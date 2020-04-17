["A3PL_Twitter_Init",
{
	for "_i" from 0 to 7 do
	{
		// record format: [caption text, unique id for hide timeout handling]
		A3PL_TwitterMsg_Array set [_i, ["", -1]];
	};

	[] spawn
	{
		if (isDedicated) exitWith {};
		waitUntil {!isNull (findDisplay 46)};
		736713 cutRsc ["Dialog_HUD_Twitter", "PLAIN"];
		waitUntil {!isNil "A3PL_Twitter_MsgDisplay"};
		[] call A3PL_Twitter_MsgDisplay;
	};
}] call Server_Setup_Compile;

["A3PL_Twitter_Open",
{
	if (isDedicated) exitWith {};
	736713 cutText ["","PLAIN"];
	createdialog "Dialog_Twitter";
	{
		_logo = _x select 0;
		_text = _x select 1;
		_number = _forEachIndex;
		lbAdd [5120, _text];
		lbSetPicture [5120, _number, _logo];
	} foreach A3PL_TwitterChatLog;
	lbSetCurSel [5120, (count A3PL_TwitterChatLog + 1)];
}] call Server_Setup_Compile;

["A3PL_Twitter_Send",
{
	private ["_msg","_result"];
	_msg = ctrlText 1400;
	closedialog 0;
	if (count _msg < 1) exitwith {};
	if (count _msg > 100) exitwith { ["Twitter: You can't have more than 100 characters!", Color_Red] call A3PL_Player_Notification; };
	if (!(profilenamespace getVariable ["A3PL_Twitter_Enabled",true])) exitwith {["Twitter: You have your twitter disabled!", Color_Red] call A3PL_Player_Notification;};

	//Receive all the icons and shit
	_msgcolor = player getvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5"]] select 2;
	_namecolor = player getvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5"]] select 1;
	_namepicture = player getvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5"]] select 0;
	_name = player getvariable ["name",(name player)];
	_truecaller = _name;

	if (_namepicture == "\A3PL_Common\icons\citizen.paa") then {
		switch (player getVariable ["job","unemployed"]) do
		 {
			default {};
			case ("fifr"): {_namepicture = "\A3PL_Common\icons\fire.paa"; _namecolor = "#FF0000";};
			case ("police"): {_namepicture = "\A3PL_Common\icons\faction_sheriff.paa"; _namecolor = "#556B2F";};
			case ("doj"): {_namepicture = "\A3PL_Common\icons\faction_doj.paa"; _namecolor = "#B18904";};
			case ("dao"): {_namepicture = "\A3PL_Common\icons\faction_doj.paa"; _namecolor = "#B18904";};
			case ("pdo"): {_namepicture = "\A3PL_Common\icons\faction_doj.paa"; _namecolor = "#B18904";};
			case ("usms"): {_namepicture = "\A3PL_Common\icons\faction_doj.paa"; _namecolor = "#B18904";};
			case ("dmv"): {_namepicture = "\A3PL_Common\icons\faction_dmv.paa"; _namecolor = "#BC8F8F";};
			case ("uscg"): {_namepicture = "\A3PL_Common\icons\faction_cg.paa"; _namecolor = "#16a085";};
			case ("faa"): {_namepicture = "\A3PL_Common\icons\faction_cg.paa"; _namecolor = "#34495e";};
		 };
	 };

	//Define all the information
	_messageto = ""; //_messageto = "admin" - "911"
	_todatabase = true;
	_doubleCommand = true; //Makes sure you cannot execute twice by "/admin /911"
	_needcellphone = true;
	_exitwith = false;
	_splitted = _msg splitString " "; //  "/r zannaza yo whats up" = ["/r","zannaza","yo","whats","up"];
	if (_msg find "/" == 0) then {_doubleCommand = false;};

	//-----------------Can use without cellphone-------------------
	if (((toLower (_splitted select 0) == "/a")) && !_doubleCommand) then {
		_splitted deleteat 0;
		_messageto = ["admin",["admin",player,player getvariable ["name",(name player)],(time + 300)]];
		_todatabase = false;
		_needcellphone = false;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = format ["Help %1",_name]; //Set front to "Help Zannaza"
		_namecolor = "#3d0000"; //Set the name text to dark red.
		_msgcolor = "#ffbfbf"; //Set text to whitered
	};
	//---------------END Can use without cellphone-----------------


	if(pVar_AdminTwitter) then {A3PL_Twitter_Cooldown = 0; _needcellphone = false;}; //If admin, you can spam whatever you want :3
	if ((! ([] call A3PL_Lib_HasPhone)) && _needcellphone) exitwith {["Twitter: You don't have a cellphone so you can't send tweets"] call A3PL_Player_Notification;};
	if(((diag_ticktime-(missionNameSpace getVariable ["A3PL_Twitter_Cooldown",-10])) < 10) && _needcellphone) exitwith {[format ["Twitter: You need to wait %1 more seconds for your next tweet",round (10-(diag_ticktime-A3PL_Twitter_Cooldown))], Color_Red] call A3PL_Player_Notification; };
	if (_needcellphone) then {A3PL_Twitter_Cooldown = diag_ticktime;}; //no timer if se
	if (((_splitted select 0 == "/911") && !_doubleCommand) && ((count(["dispatch"] call A3PL_Lib_FactionPlayers)) > 0)) exitWith {["System: You cannot use /911 when dispatch is active! Please CALL *911* using your cell-phone.",Color_Red] call A3PL_Player_Notification;};


	//------------------Command need cellphone---------------------
	if ((_splitted select 0 == "/911") && !_doubleCommand) then {
		_splitted deleteat 0;
		_messageto = ["911",["911",player,player getvariable ["name",(name player)],(time + 300)]];
		_todatabase = false;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = format ["911 %1",_name]; //Set front to "911 Zannaza"
		_namecolor = "#1c00db"; //Set the name text to blueish
		_namepicture = ""; //N
		A3PL_Twitter_Cooldown = A3PL_Twitter_Cooldown - 5; //Make cooldown 5 seconds for 911
	};

	if (((toLower (_splitted select 0) == "/r")) && !_doubleCommand) then {
		if(!(pVar_AdminTwitter OR ((player getVariable ["job","unemployed"]) IN ["fifr","police","uscg","dispatch"]))) exitwith {["You do not have the credentials to this command.","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; _exitwith = true;};
		_todatabase = false;
		_doubleCommand = true;
		_splitted deleteat 0;

		_namecolor = "#c64700"; //Set the name text to dark red.
		_msgcolor = "#ff9960"; //Set text to whitered
		_name = format ["Reply from (%1)",_name];
		_namepicture = "";
		_found = false;
		_person = [];
		_arraynum = -1;
		{
			if (((toLower (_x select 2)) find (toLower (_splitted select 0))) == 0) then {
				if ((_x select 3) > time) then {
					_found = true;
					_person = _x;
					_arraynum = _foreachindex;
				} else {
					A3PL_Twitter_ReplyArr deleteat _foreachindex;
				};
			};
		} foreach (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]);
		if (!_found) exitwith {["This person did not contact you.","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; _exitwith = true;};
		{if (_person select 1 == _x) exitwith {_found = false;};} foreach allplayers;
		if (_found) exitwith {["This person is not online.","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; A3PL_Twitter_ReplyArr deleteat _arraynum; _exitwith = true;};
		_splitted deleteat 0;
		_msg = _splitted joinString " ";
		_messageto = ["reply",_person];
	};

	if (((toLower (_splitted select 0) == "/ad")) && !_doubleCommand) then {
		_splitted deleteat 0;
		_todatabase = true;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = format ["[AD] %1",_name]; //Set front to "911 Zannaza"
		if(!isNil "A3PL_phoneNumberActive") then {_msg = _msg + format [" [%1]",A3PL_phoneNumberActive];};
		//_msg = _msg + format [" [%1]",(player getVariable ["phone_number","0"])];
		_namecolor = "#00bfbf"; //Set the name text to dark red.
		_msgcolor = "#4cffff"; //Set text to whitered
	};

	//darknet
	/*if (((toLower (_splitted select 0) == "/d")) && !_doubleCommand) then { // darknet
		if(!(pVar_AdminTwitter) AND ((player getVariable ["job","unemployed"]) IN ["fifr","police","uscg","dispatch","usms","doj","faa"])) exitwith {["Only civilians can use this command","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; _exitwith = true;};
		_splitted deleteat 0;
		_messageto = ["darknet"];
		_todatabase = false;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		_name = "[DARKNET]";
		_namecolor = "#764b4b"; //Set the name text to dark brown.
		_msgcolor = "#764b4b"; //Set text to whitered
	};*/

	/*
	if (((toLower (_splitted select 0) == "/dd")) && !_doubleCommand) then { // darknet ad
		if(!(pVar_AdminTwitter) AND ((player getVariable ["job","unemployed"]) IN ["fifr","police","uscg","dispatch","usms","doj","faa"])) exitwith {["Only civilians can use this command","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg; _exitwith = true;};
		_splitted deleteat 0;
		_messageto = ["darknet"];
		_todatabase = false;
		_doubleCommand = true;
		_msg = _splitted joinString " ";
		//_msg = _msg + format [" [%1]",(player getVariable ["phone_number","0"])];
		if(!isNil "A3PL_phoneNumberActive") then {_msg = _msg + format [" [%1]",A3PL_phoneNumberActive];};
		_name = "[DARKNET AD]";
		_namecolor = "#764b4b"; //Set the name text to dark brown.
		_msgcolor = "#764b4b"; //Set text to whitered
	};*/

	/*if (((toLower (_splitted select 0) == "/startradio")) && !_doubleCommand) exitwith {
		["Tuning in","#a3ffc1","","RADIOTEST","#42f47d",""] spawn A3PL_Twitter_NewMsg;
		_packet = format['PLAY%1%2%3', toString [10], "http://stream.kanefm.com:1037/listen", toString [10]];
		'A3PLRadio' callExtension _packet;
		A3PL_Twitter_Cooldown = 0;
	};

	if (((toLower (_splitted select 0) == "/radiovolume")) && !_doubleCommand) exitwith {
		["Chaning volume","#a3ffc1","","RADIOTEST","#42f47d",""] spawn A3PL_Twitter_NewMsg;
		_packet = format['VOLUME%1%2%3', toString [10], (_splitted select 1), toString [10]];
		'A3PLRadio' callExtension _packet;
		A3PL_Twitter_Cooldown = 0;
	};

	if (((toLower (_splitted select 0) == "/currentplaying")) && !_doubleCommand) exitwith {
		_song = 'nradio' callExtension format['SONG%1', toString [10]];
		[_song,"#a3ffc1","","RADIOTEST","#42f47d",""] spawn A3PL_Twitter_NewMsg;
		A3PL_Twitter_Cooldown = 0;
	};

	if (((toLower (_splitted select 0) == "/radio")) && !_doubleCommand) exitwith {
		A3PL_Twitter_Cooldown = 0;
		["/startradio | /radiovolume 0-100 | /currentplaying","#a3ffc1","","RADIOTEST","#42f47d",""] spawn A3PL_Twitter_NewMsg;
	};*/

	// A3PL_Twitter_ReplyArr = [["911",player,player getvariable "name",time]];
	if (((_splitted select 0 == "/h") or (_splitted select 0 == "/H")) && !_doubleCommand) exitwith {
		A3PL_Twitter_Cooldown = 0;
		["/h [help] | /911 | /a [admin] | /r (name) [reply] | /ad [advertisment]","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg;
	};

	//---------------END Command need cellphone--------------------

	if (_exitwith) exitwith {};

	if (!_doubleCommand) exitwith {
		A3PL_Twitter_Cooldown = 0;
		["Command not recognised (use /h for help)","#a3ffc1","","Commands","#42f47d",""] spawn A3PL_Twitter_NewMsg;
	};

	
	//if (A3PL_MedicalVar_Unconscious == true) exitwith {["Twitter: You are unconscious and can't use twitter"] call A3PL_Player_Notification;};



	if (_todatabase) exitwith {
		_result = [getPlayerUID player,_msg,_msgcolor,_namepicture,_name,_namecolor];
		_result remoteExec ["Server_Twitter_HandleMsg", 2];
	};


	if (isServer) then //just so this works in editor
	{
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", 2]; //target everyone
	} else
	{
		[_msg,_msgcolor,_namepicture,_name,_namecolor,_messageto,_truecaller] remoteExec ["A3PL_Twitter_NewMsg", -2]; //target everyone except server
	};

}] call Server_Setup_Compile;

["A3PL_Twitter_NewMsg",
{
	disableSerialization;
	private ["_msg", "_msgduration", "_i", "_id", "_params", "_messageto", "_subName", "_subText","_namepicture","_name","_msgcolor","_namecolor","_maxmsg","_logo","_nametext","_logname","_logchat","_messagelog","_selmsg"];

	if (isDedicated) exitWith {};
	if (isNil "A3PL_TwitterMsg_Array") exitWith {};
	if (!(profilenamespace getVariable ["A3PL_Twitter_Enabled",true])) exitwith {};
	if (!(typeName _this == typeName [])) exitWith { hint "nope";};


	_msg = param [0,""];
	_msgcolor = param [1,""];
	_namepicture = param [2,""];
	_name = param [3,""];
	_namecolor = param [4,""];
	_messageto = param [5,""];
	_truecaller = param [6,""];
	_msgduration = 20; // time before it gets removed
	_maxmsg = (8 - 1); // max messages - 1 because forced


	_cancelaction = true;
	// A3PL_Twitter_ReplyArr = [["911",player,player getvariable "name",time]];
	if (typename _messageto == "ARRAY") then {

		if (_messageto select 0 == "admin") then {
			if(pVar_AdminTwitter) then {_cancelaction = false;};
			A3PL_Twitter_ReplyArr = (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]) + [(_messageto select 1)];
		};

		if (_messageto select 0 == "911") then {
			if(pVar_AdminTwitter OR ((player getVariable ["job","unemployed"]) IN ["fifr","police","uscg","dispatch","usms"])) then {_cancelaction = false;};
			A3PL_Twitter_ReplyArr = (missionNameSpace getVariable ["A3PL_Twitter_ReplyArr",[]]) + [(_messageto select 1)];
		};

		/*if (_messageto select 0 == "darknet") then {
			if(pVar_AdminTwitter) then {
				_name = format ["[DARKNET] %1",_truecaller];
			};
			_cancelaction = false;
		};*/


		// A3PL_Twitter_ReplyArr = [["911",player,player getvariable "name",time]];
		if (_messageto select 0 == "reply") then {
			if (player == (_messageto select 1) select 1) then {_cancelaction = false;};
			if (((_messageto select 1) select 0 == "911") && (pVar_AdminTwitter OR ((player getVariable ["job","unemployed"]) IN ["fifr","police","uscg","dispatch","usms"]))) then {_cancelaction = false;};
			if (((_messageto select 1) select 0 == "admin") && pVar_AdminTwitter) then {_cancelaction = false;};
		};
	};

	if (typename _messageto == "STRING") then {
		if (_messageto == "") then {_cancelaction = false;};
	};

	if (_cancelaction) exitwith {};
	// changes it to readable !@#$%
	_msg = _msg call A3PL_Twitter_stripLineBreaks;
	_msg = _msg call A3PL_Twitter_replaceAmpersands;

	// defines chat
	_logo = "";
	_nametext = "";
	_logname = "";
	_logchat = "";
	_messagelog = _msg;


	if (_namepicture != "") then
	{
		_logo = format ["<t size='0.5'><img image='%1' /> </t>",_namepicture];
	};

	if (_name != "") then
	{
		_nametext = format ["<t color='%1'>%2: </t>",_namecolor,_name];
		_logname = format ["%1",_name];
	};

	if ((_msgcolor find "#") != 0) then
	{
		switch (_msgcolor) do
		{
			case "red": { _msgcolor = "#FF0000"; };
			case "green": { _msgcolor = "#00DB07"; };
			default { _msgcolor = "#FFFFFF"; };
		};
	};

	_messageinfo = format ["<t color='%1'>%2</t>",_msgcolor,_msg];

	if (count _logname == 0) then
	{
		_logchat = format ["%1",_messagelog];
	} else
	{
		if (count _messagelog > 30) then {

		} else {
		_logchat = format ["%1: %2",_logname,_messagelog];
		};
		_logchat = format ["%1: %2",_logname,_messagelog];
	};

	A3PL_TwitterChatLog = A3PL_TwitterChatLog + [[_namepicture,_logchat]]; //selects the first pic to display in chatbox
	while {count A3PL_TwitterChatLog > 50} do
	{
		A3PL_TwitterChatLog set [0,"delete"];
		A3PL_TwitterChatLog = A3PL_TwitterChatLog - ["delete"];
	};

	_msg = format ["%1%2%3",_logo,_nametext,_messageinfo];

	_selmsg = 0;
	while {_selmsg < _maxmsg} do
	{
		A3PL_TwitterMsg_Array set [_selmsg, A3PL_TwitterMsg_Array select (_selmsg+1)];
		_selmsg = _selmsg + 1;
	};

	// hopefully these 2 lines behave like an atomic operation
	_id = A3PL_TwitterMsg_Counter + 1;
	A3PL_TwitterMsg_Counter = A3PL_TwitterMsg_Counter + 1;
	A3PL_TwitterMsg_Array set [_maxmsg, [_msg, _id]];

	//set twitter feed text
	((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 1000) ctrlSetText "Fishers Twitter Feed";

	call A3PL_Twitter_MsgDisplay;
	//---------------------------------------------------------
	[_id, _msgduration] spawn
	{
		private ["_id","_msgduration","_last"];
		_id = param [0,0];
		_msgduration = param [1,20];

		// wait for message display duration to time out
		uiSleep _msgduration;

		// find the original message index, which may have moved during the time out period;
		// or it may have been already pushed off the list, in which case it won't find it.
		{
			if (_x select 1 == _id) exitWith
			{
				A3PL_TwitterMsg_Array set [_forEachIndex, ["", -1]];
				call A3PL_Twitter_MsgDisplay;
			};
		} forEach A3PL_TwitterMsg_Array;

		//if the last is removed remove the twitter feed text
		_last = false;
		{
			if (_x select 0 != "") exitwith {_last = false;};
			if (_x select 0 == "") then {_last = true;} else {_last = false;};
		} foreach A3PL_TwitterMsg_Array;
		if (_last) then {((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 1000) ctrlSetText "";};
	};
}] call Server_Setup_Compile;



["A3PL_Twitter_MsgDisplay",
{
	private ["_maxmsg"];
	_maxmsg = (8 - 1);
	private ["_ctrl", "_text", "_block"];

	if (isDedicated) exitWith {};
	if (isNil "A3PL_TwitterMsg_Array") exitWith {};
	disableSerialization;

	_block = "";
	for "_i" from 0 to _maxmsg do
	{
		_text = (A3PL_TwitterMsg_Array select _i) select 0;
		if (_text != "") then
		{
			_block = _block + _text + "<br />";
		};
	};

	((uiNamespace getVariable ["Dialog_HUD_Twitter", displayNull]) displayCtrl 100) ctrlSetStructuredText parseText _block;
}] call Server_Setup_Compile;

["A3PL_Twitter_stripLineBreaks",
{
	private ["_aaa","_c_chr_backSlash","_c_chr_space","_c_chr_n","_c_chr_N2","_c_chr_remove"];
	_c_chr_backSlash = 92;
	_c_chr_space = 32;
	_c_chr_n = 110;
	_c_chr_N2 = 78;
	_c_chr_remove = 990;

	_aaa = toArray _this;
	for "_i" from 0 to ((count _aaa)-2) do // checked in pairs - exclude last chr
	{
	  if ((_aaa select _i == _c_chr_backSlash) && (_aaa select (_i+1) in [_c_chr_N2, _c_chr_n])) then
	  {
		_aaa set [_i, _c_chr_space]; // leave one space
		_aaa set [_i+1, _c_chr_remove]; // remove this
	  };
	};
	_aaa = _aaa-[_c_chr_remove]; // strip out all deleted chars
	toString _aaa // result
}] call Server_Setup_Compile;

["A3PL_Twitter_replaceAmpersands",
{
	// Desc: replace "&" characters with "&amp;"
	private ["_aaa", "_ra", "_i", "_ja", "_ca"];

	// &amp;

	_aaa = toArray _this;
	_ra = +_aaa; // save "some" potential effort of copying.
	_ja = 0;

	for "_i" from 0 to ((count _aaa)-1) do
	{
		_ca = _aaa select _i;
		_ra set [_ja, _ca];
	  if (_ca == 38) then
	  {
		_ra set [_ja+0, 38];
		_ra set [_ja+1, 97];
		_ra set [_ja+2, 109];
		_ra set [_ja+3, 112];
		_ra set [_ja+4, 59];
			_ja = _ja + 5; // len of "&amp;"
	  }
		else
		{
			_ja = _ja + 1;
		};
	};

	toString _ra // result
}] call Server_Setup_Compile;
