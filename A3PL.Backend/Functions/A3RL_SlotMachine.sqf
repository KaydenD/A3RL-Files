["A3RL_Slots_Roll", 
{
	_dir = "\A3PL_Common\gui\slots\";
	_icons = ["bell", "cherry", "horseshoe", "seven", "watermelon"];
	_bet = 500;

	if((player getVariable ["player_cash",0]) < _bet) exitWith {[format ["You don't have $%1 to bet",_bet], Color_Red] call A3PL_Player_Notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0])-(_bet),true];

	createDialog "Dialog_SlotMachine";
	_display = findDisplay 63;
	_box1 = _display displayCtrl 1201;
	_box2 = _display displayCtrl 1202;
	_box3 = _display displayCtrl 1203;

	_box1Roll = "";
	_box2Roll = "";
	_box3Roll = "";

	playSound "A3RL_Slot_Sound_Roll";
	_delayLeft = 4.6;
	while{_delayLeft > 0} do {
		_box1Roll = _icons selectRandomWeighted [5,9,10,1,18];
		_box2Roll = _icons selectRandomWeighted [5,9,10,1,18];
		_box3Roll = _icons selectRandomWeighted [5,9,10,1,18];
		_box1 ctrlSetText (format["%1%2.paa", _dir, _box1Roll]);
		_box2 ctrlSetText (format["%1%2.paa", _dir, _box2Roll]);
		_box3 ctrlSetText (format["%1%2.paa", _dir, _box3Roll]);
		_sleep = (2/(_delayLeft + 1)) - 0.2;
		_delayLeft = _delayLeft - _sleep;
		uiSleep _sleep;
	};

	_multi = 0;
	switch(true) do {
		case(_box1Roll == "horseshoe" && _box2Roll == "horseshoe" && _box3Roll == "horseshoe"): {_multi = 5;};
		case(_box1Roll == "cherry" && _box2Roll == "cherry" && _box3Roll == "cherry"): {_multi = 10;};
		case(_box1Roll == "bell" && _box2Roll == "bell" && _box3Roll == "bell"): {_multi = 20;};
		case(_box1Roll == "seven" && _box2Roll == "seven" && _box3Roll == "seven"): {_multi = 200;};
		case(_box1Roll IN ["cherry","bell","seven"] && _box2Roll IN ["cherry","bell","seven"]): {_multi = 5;};
		case(_box2Roll IN ["cherry","bell","seven"] && _box3Roll IN ["cherry","bell","seven"]): {_multi = 5;};
		case(_box1Roll IN ["cherry","bell","seven"] && _box3Roll IN ["cherry","bell","seven"]): {_multi = 5;};

	};

	if(_multi > 0) then {
		_structText = _display displayCtrl 1100;
		_structText ctrlSetStructuredText parseText "<t align='center' size='2.0'>YOU WIN</t>";
		playSound "A3RL_Slot_Sound_Win";
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+(_multi*_bet),true];
	} else {
		_structText = _display displayCtrl 1100;
		_structText ctrlSetStructuredText parseText "<t align='center' size='2.0'>YOU LOSE</t>";
		playSound "A3RL_Slot_Sound_Lose";
	};


}] call Server_Setup_Compile;