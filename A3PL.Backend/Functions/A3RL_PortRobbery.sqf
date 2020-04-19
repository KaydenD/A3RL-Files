["A3RL_PortRobbery_Rob",{
	_port = param[0, objNull];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	//if ((count (["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 USCG on-duty to rob the port!", Color_Red] call A3PL_Player_Notification;}; 
	if(!(currentWeapon player != "")) exitWith {["You must have a weapon to rob the port", Color_Red] call A3PL_Player_Notification;};
	if(_port getVariable ["cooldown", false]) exitWith {["The port was robbed recently", Color_Red] call A3PL_Player_Notification;};
	_name = "Invaild Port";

	//Get Port Name
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

	_port setVariable["cooldown", true, true];
	uiSleep 600;
	_port setVariable["cooldown", false, true];
}] call Server_Setup_Compile;