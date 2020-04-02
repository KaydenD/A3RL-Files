['Server_Locker_Load', {
	private ["_lockers"];
	_lockers = ["SELECT locker, owner, items, objects FROM lockers", 2, true] call Server_Database_Async;
	{
		private ["_locker","_items"];
		_locker = call compile (_x select 0);
		_locker setVariable ["owner",_x select 1,true];

		_items = call compile (_x select 2);
		{_locker addWeaponCargoGlobal [_x,1]} foreach (_items select 0);
		{_locker addMagazineCargoGlobal [_x,1]} foreach (_items select 1);
		{_locker addItemCargoGlobal [_x,1]} foreach (_items select 2);
		{_locker addBackpackCargoGlobal [_x,1]} foreach (_items select 3);
	} foreach _lockers;
},true] call Server_Setup_Compile;

['Server_Locker_Insert', {
	private ["_locker","_player","_query"];
	_locker = _this select 0;
	_player = _this select 1;

	_query = format ["INSERT INTO lockers(locker, owner) VALUES ('%1','%2')",_locker, getPlayerUID _player];
	[_query, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;

['Server_Locker_Save', {
	private ["_lockers"];
	_lockers = ["SELECT locker, owner, items, objects FROM lockers", 2, true] call Server_Database_Async;
	{
		private ["_locker","_attachedObjects","_query"];
		_locker = call compile (_x select 0);

		//Attached objects
		_objects = [];
		{if (!isNull _x) then {_objects pushBack (typeOf _x);};} foreach (attachedObjects _locker);
		//Core inventory
		_items = [weaponCargo _locker, magazineCargo _locker, itemCargo _locker, backpackCargo _locker];

		//Update DB
		_query = format["UPDATE lockers SET items='%1',objects='%2' WHERE locker ='%3'",_items,_objects,_locker];
		[_query,1] spawn Server_Database_Async;
	} foreach _lockers;
},true] call Server_Setup_Compile;

/*
['Server_Locker_Spawn', {
	private ["_locker","_openOrClose"];
	_locker = _this select 0;
	_openOrClose = _this select 1;

	if (_openOrClose) exitwith
	{
		{
			private ["_item"];
			_item = (_x select 0) createvehicle (getpos _locker);
			if (typeOf _item == "GroundWeaponHolder") then
			{
				private ["_itemToAdd"];
				_itemToAdd = _x select 3;


				if (isClass (configFile >> "CfgWeapons" >> _itemToAdd)) exitwith
				{
					//Clothes
					if (isClass (configFile >> "CfgVehicles" >> _itemToAdd)) then
					{
						_item addItemCargoGlobal [_itemToAdd,1];
					} else
					{
						_item addWeaponCargoGlobal [_itemToAdd,1];
					};
				};
				if (isClass (configFile >> "CfgMagazines" >> _itemToAdd)) exitwith
				{
					_item addMagazineCargoGlobal [_itemToAdd,1];
				};
				_item addItemCargoGlobal [_itemToAdd,1];
			};
			_item setPosATL (_x select 1);
			_item attachTo [_locker];
			_item setDir ((_x select 2) + (360 - (getDir _item)));
			_item setPosATL (_x select 1);
		} foreach (_locker getVariable "items");
		_locker animate ["door1",1];
	};

	//Delete items from locker and delete it all
	_locker animate ["door1",0];
	[_locker] call Server_Locker_Save;

},true] call Server_Setup_Compile;
*/