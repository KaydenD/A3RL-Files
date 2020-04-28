["A3PL_HUD_Init",
{
	disableSerialization;
	private ["_display","_control","_name"];
	("A3PL_Hud" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD","PLAIN"];

	//cinema debug
	("A3PL_Hud_Cinema" call BIS_fnc_rscLayer) cutRsc ["Dialog_Hud_Cinema","PLAIN"];

	//Overlay, for setting mask images etc later on
	("A3PL_Hud_Overlay" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_Overlay","PLAIN"];

	//Perform Load overlay (for setting loading text)
	("A3PL_Hud_LoadAction" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_LoadAction","PLAIN"];

	_display = uiNamespace getVariable "Dialog_HUD_LoadAction";
	(_display displayCtrl 394) ctrlSetFade 1;
	(_display displayCtrl 350) ctrlSetFade 1;
	(_display displayCtrl 351) ctrlSetFade 1;
	(_display displayCtrl 352) ctrlSetFade 1;
	(_display displayCtrl 394) ctrlCommit 0;
	(_display displayCtrl 350) ctrlCommit 0;
	(_display displayCtrl 351) ctrlCommit 0;
	(_display displayCtrl 352) ctrlCommit 0;


	//twitter
	[] call A3PL_Twitter_Init;

	_name = name player;
	if (!isNil {player getVariable "name"}) then
	{
		_name = player getVariable "name";
	};

	_display = uiNamespace getVariable "A3PL_HUDDisplay";
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText (format ["<t align='center'>%1</t>",_name]);

	_ctrl = _display displayCtrl 9520;
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;

	_ctrl = _display displayCtrl 9521;
	_ctrl ctrlSetFade 1;
	_ctrl ctrlCommit 0;

	A3PL_HUD_Text = "";
	[] call A3RL_HUD_GPS;
	["System: A3RL message system initialized"] call A3PL_HUD_Message;
}] call Server_Setup_Compile;

["A3PL_Hud_IDCard",
{
	disableSerialization;
	private ["_target","_display","_licenses"];
	_target = param [0,objNull];
	("Dialog_IDCard" call BIS_fnc_rscLayer) cutRsc ["Dialog_IDCard","PLAIN"];
	_display = uiNamespace getVariable "A3PL_HUD_IDCard";

	_name = _target getVariable ["name","::ERROR:: ::ERROR::"];
	_firstname = (_name splitString " ") select 0;
	_lastname = (_name splitString " ") select 1;
	_ref = ((getPlayerUID _target) splitString "");
	_ref deleteRange [0,8];
	_ref = _ref joinString "";
	_passportdate = ((_target getVariable ["date","::ERROR::"]) splitString " ") select 0;
	_birthdate = (_target getVariable ["dob","::ERROR::"]) splitString "/";
	_bd = format["%1-%2-%3", _birthdate select 2, _birthdate select 1, _birthdate select 0];

	(_display displayCtrl 1000) ctrlSetText (_firstname);		//firstname
	(_display displayCtrl 1001) ctrlSetText (_lastname);		//lastname
	(_display displayCtrl 1002) ctrlSetText (_target getVariable ["gender","::ERROR::"]);		//Gender
	(_display displayCtrl 1003) ctrlSetText (_ref);	//DB_ID
	(_display displayCtrl 1004) ctrlSetText (_bd);					//DOB
	(_display displayCtrl 1005) ctrlSetText (_passportdate);					//Date Issued

	uiSleep 30;
	("Dialog_IDCard" call BIS_fnc_rscLayer) cutText ["","PLAIN"];

}] call Server_Setup_Compile;

["A3PL_HUD_Message",
{
	disableSerialization;
	private ["_display","_control","_text","_txt","_time"];
	_display = uiNamespace getVariable "A3PL_HUDDisplay";
	_control = _display displayCtrl 1104;

	_txt = param [0,""];
	_color = param [1,Color_Red];
	_time = param [2,20]; //15 seconds for message to dissapear by default

	_text = format ["<t color='%1' font='RobotoCondensed' align='left'>%2</t><br />",_color,_txt];
	_control ctrlSetStructuredText parseText (A3PL_HUD_Text + _text);
	A3PL_HUD_Text = (A3PL_HUD_Text + _text);

	//sound
	//playsound "3DEN_notificationWarning";

	[_time] spawn
	{
		private ["_time"];
		_time = param [0,20];
		uiSleep _time; //time for message to dissapear
		[] call A3PL_HUD_Clear;
	};
}] call Server_Setup_Compile;

//finds the first linebreak and clears everything before it
["A3PL_HUD_Clear",
{
	disableSerialization;
	private ["_text","_display","_control","_delete"];
	_text = toArray A3PL_HUD_Text;
	{
		_delete = false;
		if (_x == 60) then
		{
			_index = _forEachIndex;
			//look for <br />
			if ((_text select (_index+1) == 98) && (_text select (_index+2) == 114) && (_text select (_index+3) == 32) && (_text select (_index+4) == 47) && (_text select (_index+5) == 62)) exitwith
			{
				_text deleteRange [0,_index+6];
				_display = uiNamespace getVariable "A3PL_HUDDisplay";
				_control = _display displayCtrl 1104;
				_control ctrlSetStructuredText parseText (toString _text);
				A3PL_HUD_Text = (toString _text);
				_delete = true;
			};
		};
		if (_delete) exitwith {};
	} foreach _text;
}] call Server_Setup_Compile;

["A3PL_HUD_Loop",
{
	disableSerialization;
	private ["_display","_control","_name","_imgnr","_text","_itemName","_isHudEnabled","_bloodLvl"];

	_display = uiNamespace getVariable ["A3PL_HUDDisplay",displayNull];

	//disable or enable the HUD here
	//requested by the corman shepherd nigger
	_isHudEnabled = profileNameSpace getVariable ["A3PL_HUD_Enabled",true];
	if (isNull _display && _isHudEnabled) then
	{
		private ["_ctrl"];
		("A3PL_Hud" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD","PLAIN"];
		_display = uiNamespace getVariable ["A3PL_HUDDisplay",displayNull];
		_ctrl = _display displayCtrl 9520; //hide the street signs
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;
		_ctrl = _display displayCtrl 9521;
		_ctrl ctrlSetFade 1;
		_ctrl ctrlCommit 0;
	};
	if (!isNull _display && !_isHudEnabled) then
	{
		("A3PL_Hud" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		uiNameSpace setVariable ["A3PL_HUDDisplay",nil];
	};
	if (isNull _display) exitwith {}; //no need to run the rest of this script

	//setting the jailed texts
	if(player getVariable ["jailed",false]) then {
		_control = _display displayCtrl 1000;
		_control ctrlShow true;
		_control ctrlSetText format["%1 Minutes Remaining",(player getVariable ["jailtime",0])];
	} else {
		_control = _display displayCtrl 1000;
		_control ctrlShow false;
	};

	//health
	_control = _display displayCtrl 1201;
	_bloodLvl = (player getVariable ["A3PL_MedicalVars",[5000,"120/80",37]]) select 0;
	_imgnr = round (((_bloodLvl/5000))*45);

	if (_imgnr < 1) then
	{
		_control ctrlSetText "";
	} else
	{
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	};

	//hunger
	_control = _display displayCtrl 1204;
	if (!isNil "Player_Hunger") then
	{
		_imgnr = round ((player_hunger*45)/100);
		if (_imgnr < 1) exitwith
		{
			_control ctrlSetText "";
		};
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	} else
	{
		_control ctrlSetText "A3PL_Common\HUD\new\MBLoad_45.paa";
	};

	//thirst
	_control = _display displayCtrl 1205;
	if (!isNil "player_thirst") then
	{
		_imgnr = round ((player_thirst*45)/100);
		if (_imgnr < 1) exitwith
		{
			_control ctrlSetText "";
		};
		_control ctrlSetText format ["A3PL_Common\HUD\new\MBLoad_%1.paa",_imgnr];
	} else
	{
		_control ctrlSetText "A3PL_Common\HUD\new\MBLoad_45.paa";
	};

	//stats
	_control = _display displayCtrl 1600; //name
	_control ctrlSetStructuredText parseText format ["<t font='PuristaBold' align='right'>%1</t>",toUpper (player getVariable ["name",(name player)])];

	_control = _display displayCtrl 1601; //job
	_control ctrlSetStructuredText parseText format ["<t font='PuristaMedium' align='right'>%1</t>",toUpper (player getVariable ["job","unemployed"])];

	_control = _display displayCtrl 1602; //cash, add toggle bank later
	_text = missionNameSpace getVariable ["A3PL_HUD_S2T",0];
	switch (true) do
	{
		case (_text < 5): {_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='left'>CASH</t><t font='PuristaSemiBold' align='right' size=1>$%1</t>",([(player getVariable ["player_cash",0]), 1, 0, true] call CBA_fnc_formatNumber)];};
		case (_text > 4 && _text < 10): {_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='left'>BANK</t><t font='PuristaSemiBold' align='right' size=1>$%1</t>",([(player getVariable ["player_bank",0]), 1, 0, true] call CBA_fnc_formatNumber)];};
		case (_text > 9 && _text < 15): {_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='left'>PAYCHECK</t><t font='PuristaSemiBold' align='right' size=1>%1 MIN</t>",(20 - (missionNameSpace getVariable ["player_paychecktime",0]))]};
	};
	A3PL_HUD_S2T = _text + 1;
	if (A3PL_HUD_S2T > 14) then {A3PL_HUD_S2T = 0};

	_control = _display displayCtrl 1603; //other info in box
	_itemName = [player_itemClass,"name"] call A3PL_Config_GetItem; if (typeName _itemName == "BOOL") then {_itemName = "Carrying nothing";};
	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center' size='0.85'>%1<br/>Player Level: %2/60<br/>FPS: %3<br/>Players: %4/110</t>",
	_itemName,
	(player getVariable ["Player_Level",0]),round diag_fps,count allPlayers];

	//Display amount of cops online
 	_control = _display displayCtrl 1001; // faction counter every 15 seconds
 	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center' size='0.85'><img image='\A3PL_Common\icons\faction_sheriff.paa' /> %1  <img image='\A3PL_Common\icons\faction_cg.paa' /> %2  <img image='\A3PL_Common\icons\faction_fifr.paa' /> %3</t>", count(["police"] call A3PL_Lib_FactionPlayers), count(["uscg"] call A3PL_Lib_FactionPlayers), count(["fifr"] call A3PL_Lib_FactionPlayers)];
}] call Server_Setup_Compile;

//set an overlay image
["A3PL_HUD_SetOverlay",
{
	disableSerialization;
	private ["_path","_idc","_Opacity"];
	_path = param [0,""];
	_order = param [1,0];
	_opacity = param [2,1];
	_idc = (uiNamespace getVariable "A3PL_Hud_Overlay") displayCtrl (1200+_order);
	_idc ctrlSetText _path;
	_idc ctrlSetFade _opacity;
	_idc ctrlCommit 0;
}] call Server_Setup_Compile;
