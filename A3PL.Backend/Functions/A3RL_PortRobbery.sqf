Config_PortRobbery = [
	//Class, Amount, IE, Steel Mill, Wep Factory, Chance
	["weed_5g",1,true,true,true, 20],
	["weed_10g",1,true,true,true, 7],
	["weed_15g",1,true,true,true, 10],
	["weed_20g",1,true,true,true, 80],
	["weed_25g",1,true,true,true, 5],
	["weed_30g",1,true,true,true, 3],
	["weed_35g",1,true,true,true, 13],
	["weed_40g",1,true,true,true, 15],
	["weed_45g",1,true,true,true, 17]
];


["A3RL_PortRobbery_Rob",{
	_port = param[0, objNull];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if ((count (["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 USCG on-duty to rob the port!", Color_Red] call A3PL_Player_Notification;}; 
	if(!(currentWeapon player != "")) exitWith {["You must have a weapon to rob the port", Color_Red] call A3PL_Player_Notification;};
	if(_port getVariable ["cooldown", false]) exitWith {["The port was robbed recently", Color_Red] call A3PL_Player_Notification;};
	_name = "Invaild Port";
	
	switch(_port) do 
	{ 
		case portrobbery_IE: {_name = "Import/Export"; };
		case portrobbery_Steel: {_name = "Steel Mill"; };
		case portrobbery_Wep: {_name = "Weapons Factory"; };
	};
	["uscg", format ["!!! ALERT !!! The %1 is being robbed!", _name]] spawn A3RL_Notify_Robbery;

	Player_ActionCompleted = false;
	["Robbing the port...",10] spawn A3PL_Lib_LoadAction;

	waitUntil {Player_ActionCompleted || !(alive player) || (_port distance2D player) > 3 || player getVariable ["Incapacitated",false]};
	if(!(alive player)) exitWith {Player_ActionCanceled = true;};
	if(player getVariable ["Incapacitated",false]) exitWith {Player_ActionCanceled = true;};
	if((_port distance2D player) > 3) exitWith {["You walked to far away from the port worker!", Color_Red] call A3PL_Player_Notification; Player_ActionCanceled = true;}; 

	["You successfully robbed the port! ", Color_Green] call A3PL_Player_Notification;
	[_port, random[1, 3, 5]] call A3RL_PortRobbery_GetReward;

	_port setVariable["cooldown", true, true];
	uiSleep 600;
	_port setVariable["cooldown", false, true];
}] call Server_Setup_Compile;


["A3RL_PortRobbery_GetReward", {
	_port = param[0, objNull]; 
	_items = param[1, 0];
	
	_portNumber = 0;
	switch(_port) do
	{
		case portrobbery_IE: {_portNumber = 2};
		case portrobbery_Steel: {_portNumber = 3};
		case portrobbery_Wep: {_portNumber = 4};
	};

	_portChance = 0;
	_portReward = [];
	{
		if(_x select _portNumber) then {
			_portChance = _portChance + (_x select 5);
			_portReward pushBack [_x select 0, _x select 1, _x select 5];
		};
	} forEach Config_PortRobbery;

	for "_i" from 1 to _items do {
		_chance = random _portChance;
		_count = 0;
		{
			_count = _count + (_x select 2);
			if(_chance < _count) exitWith {
				_class = _x select 0;
				_amount = _x select 1;

				[_class, _amount] call A3PL_Inventory_Add;
				[format ["You stole %1x %2", _amount, ([_class] call A3RL_Inventory_ItemName)], Color_Green] call A3PL_Player_Notification;
			};
		} forEach _portReward;
	};

}] call Server_Setup_Compile;