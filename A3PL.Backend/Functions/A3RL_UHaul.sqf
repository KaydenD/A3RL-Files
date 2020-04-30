["A3RL_UHAUL_Open",
{
	disableSerialization;
	private ["_shop","_display","_currency","_control","_pos","_posConfig","_cam"];

	if(player getVariable ["inventory_opened",false]) then {[getPlayerUID player,"InventoryShopCloningAttempt",[]] remoteExec ["Server_Log_New",2];};
	if(player getVariable ["inventory_opened",false]) exitwith {['Close menu and retry',Color_Red] call A3PL_Player_Notification;};

	_itemName = [player_itemClass,"name"] call A3PL_Config_GetItem;
	if (typeName _itemName != "BOOL") then {[getPlayerUID player,"InventoryShopOpenWithItemAttempt",[]] remoteExec ["Server_Log_New",2];};
	if (typeName _itemName != "BOOL") exitwith {['Drop what you have on hand and try again',Color_Red] call A3PL_Player_Notification;};

	_shop = param [0,""];
	_currency = param [1,"player_cash"];
	_npc = cursorobject;

	createDialog "Dialog_UHaul";
	_display = findDisplay 22;

	_control = _display displayCtrl 1602;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3RL_UHAUL_Rent;",_shop,_currency]];
	_control = _display displayCtrl 1500;
	_control ctrlAddEventHandler ["LBSelChanged",format ["['%1',1500, '%2'] call A3RL_UHAUL_ItemSwitch;",_shop,_npc]];
	lbClear _control;
	//Fill listbox
	_allItems = [_shop] call A3PL_Config_GetShop;
	{
		private ["_itemType","_itemClass","_itemName","_itemPicture", "_i"];

		_itemType = _x select 0;
		_itemClass = _x select 1;
		switch (_itemType) do
		{
			case ("aitem"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("item"):{_itemName = [_itemClass,"name"] call A3PL_Config_GetItem; _itemPicture = "";};
			case ("backpack"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgVehicles" >> _itemClass >> "picture");};
			case ("uniform"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("vest"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("headgear"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("vehicle"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgVehicles" >> _itemClass >> "picture");};
			case ("weapon"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("weaponPrimary"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgWeapons" >> _itemClass >> "picture");};
			case ("magazine"): { _itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgMagazines" >> _itemClass >> "picture");};
			case ("goggles"): { _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName"); _itemPicture = getText (configFile >> "CfgMagazines" >> _itemClass >> "picture");};
		};

		if ([_itemClass,"canPickup"] call A3PL_Config_GetItem) then {
			_amount = [_itemClass] call A3PL_Inventory_Return;
			if(_amount > 0) then {
				_i = _control lbAdd format["%1 (Inv: %2x)",_itemName,_amount];
			} else {
				_i = _control lbAdd _itemName;
			};
		} else {
			if(_itemType in ["vehicle"]) then {
				_i = _control lbAdd format ["%1",_itemName,(count _objects)];
			} else {
				_i = _control lbAdd _itemName;
				if(_itemPicture != "") then{_control lbSetPicture[(lbSize _control)-1,_itemPicture];};
			};
		};
		_control lbSetData [_i,_itemClass];
	} foreach _allItems;
	_control lbSetCurSel 0;

	//set slider to half
	_control = _display displayCtrl 1900;
	_control sliderSetRange [-180, 180];
	_control sliderSetPosition 0;
	_control ctrlAddEventHandler ["SliderPosChanged",
	{
		A3PL_SHOP_ITEMPREVIEW setDir (param [1,180]);
	}];
	//Camera
	A3PL_SHOP_CAMERA = "camera" camCreate [0,0,0];
	A3PL_SHOP_CAMERA camSetPos (positionCameraToWorld [0,0,0]);
	A3PL_SHOP_CAMERA camSetRelPos [0,0,0];
	A3PL_SHOP_CAMERA cameraEffect ["internal", "BACK"];
	A3PL_SHOP_CAMERA camCommit 0;

	[_shop,1500] spawn A3RL_UHAUL_ItemSwitch;

	[A3PL_SHOP_CAMERA] spawn
	{
		disableSerialization;
		while {uiSleep 0.2; _display = findDisplay 22; !isNull _display} do {};
		deleteVehicle A3PL_SHOP_ITEMPREVIEW;
		{deleteVehicle _x;} foreach _this;
		A3PL_SHOP_ITEMPREVIEW = nil;
		player cameraEffect ["terminate", "BACK"];
	};
}] call Server_Setup_Compile;

["A3RL_UHaul_RentedVeh_Return",{
	_return = param [0,[]];
	A3RL_Rented_Vehicles = _return;
}] call Server_Setup_Compile;



["A3RL_UHAUL_Rent",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	disableSerialization;
	private ["_display","_control","_shop","_currency","_allItems","_price","_item","_itemBuy","_itemType","_itemClass","_itemName","_amount","_totalPrice","_stockCheck","_index"];
	_shop = param [0,""];
	_shopObject = cursorobject;
	_currency = param [1,"player_cash"];
	_display = findDisplay 22;
	_allItems = [_shop] call A3PL_Config_GetShop;

	_control = _display displayCtrl 1500;
	_index = lbCurSel _control;
	if(_index < 0) exitwith {};
	_item = _allItems select _index;
	_itemType = _item select 0; // item type
	_itemClass = _item select 1; // item class
	_itemBuy = _item select 2; //number containing buy price

	//get amount
	_amount = 1;

	//check stock value
	_stockCheck = true;
	if (_shop IN Config_Shops_StockSystem) then
	{
		if (isNull _shopObject) exitwith {_stockCheck = false};
		if (((_shopObject getVariable ["stock",[]]) select _index) < _amount) then {_stockCheck = false;};
	};
	if (!_stockCheck) exitwith {["System: There is not enough stock available to purchase this item!",Color_Red] call A3PL_Player_Notification;};

	//get total amount
	_totalPrice = _itemBuy*_amount;

	//check money
	_moneyCheck = false;
	switch (_currency) do
	{
		case ("candy"):
		{
			if (["candy",_totalprice] call A3PL_Inventory_Has) then {_moneyCheck = true;} else
			{
				[localize "STR_SHOP_NOTENOUGHCANDY",Color_Red] call A3PL_Player_Notification; //System: You don't have enough candy to buy this item
			};
		};
		default
		{
			if ((player getVariable [_currency,0]) >= _totalPrice) then {_moneyCheck = true;} else
			{
				[localize "STR_SHOP_NOTENOUGHMONEY",Color_Red] call A3PL_Player_Notification;
			};
		};
	};
	if (!_moneyCheck) exitwith {};

	_alreadyRentedType = false;
	A3RL_Rented_Vehicles = nil;
	[] remoteExec ["Server_UHaul_GetRentedVehicles", 2];
	waitUntil{!inNil"A3RL_Rented_Vehicles"};
	{
		if(((_x select 0) == (getPlayerUID player)) && {_itemClass IN (_x select 1)}) then {
			_alreadyRentedType = true;
		};
	} forEach A3RL_Rented_Vehicles;
	if(!_alreadyRentedType) exitWith {["You've already rented a vehicle of this type",Color_Red] call A3PL_Player_Notification;};


	//take stock if this was a stock item
	if (_shop IN Config_Shops_StockSystem) then
	{
		[_shopObject,_index,_amount] call A3PL_ShopStock_Decrease;
	};

	//give item
	_itemName = "UNKNOWN";
	switch (_itemType) do
	{
		case ("item"):
		{
			if ([_itemClass,"canPickup"] call A3PL_Config_GetItem) then
			{
				[_itemClass,_amount] call A3PL_Inventory_Add;
			} else
			{
				private ["_veh"];
				_veh = createVehicle [([_itemClass,"class"] call A3PL_Config_GetItem), getposATL player, [], 0, "CAN_COLLIDE"];
				if (!([_itemClass,"simulation"] call A3PL_Config_GetItem)) then
				{
					[_veh] remoteExec ["Server_Vehicle_EnableSimulation",2];
				};
				_veh setVariable ["class",_itemClass,true];
				_veh setVariable ["owner",getPlayerUID player,true];
			};
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
		};
		case ("backpack"): {[_itemClass] call A3PL_Lib_ChangeBackpackSafe; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("uniform"): {[_itemClass] call A3PL_Lib_ChangeUniformSafe; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vest"): {[_itemClass] call A3PL_Lib_ChangeVestSafe; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("headgear"): {[_itemClass] call A3PL_Lib_ChangeHeadgear; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("aitem"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vehicle"): {[_itemClass, (_shopObject getVariable ["spawnPos", [0,0,0]]) findEmptyPosition[0, 15, _itemClass], "UHAUL", player] remoteExec ["Server_Vehicle_Spawn", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("plane"): {[_itemClass, (_shopObject getVariable ["spawnPos", [0,0,0]]) findEmptyPosition[0, 15, _itemClass], "UHAUL", player] remoteExec ["Server_Vehicle_Spawn", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("weapon"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("weaponPrimary"): {player addWeapon _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("magazine"): {player addMagazines [_itemClass, _amount];_itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");};
		case ("goggles"): {[_itemClass] call A3PL_Lib_ChangeGoggles; _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName");};
	};
	//take money
	switch (_currency) do
	{
		case ("candy"):
		{
			["candy",-(_totalPrice)] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_BOUGHTITEMCANDY",_itemName,_totalPrice,(["candy"] call A3PL_Inventory_Return),_amount],Color_Green] call A3PL_Player_Notification; //System: You bought %4 %1(s) for %2 candy, you have %3 candy remaining
		};
		case default
		{
			player setVariable [_currency,(player getVariable [_currency,0]) - _totalPrice,true];
			[format [localize "STR_SHOP_BOUGHITEMCASH",_itemName,_totalPrice,(player getVariable [_currency,0]),_amount],Color_Green] call A3PL_Player_Notification; //System: You bought %4 %1(s) for $%2, you have $%3 remaining
		};
	};

	//refresh
	[_shop,_index] spawn A3RL_UHAUL_ItemSwitch;
	[getPlayerUID player,"UHaulRent",[_itemName,_amount], player getVariable "name"] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;


["A3RL_UHAUL_ItemSwitch",
{
	disableSerialization;
	private ["_display","_shop","_index","_allItems","_allItemsCount","_item","_itemType","_itemClass","_itemName","_ItemBuy","_itemSell","_pos","_posConfig","_itemObjectClass","_weaponHolder"];
	_shop = param [0,""];
	_ctrlID = param [1,1500];
	_shopObject = param [2,cursorobject];

	_display = findDisplay 22;
	_control = _display displayCtrl _ctrlID;
	_allItems = [_shop] call A3PL_Config_GetShop;
	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig == "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig == "OBJECT") then {_pos = getposASL _posConfig;};

	_index = lbCurSel _control;
	_item = _allItems select _index; //array format
	if(_index < 0) exitwith {};
	_itemType = _item select 0; //string containing item type
	_itemClass = _item select 1; //string containing item class
	_itemBuy = _item select 2; //number containing buy price
	_itemSell = _item select 3; //number containing sell price
	_type = "item";
	switch (_itemType) do
	{
		case ("aitem"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("item"):
		{
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
			_itemObjectClass = [_itemClass,"class"] call A3PL_Config_GetItem;
			if (((_itemClass splitString "_") select 0) == "furn") then {_type = "furn";};
		};
		case ("backpack"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("uniform"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("vest"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("headgear"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("vehicle"): { _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "vh"; };
		case ("weapon"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("weaponPrimary"): { _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("magazine"): { _itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
		case ("goggles"): { _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName"); _itemObjectClass = _itemClass; _type = "wh"; };
	};

	_priceBCtrl = _display displayCtrl 1100;
	_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>$%1</t>",_itemBuy];


	if (!isNil "A3PL_SHOP_ITEMPREVIEW") then { deleteVehicle A3PL_SHOP_ITEMPREVIEW; };

	switch (_type) do
	{
		case ("wh"):
		{
			A3PL_SHOP_ITEMPREVIEW = "groundWeaponHolder" createVehicleLocal (getpos Player);
			switch (_itemType) do
			{
				case ("weapon"): {A3PL_SHOP_ITEMPREVIEW addWeaponCargo [_itemClass,1];};
				case ("backpack"): {A3PL_SHOP_ITEMPREVIEW addBackPackCargo [_itemClass,1];};
				case ("magazine"): {A3PL_SHOP_ITEMPREVIEW addMagazineCargo [_itemClass,1];};
				case ("aitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("weaponitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("secweaponitem"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("uniform"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("vest"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("headgear"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
				case ("goggles"): {A3PL_SHOP_ITEMPREVIEW addItemCargo [_itemClass,1];};
			};
		};

		case default
		{
			A3PL_SHOP_ITEMPREVIEW = _itemObjectClass createVehicleLocal [_pos select 0,_pos select 1,(_pos select 2)+0.9];
			A3PL_SHOP_ITEMPREVIEW allowDamage false;
		};
	};

	A3PL_SHOP_ITEMPREVIEW enableSimulation false;

	switch (_itemClass) do
	{
		case ("A3PL_Jaws"): { A3PL_SHOP_ITEMPREVIEW setposATL [_pos select 0,_pos select 1,(_pos select 2)+1.2]; };
		case default { A3PL_SHOP_ITEMPREVIEW setposATL [_pos select 0,_pos select 1,(_pos select 2)+0.9]; };
	};
	if (typeName _posConfig == "OBJECT") then { A3PL_SHOP_ITEMPREVIEW setDir (getDir _posConfig); };

	//set camera position
	switch (_type) do
	{
		case ("vh"):
		{
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [6,7,0.3];
			A3PL_SHOP_CAMERA camCommit 0;
		};
		case default
		{
			A3PL_SHOP_ITEMPREVIEW enableSimulation false;
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [-0.9,0.15,0.3];
			A3PL_SHOP_CAMERA camCommit 0;
		};

		case ("furn"):
		{
			A3PL_SHOP_ITEMPREVIEW enableSimulation false;
			A3PL_SHOP_CAMERA camSetTarget A3PL_SHOP_ITEMPREVIEW;
			A3PL_SHOP_CAMERA camSetRelPos [2,3,1];
			A3PL_SHOP_CAMERA camCommit 0;
		};
	};
}] call Server_Setup_Compile;