//deals with removing items from player_inventory after crafting complete
//it will
//1. Remove cash/inventory items permanently from player vars
//2. Set another variable to add factory storage item to player
//3. Save the factory storage to database
//WARNING: In-case of a server crash, items MAY be returned to player due to there not being a cash/inventory save here
["Server_Factory_Finalise",
{
	private ["_player","_type","_id","_items","_amount","_required","_newArr","_storage","_i"];
	_player = param [0,objNull];
	_type = param [1,""]; //factory name
	_id = param [2,""]; //id of crafting item
	_quantity = param [3,1]; //quantity of crafting item
	_items = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage;
	_storage = _player getVariable ["player_fstorage",[]];
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory; //required items to craft this
	_amount = [_id,_type,"output"] call A3PL_Config_GetFactory;

	//delete the items from storage
	{
		private ["_id","_amount","_isFactory"];
		_id = _x select 0;
		_isFactory = _id splitString "_";
		_amount = _x select 1;
		_items = [_items, _id, -(_amount)*_quantity, true] call BIS_fnc_addToPairs; //remove item from his storage
	} foreach _required;

	{
		if ((_x select 1) < 1) then
		{
			_items deleteAt _forEachIndex 	//verify, delete less than 0
		};
	} forEach _items;

	{
		if (_x select 0 == _type) exitwith {_i = _forEachIndex};
	} foreach _storage;

	if (isNil "_i") exitwith {}; //cannot find the factory?

	_newArr = _storage select _i;
	_newArr set [1,_items];

	if (count _items == 0) then
	{
		_storage deleteAt _i; //we can remove the complete array from player_fstorage
	} else
	{
		_storage set [_i,_newArr];
	};
	//end of deleting from storage
	_player setvariable ["player_fStorage",_storage,true];

	//if this an item we want to add the item itself and not the recipe
	if (([_id,_type,"type"] call A3PL_Config_GetFactory) == "item") then
	{
		private ["_isFactory"];
		_isFactory = _id splitString "_";
		if ((_isFactory select 0) == "f") then {_isFactory = true;} else {_isFactory = false;};
		if (_isFactory) then {_id = [_id,_type,"class"] call A3PL_Config_GetFactory;};
	};

	//add the item to the storage
	[_player,_type,[_id,_amount*_quantity],false] call Server_Factory_Add;
},true] call Server_Setup_Compile;

//adds an item to the _fStorage
["Server_Factory_Add",
{
	private ["_items","_player","_inventory","_newCash","_type","_item","_items","_i","_move","_fail","_obj"];
	_player = param [0,objNull]; //player obviously
	_type = param [1,""]; //factory we are adding this item to
	_item = param [2,["",1]]; //items we are adding
	_move = param [3,true]; //whether we are moving this item and should delete it from there
	_obj = param [4,nil]; //additional object we must remove if moved to the factory
	_fail = false;
	if (_move) then
	{
		if (!isNil "_obj") then
		{
			if (isNull _obj) exitwith {_fail = true;};
			deleteVehicle _obj;
		} else
		{
			private ["_class","_amount","_has"];
			//check if we have this item
			_has = [(_item select 0),(_item select 1),_player] call Server_Inventory_Has;
			if (!_has) exitwith {_fail = true;};
			//REMOVE ITEM WE ARE ADDING TO STORAGE
			_inventory = _player getVariable ["player_inventory",[]];
			_class = _item select 0;
			_amount = _item select 1;
			if (_class == "cash") then
			{
				_newcash = (_player getVariable ["player_cash",0]) - _amount;
			} else
			{
				_inventory = [_inventory, _class, -(_amount), true] call BIS_fnc_addToPairs;
			};

			_player setvariable ["player_inventory",_inventory,true];
			[_player] call Server_Inventory_Verify;
			if (!isNil "_newCash") then {_player setvariable ["player_cash",_newcash,true];};
			//END OF REMOVING ITEM
		};
	};
	if (_fail) exitwith {}; //player is adding something that he doesn't have, or cannot be found

	//START OF ADDING ITEM TO fSTORAGE
	_storage = _player getvariable ["player_fStorage",[]];
	//in format
	/*
		[
			["Illegal Weapon Factory",[["f_rook1",1],["f_rook2",3]]],
			["vehicle factory",[["f_rook2",1],["f_rook2",1]]]
		]
	*/
	_newArr = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage; //exists in array already
	{
		if ((_x select 0) == _type) exitwith {_i = _forEachIndex;};
	} foreach _storage; //get the index this factory is at
	if (typeName _newArr != "BOOL") then //item exists
	{
		_newArr = [_newArr, (_item select 0), (_item select 1), true] call BIS_fnc_addToPairs;
		if (isNil "_i") exitwith {}; //somehow couldn't find the index
		(_storage select _i) set [1,_newArr];
	} else
	{
		_storage pushBack [_type,[[(_item select 0),(_item select 1)]]];
	};
	_player setvariable ["player_fstorage",_storage,true]; //set var
	_query = format ["UPDATE players SET player_fstorage='%1' WHERE uid='%2'",([_storage] call Server_Database_Array),getPlayerUID _player];
	[_query,1] spawn Server_Database_Async; //set database
	//END OF ADDING ITEM TO fSTORAGE
	[getPlayerUID _player,"addFactory",[_type,_item], _player getVariable "name"] call Server_Log_New;
},true] call Server_Setup_Compile;

//script that runs upon collecting
["Server_Factory_Collect",
{
	private ["_player","_type","_item","_i","_query","_storage","_items","_id","_amount"];
	_player = param [0,objNull];
	_type = param [1,""]; //factory name
	_item = param [2,["",1]]; //id of crafting item
	_id = _item select 0;
	_amount = _item select 1;
	_storage = _player getVariable ["player_fstorage",[]];
	_items = [_type,"items",_player] call A3PL_Config_GetPlayerFStorage; //gets an array of items as formatted above
	if (typeName _storage == "BOOL") then {_storage = []};

	//DEAL WITH THE PLAYER_FSTORAGE VARIABLES
	if (!([_id,_amount,_type,_player] call A3PL_Factory_Has)) exitwith {}; //player doesnt have the item in storage he's trying to craft
	//END OF CHECK TO SEE IF WE HAVE ITEM IN FSTORAGE

	_items = [_items, _id, -(_amount), true] call BIS_fnc_addToPairs; //remove item from his storage
	//verify, delete less than 0
	{
		if ((_x select 1) < 1) then
		{
			_items deleteAt _forEachIndex
		};
	} forEach _items;
	//end of verify

	{
		if (_x select 0 == _type) exitwith {_i = _forEachIndex};
	} foreach _storage;

	if (isNil "_i") exitwith {}; //cannot find the factory?

	_newArr = _storage select _i;
	_newArr set [1,_items];

	if (count _items == 0) then
	{
		_storage deleteAt _i; //we can remove the complete array from player_fstorage
	} else
	{
		_storage set [_i,_newArr];
	};
	_player setvariable ["player_fstorage",_storage,true]; //set variable
	_query = format ["UPDATE players SET player_fstorage='%1' WHERE uid='%2'",([_storage] call Server_Database_Array),getPlayerUID _player];
	[_query,1] spawn Server_Database_Async; //set database
	//END OF DEALING WITH THE PLAYER_FSTORAGE VARIABLES

	//HANDLE CREATION OF ITEM HERE
	[_player,_item,_type] call Server_Factory_Create;
	//END OF HANDLING CREATION OF ITEM
	[getPlayerUID _player,"collectFactoryVirtual",[_type,_item,_amount], _player getVariable "name"] call Server_Log_New;
},true] call Server_Setup_Compile;

//Takes care of spawning the item
["Server_Factory_Create",
{
	private ["_player","_id","_item","_amount","_type","_classType","_class","_isFactory","_forFaction"];
	_player = param [0,objNull];
	_item = param [1,["",1]];
	_id = _item select 0;
	_amount = _item select 1;
	_type = param [2,""];
	_classType = param [3,nil];
	_forFaction = "";

	//is this an item that the factory has created?
	_isFactory = _id splitString "_";
	if ((_isFactory select 0) == "f") then {_isFactory = true;} else {_isFactory = false;};
	//end of factory check

	if (_isFactory) then
	{
		_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		_forFaction = [_id,_type,"faction"] call A3PL_Config_GetFactory;
		_id = [_id,_type,"class"] call A3PL_Config_GetFactory;
	} else
	{
		if (isNil "_classType") then
		{
			_classType = "item";
		};
	};

	switch (true) do
	{
		case (_classType == "car"):
		{
			private ["_lp","_pos","_dir"];
			_lp = [_player,_id,"vehicle",false] call Server_Vehicle_Buy; //inserts into DB, returns id/license plate
			if (_id isKindOf "Ship") then
			{
				_pos = [(getpos _player), 1, 50, 1, 2, 100, 1] call BIS_fnc_findSafePos;
			} else
			{
				_pos = (getpos _player) findEmptyPosition [2,25,_id];
			};
			if (count _pos == 0) then {_pos = getpos _player}; //just use player pos if we cant find a suitable spot
			_dir = 0;
			switch (_type) do {
				case ("Vehicle Factory"): {_dir = 195;};
			};
			_veh = [_id,_pos,_lp,_player, _dir] call Server_Vehicle_Spawn;
			//_veh setVariable ["dealer",true,true]; //set a variable so we know it's a dealer vehicle
		};
		case (_classType == "plane"):
		{
			_lp = [_player,_id,"plane",true] call Server_Vehicle_Buy; //create into DB, tell player his airplane can be retrieved from the plane retrieval
		};
		case (_classType == "item"):
		{
			if (_forFaction != "") exitwith
			{
				private ["_obj"];
				_obj = createVehicle ["A3PL_Crate", (getpos _player), [], 0, "CAN_COLLIDE"];
				//set variables
				_obj setVariable ["owner",(getPlayerUID _player),true];
				_obj setVariable ["class","finv",true]; //"FINV" -> Faction inventory item (can be both of type "item" and arma inventory items)
				_obj setVariable ["finv",[_classtype,_id,_amount,_forFaction],true];
			};

			private ["_canPickup","_simulation"];
			_canPickup = [_id,"canPickup"] call A3PL_Config_GetItem;
			_simulation = [_id,"simulation"] call A3PL_Config_GetItem;
			if (_canPickup) then
			{
				[_player,_id,_amount] call Server_Inventory_Add;
			} else
			{
				private ["_obj","_objClass"];
				if(_amount > 1) exitWith {["System: You can only retrieve one of this item!",Color_Red] call A3PL_Player_Notification; [_player,_type,[_id,_amount],false] call Server_Factory_Add;};
				_objClass = [_id,"class"] call A3PL_Config_GetItem;
				_obj = createVehicle [_objClass, (getpos _player), [], 0, "CAN_COLLIDE"];

				//set variables
				_obj setVariable ["owner",(getPlayerUID _player),true];
				_obj setVariable ["class",_id,true];
			};
		};

		case (_classType IN ["vest","uniform","goggles","headgear","backpack","weapon","magazine","aitem","weaponitem","secweaponitem"]):
		{
				private ["_obj"];
				if (_classType == "uniform") then
				{
					_obj = createVehicle ["A3PL_Clothing", (getpos _player), [], 0, "CAN_COLLIDE"];
				} else
				{
					_obj = createVehicle ["A3PL_Crate", (getpos _player), [], 0, "CAN_COLLIDE"];
				};
				//set variables
				_obj setVariable ["owner",(getPlayerUID _player),true];

				if (_forFaction == "") then
				{
					_obj setVariable ["class","ainv",true]; //"AINV" -> Arma inventory item
					_obj setVariable ["ainv",[_classtype,_id,_amount],true];
				} else
				{
					_obj setVariable ["class","finv",true]; //"FINV" -> Faction inventory item (can be both of type "item" and arma inventory items)
					_obj setVariable ["finv",[_classtype,_id,_amount,_forFaction],true];
				};
		};
	};
	[getPlayerUID _player,"collectFactoryPhysical",[_type,_item,_amount], _player getVariable "name"] call Server_Log_New;
},true] call Server_Setup_Compile;
