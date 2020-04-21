["A3RL_GasRobbery_Start", {
	_station = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(missionNamespace getVariable ["GasRobbery", false]) exitWith {["A gas station was robbed recently!", Color_Red] call A3PL_Player_Notification;};
	if ((count (["police"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 police officers on-duty to rob the gas station", Color_Red] call A3PL_Player_Notification;};
	if(!(currentWeapon player != "")) exitWith {["You must have a weapon to rob the gas station", Color_Red] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["hgun_Pistol_Signal_F","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["You cannot rob the gas station with this!",Color_Red] call A3PL_Player_Notification;};

	missionNamespace setVariable ["GasRobbery", true];

	_name = "";
	switch(_station) do 
	{
		case npc_gasstation_1: { _name = "Stoney Creek"; };
		case npc_gasstation_2: { _name = "Beach Valley"; };
		case npc_gasstation_3: { _name = "Impound"; };
		case npc_gasstation_4: { _name = "Bellas"; };
		case npc_gasstation_5: { _name = "Elk City"; };
		case npc_gasstation_6: { _name = "King's Landing"; };
		case npc_gasstation_7: { _name = "Northdale"; };
		case npc_gasstation_8: { _name = "Mexican Hill"; };
	};

	["police", format ["Robbery in-progress at the %1 gas station", _name]] spawn A3RL_Notify_Robbery;

	Player_ActionCompleted = false;
	["Robbing the Gas Station...",30] spawn A3PL_Lib_LoadAction;

	waitUntil {Player_ActionCompleted || !(alive player) || (_station distance2D player) > 3 || player getVariable ["Incapacitated",false]};
	if(!(alive player)) exitWith {Player_ActionCanceled = true;};
	if(player getVariable ["Incapacitated",false]) exitWith {Player_ActionCanceled = true;};
	if((_station distance2D player) > 3) exitWith {["You walked to far away from the gas station!", Color_Red] call A3PL_Player_Notification; Player_ActionCanceled = true;}; 

	_money = round(random [1000, 5000, 10000]);

	[format["You successfully stole %1 from the gas station", _money], Color_Green] call A3PL_Player_Notification;
	[[player, 'Player_Cash', ((player getVariable 'Player_Cash') + _money)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	uiSleep 600;
	missionNamespace setVariable ["GasRobbery", false];
}] call Server_Setup_Compile;