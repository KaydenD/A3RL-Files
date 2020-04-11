/* ["A3PL_Shop_Open",
{
	disableSerialization;
	private ["_shop","_display","_currency","_control","_pos","_posConfig","_cam"];
	_shop = param [0,""];
	_currency = param [1,"player_cash"];

	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig == "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig == "OBJECT") then {_pos = getposASL _posConfig;};
	createDialog "Dialog_Shop";
	_display = findDisplay 20;


	_control = _display displayCtrl 1500;
	_control ctrlAddEventHandler ["LBSelChanged",format ["['%1','next'] spawn A3PL_Shop_ItemSwitch;",_shop]];
	_control = _display displayCtrl 1602;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Buy;",_shop,_currency]];
	_control = _display displayCtrl 1603;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Sell;",_shop,_currency]];

	//set slider to half
	_control = _display displayCtrl 1900;
	_control sliderSetRange [-180, 180];
	_control sliderSetPosition 0;
	_control ctrlAddEventHandler ["SliderPosChanged",
	{
		A3PL_SHOP_ITEMPREVIEW setDir (param [1,180]);
	}];

	if(_shop == "Shop_Hemlock") then {
	//disable amount ctrl
		_control = _display displayCtrl 1400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
	};
	//Camera
	A3PL_SHOP_CAMERA = "camera" camCreate [0,0,0];
	A3PL_SHOP_CAMERA camSetPos (positionCameraToWorld [0,0,0]);
	A3PL_SHOP_CAMERA camSetRelPos [0,0,0];
	A3PL_SHOP_CAMERA cameraEffect ["internal", "BACK"];
	A3PL_SHOP_CAMERA camCommit 0;

	A3PL_SHOP_ITEMINDEX = -1;
	[_shop,"next"] spawn A3PL_Shop_ItemSwitch;

	[A3PL_SHOP_CAMERA] spawn
	{
		disableSerialization;
		while {uiSleep 0.2; _display = findDisplay 20; !isNull _display} do {};
		deleteVehicle A3PL_SHOP_ITEMPREVIEW;
		{deleteVehicle _x;} foreach _this;
		A3PL_SHOP_ITEMPREVIEW = nil;
		player cameraEffect ["terminate", "BACK"];
	};
}] call Server_Setup_Compile;

["A3PL_Shop_Buy",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_shop","_currency","_allItems","_price","_item","_itemBuy","_itemType","_itemClass","_itemName","_amount","_totalPrice","_stockCheck","_index"];
	_shop = param [0,""];
	_shopObject = cursorobject;
	_currency = param [1,"player_cash"];
	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;
	_item = _allItems select A3PL_SHOP_ITEMINDEX;
	_index = A3PL_SHOP_ITEMINDEX;
	_itemType = _item select 0; // item type
	_itemClass = _item select 1; // item class
	_itemBuy = _item select 2; //number containing buy price

	//get amount
	_amount = 1;
	if (_itemType IN ["item"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT",Color_Red] call A3PL_Player_Notification;}; //System: Please enter a valid amount

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
		case default
		{
			if ((player getVariable [_currency,0]) >= _totalPrice) then {_moneyCheck = true;} else
			{
				[format [(localize "STR_SHOP_NOTENOUGHMONEY"), (_totalPrice - (player getVariable [_currency,0]))], Color_Red] call A3PL_Player_Notification; //System: You don't have enough money to buy this item
			};
		};
	};
	if (!_moneyCheck) exitwith {};

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
		case ("backpack"): {player addBackPack _itemClass; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("uniform"): {player addUniform _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vest"): {player addVest _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("headgear"): {player addHeadgear _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("aitem"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vehicle"): {[player,[_itemClass,1],"","car"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("plane"): {[player,[_itemClass,1],"","plane"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("weapon"): {
			_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
			if(_itemClass == "A3PL_FireExtinguisher") then {
				player addWeapon _itemClass;
				uiSleep 0.1;
				player addMagazines["A3PL_Extinguisher_Water_Mag", 1];
			} else {
				player addItem _itemClass;
			};
		};
		case ("weaponPrimary"): {player addWeapon _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("magazine"): {player addMagazine _itemClass; _itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");};
		case ("goggles"): {player addGoggles _itemClass; _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName");};
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
	[_shop,_index] spawn A3PL_Shop_ItemSwitch;
		[getPlayerUID player,"buyShop",[_itemName,_amount], player getVariable "name"] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_Sell",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_shop","_has","_allItems","_price","_currency","_item","_itemBuy","_itemSell","_itemType","_itemClass","_itemName","_index","_display","_isAbove"];
	_shop = param [0,""];
	_currency = param [1,"player_cash"];
	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;
	_item = _allItems select A3PL_SHOP_ITEMINDEX;
	_index = A3PL_SHOP_ITEMINDEX;
	_itemType = _item select 0; //item type
	_itemClass = _item select 1; //item class
	_itemSell = _item select 3; //number containing sell price

	//amount
	_amount = 1;
	if (_itemType IN ["item"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT",Color_Red] call A3PL_Player_Notification;}; //System: Please enter a valid amount
	//stop people duping logs
	if(_itemClass == "log" && _amount > 1) exitwith {["System: You can only sell one log at a time!",Color_Red] call A3PL_Player_Notification;};

	//check for above 500
	_isAbove = false;
	if (_shop IN Config_Shops_StockSystem) then
	{
		private ["_stockVar","_newStock"];
		_stockVar = cursorobject getVariable ["stock",[]];
		_newStock = (_stockVar select _index)+_amount;
		if (_newStock > 500) then {_isAbove = true;};
	};
	if (_isAbove) exitwith
	{
		["System: Unable to sell this quanitity of item because the shop is not buying anymore stock of this item! (max stock 500)",Color_Red] call A3PL_Player_Notification;
	};

	//some items we can't sell so we exclude them
	if (_itemClass == "bucket_full") exitwith {[localize "STR_SHOP_SELLBUCKET",Color_Red] call A3PL_Player_Notification;}; //System: Unfortunately this vendor is not looking to buy buckets of fish! but you can process them into raw fish at the food factory!
	if (_itemClass == "net") exitwith {[localize "STR_SHOP_SELLNETS",Color_Red] call A3PL_Player_Notification;}; //System: Unfortunately this vendor is not looking to buy nets!
	if (_itemClass == "bucket_empty") exitwith {[localize "STR_SHOP_SELLEMPTYBUCKETS",Color_Red] call A3PL_Player_Notification;};

	//check if we have item and take it from the player
	_itemName = "UNKNOWN";
	_has = false;
	switch (_itemType) do
	{
		case ("item"):
		{
			if ([_itemClass,_amount] call A3PL_Inventory_Has) then
			{
				[_itemClass,-(_amount)] call A3PL_Inventory_Add;
				_has = true;
			} else
			{
				//check if it's a phyiscal item
				if (!([_itemClass,"canPickup"] call A3PL_Config_GetItem)) then
				{
					_near = nearestObjects [player, [([_itemClass,"class"] call A3PL_Config_GetItem)], 5, true];
					{
						if ((_x getVariable "class") == _itemClass) exitwith
						{
							deleteVehicle _x;
							_has = true;
						};
					} foreach _near;
				};
			};
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
		};

		case ("backpack"):
		{
			if (backpack player == _itemClass) then
			{
				removeBackpack player;
				_itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");
				_has = true;
			};
		};

		case ("vehicle"):
		{
			private ["_vehicles","_vehicle"];
			//look for this nearby vehicle
			_vehicles = nearestObjects [player,[_itemClass],15];
			_vehicle = objNull;
			if (count _vehicles < 1) exitwith {["System: Cannot find your vehicle nearby! Please move it closer to the shop to sell!"] call A3PL_Player_Notification;};
			{
				if (((_x getVariable ["owner",[]]) select 0) == (getPlayerUID player)) exitwith {_vehicle = _x;};
			} foreach _vehicles;
			if (isNull _vehicle) exitwith {["System: Cannot find your vehicle nearby! Please move it closer to the shop to sell! (Only the owner of the vehicle can sell it)"] call A3PL_Player_Notification;};
			[_vehicle] remoteExec ["Server_Vehicle_Sell",2]; //don't forget to add to allowed remotexec later
			_has = true;
		};

		case ("weapon"):
		{
			if (_itemClass IN (weapons player)) then
			{
				player removeItem _itemClass;
				_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
				_has = true;

			};
		};

		case ("magazine"):
		{
			if (_itemClass IN (magazines player)) exitwith
			{
				player removeMagazine _itemClass;
				_has = true;
			};
		};

	};

	//if we don't have this item
	if (!_has) exitwith {[localize "STR_SHOP_DONTHAVEITEM",Color_Red] call A3PL_Player_Notification;}; //System: You don't have this item to sell

	//add to stock if we have the item(and it was taken) and it is a stock shop
	if (_shop IN Config_Shops_StockSystem) then
	{
		[cursorobject,_index,_amount] call A3PL_ShopStock_Add;
	};


	switch (_currency) do
	{
		case ("candy"):
		{
			["candy",_itemSell] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_SOLDITEMCANDY",_itemName,_itemSell,(["candy"] call A3PL_Inventory_Return)],Color_Green] call A3PL_Player_Notification; //System: You sold 1 %1 for %2 candy, you now have %3 candy
		};
		case default
		{
			player setVariable [_currency,(player getVariable [_currency,0]) + (_itemSell*_amount),true];
			[format [localize "STR_SHOP_SOLDITEM",_itemName,(_itemSell*_amount),(player getVariable [_currency,0]),_amount],Color_Green] call A3PL_Player_Notification; //System: You sold 1 %1 for $%2, you have $%3 remaining
		};
	};

	//refresh
	[_shop,_index] spawn A3PL_Shop_ItemSwitch;
	[getPlayerUID player,"sellShop",[_itemName,_amount], player getVariable "name"] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_ItemSwitch",
{
	disableSerialization;
	private ["_display","_shop","_index","_allItems","_allItemsCount","_item","_itemType","_itemClass","_itemName","_ItemBuy","_itemSell","_pos","_posConfig","_itemObjectClass","_weaponHolder"];
	_shop = param [0,""];
	_index = param [1,""];
	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;
	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig == "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig == "OBJECT") then {_pos = getposASL _posConfig;};
	_allItemsCount = (count _allItems) - 1;

	//figure out the index for the item we need to select
	if (typeName _index == "STRING") then
	{
		if (_index == "next") exitwith
		{
			_index = A3PL_SHOP_ITEMINDEX + 1;
			if (_index > _allItemsCount) then
			{
				_index = 0;
			};
		};
		if (_index == "prev") then
		{
			_index = A3PL_SHOP_ITEMINDEX - 1;
			if (_index < 0) then {_index = _allItemsCount;};
		};
	};

	//set item information
	_item = _allItems select _index; //array format
	_itemType = _item select 0; //string containing item type
	_itemClass = _item select 1; //string containing item class
	_itemBuy = _item select 2; //number containing buy price
	_itemSell = _item select 3; //number containing sell price
	_type = "item"; //if we need to put the preview item into a weaponholder or not
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

	_control = _display displayCtrl 1100;
	if (_shop IN Config_Shops_StockSystem) then
	{
		private ["_shopObject","_stock"];
		_shopObject = cursorobject;
		if (isNull _shopObject) exitwith {["System: Error retrieving stock value, please re-open the shop"] call A3PL_Player_Notification;};
		_stock = (_shopObject getVariable ["stock",[]]) select _index;
		if (isNil "_stock") exitwith {["System: Error retrieving stock value, please re-open the shop"] call A3PL_Player_Notification;};
		_control ctrlSetStructuredText parseText format ["<t align='center'>Item: %1 | Stock: %4<br/>Buy price: $%2<br/>Sell price: $%3</t>",_itemName,_itemBuy,_itemSell,_stock];
	} else
	{
		_control ctrlSetStructuredText parseText format ["<t align='center'>Item: %1 | Stock: Unlimited<br/>Buy price: $%2<br/>Sell price: $%3</t>",_itemName,_itemBuy,_itemSell];
	};

	if (!isNil "A3PL_SHOP_ITEMPREVIEW") then { deleteVehicle A3PL_SHOP_ITEMPREVIEW; sleep 0.05; };

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

	//enable amount if item
	if (_itemType IN ["item"]) then
	{
		//enable ctrls for setting the amount
		_control = _display displayCtrl 1400;
		_control ctrlSetText "1";
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
	} else
	{
		//make sure control is faded
		_control = _display displayCtrl 1400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
	};

	//set new index
	A3PL_SHOP_ITEMINDEX = _index;
}] call Server_Setup_Compile;

/////////////////////////////// NEW SHOP UI - BUG  ///////////////////////////////////////////////////
*/

["A3PL_Shop_Open",
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

	_posConfig = [_shop,"pos"] call A3PL_Config_GetShop;
	if (typeName _posConfig == "CODE") then {_pos = call _posConfig;};
	if (typeName _posConfig == "OBJECT") then {_pos = getposASL _posConfig;};
	createDialog "Dialog_Shop";
	_display = findDisplay 20;

	_control = _display displayCtrl 1602;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Buy;",_shop,_currency]];
	_control = _display displayCtrl 1603;
	_control ctrlAddEventHandler ["ButtonDown",format ["['%1','%2'] call A3PL_Shop_Sell;",_shop,_currency]];
	_control = _display displayCtrl 1500;
	_control ctrlAddEventHandler ["LBSelChanged",format ["['%1',1500, '%2'] call A3PL_Shop_ItemSwitch;",_shop,_npc]];
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
				_objects = nearestObjects [player,[_itemClass],10,true];
				_objects = _objects - [_deletedItem];
				_i = _control lbAdd format ["%1 (Nearby: %2x)",_itemName,(count _objects)];
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

	if(_shop == "Shop_Hemlock") then {
		_control = _display displayCtrl 1400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
	};
	//Camera
	A3PL_SHOP_CAMERA = "camera" camCreate [0,0,0];
	A3PL_SHOP_CAMERA camSetPos (positionCameraToWorld [0,0,0]);
	A3PL_SHOP_CAMERA camSetRelPos [0,0,0];
	A3PL_SHOP_CAMERA cameraEffect ["internal", "BACK"];
	A3PL_SHOP_CAMERA camCommit 0;

	[_shop,1500] spawn A3PL_Shop_ItemSwitch;

	[A3PL_SHOP_CAMERA] spawn
	{
		disableSerialization;
		while {uiSleep 0.2; _display = findDisplay 20; !isNull _display} do {};
		deleteVehicle A3PL_SHOP_ITEMPREVIEW;
		{deleteVehicle _x;} foreach _this;
		A3PL_SHOP_ITEMPREVIEW = nil;
		player cameraEffect ["terminate", "BACK"];
	};
}] call Server_Setup_Compile;

["A3PL_Shop_Buy",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	disableSerialization;
	private ["_display","_control","_shop","_currency","_allItems","_price","_item","_itemBuy","_itemType","_itemClass","_itemName","_amount","_totalPrice","_stockCheck","_index"];
	_shop = param [0,""];
	_shopObject = cursorobject;
	_currency = param [1,"player_cash"];
	_display = findDisplay 20;
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
	if (_itemType IN ["item","magazine"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT",Color_Red] call A3PL_Player_Notification;}; //System: Please enter a valid amount

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
		case ("backpack"): {player addBackPack _itemClass; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("uniform"): {player addUniform _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vest"): {player addVest _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("headgear"): {player addHeadgear _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("aitem"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("vehicle"): {[player,[_itemClass,1],"","car"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("plane"): {[player,[_itemClass,1],"","plane"] remoteExec ["Server_Factory_Create", 2]; _itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");};
		case ("weapon"): {player addItem _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("weaponPrimary"): {player addWeapon _itemClass; _itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");};
		case ("magazine"): {player addMagazines [_itemClass, _amount];_itemName = getText (configFile >> "CfgMagazines" >> _itemClass >> "displayName");};
		case ("goggles"): {player addGoggles _itemClass; _itemName = getText (configFile >> "CfgGlasses" >> _itemClass >> "displayName");};
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
	[_shop,_index] spawn A3PL_Shop_ItemSwitch;
	[getPlayerUID player,"buyShop",[_itemName,_amount], player getVariable "name"] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_Sell",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	disableSerialization;
	private ["_shop","_has","_allItems","_price","_currency","_item","_itemBuy","_itemSell","_itemType","_itemClass","_itemName","_index","_display","_isAbove"];
	_shop = param [0,""];
	_currency = param [1,"player_cash"];
	_display = findDisplay 20;
	_allItems = [_shop] call A3PL_Config_GetShop;

	_control = _display displayCtrl 1500;
	_index = lbCurSel _control;
	if(_index < 0) exitwith {};
	_item = _allItems select _index;
	_itemType = _item select 0; //item type
	_itemClass = _item select 1; //item class
	_itemSell = _item select 3; //number containing sell price

	//amount
	_amount = 1;
	if (_itemType IN ["item","magazine"]) then
	{
		_control = _display displayCtrl 1400;
		_amount = parseNumber (ctrlText _control);
	};
	if (_amount < 1) exitwith {[localize "STR_SHOP_ENTERVALAMOUNT",Color_Red] call A3PL_Player_Notification;}; //System: Please enter a valid amount
	//stop people duping logs
	if(_itemClass == "log" && _amount > 1) exitwith {["System: You can only sell one log at a time!",Color_Red] call A3PL_Player_Notification;};

	//check for above 500
	_isAbove = false;
	if (_shop IN Config_Shops_StockSystem) then
	{
		private ["_stockVar","_newStock"];
		_stockVar = cursorobject getVariable ["stock",[]];
		_newStock = (_stockVar select _index)+_amount;
		if (_newStock > 500) then {_isAbove = true;};
	};
	if (_isAbove) exitwith
	{
		["System: Unable to sell this quanitity of item because the shop is not buying anymore stock of this item! (max stock 500)",Color_Red] call A3PL_Player_Notification;
	};

	//some items we can't sell so we exclude them
	//if (_itemClass == "bucket_full") exitwith {[localize "STR_SHOP_SELLBUCKET",Color_Red] call A3PL_Player_Notification;}; //System: Unfortunately this vendor is not looking to buy buckets of fish! but you can process them into raw fish at the food factory!
	if (_itemClass == "net") exitwith {[localize "STR_SHOP_SELLNETS",Color_Red] call A3PL_Player_Notification;}; //System: Unfortunately this vendor is not looking to buy nets!
	if (_itemClass == "bucket_empty") exitwith {[localize "STR_SHOP_SELLEMPTYBUCKETS",Color_Red] call A3PL_Player_Notification;};

	//check if we have item and take it from the player
	_itemName = "UNKNOWN";
	_has = false;
	switch (_itemType) do
	{
		case ("item"):
		{
			if ([_itemClass,_amount] call A3PL_Inventory_Has) then
			{
				[_itemClass,-(_amount)] call A3PL_Inventory_Add;
				_has = true;
			} else
			{
				//check if it's a phyiscal item
				if (!([_itemClass,"canPickup"] call A3PL_Config_GetItem)) then
				{
					_near = nearestObjects [player, [([_itemClass,"class"] call A3PL_Config_GetItem)], 5, true];
					{
						if ((_x getVariable "class") == _itemClass) exitwith
						{
							deleteVehicle _x;
							_has = true;
						};
					} foreach _near;
				};
			};
			_itemName = [_itemClass,"name"] call A3PL_Config_GetItem;
		};

		case ("backpack"):
		{
			if (backpack player == _itemClass) then
			{
				removeBackpack player;
				_itemName = getText (configFile >> "CfgVehicles" >> _itemClass >> "displayName");
				_has = true;
			};
		};

		case ("vehicle"):
		{
			private ["_vehicles","_vehicle"];
			//look for this nearby vehicle
			_vehicles = nearestObjects [player,["Car","Tank","Air","Plane","Ship"],15];
			_vehicle = objNull;
			if (count _vehicles < 1) exitwith {["System: Cannot find your vehicle nearby! Please move it closer to the shop to sell!"] call A3PL_Player_Notification;};
			{
				if (((_x getVariable ["owner",[]]) select 0) == (getPlayerUID player) && (typeOf _x) == _itemClass) exitwith {
					_vehicle = _x;
				};
			} foreach _vehicles;
			if (isNull _vehicle) exitwith {["System: Cannot find your vehicle nearby! Please move it closer to the shop to sell! (Only the owner of the vehicle can sell it)"] call A3PL_Player_Notification;};
			[_vehicle] remoteExec ["Server_Vehicle_Sell",2];
			_itemName = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			_has = true;
		};

		case ("weapon"):
		{
			if (_itemClass IN (weapons player)) then
			{
				if(_itemClass isEqualTo (secondaryWeapon player)) then {
					player removeWeapon _itemClass;
				} else {
					player removeItem _itemClass;
				};
				_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
				_has = true;
			};
		};

		case ("weaponPrimary"):
		{
			if (_itemClass IN (weapons player)) then
			{
				_itemName = getText (configFile >> "CfgWeapons" >> _itemClass >> "displayName");
				player removeWeapon _itemClass;
				_has = true;
			};
		};

		case ("magazine"):
		{
			if (_itemClass IN (magazines player)) exitwith
			{
				for "_i" from 0 to _amount do {player removeMagazine _itemClass;};
				_has = true;
			};
		};

	};

	//if we don't have this item
	if (!_has) exitwith {[localize "STR_SHOP_DONTHAVEITEM",Color_Red] call A3PL_Player_Notification;}; //System: You don't have this item to sell

	//add to stock if we have the item(and it was taken) and it is a stock shop
	if (_shop IN Config_Shops_StockSystem) then
	{
		[cursorobject,_index,_amount] call A3PL_ShopStock_Add;
	};

	switch (_currency) do
	{
		case ("candy"):
		{
			["candy",_itemSell] call A3PL_Inventory_Add;
			[format [localize "STR_SHOP_SOLDITEMCANDY",_itemName,_itemSell,(["candy"] call A3PL_Inventory_Return)],Color_Green] call A3PL_Player_Notification; //System: You sold 1 %1 for %2 candy, you now have %3 candy
		};
		case default
		{
			player setVariable [_currency,(player getVariable [_currency,0]) + (_itemSell*_amount),true];
			[format [localize "STR_SHOP_SOLDITEM",_itemName,(_itemSell*_amount),(player getVariable [_currency,0]),_amount],Color_Green] call A3PL_Player_Notification; //System: You sold 1 %1 for $%2, you have $%3 remaining
		};
	};

	//refresh
	[_shop,1500] spawn A3PL_Shop_ItemSwitch;
	[getPlayerUID player,"sellShop",[_item,_amount], player getVariable "name"] remoteExec ["Server_Log_New",2];
}] call Server_Setup_Compile;

["A3PL_Shop_ItemSwitch",
{
	disableSerialization;
	private ["_display","_shop","_index","_allItems","_allItemsCount","_item","_itemType","_itemClass","_itemName","_ItemBuy","_itemSell","_pos","_posConfig","_itemObjectClass","_weaponHolder"];
	_shop = param [0,""];
	_ctrlID = param [1,1500];
	_shopObject = param [2,cursorobject];

	_display = findDisplay 20;
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

	_stockCtrl = _display displayCtrl 1102;
	_priceBCtrl = _display displayCtrl 1100;
	_priceSCtrl = _display displayCtrl 1101;
	if (_shop IN Config_Shops_StockSystem) then
	{
		private ["_stockVar","_newStock"];
		_stockVar = cursorobject getVariable ["stock",[]];
		if((count _stockVar) isEqualTo 0) exitwith {closeDialog 0;};
		_stock = (_stockVar select _index);

		_stockCtrl ctrlSetStructuredText parseText format ["<t align='right'>%1</t>",_stock];
		_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>$%1</t>",_itemBuy];
		_priceSCtrl ctrlSetStructuredText parseText format ["<t align='right'>$%1</t>",_itemSell];
	} else
	{
		_stockCtrl ctrlSetStructuredText parseText format ["<t align='right'>Unlimited</t>"];
		_priceBCtrl ctrlSetStructuredText parseText format ["<t align='right'>$%1</t>",_itemBuy];
		_priceSCtrl ctrlSetStructuredText parseText format ["<t align='right'>$%1</t>",_itemSell];
	};

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

	//enable amount if item
	if (_itemType IN ["item","magazine"]) then
	{
		//enable ctrls for setting the amount
		_control = _display displayCtrl 1400;
		_control ctrlSetText "1";
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 0;
		_control ctrlCommit 0;
	} else
	{
		//make sure control is faded
		_control = _display displayCtrl 1400;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
		_control = _display displayCtrl 1000;
		_control ctrlSetFade 1;
		_control ctrlCommit 0;
	};
}] call Server_Setup_Compile;