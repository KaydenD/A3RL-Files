//Init the storage, set storage = 1 for all items, cars, everything
["Server_Storage_Init",
{
	private ["_query"];
	_query = "UPDATE objects SET plystorage = '1'";
	[_query,1] spawn Server_Database_Async;

	_query = "UPDATE objects SET pos = '[]' WHERE spawn = '0'";
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Storage_ReturnObjects",
{
	private ["_player","_uid"];
	_player = param [0,objNull];
	_uid = param [1,"-1"];
	if (_uid == "-1") then
	{
		_uid = getplayerUID _player;
	};

	_query = format ["SELECT id,class FROM objects WHERE (type = 'object' AND plystorage = '1') AND uid = '%1'",_uid];
	_objects = [_query, 2, true] call Server_Database_Async;

	_returnArray = [];
	{
		_id = _x select 0;
		_class = _x select 1;

		_returnArray pushback [_id,_class];
	} foreach _objects;

	[[_returnArray],"A3PL_Storage_ObjectsReceive",_player,false] call BIS_FNC_MP;


},true] call Server_Setup_Compile;

["Server_Storage_RetrieveObject",
{
	private ["_query","_class","_player","_id","_storage","_veh"];
	_class = param [0,""];
	_player = param [1,objNull];
	_id = param [2,-1];

	_query = format ["DELETE FROM objects WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

	[[2],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;

	//_veh = [_class,(getpos _player),_player,_id] call Server_Housing_CreateFurniture; //TODO make it a real function
	_veh = createVehicle [_class, getposATL _player, [], 0, "CAN_COLLIDE"];
	if (!([_class,"simulation"] call A3PL_Config_GetItem)) then
	{
		[_veh] call Server_Vehicle_EnableSimulation;
	};
	_veh setVariable ["class",_class,true];
	_veh setVariable ["owner",getPlayerUID _player,true];

},true] call Server_Setup_Compile;

//Function that returns an array of vehicles back to the player
["Server_Storage_ReturnVehicles",
{
	private ["_player","_uid","_query","_objects","_returnArray","_id","_class","_customName","_fuel","_vars","_type"];
	_player = param [0,objNull];
	_uid = param [1,"-1"];
	_impound = param [2,0];
	_type = param [3,"vehicle"];

	if (_uid == "-1") then
	{
		_uid = getplayerUID _player;
	};

	_query = format ["SELECT id,class,customName,fuel FROM objects WHERE (type = '%3' AND plystorage = '1') AND (uid = '%1' AND impounded='%2')",_uid,_impound,_type];
	_objects = [_query, 2, true] call Server_Database_Async;

	_returnArray = [];
	{
		_id = _x select 0;
		_class = _x select 1;
		_customName = _x select 2;
		_fuel = _x select 3;

		_returnArray pushBack [_id,_class,_customName,_fuel];
	} foreach _objects;

	[[_returnArray],"A3PL_Storage_VehicleReceive",_player,false] call BIS_FNC_MP;

},true] call Server_Setup_Compile;

["Server_Storage_ChangeVehicleName", {

	private ["_vehiclePlate","_vehicleNewName"];
	_vehiclePlate = param [0,""];
	_vehicleNewName = param [1,""];

	_toQuery = format ["UPDATE objects SET customName = '%1' WHERE id = '%2'",_vehicleNewName,_vehiclePlate];
	[_toQuery,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

//custom function for spawning at certain position
["Server_Storage_RetrieveVehiclePos",
{
	private ["_class","_player","_id","_storage","_dir","_veh","_db"];
	_class = param [0,""];
	_player = param [1,objNull];
	_id = param [2,-1];
	_storage = param [3,[]]; //position in this case

	if (count _storage > 3) then
	{
		_dir = _storage select 3;
		_storage = [_storage select 0,_storage select 1,_storage select 2];
	};

	_query = format ["UPDATE objects SET plystorage = '0',impounded='0' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

		_query = format ["SELECT fuel,color,numpchange,iscustomplate,material,tuning FROM objects WHERE id = '%1'",_id];
	_db = [_query, 2, false] call Server_Database_Async;


	_veh = [_class,_storage,_id,_player] call Server_Vehicle_Spawn;
	if (_veh isKindOf "Ship") then
	{
		_veh setpos _storage;
	} else
	{
		_veh setPosATL _storage;
	};

	if (!isNil "_dir") then
	{
		_veh setDir _dir;
	};

	if (_veh isKindOf "helicopter") then
	{
		_veh setOwner (owner _player);
	};
	_storageclass = nearestObject [_storage, "Land_A3PL_Sheriffpd"];
	if (typeOf _storageclass == "Land_A3PL_Sheriffpd") then
	{
		[_player,_storageclass,_veh,_id] spawn
		{
			private ["_player","_storage","_t","_veh","_id"];
			_player = param [0,ObjNull];
			_storage = param [1,ObjNull];
			_veh = param [2,ObjNull];
			_id = param [3,""];

			_t = 0;
			while {(_veh distance _storage) < 8} do
			{
				uiSleep 1;
				_t = _t + 1;
				if (isNull _veh) exitwith
				{

				};
				if (_t > 119) exitwith
				{
					[[3],"A3PL_Storage_CarRetrieveResponse",_player,false] call BIS_FNC_MP;
					_query = format ["UPDATE objects SET plystorage = '1' WHERE id = '%1'",_id];
					[_query,1] spawn Server_Database_Async;
					Server_Storage_ListVehicles - [_veh];
					[_veh] call Server_Vehicle_Despawn;
				};
			};
			if (_storage animationSourcePhase "StorageDoor" > 0.5) then {_storage animateSource ["storagedoor",0];};
			if (_storage animationSourcePhase "StorageDoor2" > 0.5) then {_storage animateSource ["StorageDoor2",0];};

		};
	};

	if ((count _db) != 0) then
	{
		_veh setFuel (_db select 0);
		_veh setObjectTextureGlobal [0,(_db select 1)];
		_veh setObjectMaterialGlobal [0,(_db select 4)];
		_veh setVariable["numPChange",(_db select 2),true];
		_veh setVariable["isCustomPlate",(_db select 3),true];
		
		//tuning
		_addons = [(_db select 5)] call Server_Database_ToArray;
		if ((count _addons) > 0) then {
			{
				_animName = _x select 0;
				_animPhase = _x select 1;
				_veh animatesource [_animName, _animPhase, true];
			} foreach _addons;
		};		
	};
	[[4],"A3PL_Storage_CarRetrieveResponse",_player,false] call BIS_FNC_MP;


}] call Server_Setup_Compile;

["Server_Storage_RetrieveVehicle",
{
	private ["_query","_class","_player","_id","_storage","_veh","_trailer","_db"];
	_class = param [0,""];
	_player = param [1,objNull];
	_id = param [2,-1];
	_storage = param [3,objNull,[objNull,[]]];
	_whitelistTrailer = ["A3PL_Ski_Base"];
	//[format ["%1",_storage],"hint",true,false,false] call BIS_fnc_MP;
	if (typeName _storage == "ARRAY") exitwith
	{
		[_class,_player,_id,_storage] call Server_Storage_RetrieveVehiclePos;
	};

	if (_storage animationPhase "StorageDoor1" > 0.1) exitwith
	{
		diag_log "Server_Storage_RetrieveVehicle";
		[[1],"A3PL_Storage_CarRetrieveResponse",_player,false] call BIS_FNC_MP;
	};

	_query = format ["SELECT fuel,color,numpchange,iscustomplate,material,tuning FROM objects WHERE id = '%1'",_id];
	_db = [_query, 2, false] call Server_Database_Async;

	_query = format ["UPDATE objects SET plystorage = '0',impounded = '0' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

	[[2],"A3PL_Storage_CarRetrieveResponse",_player,false] call BIS_FNC_MP;

	_veh = [_class,_storage,_id,_player] call Server_Vehicle_Spawn;

	if ((count _db) != 0) then
	{
		_veh setFuel (_db select 0);
		_veh setObjectTextureGlobal [0,(_db select 1)];
		_veh setObjectMaterialGlobal [0,(_db select 4)];
		_veh setVariable["numPChange",(_db select 2),true];
		_veh setVariable["isCustomPlate",(_db select 3),true];
		
		//Activate Tuning
		_addons = [(_db select 5)] call Server_Database_ToArray;
		if ((count _addons) > 0) then {
			{
				_animName = _x select 0;
				_animPhase = _x select 1;
				_veh animatesource [_animName, _animPhase, true];
			} foreach _addons;
		};		
	};

	if ((_veh isKindOf "ship") && (!(typeOf _veh IN _whitelistTrailer))) then
	{
		_trailer = createVehicle ["A3PL_BoatTrailer_Normal", (getPos _veh), [], 0, 'CAN_COLLIDE'];
		_trailer allowDamage false;
		_veh attachTo [_trailer,[0,0,1.5]];
		_trailer setDir (getDir _storage);
		_trailer setPos (getPos _storage);

		[_veh,_trailer,_player] spawn
		{
			_veh = param [0,objNull];
			_trailer = param [1,objNull];
			_player = param [2,objNull];
			sleep 1.5;
			_veh setOwner (owner _player);
		};
	};

	_storage animateSource ["storagedoor",1];
	[_player,_storage,_veh,_id] spawn
	{
		private ["_player","_storage","_t","_veh","_id"];
		_player = param [0,ObjNull];
		_storage = param [1,ObjNull];
		_veh = param [2,ObjNull];
		_id = param [3,""];

		_t = 0;
		while {(_veh distance _storage) < 8} do
		{
			uiSleep 1;
			_t = _t + 1;
			if (isNull _veh) exitwith
			{

			};
			if (_t > 119) exitwith
			{
				[[3],"A3PL_Storage_CarRetrieveResponse",_player,false] call BIS_FNC_MP;
				_query = format ["UPDATE objects SET plystorage = '1' WHERE id = '%1'",_id];
				[_query,1] spawn Server_Database_Async;
				Server_Storage_ListVehicles - [_veh];
				[_veh] call Server_Vehicle_Despawn;
			};
		};
		_storage animateSource ["storagedoor",0];

	};

},true] call Server_Setup_Compile;

["Server_Storage_StoreObject",
{
	private ["_player","_obj","_var","_id"];
	_player = param [0,ObjNull];
	_obj = param [1,ObjNull];

	_var = _obj getVariable ["owner", nil];
	if(isNil "_var") exitWith {};

	_id = [7] call Server_Housing_GenerateID;
	_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','object','%2','%3','1')",_id,typeOf _obj,getPlayerUID _player];
	[_query,1] spawn Server_Database_Async;
	deleteVehicle _obj;
},true] call Server_Setup_Compile;



["Server_Storage_StoreVehicle",
{
	private ["_storage","_near","_playerCar","_player"];
	_player = param [0,ObjNull];
	_storage = param [1,ObjNull];
	_uid = getPlayerUID _player;

	if (_storage animationPhase "StorageDoor1" > 0.1) exitwith
	{
		[[1],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
	};

	//Look for nearest vehicle
	_near = nearestObjects [_storage,["Car","Ship","Air"],9];
	if (count _near == 0) exitwith
	{
		[[7],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
	};

	{
		_var = _x getVariable "owner";
		if (!isNil "_var") then
		{
			if ((_var select 0) == _uid) exitwith
			{
				_playerCar = _x;
			};
		};
	} foreach _near;

	if (isNil "_playerCar") exitwith
	{
		[[6],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
	};

	_storage animateSource ["storagedoor",1];

	[[2],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
	//Okay now tell the user to drive the car inside
	[_playerCar,_storage,_player] spawn
	{
		private ["_playerCar","_storage","_player","_t","_fail","_var","_id"];
		_playerCar = param [0,objNull];
		_storage = param [1,objNull];
		_player = param [2,objNull];

		_t = 0;
		_fail = false;
		while {(_playerCar distance _storage > 3) OR ((_player IN _playerCar) OR ((_player distance _storage) < 4.8))} do
		{
			_t = _t + 1;
			uiSleep 1;
			if (isNull _playerCar) exitwith
			{
				_fail = true;
				[[5],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
			};
			if (_t > 119) exitwith
			{
				//we can do more here later
				[[4],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
				_fail = true;
			};
		};

		if (!_fail) then
		{
			[[3],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
		};

		_storage animateSource ["storagedoor",0];

		uiSleep 10;
		if (!_fail) then
		{
			private ["_sirenObj"];
			//save the car here
			_var = _playerCar getVariable "owner";
			_id = _var select 1;
			_Path = (getObjectTextures _playerCar) select 0;
			_material = (getObjectMaterials _playerCar) select 0;
			_Pathformat = format ["%1",_Path];
			_materialFormat = format ["%1",_material];
			_Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
			_materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
			_query = format ["UPDATE objects SET plystorage = '1',fuel='%2',color='%3',material='%4' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation];
			[_query,1] spawn Server_Database_Async;
			Server_Storage_ListVehicles - [_playerCar];

			[_playercar] call Server_Vehicle_Despawn;
		};
	};

},true] call Server_Setup_Compile;


["Server_Storage_SaveLargeVehicles",
{
	private ["_veh","_var","_id","_query"];
	_playerCar = param [0,objNull];
	if (isNull _playerCar) exitwith {};

		_var = _playerCar getVariable ["owner",nil];
		_id = _var select 1;
		_Path = (getObjectTextures _playerCar) select 0;
		_material = (getObjectMaterials _playerCar) select 0;
		_Pathformat = format ["%1",_Path];
		_materialFormat = format ["%1",_material];
		_Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
		_materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
		_query = format ["UPDATE objects SET plystorage = '1',fuel='%2',color='%3',material='%4' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation];
		[_query,1] spawn Server_Database_Async;

	[_playerCar] call Server_Vehicle_Despawn;


},true] call Server_Setup_Compile;
