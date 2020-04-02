["A3PL_SFP_SignOn",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	
	if (!(["sfp",player] call A3PL_DMV_Check)) exitwith {["You do not have a Security Firearms Permit required for this job!",Color_Red] call A3PL_Player_Notification;};
	
	if ((player getVariable ["job","unemployed"]) == "security") exitwith {["You no longer work for Fishers Island Security Services!",Color_Red]; [] call A3PL_NPC_LeaveJob};
	player setVariable ["job","security"];
	["You now work for Fishers Island Security Services!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_SFP_CheckIn",
{
	private ["_store"];
	_store = param [0,objNull];

	if(_store getVariable ["checkinCooldown",false]) exitWith{["System: This store was recently checked, please try again later!",Color_Red];};

	_store setVariable ["checkinCooldown",true];

	player setVariable ["player_cash",(player getVariable ["player_cash",0]) + 300,true];
	["System: You checked in at this checkpoint and earned $300!",Color_Green] call A3PL_Player_Notification;
	sleep 600;
	_store setVariable ["checkinCooldown",false];
}] call Server_Setup_Compile;
