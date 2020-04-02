['A3PL_911System_Open', {
	private ['_display','_control','_index'];
	createDialog "Dialog_911";
	_display = findDisplay 911;
	
	buttonSetAction [1600,"[] call A3PL_911System_Send;"];
	buttonSetAction [1601,"closeDialog 0;"];
	_display displayAddEventHandler ["onLBSelChanged","_this call A3PL_911System_CategoryChange;"];
	
	//First fill up all the categorys
	_control = _display displayCtrl 2100;
	_control lbAdd "Medical Related";
	_control lbAdd "Fire Related";
	_control lbAdd "General";	
	_control lbAdd "Gun Related";
	_control lbAdd "Gang Related";	
	_control lbAdd "Vehicular Related";
	_control lbAdd "Traffic Related";
	
	_control lbSetCurSel 2;

	//Let's fill up vehicle types
	_control = _display displayCtrl 2103;
	_index = _control lbAdd "N/A";
	_control lbSetData [0,"N/A"];
	{
		if (_x select 0 == "Type") then
		{
			_index = _control lbAdd (_x select 1);
			_control lbSetData [_index,(_x select 2)];
		};
	} foreach Config_911System;
	
	_control lbSetCurSel 0;
	//Let's do the same for vehicle colours
	_control = _display displayCtrl 2102;
	_control lbAdd "N/A";
	_control lbSetData [0,"N/A"];
	{
		if (_x select 0 == "Colour") then
		{
			_index = _control lbAdd (_x select 1);
			_control lbSetData [_index,(_x select 2)];
		};
	} foreach Config_911System;

	_control lbSetCurSel 0;	
	
	//And headings
	_control = _display displayCtrl 2104;
	_control lbAdd "N/A";
	_control lbSetData [0,"N/A"];
	{
		if (_x select 0 == "dir") then
		{
			_index = _control lbAdd (_x select 1);
			_control lbSetData [_index,(_x select 2)];
		};
	} foreach Config_911System;	
	
	_control lbSetCurSel 0;
	
}] call Server_Setup_Compile;

// [index,index,value] call A3PL_911System_GetFromConfig
// [Index we want, index we have, value of index we have]
['A3PL_911System_GetFromConfig', {
	private ['_indexWant','_indexHave','_indexValue'];
	_indexWant = _this select 0;
	_indexHave = _this select 1;
	_indexValue = _this select 2;
	_output = "ERROR";
	
	{
		if ((_x select _indexHave) == _indexValue) then
		{
			_output = _x select _indexWant;
		};
	} foreach Config_911System;
	_output
	
}] call Server_Setup_Compile;

['A3PL_911System_CategoryChange', {
	private ['_display','_control','_index','_ind','_comboText'];
	_display = findDisplay 911;
	_control = _display displayCtrl 2100;
	
	_index = _this select 1;
	_comboText = _control lbText _index;
	
	_control = _display displayCtrl 2101;
	lbCLear _control;
	
		{
			if (_x select 0 == _comboText) then
			{
				_ind = _control lbAdd (_x select 1);
				_control lbSetData [_ind,(_x select 2)];
			};
		} foreach Config_911System;
	_control lbSetCurSel 0;
	
}] call Server_Setup_Compile;

['A3PL_911System_Send', {
	private ['_display','_control','_crime','_type','_color','_heading','_armed','_extraInfo'];
	createDialog "Dialog_911";
	_display = findDisplay 911;
	
	buttonSetAction [1600,"[] call A3PL_911System_Send;"];
	buttonSetAction [1601,"closeDialog 0;"];
	_display displayAddEventHandler ["onLBSelChanged","_this call A3PL_911System_CategoryChange;"];
	
	_control = _display displayCtrl 2101;
	_crime = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 2103;
	_type = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 2102;
	_color = _control lbData (lbCurSel _control);
	_control = _display displayCtrl 2104;
	_heading = _control lbData (lbCurSel _control);
	
	_control = _display displayCtrl 2500;
	// boolean
	_armed = ctrlChecked _control;
	_control = _display displayCtrl 1400;
	_extraInfo = ctrlText _control;
	
	
	[[_crime,_type,_color,_heading,_armed,_extraInfo,(floor random (count Config_Dispatch_INS - 1))],"A3PL_911System_Play",true,false] call BIS_fnc_MP;
	
	closeDialog 0;
}] call Server_Setup_Compile;

['A3PL_911System_Play', {
	private ['_crime','_type','_color','_heading','_armed','_extraInfo','_random','_text','_lastseenText','_headingText','_armedText','_extraInfoText','_colorText'];
	//Make sure to add check here to see if player is an officer
	_crime = _this select 0;
	_type = _this select 1;
	_color = _this select 2;
	_heading = _this select 3;
	_armed = _this select 4;
	_extraInfo = _this select 5;
	_random = _this select 6;
	
	//DISPATCH TEXT
	_lastseenText = "";
	_colorText = "";
	if (_color != "N/A") then {_colorText = format [" %1",[1,2,_color] call A3PL_911System_GetFromConfig]};
	if (_type != "N/A") then {_lastseenText = format [" Suspect last seen in a%1 %2.",_colorText,[1,2,_type] call A3PL_911System_GetFromConfig]};
	
	_headingText = "";
	if (_heading != "N/A") then {_headingText = format [" %1.",[1,2,_heading] call A3PL_911System_GetFromConfig]};
	
	_armedText = "";
	if (_armed) then {_armedText = format [" Suspect is Armed and Dangerous, use caution!"]};
	
	_extraInfoText = "";
	if (_extraInfo != "") then {_extraInfoText = format [" Extra Info Provided: %1",_extraInfo]};
	
	_text = format ["Available units respond to a %1.%2%3%5%4",[1,2,_crime] call A3PL_911System_GetFromConfig,_lastseenText,_headingText,_extraInfoText,_armedText];
	["Dispatch:", Color_Blue] call a3pl_player_notification;
	[_text, Color_White] call a3pl_player_notification;
	
	//mic click on
	player say2d "MIC_CLICK_ON";
	
	//Play instruction sound first
	[] call (Config_Dispatch_INS select _random);
	
	player say2d _crime;
	if (_type != "N/A") then {
		player say2D "SUSPECT_LAST_SEEN_IN";
		
		//Play random 'a' sound
		player say2d (format ["A_%1",ceil(random 7)]);
		
		if (_color != "N/A") then {player say2d _color;};
		player say2d _type;
	};
	
	if (_heading != "N/A") then
	{
		player say2d _heading;
	};
	
	if (_armed) then
	{
		player say2D "ARMED_AND_DANGEROUS";
		if (round (random 1) == 1) then
		{
			player say2d "USE_CAUTION";
		};
	};
	
	//mic click off
	player say2d "MIC_CLICK_OFF";	
	
}] call Server_Setup_Compile;