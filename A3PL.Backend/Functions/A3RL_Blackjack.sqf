["A3RL_Blackjack_Start", 
{
	disableSerialization;
	_obj = param[0, objNull];
	if(isNull _obj) exitWith {["Error: Please try again", Color_Red] call A3PL_Player_Notification;};

	if(_obj getVariable ["is_use", false]) exitWith {["This slot machine is already is use", Color_Red] call A3PL_Player_Notification;};

	_bet = _obj getVariable ["bet", 500];
	if(_bet > 50000) exitWith {["Error: Max bet is $50000", Color_Red] call A3PL_Player_Notification;};
	
	_obj setVariable ["is_use", true, true];

	_dir = "\A3PL_Common\gui\blackjack\cards\";
	_icons = ["J", "Q", "K", "A"];
	for "_i" from 2 to 10 do {
		_icons pushBack (str _i);
	};
	_newIcons = [];
	{
		_base = _x;
		{
			_newIcons pushBack (format["%1%2",_base,_x]);	
		} forEach ["C", "S", "D", "H"];
	} forEach _icons;
	_icons = _newIcons;
	
	createDialog "Dialog_Blackjack";
	_display = findDisplay 65;
	_cashCtrl = _display displayCtrl 1000; 
	_betCtrl = _display displayCtrl 1001; 
	_cashCtrl ctrlSetText (format ["$%1", [player getVariable ["player_cash", 0], 1, 0, true] call CBA_fnc_formatNumber]);
	_betCtrl ctrlSetText (format ["$%1", _bet]);

	_normalArr = [34001, 34002, 34003, 34004, 34005, 34006, 34007, 34008, 34009, 34016, 34017, 34018, 34019];
	_splitArr = [35001, 35002, 35003, 35004, 35005, 35006, 35007, 35016, 35017, 35101, 35102, 35103, 35104, 35105, 35116, 35117, 35106, 35107];

	{
		ctrlShow[_x, false];
	} forEach _splitArr;

	_dealerCard1 = _display displayCtrl 1201;
	_dealerCard1 ctrlSetText (format["%1%2.paa", _dir, selectRandom _icons]);
	_dealerCard2 = _display displayCtrl 1202;
	_dealerCard2 ctrlSetText (format["%1%2.paa", _dir, "red_back"]);
	_dealerCard3 = _display displayCtrl 1203;
	_dealerCard3 ctrlSetText "";
	_dealerCard4 = _display displayCtrl 1204;
	_dealerCard4 ctrlSetText "";
	_dealerCard5 = _display displayCtrl 1205;
	_dealerCard5 ctrlSetText "";

	ctrlShow [34000,true];
	_playerCard1 = _display displayCtrl 34001;
	_playerCard1 ctrlSetText (format["%1%2.paa", _dir, selectRandom _icons]);
	_playerCard2 = _display displayCtrl 34002;
	_playerCard2 ctrlSetText (format["%1%2.paa", _dir, selectRandom _icons]);
	_obj setVariable ["is_use", false, true];

}] call Server_Setup_Compile;