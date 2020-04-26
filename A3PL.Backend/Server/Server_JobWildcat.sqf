//dmg value from which ore will get removed
#define OREDMGDISS 0.55

//Randomizes the oil around the island and publicvariables the resulting variable
["Server_JobWildcat_RandomizeOil", 
{	
	Server_JobWildCat_Oil = [];
	
	//50 areas for now
	for "_i" from 0 to 76 do
	{
		private ["_randPos","_overWater"];
		
		_randPos = ["OilSpawnArea"] call CBA_fnc_randPosArea;
		_overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
		while {_overWater} do
		{
			_randPos = ["OilSpawnArea"] call CBA_fnc_randPosArea;
			_overWater = !(_randPos isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
		};
		
		//oilAmount in gallons, 5 levels
		_oilAmounts = [50,75,80,100,110,140,160,180,200,250];
		_r = floor random 10;
		_arr = [_randPos,(_oilAmounts select _r)];
		
		Server_JobWildCat_Oil pushback _arr;
	};	
	
	publicVariable "Server_JobWildCat_Oil";
	
},true] call Server_Setup_Compile;


["Server_JobWildcat_CheckResTimers", 
{
	{
		_time = _x select 3;
		if(diag_tickTime > _time) then {
			Server_JobWildCat_Res deleteAt _forEachIndex;
		};
	} forEach Server_JobWildCat_Res;
	publicVariable "Server_JobWildCat_Res";
},true] call Server_Setup_Compile;

["Server_JobWildcat_CreateResFromMap", 
{
	_type = param[0,""];
	_pos = param[1,[0,0,0]];
	Server_JobWildCat_Res pushback [_type, _pos, 25, diag_tickTime + 1800];
	publicVariable "Server_JobWildCat_Res";
},true] call Server_Setup_Compile;

["Server_JobWildCat_SpawnRes",
{
	private ["_player","_foundOre","_objClass","_obj"];
	_player = param [0,objNull];
	_foundOre = param [1,""];
	switch (_foundOre) do
	{
		case ("iron"): {_objClass = "A3PL_Resource_Ore_Pink";};
		case ("coal"): {_objClass = "A3PL_Resource_Ore_Black";};
		case ("aluminium"): {_objClass = "A3PL_Resource_Ore_Orange";};
		case ("sulphur"): {_objClass = "A3PL_Resource_Ore_Yellow";};
	};
	
	if (isNil "_objClass") exitwith {};
	_obj = createVehicle [_objClass,_player, [], 0, "CAN_COLLIDE"];
	_obj setVariable ["oreClass",_foundOre,false];
	
	//set some other vars
	{
		if ((toLower (_x select 0)) == _foundOre) exitwith
		{
			_obj setVariable ["smallOreItemClass",_x select 5,false];
			_obj setVariable ["smallOreAmount",_x select 6,false];
			//_obj setVariable ["smallOreClass",([(_x select 5),"class"] call A3PL_Config_GetItem),false];
		};
	} foreach Config_Resources_Ores;
	_obj addEventHandler ["HandleDamage",
	{
		private ["_sel","_obj","_dmg","_giveEach","_oreClass","_className","_itemClass","_pos","_ins","_newdmg","_wep","_prevDamage","_random"];
		_obj = param [0,objNull];		
		_sel = param [1,""];
		_ins = param [6,objNull]; //instigator 
		_wep = currentWeapon _ins;
		if (typeOf vehicle _ins == "A3PL_MiniExcavator") then {_wep = vehicle _ins currentWeaponTurret [0];};
		_dmg = param [2,0]; //new damage on hitpoint
		_oldDmg = _obj getVariable ["dmg",0];
		_giveEach = _obj getVariable ["smallOreAmount",1];
		_newDmg = _dmg;
		_prevDamage = _obj getVariable [format ["%1_dmg",_sel],0];
		if (hasInterface) then //editor debug
		{
			hintSilent format ["%1",_this];
		};
		if ((_dmg >= OREDMGDISS) && (_sel == "hitpickaxe")) exitwith {deleteVehicle _obj;};
		if ((_dmg >= (_oldDmg + (OREDMGDISS / _giveEach))) && (_sel == "hitpickaxe") && (_wep IN ["A3PL_Machinery_Pickaxe","A3PL_Pickaxe"])) then
		{
			_random = random 100;//random chance for treasure
			if (_random < 10) then
			{
				_random = random 100;
				switch (true) do
				{					
					case (_random < 1): {_itemClass = "diamond";};
					case (_random < 4): {_itemClass = "diamond_emerald";};
					case (_random < 9): {_itemClass = "diamond_ruby";};
					case (_random < 19): {_itemClass = "diamond_sapphire";};
					case (_random < 30): {_itemClass = "diamond_alex";};
					case (_random < 50): {_itemClass = "diamond_aqua";};
					case (_random <= 100): {_itemClass = "diamond_tourmaline";};
				};
				[_ins,_itemClass,1] call Server_Inventory_Add;
				["Server: You found a RARE GEM STONE! It has been placed in your inventory", Color_Green] remoteExec ["A3PL_Player_Notification", (owner _ins)];				
			} else
			{
				_itemClass = _obj getVariable ["smallOreItemClass","ore_metal"];
				[_ins,_itemClass,1] call Server_Inventory_Add;
				["Server: You succesfully mined one ore, it has been placed in your inventory", Color_Green] remoteExec ["A3PL_Player_Notification", (owner _ins)];				
			};
			_obj setVariable ["dmg",_dmg,false];
		};
		if ((_sel == "hitshovel") && (!(_wep IN ["A3PL_Machinery_Bucket","A3PL_Shovel"]))) then { _newDmg = _prevDamage;};
		if ((_sel == "hitpickaxe") && (!(_wep IN ["A3PL_Machinery_Pickaxe","A3PL_Pickaxe"]))) then { _newDmg = _prevDamage;};
		_obj setVariable [format ["%1_dmg",_sel],_newdmg,false];
		_newDmg;
	}];
},true] call Server_Setup_Compile;