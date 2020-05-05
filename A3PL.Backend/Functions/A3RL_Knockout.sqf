["A3RL_KnockedOut",
{
	[] spawn {
		["You've been knocked out", Color_Red] call A3PL_Player_Notification;
		_effect = ["DynamicBlur",[5]] call A3PL_Lib_PPEffect;
		player setVariable ["knockedout",true,true];
		player playMoveNow "unconscious";
		disableUserInput true;
		sleep 15;
		disableUserInput false;
		player playMoveNow "AmovPpneMstpSrasWrflDnon";
		player setVariable ["knockedout",false,true];
		_effect ppEffectEnable false;
		ppEffectDestroy _effect;
	};
}] call Server_Setup_Compile;