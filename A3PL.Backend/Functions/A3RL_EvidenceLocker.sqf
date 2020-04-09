["A3RL_EvidenceLocker_Lockpick", {
	private["_locker"];
	_locker = cursorObject;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(!(_locker getVariable["locked", true])) exitWith {["The evidence locker is not locked!", Color_Red] call A3PL_Player_Notification;};
	if ((count (["usms"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must 3 Marshals on-duty to rob the evidence locker ", Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick the break into the evidence locker", Color_Red] call A3PL_Player_Notification;};
	
	["usms", "!!! ALERT !!! The evidence locker is being robbed!"] spawn A3RL_Notify_Robbery;
	
	
	player playmove "Acts_carFixingWheel";
	
	Player_ActionCompleted = false;
	["Attempting to lockpick evidence locker...",44] spawn A3PL_Lib_LoadAction;
	
	while{!Player_ActionCompleted} do
	{
		if (animationstate player != "Acts_carFixingWheel") then {
			player playMove 'Acts_carFixingWheel';
		};
		if((player distance _locker) > 9) exitWith {["You walked to far away from the evidence locker", Color_Red] call A3PL_Player_Notification;};
		
		
		//uiSleep 1.0;
		
		/*
		if (animationstate player != "Acts_carFixingWheel") then {
			[[player,"Acts_carFixingWheel"],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
		};
		uiSleep 1;
		*/
	};
	
	player playmove "";
	_locker setVariable["locked", false];
}] call Server_Setup_Compile;