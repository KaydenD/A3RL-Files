["Server_Fire_PauseCheck", {
	//_sendTo = params [0,[]];

	[Server_FireLooping] remoteExec ["A3PL_Admin_PauseCheckReturn"];
},true] call Server_Setup_Compile;

["Server_Fire_PauseFire", {

	if (Server_FireLooping) then {
		Server_FireLooping = false;
	} else {
		Server_FireLooping = true;
	};
},true] call Server_Setup_Compile;

["Server_Fire_StartFire", {

	private ["_position","_fireObject","_dir"];
	_position = param [0,[]];
	_dir = param [1,random 360];
	if (count _position < 3) exitwith {}; //not valid position

	_fireObject = createVehicle ["A3PL_FireObject",_position, [], 0, "CAN_COLLIDE"];
	_fireObject addEventhandler ["HandleDamage",{[param [0,objNull],param [4,""]] spawn Server_Fire_HandleDamage;}];
	_fireObject setDir _dir;
	[_fireObject] call Server_Fire_AddFireParticles;
	Server_TerrainFires pushBack [_fireObject];

},true] call Server_Setup_Compile;


//FireObj = "#particlesource" createVehicle (getpos player); FireObj setparticleclass ""
//classes "MediumDestructionFire", "BigDestructionFire","SmallFireBarrel"
//"HouseDestrSmokeLong","HouseDestrSmokeLongSmall"
["Server_Fire_AddFireParticles", {
	private ["_fireObject","_r1","_r2","_r3","_source1","_source2"];
	_fireObject = param [0,[]];
	if (isNull _fireObject) exitwith {}; //not valid position

	_r1 = random 10; if (_r1 <= 2) then {_r1 = true} else {_r1 = false}; //15%
	_r2 = random 10; if (_r2 <= 0.7) then {_r2 = true} else {_r2 = false}; //7%
	_r3 = random 10; if (_r3 <= 0.7) then {_r3 = true} else {_r3 = false}; //7%

	_source1 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
	_source1 setparticleclass "MediumDestructionFire";
	_source1 attachTo [_fireObject,[0,0,0]];

	//random chance for smoke
	if (_r1) exitwith
	{
		_source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "MediumDestructionSmoke";
		_source2 attachTo [_fireObject,[0,0,0]];
	};

	if (_r2) exitwith
	{
		_source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "BigDestructionSmoke";
		_source2 attachTo [_fireObject,[0,0,0]];
	};

	if (_r3) exitwith
	{
		_source2 = createVehicle ["#particleSource",getposATL _fireObject, [], 0, "CAN_COLLIDE"];
		_source2 setparticleclass "HouseDestrSmokeLongSmall";
		_source2 attachTo [_fireObject,[0,0,0]];
	};
},true] call Server_Setup_Compile;

["Server_Fire_Killed", {
	private ["_fireObject","_loopIndex","_f"];
	_fireObject = param [0,objNull];
	//player globalChat "DESTROYED";
	_f = false; //variable to check if we also need to check the objectFire array later
	{
		deleteVehicle _x;
	} foreach (attachedObjects _fireObject);

	//loop through all fires, find the array this fire object is in, delete it, and delete whole array if last fire left
	{
		_loopIndex = _forEachIndex;
		_fireArray = _x;
		{
			if (_fireObject == _x) exitwith
			{
				if (count _fireArray < 2) then //if this is the last fire, remove the whole array
				{
					Server_TerrainFires deleteAt _loopIndex;
				} else
				{
					Server_TerrainFires set [_loopIndex,_fireArray-[_x]];
				};
			};
		} foreach _x;
	} foreach Server_TerrainFires;

	if (_fireObject IN Server_Fire_MarkerList) then
	{
		Server_Fire_MarkerList = Server_Fire_MarkerList - [_fireObject];
		publicVariable "Server_Fire_MarkerList";
	};

	deleteVehicle _fireObject;
},true] call Server_Setup_Compile;

["Server_Fire_HandleDamage", {
	private ["_fireObject","_loopIndex","_dmg"];
	_fireObject = param [0,objNull];
	_projectile = param [1,""];

	//damage to add
	if (_projectile IN ["A3PL_High_Pressure_Water_Ball","A3PL_Low_Pressure_Water_Ball","A3PL_High_Pressure_Foam_Ball","A3PL_Medium_Pressure_Foam_Ball","A3PL_Low_Pressure_Foam_Ball","A3PL_Extinguisher_Water_Ball"]) then
	{
		_newDmg = (_fireObject getVariable ["dmg",0]) + 0.1;
		if (_newDmg >= 1) then
		{
			[_fireObject] call Server_Fire_Killed;
		} else
		{
			_fireObject setVariable ["dmg",_newDmg,false];
		};
	};

	_dmg = 0;
	_dmg;
},true] call Server_Setup_Compile;

//deletes all fires
["Server_Fire_RemoveFires", {

	{
		private ["_x"];
		{
			private ["_x"];
			{
				private ["_x"];
				deleteVehicle _x;
			} foreach attachedObjects _x;
			deleteVehicle _x;
		} foreach _x;
	} foreach (missionNameSpace getVariable ["Server_TerrainFires",[]]);
	Server_TerrainFires = [];
},true] call Server_Setup_Compile;

//this runs every x seconds, defined in Core
["Server_Fire_FireLoop", {
	if (Server_FireLooping) then {
		private ["_latestFire","_fireObject","_latestFireDir","_newDir","_spread","_dist","_position","_correctSurface","_loopIndex","_fireArray"];
		{
			_loopIndex = _forEachIndex;
			_fireArray = _x;

			_spreadArray = []; //array that contains the fires we will spread around, there is various way we can handle this

			// this selects the last 3 fires, or 1 or 2 if there is less than 3
			if (count _fireArray > 0) then {_spreadArray pushback (_fireArray select (count _fireArray - 1));};
			if (count _fireArray > 1) then {_spreadArray pushback (_fireArray select (count _fireArray - 2));};
			if (count _fireArray > 2) then {_spreadArray pushback (_fireArray select (count _fireArray - 3));};

			{
				_spread = floor random 10; if (_spread < 5) then {_spread = true;} else {_spread = false}; //50% chance to spread
				if (_spread) then
				{
					//select latest first
					_latestFire = _x;

					//Figure out new position for fire, based on direction of latest fire
					_latestFireDir = getDir _latestFire;

					//Apply random offset, 40 degrees max (-40+max80 = max 40 off from current dir)
					_newDir = (_latestFireDir - 40) + random 80;
					_dist = 2 + random 2;
					_position = [_latestFire, _dist, _newDir] call BIS_fnc_relPos;
					//_position set [2,0]; //z = 0

					//check surfaceType for new position, we dont want to spawn fire on stuff like tarmac
					_correctSurface = (surfaceType _position) IN ["#cype_grass","#cype_forest"];

					if (_correctSurface && (!isOnRoad _position)) then
					{
						//create fire
						//_fireobject = "A3PL_FireObject" createVehicle _position;
						_fireobject = createVehicle ["A3PL_Fireobject",_position, [], 0, "CAN_COLLIDE"];
						_fireobject addEventhandler ["HandleDamage",{[param [0,objNull],param [4,""]] spawn Server_Fire_HandleDamage;}];
						_fireObject setDir _newDir;
						[_fireObject] call Server_Fire_AddFireParticles;

						//put into array
						_fireArray pushback _fireObject;
						Server_TerrainFires set [_loopIndex,_fireArray];
					};
				};
			} foreach _spreadArray;
		} foreach Server_TerrainFires;
	};
},true] call Server_Setup_Compile;

['Server_FD_Database',
{
	private ["_output"];
	_player = _this select 0;
	_name = _this select 1;
	_call = _this select 2;

		switch (_call) do {
			case "lookpatient":
			{
				_query = format ["SELECT
				(SELECT gender FROM players WHERE name = '%1') AS gender,
				(SELECT dob FROM players WHERE name = '%1') AS DOB,
				(SELECT pasportdate FROM players WHERE name = '%1') AS pasportDate
				FROM
				players
				WHERE
				uid = (SELECT uid FROM players WHERE name='%1')
				", _name];

				_return = [_query, 2] call Server_Database_Async;
				[[_name,_call,_return],"A3PL_FD_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};
			case "lookhistory":
			{
				_query = format ["SELECT * FROM firedatabase WHERE Patient = '%1'", _name];
				_return = [_query, 2,true] call Server_Database_Async;
				[[_name,_call,_return],"A3PL_FD_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};
			case "addhistory":
			{
				_pname = _name select 0;
				_place = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;

				_strArray = _info splitString "";
				_info = "";
				{
					if(_x IN ["'"]) then {
						_info = _info + " ";
					} else {
						_info = _info + _x;
					};
				} forEach _strArray;

				_query = format ["INSERT INTO firedatabase (Patient, Place, Informations, IssuedBy, Time) VALUES ('%1', '%2', '%3', '%4', NOW())",_pname,_place,_info,_issuedBy];
				_return = [_query, 2,true] call Server_Database_Async;
				[[_name,_call,format["The %1 medical folder has been successfully modified.",_pname]],"A3PL_FD_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};
			default {};
		};
},true] call Server_Setup_Compile;

["Server_Fire_VehicleExplode",
{
	_fireObject = param [0,objNull];
	if ((count(["fifr"] call A3PL_Lib_FactionPlayers)) >= 1) then {
		_marker = createMarker [format ["vehiclefire_%1",random 4000], position (_fireObject)];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";

		_marker setMarkerText "VEHICLE FIRE!";
		_marker setMarkerColor "ColorRed";
		{
			if((_x getVariable ["job","unemployed"]) in ["fifr"]) then {
				["!!! ALERT !!! A burning vehicle has been reported !", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
				["!!! ALERT !!! A burning vehicle has been reported !", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
				["!!! ALERT !!! A burning vehicle has been reported !", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
			};
		} forEach allPlayers;
		["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		[position (_fireObject)] spawn Server_Fire_StartFire;
		sleep 300;
		deleteMarker _marker;
	};
}] call Server_Setup_Compile;