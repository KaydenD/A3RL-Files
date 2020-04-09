["A3RL_EvidenceLocker_Lockpick", {
	private["_locker"];
	_locker = cursorObject;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(!(_locker getVariable["locked", true])) exitWith {["The evidence locker is not locked!", Color_Red] call A3PL_Player_Notification;};
	if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must 3 Marshals on-duty to rob the evidence locker ", Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick the break into the evidence locker", Color_Red] call A3PL_Player_Notification;};
	
	//Alarm
	["usms", "!!! ALERT !!! The evidence locker is being robbed!"] spawn A3RL_Notify_Robbery;
	_prison = nearestObject [player, "Land_A3PL_Prison"];
	playSound3D ["A3PL_Common\effects\lockdown.ogg", _prison];
	
	Player_ActionCompleted = false;
	["Attempting to lockpick evidence locker...",44] spawn A3PL_Lib_LoadAction;
	
	while{!Player_ActionCompleted} do
	{
		if ((animationstate player) != "acts_carfixingwheel") then {
			player playMove 'Acts_carFixingWheel';
		};
		uiSleep 0.5;
	};
	player playMoveNow "";
	
	["v_lockpick",1] call A3PL_Inventory_Remove;
	_locker setVariable["locked", false];
}] call Server_Setup_Compile;