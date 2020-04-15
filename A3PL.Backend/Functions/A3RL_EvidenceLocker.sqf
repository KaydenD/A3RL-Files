["A3RL_EvidenceLocker_Lockpick", {
	private["_locker"];
	_locker = cursorObject;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(!(_locker getVariable["locked", true])) exitWith {["The evidence locker is not locked!", Color_Red] call A3PL_Player_Notification;};
	//if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 Marshals on-duty to rob the evidence locker ", Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick the break into the evidence locker", Color_Red] call A3PL_Player_Notification;};
	if(_locker getVariable["robbing", false]) exitWith {["The evidence locker is already being robbed!", Color_Red] call A3PL_Player_Notification;};
	
	_locker setVariable["robbing", true, true];
	
	//Alarm
	["usms", "!!! ALERT !!! The evidence locker is being robbed!"] spawn A3RL_Notify_Robbery;
	_prison = nearestObject [player, "Land_A3PL_Prison"];
	playSound3D ["A3PL_Common\effects\lockdown.ogg", _prison];
	
	Player_ActionCompleted = false;
	["Attempting to lockpick evidence locker...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	uiSleep 0.5;
	while{!Player_ActionCompleted} do
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player};
		if (player getVariable ["Incapacitated",false]) exitwith {};
		if (!alive player) exitWith {};
		player switchMove ""; 
        player playMoveNow "Acts_carFixingWheel";  
	};
	player switchMove ""; 
	
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	
	["v_lockpick",1] call A3PL_Inventory_Remove;
	_locker setVariable["locked", false, true];
	_locker setVariable["robbing", false, true];
	
	["You have successful broke into the evidence locker! It's now open", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_EvidenceLocker_Secure", {
	private["_locker"];
	_locker = cursorObject;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	Player_ActionCompleted = false;
	["Securing evidence locker...",30] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	uiSleep 0.5;
	while{!Player_ActionCompleted} do
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",true] || !alive player};
		if (player getVariable ["Incapacitated",true]) exitwith {};
		if (!alive player) exitWith {};
		player switchMove ""; 
        player playMoveNow "Acts_carFixingWheel";  
	};
	player switchMove ""; 
	
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	
	_locker setVariable["locked", true, true];
}] call Server_Setup_Compile;

["A3RL_EvidenceLocker_Open",
{
	disableSerialization;
	private ["_display","_control"];
	if (isNull Evidence_Locker) exitwith {["System: The evidence locker is not available"] call A3PL_Player_Notification;};

	//make sure not two people access at same time
	if (Evidence_Locker getVariable ["inuse",false]) exitwith {["System: The box is already open",Color_Red] call A3PL_Player_Notification;};
	Evidence_Locker setVariable ["inuse",true,true];

	//create dialog
	createDialog "Dialog_HouseVirtual";
	_display = findDisplay 37;

	_control = _display displayCtrl 1600;
	_control ctrlAddeventhandler ["ButtonDown",{[true] call A3RL_EvidenceLocker_VirtualChange;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[false] call A3RL_EvidenceLocker_VirtualChange;}];

	//allow box to be used again
	_display displayAddEventHandler ["unload",{Evidence_Locker setVariable ["inuse",nil,true]; Evidence_Locker = nil;}];

	[_display] call A3RL_EvidenceLocker_VirtualFill;
}] call Server_Setup_Compile;


["A3RL_EvidenceLocker_VirtualFill",{
	private ["_display","_control"];
	_display = param [0,displayNull];

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
	} foreach (Evidence_Locker getVariable ["storage",[]]);
}] call Server_Setup_Compile;


["A3RL_EvidenceLocker_VirtualChange",
{
	disableSerialization;
	private ["_index","_display","_control","_storage","_inventory","_index","_itemClass","_itemAmount"];
	_add = param [0,true];
	_display = findDisplay 37;
	if (_add) then { _control = _display displayCtrl 1500;} else {_control = _display displayCtrl 1501;};
	if (isNull Evidence_Locker) exitwith {["System: The storage box is not available (_box is null)"] call A3PL_Player_Notification;};

	_storage = Evidence_Locker getVariable ["storage",[]];
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

		Evidence_Locker setVariable ["storage",([_storage, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		[] call A3PL_Inventory_Verify;
	} else
	{
		_itemClass = (_storage select _index) select 0;

		//figure out the amount we need to add
		_itemAmount = parseNumber (ctrlText 1401);
		if (_itemAmount < 1) exitwith {["System: Please enter a valid number",Color_Red] call A3PL_Player_Notification;};
		if (_itemAmount > ((_storage select _index) select 1)) exitwith {["System: You don't have this amount",Color_Red] call A3PL_Player_Notification;};

		Evidence_Locker setVariable ["storage",([_storage, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		[Evidence_Locker] call A3RL_EvidenceLocker_VirtualVerify;
	};

	[_display] call A3RL_EvidenceLocker_VirtualFill;
}] call Server_Setup_Compile;

["A3RL_EvidenceLocker_VirtualVerify", {
	private ["_index", "_forEachIndex","_change"];
	_change = false;

	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(Evidence_Locker getVariable "storage") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (Evidence_Locker getVariable "storage");

	if (_change) then
	{
		Evidence_Locker setVariable ["storage", ((Evidence_Locker getVariable "storage") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;