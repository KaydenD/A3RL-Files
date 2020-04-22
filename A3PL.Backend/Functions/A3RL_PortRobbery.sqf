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
		case portrobbery_IE: {_portNumber = 3};
		case portrobbery_Steel: {_portNumber = 4};
		case portrobbery_Wep: {_portNumber = 5};
	};

	{
		if(_x select _portNumber) then {
			_chance = random 100;
			if((_x select 6) < _chance) then {
				if(_x select 7 == "virtual") then {
					_class = _x select 0;
					_amountMin = _x select 1;
					_amountMax = _x select 2;
					_amount = round(random[_amountMin,_amountMin + ((_amountMax - _amountMin)/2),_amountMax]);
					[_class, _amount] call A3PL_Inventory_Add;
					[format ["You stole %1x %2", _amount, ([_class] call A3RL_Inventory_ItemName)], Color_Green] call A3PL_Player_Notification;
				} else {
					_class = _x select 0;
					_amountMin = _x select 1;
					_amountMax = _x select 2;
					_amount = round(random[_amountMin,_amountMin + ((_amountMax - _amountMin)/2),_amountMax]);
					_veh = createVehicle ["GroundWeaponHolder", (getPosATL  player), [], 0, "CAN_COLLIDE"]; 
					_veh addItemCargoGlobal[_class,_amount];
				};
			};
		};
	} forEach Config_PortRobbery;

}] call Server_Setup_Compile;