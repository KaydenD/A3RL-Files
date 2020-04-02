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

	_query = format ["UPDATE objects SET plystorage = '0' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

	[[2],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;

	_veh = [_class,(getpos _player),_player,_id] call Server_Housing_CreateFurniture;

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

	if ((_obj distance _player) > 10) exitwith
	{
		[[4],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;
	};

	_var = _obj getVariable "owner";

	if (isNil "_var") exitwith
	{
		[[6],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;
	};

	_id = _var select 1;

	if (!((_var select 0) == (getPlayerUID _player))) exitwith
	{
		[[7],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;
	};

	_query = format ["UPDATE objects SET plystorage = '1' WHERE id = '%1'",_id];
	[_query,1] spawn Server_Database_Async;

	Server_Storage_ListAll = Server_Storage_ListAll - [_obj];
	deleteVehicle _obj;

	[[5],"A3PL_Storage_ObjectRetrieveResponse",_player,false] call BIS_FNC_MP;

},true] call Server_Setup_Compile;

//This function can get Vars from a 'vars' database
["Server_Storage_GetVars",
{
	private ["_request","_vars"];
	_request = param [0,"lp"];
	_vars = param [1,[]];

	_return = "";
	{
		if ((_x select 0) == _request) exitwith
		{
			_return = _x select 1;
		};
	} foreach _vars;

	_return;
},true] call Server_Setup_Compile;

//Function that checks storage of player and spawns any that should be inside their house
//COMPILE BLOCK FUNCTION!!!!
["Server_Storage_loadFurniture",
{
	private ["_player","_uid","_objects","_query","_apt","_aptNumber"];
	_player = param [0,objNull];
	_uid = param [1,"-1"];
	if (_uid == "-1") then
	{
		_uid = getplayerUID _player;
	};

	_apt = _player getVariable "apt";
	if (!isNil "_apt") then
	{
		_aptNumber = _player getVariable "aptnumber";
		if (isNil "_aptNumber") exitwith {diag_log "Unable to spawn furniture, _aptNumber nil"};

		//3 different querys because we somehow cant do it once(statement prepare error) sucks
		_query = format ["SELECT id,class,pos FROM objects WHERE (spawn = '2' AND plystorage = '1') AND (uid = '%1' AND type='object')",_uid];
		_objects = [_query, 2, true] call Server_Database_Async;

		_query = format ["UPDATE objects SET plystorage = '0' WHERE (spawn = '2' AND plystorage = '1') AND (uid = '%1' AND type='object')",_uid]; // also reset every house furniture to storage
		[_query,1] spawn Server_Database_Async;

		_query = format ["UPDATE objects SET spawn = '0' WHERE spawn = '1' AND (uid = '%1' AND type='object')",_uid]; // also reset every house furniture to storage (in case we owned a house before)
		[_query,1] spawn Server_Database_Async;


		{
			private ["_id","_class","_pos","_dir","_obj","_h","_hArray","_y"];
			_id = _x select 0;
			_class = _x select 1;
			_pos = call compile (_x select 2);
			_dir = _pos select 3;

			//lets calculate height here
			_hArray = [0.231,0.231,0.231,0.231,3.00974,3.00974,3.00974,3.00974]; //Custom height here since modelToWorld Z is broken
			_h = _hArray select (_aptNumber - 1);

			//lets calculate _y here
			_y = _pos select 1;
			if (_aptNumber IN [1,5,3,7]) then //left sides
			{
				_y = 5.4 + _y;
				_dir = (getDir _apt) + _dir;
			} else //right sides
			{
				_y = 5.4 - _y;
				_dir = (getDir _apt) - _dir;
			};

			if (_aptNumber IN [3,4,7,8]) then //offset for 3,4,7,8
			{
				_y = _y - 10.8;
			};


			_pos = _apt ModelToWorld [_pos select 0,_y,0];
			_pos = [_pos select 0,_pos select 1,_h];
			[_class,_pos,_player,_id,_dir] spawn Server_Housing_CreateFurniture;
		} foreach _objects;
	} else
	{
		//two query, one selects, other sets it to storage to 0
		_query = format ["SELECT id,class,pos FROM objects WHERE (spawn = '1' AND plystorage = '1') AND (uid = '%1' AND type='object')",_uid];
		_objects = [_query, 2, true] call Server_Database_Async;

		_query = format ["UPDATE objects SET plystorage = '0' WHERE (spawn = '1' AND plystorage = '1') AND (uid = '%1' AND type='object')",_uid];
		[_query,1] spawn Server_Database_Async;

		{
			private ["_id","_class","_pos","_dir"];
			_id = _x select 0;
			_class = _x select 1;
			_pos = call compile (_x select 2);

			_dir = _pos select 3;
			_pos = [_pos select 0,_pos select 1,_pos select 2];

			[_class,_pos,_player,_id,_dir] spawn Server_Housing_CreateFurniture;
		} foreach _objects;
	};


},true,true] call Server_Setup_Compile;

//Function responsible for saving every single object
["Server_Storage_Save",
{
	private ["_player","_uid","_playerHouse","_objectsOutsideHouse","_playerAPTVar","_delete"];
	_player = param [0,objNull];
	_uid = param [1,"-1"];
	_delete = param [2,false];

	if (_uid == "-1") then
	{
		_uid = getplayerUID _player;
	};

	//First get a list of objects owned by that player
	_playerObjects = [];
	{
		private ["_var"];
		_var = _x getVariable "Owner";
		if (!isNil "_var") then
		{
			if (_uid == (_var select 0)) then
			{
				_playerObjects pushback _x;
			};
		};
	} foreach Server_Storage_ListAll; // Server_Storage_ListAll contains pretty much all storage objects

	_objectsOutsideHouse = [];
	_playerAPTVar = _player getVariable "apt";

	//first check if any object is near a player house
	{
		private ["_playerHouse","_ownerInfo","_obj"];
		_obj = _x;

		_ownerInfo = _obj getVariable "owner";
		if (isNil "_ownerInfo") exitwith {};

		if (!isNil "_playerAPTVar") then
		{
			private ["_objModel","_t","_aptN","_apt","_aptO","_atl"];
			//get trigger
			_apt = _player getVariable "apt";
			_aptN = _player getVariable "aptNumber";

			//second part is a copy of first (1-4, 5-8)
			_aptO = [8.1,2.8,-2.7,-7.8, 8.1,2.8,-2.7,-7.8]; //offsets

			if (_obj inArea [(_apt modelToWorld [1.5,(_aptO select (_aptN-1)),-2.8]), 6.8, 2.4, (getDir _apt), true]) then
			{
				//another check to see if the Z is good, Z on WorldToModel is broken
				_atl = getposATL _obj;
				if ((_aptN IN [1,2,3,4]) && ((_atl select 2) < 2.5)) then
				{
					_playerHouse = _player getVariable "apt";
				};

				if ((_aptN IN [5,6,7,8]) && ((_atl select 2) > 2.5)) then
				{
					_playerHouse = _player getVariable "apt";
				};

			};

		} else
		{
			private ["_near"];
			_near = nearestObjects [_obj, ["Land_Home1g_DED_Home1g_01_F"], 25];
			//if we find a house
			if (count _near > 0) then
			{
				{
					private ["_getVar"];
					_getVar = _x getVariable "owner";
					if (!isNil "_getVar") then
					{
						//okay this house belongs to us
						if ((_getVar select 0) == _uid) then
						{
							_playerHouse = _x;
						};
					};
				} foreach _near;
			};
		};

		if (isNil "_playerHouse") then
		{
			_objectsOutsideHouse pushback (_ownerInfo select 1);
		} else
		{
			if (_playerHouse isKindOf "Land_Home1g_DED_Home1g_01_F") then
			{

				if (_delete) then
				{
					_query = format ["UPDATE objects SET spawn = '1',pos = '%2',plystorage='1' WHERE id = '%1'",(_ownerInfo select 1),[(getposATL _obj select 0),(getposATL _obj select 1),(getposATL _obj select 2),getDir _obj]];
					[_query,1] spawn Server_Database_Async;
					Server_Storage_ListAll = Server_Storage_ListAll - [_obj];
					deleteVehicle _obj;
				} else
				{
					_query = format ["UPDATE objects SET spawn = '1',pos = '%2' WHERE id = '%1'",(_ownerInfo select 1),[(getposATL _obj select 0),(getposATL _obj select 1),(getposATL _obj select 2),getDir _obj]];
					[_query,1] spawn Server_Database_Async;
				};
			} else
			{
				private ["_pos","_posY","_dir","_offsetX","_offsetY"];
				//Custom saving for apt furniture here
				_pos = _playerHouse worldToModel (getpos _obj);
				_offsetX = _pos select 0; //x offset is easy
				_posY = _pos select 1;
				_dir = getDir _obj;

				//http://i.imgur.com/GT5Zw0n.png
				//first retrieve the offset

				if (_posY < 0) then
				{
					_posY = _posY + 10.8; //offset for APT3,4,7,8
				};

				_offsetY = _posY - 5.4;

				//negative to positive
				if (_offsetY < 0) then
				{
					_offsetY = -(-_offsetY);
				};

				//Direction
				_dir = (getDir _obj) - (getDir _playerHouse);

				if (_delete) then
				{
					//
					_pos = [_offsetX,_offsetY,0,_dir];
					_query = format ["UPDATE objects SET spawn = '2',pos = '%2',plystorage = '1' WHERE id = '%1'",(_ownerInfo select 1),_pos];
					[_query,1] spawn Server_Database_Async;

					Server_Storage_ListAll = Server_Storage_ListAll - [_obj];
					deleteVehicle _obj;

				} else
				{
					_pos = [_offsetX,_offsetY,0,_dir];
					_query = format ["UPDATE objects SET spawn = '2',pos = '%2' WHERE id = '%1'",(_ownerInfo select 1),_pos];
					[_query,1] spawn Server_Database_Async;
				};
			};
		};
	} foreach _playerObjects;

	if (count _objectsOutsideHouse > 0) then
	{
		//Save it with spawn = 0
		_query = format ["UPDATE objects SET spawn = '0',pos = '[]' WHERE id IN %1",[_objectsOutsideHouse] call Server_Database_ArrayToSqlIN];
		[_query,1] spawn Server_Database_Async;
	};

},true] call Server_Setup_Compile;

["Server_Storage_StoreVehicle_Pos",
{
	private ["_storage","_near","_playerCar","_player"];
	_player = param [0,ObjNull];
	_storage = param [1,ObjNull];
	_uid = getPlayerUID _player;
	//[format ["%1",_storage],"hint",true,false,false] call BIS_fnc_MP;
	//Look for nearest vehicle
	_near = nearestObjects [_player,["Car","Ship","Air","Tank"],15];

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

	[_playerCar,_storage,_player] spawn
	{
		private ["_playerCar","_storage","_player","_t","_fail","_var","_id"];
		_playerCar = param [0,objNull];
		_storage = param [1,objNull];
		_player = param [2,objNull];

		_t = 0;
		_fail = false;

		while {(_playerCar distance _player > 5) OR (_player IN _playerCar)} do
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
			[[9],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
		};
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
			hint "This ran";

			[_playercar] call Server_Vehicle_Despawn;

		};
	};

},true] call Server_Setup_Compile;

//This function can put a car back into storage
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

//This function can put a car back into storage
["Server_Storage_StoreVehicle_Position",
{
	private ["_storage","_near","_playerCar","_player"];
	_player = param [0,ObjNull];
	_storage = param [1,ObjNull];
	_uid = getPlayerUID _player;


	//Look for nearest vehicle
	_near = nearestObjects [_player,["Car","Ship","Air","Tank","Truck"],15];
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


	[[8],"A3PL_Storage_CarStoreResponse",_player,false] call BIS_FNC_MP;
	//Okay now tell the user to drive the car inside
	[_playerCar,_storage,_player] spawn
	{
		private ["_playerCar","_storage","_player","_t","_fail","_var","_id"];
		_playerCar = param [0,objNull];
		_storage = param [1,objNull];
		_player = param [2,objNull];

		_t = 0;
		_fail = false;
		while {(_playerCar distance _storage > 15) OR ((_player IN _playerCar) OR ((_player distance _storage) < 4.8))} do
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


		if (!_fail) then
		{
			private ["_sirenObj"];
			//save the car here
			hint "RUNNING SCRIPT RIGHT";
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
