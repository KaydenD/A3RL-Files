["A3RL_EvidenceLocker_Lockpick", {
	private["_locker"];
	_locker = cursorObject;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(!(_locker getVariable["locked", true])) exitWith {["The evidence locker is not locked!", Color_Red] call A3PL_Player_Notification;};
	//if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 Marshals on-duty to rob the evidence locker ", Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick the break into the evidence locker", Color_Red] call A3PL_Player_Notification;};
	if(_locker getVariable["robbing", false]) exitWith {["The evidence locker is already being robbed!", Color_Red] call A3PL_Player_Notification;};
	
	_locker setVariable["robbing", true, true];
	
	//Alarm
	["usms", "!!! ALERT !!! The evidence locker is being robbed!"] spawn A3RL_Notify_Robbery;
	_prison = nearestObject [player, "Land_A3PL_Prison"];
	playSound3D ["A3PL_Common\effects\lockdown.ogg", _prison];
	
	Player_ActionCompleted = false;
	["Attempting to lockpick evidence locker...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	uiSleep 0.5;
	while{!Player_ActionCompleted} do
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player};
		if (player getVariable ["Incapacitated",false]) exitwith {};
		if (!alive player) exitWith {};
		player switchMove ""; 
        player playMoveNow "Acts_carFixingWheel";  
	};
	player switchMove ""; 
	
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	
	["v_lockpick",1] call A3PL_Inventory_Remove;
	_locker setVariable["locked", false, true];
	_locker setVariable["robbing", false, true];
	
	["You have successful broke into the evidence locker! It's now open", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_EvidenceLocker_Secure", {
	private["_locker"];
	_locker = cursorObject;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	Player_ActionCompleted = false;
	["Securing evidence locker...",30] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	uiSleep 0.5;
	while{!Player_ActionCompleted} do
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",true] || !alive player};
		if (player getVariable ["Incapacitated",true]) exitwith {};
		if (!alive player) exitWith {};
		player switchMove ""; 
        player playMoveNow "Acts_carFixingWheel";  
	};
	player switchMove ""; 
	
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	
	_locker setVariable["locked", true, true];
}] call Server_Setup_Compile;