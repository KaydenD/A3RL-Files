//gets the inventory variable
["A3PL_Inventory_Get", {
	private ["_subtract","_fact","_inv","_player"];
	_player = param [0,player]; //player, just in-case we ever want to run this on the server
	_inv = _player getVariable ["player_inventory",[]];
	_inv;
}] call Server_Setup_Compile;

["A3PL_Inventory_GetCash", {
	private ["_player"];
	_player = param [0,player]; //player, just in-case we ever want to run this on the server
	_cash = _player getvariable ["player_cash",0];
	_cash;
}] call Server_Setup_Compile;

//Clear vars
["A3PL_Inventory_Clear",
{
	private ["_obj","_delete"];
	_obj = param [0,Player_Item];
	_delete = param [1,true];
	_setNull = param [2,true];

	if (_delete) then
	{
		deleteVehicle _obj;
	};

	if (_setNull) then
	{
		Player_Item = objNull;
		Player_ItemClass = '';
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Add", {
	private ["_class", "_amount", "_weight", "_totalWeight"];

	_class = param [0,""];
	_amount = param [1,0];
	//_weight = [_class, 'weight'] call A3PL_Config_GetItem;

	[[player, _class, _amount], "Server_Inventory_Add", false] call BIS_fnc_MP;
}] call Server_Setup_Compile;

["A3PL_Inventory_Remove", {
	private ["_class","_amount"];

	_class = param [0,""];
	_amount = param [1,1];

	[_class, -(_amount)] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;

["A3PL_Inventory_Verify", {
	private ["_player", "_index", "_forEachIndex","_change"];

	_player = param [0,player];
	_change = false;

	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_player getVariable "Player_Inventory") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_player getVariable "Player_Inventory");

	if (_change) then
	{
		_player setVariable ["Player_Inventory", ((_player getVariable "Player_Inventory") - ["REMOVE"]), true];
	};
}] call Server_Setup_Compile;

["A3PL_Inventory_Return", { //doesnt seem to be used anywhere, A3PL_Inventory_Get should be used instead as it accounts for items that shouldn't show
	private ["_class", "_amount"];

	_class = param [0,""];
	_player = param [1,player];
	_amount = [(_player getVariable ["Player_Inventory",[]]), _class, 0] call BIS_fnc_getFromPairs;

	_amount;
}] call Server_Setup_Compile;

["A3PL_Inventory_Has", {
	private ["_class","_player","_amount","_inventoryAmount"];

	_class = param [0,""];
	_amount = param [1,1];
	_player = param [2,player];

	if (_class == "cash") exitwith {if (_player getVariable ["player_cash",0] >= _amount) then {true;} else {false;};}; //return whether we have enough money or not instead

	_inventoryAmount = [_class,_player] call A3PL_Inventory_Return;
	if (_inventoryAmount < _amount) exitWith {false};

	true
}] call Server_Setup_Compile;

//calculate total weight in inventory
["A3PL_Inventory_TotalWeight",
{
	private ["_return","_inventory","_player","_itemToAdd"];
	_return = 0;

	_itemToAdd = _this; //this function can take an argument to calculate the totalweight including any items send to this function

	//check for alternative syntax
	if (count _itemToAdd > 1) then
	{
		_player = _itemToAdd select 1;
		_itemToAdd = _itemToAdd select 0;
	} else
	{
		_player = player;
	};

	_inventory = [] call A3PL_Inventory_Get;

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

/*----------------------------------------------------------------------------*/

//Opens inventory menu
["A3PL_Inventory_Open", {
	//play animation
	if((vehicle player == player) && (!(animationState player IN ["crew"]))) then {
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon';
	};

	//open dialog
	['Dialog_Inventory'] call A3PL_Lib_CreateDialog;

	//populate dialog
	[] call A3PL_Inventory_Populate;
}] call Server_Setup_Compile;

//Populates the menu
["A3PL_Inventory_Populate", {
	private ['_keys',"_cash"];

	buttonSetAction [14671, "call A3PL_Inventory_Use"];
	buttonSetAction [14672,
	"
		private ['_display','_amount','_selection','_classname'];
		_amount = parseNumber (ctrlText 14471);

		if (_amount <= 0) exitwith {['System: Please enter a valid amount',Color_Red] call A3PL_Player_Notification;};

		[] call A3PL_Inventory_Use;
		[true,_amount] call A3PL_Inventory_Drop;
	"];
	buttonSetAction [14674, "[0] call A3PL_Lib_CloseDialog"];

	ctrlSetText [14471, "1"];
	ctrlSetText [14072, format["Weight: %1/%2", (call A3PL_Inventory_TotalWeight), Player_MaxWeight]];

	{
		private ["_itemName", "_amount", "_index","_itemWeight"];

		_itemName = [_x select 0, "name"] call A3PL_Config_GetItem;
		_amount = _x select 1;
		_itemWeight = ([_x select 0, "weight"] call A3PL_Config_GetItem) * _amount;

		_index = lbAdd [14571, format["%1 (x%2) - %3 lbs", _itemName, _amount, _itemWeight]];
		lbSetData [14571, _index, _x select 0];
	} forEach ([] call A3PL_Inventory_Get);

	{
		private ["_player", "_index"];

		_player = _x;

		if (isPlayer _player) then {
			_index = lbAdd [14572, format["%1", (name _player)]];
			lbSetData [14572, _index, _x];
		};
	} forEach (nearestObjects [player, [], 5]);

	//Lets add all the housing keys
	_keys = player getVariable "keys";
	if (isNil "_keys") exitwith {};
	{
		//appartment
		if (count _x == 4) then
		{
			_index = lbAdd [1900,format ["Motel room key (%1)",_x]];
			lbSetData [1900, _index,_x];
		} else
		{
			_index = lbAdd [1900,format ["House key (%1)",_x]];
			lbSetData [1900, _index,_x];
		};
	} forEach (player getVariable ["keys",[]]);

	//add all the licenses
	{
		_index = lbAdd [1503,([_x,"name"] call A3PL_Config_GetLicense)];
	} forEach (player getVariable ["licenses",[]]);

	//add cash to inventory
	_cash = player getVariable "Player_Cash";
	if (isNil "_cash") exitwith {};
	if (_cash == 0) exitwith {};
	_index = lbAdd [14571, format["%1 (x%2)", "Cash", (player getVariable "Player_Cash")]];
	lbSetData [14571, _index, "cash"];
	
	((findDisplay 1001) displayCtrl 14571) ctrlAddEventHandler ["LBDblClick","[] call A3PL_Inventory_Use"];
}] call Server_Setup_Compile;

/*----------------------------------------------------------------------------*/

["A3PL_Inventory_Use",
{
	disableSerialization;
	private ['_selection', '_classname', '_itemClass', '_itemDir', '_canUse', '_format',"_display","_attach"];

	_className = param [0,""];

	if (_className == "") then
	{
		_display = findDisplay 1001;
		_selection = lbCurSel 14571;
		_classname = lbData [14571, _selection];
	};

	_itemClass = [_classname, 'class'] call A3PL_Config_GetItem;
	_itemDir = [_classname, 'dir'] call A3PL_Config_GetItem;
	_canUse = [_classname, 'canUse'] call A3PL_Config_GetItem;
	_attach = [_classname, 'attach'] call A3PL_Config_GetItem; //attachpoint

	//exit fnc if no selection
	if ((_selection == -1) && (!isNil "_display")) exitWith {};

	//exit fnc if item cannot be used
	if (_canUse isEqualTo false) exitWith {
		//item cannot be used - needs notification
		["System: This item cannot be used", Color_Red] call A3PL_Player_Notification;
	};

	//cant use item if hostage
	if (animationState player == "A3PL_TakenHostage") exitwith {["System: You cannot use an item while being taken hostage",Color_Red] call A3PL_Player_Notification;};

	//if item is in hand already, remove it
	if (!(isNull Player_Item)) then {
		[false] call A3PL_Inventory_PutBack;
	};

	if (!(player == vehicle player)) exitwith
	{
		["System: You cannot take items out of your inventory when inside a vehicle", Color_Red] call A3PL_Player_Notification;
	};

	if (animationState player IN ["a3pl_handsuptokneel","a3pl_handsupkneelgetcuffed","a3pl_cuff","a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","a3pl_cuffkickdown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","a3pl_handsupkneel"]) exitWith
	{
		["System: You cannot take items out of your inventory when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;
	};

	//Check for cash here
	if (_classname == "cash") then
	{
		Player_ItemAmount = parseNumber (ctrlText (_display displayCtrl 14471));
		if (Player_ItemAmount < 1) then
		{
			Player_ItemAmount = Nil;
		};
		if (Player_ItemAmount > (player getVariable "player_cash")) then
		{
			Player_ItemAmount = Nil;
			["System: You don't have this amount of cash on you", Color_Red] call A3PL_Player_Notification;
		};
	} else
	{
		Player_ItemAmount = Nil;
	};

	if ((_classname == "cash") && (isNil "Player_ItemAmount")) exitwith {};

	//create item
	Player_Item = _itemClass createVehicle (getPos player);

	//attach item to player's hand
	if (_classname == "popcornbucket") then
	{
		Player_Item attachTo [player, _attach, 'LeftHand'];
	} else
	{
		Player_Item attachTo [player, _attach, 'RightHand'];
	};

	//play animation
	if ((vehicle player == player) && (!(animationState player IN ["crew"]))) then
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon';
	};

	//set item dir in hand
	Player_Item setDir _itemDir;

	//set name
	Player_ItemClass = _classname;

	//close inventory dialog
	if (!isNil "_display") then
	{
		[0] call A3PL_Lib_CloseDialog;
	};

	//Run attachedloop, will drop item when entering vehicle etc.
	[Player_Item,_attach] spawn A3PL_Placeable_AttachedLoop;

	_format = format['You have pulled a %1 out of your inventory.', [Player_ItemClass, 'name'] call A3PL_Config_GetItem];
	[_format, Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Adds item in hands back to inventory -- temp fnc
["A3PL_Inventory_PutBack", {
	private ['_itemClass', '_displayNotification', '_format'];

	_itemClass = Player_ItemClass;
	_displayNotification = [_this, 0, true, [true]] call BIS_fnc_param;

	if (_itemClass == "") exitwith {["System: There is no itemClass assigned", Color_Red] call A3PL_Player_Notification;};

	//Delete the item
	detach Player_Item;
	deleteVehicle Player_Item;

	//reset variables
	Player_Item = objNull;
	Player_ItemClass = '';

	//display notification & play animation if true
	if (_displayNotification isEqualTo true) then {

		if (!(animationState player IN ["crew"])) then
		{
			player playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon';
		};

		_format = format["You put a %1 back into your inventory.", [_itemClass, 'name'] call A3PL_Config_GetItem];
		[_format, Color_Yellow] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

//Performs drop action from inventory
["A3PL_Inventory_Drop", {
	private ["_itemClass", "_obj", "_format","_setpos","_amount"];
	_setpos = param [0,true];
	_amount = param [1,1];
	_itemClass = Player_ItemClass;
	_obj = Player_Item;
	_droppedItems = server getVariable 'droppedObjects';

	if (!([_itemClass,_amount] call A3PL_Inventory_Has)) exitwith { ["System: You don't have this amount to drop",Color_Red] call A3PL_Player_Notification; };

	if (isNull _obj) exitwith
	{
		["System: It doesn't seem like you have an item to throw",Color_Red] call A3PL_Player_Notification;
	};

	if (!isNil "Player_isEating") exitwith
	{
		["System: You are currently eating something and cannot perform this action",Color_Red] call A3PL_Player_Notification;
	};

	//play animation
	if (!(animationState player IN ["crew"])) then
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};

	//change position
	if (_setPos) then
	{
		detach _obj;
		_obj setPosASL (AGLtoASL (player modelToWorld [0,1,0]));
	};

	//add obj to dropped items array
	//Reset Variables - as no longer holding it
	Player_Item = objNull;
	Player_ItemClass = '';

	//Remove from inventory
	switch (_itemclass) do
	{
		//[[player, _class, _amount], 'Server_Inventory_Add', false] call BIS_fnc_MP;
		case "doorkey": {[[_obj, player], 'Server_Housing_dropKey', false] call BIS_fnc_MP;};
		//case "cash": {[_itemClass, -(Player_ItemAmount)] call A3PL_Inventory_Add;};
		case "cash": {[[player,_obj,_itemClass,Player_ItemAmount], "Server_Inventory_Drop", false] call BIS_fnc_MP;};
		default {[[player,_obj,_itemClass,_amount], "Server_Inventory_Drop", false] call BIS_fnc_MP;};
	};

	_format = format["You dropped a %1.", [_itemClass, 'name'] call A3PL_Config_GetItem];
	[_format, Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Pickup items from ground
["A3PL_Inventory_Pickup", {
	private ["_obj", "_format","_exit","_attachedTo","_canPickup","_amount"];

	_obj = param [0,objNull];
	_moveToHand = param [1,false];

	if (isNull _obj) exitwith {["System error: Unable to pickup, object is null", Color_Red] call A3PL_Player_Notification;};

	_classname = _obj getVariable "class";
	if (isNil "_classname") exitwith {["System error: Unable to pickup, object contains no class", Color_Red] call A3PL_Player_Notification;};

	//if we are already holding an object
	if (!isNull Player_Item) exitwith
	{
		_format = format["System: You are already holding an object"];
		[_format, Color_Red] call A3PL_Player_Notification;
	};

	//make sure nobody else can pick it up
	_attachedTo = attachedTo _obj;
	if (!isNull _attachedTo) then
	{
		if ((isPlayer _attachedTo) && (!(_attachedTo isKindOf "Car"))) then
		{
			_exit = true;
		};
	};

	if (!isNil "_exit") exitwith
	{
		_format = format["You can't pickup an object that another player is holding"];
		[_format, Color_Red] call A3PL_Player_Notification;
	};

	//CHECK IF THIS ITEM CANNOT BE picked up
	_canPickup = true;
	if (((count (_obj getVariable ["ainv",[]])) != 0) OR ((count (_obj getVariable ["finv",[]])) != 0)) exitwith
	{
		[_obj] call A3PL_Placeables_Pickup;
	};
	_canPickup = [_classname,"canPickup"] call A3PL_Config_GetItem;
	if (!_canPickup) exitwith
	{
		[_obj] call A3PL_Placeables_Pickup;
	};

	//check inventory space
	if (([[_classname,1]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {[format ["System: You can't pick this item up because it would exceed the %1 lbs limit you can carry on you!",Player_MaxWeight],Color_Red] call A3PL_Player_Notification;};

	//FD adapter check
	if (typeOf _obj == "A3PL_FD_HoseEnd1_Float") then
	{
		private ["_hydrant"];
		_hydrant = (nearestObjects [_obj,["Land_A3PL_FireHydrant"], 1]) select 0;
		if (!isNil "_hydrant") then
		{
			_hydrant animateSource ["cap_hide",0];
		};
	};

	//Exclusions
	if (_classname == "apple" && !simulationEnabled _obj) exitwith {[_obj] spawn A3PL_JobPicking_Pickup;};


	//play animation
	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';

	//Hotfix to fix spam duping
	if (player_objIntersect getVariable ["inUse",false]) exitWith {};
	player_objIntersect setVariable ["inUse",true,true];

	//get amount
	_amount = _obj getVariable ["amount",1];

	//add item to inventory
	switch (_classname) do
	{
		//; [_classname, 1] call A3PL_Inventory_Add;
		case "doorkey": {[[_obj, player], "Server_Housing_PickupKey", false,false,true] call BIS_fnc_MP;}; // call on server to prevent duplication, test this
		case "cash": {[[player, _obj], "Server_Inventory_Pickup", false,false,true] call BIS_fnc_MP};
		default {[[player, _obj, _amount], "Server_Inventory_Pickup", false,false,true] call BIS_fnc_MP;}; // call on server to prevent duplication
	};

	//if we want to go straight to hand
	if (_moveToHand) then
	{
		[_classname] call A3PL_Inventory_Use;
	};

	//display notification
	_format = format["System: Send request to server to pick up %1 %2(s)",_amount, [_classname, "name"] call A3PL_Config_GetItem];
	[_format, Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Inventory_Throw", {
	[] spawn {
		private ['_obj', '_itemClass', '_playerVelocity', '_playerDir'];

		_obj = Player_Item;
		_itemClass = Player_ItemClass;

		if(_itemClass in ["A3PL_BucketFull","A3PL_Bucket","bucket_empty","bucket_full"]) exitWith {
			["System: Stop throwing buckets man!",Color_Red] call A3PL_Player_Notification;
		};

		if (isNull _obj) exitwith
		{
			["System: It doesn't seem like you have an item to throw",Color_Red] call A3PL_Player_Notification;
		};

		if (!isNil "Player_isEating") exitwith
		{
			["You are eating something and cannot perform this action",Color_Red] call A3PL_Player_Notification;
		};
		
		if ((count (player nearObjects ["A3PL_Container_Ship", 100])) > 0) exitwith
		{
			["System: Are you trying to sink a cargo ship?",Color_Red] call A3PL_Player_Notification;
		};		

		//play throw animation
		player playaction "Gesture_throw";

		//sleep so matches with animation
		sleep 0.5;

		//detach object
		detach _obj;

		//move object - throw
		_playerVelocity = velocity player;
		_playerDir = direction player;

		_obj setVelocity [((_playerVelocity select 0) + (sin _playerDir * 7)), ((_playerVelocity select 1) + (cos _playerDir * 7)), ((_playerVelocity select 2) + 7)];

		switch (_itemClass) do
		{
			case "doorkey": {[[_obj, player], 'Server_Housing_dropKey', false] call BIS_fnc_MP;};
			case "cash": {[[player,_obj,_itemClass,Player_ItemAmount], "Server_Inventory_Drop", false] call BIS_fnc_MP;};
			default {[[player,_obj,_itemClass], "Server_Inventory_Drop", false] call BIS_fnc_MP;};
//			case "doorkey": {[[_obj, player], 'Server_Housing_dropKey', false] call BIS_fnc_MP;};
//			case "cash": {[[player,_obj,_itemClass,Player_ItemAmount], 'Server_Inventory_Drop', false] call BIS_fnc_MP;};
//			default {[[player,_obj,_itemClass], 'Server_Inventory_Drop', false] call BIS_fnc_MP;};
		};

		//add obj to dropped items array


		//Reset Variables - as no longer holding it
		Player_Item = objNull;
		Player_ItemClass = '';
	};
}] call Server_Setup_Compile;

//Performs give action from inventory
["A3PL_Inventory_Give", {
	disableSerialization;
	private ['_selection', '_classname', '_itemClass', '_itemDir', '_canUse', '_format',"_display"];

	_display = findDisplay 1001;

	_selection = lbCurSel 14571;
	_classname = lbData [14571, _selection];

	_playerSelection = lbCurSel 14572;
	_target = lbData [14572,_playerSelection];

	_itemClass = [_classname, 'class'] call A3PL_Config_GetItem;
	_name = [_classname, 'name'] call A3PL_Config_GetItem;
	_itemDir = [_classname, 'dir'] call A3PL_Config_GetItem;

	//exit fnc if no selection
	if (_selection == -1) exitWith {};
	if (_playerSelection == -1) exitWith {
		["Select someone to give this item to!", Color_Red] call A3PL_Player_Notification;
	};

	if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith
	{
		["System: You cannot give items when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;
	};

	//Get the amount
	_amount = parseNumber (ctrlText (_display displayCtrl 14471));
	if (_amount < 1) exitWith
	{
		["Enter a valid amount above 0!", Color_Red] call A3PL_Player_Notification;
	};

	if ((_classname == "cash") && (isNil "Player_ItemAmount")) exitwith {};

	//Send the player the stuff, Remove mine.
	[[player, _itemClass, _amount], 'Server_Inventory_Add', false] call BIS_fnc_MP;
	[[_target, _itemClass, _amount], 'Server_Inventory_Add', false] call BIS_fnc_MP;

	//Tell the person they got the items
	[format["%1 has given you %2 %3(s)",name player,_amount,_name], Color_Green] remoteExec ["A3PL_Player_Notification",_target];

	//Tell the player they sent items
	_format = format['You have given %1 %2(s) to %3', _amount, _name, name _target];
	[_format, Color_Yellow] call A3PL_Player_Notification;

	//close inventory dialog
	[0] call A3PL_Lib_CloseDialog;
}] call Server_Setup_Compile;
