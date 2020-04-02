//creates a list of markers
["Server_Resources_SearchMarkers",
{
	private ["_output"];
	_output = [];
	
	{
		private ["_name","_s","_c"];
		_s = _x splitstring "_";
		_c = count _s > 1; //continue
		if (_c && (_s select 0 == "Ore")) then
		{
			_output pushback _x;
		};
	} foreach allMapMarkers;
	_output;
}] call Server_Setup_Compile;

//Handle the damage to an ore
["Server_Resources_OreHandleDamage",
{
	private ["_ore","_projectile","_dmgValue"];
	_obj = param [0,objNull];
	_projectile = param [1,""];	
	
	if (!(_projectile IN ["A3PL_Shovel_Bullet","A3PL_PickAxe_Bullet"])) exitwith {}; //we arent using a pickaxe on this rock
	_dmgValue = _obj getVariable ["dmg",0];
	if (_dmgValue >= 1) exitwith //destroy and spawn small ores
	{
		private ["_pos","_oreClass","_arrayToCheck","_varname","_oreClass","_classname","_amount","_itemClass"];
		
		//code to delete from existing ore array
		_varname = _obj getVariable ["varName",""];
		_arrayToCheck = missionNameSpace getVariable [_varname,[]];
		{
			if (_x == _obj) exitwith
			{
				_arrayToCheck deleteAt _forEachIndex;
			}
		} foreach _arrayToCheck;
		missionNameSpace setVariable [_varname,_arrayToCheck,false];
		//end of array setting
		
		//get some info or ore
		_pos = getPos _obj;
		_oreClass = _obj getVariable ["oreClass","Metal"];
		
		//delete
		deleteVehicle _obj;
		
		//spawn small ores
		_amount = [_oreclass,"amount"] call A3PL_Config_GetOreConfig;
		_itemClass = [_oreclass,"itemclass"] call A3PL_Config_GetOreConfig;
		_classname = [_itemClass,"class"] call A3PL_Config_GetItem; //get classname of the item to spawn
		for "_i" from 0 to _amount-1 do
		{
			private ["_smallOre"];
			_smallOre = createVehicle [_classname,([_pos,0.2+random 1,random 360] call BIS_fnc_relPos),[],0,"CAN_COLLIDE"];
			_smallOre setVariable ["class",_itemClass,true];
		};		
	};
	_obj setVariable ["dmg",_dmgValue + 0.1,false]//set damage value
}] call Server_Setup_Compile;

//spawns ores in positions defined on the map
//Server_Ores is a global var which contains the markers we will have to spawn ores on
["Server_Resources_SpawnOres",
{
	if (isNil "Server_Ores") exitwith {diag_log "Error spawning ores: Server_Ores is undefined"};
	
	{
		private ["_class","_areaNumber","_amountOres","_classname","_min","_max","_varname","_amount","_ores"];
		
		//first determine if we should spawn more ores in a specific area
		_class = (_x splitString "_") select 1;
		_areaNumber = (_x splitString "_") select 2;
		
		//get all the ores in that area and clear any null objects
		_varname = format ["Server_Ores_%1_%2",_class,_areaNumber];
		_amountOres = count (missionNameSpace getVariable [_varname,[]]);
		
		
		//if there are no ores in that area we'll spawn new ones
		if (_amountOres < 1) then
		{		
			switch (_class) do
			{
				case ("Metal"): {_classname = "A3PL_Resource_Ore_Black";};
				case default {_classname = "A3PL_Resource_Ore_Black";}; //just a default ore
			};
			_min = [_class,"min"] call A3PL_Config_GetOreConfig;
			_max = [_class,"max"] call A3PL_Config_GetOreConfig;
			
			_amount = floor (_min + (random (_max-_min)));
			
			_ores = missionNameSpace getVariable [_varname,[]];
			for "_i" from 0 to _amount do
			{
				private ["_pos","_ore"];
				_pos = ([_x] call CBA_fnc_randPosArea) findEmptyPosition [0,25,_classname];
				_ore = createVehicle [_classname,_pos,[],0,"CAN_COLLIDE"];
				
				//set some variables we can reference later to determine what area, and what type this is
				_ore setVariable ["oreClass",_class];
				_ore setVariable ["area",_x];
				_ore setVariable ["varname",_varname]; //so we can delete it from this array later
				
				//add EH
				_ore addEventHandler ["HandleDamage",{[param [0,objNull],param [4,""]] spawn Server_Resources_OreHandleDamage;}];;
				
				//add to array
				_ores pushback _ore;
			};
			missionNameSpace setvariable [_varname,_ores];
		};
	} foreach Server_Ores;
}] call Server_Setup_Compile;