//deals with getting inherance information from configFile for usage in text by Factory_Open
["A3PL_Factory_Inheritance",
{
	private ["_class","_type","_info","_return","_mainClass"];
	_class = param [0,""];
	_type = param [1,""];
	_info = param [2,""];

	if (_type == "item") exitwith
	{
		switch (_info) do
		{
			case ("img"): {_return = ""; };
			case ("name"): {_return = [_class,"name"] call A3PL_Config_GetItem; };
			case ("mainClass"): { _return = _mainClass;};
		};
		if (isNil "_return") then {_return = "ERROR"};
		if (typeName _return == "BOOL") then {_return = "ERROR"};
		_return;
	};

	switch (_type) do
	{
		case ("car"): {_mainClass = "cfgVehicles"};
		case ("weapon"): {_mainClass = "CfgWeapons"};
		case ("magazine"): {_mainClass = "cfgMagazines"};
		case ("mag"): {_mainClass = "cfgMagazines"};
		case ("uniform"): {_mainClass = "CfgWeapons"};
		case ("vest"): {_mainClass = "CfgWeapons"};
		case ("headgear"): {_mainClass = "CfgWeapons"};
		case ("backpack"): {_mainClass = "CfgWeapons"};
		case ("goggles"): {_mainClass = "CfgGlasses"};
		case ("aitem"): {_mainClass = "CfgWeapons"};
		default {_mainClass = "cfgVehicles"};
	};

	switch (_info) do
	{
		case ("img"): { _return = getText (configFile >> _mainClass >> _class >> "picture") };
		case ("name"): { _return = getText (configFile >> _mainClass >> _class >> "displayName") };
		case ("mainClass"): { _return = _mainClass;};
	};

	if (isNil "_return") then {_return = "";};
	_return;
}] call Server_Setup_Compile;

//a loop in the dialog to set the progress among other things
["A3PL_Factory_DialogLoop",
{
	disableSerialization;
	private ["_display","_var","_craftID","_control","_duration","_secLeft","_id","_timeEnd","_name","_quantity"];
	_display = findDisplay 45;
	_type = ctrlText (_display displayCtrl 1100);
	if (isNull _display) exitwith {};
	_var = player getVariable ["player_factories",[]];
	{
		private ["_id"];
		_id = _x select 0;
		if (([_id, "type"] call A3PL_Config_GetPlayerFactory) == _type) exitwith
		{
			_craftID = _id; //select what we are currently crafting at this factory
		};
	} foreach _var;

	if (isNil "_craftID") exitwith {}; //no point in running this loop if we aren't crafting shit here

	_id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
	_quantity = [_craftID, "amount"] call A3PL_Config_GetPlayerFactory;
	_duration = [_id,_type,"time"] call A3PL_Config_GetFactory; //duration for this item to finish crafting
	_duration = _duration * _quantity;
	_timeEnd = [_craftID, "finish"] call A3PL_Config_GetPlayerFactory; //time at which it ends
	_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
	if (_name == "inh") then {_name = [([_id,_type,"class"] call A3PL_Config_GetFactory),([_id,_type,"type"] call A3PL_Config_GetFactory),"name"] call A3PL_Factory_Inheritance;};
	while {!isNull _display} do
	{
		_secLeft = -(diag_ticktime) + _timeEnd;
		(_display displayCtrl 1105) progressSetPosition (1-(_secLeft / _duration));
		//set what we are currently crafting
		if (_secLeft < 0) then {_secLeft = 0};
		(_display displayCtrl 1104) ctrlSetStructuredText parseText format ["<t size='0.92'>Crafting: %1<br/>%2 seconds left</t>",_name,ceil _secLeft];
		uiSleep 0.1;
		if (_secLeft <= 0) exitwith {};
	};
}] call Server_Setup_Compile;

//can check whether we have an item in the factory storage or not. can also be used by the server
["A3PL_Factory_Has",
{
	private ["_item","_amount","_player","_has","_found","_storage","_type"];
	_item = param [0,""];
	_amount = param [1,1];
	_type = param [2,""];
	_player = param [3,player];
	_has = false;
	_found = false;
	_storage = _player getVariable ["player_fstorage",[]];

	{
		if (_x select 0 == _type) then
		{
			{
				private ["_storageItem","_isFactory","_itemType"];
				_storageItem = _x select 0;

				_isFactory = _storageItem splitString "_";
				if ((_isFactory select 0) == "f") then {_isFactory = true; _itemType = [_storageItem,_type,"type"] call A3PL_Config_GetFactory;} else {_isFactory = false;};
				if (isNil "_itemType") then {_itemType = ""};
				if (_isFactory && (_itemType == "item")) then {_storageItem = [_storageItem,_type,"class"] call A3PL_Config_GetFactory;};
				if (_storageItem == _item) exitwith
				{
					if ((_x select 1) >= _amount) then
					{
						_has = true
					};
					_found = true;
				};
			} foreach (_x select 1);
			if (_found) exitwith {};
		};
	} foreach _storage;

	_has;
}] call Server_Setup_Compile;

//does the actual crafting, this function runs when we press the craft button
["A3PL_Factory_Craft",
{
	disableSerialization;
	private ["_display","_control","_type","_id","_required","_failed","_sec","_classType","_craftID","_classname","_alreadyCrafting", "_amount","_newRequired","_quantity"];
	_display = findDisplay 45;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text

	_var = player getVariable ["player_factories",[]]; //check to see if we are already crafting something here
	{
		private ["_id"];
		_id = _x select 0;
		if (([_id, "type"] call A3PL_Config_GetPlayerFactory) == _type) exitwith
		{
			_alreadyCrafting = true;
		};
	} foreach _var;
	if (!isNil "_alreadyCrafting") exitwith {["System: You are already crafting something here, please wait!",Color_Red] call A3PL_Player_Notification;};
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam

	_control = _display displayCtrl 1500; //get id
	if (lbCurSel _control < 0) exitwith {["System: You haven't selected any item to craft",Color_Red] call A3PL_Player_Notification;};
	_id = _control lbData (lbCurSel _control);
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory;
	if (isNil "_required" OR (count _required < 1)) exitwith {["System: Unexpected error occured trying to retrieve items for recipe in _Craft",Color_Red] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1400;
	_quantity = floor(parseNumber (ctrlText _control));
	if(_quantity < 1) exitWith {["You must enter a quantity greater than 0",Color_Red] call A3PL_Player_Notification;};

	_newRequired = [];
	{
		private ["_amount","_id"];
		_id = _x select 0;
		_amount = (_x select 1) * _quantity;
		_newRequired pushBack [_id, _amount];
	} foreach _required;
	_required = _newRequired;
	//first check if we have all the items
	{
		private ["_amount","_id"];
		_id = _x select 0;
		_amount = _x select 1;

		if (!([_id,_amount,_type] call A3PL_Factory_Has)) exitwith {_failed=true}; //if dont have this required item exit
	} foreach _required;
	systemChat (format["%1", _required]);

	if (!isNil "_failed") exitwith
	{
		["System: You don't have the required materials to craft this",Color_Red] call A3PL_Player_Notification;
	};

	//set a variable that we will use later on to make these items UNAVAILABLE, and also to keep track of what we are still crafting
	_sec = ([_id,_type,"time"] call A3PL_Config_GetFactory) * _quantity;
	_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
	_classname = [_id,_type,"class"] call A3PL_Config_GetFactory;
	_craftID = floor (random 10000);
	_var = player getVariable ["Player_Factories",[]];
	_var pushback [_craftID,_classname,_required,_type,_classType,_id,_quantity,(diag_ticktime + _sec)]; //defined in A3PL_Config.sqf
	player setVariable ["Player_Factories",_var,false];
	[] spawn A3PL_Factory_DialogLoop; //seperate dialog loop

	[_craftID,_sec] spawn
	{
		private ["_craftID","_sec","_type","_classType","_id","_name","_var","_quantity"];
		_craftID = param [0,0];
		_sec = param [1,0];
		_type = [_craftID, "type"] call A3PL_Config_GetPlayerFactory;
		_classtype = [_craftID, "classtype"] call A3PL_Config_GetPlayerFactory;
		_classname = [_craftID, "classname"] call A3PL_Config_GetPlayerFactory;
		_id = [_craftID, "id"] call A3PL_Config_GetPlayerFactory;
		_quantity = [_craftID, "amount"] call A3PL_Config_GetPlayerFactory;
		_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
		if (_name == "inh") then {_name = [_classname,_classType,"name"] call A3PL_Factory_Inheritance;};

		uiSleep _sec;
		[format ["System: %1 has finished crafting in your %2",_name,_type],Color_Green] call A3PL_Player_Notification;

		//have server remove items from player_inventory permanently
		systemChat (format ["%1", _quantity]);
		[player,_type,_id, _quantity] remoteExec ["Server_Factory_Finalise", 2];

		uiSleep 1.5; //account for server lag to prevent duping, during this sleep it 'can make it look' like more items are taken due to the temp factories var, it will be fixed after 1.5 seconds

		//delete from player_factories
		_var = player getVariable ["player_factories",[]];
		{
			if (_x select 0 == _craftID) exitwith {_var deleteAt _forEachIndex};
		} foreach _var;
	};
}] call Server_Setup_Compile;

//set all the items required, colour will display whether we have the item or not
["A3PL_Factory_SetRecipe",
{
	disableSerialization;
	private ["_display","_control","_type","_id","_desc","_classType","_class","_ctrlID","_preview","_lbArray"];
	_display = findDisplay 45;
	_ctrlID = param [0,1500];
	_preview = param [1,true];
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	_control = _display displayCtrl _ctrlID; //get id
	if ((lbCurSel _control) < 0) exitwith {};
	_id = _control lbData (lbCurSel _control);
	_required = [_id,_type,"required"] call A3PL_Config_GetFactory;
	_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
	if (_preview) then
	{
		[_type,_id] spawn A3PL_Factory_ObjectPreviewSpawn; //spawn object in preview
	};
	_control = _display displayCtrl 1501;

	_lbArray = []; //quick refresh
	{
		private ["_i","_name","_amount","_id"];
		_id = _x select 0;
		_amount = _x select 1;
		_name = format ["%1x %2",_amount,([_id,"name"] call A3PL_Config_GetItem)];
		if ([_id,_amount,_type] call A3PL_Factory_Has) then //if we have the required item
		{
			_lbArray pushback [_name,_id,true];
		} else
		{
			_lbArray pushback [_name,_id,false];
		};

	} foreach _required;

	//quick refresh lb
	lbClear _control;
	{
		_i = _control lbAdd (_x select 0); //prepare new lb entry
		_control lbSetData [_i,(_x select 1)];
		if (_x select 2) then {_control lbSetColor [_i,[0, 1, 0, 1]];} else {_control lbSetColor [_i,[1, 0, 0, 1]];};
	} foreach _lbArray;

	//set item information
	_desc = [_id,"desc"] call A3PL_Config_GetItem;
	if (typeName _desc == "BOOL") then
	{
		switch (_classType) do
		{
			case ("car"): {_desc = "Car"};
			case ("weapon"): {_desc = "Weapon"};
			case ("mag"): {_desc = "Magazine"};
			case default {_desc = "Not defined"};
		};
	};
	_control = _display displayCtrl 1103;
	_control ctrlSetStructuredText parseText format ["Item Description: %1",_desc];
}] call Server_Setup_Compile;

["A3PL_Factory_Open",
{
	disableSerialization;
	private ["_type","_display","_control","_recipes"];
	_type = param [0,""];

	//if we are carrying something
	if (!isNull Player_Item) then {[] call A3PL_Inventory_PutBack;}; //fixes a dupe glitch
	createDialog "Dialog_Factory";
	[] spawn A3PL_Factory_DialogLoop; //seperate dialog loop, takes care of progressbar
	[_type] spawn A3PL_Factory_ObjectPreview; //seperate object preview loop
	[_type] spawn
	{
		disableSerialization;
		_type = param [0,""];
		_display = findDisplay 45;
		while {!isNull _display} do
		{
			[_type] call A3PL_Factory_Refresh;
			uiSleep 0.5;
		};
	}; //loop to keep refreshing info

	_display = findDisplay 45;

	_control = _display displayCtrl 1600;
	_control buttonSetAction "call A3PL_Factory_Craft";
	_control = _display displayCtrl 1603;
	_control buttonSetAction "call A3PL_Factory_Collect";
	_control = _display displayCtrl 1601;
	_control buttonSetAction "call A3PL_Factory_Add";
	_control = _display displayCtrl 1100; //deal with setting text
	_control CtrlSetText _type;
	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged",{}];
	_control = _display displayCtrl 1500; //controlgroup
	_control ctrlAddEventHandler ["LBSelChanged",{[1500] call A3PL_Factory_SetRecipe;}];
	_recipes = ["all",_type] call A3PL_Config_GetFactory; //return the recipe array
	{
		private ["_id","_img","_class","_i","_name"];
		_id = _x select 0;
		_img = [_id,_type,"img"] call A3PL_Config_GetFactory;
		_class = [_id,_type,"class"] call A3PL_Config_GetFactory;
		_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
		_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
		_parent = [_id,_type,"parent"] call A3PL_Config_GetFactory;
		if (_img == "inh") then {_img = [_class,_classType,"img"] call A3PL_Factory_Inheritance;};
		if (_name == "inh") then {_name = [_class,_classType,"name"] call A3PL_Factory_Inheritance;};

		if (_parent != "") then {}; //Deal with parenting listbox, this is not *really* implemented yet,

		_i = _control lbAdd _name; //prepare new lb entry
		_control lbSetPicture [_i,_img];
		_control lbSetData [_i,_id];
	} foreach _recipes;
	_control lbSetCurSel 0;

	[_type] call A3PL_Factory_Refresh;
}] call Server_Setup_Compile;

//get the storage minus what we are using in crafting right now
["A3PL_Factory_GetStorage",
{
	private ["_subtract","_storage","_fact","_type"];
	_type = param [0,""];

	_storage = [_type,"items"] call A3PL_Config_GetPlayerFStorage;
	if (typeName _storage == "BOOL") exitwith {_storage = []; _storage;};
	_fact = player getVariable ["player_factories",[]];
	_subtract = [];

	{
		private ["_class","_amount","_items"];
		{
			_class = _x select 0;
			_amount = _x select 1;
			_subtract = [_subtract, _class, _amount, true] call BIS_fnc_addToPairs; //required items as in A3PL_Config
		} foreach (_x select 2); //as in 'required' from A3PL_Config
	} foreach _fact;

	{
		private ["_class","_amount"];
		_class = _x select 0;
		_amount = _x select 1;
		_storage = [_storage, _class, -(_amount), true] call BIS_fnc_addToPairs;
	} foreach _subtract;

	//verify, delete less than 0
	{
		if ((_x select 1) < 1) then
		{
			_storage deleteAt _forEachIndex;
		};
	} forEach _storage;
	//end of formating _storage

	_storage;
}] call Server_Setup_Compile;

//refreshes info such as item storage and required
["A3PL_Factory_Refresh",
{
	disableSerialization;
	private ["_type","_storage","_control","_display","_curSel","_inventory","_i","_near","_LBarray"];
	_type = param [0,""];
	_display = findDisplay 45;
	if (isNull _display) exitwith {};
	_control = _display displayCtrl 1502;
	_storage = [_type] call A3PL_Factory_GetStorage;
	_inventory = player getVariable ["player_inventory",[]];
	if (typeName _storage == "BOOL") then {_storage = []};

	_lbArray = []; //we use this to quickly perform lbadd
	{
		private ["_id","_name","_amount","_i","_img","_classType","_class","_isFactory"];
		_id = _x select 0;
		_amount = _x select 1;
		_isFactory = _id splitString "_";
		if ((_isFactory select 0) == "f") then {_isFactory = true;} else {_isFactory = false;};
		if (_isFactory) then
		{
			_img = [_id,_type,"img"] call A3PL_Config_GetFactory;
			_name = [_id,_type,"name"] call A3PL_Config_GetFactory;
			_class = [_id,_type,"class"] call A3PL_Config_GetFactory;
			_classType = [_id,_type,"type"] call A3PL_Config_GetFactory;
			if (_img == "inh") then {_img = [_class,_classType,"img"] call A3PL_Factory_Inheritance;}; //get inheritant info if necesarry
			if (_name == "inh") then {_name = [_class,_classType,"name"] call A3PL_Factory_Inheritance;}; //get inheritant info if necesarry
		} else
		{
			_name = [_id,"name"] call A3PL_Config_GetItem;
			_img = [_id,"icon"] call A3PL_Config_GetItem;
		};

		_lbArray pushback [format ["%1 (%2x)",_name,_amount],_id];
	} foreach _storage;

	//Refresh storage LB
	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetPicture [_i,""];
		_control lbSetData [_i,(_x select 1)];
	} foreach _lbArray;
	_lbArray = [];

	_control = _display displayCtrl 1503;
	{
		private ["_i","_id","_amount"];
		_id = _x select 0;
		_amount = _x select 1;
		_lbArray pushback [format ["%1 (%2x)",([_id,"name"] call A3PL_Config_GetItem),_amount],_id];
	} foreach _inventory;

	lbClear _control;
	{
		_i = _control lbAdd (_x select 0);
		_control lbSetData [_i,(_x select 1)];
	} foreach _lbArray;
	_i = _control lbAdd format ["Cash (%1x)",(player getvariable ["player_cash",0])]; //add money
	_control lbSetData [_i,"cash"];

	//delete items with faction inventory or arma inventory
	_near = nearestObjects [player, [], 20];
	{
		if ((!isNil {_x getVariable ["ainv",nil]}) OR (!isNil {_x getVariable ["finv",nil]})) then
		{
			_near deleteAt _forEachIndex;
		};
	} foreach _near;

	{
		if (!isNil {_x getVariable ["class",nil]}) then
		{
			if ((_x getVariable ["owner",""]) == (getPlayerUID player)) then
			{
				private ["_i","_id","_amount"];
				_id = _x getVariable ["class",""];
				_amount = 1;
				_i = _control lbAdd format ["%1 (%2x)",([_id,"name"] call A3PL_Config_GetItem),_amount];
				_control lbSetData [_i,format ["OBJ_%1",_x]];
			};
		};
	} foreach _near;

	[1500,false] call A3PL_Factory_SetRecipe; //refresh recipe
}] call Server_Setup_Compile;

//this runs when we press the collect button
["A3PL_Factory_Collect",
{
	private ["_display","_control","_id","_amount","_isCrafting"];
	_display = findDisplay 45;
	_control = _display displayCtrl 1502;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	if (lbCurSel _control < 0) exitwith {["System: You haven't selected anything!",Color_Red] call A3PL_Player_Notification;};
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	_id = _control lbData (lbCurSel _control);

	//anti-dupe for collecting items that are currently being crafted
	_isCrafting = false;
	{
		if ((_x select 3) == _type) exitwith {_isCrafting = true;};
	} foreach (player getVariable ["player_factories",[]]);
	if (_isCrafting) exitwith {["System: You can't take out items out of the storage if you are currently crafting something!"] call A3PL_Player_Notification;};
	//end of anti-dupe

	_control = _display displayCtrl 1400;
	_amount = parseNumber (ctrlText _control);
	if (_amount <= 0) exitwith {["System: Please enter a valid amount to collect",Color_Red] call A3PL_Player_Notification;};
	if (!([_id,_amount,_type] call A3PL_Factory_Has)) exitwith {["System: You don't have this amount of this item to collect",Color_Red] call A3PL_Player_Notification;};

	[player,_type,[_id,_amount]] remoteExec ["Server_Factory_Collect",2]; //change to 2
	[_type] spawn
	{
		_type = param [0,""];
		uiSleep 2;
		[_type] call A3PL_Factory_Refresh;
	};
}] call Server_Setup_Compile;

["A3PL_Factory_Add",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	private ["_display","_control","_type","_id","_amount","_typeOf","_fail","_obj","_cashCheck"];
	_display = findDisplay 45;
	_control = _display displayCtrl 1503;
	_type = ctrlText (_display displayCtrl 1100); //factory id from dialog text
	_id = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 1400;
	_amount = parseNumber (ctrlText _control);
	if (_amount <= 0) exitwith {["System: Please enter a valid amount to add",Color_Red] call A3PL_Player_Notification;};
	_fail = false;

	//check if this was a near object
	_splitted = _id splitString "_";
	if ((_splitted select 0) == "OBJ") then
	{
		_typeOf = "";
		_typeOf = toArray _id;
		_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;_typeOf deleteAt 0;
		_typeOf = toString _typeOf;
	};
	if (_fail) exitwith {["System: Error retrieving object typeOf in _Factory_Add",Color_Red] call A3PL_Player_Notification;};
	if (!isNil "_typeOf") then
	{
		_obj = [_typeOf] call A3PL_Lib_vehStringToObj;
	};
	if (_fail) exitwith {["System: Error retrieving object in _Factory_Add",Color_Red] call A3PL_Player_Notification;};
	if (isNil "_obj") then
	{

	if(_id == "cash")	exitwith {["System: You cannot store cash in a factory!",Color_Red] call A3PL_Player_Notification;};

		[player,_type,[_id,_amount]] remoteExec ["Server_Factory_Add",2];
	} else
	{
		if (isNull _obj) exitwith {_fail = true};
		_id = _obj getVariable ["class",nil];
		if (isNil "_id") exitwith {_fail = true};
		[player,_type,[_id,1],true,_obj] remoteExec ["Server_Factory_Add",2];
	};
	if (_fail) exitwith {["System: Error retrieving itemClass from object",Color_Red] call A3PL_Player_Notification;};
}] call Server_Setup_Compile;
["A3PL_Factory_ObjectPreview",
{
	disableSerialization;
	private ["_cam","_logic","_factory","_display","_dir","_interval"];
	_factory = param [0,""];
	_display = findDisplay 45;

	_logic = "logic" createvehicleLocal [0,0,0];
	_logic setposATL (["pos",_factory] call A3PL_Config_GetFactory);
	_cam = "camera" camCreate [0,0,0];
	FACTORYCAMERA = _cam;
	FACTORYLOGIC = _logic;
	_cam camSetTarget _logic;
	_cam camCommit 0;
	_cam cameraEffect ["internal", "BACK"];
	_cam attachto [_logic, [0,5,2]];
	_dir = random 359;
	_interval = 0.1;
	while {!isNull _display} do
	{
		_dir = _dir + _interval;
		_logic setDir _dir;
		uiSleep 0.01;
	};

	{
		deleteVehicle _x;
	} foreach (attachedObjects (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]));
	deleteVehicle (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]); //clear the object from preview
	FACTORYCAMERA = nil;
	FACTORYLOGIC = nil;
	camDestroy _cam;
	deleteVehicle _logic;
	player cameraEffect ["terminate", "BACK"];
}] call Server_Setup_Compile;

["A3PL_Factory_ObjectPreviewSpawn",
{
	disableSerialization;
	private ["_factory","_id","_pos","_display","_camera","_logic","_itemType","_class"];
	_factory = param [0,""];
	_id = param [1,""];
	_class = [_id,_factory,"class"] call A3PL_Config_GetFactory;
	_itemType = [_id,_factory,"type"] call A3PL_Config_GetFactory;
	_pos = ["pos",_factory] call A3PL_Config_GetFactory;
	_display = findDisplay 45;
	_camera = missionNameSpace getVariable ["FACTORYCAMERA",objNull];
	_logic = missionNameSpace getVariable ["FACTORYLOGIC",objNull];
	if (isNull _display) exitwith {};
	{
		deleteVehicle _x;
	} foreach (attachedObjects (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]));
	deleteVehicle (missionNameSpace getVariable ["A3PL_FACTORY_OBJPRV",objNull]);
	sleep 0.01;
	if (!([] call A3PL_Player_AntiListboxSpam)) exitwith {};

	//deal with spawning item
	switch (true) do
	{
		case (_itemType =="item"): //spawn with simulation disabled
		{
			_class = [_class,"class"] call A3PL_Config_GetItem;
			A3PL_FACTORY_OBJPRV = _class createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			A3PL_FACTORY_OBJPRV enableSimulation false;
			_camera attachto [_logic, [0,2,2]];
		};

		case (_itemType IN ["weapon","magazine","aitem","weaponitem","secweaponitem"]): //groundweaponholder
		{
			A3PL_FACTORY_OBJPRV = "groundWeaponHolder" createvehicleLocal [0,0,0];
			switch (_itemType) do
			{
				case ("weapon"): {A3PL_FACTORY_OBJPRV addWeaponCargo [_class,1];};
				case ("magazine"): {A3PL_FACTORY_OBJPRV addMagazineCargo [_class,1];};
				case ("aitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
				case ("weaponitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
				case ("secweaponitem"): {A3PL_FACTORY_OBJPRV addItemCargo [_class,1];};
			};

			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			_camera attachto [_logic, [0,0.1,1]];
		};

		case (_itemType IN ["car","plane","heli"]): //spawn with simulation enabled
		{
			A3PL_FACTORY_OBJPRV = _class createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL _pos;
			A3PL_FACTORY_OBJPRV setDir (random 359);
			_camera attachto [_logic, [0,5,2]];
		};

		case (_itemType IN ["vest","uniform","goggles","headgear","backpack"]): //spawn AI
		{
			A3PL_FACTORY_OBJPRV = "C_man_p_beggar_F" createvehicleLocal [0,0,0];
			A3PL_FACTORY_OBJPRV allowDamage false;
			A3PL_FACTORY_OBJPRV setPosATL [_pos select 0,_pos select 1,((_pos select 2) - 1)];
			A3PL_FACTORY_OBJPRV setDir (random 359);
			A3PL_FACTORY_OBJPRV enableSimulation false;
			A3PL_FACTORY_OBJPRV addweapon "arifle_AKM_F";
			switch (_itemType) do
			{
				case ("uniform"): {removeUniform A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addUniform _class; };
				case ("vest"): {removeVest A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addVest _class; };
				case ("headgear"): {removeHeadGear A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addHeadGear _class; };
				case ("backpack"): {removeBackPack A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addBackPack _class; };
				case ("goggles"): {removeGoggles A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addGoggles _class; };
				case ("weapon"): {removeAllWeapons A3PL_FACTORY_OBJPRV; A3PL_FACTORY_OBJPRV addWeapon _class; };
			};
			_camera attachto [_logic, [0,2,2]];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Factory_CrateInfo",
{
	private ["_crate","_ainv","_finv","_classType","_id","_amount","_forFaction"];
	_crate = param [0,objNull];
	_aInv = _crate getVariable ["ainv",nil]; //or finv
	if (isNil "_aInv") then
	{
		_finv = _crate getVariable ["finv",nil];
	};
	if (isNil "_aInv" && isNil "_finv") exitwith {["System: Missing inv variables on this object in _CrateCheck -> report this bug",Color_Red] call A3PL_Player_Notification;};

	if (isNil "_fInv") then
	{
		_classtype = _aInv select 0;
		_id = _aInv select 1;
		_amount = _aInv select 2;
		_forFaction = "";
	} else
	{
		_classtype = _fInv select 0;
		_id = _fInv select 1;
		_amount = _fInv select 2;
		_forFaction = _fInv select 3;
	};

	if (_forFaction == "") then {_forFaction = "All"};
	_return = [_classType,_id,_amount,_forFaction];
	_return;
}] call Server_Setup_Compile;

["A3PL_Factory_CrateName",
{
	private ["_classType","_id","_name"];
	_id = param [0,""];
	_classType = param [1,""];

	_name = "ERROR";
	switch (true) do
	{
		case (_classType == "item"):
		{
			_name = [_id,"name"] call A3PL_Config_GetItem;
		};
		case default //["car","weapon","magazine","mag","uniform","vest","headgear","backpack","goggles"]
		{
			private ["_mainClass"];
			switch (_classtype) do
			{
				case ("car"): {_mainClass = "cfgVehicles"};
				case ("weapon"): {_mainClass = "CfgWeapons"};
				case ("magazine"): {_mainClass = "cfgMagazines"};
				case ("mag"): {_mainClass = "cfgMagazines"};
				case ("uniform"): {_mainClass = "CfgWeapons"};
				case ("vest"): {_mainClass = "CfgWeapons"};
				case ("headgear"): {_mainClass = "CfgWeapons"};
				case ("backpack"): {_mainClass = "CfgWeapons"};
				case ("goggles"): {_mainClass = "CfgGlasses"};
				case ("aitem"): {_mainClass = "CfgWeapons"};
				default {_mainClass = "cfgVehicles"};
			};

			_name = getText (configFile >> _mainClass >> _id >> "displayName");
		};
	};
	_name;
}] call Server_Setup_Compile;

//collect item from a crate/garmant
["A3PL_Factory_CrateCollect",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_crate","_info","_classType","_id","_amount","_forFaction","_name","_mainClass","_fail"];
	_crate = param [0,objNull];
	_info = [_crate] call A3PL_Factory_CrateInfo;
	_classtype = _info select 0;
	_id = _info select 1;
	_amount = _info select 2;
	_forFaction = _info select 3;
	_name = [_id,_classType] call A3PL_Factory_CrateName;
	_owner = _crate getVariable ["owner",""];
	if (_owner != (getPlayerUID player)) exitwith {["System: You don't own this item, ask the owner to sell it to you in his shop",Color_Red] call A3PL_Player_Notification;};

	_correctFaction = false;
	if ((_forFaction != "All") && ((player getVariable ["faction","citizen"]) != _forFaction)) exitwith
	{
		_forFaction = [_forFaction] call A3PL_Lib_ParseFaction;
		[format ["System: This item can only be collected by someone within the %1 faction",_forFaction],Color_Red] call A3PL_Player_Notification;
	};

	_fail = false;
	switch (true) do
	{
		case (_classType == "item"):
		{
			//might want to call Server_Factory_Create later on, that will also take care of spawning items that cannot be picked up
			[_id,_amount] call A3PL_Inventory_Add;
		};
		case default //["car","weapon","magazine","mag","uniform","vest","headgear","backpack","goggles"]
		{
			switch (_classtype) do
			{
				case ("weapon"): {player addWeapon _id;};
				case ("magazine"): {for "_i" from 1 to (_amount) do {player addMagazine _id;};};
				case ("mag"): {for "_i" from 1 to (_amount) do {player addMagazine _id;};};
				case ("uniform"): {[_id] call A3PL_Lib_ChangeUniformSafe;};
				case ("vest"): {[_id] call A3PL_Lib_ChangeVestSafe;};
				case ("headgear"): {[_id] call A3PL_Lib_ChangeHeadgear;};
				case ("backpack"): {[_id] call A3PL_Lib_ChangeBackpackSafe;};
				case ("goggles"): {[_id] call A3PL_Lib_ChangeGoggles;};
				case ("aitem"): {player addItem _id; player assignItem _id;};
				default {_fail = true;};
			};
		};
	};
	if (_fail) exitwith {[format ["Error: Undefined _classType in _CrateCollect (ID: %1) > report this bug",_id],Color_Red] call A3PL_Player_Notification;};
	deleteVehicle _crate;
	[format ["System: You collected %1 %2",_amount,_name],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Check what's inside a crate/garmant
["A3PL_Factory_CrateCheck",
{
	private ["_crate","_info","_classType","_id","_amount","_forFaction","_name"];
	_crate = param [0,objNull];
	if ((isNil {_crate getVariable ["aInv",nil]}) && (isNil {_crate getVariable ["fInv",nil]})) exitwith
	{
		//regular item
		_id = _crate getVariable ["class",""];
		_amount = _crate getVariable ["amount",1];
		_name = [_id,"name"] call A3PL_Config_GetItem;
		[format ["System: There is %1 %2 inside this item",_amount,_name],Color_Green] call A3PL_Player_Notification;
	};
	_info = [_crate] call A3PL_Factory_CrateInfo;
	_classtype = _info select 0;
	_id = _info select 1;
	_amount = _info select 2;
	_forFaction = _info select 3;
	_name = [_id,_classType] call A3PL_Factory_CrateName;
	if (_forFaction != "All") then
	{
		_forFaction = [_forFaction] call A3PL_Lib_ParseFaction;
	};

	[format ["System: There is %1 %2 inside this item (for faction: %3)",_amount,_name,_forFaction],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
