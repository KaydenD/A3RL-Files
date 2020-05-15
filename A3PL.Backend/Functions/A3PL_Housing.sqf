["A3PL_Housing_VirtualOpen",
{
	disableSerialization;
	private ["_box","_display","_control"];
	_box = param [0,player_objintersect];
	if (isNull _box) exitwith {["System: The storage box is not available (_box is null)"] call A3PL_Player_Notification;};

	//make sure not two people access at same time
	if (_box getVariable ["inuse",false]) exitwith {["System: This storage box is already in-use",Color_Red] call A3PL_Player_Notification;};
	_box setVariable ["inuse",true,true];

	//create dialog
	createDialog "Dialog_HouseVirtual";
	_display = findDisplay 37;

	//EHs
	A3PL_Housing_StorageBox = _box;
	_control = _display displayCtrl 1600;
	_control ctrlAddeventhandler ["ButtonDown",{[true] call A3PL_Housing_VirtualChange;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddeventhandler ["ButtonDown",{[false] call A3PL_Housing_VirtualChange;}];

	//allow box to be used again
	_display displayAddEventHandler ["unload",{A3PL_Housing_StorageBox setVariable ["inuse",nil,true]; A3PL_Housing_StorageBox = nil;}];

	[_display,_box] call A3PL_Housing_VirtualFillLB;
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualFillLB",
{
	private ["_display","_control"];
	_display = param [0,displayNull];
	_box = param [1,objNull];

	//fill lb
	_control = _display displayCtrl 1500;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (player getVariable ["player_inventory",[]]);

	//fill storage box lb
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_item = _x select 0;
		_control lbAdd format ["%1 (x%2)",([_item,"name"] call A3PL_Config_GetItem),_x select 1];
		_control lbSetData [_forEachIndex,_item];
	} foreach (_box getVariable ["storage",[]]);
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualChange",
{
	disableSerialization;
	private ["_index","_display","_control","_storage","_inventory","_index","_itemClass","_itemAmount"];
	_add = param [0,true];
	_display = findDisplay 37;
	if (_add) then { _control = _display displayCtrl 1500;} else {_control = _display displayCtrl 1501;};
	if (isNull A3PL_Housing_StorageBox) exitwith {["System: The storage box is not available (_box is null)"] call A3PL_Player_Notification;};

	_storage = A3PL_Housing_StorageBox getVariable ["storage",[]];
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

		A3PL_Housing_StorageBox setVariable ["storage",([_storage, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		[] call A3PL_Inventory_Verify;
	} else
	{
		_itemClass = (_storage select _index) select 0;

		//figure out the amount we need to add
		_itemAmount = parseNumber (ctrlText 1401);
		if (_itemAmount < 1) exitwith {["System: Please enter a valid number",Color_Red] call A3PL_Player_Notification;};
		if (_itemAmount > ((_storage select _index) select 1)) exitwith {["System: You don't have this amount",Color_Red] call A3PL_Player_Notification;};

		A3PL_Housing_StorageBox setVariable ["storage",([_storage, _itemClass, -(_itemAmount),false] call BIS_fnc_addToPairs),true];
		player setVariable ["player_inventory",([_inventory, _itemClass, _itemAmount,false] call BIS_fnc_addToPairs),true];
		[A3PL_Housing_StorageBox] call A3PL_Housing_VirtualVerify;
	};

	[_display,A3PL_Housing_StorageBox] call A3PL_Housing_VirtualFillLB;
}] call Server_Setup_Compile;

["A3PL_Housing_VirtualVerify", {
	private ["_box", "_index", "_forEachIndex","_change"];

	_box = param [0,objNull];
	_change = false;

	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_box getVariable "storage") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_box getVariable "storage");

	if (_change) then
	{
		_box setVariable ["storage", ((_box getVariable "storage") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;


//This function will return either true or false, it can check if our key matches the lock
["A3PL_Housing_CheckOwn",
{
	private ["_obj","_keyID","_doorID"];

	_obj = param [0,objNull];
	_keyID = param [1,""];
	_return = false;
	_doorID = _obj getVariable "doorID";

	if (typeOf _obj == "Land_A3PL_Motel") then
	{
		_name  = _this select 2;
		_doorID = _obj getVariable "doorID";
		{
			if ((_x select 2) == _name) exitwith
			{
				if (_x select 1 == _keyid) then
				{
					_return = true;
				};
			};
		} foreach _doorID;
	} else
	{
		if (_keyID == (_doorID select 1)) then
		{
			_return = true;
		};
	};
	_return;
}] call Server_Setup_Compile;

//This function will return only the type of keys we need
//argument: house,apt,cars
["A3PL_Housing_keyFilter",
{
	private ["_keys","_filter","_filteredKeys","_nr"];
	_keys = player getVariable "keys";
	_filteredKeys = [];
	_nr = 6;
	_filter = _this select 0;
	switch (_filter) do
	{
		case "house": {_nr = 5;};
		case "apt": {_nr = 4;};
		case "cars": {_nr = 6;};
		default {_nr = 7;};
	};

	{
		if ((count _x) == _nr) then
		{
			_filteredKeys pushback _x;
		};
	} foreach _keys;

	_filteredKeys;

}
] call Server_Setup_Compile;

["A3PL_Housing_PickupKey",
{
	_obj = player_objintersect;
	if (typeOf _obj != "A3PL_HouseKey") exitwith {};
	[[_obj, player], 'Server_Housing_PickupKey', false] call BIS_fnc_MP;
	["System: Send request to server to pick up a key", Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//This will put the key into players hands
["A3PL_Housing_Grabkey",
{
	private ["_keyID","_format"];
	_keyID = lbdata [1900,(lbCurSel 1900)];

	//if we have something in our hand already
	if (!(isNull Player_Item)) then {
		[false] call A3PL_Inventory_PutBack;
	};

	//create item, replace model
	Player_Item = "A3PL_HouseKey" createVehicle (getPos player);

	//attach item to player's hand
	Player_Item attachTo [player, [0,0,1], 'RightHand'];

	//set vars
	Player_ItemClass = "doorkey";
	Player_Item setVariable ["keyID",_keyID,true];

	//Run attachedloop, will drop item when entering vehicle etc.
	[Player_Item] spawn A3PL_Placeable_AttachedLoop;

	closeDialog 0;
	_format = format['You grabbed a key out of your pocket (ID: %1)',_keyID];
	[_format, Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Retrieves the nearest address on marker name (_dist away)
// [2658.42,5627.65,0.0310001] call A3PL_Housing_RetrieveAddress
["A3PL_Housing_RetrieveAddress",
{
	private ["_dist","_distMarker","_marker"];
	//increase this if we want to ever search in a larger radius
	_dist = 15;
	{
		_distMarker = _this distance (getMarkerPos _x);
		if (_distMarker < _dist) then
		{
			_marker = _x;
		};
	} foreach allMapMarkers;
	if (isNil "_marker") exitwith {"House Address Undefined"};
	_markerName = markerText _marker;
	_markerName;
}] call Server_Setup_Compile;

//get the price of a house
["A3PL_Housing_GetPrice",
{
	private ["_price","_house"];
	_house = param [0,objNull];
	_price = 0;
	switch (typeOf _house) do
	{
		case ("Land_Home1g_DED_Home1g_01_F"): {_price = 150000;};
		case ("Land_Home2b_DED_Home2b_01_F"): {_price = 175000;};
		case ("Land_Home3r_DED_Home3r_01_F"): {_price = 250000;};
		case ("Land_Home4w_DED_Home4w_01_F"): {_price = 150000;};
		case ("Land_Home5y_DED_Home5y_01_F"): {_price = 175000;};
		case ("Land_Home6b_DED_Home6b_01_F"): {_price = 250000;};
		case ("Land_Mansion01"): {_price = 400000;};
		case ("Land_A3PL_Ranch1"): {_price = 150000;};
		case ("Land_A3PL_Ranch2"): {_price = 150000;};
		case ("Land_A3PL_Ranch3"): {_price = 150000;};
		case ("Land_A3PL_ModernHouse1"): {_price = 600000;};
		case ("Land_A3PL_ModernHouse2"): {_price = 400000;};
		case ("Land_A3PL_ModernHouse3"): {_price = 800000;};
		case ("Land_A3RL_modernhouse4"): {_price = 600000;};
		case ("Land_A3PL_BostonHouse"): {_price = 50000;};
		case ("Land_A3PL_Shed3"): {_price = 30000;};
		case ("Land_A3PL_Shed4"): {_price = 10000;};
		case ("Land_A3PL_Shed2"): {_price = 15000;};
	};
	_price;
}] call Server_Setup_Compile;

//[player_objIntersect] call A3PL_Housing_OpenBuyMenu;
["A3PL_Housing_OpenBuyMenu",
{
	disableSerialization;
	private ["_display","_control","_obj","_houses","_price"];
	_obj = param [0,objNull];
	if (isNull _obj) exitwith {};
	_houses = nearestObjects [player, ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_modernhouse1", "Land_A3RL_modernhouse4","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2"], 20];
	if (count _houses < 1) exitwith {["System: Can't find house nearby (Inform an admin this house is not working properly)",Color_red] call A3PL_Player_Notification;};
	A3PL_Housing_Object = _houses select 0;

	//set the current real estate price
	_price = [A3PL_Housing_Object] call A3PL_Housing_GetPrice;
 	createDialog "Dialog_HouseBuy";
	_display = findDisplay 72;
	_control = _display displayCtrl 1000;
	_control ctrlSetText format ["$%1",[_price, 1, 2, true] call CBA_fnc_formatNumber];

	//add button eventhandlers
	_control = _display displayCtrl 1600;
	_control buttonSetAction "[] call A3PL_Housing_Buy"; //yes button

	_control = _display displayCtrl 1601;
	_control buttonSetAction "closeDialog 0; A3PL_Housing_Object = nil;";
}] call Server_Setup_Compile;

["A3PL_Housing_Buy",
{
	//check player money
	private ["_price"];
	_price = [A3PL_Housing_Object] call A3PL_Housing_GetPrice;
	if ((player getVariable ["player_bank",0]) < _price) exitwith {["System: You don't have enough money on your bank account to buy this house",Color_Red] call A3PL_Player_Notification;};
	if (!isNil {A3PL_Housing_Object getVariable ["doorid",nil]}) exitwith {["System: This house is already owned",Color_Red] call A3PL_Player_Notification;};
	if (!isNil {player getVariable ["house",nil]}) exitwith {["System: You already own a house",Color_Red] call A3PL_Player_Notification;};

	[A3PL_Housing_Object,player,true,_price] remoteExec ["Server_Housing_AssignHouse", 2];
	closeDialog 0;
	[format ["System: You bought this house for $%1",_price],Color_Green] call A3PL_Player_Notification;
	[A3PL_Housing_Object] spawn
	{
		private ["_house"];
		_house = param [0,objNull];
		sleep 3;
		_marker = createMarkerLocal [format["house_%1",round (random 1000)],visiblePosition _house];
		_marker setMarkerTypeLocal "mil_triangle";
		_marker setMarkerAlphaLocal 0.5;
		_marker setMarkerColorLocal "ColorGreen";
		_marker setMarkerTextLocal (format ["My house - Key ID: %1",((_house getVariable ["doorid",["1","Unknown"]]) select 1)]);
	};
	A3PL_Housing_Object = nil;
}] call Server_Setup_Compile;


//This will set the markers for houses on the map
["A3PL_Housing_Init",
{
	private ["_keys","_doorID","_keyID","_buildings","_marker","_text","_apt","_aptNumber"];
	//if we are in editor
	if (isServer) then {player setVariable ["keys",[],true];};
	//wait 1 second until we receive our keys from the server
	waituntil {sleep 1; _keys = player getVariable "keys"; !isNil "_keys"};
	//change _keys with only house keys
	_keys = ["house"] call A3PL_Housing_keyFilter;
	_buildings = nearestObjects [[10000,10000,0], ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3"], 5000];
	{
		_doorID = _x getVariable "doorID";
		//If this variable exists
		if (!isNil "_doorID") then
		{
			//If the doorID is one of my keys
			if ((_doorID select 1) IN _keys) then
			{
				//_marker is also door/keyid
				_marker = createMarkerLocal [format["house_%1",round (random 1000)],visiblePosition _x];
				_marker setMarkerTypeLocal "mil_triangle";
				_marker setMarkerAlphaLocal 0.5;
				_marker setMarkerColorLocal "ColorGreen";
				_marker setMarkerTextLocal (format ["My house - Key ID: %1",(_doorID select 1)]);
			};
		};
	} foreach _buildings;

	//this will change appartment marker text (in case we own an appartment)
	_apt = param [0,objNull];
	_aptNumber = param [1,-1];
	if ((isNull _apt) OR (_aptNumber == -1)) exitwith {};

	_marker = [_apt] call A3PL_Lib_NearestMarker;
	_marker setMarkerColorLocal "ColorGreen";
	_text = markerText _marker;
	_marker setMarkerTextLocal (format ["%1 (You own room: %2)",_text,_aptNumber]);
}
] call Server_Setup_Compile;

["A3PL_Housing_AptAssignedMsg",
{
	private ["_objAssigned","_aptAssigned","_marker"];
	_objAssigned = param [0,objNull];
	_aptAssigned = param [1,"0"];

	_marker = [_objAssigned] call A3PL_Lib_NearestMarker;
	_marker = markerText _marker;
	[format ["Server: You have been assigned motel room %1 at %2",_aptAssigned,_marker], Color_Green] call A3PL_Player_Notification;
	[_objAssigned,_aptAssigned] call A3PL_Housing_Init;

	[] spawn
	{
		waituntil {sleep 0.1; !isNil {player getVariable "faction"}}; //wait until our faction variable is assigned
		waituntil {sleep 0.1; !isNull (findDisplay 15)}; //wait until loading screen is here
		if ((player getVariable ["faction","citizen"]) == "uscg") then
		{
			waituntil {sleep 0.1; isNull (findDisplay 15)};
			createDialog "Dialog_CGSpawn";
			buttonSetAction [1600,"closeDialog 0; player setpos [2146.33,5015.62,0]"];
			buttonSetAction [1601,"closeDialog 0;"];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Housing_Loaditems",
{
	private ["_house","_pItems","_objects"];
	_house = param [0,objNull];
	_pItems = param [1,[]];
	_objects = [];
	{
		private ["_classname","_class","_pos","_dir","_obj"];
		_classname = _x select 0;
		_class = _x select 1;
		_pos = _house modelToWorld (_x select 2);
		_dir = _x select 3;
		_obj = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
		_obj setDir _dir;
		_obj setPosATL _pos;
		_obj setVariable ["owner",(getPlayerUID player),true];
		_obj setVariable ["class",_class,true];

		if (!([_class,"simulation"] call A3PL_Config_GetItem)) then
		{
			_objects pushback _obj;
		};
	} foreach _pitems;

	sleep 0.5;

	[_objects] remoteExec ["Server_Housing_LoadItemsSimulation", 2];
}] call Server_Setup_Compile;

["A3RL_RoommateInviteOpen",
{
	_owner = param [0,objNull];
	createDialog "Dialog_RoommateInvite";
	buttonSetAction[1600, format["[call compile ""%1""] call A3RL_RoommateAccept;", _owner]];
	buttonSetAction[1601, format["[call compile ""%1""] call A3RL_RoommateDecline;", _owner]];
	buttonSetAction[1602, format["[call compile ""%1""] call A3RL_RoommateDecline;", _owner]];
}] call Server_Setup_Compile;

["A3RL_RoommateAccept",
{
	_owner = param [0,objNull];
	[_owner getVariable ["house", objNull], player] remoteExec ["Server_AddRoommate", 2];
	[format["%1 accepted your roommate invitation", player getVariable "name"], Color_Green] remoteExec ["A3PL_Player_Notification", _owner];
	["Invitation accepted. You have been gived a copy of the keys", Color_Green] call A3PL_Player_Notification;
	closeDialog 1;
}] call Server_Setup_Compile;

["A3RL_RoommateDecline",
{
	_owner = param [0,objNull];
	[format["%1 denied your roommate invitation", player getVariable "name"], Color_Red] remoteExec ["A3PL_Player_Notification", _owner];
	["Invitation Declined.", Color_Red] call A3PL_Player_Notification;
	closeDialog 1;
}] call Server_Setup_Compile;

["A3RL_RemoveRoommate",
{
	_owner = param [0,objNull];
	[_owner getVariable ["house", objNull], player] remoteExec ["Server_RemoveRoommate", 2];
	["Your roommate agreement has been terminated. You keys have been taken", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
