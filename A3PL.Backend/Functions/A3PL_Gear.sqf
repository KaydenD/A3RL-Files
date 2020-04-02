["A3PL_Gear_CheckSpace", {
	private ["_classname", "_gearType", "_return", "_primaryWeapon", "_secondaryWeapon", "_canAdd"];
	
	_classname = param [0,""];
	_player = param [1,player];
	_gearType = [_classname] call A3PL_Gear_Type;
	_return = _player canAdd _classname;

	switch (_gearType) do {
		case "primaryweapon": {
			if ((primaryWeapon _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};

		case "sidearmweapon": {
			if ((secondaryWeapon _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};

		case "secondaryweapon": {
			if ((secondaryWeapon _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};

		case "backpack": {
			if ((backpack _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};

		case "vest": {
			if ((vest _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};
		
		case "headgear": {
			if ((headgear _player) isEqualTo "") then {
				_return = true;
			}else{
				_return = false;
			};
		};
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Gear_Type", {
	private ["_classname", "_gearType", "_weaponType", "_magazineType", "_return"];
	_classname = [_this, 0] call BIS_fnc_param;
	_gearType = [format["%1", _classname], "type"] call A3PL_Config_GetGear;
	_return = false;

	if (_gearType isEqualTo "weapon") then {
		_weaponType = getNumber(configFile >> "cfgWeapons" >> _classname >> "type");
		
		switch (_weaponType) do {
			case 1: { 
				_return = "primaryweapon";
			};
	
			case 2: { 
				_return = "sidearmweapon";
			};
	
			case 16: { 
				_return = "secondaryweapon";
			};
		};
	};

	if (_gearType isEqualTo "magazine") then {
		_magazineType = getNumber(configFile >> "cfgMagazines" >> _classname >> "type");

		switch (_magazineType) do {
			case 256: { 
				_return = "primarymagazine";
			};
	
			case 16: { 
				_return = "sidearmmagazine";
			};
		};
	};

	if (_gearType isEqualTo "item") then {
		_return = "item";
	};

	if (_gearType isEqualTo "backpack") then {
		_return = "backpack";
	};
	
	if (_gearType isEqualTo "headgear") then {
		_return = "headgear";
	};	

	_return;
}] call Server_Setup_Compile;