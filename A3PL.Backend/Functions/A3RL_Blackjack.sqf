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
	A3RL_Blackjack_Icons = ["J", "Q", "K", "A"];
	for "_i" from 2 to 10 do {
		A3RL_Blackjack_Icons pushBack (str _i);
	};
	_newIcons = [];
	{
		_base = _x;
		{
			_newIcons pushBack (format["%1%2",_base,_x]);	
		} forEach ["C", "S", "D", "H"];
	} forEach A3RL_Blackjack_Icons;
	A3RL_Blackjack_Icons = _newIcons;
	
	createDialog "Dialog_Blackjack";
	_display = findDisplay 65;
	_cashCtrl = _display displayCtrl 1001; 
	_betCtrl = _display displayCtrl 1000; 
	_cashCtrl ctrlSetText (format ["$%1", [player getVariable ["player_cash", 0], 1, 0, true] call CBA_fnc_formatNumber]);
	_betCtrl ctrlSetText (format ["$%1", _bet]);

	_normalArr = [34001, 34002, 34003, 34004, 34005, 34006, 34007, 34008, 34009, 34016, 34017, 34018, 34019];
	_splitArr = [35001, 35002, 35003, 35004, 35005, 35006, 35007, 35016, 35017, 35101, 35102, 35103, 35104, 35105, 35116, 35117, 35106, 35107];

	{
		ctrlShow[_x, false];
	} forEach _splitArr;

	A3RL_Dealer_Cards = [selectRandom A3RL_Blackjack_Icons, "red_back"];
	_dealerCard1 = _display displayCtrl 1201;
	_dealerCard1 ctrlSetText (format["%1%2.paa", _dir, A3RL_Dealer_Cards select 0]);
	_dealerCard2 = _display displayCtrl 1202;
	_dealerCard2 ctrlSetText (format["%1%2.paa", _dir, A3RL_Dealer_Cards select 1]);
	_dealerCard3 = _display displayCtrl 1203;
	_dealerCard3 ctrlSetText "";
	_dealerCard4 = _display displayCtrl 1204;
	_dealerCard4 ctrlSetText "";
	_dealerCard5 = _display displayCtrl 1205;
	_dealerCard5 ctrlSetText "";

	A3RL_Player_Cards = [selectRandom A3RL_Blackjack_Icons, selectRandom A3RL_Blackjack_Icons];
	
	_playerCard1 = _display displayCtrl 34001;
	_playerCard1 ctrlSetText (format["%1%2.paa", _dir, A3RL_Player_Cards select 0]);
	_playerCard2 = _display displayCtrl 34002;
	_playerCard2 ctrlSetText (format["%1%2.paa", _dir, A3RL_Player_Cards select 1]);
	_playerCard3 = _display displayCtrl 34003;
	_playerCard3 ctrlSetText "";
	_playerCard4 = _display displayCtrl 34004;
	_playerCard4 ctrlSetText "";
	_playerCard5 = _display displayCtrl 34005;
	_playerCard5 ctrlSetText "";

	_card1 = ((A3RL_Player_Cards select 0) splitString "");
	_card1 deleteAt ((count _card1) - 1);
	_card2 = ((A3RL_Player_Cards select 1) splitString "");
	_card2 deleteAt ((count _card2) - 1);

	ctrlShow [34008, false];
	ctrlShow [34018, false];
	if(_card1 isEqualTo _card2) then {
		ctrlShow [34008, true];
		ctrlShow [34018, true];
	};

	_obj setVariable ["is_use", false, true];

}] call Server_Setup_Compile;

["A3RL_Blackjack_Hit", {
	_splitIndex = param [0, -1];
	if(_splitIndex == -1) then {
		_nextIdc = 34000 + (count A3RL_Player_Cards) + 1;
		_newCard = selectRandom A3RL_Blackjack_Icons;
		A3RL_Player_Cards pushBack _newCard;
		((findDisplay 65) displayCtrl _nextIdc) ctrlSetText (format["%1%2.paa", _dir, _newCard]);
		if([A3RL_Player_Cards] call A3RL_Blackjack_CardsValue >= 21) then {
			systemChat "BUST/StopMoreHits";
			ctrlShow [34006, false];
			ctrlShow [34007, false];
			ctrlShow [34016, false];
			ctrlShow [34017, false];
			[] call A3RL_Blackjack_DealerResolve;
		};
		ctrlShow [34008, false];
		ctrlShow [34018, false];
		ctrlShow [34009, false];
		ctrlShow [34019, false];
	} else {
		_nextIdc = 35000 + (_splitIndex * 100) + (count (A3RL_Player_Cards select _splitIndex)) + 1;
		_newCard = selectRandom A3RL_Blackjack_Icons;
		(A3RL_Player_Cards select _splitIndex) pushBack _newCard;
		((findDisplay 65) displayCtrl _nextIdc) ctrlSetText (format["%1%2.paa", _dir, _newCard]);
		if([A3RL_Player_Cards select _splitIndex] call A3RL_Blackjack_CardsValue >= 21) then {
			systemChat "BUST/StopMoreHits";
			ctrlShow [35006 + (_splitIndex * 100), false];
			ctrlShow [35007 + (_splitIndex * 100), false];
			ctrlShow [35016 + (_splitIndex * 100), false];
			ctrlShow [35017 + (_splitIndex * 100), false];
			A3RL_Blackjack_SplitGamestate set [_splitIndex, true];
			if((A3RL_Blackjack_SplitGamestate select 0) && (A3RL_Blackjack_SplitGamestate select 1)) then {
				[] call A3RL_Blackjack_DealerResolve;
			};
		};
	};
}] call Server_Setup_Compile;

["A3RL_Blackjack_Stand", {
	_splitIndex = param [0, -1];
	if(_splitIndex == -1) then {
		[] call A3RL_Blackjack_DealerResolve;
		ctrlShow [34006, false];
		ctrlShow [34007, false];
		ctrlShow [34008, false];
		ctrlShow [34009, false];
		ctrlShow [34016, false];
		ctrlShow [34017, false];
		ctrlShow [34018, false];
		ctrlShow [34019, false];
	} else {
		ctrlShow [35006 + (_splitIndex * 100), false];
		ctrlShow [35007 + (_splitIndex * 100), false];
		ctrlShow [35016 + (_splitIndex * 100), false];
		ctrlShow [35017 + (_splitIndex * 100), false];
		A3RL_Blackjack_SplitGamestate set [_splitIndex, true];	
		if((A3RL_Blackjack_SplitGamestate select 0) && (A3RL_Blackjack_SplitGamestate select 1)) then {
			[] call A3RL_Blackjack_DealerResolve;
		};
	};
}] call Server_Setup_Compile;

["A3RL_Blackjack_Double", {
	_nextIdc = 34000 + (count A3RL_Player_Cards) + 1;
	_newCard = selectRandom A3RL_Blackjack_Icons;
	A3RL_Player_Cards pushBack _newCard;
	((findDisplay 65) displayCtrl _nextIdc) ctrlSetText (format["%1%2.paa", _dir, _newCard]);
	if([A3RL_Player_Cards] call A3RL_Blackjack_CardsValue > 21) then {
		systemChat "BUST";
	} else {
		[] call A3RL_Blackjack_DealerResolve;
	};
}] call Server_Setup_Compile;

["A3RL_Blackjack_Split", {
	A3RL_Player_Cards = [[A3RL_Player_Cards select 0], [A3RL_Player_Cards select 1]];
	_normalArr = [34001, 34002, 34003, 34004, 34005, 34006, 34007, 34008, 34009, 34016, 34017, 34018, 34019];
	_splitArr = [35001, 35002, 35003, 35004, 35005, 35006, 35007, 35016, 35017, 35101, 35102, 35103, 35104, 35105, 35116, 35117, 35106, 35107];
	{ctrlShow[_x, false];} forEach _normalArr;
	{ctrlShow[_x, true];} forEach _splitArr;

	((findDisplay 65) displayCtrl 35001) ctrlSetText (format["%1%2.paa", _dir, (A3RL_Player_Cards select 0) select 0]);
	((findDisplay 65) displayCtrl 35002) ctrlSetText "";
	((findDisplay 65) displayCtrl 35003) ctrlSetText "";
	((findDisplay 65) displayCtrl 35004) ctrlSetText "";
	((findDisplay 65) displayCtrl 35005) ctrlSetText "";
	((findDisplay 65) displayCtrl 35101) ctrlSetText (format["%1%2.paa", _dir, (A3RL_Player_Cards select 1) select 0]);
	((findDisplay 65) displayCtrl 35102) ctrlSetText "";
	((findDisplay 65) displayCtrl 35103) ctrlSetText "";
	((findDisplay 65) displayCtrl 35104) ctrlSetText "";
	((findDisplay 65) displayCtrl 35105) ctrlSetText "";
	A3RL_Blackjack_SplitGamestate = [false, false]; // Has stood hand, Has stood hand

}] call Server_Setup_Compile;

["A3RL_Blackjack_DealerResolve", {
	A3RL_Dealer_Cards set [1, selectRandom A3RL_Blackjack_Icons];
	_dealerCard2 = (findDisplay 65) displayCtrl 1202;
	_dealerCard2 ctrlSetText (format["%1%2.paa", _dir, A3RL_Dealer_Cards select 1]);
	
	_dealerValue = [A3RL_Dealer_Cards] call A3RL_Blackjack_CardsValue;

	if(_dealerValue >= 17) then {

	};
	
	_nextIdc = 1203;
	while {_dealerValue < 17} do {
		_newDealerCard = selectRandom A3RL_Blackjack_Icons;
		A3RL_Dealer_Cards pushBack [selectRandom _newDealerCard];
		((findDisplay 65) displayCtrl _nextIdc) ctrlSetText (format["%1%2.paa", _dir, _newDealerCard]);
		_nextIdc = _nextIdc + 1;
		_dealerValue = [A3RL_Dealer_Cards] call A3RL_Blackjack_CardsValue;
	};

	if(_dealerValue > 21) exitWith {systemChat "dealer bust";};

	if(_dealerValue == 21) exitWith {
		systemChat "dealer blackjack";
	} else {
		systemChat "dealer stand";
	};

}] call Server_Setup_Compile;

["A3RL_Blackjack_TrimCard", {
	_card = param [0,""];
	_card = (_card splitString "");
	_card deleteAt ((count _card) - 1);
	_card joinString "";
}] call Server_Setup_Compile;

["A3RL_Blackjack_CardsValue", {
	_cards = param [0,[]];

	_aces = 0;
	_value = 0;
	{
		switch ([_x] call A3RL_Blackjack_TrimCard) do {
			case "2": 	{ _value = _value + 2;};
			case "3": 	{ _value = _value + 3;};
			case "4": 	{ _value = _value + 4;};
			case "5": 	{ _value = _value + 5;};
			case "6": 	{ _value = _value + 6;};
			case "7": 	{ _value = _value + 7;};
			case "8": 	{ _value = _value + 8;};
			case "9": 	{ _value = _value + 9;};
			case "10":	{ _value = _value + 10;};
			case "J": 	{ _value = _value + 10;};
			case "Q": 	{ _value = _value + 10;};
			case "K": 	{ _value = _value + 10;};
			case "A": 	{ _value = _value + 11; _aces = _aces + 1;};
		};
	} forEach _cards;

	while {_aces > 0 && _value > 21} do {
		if(_value > 21) then {
			_aces = _aces - 1;
			_value = _value - 10;
		};
	};

	_value;
}] call Server_Setup_Compile;