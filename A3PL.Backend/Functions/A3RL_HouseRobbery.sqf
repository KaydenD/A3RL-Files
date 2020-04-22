 ["A3RL_HouseRobbery_Rob", {
	_house = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick to break into the house", Color_Red] call A3PL_Player_Notification;};
	if(_house getVariable ["robbing", false]) exitWith {["The house is already being robbed", Color_Red] call A3PL_Player_Notification;};

	_house setVariable ["robbing", true, true];

	Player_ActionCompleted = false;
	["Lockpicking house door...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  

	uiSleep 2.0;
	while{!Player_ActionCompleted} do 
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player || !(vehicle player == player)};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionCanceled = true;};
		if (!alive player) exitWith {Player_ActionCanceled = true;};
		if (!(vehicle player == player)) exitWith {Player_ActionCanceled = true;};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	if (!(vehicle player == player)) exitWith {};

	["v_lockpick",1] call A3PL_Inventory_Remove;
	_house setVariable ["unlocked", true, true];
	_house setVariable ["robbing", false, true];
	
	_box = createVehicle ["Land_MetalCase_01_large_F", [(getpos _house select 0),(getpos _house select 1),1], [], 0, "CAN_COLLIDE"];

	["You have successful broke into the house", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;