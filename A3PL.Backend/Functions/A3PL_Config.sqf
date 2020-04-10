["A3PL_Config_GetItem", {
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	if (_class == "") exitWith {false};

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Items;
	
	if (count _config == 0) exitwith {false;};

	switch (_search) do {
		default { _return = _config; };
		case "name": 
		{			
			_return = _config select 1; 
			if (_return == "inh") then 
			{
				_return = getText (configFile >> "CfgVehicles" >> (_config select 3) >> "displayName");
			};
		};
		case "icon":
		{
			_return = getText (configFile >> "CfgVehicles" >> (_config select 3) >> "picture");
		};
		case "weight": { _return = _config select 2; };
		case "class": { _return = _config select 3; };
		case "dir": { _return = _config select 4; };
		case "canDrop": { _return = _config select 5; };
		case "canGive": { _return = _config select 6; };
		case "canUse": { _return = _config select 7; };
		case "canPickup": { _return = _config select 8; };
		case "simulation": { _return = _config select 9; };
		case "fnc": { _return = _config select 10; };
		case "attach": { _return = _config select 11; };
		case "desc": { _return = _config select 12; };
		case "needsWeaponHolder": { if (count _config < 15) then {_return = false;} else {_return = _config select 13;};};
		case "holderName": { if (count _config < 15) then {_return = "";} else {_return = _config select 14;};};
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetLicense",
{
	private ["_class", "_search","_config"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";	
	
	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Licenses;

	switch (_search) do {
		default { _return = _config; };
		case "name": { _return = _config select 1; };
	};

	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetPaycheckInfo", {
	private ["_class", "_search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Paychecks;

	switch (_search) do {
		default { _return = _config; };
		case "pay": { _return = _config select 1; };
		case "xp": { _return = _config select 2; };
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetFood", {
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Food;

	switch (_search) do {
		default { _return = _config; };
		case "quality": { _return = _config select 1; };
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetThirst",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Thirst;

	switch (_search) do {
		default { _return = _config; };
		case "quality": { _return = _config select 1; };
	};

	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetShop", {
	private ["_class", "_Search","_itemClass", "_config", "_return"];

	_class = param [0,""];
	_itemClass = param [1,""];
	_search = param [2,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) exitwith {
			if (_itemClass == "pos") then {_config = _x select 2;} else
			{
				_config = _x select 1;
			};	
		};
	} forEach Config_Shops_Items;
	
	if (_search == "") exitwith 
	{
		_return = _config; 
		_return;
	};
	
	/*
	switch (_search) do {
		default { _return = _config; };
		case "name": { _return = _config select 1; };
		case "type": { _return = _config select 2; };
		case "class": { _return = _config select 3; };
		case "buyPrice": { _return = _config select 4; };
		case "sellPrice": { _return = _config select 5; };
		case "stock": { _return = _config select 6; };
		case "whitelist": {_return = _config select 7; };
		case "allowedsell": { if (count _config > 8) then { _return = _config select 8; } else {_return = [(_config select 3)];}; };
	};
	_return;
	*/
}] call Server_Setup_Compile;

["A3PL_Config_GetGear", {
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Gear;

	switch (_search) do {
		default { _return = false; };
		case "name": { _return = _config select 1; };
		case "type": { _return = _config select 2; };
		case "weaponType": { _return = _config select 2; };
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetLevel", {
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Levels;

	switch (_search) do {
		default { _return = false; };
		case "next": { _return = _config select 1; };
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Config_GetOreConfig",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Resources_Ores;

	switch (_search) do {
		default { _return = false; };
		case "minArea": { _return = _config select 1; };
		case "maxArea": { _return = _config select 2; };
		case "min": { _return = _config select 3; };
		case "max": { _return = _config select 4; };		
		case "itemclass": { _return = _config select 5; };
		case "amount": { _return = _config select 6; }; //amount of ores to spawn once mined
	};

	_return;	
}] call Server_Setup_Compile;

//Select from Config_Factories
["A3PL_Config_GetFactory",
{
	private ["_class","_factory","_search", "_config", "_return"];

	_class = param [0,""];
	_factory = param [1,""];
	_search = param [2,""];
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _factory) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main factory config
		};
	} forEach Config_Factories;
	
	if (_class == "all") exitwith { _return = _config; _return deleteAt 0; _return deleteAt 0; _return;};
	if (_class == "pos") exitwith { _return = _config select 1; _return;};
	
	//we are looking for individual recipe info
	
	_config deleteAt 0; //dont need title, array shifting
	_config deleteAt 0; //dont need pos
	{
		if (_x select 0 == _class) then {_config = _x};
	} foreach _config; //we get the item here
	switch (_search) do { //look for
		case "id": { _return = _config select 0; };
		case "parent": { _return = _config select 1; };
		case "name": { _return = _config select 2; };
		case "img": { _return = _config select 3; };
		case "class": { _return = _config select 4; };
		case "type": { _return = _config select 5; };
		case "craftable": { _return = _config select 6; };
		case "time": { _return = _config select 7; };
		case "required": { _return = _config select 8; };
		case "output": { _return = _config select 9; };
		case "faction": { _return = _config select 10; };
		default { _return = false; };
	};		

	//hint format ["_class: %1 // _factory: %2 // _search: %3 // _config: %4 // _return: %5",_class,_factory,_search,_config,_return];

	_return;	
}] call Server_Setup_Compile;

//Select from player_factory variable
["A3PL_Config_GetPlayerFactory",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";
	
	{
		if ((_x select 0) == _class) then {
			_config = _x;
		};
	} forEach (player getVariable ["player_factories",[]]);

	switch (_search) do {
		default { _return = false; };
		case "craftID": { _return = _config select 0; };
		case "classname": { _return = _config select 1; };
		case "required": { _return = _config select 2; };
		case "type": { _return = _config select 3; };
		case "classtype": { _return = _config select 4; };
		case "id": { _return = _config select 5; };
		case "amount": { _return = _config select 6; };
		case "finish": { _return = _config select 7; };
	};

	_return;	
}] call Server_Setup_Compile;

//Select from player_fstorage var
["A3PL_Config_GetPlayerFStorage",
{
	private ["_class", "_Search", "_config", "_return","_player"];

	_class = param [0,""];
	_search = param [1,""];
	_player = param [2,player];
	_config = [];
	_return = "";
	
	{
		if ((_x select 0) == _class) then {
			_config = _x;
		};
	} forEach (_player getVariable ["player_fStorage",[]]);
	
	if (count _config == 0) exitwith {_return = false; _return;};

	switch (_search) do {
		default { _return = false; };
		case "type": { _return = _config select 0; }; //fac type
		case "items": { _return = _config select 1; }; //the array with items in this storage
	};

	_return;	
}] call Server_Setup_Compile;

["A3PL_Config_GetBusinessItem",
{
	private ["_class", "_search", "_config", "_return"];
	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	{
		if ((_x select 0) == _class) then {
			_config = _x;
		};
	} forEach Config_Business_Items;
	
	if (count _config == 0) exitwith {_return = false; _return;};

	switch (_search) do {
		default { _return = false; };
		case "class": { _return = _config select 0; }; //fac type
		case "type": { _return = _config select 1; }; //the array with items in this storage
		case "min": { _return = _config select 2; }; //min price
		case "max": { _return = _config select 3; };
		case "bmin": { _return = _config select 4; };
		case "bmax": { _return = _config select 5; };		
	};

	_return;		
}] call Server_Setup_Compile;

//Select from Config_Garage_Upgrade
["A3PL_Config_GetGarageUpgrade",
{
	private ["_class","_typeOf","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_typeOf = param [1,""]; //classname of veh
	_search = param [2,""]; //info to search
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _typeOf) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main factory config
		};
	} forEach Config_Garage_Upgrade;
	
	if (_class == "all") exitwith { _return = _config; _return deleteAt 0; _return;};
	
	_config deleteAt 0; //dont need typeof, array shifting
	{
		if (_x select 0 == _class) then {_config = _x};
	} foreach _config; //we get the item here
	switch (_search) do { //look for
		case "id": { _return = _config select 0; }; //id
		case "type": { _return = _config select 1; }; //upgrade type
		case "class": { _return = _config select 2; }; //upgrade class
		case "title": { _return = _config select 3; }; //upgrade title
		case "desc": { _return = _config select 4; }; //upgrade description
		case "camTarget": { _return = _config select 5; }; //cam target location
		case "camOffset": { _return = _config select 6; }; //cam offset from Target
		case "price": { _return = _config select 7; }; //install price
		case "required": { _return = _config select 8; }; //required items for upgrade
		default { _return = false; };
	};		

	_return;	
}] call Server_Setup_Compile;

//Select from config the textures
["A3PL_Config_GetGaragePaint",
{
	private ["_class","_typeOf","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_typeOf = format ["%1_Textures",(param [1,""])]; //classname of veh
	_search = param [2,""]; //info to search
	_config = [];
	_return = "";
	
	{
		_config = _config + 
			[
				[
					(configName _x),
					(getArray (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "Texture_Path")),
					(getText (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "Name")),
					(getArray (configFile >> "CfgVehicles" >> _typeOf >> "Skins" >> (configName _x) >> "Allowed_GUID"))
				]
			];
				
	} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _typeOf >> "Skins"));
	
	if (_class == "all") exitwith { _return = _config; _return;};
	
	{
		if (_x select 0 == _class) then {_config = _x};
	} foreach _config; //we get the item here
	switch (_search) do { //look for
		case "id": { _return = _config select 0; }; //id
		case "file": { _return = _config select 1; }; //texture file
		case "title": { _return = _config select 2; }; //name of skin
		case "allowed": { _return = _config select 3; };
		default { _return = false; };
	};		

	_return;	
}] call Server_Setup_Compile;

//Select from Config_Garage_Repair
["A3PL_Config_GetGarageRepair",
{
	private ["_class","_search", "_config", "_return"];

	_class = param [0,""]; //id to search
	_search = param [1,""]; //info to search
	_config = [];
	_return = "";
	
	{
		if(_x select 0 == _class) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main factory config
		};
	} forEach Config_Garage_Repair;
	
	if (count _config == 0) exitwith {_return = false; _return};

	switch (_search) do { //look for
		case "id": { _return = _config select 0; }; //id
		case "title": { _return = _config select 1; }; //name of repair
		default { _return = false; };
	};		

	_return;	
}] call Server_Setup_Compile;

//get faction ranks
["A3PL_Config_GetRanks",
{
	private ["_class","_search", "_config", "_return", "_index"];

	_class = param [0,""]; //id to search
	_search = param [1,""]; //info to search
	_config = [];
	_return = "";
	_index = -1;
	
	{
		if(_x select 0 == _class) then 
		{
			_config = [] + _x; //save a copy to prevent deleteAt delete the title from main config
			_index = _forEachIndex;
		};
	} forEach Server_Government_FactionRanks;
	
	if (count _config == 0) exitwith {_return = [[],_index]; _return};

	switch (_search) do { //look for
		case "faction": { _return = _config select 0; };
		case "ranks": { _return = _config select 1; };
		default { _return = false; };
	};		

	_return = [_return,_index]; //this function also returns the index
	_return;	
}] call Server_Setup_Compile;

//get stuff from Config_Medical_Wounds
["A3PL_Config_GetWound",
{
	private ["_class", "_Search", "_config", "_return"];

	_class = param [0,""];
	_search = param [1,""];
	_config = [];
	_return = "";

	if (_class == '') exitWith {false};

	{
		if(_x select 0 == _class) then {
			_config = _x;
		};
	} forEach Config_Medical_Wounds;
	
	if (count _config == 0) exitwith {false;};

	switch (_search) do {
		default { _return = _config; };
		case "class": { _return = _config select 0; };
		case "name": { _return = _config select 1; };
		case "color": { _return = _config select 2; };
		case "bloodLossInstant": { _return = _config select 3; };
		case "bloodLoss": { _return = _config select 4; };
		case "painLevel": { _return = _config select 5; };
		case "itemTreat": { _return = _config select 6; };
		case "doesTreatHeal": { _return = _config select 7; };
		case "itemHeal": { _return = _config select 8; };
	};

	_return;
}] call Server_Setup_Compile;