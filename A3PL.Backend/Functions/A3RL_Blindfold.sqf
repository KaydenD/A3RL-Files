["A3RL_Blindfold", {
	_unit = param[0, objNull];
	[] remoteExec ["A3RL_Blindfold_Receive", _unit];
	[false] call A3PL_Inventory_PutBack;
	["headbag", 1] call A3PL_Inventory_Remove;
	["Successfully Blindfolded Player", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Blindfold_Receive", {
	["You've been blindfolded", Color_Red] call A3PL_Player_Notification;
	player addHeadgear "A3RL_Headbag";
	["A3RL_headbag\headbag_overlay.paa", 0, 0] call A3PL_HUD_SetOverlay;
	player setVariable ["A3RL_Blindfolded", true, true];
}] call Server_Setup_Compile;

["A3RL_Remove_Blindfold", {
	_unit = param[0, objNull];
	[] remoteExec ["A3RL_Remove_Blindfold_Receive", _unit];
	["headbag", 1] call A3PL_Inventory_Add;
	["You've removed the headbag", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Remove_Blindfold_Receive", {
	["Your blindfold has been removed", Color_Red] call A3PL_Player_Notification;
	player removeHeadgear "A3RL_Headbag";
	["", 0, 0] call A3PL_HUD_SetOverlay;
	player setVariable ["A3RL_Blindfolded", false, true];
}] call Server_Setup_Compile;