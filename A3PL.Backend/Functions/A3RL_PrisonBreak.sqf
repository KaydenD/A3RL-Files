["A3RL_PrisonBreak_Lockpick", {
	_building = param[0, objNull];
	_door = param[1, ""];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick to preform this action", Color_Red] call A3PL_Player_Notification;};
	if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 Marshals on-duty to break out", Color_Red] call A3PL_Player_Notification;};

	Player_ActionCompleted = false;
	["Attempting to lockpick cell door...",15] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
	uiSleep 2.0;
	while{!Player_ActionCompleted} do
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {};
		if (!alive player) exitWith {};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};

	["v_lockpick",1] call A3PL_Inventory_Remove;
	[_building,_door,false,1] call A3PL_Lib_ToggleAnimation;
	["You successfully lockpicked the cell door", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;


["A3RL_PrisonBreak_Search", {
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	Player_ActionCompleted = false;
	["Searching the trash...",10] spawn A3PL_Lib_LoadAction;
	while {!Player_ActionCompleted} do
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
		uiSleep 1.0;
	};

	_random = random 100;
	_foundSomething = false;
	switch (true) do {
		case (_random <= 5): {_foundSomething = true; ["You have found a lockpick in the trash", Color_Green] call A3PL_Player_Notification; ["v_lockpick", 1] call A3PL_Inventory_Add;};
		case (_random > 5 && _random <= 10): {_foundSomething = true; ["You have found a ziptie in the trash", Color_Green] call A3PL_Player_Notification; ["zipties", 1] call A3PL_Inventory_Add;};
		case (_random > 10 && _random <= 15): {_foundSomething = true; ["You have found keycard in the trash", Color_Green] call A3PL_Player_Notification; ["keycard", 1] call A3PL_Inventory_Add;};
	};
	
	if(!_foundSomething) exitWith {};
	["You have found nothing in the trash", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;