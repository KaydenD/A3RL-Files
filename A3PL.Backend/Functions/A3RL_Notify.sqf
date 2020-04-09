["A3RL_Notify_Robbery", 
{
	_job = param [0, ""];
	_msg = param [1, ""];
	{
		if((_x getVariable ["job",""]) == _job) then {
			[_msg, Color_Red] remoteExec ["A3PL_Player_Notification",_x];
			[_msg, Color_Red] remoteExec ["A3PL_Player_Notification",_x];
			[_msg, Color_Red] remoteExec ["A3PL_Player_Notification",_x];
		};
	} forEach allPlayers;
}] call Server_Setup_Compile;