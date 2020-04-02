//open the dialog
["A3PL_Level_Open", {
	['Dialog_Level'] call A3PL_Lib_CreateDialog;

	[] call A3PL_Level_Populate;
}] call Server_Setup_Compile;

//populate the dialog
["A3PL_Level_Populate", {
	private ['_currentLevel', '_currentXP', '_nextLevel', '_nextLevelXP', '_barEnd', '_format'];

	_currentLevel = player getvariable 'Player_Level';
	_currentXP = player getVariable 'Player_XP';
	_nextLevel = (_currentLevel + 1);
	_nextLevelXP = [_currentLevel, 'next'] call A3PL_Config_GetLevel;
	_barEnd = (_currentXp / _nextLEvelXP);

	//header
	_format = "<t size='1.2' align='center' color='#B8B8B8'>Experience</t>";
	((findDisplay 25) displayCtrl 7852) ctrlSetStructuredText (parseText _format);

	//the level the player is
	_format = format["<t align='center' color='#B8B8B8'>%1</t>", _currentLevel];
	((findDisplay 25) displayCtrl 7853) ctrlSetStructuredText (parseText _format);

	//the next level the player will be
	_format = format["<t align='center' color='#B8B8B8'>%1</t>", _nextLevel];
	((findDisplay 25) displayCtrl 7854) ctrlSetStructuredText (parseText _format);

	//total xp
	ctrlSetText [7754, format["%1", _currentXP]];

	//xp until next level
	ctrlSetText [7755, format["%1", (_nextLevelXP - _currentXP)]];

	//xpbar
	((findDisplay 25) displayCtrl 8552) progressSetPosition _barEnd;
}] call Server_Setup_Compile;