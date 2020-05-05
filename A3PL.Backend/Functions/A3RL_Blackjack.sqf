["A3RL_Blackjack_Start", 
{
	disableSerialization;
	_obj = param[0, objNull];
	if(isNull _obj) exitWith {["Error: Please try again", Color_Red] call A3PL_Player_Notification;};

	_bet = _obj getVariable ["bet", 500];
	if(_bet > 50000) exitWith {["Error: Max bet is $50000", Color_Red] call A3PL_Player_Notification;};
	
	_dir = "\A3PL_Common\gui\blackjack\";
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

	_dealerCard1 = _display displayCtrl 1201;
	_dealerCard1 ctrlSetText (format["%1%2", _dir, selectRandom _icons]);
	_dealerCard2 = _display displayCtrl 1202;
	_dealerCard2 ctrlSetText (format["%1%2", _dir, "red_back.paa"]);

	(_display displayCtrl 34000) ctrlShow true;
	_playerCard1 = _display displayCtrl 34001;
	_playerCard1 ctrlSetText (format["%1%2", _dir, selectRandom _icons]);
	_playerCard2 = _display displayCtrl 34002;
	_playerCard2 ctrlSetText (format["%1%2", _dir, selectRandom _icons]);
}] call Server_Setup_Compile;