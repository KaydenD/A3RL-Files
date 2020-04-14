["A3RL_License_Buy", {
	private["_playercash"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	
	_playercash = player getvariable ["Player_Cash",0];
	
	if(_playercash >= 500) then {
		[[player, 'Player_Cash', ((player getVariable 'Player_Cash') - _towTruckPrice)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
		[player,"driver",true] remoteExec ["Server_DMV_Add",2];
	} else { 
		["You don't have enough money to purchase that",Color_Red] call A3PL_Player_Notification;
	};
	
}] call Server_Setup_Compile;