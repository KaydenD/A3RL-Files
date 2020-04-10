["A3RL_EvidenceLocker_Lockpick", {
	private["_locker"];
	_locker = cursorObject;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(!(_locker getVariable["locked", true])) exitWith {["The evidence locker is not locked!", Color_Red] call A3PL_Player_Notification;};
	if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 Marshals on-duty to rob the evidence locker ", Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick the break into the evidence locker", Color_Red] call A3PL_Player_Notification;};
	
	//Alarm
	["usms", "!!! ALERT !!! The evidence locker is being robbed!"] spawn A3RL_Notify_Robbery;
	_prison = nearestObject [player, "Land_A3PL_Prison"];
	playSound3D ["A3PL_Common\effects\lockdown.ogg", _prison];
	
	Player_ActionCompleted = false;
	["Attempting to lockpick evidence locker...",44] spawn A3PL_Lib_LoadAction;
	

	player switchMove "Acts_carFixingWheel";
	_event = player addEventHandler ["AnimDone", {
		params ["_unit", "_anim"];
		if ( _anim == "Acts_carFixingWheel") then {  //Make sure function is not break out by other anims 
        	player switchMove "Acts_carFixingWheel";       
		};
	}];
	waitUntil{Player_ActionCompleted};
	player removeEventHandler ["AnimDone", _event];
	player switchMove "";
	
	["v_lockpick",1] call A3PL_Inventory_Remove;
	_locker setVariable["locked", false, true];
}] call Server_Setup_Compile;
