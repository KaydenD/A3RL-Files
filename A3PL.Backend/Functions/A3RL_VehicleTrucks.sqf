["A3RL_VITrunk_Open",
{
	disableSerialization;
	private ["_display","_control","_obj"];
	_obj = param [0,objNull];
	if (isNull _obj) exitwith {["System: The virtual inventory is not available"] call A3PL_Player_Notification;};

	//make sure not two people access at same time
	if (_obj getVariable ["inuse",false]) exitwith {["System: The inventory is already open",Color_Red] call A3PL_Player_Notification;};
	_obj setVariable ["inuse",true,true];
	player setVariable ["objInUse", _obj];

	//create dialog
	createDialog "Dialog_HouseVirtual";
	_display = findDisplay 37;

	_control = _display displayCtrl 1600;
	_control ctrlAddeventhandler ["ButtonDown",{[true, player getVariable ["objInUse", objNull]] call A3RL_Trunk_VirtualChange;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[false, player getVariable ["objInUse", objNull]] call A3RL_Trunk_VirtualChange;}];

	//allow box to be used again
	_display displayAddEventHandler ["unload",{_obj setVariable ["inuse",nil,true]; player setVariable ["objInUse", nil];}];

	[_display, _obj] call A3RL_Trunk_VirtualFill;
}] call Server_Setup_Compile;

["A3RL_Trunk_VirtualFill",{
	private ["_display","_control", "_obj"];
	_display = param [0,displayNull];
	_obj = param [1,objNull];

	//Fill Player side
	_control = _display displayCtrl 1500;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (player getVariable ["player_inventory",[]]);

	//Fill Server side
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (_obj getVariable ["storage",[]]);
}] call Server_Setup_Compile;


["A3RL_Trunk_VirtualChange",
{
	disableSerialization;
	private ["_index","_display","_control","_storage","_inventory","_index","_itemClass","_itemAmount","_obj"];
	_add = param [0,true];
	_obj = param [1,objNull];
	_display = findDisplay 37;
	if (_add) then { _control = _display displayCtrl 1500;} else {_control = _display displayCtrl 1501;};
	if (isNull _obj) exitwith {["System: The storage box is not available (_box is null)"] call A3PL_Player_Notification;};

	_storage = _obj getVariable ["storage",[]];
	_inventory = player getVariable ["player_inventory",[]];
	_index = lbCurSel _control;
	if (_control lbText _index == "") exitwith {["System: You have not selected a valid item in the list",Color_Red] call A3PL_Player_Notification;};

	if (_add) then
	{
		_itemClass = (_inventory select _index) select 0;

		//figure out the amount we need to add
		_itemAmount = parseNumber (ctrlText 1400);
		if (_itemAmount < 1) exitwith {["System: Please enter a valid number",Color_Red] call A3PL_Player_Notification;};
		if (_itemAmount > ((_inventory select _index) select 1)) exitwith {["System: You don't have this amount",Color_Red] call A3PL_Player_Notification;};
		if (([_obj, [_itemClass, _itemAmount]] call A3PL_Trunk_VirtualTotalWeight) > ([typeOf _obj, "maxWeight"] call A3RL_Config_GetMaxTrunkWeight)) exitWith {["System: You doesn't have enough space",Color_Red] call A3PL_Player_Notification;};

		_obj setVariable ["storage",([_storage, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		[] call A3PL_Inventory_Verify;
	} else
	{
		_itemClass = (_storage select _index) select 0;

		//figure out the amount we need to add
		_itemAmount = parseNumber (ctrlText 1401);
		if (_itemAmount < 1) exitwith {["System: Please enter a valid number",Color_Red] call A3PL_Player_Notification;};
		if (_itemAmount > ((_storage select _index) select 1)) exitwith {["System: You don't have this amount",Color_Red] call A3PL_Player_Notification;};
		if (Player_MaxWeight < ([[_itemClass, _itemAmount]] call A3PL_Inventory_TotalWeight)) exitWith {["System: You don't have enough space",Color_Red] call A3PL_Player_Notification;};

		_obj setVariable ["storage",([_storage, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		[_obj] call A3RL_Trunk_VirtualVerify;
	};

	[_display, _obj] call A3RL_Trunk_VirtualFill;
}] call Server_Setup_Compile;

["A3RL_Trunk_VirtualVerify", {
	private ["_index", "_forEachIndex","_change","_obj"];
	_obj = param [0,objNull];
	_change = false;
	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_obj getVariable "storage") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_obj getVariable "storage");

	if (_change) then
	{
		_obj setVariable ["storage", ((_obj getVariable "storage") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;

["A3PL_Trunk_VirtualTotalWeight",
{
	private ["_return","_inventory","_player","_itemToAdd","_obj"];
	_obj = param [0,objNull];
	_itemToAdd = param [1,[]];
	_return = 0;
	_inventory = _obj getVariable ["storage",[]];

	if (count _itemToAdd > 0) then
	{
		{
			_inventory = [_inventory, (_x select 0), (_x select 1), true] call BIS_fnc_addToPairs; //last param set to true to prevent overwriting of original variable
		} foreach _itemToAdd;
	};

	{
		private ["_amount", "_itemWeight"];

		_amount = _x select 1;
		_itemWeight = ([_x select 0, 'weight'] call A3PL_Config_GetItem) * _amount;
		_return = _return + _itemWeight;
	} forEach _inventory;

	_return;
}] call Server_Setup_Compile;