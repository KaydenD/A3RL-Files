//Variables only the server can change
['Server_Player_BLVariablesSetup', {
	private ['_player'];

	_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

	if (isNull _player) exitWith {};

	//_player setVariable ["Player_Cash", 0, true]; //Remove this shit later
	//_player setVariable ["Player_Bank", 500, true];
	//_player setVariable ['Player_Inventory', [], true];
	_player setVariable ["Player_XP", 0, true];
	_player setVariable ["Player_Level", 0, true];
}, true] call Server_Setup_Compile;



["Server_Player_TransferBank",{
	
	params[["_player",objNull,[objNull]],["_target",objNull,[objNull]],["_amount",0,[0]]];

	_playerAmount = _player getVariable ["player_bank",0];
	_targetAmount = _target getVariable ["player_bank",0];

	if(_playerAmount < _amount) exitWith {
		["System: You don't have enough money for this transfer!", Color_Red] remoteExec ["A3PL_Player_Notification",_player];
	};

	_player setVariable ["player_bank",(_playerAmount - _amount),true];
	_target setVariable ["player_bank",(_targetAmount + _amount),true];

	[_player, getPlayerUID _player, true] spawn Server_Gear_Save;
	[_target, getPlayerUID _target, true] spawn Server_Gear_Save;

	["System: Successfully Transfered Money", Color_Green] remoteExec ["A3PL_Player_Notification",_player];
	[format["System: %1 Sent you %2 Dollars!",name _player,_amount], Color_Green] remoteExec ["A3PL_Player_Notification",_target];

}, true] call Server_Setup_Compile;