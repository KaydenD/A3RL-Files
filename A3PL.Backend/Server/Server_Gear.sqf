["Server_Gear_Add",
{
	private ["_classname", "_gearType","_player"];

	_classname = param [0,""];
	_player = param [1,objNull];
	_gearType = [_classname, "type"] call A3PL_Config_GetGear;

	switch (_gearType) do
	{
		case "vest": {
			_player addVest _classname;
		};

		case "backpack": {
			_player addBackpack _classname;
		};

		case "item": {
			_player addItem _classname;
		};

		case "uniform": {
			_player addUniform _classname;
		};

		case "weapon": {
			_player addWeaponGlobal _classname;
		};

		case "magazine": {
			_player addMagazine [_classname,100];
		};

		case "headgear": {
			_player addHeadGear _classname;
		};

		case "PrimaryWeaponItem": {
			_player addPrimaryWeaponItem _classname;
		};

		case "HandgunItem": {
			_player addHandgunItem _classname;
		};
	};
}] call Server_Setup_Compile;

["Server_Gear_Remove",
{
	private ["_classname", "_gearType","_player"];

	_classname = param [0,""];
	_player = param [1,player];

	_gearType = [_classname, "type"] call A3PL_Config_GetGear;

	switch (_gearType) do {
		case "vest": {
			removeVest _player;
		};

		case "backpack": {
			removeBackpack _player;
		};

		case "item": {
			if (goggles _player isEqualTo _classname) exitWith {
				removeGoggles _player;
			};

			if (vest _player isEqualTo _classname) exitWith {
				removeVest _player;
			};

			if (headGear _player isEqualTo _classname) exitWith {
				removeHeadgear _player;
			};

			if (uniform _player isEqualTo _classname) exitWith {
				removeUniform _player;
			};

			_player removeItem _classname;
		};

		case "headgear": {
			removeHeadGear _player;
		};

		case "weapon": {
			_player removeWeapon _classname;
		};

		case "magazine": {
			_player removeMagazine _classname;
		};

		case "PrimaryWeaponItem": {
			_player removePrimaryWeaponItem _classname;
		};

		case "HandgunItem": {
			_player removeHandgunItem _classname;
		};
	};
}] call Server_Setup_Compile;

// Load the physical A3 inventory + pos and add them remotely, once finished send message to client!
// Spawn this

["Server_Gear_New", {
	private ["_unit"];
	_unit = _this select 0;
	_newEntry = _this select 1;

	//Assign default gear
	_unit addUniform (selectRandom ["A3PL_citizen2_Uniform","A3PL_citizen3_Uniform","A3PL_citizen4_Uniform","A3PL_citizen5_Uniform"]);
	_unit addItem "A3PL_Cellphone";
	//Tell players his gear is loaded, because there is nothing to load
	(owner _unit) publicVariableClient "A3PL_RetrievedInventory";

	//Lets make a new entry for this UID
	if (_newEntry) then
	{
		_query = format ["INSERT INTO players (uid) VALUES ('%1')",(getPlayerUID _unit)];
		[_query,1] call Server_Database_Async;
	};

	//Lets tell the player he needs to enter a new name
	[[],"A3PL_Player_NewPlayer",_unit,false] call BIS_FNC_MP;

	//set keys to nothing so we can assign a house
	_unit setVariable ["keys",[],true];

	[_unit] call Server_Housing_AssignApt;
	[_unit] call Server_Housing_SetPosApt;

},true] call Server_Setup_Compile;

["Server_Gear_NewReceive", {
	private ["_unit","_uid","_name","_query","_return"];
	_unit = _this select 0;
	_uid = getPlayerUID _unit;
	_name = _this select 1;
	_sex = _this select 3;
	_dob = _this select 4;

	//check name
	_query = format ["SELECT name FROM players WHERE name='%1'", _name];
	_return = [_query, 2] call Server_Database_Async;
	if (count _return > 0) exitwith
	{
		[[],"A3PL_Player_NewPlayer",_unit,false] call BIS_FNC_MP;
	};

	//Set name, default faction and no keys
	_unit setVariable ["name",_name,true];
	_unit setVariable ["gender",_sex,true];
	_unit setVariable ["job","unemployed",true];
	_unit setVariable ["faction","citizen",true];
	_unit setVariable ["Player_Cash",0,true];
	_unit setVariable ["Player_Bank",2000,true];
	_unit setvariable ["Player_Paycheck",0,true];
	_unit setVariable ["Player_Inventory",[],true];
	_unit setVariable ["Cuffed",false,true];

	[_unit,"burger_full_cooked",5] call Server_Inventory_Add;
	[_unit,"coke",5] call Server_Inventory_Add;
	[_unit,"repairwrench",2] call Server_Inventory_Add;

	[_unit,_uid,false] call Server_Gear_Save;
	_query = format ["UPDATE players SET name='%1',pasportdate=NOW(), gender='%3', dob='%4' WHERE uid ='%2'", _name,_uid,_sex,_dob];
	[_query,1] spawn Server_Database_Async;

	//give them a rusted CVPI
	_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','vehicle','A3PL_CVPI_Rusty','%2','1')",([7] call Server_Housing_GenerateID),_uid];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

//COMPILE BLOCK WARNING
/*["Server_Gear_Load", {
	private ["_unit", "_uid", "_return", "_query", "_pos", "_loadout","_name","_houseVar","_ownsHouse","_houseObj","_job","_virtinv","_cash","_bank","_facStorage","_licenses","_twitterProfile"];
	_unit = _this select 0;
	_uid = getPlayerUID _unit;

	// Perform a query with all the information
	_query = format ["SELECT position,loadout,name,faction,userkey,job,virtualinv,cash,bank,jail,ID,dob,pasportdate,player_fstorage,adminpowers,licenses,twitterprofile,adminWatch FROM players WHERE uid='%1'", _uid];
	_return = [_query, 2] call Server_Database_Async;


	if (count _return == 0) exitwith
	{
		[_unit,true] call Server_Gear_New;
	};

	_name = _return select 2;

	if (_name == "") exitwith
	{
		[_unit,false] call Server_Gear_New;
	};

	_pos = call compile (_return select 0);
	_loadout = [(_return select 1)] call Server_Database_ToArray;
	_faction = _return select 3;
	_keys = [(_return select 4)] call Server_Database_ToArray;
	_job = _return select 5;
	_virtinv = [(_return select 6)] call Server_Database_ToArray;
	_cash = parseNumber (_return select 7);
	_bank = parseNumber (_return select 8);
	_jail = _return select 9;
	_id = _return select 17;
	_dob = _return select 11;
	_passportdate = _return select 12;
	_facStorage = [(_return select 13)] call Server_Database_ToArray;
	_admpwrs = [(_return select 14)] call Server_Database_ToArray;
	_licenses = [(_return select 15)] call Server_Database_ToArray;
	_twitterProfile = call compile (_return select 16);
	_adminWatch = _return select 17;

	//setAdminWatch
	_unit setVariable ["adminWatch",_adminWatch,true];

	//set twitter profile
	_unit setVariable ["twitterprofile",_twitterProfile,true];

	//Load player clothes and add them
	_unit setUnitLoadout _loadout;

	// Set position to last known pos, can be [0,0,0] if server has restarted
	_unit setpos _pos;

	// Set name on the player
	_unit setVariable ["name",_name,true];

	//Set the units db_id
	_unit setVariable ["db_id",_id,true];

	//DOB
	_unit setVariable ["dob",_dob,true];

	//Join Date
	_unit setVariable ["date",_passportdate,true];

	//Set faction
	_unit setVariable ["faction",_faction,true];

	//Give keys to player
	_unit setVariable ["keys",_keys,true];

	//Scan if player owns a house, if not we will assign him an appartment
	_ownsHouse = false;
	{
		_houseVar = _x getVariable "owner";
		if ((_houseVar select 0) == _uid) exitwith
		{
			_ownsHouse = true;
			_houseObj = _x;

			//give the key to the player if he doesn't have it
			_doorID = (_houseObj getVariable "doorid") select 1;
			if (!(_doorID IN _keys)) then
			{
				_keys pushback _doorID;
				_unit setVariable ["keys",_keys,true];
			};
		};
	} foreach Server_HouseList;

	if (!_ownsHouse) then
	{
		[_unit] call Server_Housing_AssignApt;
	} else
	{
		//setpos to house position
		if ([[0,0,0],_pos] call BIS_fnc_areEqual) then
		{
			//for some houses we need to set the player position a bit higher
			switch (typeOf _houseObj) do
			{
				case ("Land_Mansion01"): { _unit setpos [(getpos _houseObj select 0),(getpos _houseObj select 1),1]; };
				case default { _unit setpos (getpos _houseObj); };
			};

		};
		//set house var
		_unit setVariable ["house",_houseObj,true];
		//load items
		[_unit,_houseObj,_uid] call Server_Housing_LoadItems;
	};

	if ((!([[0,0,0],_pos] call BIS_fnc_areEqual)) && (!(_ownsHouse))) then //if our position is not [0,0,0] and we have an apartment
	{
		private ["_near"];
		_near = nearestObjects [_pos, ["Land_A3PL_Motel"], 14];
		if (count _near > 0) then
		{
			//still set the player to the apartment position since he spawned (close) back into an apartment
			[_unit] call Server_Housing_SetPosApt;
		};
	};

	//change 0,0,0 with whatever we set on server start later
	if (([[0,0,0],_pos] call BIS_fnc_areEqual) && (!(_ownsHouse))) then
	{
		[_unit] call Server_Housing_SetPosApt;
	};

	//Set the job
	_unit setVariable ["job",_job,true];

	//assign virtual inventory
	_unit setVariable ["player_inventory",_virtinv,true];
	_unit setVariable ["player_fstorage",_facStorage,true];

	//give money back
	_unit setVariable ["Player_Cash",_cash,true];
	_unit setVariable ["Player_Bank",_bank,true];
	_unit setVariable ["adminpowers",_admpwrs,true];
	_unit setVariable ["licenses",_licenses,true];
	_unit setVariable ["Cuffed",false,true];

	//Jail the player if needed...
	if(_jail > 0) then
	{
		_unit setPos [4795.31,6313.62,0];
		[_jail, _unit] call Server_Police_JailPlayer;
	};

	[_unit] call Server_IE_LoadPlayerIE;

	// Once all done send message to Client to tell him everything is assigned!
	// publicVariableClient is a priority message, cuts down on network traffic
	(owner _unit) publicVariableClient "A3PL_RetrievedInventory";
}, true,true] call Server_Setup_Compile;*/


// Save the physical A3 inventory including clothing
["Server_Gear_Save", {
	private ["_unit", "_uid", "_delete", "_weapons", "_items", "_magazines", "_query", "_loadout", "_pos","_job","_virtinv","_cash","_bank","_ship","_adminWatch"];
	_unit = _this select 0;
	_uid = _this select 1;
	_delete = _this select 2;

	//get loadout
	_loadout = getUnitLoadout _unit;

	//Get position
	_pos = getpos _unit;

	//get job
	_job = _unit getVariable ["job","unemployed"];

	//virtual inventory
	_virtinv = _unit getVariable ["player_inventory",[]];
	
	// import export ship
	_ship = [(_unit getVariable ["player_importing",[]]),(_unit getVariable ["player_exporting",[]])];	

	//Med stats
	_medStat = _unit getVariable ["A3PL_Wounds",[]];
	_blood = _unit getVariable ["A3PL_MedicalVars",[5000,"120/80",37]];
	_medStat = [_medStat,_blood];

	//cash and bank, lets not check for Nil vars, see if this needs editing later
	_cash = _unit getVariable "Player_Cash";
	_bank = _unit getVariable "Player_Bank";
	_paycheck = _unit getVariable "Player_Paycheck";
	if ((isNil "_cash") OR (isNil "_bank")) exitwith
	{
		diag_log format ["Error in Server_Gear_Save: _cash or _bank is nil for %1",name _unit];
	};

	//get adminshit
	_adminWatch = _unit getVariable ["adminWatch",0];

	_query = format ["UPDATE players SET loadout='%2',position='%3',job='%4',virtualinv='%5',cash='%6',bank='%7',ship='%8',adminWatch='%9',medstats='%10',paycheck='%11' WHERE uid ='%1'",
		_uid,
		([_loadout] call Server_Database_Array), //these need to be formatted for db save, only if array consists of strings
		_pos,
		_job,
		([_virtinv] call Server_Database_Array),
		_cash,
		_bank,
		([_ship] call Server_Database_Array),
		_adminWatch,
		_medStat,
		_paycheck
	];

	[_query,1] spawn Server_Database_Async;
	
	//Delete unit if we want to
	if (_delete) then { deleteVehicle _unit; };	
}, true] call Server_Setup_Compile;

// Only run when the user has loaded its stats otherwise it will overwrite with empty stats most likely (duh..)
["Server_Gear_HandleDisconnect",
{
	addMissionEventHandler ["HandleDisconnect",
	{
		private ["_unit","_uid","_var"];
		_unit = _this select 0;
		_uid = _this select 2;
		if (isNull _unit) exitwith {};
		_var = _unit getVariable "name";
		if (isNil "_var") exitwith {};

		[_unit,_uid] call Server_Housing_SaveKeys;

		//save furniture
		if (!isNil {_unit getVariable ["house",nil]}) then {[_unit,_uid] call Server_Housing_SaveItems;};

		//get rid of the assigned apt, if exist
		_var = _unit getVariable "apt";
		if (!isNil "_var") then
		{
			[_unit] call Server_Housing_UnAssignApt;
		};

		/* Clean Up Any Buoys owned by the player */
		_deleteAt = [];
		{
			if(_x getVariable ["owner",""] == _uid) then {
				ropeDestroy (_x getVariable ["rope",objNull]);
				deleteVehicle (_x getVariable ["net",objNull]);
				deleteVehicle _x;
				_deleteAt pushBack _forEachIndex;
			};
		} forEach Server_FishingBuoys;

		{
		  Server_FishingBuoys deleteAt _x;
		} forEach _deleteAt;

		//we can spawn this because we wont be requiring any setvariables after this point
		[_unit,_uid,true] spawn Server_Gear_Save;
		[] call Server_Bowling_BLaneCheck;
	}];
}, true] call Server_Setup_Compile;

// Loop to save player stats
["Server_Gear_SaveLoop",
{
	private ["_unit", "_uid"];
	{
		_unit = _x;
		_uid = getPlayerUID _unit;
		[_unit, _uid, false] spawn Server_Gear_Save;
		sleep 1;
	} foreach allPlayers;
}, true] call Server_Setup_Compile;
