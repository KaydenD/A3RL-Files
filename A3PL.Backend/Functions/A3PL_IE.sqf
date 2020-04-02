["A3PL_IE_Open",
{
	disableSerialization;
	private ["_control","_display"];
	createDialog "Dialog_IE";
	_display = findDisplay 48;
	_control = _display displayCtrl 1500;
	
	//add EH to items list
	_control ctrlAddEventHandler ["LBSelChanged",{_this call A3PL_IE_LbChanged;}];
	
	//import/import EH
	(_display displayCtrl 1600) ctrlAddEventHandler ["ButtonDown",{[true] call A3PL_IE_addShipment;}]; //import button
	(_display displayCtrl 1601) ctrlAddEventHandler ["ButtonDown",{[false] call A3PL_IE_addShipment;}]; //export button
	
	//retrieve EH
	(_display displayCtrl 1603) ctrlAddEventHandler ["ButtonDown",{[] call A3PL_IE_collectShipment;}];

	//Close EH
	_display displayAddEventHandler ["unload", {A3PL_IE_PriceArray = nil;}];
	
	//EH for amount
	_control = _display displayCtrl 1402;
	_control ctrlAddEventHandler ["KeyUp",
	{
		[] call A3PL_IE_UpdateTotal;
	}];
	
	//Refresh shipments
	[] call A3PL_IE_RefreshShipments;
}] call Server_Setup_Compile;

["A3PL_IE_UpdateTotal",
{
	disableSerialization;
	private ["_display","_control","_amount"];
	_display = findDisplay 48;
	_control = _display displayCtrl 1402;
	_amount = parseNumber (ctrlText _control);
	_control = _display displayCtrl 1403;
	
	if (isNil "A3PL_IE_PriceArray") exitwith {}; //exits for invalid vars
	if (_amount < 1) exitwith {_control ctrlSetText "$0/$0"};
	
	_importPrice = A3PL_IE_PriceArray select 1; //get the prices
	_exportPrice = A3PL_IE_PriceArray select 2;	

	_control ctrlSetText (format ["$%1/$%2",_amount*_importPrice,_amount*_exportPrice]); //set the edit box value
}] call Server_Setup_Compile;

["A3PL_IE_LbChanged",
{
	disableSerialization;
	private ["_control","_display","_LBIndex","_LBControl","_priceArray","_importPrice","_exportPrice"];
	_LBControl = param [0,displayNull];
	_LBIndex = param [1,0];
	_display = findDisplay 48;
	
	//get the price from array
	{
		if ((_x select 0) == (_LBControl lbData _LBIndex)) exitwith {A3PL_IE_PriceArray = _x;};
	} foreach Server_IE_Prices;
	if (isNil "A3PL_IE_PriceArray") exitwith {["System: Error getting IE_PriceArray in IE_LBChanged",Color_Red] call A3PL_Player_notification;};
	
	//set the prices
	_importPrice = A3PL_IE_PriceArray select 1;
	_exportPrice = A3PL_IE_PriceArray select 2;
	_control = _display displayCtrl 1400;
	_control ctrlSetText format ["$%1",_importPrice];
	_control = _display displayCtrl 1401;
	_control ctrlSetText format ["$%1",_exportPrice];	
	
	[] call A3PL_IE_UpdateTotal; //update the total edit box
}] call Server_Setup_Compile;

["A3PL_IE_RefreshShipments",
{
	disableSerialization;
	private ["_control","_display","_deletedItem","_deletedAmount","_amount"];
	_display = findDisplay 48;
	_control = _display displayCtrl 1501;
	_deletedItem = param [0,objNull]; //Delete a deleted item from the near list
	_deletedAmount = param [1,0]; //the amount of the deleted item
	
	
	lbClear _control;
	{
		_itemName = [(_x select 0),"name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_status = _x select 2;
		
		if (_status) then
		{
			_index = _control lbAdd format ["%1x %2 (Arrived)",_amount,_itemName];
			_control lbSetData [_index,"import"];
		} else
		{
			_index = _control lbAdd format ["%1x %2 (Arriving on next ship)",_amount,_itemName];
			_control lbSetData [_index,"import"];
		};
	} foreach (player getVariable ["player_importing",[]]);
	
	{
		_itemName = [(_x select 0),"name"] call A3PL_Config_GetItem ;
		_amount = _x select 1;
		_status = _x select 2;
		
		if (isNil "Server_IE_ShipOutbound") then
		{
			_index = _control lbAdd format ["%1x %2 (Exporting on next ship)",_amount,_itemName];
			_control lbSetData [_index,"export"];
		} else
		{
			_index = _control lbAdd format ["%1x %2 (Exporting)",_amount,_itemName];
			_control lbSetData [_index,"export"];
		};
	} foreach (player getVariable ["player_exporting",[]]);	
	
	//refresh items list
	_control = _display displayCtrl 1500;
	
	//fill items list
	lbClear _control;
	{
		private ["_item","_index","_objects","_amount"];
		_item = _x select 0;
		if ([_item,"canPickup"] call A3PL_Config_GetItem) then
		{
			_amount = [_item] call A3PL_Inventory_Return;
			if (typeName _deletedItem == "STRING") then 
			{
				if (_item == _deletedItem) then
				{
					_amount = _amount - _deletedAmount;
				};
			};
			_index = _control lbAdd (format ["%1 (Inventory: %2x)",[_item,"name"] call A3PL_Config_GetItem,_amount]);
		} else
		{
			_objects = nearestObjects [player,[([_item,"class"] call A3PL_Config_GetItem)],10,true];
			_objects = _objects - [_deletedItem];
			_index = _control lbAdd (format ["%1 (Near: %2x)",[_item,"name"] call A3PL_Config_GetItem,count _objects]);
		};
		_control lbSetData [_index,_item];
	} foreach Server_IE_Prices;	
}] call Server_Setup_Compile;

["A3PL_IE_AddShipment",
{
	disableSerialization;
	private ["_control","_display","_import","_item","_importPrice","_exportPrice","_amount","_itemCheck","_objectItem"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	_display = findDisplay 48;
	_import = param [0,true]; //whether we are importing or exporting
	
	//update the pricearray just in-case
	_control = _display displayCtrl 1500;	
	{
		if ((_x select 0) == (_control lbData (lbCurSel _control))) exitwith {A3PL_IE_PriceArray = _x;};
	} foreach Server_IE_Prices;	
	
	//get the item we are importing or exporting
	_item = A3PL_IE_PriceArray select 0;
	_itemName = [_item,"name"] call A3PL_Config_GetItem;
	_importPrice = A3PL_IE_PriceArray select 1;
	_exportPrice = A3PL_IE_PriceArray select 2;
	_amount = parseNumber (ctrlText (_display displayCtrl 1402));
	if (_amount <= 0) exitwith {["System: Please enter a valid number",Color_Red] call A3PL_Player_notification;};
	
	if (_import) then //if importing
	{
		//check if ship is on the way already
		if (!isNil "Server_IE_ShipImbound") exitwith {["System: You can't order shipments while the container ship is on the way, please wait a bit",Color_Red] call A3PL_Player_notification;};
		//check enough cash
		_totalPrice = _importPrice * _amount;
		if (_totalPrice > (player getVariable ["player_cash",0])) exitwith {[format ["System: You don't have enough money to import %1 %2 for $%3",_amount,_itemName,_totalPrice]] call A3PL_Player_notification;};
		//take cash
		player setVariable ["player_cash",(player getVariable ["player_cash",0]) - _totalPrice,true];
		//add to a variable
		player setVariable ["player_importing",(player getVariable ["player_importing",[]]) + [[_item,_amount,false]],true];
		//give message
		[format ["System: You added an import shipment, you paid: $%3 for %1 %2",_amount,_itemName,_totalPrice],Color_Green] call A3PL_Player_notification;
	} else //if exporting
	{
		//check if ship is exiting already
		if (!isNil "Server_IE_ShipOutbound") exitwith {["System: You can't order shipments while the container ship left already, please wait a bit",Color_Red] call A3PL_Player_notification;};
		//check amount
		_itemCheck = false;
		if ([_item,"canPickup"] call A3PL_Config_GetItem) then
		{
			if ([_item,_amount] call A3PL_Inventory_Has) exitwith {_itemCheck = true;};
		} else
		{
			private ["_class","_objects"];
			_amount = 1; //reset the amount to 1
			_class = [_item,"class"] call A3PL_Config_GetItem;
			_objects = nearestObjects [player,[_class],10,true];
			if (count _objects == 0) exitwith {};
			{
				if ((local _x) && ((_x getVariable ["class",""]) == _item)) exitwith {_itemCheck = true; _objectItem = _x;};
			} foreach _objects;
		};
		if (!_itemCheck) exitwith {["System: You don't have this amount of this item to export"] call A3PL_Player_notification;};
		
		//take items
		if (isNil "_objectItem") then //if its an inventory item
		{
			[_item,-(_amount)] call A3PL_Inventory_Add;
		} else //if it's a physical object
		{
			deleteVehicle _objectItem;
		};
		//add to a variable
		player setVariable ["player_exporting",(player getVariable ["player_exporting",[]]) + [[_item,_amount,false,(_exportPrice * _amount)]],true];
		//give message
		[format ["System: You added an export shipment (%2x %3), you will get paid $%1 when the ship has left the waters of Fishers Island",(_exportPrice * _amount),_amount,[_item,"name"] call A3PL_Config_GetItem],Color_Green] call A3PL_Player_notification;		
	};
	
	if (_import) then
	{
		[] call A3PL_IE_RefreshShipments;
	} else
	{
		if (!_itemCheck) exitwith {};
		if (isNil "_objectItem") then { [_item,_amount] call A3PL_IE_RefreshShipments; } else {[_objectItem,1] call A3PL_IE_RefreshShipments;}; //refresh shipments, but exclude the removed item from it
	};
}] call Server_Setup_Compile;

["A3PL_IE_collectShipment",
{
	disableSerialization;
	private ["_display","_control","_index","_lbIndex"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	_display = findDisplay 48;
	_control = _display displayCtrl 1501;
	
	_lbIndex = lbCurSel _control;
	if (_lbIndex < 0) exitwith {["System: You don't have a shipment selected"] call A3PL_Player_notification;};
	if ((_control lbData _lbIndex) == "import") then
	{
		private ["_importArray","_currentItemArray","_item","_arrived","_amount"];
		_importArray = player getVariable ["player_importing",[]];
		_currentItemArray = _importArray select _lbIndex;
		_item = _currentItemArray select 0;
		_amount = _currentItemArray select 1;
		_arrived = _currentItemArray select 2;
		
		//check if item arrived
		if (!_arrived) exitwith {["System: This shipment has not arrived yet",Color_Red] call A3PL_Player_Notification;};
		 
		//remove from player_importing array
		[] call A3PL_IE_RefreshShipments;
		 
		//handle physical items later
		if ([_item,"canPickup"] call A3PL_Config_GetItem) then
		{
			[_item,_amount] call A3PL_Inventory_Add;
			
			_importArray deleteAt _lbIndex;
		} else
		{
			_class = [_item,"class"] call A3PL_Config_GetItem;
			_veh = createVehicle [_class, getposATL player, [], 4, ""];
			_veh setVariable ["class",_item,true];
			_veh setVariable ["owner",(getPlayerUID player),true];
			
			_importItem = _importArray select _lbIndex;
			_currentImportAmount = _importItem select 1;
			if (_currentImportAmount > 1) then
			{
				_importItem set [1,(_currentImportAmount - 1)];
				_importArray set [_lbIndex,_importItem];
				_amount = 1;
			} else
			{
				_importArray deleteAt _lbIndex;
			};
			
		};
		
		//set new array
		player setVariable ["player_importing",_importArray,true];
		[] call A3PL_IE_RefreshShipments;
		
		//msg
		[format ["System: You succesfully collected %1 %2(s)",_amount,([_item,"name"] call A3PL_Config_GetItem)],Color_Green] call A3PL_Player_Notification;
	} else
	{
		["System: Unable to retrieve because this is an export shipment, the money will automatically be transferred to your bank account",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_IE_ShipLost",
{
	["System: The container ship was lost and did not make it into Stoney Creek port on time, all containers arriving will be on the next shipment",Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_IE_ShipArrived",
{
	private ["_importing","_shipment"];
	["Server: The container ship has arrived in the port of Stoney Creek, it will depart again shortly.",Color_Green] call A3PL_Player_notification;
	_importing = player getVariable ["player_importing",[]];
	if (count _importing < 1) exitwith {};
	
	//set the importing array so it can be collected
	_shipment = 1;
	["Server: Your shipments should be located on this ship, the shipment list is as follows:",Color_Green] call A3PL_Player_notification;
	{
		if (!(_x select 2)) then
		{
			private ["_item","_amount"];
			_item = [_x select 0,"name"] call A3PL_Config_GetItem;
			_amount = _x select 1;
			[format ["Server: Shipment #%1 arrived containing %2x %3",_shipment,_amount,_item],Color_Green] call A3PL_Player_notification;
			_shipment = _shipment + 1;
			_importing set [_forEachIndex,[_x select 0,_amount,true]];
		};
	} foreach _importing;
	player setVariable ["player_importing",_importing,true];
}] call Server_Setup_Compile;

["A3PL_IE_ShipLeft",
{
	private ["_exporting","_addMoney"];
	["Server: The container ship has left the waters of Fishers Island, it will return again shortly.",Color_Green] call A3PL_Player_notification;
	_exporting = player getVariable ["player_exporting",[]];
	if (count _exporting < 1) exitwith {};
	
	//add money according to what the player has exported
	_addMoney = 0;
	["Server: Your shipments have been exported, your exported goods are as follows:",Color_Green] call A3PL_Player_notification;
	{
		private ["_item","_itemName","_itemPrice","_amount","_price"];
		_item = _x select 0; //get item
		_itemName = [_item,"name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_price = _x select 3;
		//get item price
		{
			if ((_x select 0) == _item) exitwith {_itemPrice = _x select 2;};
		} foreach Server_IE_Prices;
		//msg
		[format ["Server: Shipment #%1 exported containing %2x %3 - totalling $%4",_forEachIndex,_amount,_itemName,_price],Color_Green] call A3PL_Player_notification;
		_addMoney = _addMoney + _price;
	} foreach _exporting;
	player setVariable ["player_exporting",nil,true];
	player setVariable ["player_bank",(player getVariable ["player_bank",0]) + _addMoney,true];
	[format ["Server: The total of $%1 has been transferred to your bank account",_addMoney],Color_Green] call A3PL_Player_notification;
}] call Server_Setup_Compile;
 
//BELOW DOES NOT WORK UNTIL JONZIE FIXES THE GAME CRASHING WHEN CREATING THE ROPES
["A3PL_IE_CraneGetIn",
{
	private ["_hook","_crane","_rope1","_rope2","_rope3","_craneEH","_connector"];
	_crane = param [0,objNull];
	_crane allowDamage false;
	if (typeOf _crane != "A3PL_MobileCrane") exitwith {["System: Error initializing IE_MobileCraneInit -> Cannot determine crane",Color_Red] call A3PL_Player_notification};	
	
	_hook = createVehicle ["A3PL_Container_Hook", (_crane modelToWorld [-33,-8,0]), [], 0, "CAN_COLLIDE"];
	_connector = "A3PL_FD_HoseEnd1" createVehicle [0,0,0];
	_connector attachTo [_crane, [0, 0, 0], "Cable_1_Start"];	
	_rope1 = ropeCreate [_connector, [0,0,0], _hook, (_hook selectionPosition "Cable_1_End"), 25];
	_rope2 = ropeCreate [_connector, [0,0,0], _hook, (_hook selectionPosition "Cable_2_End"), 25];
	_rope3 = ropeCreate [_connector, [0,0,0], _hook, (_hook selectionPosition "Cable_3_End"), 25];
	
	A3PL_IE_CraneHook = _hook;
	A3PL_IE_CraneConnector = _connector;
	_CraneEH = (FindDisplay 46) DisplayAddEventHandler ["keydown",{_this call A3PL_IE_CraneKeyHandler}];
	//[_crane] call A3PL_IE_CraneLoop;
	waitUntil 
	{
		sleep 1;
		_pos = getpos _crane;
		if ((!(_pos inArea [[3693.044,7625.027,39.260], 43, 7, 52.482, true, 0])) && (!(_pos inArea [[3654.588,7676.509,38.527], 46, 7, 232.025, true, 0]))) then
		{
			[] spawn A3PL_IE_CraneReset;
		};
		vehicle player == player
	};
	(findDisplay 46) displayRemoveEventhandler ["keydown",_CraneEH];
	ropeDestroy _rope1;
	ropeDestroy _rope2;
	ropeDestroy _rope3;
	deleteVehicle _hook;
	deleteVehicle _connector;
}] call Server_Setup_Compile;

//reset crane whenever something bad happends
["A3PL_IE_CraneReset",
{
	private ["_ropes","_crane","_hook","_connector","_rope1","_rope2","_rope3"];
	_crane = param [0,vehicle player];
	//deleteVehicle A3PL_IE_CraneHook;
	//deleteVehicle A3PL_IE_CraneConnector;
	
	//reset crane location
	if (typeOf _crane != "A3PL_MobileCrane") exitwith {["System: Error initializing IE_MobileCraneInit in IE_CraneReset -> Cannot determine crane",Color_Red] call A3PL_Player_notification};
	if ((_crane distance2d [3693.044,7625.027,39.260]) < (_crane distance2d [3654.588,7676.509,38.527])) then //if on right dock
	{
		_crane setDir 52.482;
		_crane setposATL [3693.044,7625.027,39.260];
	} else
	{
		_crane setDir 232.025;
		_crane setposATL [3654.588,7676.509,38.527];
	};
	A3Pl_IE_CraneHook setpos (_crane modelToWorld [-31.3594,-8.99023,-11.6366]);
	uiSleep 0.5;

	//msg
	["System: The crane has been reset",Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//loop that will run that will check the position of the container hook to see if something can be picked up
["A3PL_IE_CranePickup",
{
	private ["_crane","_hook","_ship","_hookPos","_cAnim","_container","_cIndex"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	_crane = param [0,objNull];
	_hook = A3PL_IE_CraneHook; //"spin" is memory point
	_ship = (getpos _hook) nearestObject "A3PL_Container_Ship"; //"c1" to "c72" are memory points for picking up containers
	_hookPos = _hook modelToWorld (_hook selectionPosition "spin");
	
	if ((_hook animationPhase "container") > 0.9) exitwith //detach container
	{
		if ((_hookPos inArea [[3690.18,7623.31,0], 43, 7, 143.098, true, 6]) OR (_hookPos inArea [[3646.97,7671.58,0], 46, 7, 323.149, true, 6])) then
		{
			_hook animate ["container",0];
			//_veh setDir ([(_hook modelToWorld (_hook selectionPosition "Cable_2_End")), (_hook modelToWorld (_hook selectionPosition "Cable_3_End"))] call BIS_fnc_dirTo);
			[] spawn
			{
				["System: You unloaded a container and earned $100",Color_Green] call A3PL_Player_Notification;
				player setVariable ["player_cash",(player getVariable ["player_cash",0]) + 100,true];
			};
		} else
		{
			["System: Please drop the container off on the dock"] call A3PL_Player_Notification;
		};
	};

	//check if ship near
	if (isNull _ship) exitwith {["System: Cannot find a ship nearby to grab a container from"] call A3PL_Player_Notification;};
	
	//check if the hook is anywhere near
	for "_i" from 1 to 72 do
	{
		_cAnim = format ["c%1",_i];
		if ((_hookPos distance (_ship modelToWorld (_ship selectionPosition _cAnim))) < 5) exitwith {_container = _cAnim; _cIndex = _i;};
	};
	if (isNil "_container") exitwith {["System: The hook is not near a container to grab - #1"] call A3PL_Player_Notification;};
	if ((_ship animationSourcePhase _container) < 0.9) exitwith {["System: The hook is not near a container to grab - #2"] call A3PL_Player_Notification;};
	
	_ship animateSource [_container,0];
	_hook animate ["container",1];
	_hook setObjectTextureGlobal [0,(getObjectTextures _ship) select _cIndex];
	["System: You succesfully picked up a container, now drop it off on the dock to get paid",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_IE_CraneKeyHandler",
{
	private ["_return","_key","_ropes","_rope1","_rope2","_rope3","_veh"];
	_key = param [1,0];
	_return = false;
	_veh = vehicle player;
	if (typeOf _veh != "A3PL_MobileCrane") exitwith {false;};
	_ropes = ropes A3PL_IE_CraneConnector;
	_rope1 = _ropes select 0;
	_rope2 = _ropes select 1;
	_rope3 = _ropes select 2;
		
	switch (_key) do
	{
		case 201: //PAGEUP
		{
			_val = _veh animationSourcePhase "Turntable";
			_veh animateSource ["Turntable",(_val + 0.0006)];
			_return = true;
		};
			
		case 209: //PAGEDOWN
		{
			_val = _veh animationSourcePhase "Turntable";
			_veh animateSource ["Turntable",(_val - 0.0006)];
			_return = true;
		};
			
		case 199: //HOME
		{
			_val = _veh animationSourcePhase "Boom";
			_valu = _val + 0.005;
			if (_valu >= 1) then {_valu = 1};
			_veh animateSource ["Boom",_valu];
			_return = true;
		};
			
		case 207: //END
		{
			_val = _veh animationSourcePhase "Boom";
			_valu = _val - 0.005;
			if (_valu <= 0) then {_valu = 0};
			_veh animateSource ["Boom",_valu];
			_return = true;
		};

		case 211: //DELETE
		{
			_val = ropeLength _rope1;
			_valu = _val + 0.06;
			if (_valu >= 50) then {_valu = 50};
			ropeUnwind [_rope1, 30, _valu];
			ropeUnwind [_rope2, 30, _valu];
			ropeUnwind [_rope3, 30, _valu];
			_return = true;
		};
			
		case 210: //INSERT
		{
			_val = ropeLength _rope1;
			_valu = _val - 0.06;
			if (_valu <= 0) then {_valu = 0};
			ropeUnwind [_rope1, 30, _valu];
			ropeUnwind [_rope2, 30, _valu];
			ropeUnwind [_rope3, 30, _valu];
			_return = true;
		};
			
		case 51: //,
		{
			_val = A3PL_IE_CraneHook animationSourcePhase "Spin";
			_valu = _val + 0.006;
			A3PL_IE_CraneHook animateSource ["Spin",_valu];
			_return = true;
		};
			
		case 52: //.
		{
			_val = A3PL_IE_CraneHook animationSourcePhase "Spin";
			_valu = _val - 0.006;
			A3PL_IE_CraneHook animateSource ["Spin",_valu];
			_return = true;
		};
		
		case 57: //space
		{
			[] call A3PL_IE_CranePickup;
		};		
	};
	_return;
}] call Server_Setup_Compile;