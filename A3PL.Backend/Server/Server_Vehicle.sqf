["Server_Vehicle_Buy",
{
	private ["_player","_class","_type","_id","_uid","_query"];
	_player = param [0,objNull];
	if (isNull _player) exitwith {diag_log "Error in Server_Vehicle_Buy: _player is Null"};
	_uid = getPlayerUID _player;
	_class = param [1,""];
	_type = param [2,"vehicle"];
	_inStorage = param [3,false];

	//First generate a license plate and insert it as ID field
	_id = [7] call Server_Housing_GenerateID;

	if (_inStorage) then
	{
		_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','%2','%3','%4','1')",_id,_type,_class,_uid];
	} else
	{
		_query = format ["INSERT INTO objects (id,type,class,uid) VALUES ('%1','%2','%3','%4')",_id,_type,_class,_uid];
	};

	[_query,1] spawn Server_Database_Async;

	_id //return the id
},true] call Server_Setup_Compile;

//remove from DB and despawn
["Server_Vehicle_Sell",
{
	private ["_vehicle","_id","_query"];
	_vehicle = param [0,objNull];
	_id = (_vehicle getVariable ["owner",[]]) select 1; //equal to license plate

	//despawn
	[_vehicle] call Server_Vehicle_Despawn;

	//remove from DB
	_query = format ["DELETE FROM objects WHERE id='%1'",_id];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

//Initiate license plate change, returns whether success or not
["Server_Vehicle_InitLPChange",
{
	private ["_player","_veh","_newLP","_currentLP","_exist"];
	_player = param [0,objNull];
	_veh = param [1,objNull];
	_newLP = param [2,""];
	_currentLP = (_veh getVariable ["owner",["",""]]) select 1;
	_canChange = _veh getVariable "numPChange";


  // check if the vehicle lp has been changed since the last restart
	if(_canChange == 1) exitWith {
		[2] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];
	};

	//first check if license plate is in-use already
	_exist = [_newLP] call Server_Vehicle_CheckLP;
	if (_exist) exitwith
	{
		[0] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];
	};

	//set new LP texture
	[_newLP,_veh] call Server_Vehicle_Init_SetLicensePlate;

	//update database with new id, the cooldown for changing the plate and the perm value for generating a new plate on sale of the vehicle
	_query = format ["UPDATE objects SET id = '%2',numpchange='1',iscustomplate='1' WHERE id = '%1'",_currentLP,_newLP];
	[_query,1] spawn Server_Database_Async;

  _player setVariable ["player_cash",(_player getVariable ["player_cash",0]) - 20000,true];

	//change the setVariable with the new id
	_veh setVariable ["owner",[(getplayerUID _player),_newLP],true];
	_veh setVariable ["numPChange",1,true];
	_veh setVariable ["isCustomPlate",1,true];

	//response back to client
	[1] remoteExec ["A3PL_Garage_SetLicensePlateResponse", (owner _player), false];
},true] call Server_Setup_Compile;

//Check if license plate is taken by performing a SELECT query
["Server_Vehicle_CheckLP",
{
	private ["_newLP","_query","_idexist","_return"];
	_newLP = param [0,""];
	_return = false;

	_query = format ["SELECT id FROM objects WHERE id='%1'",_newLP];
	_idexist = [_query, 2, true] call Server_Database_Async;

	if ((count _idexist) > 0) then
	{
		_return = true;
	};
	_return;
},true] call Server_Setup_Compile;

["Server_Vehicle_HandleDestroyed",
{
	private ["_veh","_ownerID","_sirenObj"];
	_veh = param [0,objNull];
	_ownerID = _veh getVariable "owner";
	_msg = param [1,false];
	diag_log (format["veh destoryed=%1 isserver = %2",_veh, isServer]);
	if (!isNil "_ownerID") then //just in-case
	{
		private ["_player"];
		_ownerUID = _ownerID select 0;
		_ownerID = _ownerID select 1;

		if (_ownerID == "UHAUL") then {
			_find = [A3RL_Server_Rented_Vehicles, _ownerUID] call BIS_fnc_findNestedElement;
			diag_log (format["_find=%1",_find]);
			if !(_find isEqualTo []) then {
				diag_log (format["if",(count ((A3RL_Server_Rented_Vehicles select (_find select 0)) select 1))]);
				if ((count ((A3RL_Server_Rented_Vehicles select (_find select 0)) select 1)) < 2) then {
					A3RL_Server_Rented_Vehicles deleteAt (_find select 0);
				} else {
					_find2 = ((A3RL_Server_Rented_Vehicles select (_find select 0)) select 1) find (typeOf _veh);
					diag_log (format["_find2",_find2]);
					if(_find2 > -1) then {
						((A3RL_Server_Rented_Vehicles select (_find select 0)) select 1) deleteAt _find2;
					};
				};
			};
		};

		//delete vehicle from database
		_query = format ["DELETE FROM objects WHERE id=""%1""",_ownerID];
		[_query,1] spawn Server_Database_Async;

		if (_msg) then
		{
			_player = objNull;
			{
				if (getPlayerUID _x == _ownerUID) exitwith
				{
					_player = _x;
				};
			} foreach allPlayers;
			//let player know vehicle is deleted
			if (!isNull _player) then
			{
				[[],"A3PL_Vehicle_DestroyedMsg",_player,false] call BIS_FNC_MP;
			};
		};
	};
	[_veh] call A3PL_Vehicle_SoundSourceClear;
	_sirenObj = _veh getVariable ["sirenObj",objNull];

	if (!isNull _sirenObj) then
	{
		deleteVehicle _sirenObj;
	};

	deleteVehicle _veh;

},true] call Server_Setup_Compile;

//Spawns a vehicle
//Direct call: [["A3PL_Jayhawk_Normal",player,"1",player], "Server_Vehicle_Spawn", false, false] call BIS_fnc_MP;
//Format: [classname:string,position:[xyz] OR object:obj]
//EX: ["A3PL_Jayhawk",[0,0,0]]
['Server_Vehicle_Spawn', {
	private ['_class','_pos','_initfunction','_veh','_id',"_owner"];

	_class = param [0,""];
	_pos = param [1,[]];
	_id = param [2,-1];
	_owner = param [3,objNull];
	_dir = param [4,0];

	_initfunction = !isNil ('Server_Vehicle_Init_' + _class);

	_veh = ObjNull;

	//Log real quick
	diag_log format ["Server_Vehicle_Spawn: Spawning %1 @ %2 for %3",_class,_pos,(_owner getVariable ["name",name _owner])];

	if (typename _pos == 'Object') then
	{
		_veh = createVehicle [_class, (getPos _pos), [], 0, 'CAN_COLLIDE'];
		_veh allowDamage false;
		_veh setDir (getDir _pos);
		_veh setpos (getPos _pos);
	} else
	{
		_veh = createVehicle [_class, _pos, [], 0, 'CAN_COLLIDE'];
		_veh allowDamage false;
		_veh setDir _dir;
	};

	if (isNull _veh) exitwith {diag_log "Server_Vehicle_Spawn Error: _veh isNull"};

	_veh setVariable ["keyAccess",[getPlayerUID _owner],true];
	_veh setFuelCargo 0;
	_veh setVariable ["owner",[(getplayerUID _owner),_id],true];
	Server_Storage_ListVehicles pushback _veh;

	//check for job vehicles
	if (_id IN ["WASTE","DELIVER","EXTERMY","KARTING","DMV", "ROADSID"]) then
	{
		switch (_class) do
		{
			case ("A3PL_P362_Garbage_Truck"): {_veh setObjectTextureGlobal [0,"\A3PL_Textures\Peterbilt_Garbage_Truck\Waste_Management_Garbage_Truck.paa"];};
			case ("A3PL_P362_TowTruck"): { if(_id == "DMV") then {_veh setObjectTextureGlobal [0,"\A3PL_Textures\Peterbilt_TowTruck\DMV_TowTruck.paa"]; }};
			case ("A3PL_Mailtruck"):
			{
				if (_id == "EXTERMY") then
				{
					_veh setObjectTextureGlobal [0,"\A3PL_Textures\MailTruck\Exterminator_Truck.paa"];
				};
			};
		};
		_owner setVariable ["jobVehicle",_veh,true];
	};

	if(_id == "UHAUL") then {
		_find = [A3RL_Server_Rented_Vehicles, getPlayerUID _owner] call BIS_fnc_findNestedElement;
		if(_find isEqualTo []) then {
			A3RL_Server_Rented_Vehicles pushBack [getPlayerUID _owner, [_class]];
		} else {
			((A3RL_Server_Rented_Vehicles select (_find select 0)) select 1) pushBack _class;
		};
	};

	[_veh,_id] call Server_Vehicle_Init_General;


	if (_initfunction) then
	{
		_veh call (missionNamespace getVariable ('Server_Vehicle_Init_' + _class));
	};

	if ((typeOf _veh) IN A3PL_HitchingVehicles) then
	{
		_veh call Server_Vehicle_Init_A3PL_F150;
	};

	_veh;

},true] call Server_Setup_Compile;

["Server_UHaul_GetRentedVehicles",
{
	_player = param [0,objNull];
	[A3RL_Server_Rented_Vehicles] remoteExec ["A3RL_UHaul_RentedVeh_Return", _player];
},true] call Server_Setup_Compile;

//despawns a vehicle, delete all attached objects etc
["Server_Vehicle_Despawn",
{
	private ["_veh"];
	_veh = param [0,objNull];
	Server_Storage_ListVehicles = Server_Storage_ListVehicles - [_veh];
	{
		deleteVehicle _x;
	} foreach (attachedObjects _veh);

	deleteVehicle _veh;
}] call Server_Setup_Compile; //this is global on purpose so that as a client we can use this same function (admin menu)
// Init for Vehicle Sirens
["Server_Vehicle_Siren_Init",
{
	private ["_sirenType","_veh","_classname","_Siren","_SoundSource_1","_SoundSource_2","_SoundSource_3","_SoundSource_4"];
	_veh = _this;
	_classname = typeOf _veh;
	switch (true) do
	{
		case (_classname IN ["A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Tahoe_FD"]): {_sirenType = "fire_FR";};
		case (_classname IN ["A3PL_F150_Marker_PD","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_RBM","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_Silverado_PD","A3PL_VetteZR1_PD"]): {_sirenType = "police";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"]): {_sirenType = "ems";};
		case (_classname IN ["A3PL_P362_TowTruck","A3PL_F150_Marker"]): {_sirenType = "civ";};
		case (_classname IN ["A3PL_Yacht","A3PL_Container_Ship","A3PL_Yacht_Pirate","A3PL_Cutter","A3PL_Motorboat","A3PL_RHIB"]): {_sirenType = "Ship";};
		default {_sirenType = "police";};
	};
	switch (_sirenType) do
	{
		case "police":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_FSS_Phaser", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FSS_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_FSS_Rumbler", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire":
		{
			_SoundSource_1 = createSoundSource ["A3PL_EQ2B_Wail", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Warble", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_AirHorn_1", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire_FR":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority3", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FIPA20A_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Horn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "ems":
		{
			_SoundSource_1 = createSoundSource ["A3PL_Whelen_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_Whelen_Priority2", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Airhorn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "civ": {};
		case "Ship": {};
	};
},true] call Server_Setup_Compile;

//List of all server inits
//Format: Server_Vehicle_Init_CLASSNAME
['Server_Vehicle_Init_A3PL_Jayhawk', {
	private ['_veh'];
	_veh = _this;
	_basket = "A3PL_RescueBasket" createVehicle [0,0,0];
	_basket allowdamage false;
	_basket setVariable ["locked",false,true];
	_basket attachTo [_veh, [0,999999,0] ];
	_veh setVariable ["basket",_basket,true];
	_basket setVariable ["vehicle",_veh,true];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_F150',
{
	private ["_veh"];
	_veh = _this;
	_veh addEventHandler ["GetIn",
	{
		private ["_veh","_unit","_pos"];
		_veh = _this select 0;
		_pos = _this select 1;
		_unit = _this select 2;
		if (_pos != "driver") exitwith {};
		_trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
		if (count _trailerArray > 0) then
		{
			_trailerArray = _trailerArray select 0;

			if (!(owner _trailerArray == owner _unit)) then
			{
				_trailerArray setOwner (owner _unit);
			};
		};
	}];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Patrol', {
	private ['_veh'];
	_veh = _this;
	//_veh2 = createVehicle ["B_Lifeboat", getpos _veh, [], 0, 'CAN_COLLIDE'];
	//_veh2 attachto [_veh,[0,-11,-6]];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Goose_Base",
{
		//we'll do something here later
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Pumper',
{
	private ["_veh"];
	_veh = _this;
	_this call Server_Vehicle_Siren_Init;
	_light_1 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_light_2 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_Rotator1 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	_Rotator2 = "A3PL_White_Rotator" createVehicle [0,0,0];
	_Rotator3 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	_Rotator4 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	_Rotator5 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	_Rotator6 = "A3PL_White_Rotator" createVehicle [0,0,0];
	_Rotator7 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	_Rotator8 = "A3PL_White_Rotator_off" createVehicle [0,0,0];
	_Rotator9 = "A3PL_Red_Rotator" createVehicle [0,0,0];
	_Rotator10 = "A3PL_White_Rotator" createVehicle [0,0,0];
	_Rotator11 = "A3PL_Red_Rotator_off" createVehicle [0,0,0];
	_Flag = "A3PL_Mini_Flag_US" createVehicle [0,0,0];
	_light_1 attachTo [_veh, [0, 0, 0.79], "Floodlight_1"];
	_light_2 attachTo [_veh, [0, 0, 0.79], "Floodlight_2"];
	_Rotator1 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light1"];
	_Rotator2 attachTo [_veh, [0, -0.44, 1.01], "Rotator_Light2"];
	_Rotator3 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light3"];
	_Rotator4 attachTo [_veh, [0, -0.44, 1.01], "Rotator_Light4"];
	_Rotator5 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light5"];
	_Rotator6 attachTo [_veh, [0, -0.44, 1.01], "Rotator_Light6"];
	_Rotator7 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light7"];
	_Rotator8 attachTo [_veh, [0, -0.44, 1.01], "Rotator_Light8"];
	_Rotator9 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light9"];
	_Rotator10 attachTo [_veh, [0, -0.44, 1.01], "Rotator_Light10"];
	_Rotator11 attachTo [_veh, [0, 0.44, 1.01], "Rotator_Light11"];
	_Flag attachTo [_veh, [0.85, -4.59, -2.24]];
	_light_2 setdir 180;
	_Flag setFlagTexture "\A3\Data_F\Flags\Flag_us_CO.paa";
	[_veh,"A3PL_Pierce_Pumper"] call A3PL_FD_SetPumperNumber;
	_veh setVariable ["water",1800,true];
	_veh animate ["Water_Gauge1",1];
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Ladder',
{
	private ["_veh"];
	_veh = _this;
	_this call Server_Vehicle_Siren_Init;
	_light_1 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_light_2 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_light_3 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_light_4 = "A3PL_Floodlight_Double" createVehicle [0,0,0];
	_Ladder = "A3PL_Rear_Ladder" createVehicle [0,0,0];
	_Flag = "A3PL_Mini_Flag_US" createVehicle [0,0,0];
	_light_1 attachTo [_veh, [0, 0, 0], "Floodlight_1"];
	_light_2 attachTo [_veh, [0, 0, 0], "Floodlight_2"];
	_light_3 attachTo [_veh, [0, 0, 0], "Floodlight_3"];
	_light_4 attachTo [_veh, [0, 0, 0], "Floodlight_4"];
	_Ladder attachTo [_veh, [0, -1, -16.1]];
	_Flag attachTo [_veh, [-0.05, 0.39, -2.3], "Flag_Point"];
	_light_3 setdir 180;
	_light_4 setdir 180;
	_Flag setFlagTexture "\A3\Data_F\Flags\Flag_us_CO.paa";
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_Pierce_Heavy_Ladder',
{
	_this call Server_Vehicle_Init_A3PL_Pierce_Ladder;
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_Jonzie_Ambulance',
{
	private ["_veh"];
	_veh = _this;
	_this call Server_Vehicle_Siren_Init;
	_light_1 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_2 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_3 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_4 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_5 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_6 = "A3PL_Floodlight" createVehicle [0,0,0];
	_light_7 = "A3PL_Interior_light" createVehicle [0,0,0];
	_light_1 attachTo [_veh, [0.03, 0, 0.8], "Floodlight_1"];
	_light_2 attachTo [_veh, [0.03, 0, 0.8], "Floodlight_2"];
	_light_3 attachTo [_veh, [-0.03, 0, 0.8], "Floodlight_3"];
	_light_4 attachTo [_veh, [-0.03, 0, 0.8], "Floodlight_4"];
	_light_5 attachTo [_veh, [0, 0, 0.8], "Floodlight_5"];
	_light_6 attachTo [_veh, [0, 0, 0.8], "Floodlight_6"];
	_light_7 attachTo [_veh, [0, 0, 0], "Interior_Lights"];
	_light_3 setdir 180;
	_light_4 setdir 180;
	_light_5 setdir 270;
	_light_6 setdir 270;
},true] call Server_Setup_Compile;

['Server_Vehicle_Init_A3PL_E350',
{
	_this call Server_Vehicle_Init_Jonzie_Ambulance;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Tahoe_PD",
{
	private ["_veh"];
	_veh = _this;
	_this call Server_Vehicle_Siren_Init;
	_light_1 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	_light_2 = "A3PL_Floodlight_Level" createVehicle [0,0,0];
	_light_1 attachTo [_veh, [0.03, 0, 0.8], "Floodlight_1"];
	_light_2 attachTo [_veh, [-0.03, 0, 0.8], "Floodlight_2"];
	_light_2 setdir 180;
	_veh animate ["Pushbar_Addon",1];
	_veh animate ["Spotlight_Addon",1];
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop",
{
	_veh = _this;
	_this call Server_Vehicle_Siren_Init;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_CVPI_PD",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_CVPI_PD_Slicktop",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Mustang_PD",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Mustang_PD_Slicktop",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Charger_PD",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Charger_PD_Slicktop",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_Silverado_PD",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_A3PL_VetteZR1_PD",
{
	_this call Server_Vehicle_Init_A3PL_Tahoe_PD_Slicktop;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_C_Van_02_transport_F",
{
	_this setVariable [_door,true,true];
	_this setObjectTextureGlobal [1, "\a3\Soft_F_Orange\Van_02\Data\van_wheel_transport_co.paa"];
	_this setObjectTextureGlobal [2, "\a3\Soft_F_Orange\Van_02\Data\van_glass_civservice_ca.paa"];
	_this call Server_Vehicle_Init_C_Van_02_transport_F;
},true] call Server_Setup_Compile;

["Server_Vehicle_Init_C_Heli_Light_01_civil_F",
{
	private ["_veh"];
	_veh = _this;
	_veh animate ["addDoors",1];


		_veh = param [0,objNull];
		_position = param [1,""];
		_unit = param [2,objNull];

		if (!local _unit) exitwith {};

		if (_position IN ["gunner","driver"]) then
		{
			[_veh] spawn A3PL_ATC_GetInAircraft;
		};
		_this call Server_Vehicle_Init_C_Heli_Light_01_civil_F;
},true] call Server_Setup_Compile;

//This function will set License Plate
['Server_Vehicle_Init_SetLicensePlate',
{
	private ["_plate","_vehicle"];
	//_plate needs to be 7 characters
	_plate = _this select 0;
	_vehicle = _this select 1;
	_extraVehicles = ["C_Van_02_transport_F","red_demon_18_base2","red_demon_18_base","red_e350_14_base","red_explorer_16_base","red_camaro_18_base","red_taurus_13_base","red_hellcat_15_base","red_huracan_17_base","red_harley_18_base","red_blimp_base","red_corvette_14_base","red_e350_14_d_p_base","red_e350_14_d_p_base2","red_f150_18_base","red_raptor_16_base","red_f350_18_base","red_f350_18_base2","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base","red_mustang_15_base","red_sierra_14_base","red_sierra_14_base2"];

	if(typeOf _vehicle IN _extraVehicles) then {
		_vehicle setPlateNumber toUpper(_plate);
	};
	for "_i" from 0 to (count _plate) do
	{
		_vehicle setObjectTextureGlobal [_i+1,(format ["A3PL_Cars\Common\Number_Plates\%1.paa",_plate select [_i,1]])];
	};

},true] call Server_Setup_Compile;

//Some general functions for the server
['Server_Vehicle_Init_General', {
	private ['_veh','_id','_query','_lp','_vars'];
	_veh = param [0,objNull];
	_id = param [1,"-1"];
	_veh lock 2;

	//killed eventhandler
	_veh addEventHandler ["Killed",{[(_this select 0)] remoteExec ["Server_Vehicle_HandleDestroyed",2];}];

	if (_veh isKindOf "LandVehicle") then
	{
		private ["_plate"];

		_veh animate ["Camo1",1];
		_veh animate ["Glass0_destruct",1];
		//_veh setMass (getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "htMax"));

		if (_id != "-1") then
		{
			[_id,_veh] call Server_Vehicle_Init_SetLicensePlate;
		};
	};
},true] call Server_Setup_Compile;

['Server_Vehicle_Trailer_Hitch',
{
	private ["_truck","_trailer"];
	_truck = param [0,objNull];
	_trailer = param [1,objNull];

	if ((owner _truck) != (owner _trailer)) then
	{
		_trailer setOwner (owner _truck);
	};
},true] call Server_Setup_Compile;

["Server_Vehicle_TrailerDetach",
{
	private ["_trailer","_boat"];

	_boat = param [0,objNull];
	_trailer = attachedTo _boat;
	if ((isNull _trailer) OR (isNull _boat)) exitwith {};

	_boat allowDamage false;

	if ((owner _trailer) != (owner _boat)) then
	{
		_boat setOwner (owner _trailer);
	};
	[_boat] spawn
	{
		_boat = param [0,objNull];
		[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
		sleep 1.5;
		detach _boat;
		sleep 10;
		_boat allowDamage true;
	};
},true] call Server_Setup_Compile;

//takes care of globally disabling simulation so cars can be driven onto the back without bad things happening lol
["Server_Vehicle_EnableSimulation",
{
	private ["_veh"];
	_veh = param [0,objNull];
	_force = param [1,false];
	_forceEnable = param [2,false];

	if (isNull _veh) exitwith {};

	//we are forcing a simulation type
	if (_force) exitwith
	{
		_veh enableSimulationGlobal _forceEnable;
	};

	if (simulationEnabled _veh) then
	{
		_veh enableSimulationGlobal false;
	} else
	{
		_veh enableSimulationGlobal true;
	};

},true] call Server_Setup_Compile;

//handle for locality in-case vehicles are not local to same user
["Server_Vehicle_AtegoHandle",
{
	_player = param [0,objNull];
	_truck = param [1,objNull];
	_car = param [2,objNull];

	_oTruck = owner _truck;
	_oPlayer = owner _player;
	_oCar = owner _car;

	if (_oTruck != _oPlayer) then
	{
		_truck setOwner _oPlayer;
	};

	if ((!isNull _car) && (_oCar != _oTruck)) then
	{
		_car setOwner _oPlayer;
	};

	//send message back to approve towing, we will do additional check client side to make sure both vehicles are actually local
	[_truck,_car] remoteExec ["A3PL_Vehicle_AtegoTowResponse", _oPlayer];
},true] call Server_Setup_Compile
/*
['Server_Vehicle_Init_A3PL_Stinger',
{
	private ["_veh"];
	_veh = param [0,objNull];

	_veh addEventHandler ["EpeContact",
	{
		_Stinger = param [0,objNull];
		if (_Stinger animationSourcePhase "Deploy_Stinger" == 0) exitWith {};
		_threshold = 0.5;
		_wheels = [];
		_stingerPoints = [];
		_wheelHits = [];
		_objects = nearestObjects [_Stinger, ["Car_F"], 25]; //Search for nearest objects
		_veh = objNull;
		if (count _objects > 0) then {_veh = _objects select 0;};
		if (speed _veh < 1) exitWith {};
		//How many columns of wheels, e.g Left and Right. If you had a column in the middle of the vehicle it would be 3
		for "_x" from 1 to 2 do
		{
			// How many rows of wheels
			for "_y" from 1 to 3 do {
				_wheels = _wheels + [[format ["%1_%2", _x, _y], _veh modelToWorld (_veh selectionPosition (format ["wheel_%1_%2_bound", _x, _y]))]];
			};
		};

		for "_i" from 1 to 52 do
		{
			_stingerPoints = _stingerPoints + [[_i, _Stinger modelToWorld (_Stinger selectionPosition (format ["Arm_%1_Hit", _i]))]];
		};

		{
			_wheel = _x select 0;
			_bound = _x select 1;

			{
				_distance = _bound distance (_x select 1);
				if (_distance < _threshold) then {
					//Add the wheel into the wheel hit array because it was hit by a spike
					_wheelHits = _wheelHits + [_wheel];
				};
			} forEach _stingerPoints;
		} forEach _wheels;

		//Actually pop the tire
		{
			_wheel = _x;
			_hitPoint = "";

			if (_wheel == "1_1") then {
				_hitPoint = "HitLFWheel";
			};
			if (_wheel == "1_2") then {
				_hitPoint = "HitLF2Wheel";
			};
			if (_wheel == "1_3") then {
				_hitPoint = "HitLMWheel";
			};
			if (_wheel == "2_1") then {
				_hitPoint = "HitRFWheel";
			};
			if (_wheel == "2_2") then {
				_hitPoint = "HitRF2Wheel";
			};
			if (_wheel == "2_3") then {
				_hitPoint = "HitRMWheel";
			};

			_veh setHitPointDamage [_hitPoint, 1];
		} forEach _wheelHits;
	}];
},true] call Server_Setup_Compile;*/
