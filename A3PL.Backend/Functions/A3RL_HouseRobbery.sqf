 ["A3RL_HouseRobbery_Rob", {
	_house = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick to break into the house", Color_Red] call A3PL_Player_Notification;};
	//if ((count (["police"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 police officers on-duty to rob a house", Color_Red] call A3PL_Player_Notification;}; 
	if(_house getVariable ["robbing", false]) exitWith {["The house is already being robbed", Color_Red] call A3PL_Player_Notification;};

	_alarm = false;
	_random = random 100;
	if(_random < 5) then {
		_alarm = true;
		[_house] call A3RL_HouseRobbery_Alarm;
	};

	Player_ActionCompleted = false;
	["Lockpicking house door...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  

	uiSleep 2.0;
	while{!Player_ActionCompleted} do 
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player || !(vehicle player == player)};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionCanceled = true;};
		if (!alive player) exitWith {Player_ActionCanceled = true;};
		if (!(vehicle player == player)) exitWith {Player_ActionCanceled = true;};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	if (!(vehicle player == player)) exitWith {};

	["v_lockpick",1] call A3PL_Inventory_Remove;

	if(!_alarm) then { [_house] call A3RL_HouseRobbery_Alarm; };

	_random = random 100;
	if(_random > 70) exitWith { ["Your lockpick broke", Color_Red] call A3PL_Player_Notification; };

	_house setVariable ["unlocked", true, true];
	["You have successful broke into the house", Color_Green] call A3PL_Player_Notification;

	[_house] call A3RL_HouseRobbery_Reward; 
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Alarm", {
	_house = param[0, objNull];

	["police", format ["A house is being robbed! Check your gps for a location", _name]] spawn A3RL_Notify_Robbery;
	_cops = ["police"] call A3PL_Lib_FactionPlayers;

	[_house] remoteExec ["A3RL_HouseRobbery_Marker", _cops];
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Marker",
{
	private ["_house"];
	_house = param [0,objNull];
	
	//create marker
	_marker = createMarkerLocal [format ["house_robbery_%1",round (random 1000)],_house];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal "Alarm Triggered!";
	
	//wait 30 seconds and delete marker
	uiSleep 30;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Reward", {
	private ["_house"];
	_house = param [0,objNull];

	_box = createVehicle ["Land_MetalCase_01_large_F", [(getpos _house select 0),(getpos _house select 1),1], [], 0, "CAN_COLLIDE"];

	_storage = [];
	{
		_chance = random 100;
		if((_x select 6) > _chance) then {
			if(_x select 7 == "virtual") then {
				_class = _x select 0;
				_amountMin = _x select 1;
				_amountMax = _x select 2;
				_amount = round(random[_amountMin,_amountMin + ((_amountMax - _amountMin)/2),_amountMax]);
				_storage pushBack [_class, _amount];
			} else {
				_class = _x select 0;
				_amountMin = _x select 1;
				_amountMax = _x select 2;
				_amount = round(random[_amountMin,_amountMin + ((_amountMax - _amountMin)/2),_amountMax]);
				_box addItemCargoGlobal[_class,_amount];
			};
		};
	} forEach Config_HouseRobbery;
	_box setVariable ["storage", _storage, true];

	uiSleep 300;
	deleteVehicle _box;
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Secure", {
	_house = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	Player_ActionCompleted = false;
	["Securing house door...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  

	uiSleep 2.0;
	while{!Player_ActionCompleted} do 
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player || !(vehicle player == player)};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionCanceled = true;};
		if (!alive player) exitWith {Player_ActionCanceled = true;};
		if (!(vehicle player == player)) exitWith {Player_ActionCanceled = true;};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	if (!(vehicle player == player)) exitWith {};

	_house setVariable ["unlocked", false, true];
	["The door has been secured", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_HouseRob_Open",
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
	_control ctrlAddeventhandler ["ButtonDown",{[true, player getVariable ["objInUse", objNull]] call A3RL_HouseRob_VirtualChange;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[false, player getVariable ["objInUse", objNull]] call A3RL_HouseRob_VirtualChange;}];

	//allow box to be used again
	_display displayAddEventHandler ["unload",{(player getVariable ["objInUse", objNull]) setVariable ["inuse",nil,true]; player setVariable ["objInUse", nil];}];

	[_display, _obj] call A3RL_HouseRob_VirtualFill;
}] call Server_Setup_Compile;

["A3RL_HouseRob_VirtualFill",{
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

["A3RL_HouseRob_VirtualChange",
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
		[_obj] call A3RL_HouseRob_VirtualVerify;
	};

	[_display, _obj] call A3RL_HouseRob_VirtualFill;
}] call Server_Setup_Compile;

["A3RL_HouseRob_VirtualVerify", {
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