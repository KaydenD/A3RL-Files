["A3RL_FactionManagment_Open", {
	disableSerialization;
	_faction = param[0, ""];

	if(player getVariable ["job", "unemployed"] != player getVariable ["faction", "citizen"]) exitWith {["You must been signed on-duty to mange your faction", Color_Red] call A3PL_Player_Notification;};

	createDialog "dialog_factionsetup";
	_display = findDisplay 111;

	
	buttonSetAction [1600, "[] call A3RL_FactionManagment_SetRank"];
	buttonSetAction [1601, "[] call A3RL_FactionManagment_AddRank"];
	buttonSetAction [1602, "[] call A3RL_FactionManagment_RemoveRank"];
	buttonSetAction [1603, "[] call A3RL_FactionManagment_SetPay"];

	[_faction, player] remoteExec ["Server_FactionManagment_Init", 2];

	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged", "[] call A3RL_FactionManagment_UpdateRanks;"];
}] call Server_Setup_Compile;

["A3RL_FactionManagment_Setup", {
	_factionId = param[0, 0];
	_ranks = param[1, []];
	_whitelisted = param[2, []];
	_bank = param[3, 0]; 
	_display = findDisplay 111;

	FactionID = _factionId;
	FactionWhitelisted = _whitelisted;

	[] call A3RL_FactionManagment_RefreshRanks;

	{
		_i = lbAdd [1501, (format ["%1 (%2)", _x select 0, [_x select 1] call A3RL_FactionManagment_GetRankName])];
		lbSetData [1501,_i,format["%1", _x select 0]];
	} forEach _whitelisted;

	(_display displayCtrl 1101) ctrlSetStructuredText parseText format ["%1",count(_whitelisted)]; 
	(_display displayCtrl 1100) ctrlSetStructuredText parseText format ["%1",_bank]; 
}] call Server_Setup_Compile;

["A3RL_FactionManagment_UpdateRanks", {
	_display = findDisplay 111;
	_control = _display displayCtrl 1500;
	lbClear _control;

	_control = _display displayCtrl 1502;
	_rank = _control lbData (lbCurSel _control); 

	{
		if((_x select 1) == (parseNumber(_rank))) then {
			_i = lbAdd [1500, (format ["%1", (_x select 0)])];
			lbSetData [1500,_i,format["%1", _x select 0]];
		};
	} forEach FactionWhitelisted;

}] call Server_Setup_Compile;

["A3RL_FactionManagment_RefreshRanks", {
	_display = findDisplay 111;
	_control = _display displayCtrl 1502;
	lbClear _control; 

	{
		if((_x select 1) == FactionID) then {
			_i = lbAdd [1502, (format ["%1 ($%2)", _x select 2, _x select 3])];
			lbSetData [1502,_i,format["%1", _x select 0]];
		};
	} forEach A3RL_FactionRanks;
}] call Server_Setup_Compile;

["A3RL_FactionManagment_AddRank", {
	_display = findDisplay 111;
	_rank = ctrlText (_display displayCtrl 1400);
	_exist = false;

	{
		_exit = false;
		if((_x select 1) == FactionID) then {
			if((_x select 2) == _rank) exitWith {_exit = true};
		};
		if(_exit) exitWith {};
	} forEach A3RL_FactionRanks;

	if(_exist) exitWith {["The rank already exist", Color_Red] call A3PL_Player_Notification;};
	if(_rank == "") exitWith {["Please type in a name", Color_Red] call A3PL_Player_Notification;};
	if((count _rank) > 50) exitWith {["The rank can't have more than 50 charcters", Color_Red] call A3PL_Player_Notification;};
	
	[_rank, FactionID, player] remoteExec ["Server_FactionManagment_AddRank", 2];
}] call Server_Setup_Compile;

["A3RL_FactionManagment_SetRank", {
	_display = findDisplay 111;

	_control = _display displayCtrl 1502;
	if(lbCurSel _control < 0) exitWith {["Please select a rank", Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	_control = _display displayCtrl 1501; 
	if(lbCurSel _control < 0) exitWith {["Please select a player", Color_Red] call A3PL_Player_Notification;};
	_player = _control lbData (lbCurSel _control);

	[_player, _rank] remoteExec ["Server_FactionManagment_SetRank", 2];
	_control lbSetText [lbCurSel(_control), (format ["%1 (%2)", _player, [parseNumber(_rank)] call A3RL_FactionManagment_GetRankName])];

	_number = parseNumber(_rank);
	{
		if((_x select 0) == _player) then {
			(FactionWhitelisted select _forEachIndex) set [1, _number];
		};
	} forEach FactionWhitelisted;

	{
		if((name _x) == _player) then {
			_x setVariable ["rank", _number, true]; 
		};
	}forEach allPlayers;


	[] call A3RL_FactionManagment_UpdateRanks;
}] call Server_Setup_Compile;

["A3RL_FactionManagment_RemoveRank", {
	_display = findDisplay 111;

	_control = _display displayCtrl 1502;
	if(lbCurSel _control < 0) exitWith {["Please select a rank", Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_rank] remoteExec ["Server_FactionManagment_RemoveRank", 2];

	_control lbDelete (lbCurSel _control);

	_control = _display displayCtrl 1500;
	lbClear _control;

	_number = parseNumber(_rank);
	{
		if((_x select 1) == _number) then {
			(FactionWhitelisted select _forEachIndex) set [1, 0];
		};
	}forEach FactionWhitelisted;

	_control = _display displayCtrl 1501;
	lbClear _control;

	{
		_i = lbAdd [1501, (format ["%1 (%2)", _x select 0, [_x select 1] call A3RL_FactionManagment_GetRankName])];
		lbSetData [1501,_i,format["%1", _x select 0]];
	} forEach FactionWhitelisted;

	{
		if((_x select 0) == _number) exitWith {
			A3RL_FactionRanks deleteAt _forEachIndex;
			publicVariable "A3RL_FactionRanks";
		};
	} forEach A3RL_FactionRanks;
}] call Server_Setup_Compile;

["A3RL_FactionManagment_SetPay", {
	_display = findDisplay 111;

	_pay = ctrlText (_display displayCtrl 1401);
	if(_pay == "") exitWith {["Please put a pay amount", Color_Red] call A3PL_Player_Notification;};
	_pay = parseNumber(_pay);
	if(_pay > 10000 || _pay < 1) exitWith {["Invaild amount of money", Color_Red] call A3PL_Player_Notification;};

	_control = _display displayCtrl 1502;
	if(lbCurSel _control < 0) exitWith {["Please select a rank", Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_rank, _pay] remoteExec ["Server_FactionManagment_SetPay", 2];
	_control lbSetText [lbCurSel(_control), (format["%1($%2)", [parseNumber(_rank)] call A3RL_FactionManagment_GetRankName,_pay])];

	{
		if((_x select 0) == parseNumber(_rank)) exitWith {
			(A3RL_FactionRanks select _forEachIndex) set [3, _pay];
		};
	} forEach A3RL_FactionRanks;
}] call Server_Setup_Compile;

["A3RL_FactionManagment_GetRankName", {
	_rankID = param[0, 0];

	_rankName = "";
	{
		if((_x select 0) isEqualTo _rankID) exitWith
		{
			_rankName = _x select 2;
		};
	} forEach A3RL_FactionRanks;

	_rankName;
}] call Server_Setup_Compile;