["A3PL_CellP_CreateConfig",
{
	A3PL_CellP_applications = [
			//["Player Menu","Player<br/>Menu","\A3PL_Common\phone\icons\playerm.paa","\A3PL_Common\phone\icons\selected\playerm.paa",[""],"playermenu"],
			//["Tag Menu","Tag<br/>Menu","\A3PL_Common\phone\icons\tagm.paa","\A3PL_Common\phone\icons\selected\tagm.paa",[""],"tagmenu"],
	["Phone","Phone","\A3PL_Common\phone\icons\phone.paa","\A3PL_Common\phone\icons\selected\phone.paa",[""],"[] call A3PL_Phone_AddNmrMenu"],
	["Messages","Messages","\A3PL_Common\phone\icons\messages.paa","\A3PL_Common\phone\icons\selected\messages.paa",[""],"[] call A3PL_Phone_OpenMessages"],
	["Contacts","Contacts","\A3PL_Common\phone\icons\wantedm.paa","\A3PL_Common\phone\icons\selected\wantedm.paa",[""],"[] call A3PL_Phone_OpenContacts"],
			//["Key Chain","Key<br/>Chain","\A3PL_Common\phone\icons\weather.paa","\A3PL_Common\phone\icons\selected\weather.paa",[""],"keymenu"],
			//["Skills","Skills","\A3PL_Common\phone\icons\playerm.paa","\A3PL_Common\phone\icons\selected\playerm.paa",[""],"skillsmenu"],
			//["Synchronize","Synchronize","\A3PL_Common\phone\icons\synchronize.paa","\A3PL_Common\phone\icons\selected\synchronize.paa",[""],"1"],
	["Settings","Settings","\A3PL_Common\phone\icons\settings.paa","\A3PL_Common\phone\icons\selected\settings.paa",[""],"closedialog 0; [] call A3PL_Phone_OpenSettings"]
	//["Bank","Installing","\A3PL_Common\phone\icons\Bank.paa","\A3PL_Common\phone\icons\selected\Bank.paa",[""],""]
			//["Viewdistance","View<br/>Distance","\A3PL_Common\phone\icons\weather.paa","\A3PL_Common\phone\icons\selected\weather.paa",[""],"2"],
	];

	A3PL_CellP_Applocations = 
	[
		["app1",1001,2001,3001],
		["app2",1002,2002,3002],
		["app3",1003,2003,3003],
		["app4",1004,2004,3004],
		["app5",1005,2005,3005],
		["app6",1006,2006,3006],
		["app7",1007,2007,3007],
		["app8",1008,2008,3008],
		["app9",1009,2009,3009],
		["app10",1010,2010,3010],
		["app11",1011,2011,3011],
		["app12",1012,2012,3012],
		["app13",1013,2013,3013],
		["app14",1014,2014,3014],
		["app15",1015,2015,3015],
		["app16",1016,2016,3016],
		["app17",1017,2017,3017],
		["app18",1018,2018,3018],
		["app19",1019,2019,3019],
		["app20",1020,2020,3020]
	];
	
	A3PL_CellP_BackGrounds = 
	[
		["Default","\A3PL_Common\phone\backgrounds\background01.paa"],
		["Triangles","\A3PL_Common\phone\backgrounds\background02.paa"],
		["Blue Scratches","\A3PL_Common\phone\backgrounds\background03.paa"],
		["Town","\A3PL_Common\phone\backgrounds\background04.paa"],
		["Grand Theft Auto","\A3PL_Common\phone\backgrounds\background05.paa"],
		["Rainbow Nyan","\A3PL_Common\phone\backgrounds\background06.paa"],
		["Blue Nyan","\A3PL_Common\phone\backgrounds\background07.paa"],
		["Star Nyan","\A3PL_Common\phone\backgrounds\background08.paa"],
		["Tomb Raider","\A3PL_Common\phone\backgrounds\background09.paa"],
		["Cats","\A3PL_Common\phone\backgrounds\background10.paa"],
		["Grande","\A3PL_Common\phone\backgrounds\background11.paa"],
		["Stars","\A3PL_Common\phone\backgrounds\background12.paa"],
		["Dark-blue clouds","\A3PL_Common\phone\backgrounds\background13.paa"],
		["Technology","\A3PL_Common\phone\backgrounds\background14.paa"],
		["Uranus","\A3PL_Common\phone\backgrounds\background15.paa"],
		["Space Sloth","\A3PL_Common\phone\backgrounds\background16.paa"],
		["Burning Forest","\A3PL_Common\phone\backgrounds\background17.paa"],
		["Pink Tree","\A3PL_Common\phone\backgrounds\background18.paa"],
		["Tiger","\A3PL_Common\phone\backgrounds\background19.paa"],
		["Counter Strike GO","\A3PL_Common\phone\backgrounds\background20.paa"],
		["Gandalf","\A3PL_Common\phone\backgrounds\background21.paa"],
		["Star Heaven","\A3PL_Common\phone\backgrounds\background22.paa"],
		["Batman","\A3PL_Common\phone\backgrounds\background23.paa"]
	];		
	
	
	A3PL_CellP_CreateConfigDone = true;
}] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTION, COPY OF THIS NEEDS TO BE in FN_Preinit.sqf in @A3PLS
["A3PL_Phone_Open",
{
	// make sure that TFR has our cellphone
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	
	//create config if doesn't exist
	if (isNil "A3PL_CellP_CreateConfigDone") then {[] call A3PL_CellP_CreateConfig;};
	
	/*
	if(isNil "batterylevel") then {batterylevel = 100;}; //local variable in namespace
	if (batterylevel == 0) exitwith {
		createdialog "emptyphone";
		_switch1 = "\A3PL_Common\phone\base\empty.paa";
		_switch2 = "\A3PL_Common\phone\base\empty2.paa";
		_switch = 0;
		while {cellphoneopen2 == 1} do {
			switch (_switch) do
			{
				case 0: {((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText _switch1; _switch = 1;};
				case 1: {((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText _switch2; _switch = 0;};
			};
			sleep 0.5;
		};
	};
	*/
	//1 == currently calling someone, 2 == currently being called, 3 == currenlty in an active call
	//Currently calling someone...
	if((player getVariable "A3PL_Call_Status" select 1) == 1) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Active"; //EDIT

		A3PL_Call_Status = 1;

		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
		ctrlSetText [1002, "Starting Call..."];
	};

	//currently being called...
	if((player getvariable "A3PL_Call_Status" select 1) == 2) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Incoming";

		//Create the incoming call dialog
		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
	};
	
	//Currently an active call...
	if((player getvariable "A3PL_Call_Status" select 1) == 3) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Active";

		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
		ctrlSetText [1002, "Active..."];
	};

	// open cellphone and put down the background, not set: default background.
	createdialog "A3PL_Open_CellPhone";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	
	// puts down all the pictures, text and functions into the buttons
	{
	_piclocation = (A3PL_CellP_Applocations select _forEachIndex) select 1;
	_buttonlocation = (A3PL_CellP_Applocations select _forEachIndex) select 2;
	_textlocation = (A3PL_CellP_Applocations select _forEachIndex) select 3;
	_apptext2 = parseText format["<t font='EtelkaNarrowMediumPro' color='#FFFFFF' size='0.6' align='center'>%1</t>", (_x select 1)];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) buttonsetAction format ["[] call (compile ((A3PL_CellP_applications select %1) select 5))",_forEachIndex];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseEnter",format ["_var = '%1';((findDisplay 12198) displayCtrl %2) ctrlSetText _var;",(_x select 3),_piclocation]];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseExit",format ["_var = '%1';((findDisplay 12198) displayCtrl %2) ctrlSetText _var;",(_x select 2),_piclocation]];

//;


	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseExit", {((findDisplay 12198) displayCtrl 1001) ctrlSetText (_x select 3);}];
	((uiNamespace getVariable "cellphone") displayCtrl _piclocation) ctrlSetText (_x select 2);
	((uiNamespace getVariable "cellphone") displayCtrl _textlocation) ctrlSetStructuredText _apptext2;

	} foreach A3PL_CellP_applications;

	
}] call Server_Setup_Compile;


// sets all the information in the button, anti-steal magic
["A3PL_Phone_AddNmrMenu",
{
	disableSerialization;
	createdialog "callmenu";
	((findDisplay 12194) displayCtrl 6644) buttonsetAction "[1] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6646) buttonsetAction "[2] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6648) buttonsetAction "[3] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6650) buttonsetAction "[4] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6652) buttonsetAction "[5] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6654) buttonsetAction "[6] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6656) buttonsetAction "[7] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6658) buttonsetAction "[8] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6661) buttonsetAction "[9] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6663) buttonsetAction "[0] spawn A3PL_Phone_AddNumber;";
	((findDisplay 12194) displayCtrl 6642) buttonsetAction "[] call A3PL_Phone_DialNumber;";
}] call Server_Setup_Compile;

// Add number as soon as you press the buttons 1-9
["A3PL_Phone_AddNumber",
{
	params[["_num",-1,[0]]];

	//Check if display is open
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	if(isNull (findDisplay 12194)) exitWith {};

	_currentNumber = ctrlText 6668;

	//Remove a digit
	if(_num < 0) exitWith {
		if(count _currentNumber < 1) exitWith {};

		_currentNumber = _currentNumber select [0,((count _currentNumber)-1)];
		ctrlSetText [6668,_currentNumber];
	};

	//Make sure there aren't already 7 digits typed
	if(count _currentNumber >= 7) exitWith {
		["Phone: Max digits reached!", Color_Red] call A3PL_Player_Notification;
	};

	//Add the digit
	_currentNumber = format["%1%2",_currentNumber,_num];
	ctrlSetText [6668,_currentNumber];
}] call Server_Setup_Compile;

//<--------------------------------- Contact application --------------------------------->

//contacts_list = [["name","number","notes"]];
["A3PL_Phone_OpenContacts",
{
	// Create phone, background and anything default
	createdialog "contactsmenu";
	disableSerialization;
	_background = uiNamespace getvariable "background";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	// add actions
	((findDisplay 7732) displayCtrl 1600) buttonsetAction "closedialog 0; [] call A3PL_Phone_AddNmrMenu; ctrlSetText [6668,(((profilenamespace getVariable [""CellPhone_Contacts"",[]]) select (lbCurSel ((findDisplay 7732) displayCtrl 1500))) select 1)];"; //Call button
	((findDisplay 7732) displayCtrl 1601) buttonsetAction "closedialog 0; [(((profilenamespace getVariable [""CellPhone_Contacts"",[]]) select (lbCurSel ((findDisplay 7732) displayCtrl 1500))) select 1)] call A3PL_Phone_TextNumber;"; //SMS button
	((findDisplay 7732) displayCtrl 1602) buttonsetAction "[] call A3PL_Phone_RemContact;"; //Remove Contact
	((findDisplay 7732) displayCtrl 1603) buttonsetAction "[] call A3PL_Phone_UpdContact;"; //Update Contact
	((findDisplay 7732) displayCtrl 1604) buttonsetAction "[] call A3PL_Phone_AddContact;"; //Create Contact
	
	// make sure that the listbox is empty :|
	lbClear ((findDisplay 7732) displayCtrl 1500);
	
	// Add the contacts in the listbox
	{
		selectedtext = format ["%1 (%2)",_x select 0,_x select 1];
		((findDisplay 7732) displayCtrl 1500) lbAdd selectedtext;
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	
	// add the amount added + select the last one in the list
	((findDisplay 7732) displayCtrl 1001) ctrlSetText format ["%1/50",(count (profilenamespace getVariable ["CellPhone_Contacts",[]]))];
	((findDisplay 7732) displayCtrl 1500) lbSetCurSel (count (profilenamespace getVariable ["CellPhone_Contacts",[]]) + 1);
}] call Server_Setup_Compile;


["A3PL_Phone_SelContact",
{
	// check which one is currently selected, if not CLOSE SCRIPT. If there is something selected; select all the information of the array in the edit box.
	_cursel = lbCurSel ((findDisplay 7732) displayCtrl 1500); 
	if (_cursel == -1) exitwith {};
	((findDisplay 7732) displayCtrl 1400) ctrlSetText (((profilenamespace getVariable ["CellPhone_Contacts",[]]) select _cursel) select 0); //name edit display
	((findDisplay 7732) displayCtrl 1401) ctrlSetText (((profilenamespace getVariable ["CellPhone_Contacts",[]]) select _cursel) select 1); // cellphone edit display
	((findDisplay 7732) displayCtrl 1403) ctrlSetText (((profilenamespace getVariable ["CellPhone_Contacts",[]]) select _cursel) select 2); //notes edit display
}] call Server_Setup_Compile;

["A3PL_Phone_RemContact",
{
	// checks which one to delete
	_cursel = lbCurSel ((findDisplay 7732) displayCtrl 1500); 
	if (_cursel == -1) exitwith {};

	// remove the contact in array
	_contacts_list = profilenamespace getVariable ["CellPhone_Contacts",[]];
	_contacts_list set [_cursel,"deletethis"];
	_contacts_list = _contacts_list - ["deletethis"];
	profilenamespace setVariable ["CellPhone_Contacts",_contacts_list];
	_msg = format ["You succesfully deleted: %1 (%2)",(ctrlText ((findDisplay 7732) displayCtrl 1400)),(ctrlText ((findDisplay 7732) displayCtrl 1401))];

	// REFRESH
	// make sure that the listbox is empty :|
	lbClear ((findDisplay 7732) displayCtrl 1500);
	// Add the contacts in the listbox
	{
		selectedtext = format ["%1 (%2)",_x select 0,_x select 1];
		((findDisplay 7732) displayCtrl 1500) lbAdd selectedtext;
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	// add the amount added + select the last one in the list
	((findDisplay 7732) displayCtrl 1001) ctrlSetText format ["%1/50",(count (profilenamespace getVariable ["CellPhone_Contacts",[]]))];
	((findDisplay 7732) displayCtrl 1500) lbSetCurSel (count (profilenamespace getVariable ["CellPhone_Contacts",[]]) + 1);
}] call Server_Setup_Compile;


["A3PL_Phone_AddContact",
{
	//  Gets information out of the display and does some simple checks
	_name = ctrlText ((findDisplay 7732) displayCtrl 1400);
	_cellphone = ctrlText ((findDisplay 7732) displayCtrl 1401);
	_notes = ctrlText ((findDisplay 7732) displayCtrl 1403);
	if((_name == "") OR (count _name > 19)) exitWith {["Phone: You need to fill in a (reasonable) name!", Color_Red] call A3PL_Player_Notification;};
	if((_cellphone == "") OR !(count _cellphone == 7)) exitWith {["Phone: You need to fill in a correct number!", Color_Red] call A3PL_Player_Notification;};
	if((count _notes > 150)) exitWith {["Phone: You can't have more than 150 characters!", Color_Red] call A3PL_Player_Notification;};

	//Adds in Array and makes sure that there is not more than 50 people added.
	_contacts_list = profilenamespace getVariable ["CellPhone_Contacts",[]];
	if((count _contacts_list > 49)) exitWith {["Phone: You can't have more than 50 contacts!", Color_Red] call A3PL_Player_Notification;};
	_contacts_list = _contacts_list + [[_name,_cellphone,_notes]];
	profilenamespace setVariable ["CellPhone_Contacts",_contacts_list];


	// REFRESH
	// make sure that the listbox is empty :|
	lbClear ((findDisplay 7732) displayCtrl 1500);
	
	// Add the contacts in the listbox
	{
		selectedtext = format ["%1 (%2)",_x select 0,_x select 1];
		((findDisplay 7732) displayCtrl 1500) lbAdd selectedtext;
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	
	// add the amount added + select the last one in the list
	((findDisplay 7732) displayCtrl 1001) ctrlSetText format ["%1/50",(count (profilenamespace getVariable ["CellPhone_Contacts",[]]))];
	((findDisplay 7732) displayCtrl 1500) lbSetCurSel (count (profilenamespace getVariable ["CellPhone_Contacts",[]]) + 1);
}] call Server_Setup_Compile;

["A3PL_Phone_UpdContact",
{

	// checks which one to delete
	_cursel = lbCurSel ((findDisplay 7732) displayCtrl 1500); 
	if (_cursel == -1) exitwith {};

	//  Gets information out of the display and does some simple checks
	_name = ctrlText ((findDisplay 7732) displayCtrl 1400);
	_cellphone = ctrlText ((findDisplay 7732) displayCtrl 1401);
	_notes = ctrlText ((findDisplay 7732) displayCtrl 1403);
	if((_name == "") OR (count _name > 19)) exitWith {["Phone: You need to fill in a (reasonable) name!", Color_Red] call A3PL_Player_Notification;};
	if((_cellphone == "") OR !(count _cellphone == 7)) exitWith {["Phone: You need to fill in a correct number!", Color_Red] call A3PL_Player_Notification;};
	if((count _notes > 150)) exitWith {["Phone: You can't have more than 150 characters!", Color_Red] call A3PL_Player_Notification;};

	//Changes in Array and makes sure that there is not more than 50 people added, not possible but checks > life.
	_contacts_list = profilenamespace getVariable ["CellPhone_Contacts",[]];
	if((count _contacts_list > 19)) exitWith {["Phone: You can't have more than 50 contacts!", Color_Red] call A3PL_Player_Notification;};
	_contacts_list set [_cursel,[_name,_cellphone,_notes]];
	profilenamespace setVariable ["CellPhone_Contacts",_contacts_list];
	
	// REFRESH
	// make sure that the listbox is empty :|
	lbClear ((findDisplay 7732) displayCtrl 1500);
	
	// Add the contacts in the listbox
	{
		selectedtext = format ["%1 (%2)",_x select 0,_x select 1];
		((findDisplay 7732) displayCtrl 1500) lbAdd selectedtext;
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	
	// add the amount added + select the last one in the list
	((findDisplay 7732) displayCtrl 1001) ctrlSetText format ["%1/50",(count (profilenamespace getVariable ["CellPhone_Contacts",[]]))];
	((findDisplay 7732) displayCtrl 1500) lbSetCurSel _cursel;
}] call Server_Setup_Compile;

//<--------------------------------- Messages application --------------------------------->


// open Menu
["A3PL_Phone_OpenMessages",
{
	createDialog "smsmenu";
	// Create phone, background and anything default
	disableSerialization;
	_background = uiNamespace getvariable "background";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	((findDisplay 75522) displayCtrl 1600) buttonsetAction "[] call A3PL_Phone_OpenMessage;"; //Open Message
	((findDisplay 75522) displayCtrl 1909) buttonsetAction "[] call A3PL_Phone_DeleteMessage;"; //Delete Message


	{
		_number = _x select 0;
		_read = _x select 1;
		_messageArray = _x select 2;
		_name = format ["%1",_number];
		{if (_number == _x select 1) then {_name = format ["%1 (%2)",_x select 0,_number];};} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
		_id = lbAdd [1500,_name];
		lbSetValue [1500,_id,_forEachIndex];

		if(_read) then {
			lbSetPicture [1500,_id, "A3PL_Common\GUI\read.paa"];
		} else {
			lbSetPicture [1500,_id, "A3PL_Common\GUI\new.paa"];
		};
	} forEach (profileNamespace getVariable ["A3PL_Messages",[]]);
}] call Server_Setup_Compile;

// texting a new person
["A3PL_Phone_TextNumber",
{
	params[["_num","",[""]]];
	if(_num == "") then {
		_num = ctrlText 1001;
	};
	
	_id = [_num] call A3PL_Phone_FindMessageInList;

	if(_id > -1) exitWith {
		[_id] call A3PL_Phone_OpenMessage;
	};

	//Create a new entry...
	_messages = profileNamespace getVariable ["A3PL_Messages",[]];
	_messages pushBack [_num,true,[]];
	profileNamespace setVariable ["A3PL_Messages",_messages];
	A3PL_Phone_OpenMessageID = ((count _messages)-1);

	closeDialog 0;
	createDialog "smsmessagemenu";
	disableSerialization;
	_background = uiNamespace getvariable "background";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	((findDisplay 751282) displayCtrl 1603) buttonsetAction "closeDialog 0;"; //Cancel
	((findDisplay 751282) displayCtrl 1603) buttonsetAction "[] call A3PL_Phone_SendMessage;"; //Send

	_display = findDisplay 751282;
	_ctrl = _display displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText "<br /><br /><br /><br /><t color='#FFFFFF'><t align='center'>No Messages yet!</t></t>";
}] call Server_Setup_Compile;

// Open existing text
["A3PL_Phone_OpenMessage",
{

	params[["_id",-1,[0]]];

	if(_id < 0) then {
		A3PL_Phone_OpenMessageID = lbCurSel 1500;
	} else {
		A3PL_Phone_OpenMessageID = _id;
	};

	if(A3PL_Phone_OpenMessageID < 0) exitWith {
		["Phone: No Message Selected!", Color_Red] call A3PL_Player_Notification;
	};

	closeDialog 0;
	createDialog "smsmessagemenu";
	disableSerialization;
	_background = uiNamespace getvariable "background";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	
	((findDisplay 751282) displayCtrl 1601) buttonsetAction "closeDialog 0;"; //Cancel
	((findDisplay 751282) displayCtrl 1602) buttonsetAction "[] call A3PL_Phone_SendMessage;"; //Send

	_messages = profileNamespace getVariable ["A3PL_Messages",[]];
	_messageLine = _messages select A3PL_Phone_OpenMessageID;

	_texts = "";

	{
		_num = _x select 0;
		_text = _x select 1;

		if(_num == (player getVariable ["phone_number",""])) then {
			_texts = format["<t color='#00FFFF'><t align='right'>%1</t></t><br />",_text] + _texts;
		} else {
			_texts = format["<t color='#00FF00'><t align='left'>%1</t></t><br />",_text] + _texts;
		};

	} forEach (_messageLine select 2);

	_display = findDisplay 751282;
	_ctrl = _display displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText _texts;

	_messageLine set [1, true];
	_messages set [A3PL_Phone_OpenMessageID, _messageLine];
	profileNamespace setVariable ["A3PL_Messages",_messages];
}] call Server_Setup_Compile;

// Send message 
["A3PL_Phone_SendMessage",
{
	_newMessage = ctrlText 1400;
	_messages = profileNamespace getVariable ["A3PL_Messages",[]];
	_messageLine = _messages select A3PL_Phone_OpenMessageID;

	_targetNumber = _messageLine select 0;
	_target = objNull;
	{
		if(_targetNumber == (_x getVariable ["phone_number",""])) exitWith {
			_target = _x;
		};
	} forEach allPlayers;

	if(isNull _target) exitWith {
		["Phone: Number Currently Unavailable!", Color_Red] call A3PL_Player_Notification;
	};

	//Send them a message
	[player,_newMessage] remoteExec ["A3PL_Phone_RecieveMessage",_target];

	//Add it to our message array
	_curMessages = _messageLine select 2;
	_curMessages pushBack [(player getVariable ["phone_number",""]),_newMessage];
	_messageLine set [2,_curMessages];
	_messages set [A3PL_Phone_OpenMessageID, _messageLine];
	profileNamespace setVariable ["A3PL_Messages",_messages];

	closeDialog 0;
}] call Server_Setup_Compile;


//receive message
["A3PL_Phone_RecieveMessage",
{
	params[["_sender",objNull,[objNull]],["_message","",[""]]];

	_num = _sender getVariable ["phone_number",""];
	_messages = profileNamespace getVariable ["A3PL_Messages",[]];
	
	_id = [_num] call A3PL_Phone_FindMessageInList;
	if(_id > -1) then {
		_messageLine = _messages select _id;
		_curMessages = _messageLine select 2;
		_curMessages pushBack [_num,_message];
		_messageLine set [2, _curMessages];
		_messageLine set [1, false];
		_messages set [_id, _messageLine];
	} else {
		_messages pushBack [_num,false,[[_num,_message]]];
	};

	profileNamespace setVariable ["A3PL_Messages",_messages];

	//Done - Notify player of new message
	["Phone: New Text Message!", Color_Green] call A3PL_Player_Notification;
	[[1,_num,_message]] spawn A3PL_Phone_HUD;
}] call Server_Setup_Compile;

//<--------------------------------- Settings application --------------------------------->


// open Menu
//["Default","\A3PL_Common\phone\backgrounds\background01.paa"],
["A3PL_Phone_OpenSettings",
{
	disableSerialization;
	createDialog "settingsmenu";
	// Create phone, background and anything default
	_background = uiNamespace getvariable "background";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);

	((findDisplay 751991) displayCtrl 1600) buttonsetAction "[] call A3PL_Phone_savesettings;"; //Save Settings
	((findDisplay 751991) displayCtrl 1601) buttonsetAction "closedialog 0;"; //Close Settings
	((findDisplay 751991) displayCtrl 2100) ctrlAddEventHandler ["LBSelChanged","[] call A3PL_Phone_changedBgSettings;"];
	(findDisplay 751991) displayAddEventHandler ["unLoad", {waituntil {!isNull (findDisplay 751991)}; [] call A3PL_Phone_Open;}];

	
	((findDisplay 751991) displayCtrl 1001) ctrlSetText format ["Your cellphone number is: %1",(player getVariable ["phone_number","0"])];
	//_x getVariable ["phone_number","0"]
	_selection = 0;
	{
		_bgname = _x select 0;
		if (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"] == _x select 1) then {_selection = _forEachIndex};
		((findDisplay 751991) displayCtrl 2100) lbAdd _bgname;
	} forEach A3PL_CellP_BackGrounds;
	((findDisplay 751991) displayCtrl 2100) lbSetCurSel _selection;
	if (profilenamespace getVariable ["A3PL_Twitter_Enabled",true]) then {((findDisplay 751991) displayCtrl 2800) cbSetChecked true;};
	
	//grass distance
	sliderSetRange [1900, 3.125, 50];
	sliderSetPosition [1900,getTerrainGrid];
	((findDisplay 751991) displayCtrl 1900) ctrlAddEventHandler ["SliderPosChanged","setTerrainGrid (param [1,getTerrainGrid]);"];
	
	//hud enabled
	if (profilenamespace getVariable ["A3PL_HUD_Enabled",false]) then {((findDisplay 751991) displayCtrl 2801) cbSetChecked true;};
	
	//hud enabled
	if (profilenamespace getVariable ["A3PL_HINT_Enabled",true]) then {((findDisplay 751991) displayCtrl 2802) cbSetChecked true;};
	
	//Tags
	{
		lbAdd [2102,(_x select 1)];
	} foreach ((player getvariable "twitterprofile") select 3);
	//Text color hex
	{
		lbAdd [2101,(_x select 1)];
	} foreach ((player getvariable "twitterprofile") select 5);
	lbSetCurSel [2101,0];
	lbSetCurSel [2102,0];
}] call Server_Setup_Compile;

["A3PL_Phone_changedBgSettings",
{
	_selected = lbCurSel ((findDisplay 751991) displayCtrl 2100);
	_selbackground = (A3PL_CellP_BackGrounds select _selected) select 1;
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (_selbackground);
}] call Server_Setup_Compile;

["A3PL_Phone_SaveSettings",
{
	_selected = lbCurSel ((findDisplay 751991) displayCtrl 2100);
	profilenamespace setVariable ["CellPhone_Background",((A3PL_CellP_BackGrounds select _selected) select 1)];
	profilenamespace setVariable ["A3PL_Twitter_Enabled",(cbChecked ((findDisplay 751991) displayCtrl 2800))];
	profileNamespace setVariable ["A3PL_HUD_Enabled",(cbChecked ((findDisplay 751991) displayCtrl 2801))];
	profileNamespace setVariable ["A3PL_HINT_Enabled",(cbChecked ((findDisplay 751991) displayCtrl 2802))];
	
	
	//Twitter nametag set
	_array = player getvariable "twitterprofile";
	_selectedtag = (((player getvariable "twitterprofile") select 3) select (lbCurSel 2102)) select 0;
	_selectedtext = (((player getvariable "twitterprofile") select 5) select (lbCurSel 2101)) select 0;
	_selectedname = "#ed7202";
	{
		if (_x select 0 == _selectedtag) exitwith {_selectedname = _x select 1;};
	} foreach 
	[["\A3PL_Common\icons\chief.paa","#1E90FF"], //lightblue
	["\A3PL_Common\icons\citizen.paa","#ed7202"], //orange
	["\A3PL_Common\icons\director.paa","#FFFF32"], //yellow
	["\A3PL_Common\icons\don_green.paa","#0af326"], //lightgreen
	["\A3PL_Common\icons\executive.paa","#8833a4"], //Purple
	//["\A3PL_Common\icons\fire.paa","#FF0000"], //REDRED
	["\A3PL_Common\icons\leadchief.paa","#1E90FF"], //lightblue
	["\A3PL_Common\icons\secretary.paa","#2CCDAB"], //Light Cyan
	//["\A3PL_Common\icons\sheriff.paa","#556B2F"], //Shitgreen
	["\A3PL_Common\icons\sub-director.paa","#ff8e2b"] //Lightorange
	//["\A3PL_Common\icons\citizen.paa","#16a085"] //Strong Cyan || Coast Guard
	//["\A3PL_Common\icons\citizen.paa","#ffffff"] //White || Creators
	//["\A3PL_Common\icons\citizen.paa","#34495e"] //Darkblueish || FAA
	];
	
	_array set [0,_selectedtag];
	_array set [1,_selectedname];
	_array set [2,_selectedtext];
	
	
}] call Server_Setup_Compile;

//<--------------------------------- When you call and when you get called --------------------------------->
/*
A3PL_Call_Status:
[
IF ANYTHING BUT PLAYER = CHECK SECOND ARRAYLINE
,
0 = IDLE
1 = SENDING A CALL
2 = BEING CALLED
3 = CALL ACTIVE
,
Name set in phone contacts IF set, if not, show number
]
*/

["A3PL_Phone_HUD",
{
	75421 cutRsc ["Dialog_HUD_Cellphone", "PLAIN"];
	((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1201) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);
	_type = _this select 0;
	if (_type select 0 == 0) then {
		_timer = time;
		while {(player getvariable "A3PL_Call_Status" select 1) != 0} do
		{
			sleep 1;
			if (player getvariable "A3PL_Call_Status" select 1 == 1) then {
				((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t font='PuristaSemiBold' align='center' size='0.6'>Calling</t><t font='PuristaSemiBold' align='left' size='0.6'><br/>%1</t>",player getvariable "A3PL_Call_Status" select 2]);
				_timer = time;
			};
			if (player getvariable "A3PL_Call_Status" select 1 == 2) then {
				((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t font='PuristaSemiBold' align='center' size='0.6'>Incoming Call...</t><t font='PuristaSemiBold' align='left' size='0.6'><br/>%1</t>",player getvariable "A3PL_Call_Status" select 2]);
				_timer = time;
			};
			if (player getvariable "A3PL_Call_Status" select 1 == 3) then {
				_calctimer = round (time - _timer);
				_mins = floor (_calctimer / 60);
				_secs = round (((_calctimer / 60) - _mins) * 60);
				if (_secs < 10) then { _secs = format ["0%1",_secs];};
				((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t font='PuristaSemiBold' align='center' size='0.6'>Active Call...</t><t font='PuristaSemiBold' align='left' size='0.6'><br/>%1<br/>%2</t>",player getvariable "A3PL_Call_Status" select 2,format ["%1:%2",_mins,_secs]]);
			};
		};
		((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t font='PuristaSemiBold' align='center' size='0.6'>Call ended...</t><t font='PuristaSemiBold' align='left' size='0.6'><br/>%1</t>",player getvariable "A3PL_Call_Status" select 2]);
		sleep 3;
	};
	if (_type select 0 == 1) then {
		((uiNamespace getVariable "Dialog_Cellphone_HUD") displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t font='PuristaSemiBold' align='center' size='0.4'>MSG FROM: %1</t><t font='PuristaSemiBold' align='left' size='0.6'><br/>%2</t>",_type select 1, _type select 2]);
		sleep 5;
	};
	75421 cutText ["","PLAIN"];
}] call Server_Setup_Compile;


["A3PL_Phone_DialNumber",
{
	params[["_currentNumber","",[""]]];
	//Random checks, Script rewritten, previous owner didn't state what this does..
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	
	//Checking the cellphone number in the textbar
	if(_currentNumber == "") then {
		if(isNull (findDisplay 12194)) exitWith {};
		_currentNumber = ctrlText 6668;
	};
	
	//Phone called is 911? Start different script and cancel rest.
	if(_currentNumber in ["911"]) exitWith {
		[player] remoteExec ["Server_Police_CallDispatch",2];
		["911"] spawn A3PL_Phone_StartActive;
	};
	
	//Define variable, add empty object to it and check who has the phone that is being called
	_target = objNull; 
	{
		if(_x getVariable ["phone_number",""] == _currentNumber) exitWith {
			_target = _x;
		};
	} forEach allPlayers;

	//Person offline? Number invalid? Send out this message.
	if(isNull _target) exitWith {
		["Phone: Phone Number Unavailable!", Color_Red] call A3PL_Player_Notification;
		closeDialog 0;
	};
	if (_target getvariable "A3PL_Call_Status" select 1 != 0) exitwith {
		["Phone: User is already in a call.", Color_Red] call A3PL_Player_Notification;
		closeDialog 0;
	};
	//Set _setincontacts to default number, if known in contacts, change it to the person set name.
	_setincontacts = _currentNumber;
	{
		if (_x select 1 == _setincontacts) then {_setincontacts = _x select 0; };
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	
	//Set the variable to define who the person actually is that is being called, check ABOVE for more information of this variable in case of future edits.
	// 1 is being set since this is the person that is being the caller, not having a reply yet.
	player setvariable ["A3PL_Call_Status",[_target,1,_setincontacts],true];

	// Oh hey! Phone number is found, let's send out some stuff to the victim.
	// Let's start the Active script and let his phone ring ;)
	[] spawn A3PL_Phone_StartActive;
	[[0]] spawn A3PL_Phone_HUD;
}] call Server_Setup_Compile;


["A3PL_Phone_StartActive",
{
	params[["_num","",[""]]];

	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	
	//This script is for the person calling, close the phone menu and activate new cellphone menu!
	closeDialog 0;
	createDialog "Dialog_Phone_Active";

	//Show this if you are calling 911, _num is defined above.
	if(_num != "") then {
		ctrlSetText [1001, _num];
	} else {
		ctrlSetText [1001,(player getvariable "A3PL_Call_Status" select 2)];
		//Send requests to the person you are calling
		[player] remoteExec ["A3PL_Phone_IncomingCall",(player getvariable "A3PL_Call_Status" select 0)];
	};
	ctrlSetText [1002, "Starting Call..."];

	//Play Ringing Sound..?
	uiSleep 15;
	if((player getvariable "A3PL_Call_Status" select 1) == 1) exitWith {
		ctrlSetText [1002, "Call Failed..."];
		sleep 3;
		closeDialog 0;
		(player getvariable "A3PL_Call_Status" select 0) setvariable ["A3PL_Call_Status",[(player getvariable "A3PL_Call_Status" select 0),0,""],true];
		player setvariable ["A3PL_Call_Status",[player,0,""],true];
	};

}] call Server_Setup_Compile;

["A3PL_Phone_IncomingCall",
{
	params[["_caller",objNull,[objNull]]];

	//_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	if(isNull _caller) exitWith {};
	
	
	//Check if the person calling you is a known number
	_setincontacts = _caller getVariable ["phone_number","ERROR!"];
	{
		if (_x select 1 == _setincontacts) then {_setincontacts = _x select 0; };
	} foreach (profilenamespace getVariable ["CellPhone_Contacts",[]]);
	
	player setvariable ["A3PL_Call_Status",[_caller,2,_setincontacts],true];

	[[0]] spawn A3PL_Phone_HUD;

}] call Server_Setup_Compile;


//Being activated in menu..
["A3PL_Phone_AnswerCall",
{
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	
	closeDialog 0;
	createDialog "Dialog_Phone_Active";

	ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 0) getVariable ["phone_number",""]];
	ctrlSetText [1002, "Active..."];

	player setvariable ["A3PL_Call_Status",[(player getvariable "A3PL_Call_Status" select 0),3,(player getvariable "A3PL_Call_Status" select 2)],true];
	[] remoteExec ["A3PL_Phone_CallAccepted",(player getvariable "A3PL_Call_Status" select 0)];
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid (player getvariable "A3PL_Call_Status" select 0))] call TFAR_fnc_SetChannelFrequency;

}] call Server_Setup_Compile;

["A3PL_Phone_CallAccepted",
{
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};

	player setvariable ["A3PL_Call_Status",[(player getvariable "A3PL_Call_Status" select 0),3,(player getvariable "A3PL_Call_Status" select 2)],true];
	ctrlSetText [1002, "Active..."];
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;

}] call Server_Setup_Compile;

["A3PL_Phone_EndCall",
{
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};	
	closeDialog 0;

	[] remoteExec ["A3PL_Phone_CallEnded",(player getvariable "A3PL_Call_Status" select 0)];

	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;

	if(player getVariable ["job","unemployed"] == "dispatch") then {
		player setVariable ["busy",false,true];
		[(player getvariable "A3PL_Call_Status" select 0)] remoteExec ["Server_Police_EndDispatch",2];
	};
	
	player setvariable ["A3PL_Call_Status",[player,0,""],true];
}] call Server_Setup_Compile;

["A3PL_Phone_CallEnded",
{
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};

	if(!isNull (findDisplay 5002)) then {closeDialog 0;};
	player setvariable ["A3PL_Call_Status",[player,0,""],true];
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;

	if(player getVariable ["job","unemployed"] == "dispatch") then {
		player setVariable ["busy",false,true];
		[(player getvariable "A3PL_Call_Status" select 0)] remoteExec ["Server_Police_EndDispatch",2];
	};
}] call Server_Setup_Compile;

//<--------------------------------- Others that was made by 'that kid'. will look at later --------------------------------->

["A3PL_Phone_FindMessageInList",
{
	params[["_num","",[""]]];

	_id = -1;
	_messages = profileNamespace getVariable ["A3PL_Messages",[]];

	{
		_number = _x select 0;
		if(_number == _num) exitWith {
			_id = _forEachIndex;
		};
	} forEach _messages;

	_id
}] call Server_Setup_Compile;


["A3PL_Phone_openBank",
{
	disableSerialization;

	closeDialog 0;
	createDialog "Dialog_Phone_Bank";

	_display = findDisplay 5023;

	_ctrl = _display displayCtrl 1003;
	_ctrl ctrlSetText str (player getVariable ["player_cash",0]);

	_ctrl = _display displayCtrl 1004;
	_ctrl ctrlSetText str (player getVariable ["player_bank",0]);
}] call Server_Setup_Compile;



["A3PL_Phone_BankTransferNumber",{
	disableSerialization;

	closeDialog 0;
	createDialog "Dialog_Phone_BankTransferNumber";
}] call Server_Setup_Compile;



["A3PL_Phone_BankTransferContact",{
	disableSerialization;

	closeDialog 0;
	createDialog "Dialog_Phone_BankTransferContact";

	_contacts = profileNamespace getVariable ["A3PL_Contacts",[]];
	{
		_id = lbAdd [1500, format["%1 - %2",_x select 0,_x select 1]];
		lbSetValue [1500, _id, _forEachIndex];
	} forEach _contacts;

}] call Server_Setup_Compile;



["A3PL_Phone_BankSendMoneyContact",{
	_amount = parseNumber (ctrlText 1400);

	if(_amount < 1) exitWith {["Phone: Enter an amount!", Color_Red] call A3PL_Player_Notification;};
	if(_amount > (player getVariable ["player_bank",0])) exitWith {["Phone: Bank Balance Too Low!", Color_Red] call A3PL_Player_Notification;};

	_cur = lbCurSel 1500;
	_id = lbValue [1500, _cur];
	if(_cur < 0) exitWith {["Phone: Select a contact!", Color_Red] call A3PL_Player_Notification;};

	_contacts = profileNamespace getVariable ["A3PL_Contacts",[]];
	_num = parseNumber ((_contacts select _id) select 1);

	closeDialog 0;
	[_amount,_num] call A3PL_Phone_SendMoney;
}] call Server_Setup_Compile;



["A3PL_Phone_BankSendMoneyNumber",{
	_amount = parseNumber (ctrlText 1400);
	if(_amount < 1) exitWith {["Phone: Enter an amount!", Color_Red] call A3PL_Player_Notification;};
	if(_amount > (player getVariable ["player_bank",0])) exitWith {["Phone: Bank Balance Too Low!", Color_Red] call A3PL_Player_Notification;};

	_num = parseNumber (ctrlText 1001);

	closeDialog 0;
	[_amount,_num] call A3PL_Phone_SendMoney;
}] call Server_Setup_Compile;







["A3PL_Phone_SendMoney",{

	params[["_amount",0,[0]],["_number",0,[0]]];

	if(_number == (parseNumber (player getVariable ["phone_number","0"]))) exitWith {["Phone: You can't send yourself money!", Color_Red] call A3PL_Player_Notification;};

	_target = objNull;
	{
		if(_number == (parseNumber (_x getVariable ["phone_number","0"]))) exitWith {
			_target = _x;
		};
	} forEach allPlayers;

	if(isNull _target) exitWith {
		["Phone: Unable to transfer - Number Offline!", Color_Red] call A3PL_Player_Notification;
	};

	[player,_target,_amount] remoteExec ["Server_Player_TransferBank",2];
	
}] call Server_Setup_Compile;