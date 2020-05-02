["A3RL_Slots_Roll", 
{
	_obj = param[0, objNull];
	if(isNull _obj) exitWith {["Error: Please try again", Color_Red] call A3PL_Player_Notification;};

	_dir = "\A3PL_Common\gui\slots\";
	_icons = ["bell", "cherry", "horseshoe", "seven", "watermelon"];
	_bet = _obj getVariable ["bet", 500];

	if(_obj getVariable ["is_use", false]) exitWith {["This slot machine is already is use", Color_Red] call A3PL_Player_Notification;};
	if((player getVariable ["player_cash",0]) < _bet) exitWith {[format ["You don't have $%1 to bet",_bet], Color_Red] call A3PL_Player_Notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0])-(_bet),true];

	_obj setVariable ["is_use", true, true];

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
		if((_delayLeft - ((2/(_delayLeft + 1)) - 0.2)) <= 0) exitWith {uiSleep ((2/(_delayLeft + 1)) - 0.4);}; //check if last icon change. Want to exit loop to choose winning combo
		_box1Roll = _icons selectRandomWeighted [10,7,9,2,18];
		_box2Roll = _icons selectRandomWeighted [10,7,9,2,18];
		_box3Roll = _icons selectRandomWeighted [10,7,9,2,18];
		_box1 ctrlSetText (format["%1%2.paa", _dir, _box1Roll]);
		_box2 ctrlSetText (format["%1%2.paa", _dir, _box2Roll]);
		_box3 ctrlSetText (format["%1%2.paa", _dir, _box3Roll]);
		_sleep = (2/(_delayLeft + 1)) - 0.2;
		_delayLeft = _delayLeft - _sleep;
		uiSleep _sleep;
	};

	_rand = random 10000;
	_multi = 0;
	switch (true) do {
		case (_rand <= 10): {{_x ctrlSetText (format["%1%2.paa", _dir, "seven"]);} forEach [_box1, _box2, _box3]; _multi = 50;};
		case (_rand <= 50): {{_x ctrlSetText (format["%1%2.paa", _dir, "cherry"]);} forEach [_box1, _box2, _box3]; _multi = 15;};
		case (_rand <= 150): {{_x ctrlSetText (format["%1%2.paa", _dir, "bell"]);} forEach [_box1, _box2, _box3]; _multi = 8;};
		case (_rand <= 500): {{_x ctrlSetText (format["%1%2.paa", _dir, "horseshoe"]);} forEach [_box1, _box2, _box3]; _multi = 4;};
		case (_rand <= 2500): {{_x ctrlSetText (format["%1%2.paa", _dir, "watermelon"]);} forEach [_box1, _box2, _box3]; _multi = 2;};
		default {
			_arr = ["bell", "bell", "cherry", "cherry", "horseshoe", "horseshoe", "seven", "seven", "watermelon", "watermelon"];
			{
				_select = floor(random (count _arr));
				_x ctrlSetText (format["%1%2.paa", _dir, _arr select _select]);
				_arr deleteAt _select;
			} forEach [_box1, _box2, _box3];
		}; 
	};

	if(_multi > 0) then {
		_structText = _display displayCtrl 1100;
		_structText ctrlSetStructuredText parseText (format ["<t align='center' size='2.0'>YOU WIN $%1</t>", [(_multi-1)*_bet, 1, 0, true] call CBA_fnc_formatNumber]);
		playSound "A3RL_Slot_Sound_Win";
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+(_multi*_bet),true];
	} else {
		_structText = _display displayCtrl 1100;
		_structText ctrlSetStructuredText parseText "<t align='center' size='2.0'>YOU LOSE</t>";
		playSound "A3RL_Slot_Sound_Lose";
	};
	_obj setVariable ["is_use", false, true];



}] call Server_Setup_Compile;

["A3RL_Slots_OpenSetBet", 
{
	createDialog "Dialog_SetBet";
	_display = findDisplay 64;
	_ctrl = _display displayCtrl 1400;
	_ctrl ctrlSetText (format ["%1",player_objIntersect getVariable ["bet", 500]]);
}] call Server_Setup_Compile;

["A3RL_Slots_SetBet", 
{
	createDialog "Dialog_SetBet";
	_display = findDisplay 64;
	_ctrl = _display displayCtrl 1400;
	_bet = player_objIntersect getVariable ["bet", 500];
	_newBetStr =  ctrlText _ctrl;
	_newBet = parseNumber _newBetStr;
	if(_newBet < 1) exitWith {["Invaild bet amount", Color_Red] call A3PL_Player_Notification;};
	if(_bet != _newBet) then {
		player_objIntersect setVariable ["bet", _newBet, true];
	};
}] call Server_Setup_Compile;