["A3RL_EvidenceLocker_Lockpick", {
	//Checks
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ActionDoing) exitwith {["You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You don't have a lockpick",Color_Red] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	
	//Alram
	_prison = getPos player nearestObject "Land_A3PL_Prison";
	playSound3D ["A3PL_Common\effects\lockdown.ogg", _prison];
	
	["v_lockpick", 1] call A3PL_Inventory_Remove;
	
	["Lockpicking...",7] spawn A3PL_Lib_LoadAction;
	
	
	while {!Player_ActionCompleted} do
	{
		player playMove 'Acts_carFixingWheel';
		if (player getVariable ["Incapacitated",false]) exitwith {};
		uiSleep 1.0;
	}
	
	player playmove "";
	
}] call Server_Setup_Compile;