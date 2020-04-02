["A3PL_Locker_Rent",
{
	_locker = _this select 0;
	_lockerPrice = 7500;
	_playerCash = player getVariable["Player_Cash",0];
	if(_lockerPrice > _playerCash) exitWith {["You do not have enough money to rent this locker!", Color_Red] call A3PL_Player_Notification;};
	player setVariable ["Player_Cash",(_playerCash - _lockerPrice),true];
	_locker setVariable["owner",getPlayerUID player,true];
	[_locker, player] remoteExec ["Server_Locker_Insert",2];
	[format["You rent a locker for $%1",_lockerPrice], Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;