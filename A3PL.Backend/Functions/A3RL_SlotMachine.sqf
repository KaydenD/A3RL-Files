["A3RL_Slots_Roll", 
{
	_dir = "\A3PL_Common\gui\slots\";
	_icons = ["bell.paa", "cherry.paa", "clover.paa", "crown.paa", "diamond.paa", "horseshoe.paa", "seven.paa", "star.paa", "strawberry.paa", "watermelon.paa"];

	createDialog "Dialog_SlotMachine";
	_display = findDisplay 63;
	_box1 = _display displayCtrl 1201;
	_box2 = _display displayCtrl 1202;
	_box3 = _display displayCtrl 1203;


	playSound "A3RL_Slot_Sound_Roll";
	_delayLeft = 4.6;
	while{_delayLeft > 0} do {
		_box1 ctrlSetText (format["%1%2", _dir, selectRandom(_icons)]);
		_box2 ctrlSetText (format["%1%2", _dir, selectRandom(_icons)]);
		_box3 ctrlSetText (format["%1%2", _dir, selectRandom(_icons)]);
		_sleep = (2/(_delayLeft + 1)) - 0.2;
		_delayLeft = _delayLeft - _sleep;
		uiSleep _sleep;
	};

	_structText = _display displayCtrl 1100;

	_structText ctrlSetStructuredText parseText "<t align='center' size='2.0'>YOU WIN</t>";

	playSound "A3RL_Slot_Sound_Win";

}] call Server_Setup_Compile;