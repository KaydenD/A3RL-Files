["A3RL_PortRobbery_Rob",{
	_port = param[0, objNull];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(missionNamespace getVariable ["PortRobbery", false]) exitWith {["A port was robbed recently!", Color_Red] call A3PL_Player_Notification;};
	if ((count (["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 USCG on-duty to rob the port!", Color_Red] call A3PL_Player_Notification;}; 
	if(!(currentWeapon player != "")) exitWith {["You must have a weapon to rob the port", Color_Red] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["hgun_Pistol_Signal_F","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["You cannot rob the gas station with this!",Color_Red] call A3PL_Player_Notification;};
	_name = "Invaild Port";
	
	switch(_port) do 
	{ 
		case portrobbery_IE: {_name = "Import/Export"; };
		case portrobbery_Steel: {_name = "Steel Mill"; };
		case portrobbery_Wep: {_name = "Weapons Factory"; };
	};
	["uscg", format ["!!! ALERT !!! The %1 is being robbed!", _name]] spawn A3RL_Notify_Robbery;

	Player_ActionCompleted = false;
	["Robbing the port...",120] spawn A3PL_Lib_LoadAction;

	waitUntil {Player_ActionCompleted || !(alive player) || (_port distance2D player) > 3 || player getVariable ["Incapacitated",false]};
	if(!(alive player)) exitWith {Player_ActionCanceled = true;};
	if(player getVariable ["Incapacitated",false]) exitWith {Player_ActionCanceled = true;};
	if((_port distance2D player) > 3) exitWith {["You walked to far away from the port worker!", Color_Red] call A3PL_Player_Notification; Player_ActionCanceled = true;}; 

	["You successfully robbed the port! ", Color_Green] call A3PL_Player_Notification;
	[_port, random[1, 3, 5]] call A3RL_PortRobbery_GetReward;

	missionNamespace setVariable ["PortRobbery", true];
	uiSleep 600;
	missionNamespace setVariable ["PortRobbery", false];
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

	_veh = createVehicle ["GroundWeaponHolder", (getPosATL  player), [], 0, "CAN_COLLIDE"]; 
	{
		if(_x select _portNumber) then {
			_chance = random 100;
			if((_x select 6) > _chance) then {
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
					_veh addItemCargoGlobal[_class,_amount];
				};
			}; 
		};
	} forEach Config_PortRobbery;

}] call Server_Setup_Compile;