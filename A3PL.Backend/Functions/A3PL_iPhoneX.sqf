["A3PL_iPhoneX_AddContact",
{
	private["_uid","_contacts","_nameContact","_phoneNumberContact","_exists"];
	disableSerialization;

	if (count A3PL_contacts > 100) exitWith {["The contact limit has been reached",Color_Red] call A3PL_Player_Notification;};

	_uid = getPlayerUID player;
	_contacts = A3PL_contacts;
	_nameContact = ctrlText 97605;
	_phoneNumberContact = ctrlText 97606;
	_noteContact = ctrlText 97658;

	_nameContact = _nameContact splitString "'" joinString " ";
	_noteContact = _noteContact splitString "'" joinString " ";

	if (_nameContact in ["Identity", ""]) exitWith {["The identity is invalid",Color_Red] call A3PL_Player_Notification;};
	if (_phoneNumberContact in ["Number", ""]) exitWith {["The number is invalid",Color_Red] call A3PL_Player_Notification;};
	if (_noteContact isEqualTo "Note") then {_noteContact = ""};

	_exists = [_contacts, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (!(_exists isEqualTo [])) exitWith {["The contact is already existing",Color_Red] call A3PL_Player_Notification;};

	_contacts pushBack [_nameContact, _phoneNumberContact, _noteContact];
	A3PL_contacts = [_contacts,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
	[_uid, _nameContact, _phoneNumberContact, _noteContact] remoteExec ["Server_iPhoneX_SaveContact",2];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhoneX_PhoneContacts", []]);
	[] call A3PL_iPhoneX_AppContactsList;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddConversation",
{
	private["_uid","_conversations","_nameContact","_phoneNumberContact","_exists","_error"];
	disableSerialization;

	if (count A3PL_conversations > 100) exitWith {["The conversation limit has been reached",Color_Red] call A3PL_Player_Notification;};

	_uid = getPlayerUID player;
	_conversations = A3PL_conversations;
	_nameContact = ctrlText 97607;
	_phoneNumberContact = ctrlText 97608;
	_message = "No message";
	_error = false;

	_nameContact = _nameContact splitString "'" joinString " ";
	_message = _message splitString "'" joinString " ";

	if (_nameContact in ["Identity", ""]) exitWith {["The identity is invalid",Color_Red] call A3PL_Player_Notification;};
	if (_phoneNumberContact in ["Number", ""]) exitWith {["The number is invalid",Color_Red] call A3PL_Player_Notification;};
	if !(isNil "A3PL_phoneNumberPrimary") then {if (A3PL_phoneNumberPrimary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberSecondary") then {if (A3PL_phoneNumberSecondary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberEnterprise") then {if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then {_error = true};};

	if (_error) exitWith {["You can not create a conversation with this number",Color_Red] call A3PL_Player_Notification; _error = false;};

	_exists = [_conversations, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (!(_exists isEqualTo [])) exitWith {["A conversation with this contact already exists",Color_Red] call A3PL_Player_Notification;};

	_conversations pushBack [_nameContact, _phoneNumberContact, "No message"];
	A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
	[_uid, _nameContact, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhoneX_PhoneConversations", []]);
	_error = false;
	[] call A3PL_iPhoneX_AppSMSList;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddEvent",
{
	private["_uid","_contacts","_nameContact","_phoneNumberContact","_exists"];
	disableSerialization;

	_uid = getPlayerUID player;
	_events = A3PL_events;
	_nameOwner = ctrlText 98291;
	_nameEvent = ctrlText 98292;
	_description = ctrlText 98296;
	_price = ctrlText 98295;
	_position = ctrlText 98297;
	_phoneNumber = ctrlText 98298;
	_date = ctrlText 98293;
	_time = ctrlText 98294;

	if (_nameOwner in ["Identity", ""]) exitWith {["The identity is invalid",Color_Red] call A3PL_Player_Notification;};
	if (_nameEvent in ["Event Name", ""]) exitWith {["Le nom de l'événement est invalide",Color_Red] call A3PL_Player_Notification;};
	if (_description in ["Description", ""]) exitWith {["La description de l'événement est invalide",Color_Red] call A3PL_Player_Notification;};
	if (_price isEqualTo "Price") then {_price = "Inconnu"};
	if (_position isEqualTo "Position") then {_price = "Inconnue"};
	if (_phoneNumber isEqualTo "Contact") then {_price = "Inconnu"};
	if (_date in ["jj/mm/aaaa", ""]) exitWith {["La date de l'événement est invalide",Color_Red] call A3PL_Player_Notification;};
	if (_time in ["hh:mm", ""]) exitWith {["L'heure de l'événement est invalide",Color_Red] call A3PL_Player_Notification;};
	if ((count _date) != 10) exitWith {["La date de l'événement est invalide",Color_Red] call A3PL_Player_Notification;};
	if ((count _time) != 5) exitWith {["L'heure de l'événement est invalide (format hh:mm)",Color_Red] call A3PL_Player_Notification;};
	if ((count _phoneNumber) != 7) exitWith {["Le numéro de téléphone est invalide",Color_Red] call A3PL_Player_Notification;};

	_events pushBack [_nameOwner, _nameEvent, _description, _price, _position, _phoneNumber, _date, _time];
	[_uid, _nameOwner, _nameEvent, _description, _price, _position, _phoneNumber, _date, _time] remoteExec ["Server_iPhoneX_saveEvent",2];

	[] call A3PL_iPhoneX_Home;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddPhoneNumberEnterprise",
{
	private["_uid","_type","_price","_phoneNumber"];
	disableSerialization;

	_uid = getPlayerUID player;
	_type = "3";
	_price = 27215;

	_phoneNumber = [6,3];
	while {(count _phoneNumber < 6)} do {
		_phoneNumber = [6,3];
		for "_i" from 0 to 4 do {
			_phoneNumber pushBack (selectRandom [0,1,2,3,4,5,6,7,8,9]);
		};
	};

	_phoneNumber = _phoneNumber joinString "";
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	//_isBoss = [getPlayerUID player] call A3PL_Config_IsCompanyBoss;
	//if(!_isBoss) exitWith {["Vous n'êtes pas le patron de votre entreprise!",Color_Red] call A3PL_Player_Notification;};

	[player, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberSubscription",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberSubscription isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberSubscription) exitWith {["You already have a company subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberSubscription = [];};

	_bank = (player getVariable["Player_Bank",0]);
	if(_bank < _price) exitWith {[format ["You don't have $%1!",_price],Color_Red] call A3PL_Player_Notification;};
	//_cid = [getPlayerUID player] call A3PL_Config_GetCompanyID;
	//_cBank = [_cid, "bank"] call A3PL_Config_GetCompanyData;

	//if(_cBank < _price) exitWith {[format ["Votre entreprise ne possede pas $%1 pour prendre un abonnement!",_price],Color_Red] call A3PL_Player_Notification;};

	[player, _phoneNumber, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberIsUsed",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberIsUsed isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberIsUsed) exitWith {["Error buying the subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberIsUsed = [];};

	[_uid, _phoneNumber, _type] remoteExec ["Server_iPhoneX_AddPhoneNumber",2];

	["Activation of the subscription...",Color_Orange] call A3PL_Player_Notification;
	uiSleep 5;

	[player] remoteExec ["Server_iPhoneX_getPhoneNumber",2];

	iPhoneX_CheckPhoneNumberSubscription = [];
	iPhoneX_CheckPhoneNumberIsUsed = [];

	[format ["Your subscription has been activated. Your company number is  %1",_phoneNumber],Color_Green] call A3PL_Player_Notification;

	player setVariable["Player_Bank",_bank-_price,true];
	//[_cid, -_price, "Abonnement téléphonique"] remoteExec ["Server_Company_SetBank",2];

	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddPhoneNumberPrimary",
{
	private["_uid","_type","_price","_phoneNumber"];
	disableSerialization;

	_uid = getPlayerUID player;
	_type = "1";
	_price = 912;

	_phoneNumber = [6,3];
	while {(count _phoneNumber < 6)} do {
		_phoneNumber = [6,3];
		for "_i" from 0 to 4 do {
			_phoneNumber pushBack (selectRandom [0,1,2,3,4,5,6,7,8,9]);
		};
	};

	_phoneNumber = _phoneNumber joinString "";

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	[player, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberSubscription",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberSubscription isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberSubscription) exitWith {["You already have a primary subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberSubscription = [];};

	_bank = (player getVariable["Player_Bank",0]);
	if(_bank < _price) exitWith {[format ["You don't have $%1!",_price],Color_Red] call A3PL_Player_Notification;};

	[player, _phoneNumber, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberIsUsed",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberIsUsed isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberIsUsed) exitWith {["Error buying the subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberIsUsed = [];};

	[_uid, _phoneNumber, _type] remoteExec ["Server_iPhoneX_addPhoneNumber",2];

	["Activation of the subscription...",Color_Orange] call A3PL_Player_Notification;
	uiSleep 5;

	[player] remoteExec ["Server_iPhoneX_getPhoneNumber",2];

	iPhoneX_CheckPhoneNumberSubscription = [];
	iPhoneX_CheckPhoneNumberIsUsed = [];

	[format ["Your subscription has been activated. Your primary number is %1",_phoneNumber],Color_Green] call A3PL_Player_Notification;
	player setVariable["Player_Bank",_bank-_price,true];
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AddPhoneNumberSecondary",
{
	private["_uid","_type","_price","_phoneNumber"];
	disableSerialization;

	_uid = getPlayerUID player;
	_type = "2";
	_price = 8024;

	_phoneNumber = [6,3];
	while {(count _phoneNumber < 6)} do {
		_phoneNumber = [6,3];
		for "_i" from 0 to 4 do {
			_phoneNumber pushBack (selectRandom [0,1,2,3,4,5,6,7,8,9]);
		};
	};

	_phoneNumber = _phoneNumber joinString "";

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	//if (!(["motorhead"] call A3PL_Lib_hasPerk)) exitWith {["You need to have motorhead perk for buy secondary subscription! www.arma3realitylife.com",Color_Red] call A3PL_Player_Notification;};

	[player, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberSubscription",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberSubscription isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberSubscription) exitWith {["You already have a secondary subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberSubscription = [];};

	_bank = (player getVariable["Player_Bank",0]);
	if(_bank < _price) exitWith {[format ["You don't have $%1!",_price],Color_Red] call A3PL_Player_Notification;};

	[player, _phoneNumber, _type] remoteExec ["Server_iPhoneX_CheckPhoneNumberIsUsed",2];
	waitUntil {!(iPhoneX_CheckPhoneNumberIsUsed isEqualTo [])};

	if (iPhoneX_CheckPhoneNumberIsUsed) exitWith {["Error buying the subscription",Color_Red] call A3PL_Player_Notification; iPhoneX_CheckPhoneNumberIsUsed = [];};

	[_uid, _phoneNumber, _type] remoteExec ["Server_iPhoneX_addPhoneNumber",2];

	["Activation of the subscription...",Color_Orange] call A3PL_Player_Notification;
	uiSleep 5;

	[player] remoteExec ["Server_iPhoneX_getPhoneNumber",2];

	iPhoneX_CheckPhoneNumberSubscription = [];
	iPhoneX_CheckPhoneNumberIsUsed = [];

	[format ["Your subscription has been activated. Your secondary number is %1",_phoneNumber],Color_Green] call A3PL_Player_Notification;
	player setVariable["Player_Bank",_bank-_price,true];
	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppAddContact",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_nameContact","_iPhone_X_phoneNumberContact","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97503,97504,99714,99715,99716,99719,99718,99721,97720];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97505,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_nameContact = _display displayCtrl 97605;
	_iPhone_X_phoneNumberContact = _display displayCtrl 97606;
	_iPhone_X_noteContact = _display displayCtrl 97658;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appAddContact.paa";
	_iPhone_X_nameContact ctrlSetText "Identity";
	_iPhone_X_phoneNumberContact ctrlSetText "Number";
	_iPhone_X_noteContact ctrlSetText "Note";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppAddConversation",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_nameConversation","_iPhone_X_phoneNumberConversation","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97506,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97507,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_nameConversation = _display displayCtrl 97607;
	_iPhone_X_phoneNumberConversation = _display displayCtrl 97608;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appAddConversations.paa";
	_iPhone_X_nameConversation ctrlSetText "Identity";
	_iPhone_X_phoneNumberConversation ctrlSetText "Number";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppAddEvent",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_nameContact","_iPhone_X_phoneNumberContact","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,98270,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [98290,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameOwner = _display displayCtrl 98292;
	_iPhone_X_nameEvent = _display displayCtrl 98291;
	_iPhone_X_description = _display displayCtrl 98296;
	_iPhone_X_date = _display displayCtrl 98293;
	_iPhone_X_time = _display displayCtrl 98294;
	_iPhone_X_price = _display displayCtrl 98295;
	_iPhone_X_position = _display displayCtrl 98297;
	_iPhone_X_phoneNumber = _display displayCtrl 98298;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appAddContact.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
	_iPhone_X_nameOwner ctrlSetText "Identity";
	_iPhone_X_nameEvent ctrlSetText "Your Event";
	_iPhone_X_description ctrlSetText "Description";
	_iPhone_X_date ctrlSetText "jj/mm/aaaa";
	_iPhone_X_time ctrlSetText "hh:mm";
	_iPhone_X_position ctrlSetText "Position";
	_iPhone_X_price ctrlSetText "Price";
	_iPhone_X_phoneNumber ctrlSetText "Contact";
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppCall",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_phoneNumber","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97005,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97115,97501,97503,97509,97800,97801,97805,98260,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97517,true];

	_ctrl2 = [97667,97663,97668,97664,97669,97665,97671,97672,97673,97674,97675,97676,97677,97678];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl2;

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appCall.paa";
	_iPhone_X_clock_home ctrlSetTextColor [1,1,1,1];

	_callSettings = player getVariable ["A3PL_iPhoneX_CallSettings", ""];

	systemChat (format["%1", _callSettings]);

	if !(isNil "_callSettings") then
	{
		if !(_callSettings isEqualTo []) then
		{
			_phoneNumberContact = _callSettings select 1;

			_display = findDisplay 97000;

			_iPhone_X_phoneNumber = _display displayCtrl 97661;
			_iPhone_X_informations = _display displayCtrl 97670;

			_iPhone_X_phoneNumber ctrlSetText _phoneNumberContact;

			_phoneNumberSendCall = player getVariable ["A3PL_iPhoneX_PhoneNumberSendCall",""];
			//Send call
			if ((_callSettings select 0) isEqualTo "1") then {
				ctrlShow [97667,true]; 
				ctrlShow [97663,true]; 
				buttonSetAction [97663, "
					_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",""""]; 
					if !(_sound isEqualTo []) then {
						deleteVehicle _sound;
					};
					playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 20, 1, 5]; 
					[] spawn A3PL_iPhoneX_EndCall; 
					_phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; 
					_exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; 
					if (!(_exists isEqualTo [])) then {
						[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]
					};
				"]; 
				_iPhone_X_informations ctrlSetText (_callSettings select 2)
			};
			if ((_callSettings select 0) isEqualTo "2") then {
				ctrlShow [97675,true]; 
				ctrlShow [97676,true]; 
				ctrlShow [97677,true]; 
				ctrlShow [97678,true]; 
				//Accept call?
				buttonSetAction [97676, "
					[] spawn A3PL_iPhoneX_StartCall; 
					_phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; 
					_exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; 
					if (!(_exists isEqualTo [])) then {
						[] remoteExec [""A3PL_iPhoneX_StartCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]
					};
				"];
				//Decline call?
				buttonSetAction [97678, "
					_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",""""]; 
					if !(_sound isEqualTo []) then {deleteVehicle _sound;}; 
					playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 20, 1, 5]; 
					[] spawn A3PL_iPhoneX_EndCall; 
					_phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; 
					_exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; 
					if (!(_exists isEqualTo [])) then {
						 [] remoteExec [""A3PL_iPhoneX_StartCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]
					};"
				];
			};
			//Active call
			if ((_callSettings select 0) isEqualTo "3") then {
				ctrlShow [97667,true]; 
				ctrlShow [97663,true]; 
				ctrlShow [97668,true]; 
				ctrlShow [97664,true]; 
				ctrlShow [97669,true]; 
				ctrlShow [97665,true]; 
				ctrlShow [97671,true]; 
				ctrlShow [97672,true]; 
				ctrlShow [97673,true]; 
				ctrlShow [97674,true];
				if (A3PL_phoneNumberActive isEqualTo _phoneNumberSendCall) then {
					buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
				} else {
					buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
				};

				_iPhone_X_informations ctrlSetText (_callSettings select 2);

				_hour = _callSettings select 3;
				_minute = _callSettings select 4;
				_second = _callSettings select 5;
				[] spawn {
					while {A3PL_phoneInCall} do
					{
						_time = format["%1:%2:%3", if (_hour < 10) then {"0" + (str _hour)} else {_hour}, if (_minute < 10) then {"0" + (str _minute)} else {_minute}, if (_second < 10) then {"0" + (str _second)} else {_second}];
						_second = _second + 1;
						if (_second >= 60) then {_second = 0; _minute = _minute + 1};
						if (_minute >= 60) then {_minute = 0; _hour = _hour + 1};
						_iPhone_X_informations ctrlSetText _time;
						player setVariable ["A3PL_iPhoneX_CallSettings", ["3", _phoneNumberContact, _time, _hour, _minute, _second]];
						uiSleep 1;
					};
				}
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppCamera",
{
	private["_display","_ctrl","_progressTime","_startTime","_endTime","_background_iPhone_X_base","_background_iPhone_X_background","_angle","_progress","_renderSurface","_cam"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97114,97117,97500,97502,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	_progressTime = 1.5;
	_startTime = time;
	_endTime = _startTime + _progressTime;
	_background_iPhone_X_base = _display displayCtrl 97001;
	_background_iPhone_X_background = _display displayCtrl 97002;
	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";

	_angle = (ctrlAngle _background_iPhone_X_base select 0);

	if (_angle == 0) then {
		noesckey = (findDisplay 97000) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

		while {time <= _endTime} do {
			_progress = linearConversion[_startTime, _endTime, time, 0, -90];
			_background_iPhone_X_base ctrlSetAngle [_progress,0.5,0.5];
			_background_iPhone_X_background ctrlSetAngle [_progress,0.5,0.5];
			_background_iPhone_X_base ctrlCommit 0;
			_background_iPhone_X_background ctrlCommit 0;
		};

		_background_iPhone_X_base ctrlSetAngle [-90,0.5,0.5];
		_background_iPhone_X_background ctrlSetAngle [-90,0.5,0.5];
		_background_iPhone_X_base ctrlCommit 0;
		_background_iPhone_X_background ctrlCommit 0;

		ctrlShow [97002, false];
		(findDisplay 97000) displayRemoveEventHandler ["KeyDown", noesckey];
	};

	ctrlShow [97502, true];
	ctrlShow [97502, true];
	ctrlShow [97502, true];

	_renderSurface = ((findDisplay 97000) displayCtrl 97602);
	_renderSurface ctrlSetText "#(argb,512,512,1)r2t(cam,1)";
	_cam = "camera" camCreate (getPos player);
	_cam cameraEffect ["External", "Back", "cam"];
	_cam camSetTarget player;
	_cam attachTo [player, [0.1, 0.75, 1.5] ];
	_cam camSetFov 0.5;
	_cam camCommit 0;

	buttonSetAction [97603, "[] spawn A3PL_iPhoneX_AppFrontCamera"];

	waitUntil{isNull (findDisplay 97000)};
	camDestroy _cam;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppContact",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppContact","_iPhone_X_phoneNumberContactAppContact"];
	disableSerialization;

	_index = _this select 0;
	_nameContact = _this select 1;
	_phoneNumberContact = _this select 2;
	_noteContact = _this select 3;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97503,97504,99714,99715,99716,97720,99719,99718,99721,97722];

	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	ctrlShow [97509,true];

	if (isNil "A3PL_phoneNumberActive") then {ctrlEnable [97657,false];};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameContactAppContact = _display displayCtrl 97609;
	_iPhone_X_phoneNumberContactAppContact = _display displayCtrl 97610;
	_iPhone_X_noteContactAppContact = _display displayCtrl 97659;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appContact.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	_iPhone_X_nameContactAppContact ctrlSetText _nameContact;
	_iPhone_X_phoneNumberContactAppContact ctrlSetText _phoneNumberContact;
	_iPhone_X_noteContactAppContact ctrlSetText _noteContact;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppContactsList",
{
	private["_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_nameContact","_phoneNumberContact","_tmp","_ctrlList","_pos"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97504);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97514);
	_ctrlList = [];
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97503,97505,97509,99714,99715,99716,97720,99719,99718,99721,97722];

	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	ctrlShow [97504,true];

	if (isNil "A3PL_phoneNumberActive") then {ctrlEnable [97654,false];};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appContactsList.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneContacts", []]);

	if (!(A3PL_contacts isEqualTo [])) then {
		{
			_nameContact = _x select 0;
			_phoneNumberContact = _x select 1;
			_noteContact = _x select 2;
			_tmp = _display ctrlCreate ["iPhone_X_contacts", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98002) ctrlSetText _nameContact;
			(_tmp controlsGroupCtrl 98003) ctrlSetText _phoneNumberContact;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3', '%4'] spawn A3PL_iPhoneX_AppContact;", _forEachIndex, _nameContact, _phoneNumberContact, _noteContact]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_contacts;
	};
	player setVariable ["iPhoneX_PhoneContacts", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppEvent",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppContact","_iPhone_X_phoneNumberContactAppContact"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,98270,98290,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [98270,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appContactsList.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhone_X_events", []]);

	[player] remoteExec ["A3PL_iPhoneX_getEvents",2];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppEventLoad",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppContact","_iPhone_X_phoneNumberContactAppContact"];
	disableSerialization;

	_index = _this select 0;
	_nameOwner = _this select 1;
	_nameEvent = _this select 2;
	_description = _this select 3;
	_price = _this select 4;
	_position = _this select 5;
	_phoneNumber = _this select 6;
	_date = _this select 7;
	_time = _this select 8;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,98270,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [98280,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameOwner = _display displayCtrl 98283;
	_iPhone_X_nameEvent = _display displayCtrl 98281;
	_iPhone_X_description = _display displayCtrl 98282;
	_iPhone_X_date = _display displayCtrl 98284;
	_iPhone_X_time = _display displayCtrl 98285;
	_iPhone_X_price = _display displayCtrl 98286;
	_iPhone_X_position = _display displayCtrl 98287;
	_iPhone_X_phoneNumber = _display displayCtrl 98288;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appContactsList.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
	_iPhone_X_nameOwner ctrlSetText format["Organized by : %1", _nameOwner];
	_iPhone_X_nameEvent ctrlSetText _nameEvent;
	_iPhone_X_description ctrlSetText _description;
	_iPhone_X_date ctrlSetText _date;
	_iPhone_X_time ctrlSetText _time;
	_iPhone_X_position ctrlSetText format["Position : %1", _position];
	_iPhone_X_price ctrlSetText format["Price : %1", _price];
	_iPhone_X_phoneNumber ctrlSetText format["Contact : %1", _phoneNumber];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppFrontCamera",
{
	private["_display","_ctrl","_renderSurface","_cam"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97500,97502,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97502, true];

	_renderSurface = ((findDisplay 97000) displayCtrl 97602);
	_renderSurface ctrlSetText "#(argb,512,512,1)r2t(frontcam,1)";
	_cam = "camera" camCreate (getPos player);
	_cam cameraEffect ["Internal", "Back", "frontcam"];
	_cam camSetTarget player;
	_cam attachTo [player, [0.1, 0.75, 1.75] ];
	_cam camSetFov 0.5;
	_cam camCommit 0;

	buttonSetAction [97603, "[] spawn A3PL_iPhoneX_AppCamera"];

	waitUntil{isNull (findDisplay 97000)};
	camDestroy _cam;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppPhone",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_phoneNumber","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97505,97509,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97503,true];

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlEnable [97656,false];
		ctrlEnable [97660,false];
	};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_phoneNumber = _display displayCtrl 97613;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appPhone.paa";
	_iPhone_X_phoneNumber ctrlSetText "Number";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppPMC",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppContact","_iPhone_X_phoneNumberContactAppContact"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,98122,98155,98199,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [98133,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appPMC.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSettings",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97508,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSettings.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSIM",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_SIM_1","_iPhone_X_SIM_2","_iPhone_X_SIM_3","_iPhone_X_button_SIM_1","_iPhone_X_button_SIM_2","_iPhone_X_button_SIM_3"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97508,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97515,true];
	ctrlShow [97719,false];
	ctrlShow [97720,false];
	ctrlShow [97721,false];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_SIM_1 = _display displayCtrl 97616;
	_iPhone_X_SIM_2 = _display displayCtrl 97617;
	_iPhone_X_SIM_3 = _display displayCtrl 97618;
	_iPhone_X_button_SIM_1 = _display displayCtrl 97619;
	_iPhone_X_button_SIM_2 = _display displayCtrl 97620;
	_iPhone_X_button_SIM_3 = _display displayCtrl 97621;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSIM.paa";

	if !(isNil "A3PL_phoneNumberPrimary") then {_iPhone_X_SIM_1 ctrlSetText format["PRIMARY : %1", A3PL_phoneNumberPrimary]; ctrlShow [97719,true];};
	if !(isNil "A3PL_phoneNumberSecondary") then {_iPhone_X_SIM_2 ctrlSetText format["SECONDARY : %1", A3PL_phoneNumberSecondary]; ctrlShow [97720,true];};
	if !(isNil "A3PL_phoneNumberEnterprise") then {_iPhone_X_SIM_3 ctrlSetText format["COMPANY : %1", A3PL_phoneNumberEnterprise]; ctrlShow [97721,true];};
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	if !(isNil "A3PL_phoneNumberActive") then
	{
		if !(isNil "A3PL_phoneNumberPrimary") then
		{
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberPrimary) then {_iPhone_X_SIM_1 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97719,false];} else {_iPhone_X_SIM_1 ctrlSetTextColor [0,0,0,1]; ctrlShow [97719,true];};
		};

		if !(isNil "A3PL_phoneNumberSecondary") then
		{
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberSecondary) then {_iPhone_X_SIM_2 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97720,false];} else {_iPhone_X_SIM_2 ctrlSetTextColor [0,0,0,1]; ctrlShow [97720,true];};
		};

		if !(isNil "A3PL_phoneNumberEnterprise") then
		{
			if (A3PL_phoneNumberActive isEqualTo A3PL_phoneNumberEnterprise) then {_iPhone_X_SIM_3 ctrlSetTextColor [0.027,0.576,0.047,1]; ctrlShow [97721,false];} else {_iPhone_X_SIM_3 ctrlSetTextColor [0,0,0,1]; ctrlShow [97721,false];};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMS",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppSMS"];
	disableSerialization;

	_index = _this select 0;
	_nameContact = _this select 1;
	_phoneNumberContact = _this select 2;

	_display = findDisplay 97000;

	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97503,97506,97510,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97510,true];
	ctrlEnable [97621,true];
	ctrlShow [97621,true];
	ctrlEnable [97622,true];
	ctrlEnable [97623,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameContactAppSMS = _display displayCtrl 97620;

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlEnable [97621,false];
		ctrlEnable [97622,false];
		ctrlEnable [97623,false];
	};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			ctrlEnable [97621,false];
			ctrlShow [97621,false];
			ctrlEnable [97622,false];
			ctrlEnable [97623,false];
			_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMSEnterprise.paa";
		};
	};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if !(A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
		};
	} else {
		_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
	};

	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	player setVariable ["iPhoneX_CurrentConversation", []];

	_iPhone_X_nameContactAppSMS ctrlSetText _nameContact;

	if (isNil "A3PL_phoneNumberActive") exitWith {};
	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			[player, _phoneNumberContact] remoteExec ["Server_iPhoneX_getSMSEnterprise",2];
		};
	};

	if !(isNil "A3PL_phoneNumberEnterprise") then
	{
		if !(A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then
		{
			[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_GetSMS",2];
		};
	} else {
		[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_GetSMS",2];
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSFromContact",
{
	private["_uid","_nameContact","_phoneNumberContact","_conversations","_exists"];
	disableSerialization;

	_uid = getPlayerUID player;
	_nameContact = _this select 0;
	_phoneNumberContact = _this select 1;
	_conversations = A3PL_conversations;
	_message = "No message";

	_exists = [_conversations, _phoneNumberContact] call BIS_fnc_findNestedElement;
	if (_exists isEqualTo []) then
	{
		_conversations pushBack [_nameContact, _phoneNumberContact];
		A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
		[_uid, _nameContact, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];

		{
		ctrlDelete _x;
		} count (player getVariable ["iPhoneX_PhoneConversations", []]);
	};

	[_nameContact, _phoneNumberContact] spawn A3PL_iPhoneX_AppSMSNew;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSFromNotification",
{
	private["_index","_nameContact","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppSMS"];
	disableSerialization;

	_nameContact = _this select 0;
	_phoneNumberContact = _this select 1;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97115,97501,97503,97506,97800,97801,97805,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	player setVariable ["iPhone_X_lastSMS", []];

	ctrlShow [97510,true];

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlEnable [97621,false];
		ctrlEnable [97622,false];
		ctrlEnable [97623,false];
	};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameContactAppSMS = _display displayCtrl 97620;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	_iPhone_X_nameContactAppSMS ctrlSetText _nameContact;

	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};

	if !(isNil "A3PL_phoneNumberActive") then {[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_getSMS",2];};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSList",
{
	private["_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_nameContact","_phoneNumberContact","_tmp","_ctrlList","_pos"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97506);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97516);
	_ctrlList = [];
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97507,97510,99714,99715,99716,97720,99719,99718,99721,97722];

	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	ctrlShow [97506,true];

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlEnable [97655,false];
	};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMSList.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_PhoneConversations", []]);

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	player setVariable ["iPhoneX_CurrentConversation", []];
	if (!(A3PL_conversations isEqualTo [])) then {
		{
			_nameContact = _x select 0;
			_phoneNumberContact = _x select 1;
			_lastSMS = _x select 2;
			_tmp = _display ctrlCreate ["iPhone_X_conversations", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98101) ctrlSetText _nameContact;
			(_tmp controlsGroupCtrl 98102) ctrlSetText _lastSMS;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3'] spawn A3PL_iPhoneX_AppSMS;", _forEachIndex, _nameContact, _phoneNumberContact]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_conversations;
	};
	player setVariable ["iPhoneX_PhoneConversations", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSMSNew",
{
	private["_nameContact","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_nameContactAppSMS"];
	disableSerialization;

	_nameContact = _this select 0;
	_phoneNumberContact = _this select 1;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97503,97506,97509,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97510,true];

	if (isNil "A3PL_phoneNumberActive") then
	{
		ctrlShow [97621,false];
		ctrlShow [97622,false];
		ctrlShow [97623,false];
	};

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_nameContactAppSMS = _display displayCtrl 97620;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSMS.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	_iPhone_X_nameContactAppSMS ctrlSetText _nameContact;
	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};

	[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_getSMS",2];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSound",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_sound_1","_iPhone_X_sound_2","_iPhone_X_sound_3","_soundActive"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97508,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97513,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_sound_1 = _display displayCtrl 97714;
	_iPhone_X_sound_2 = _display displayCtrl 97715;
	_iPhone_X_sound_3 = _display displayCtrl 97716;
	_iphone_X_silent = _display displayCtrl 97717;

	_soundActive = A3PL_settings select 1;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSound.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	if (_soundActive == 1) then {_iPhone_X_sound_1 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_1 ctrlSetTextColor [0,0,0,1];};
	if (_soundActive == 2) then {_iPhone_X_sound_2 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_2 ctrlSetTextColor [0,0,0,1];};
	if (_soundActive == 3) then {_iPhone_X_sound_3 ctrlSetTextColor [0.027,0.576,0.047,1];} else {_iPhone_X_sound_3 ctrlSetTextColor [0,0,0,1];};

	if ((A3PL_settings select 2) isEqualTo 0) then {
		_iphone_X_silent ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		_iphone_X_silent ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppUber",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_SIM_1","_iPhone_X_SIM_2","_iPhone_X_SIM_3","_iPhone_X_button_SIM_1","_iPhone_X_button_SIM_2","_iPhone_X_button_SIM_3"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97508,99714,99715,99716,97720,99719,99718,99721,97722];
	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	ctrlShow [10515,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_Uber_1 = _display displayCtrl 10616;
	_iPhone_X_Uber_2 = _display displayCtrl 10617;
	_iPhone_X_Uber_3 = _display displayCtrl 10618;
	_iPhone_X_button_Uber_1 = _display displayCtrl 10719;
	_iPhone_X_button_Uber_2 = _display displayCtrl 10720;
	_iPhone_X_button_Uber_3 = _display displayCtrl 10721;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appUber.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppGeneral",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_iPhone_X_sound_1","_iPhone_X_sound_2","_iPhone_X_sound_3","_soundActive"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97508];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97519,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iphone_X_hud = _display displayCtrl 99719;
	_iphone_X_twitter = _display displayCtrl 99718;
	_iphone_X_idplayer = _display displayCtrl 99721;
	_iphone_X_notification = _display displayCtrl 99722;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appGeneral.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	if (profilenamespace getVariable ["A3PL_HUD_Enabled",true]) then {
		_iphone_X_hud ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_iphone_X_hud ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};

	if (profilenamespace getVariable ["A3PL_Twitter_Enabled",true]) then {
		_iphone_X_twitter ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_iphone_X_twitter ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};

	if (profilenamespace getVariable ["Player_EnableID",true]) then {
		_iphone_X_idplayer ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_iphone_X_idplayer ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};

	if (profilenamespace getVariable ["A3PL_HINT_Enabled",true]) then {
		_iphone_X_notification ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		_iphone_X_notification ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppSwitchboard",
{
	private["_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home","_nameContact","_phoneNumberContact","_tmp","_ctrlList","_pos"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,99714,99715,99716,97720,99719,99718,99721,97722];

	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	ctrlShow [98260,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appSwitchboard.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];

	if (A3PL_phoneNumberActive isEqualTo []) exitWith {};

	if !(isNil "A3PL_phoneNumberActive") then
	{
		if ((player getVariable ["job","unemployed"]) IN ["dispatch"]) then {[player] remoteExec ["Server_iPhoneX_GetSwitchboardSD",2];};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_AppWallpaper",
{
	private["_display","_ctrl","_background_iPhone_X_background","_iPhone_X_clock_home"];
	disableSerialization;

	_display = findDisplay 97000;
	_ctrl = [97004,97006,97007,97008,97009,97010,97011,97012,97013,97014,97015,97016,97106,97107,97108,97109,97110,97111,97112,97113,97117,97508,99714,99715,99716,97720,99719,99718,99721,97722];

	{
		(_display displayCtrl _x) ctrlShow false;
	} forEach _ctrl;

	ctrlShow [97512,true];

	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_appWallpaper.paa";
	_iPhone_X_clock_home ctrlSetTextColor [0,0,0,1];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Clock",
{
	private["_display","_iPhone_X_clock_home","_iPhone_X_clock","_date","_hour","_minute","_time"];
	disableSerialization;

	_display = findDisplay 97000;

	_iPhone_X_clock_home = _display displayCtrl 97500;
	_iPhone_X_clock = _display displayCtrl 97501;

	while {!(isNull (findDisplay 97000))} do
	{
		_date = date;
		_hour = str (_date select 3);
		_minute  = str (_date select 4);
		_time = format["%1:%2", if(count _hour == 1) then {("0" + _hour)} else {_hour}, if(count _minute == 1) then {("0" + _minute)} else {_minute}];

		_iPhone_X_clock ctrlSetText _time;
		_iPhone_X_clock_home ctrlSetText _time;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Contacts",
{
	private ["_contacts"];
	_contacts = [_this,0,[],[[]]] call BIS_fnc_param;

	if ((_contacts isEqualTo [[]]) || (isNil "_contacts")) then {_contacts = [];};
	A3PL_contacts = _contacts;

	if (isNil "A3PL_contacts") then {A3PL_contacts = []};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Conversations",
{
	private ["_conversations"];
	_conversations = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_conversations isEqualTo [[]]) then {_conversations = [];};
	A3PL_conversations = _conversations;

	if (isNil "A3PL_conversations") then {A3PL_conversations = []};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EditString",
{
	_message = "Salut :)";

	_toFind = ":)";
	_replaceBy = "lol";

	_numberCharToReplace = count _toFind;
	_numberFind = _message find _toFind;

	while {_numberFind != -1} do {
		_numberFind = _message find _toFind;
		if (_numberFind isEqualTo -1) exitWith {};
		_splitMessage = _message splitString "";
		_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		_splitMessage set [_numberFind, _replaceBy];
		_message = _splitMessage joinString "";
	};

	_message = "1491";
	_message = _message splitString "" joinString " ";

	_toFind = " ";
	_replaceBy = ",";

	_numberCharToReplace = count _toFind;
	_numberFind = _message find _toFind;

	while {_numberFind != -1} do {
	_numberFind = _message find _toFind;
	if (_numberFind isEqualTo -1) exitWith {};
	_splitMessage = _message splitString "";
	_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
	_splitMessage set [_numberFind, _replaceBy];
	_message = _splitMessage joinString "";
	};

	hint str _message;
}] call Server_Setup_Compile;


["A3PL_iPhoneX_StartCall",
{
	private["_phoneNumber"];
	disableSerialization;

	A3PL_phoneInCall = true;

	_display = findDisplay 97000;

	_iPhone_X_informations = _display displayCtrl 97670;
	systemChat "fcuk you";
	_sound = player getVariable ["A3PL_iPhoneX_SoundCall",""];
	if !(_sound isEqualTo []) then {deleteVehicle _sound;};
	_phoneNumberSendCall = player getVariable ["A3PL_iPhoneX_PhoneNumberSendCall",""];
	_phoneNumberContact = player getVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall",""];

	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};
	systemChat "here 1";

	[(call TFAR_fnc_activeSwRadio), format["%1", _phoneNumberSendCall]] call TFAR_fnc_setSwFrequency;

	_ctrl = [97675,97676,97677,97678];
	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;
	ctrlShow [97667,true];
	ctrlShow [97663,true];
	ctrlShow [97668,true];
	ctrlShow [97664,true];
	ctrlShow [97669,true];
	ctrlShow [97665,true];
	ctrlShow [97671,true];
	ctrlShow [97672,true];
	ctrlShow [97673,true];
	ctrlShow [97674,true];

	if ((A3PL_phoneNumberActive) isEqualTo (_phoneNumberSendCall)) then {
		buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
	} else {
		buttonSetAction [97663, "[] spawn A3PL_iPhoneX_EndCall; _phoneNumberSendCall = player getVariable [""A3PL_iPhoneX_PhoneNumberSendCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberSendCall] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
	};

	_info = "Call in progress...";

	_hour = 0;
	_minute = 0;
	_second = 0;

	while {A3PL_phoneInCall} do
	{
		_time = format["%1:%2:%3", if (_hour < 10) then {"0" + (str _hour)} else {_hour}, if (_minute < 10) then {"0" + (str _minute)} else {_minute}, if (_second < 10) then {"0" + (str _second)} else {_second}];
		_second = _second + 1;
		if (_second >= 60) then {_second = 0; _minute = _minute + 1};
		if (_minute >= 60) then {_minute = 0; _hour = _hour + 1};
		_iPhone_X_informations ctrlSetText _time;
		player setVariable ["A3PL_iPhoneX_CallSettings", ["3", _phoneNumberContact, _time, _hour, _minute, _second]];
		uiSleep 1;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EndCall",
{
	private["_type","_display","_iPhone_X_phoneNumber"];
	disableSerialization;

	_display = findDisplay 97000;

	_iPhone_X_phoneNumber = _display displayCtrl 97661;
	_iPhone_X_informations = _display displayCtrl 97670;

	_sound = player getVariable ["A3PL_iPhoneX_SoundCall",""];

	if !(_sound isEqualTo []) then {deleteVehicle _sound;};

	if (A3PL_phoneInCall) then {_info = "Call ended";};

	_iPhone_X_phoneNumber ctrlSetText "";
	_iPhone_X_informations ctrlSetText "";
	A3PL_iPhoneX_ListNumberClient = [];
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", []];
	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;
	[(call TFAR_fnc_activeSwRadio), 1, (getPlayerUid player)] call TFAR_fnc_SetChannelFrequency;

	if (!isNull (findDisplay 97000)) then {[] spawn A3PL_iPhoneX_Home;};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_EndCallSwitchboard",
{
	private["_type","_display","_iPhone_X_phoneNumber"];
	disableSerialization;

	_fromNum = _this select 0;

	if !(isNil A3PL_phoneNumberEnterprise) then {
		if ((A3PL_phoneNumberEnterprise isEqualTo "911")) then {
			_exists = [A3PL_switchboard, _fromNum] call BIS_fnc_findNestedElement;
			if (!(_exists isEqualTo [])) then {
				A3PL_switchboard = ([A3PL_switchboard, (_exists select 0)] call BIS_fnc_removeIndex);
				if ((player getVariable ["job","unemployed"]) IN ["dispatch"]) then {[A3PL_switchboard] remoteExec ["Server_iPhoneX_SetSwitchboardSD",2];};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Events",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;

	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};

	A3PL_events = _result;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 98270);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 98271);
	_ctrlList = [];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhone_X_events", []]);

	if (!(A3PL_events isEqualTo [])) then {
		{
			_nameOwner = _x select 0;
			_nameEvent = _x select 1;
			_description = _x select 2;
			_price = _x select 3;
			_position = _x select 4;
			_phoneNumber = _x select 5;
			_date = _x select 6;
			_time = _x select 7;
			_tmp = _display ctrlCreate ["iPhone_X_events", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98061) ctrlSetText _nameEvent;
			(_tmp controlsGroupCtrl 98062) ctrlSetText format["%1",_price];
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9'] spawn A3PL_iPhoneX_AppEventLoad;", _forEachIndex, _nameOwner, _nameEvent, _description, _price, _position, _phoneNumber, _date, _time]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_events;
	};

	player setVariable ["iPhone_X_events", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GetPhoneNumberIsUsed",
{
	private ["_phoneNumberIsUse"];
	_phoneNumberIsUse = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_phoneNumberIsUse isEqualTo [[]]) then {_phoneNumberIsUse = [];};

	if (_phoneNumberIsUse isEqualTo []) then {_phoneNumberIsUse = false;} else {_phoneNumberIsUse = true;};

	iPhoneX_CheckPhoneNumberIsUsed = _phoneNumberIsUse;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_GetPhoneNumberSubscription",
{
	private ["_phoneNumberSubscription"];
	_phoneNumberSubscription = [_this,0,[],[[]]] call BIS_fnc_param;
	if (_phoneNumberSubscription isEqualTo [[]]) then {_phoneNumberSubscription = [];};
	if (_phoneNumberSubscription isEqualTo []) then {_phoneNumberSubscription = false;} else {_phoneNumberSubscription = true;};
	iPhoneX_CheckPhoneNumberSubscription = _phoneNumberSubscription;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Home",
{
	private["_display","_ctrl","_background_iPhone_X_base","_background_iPhone_X_background","_iPhone_X_clock_home","_angle","_wallpaperActive","_progressTime","_startTime","_endTime","_progress","_ctrl2"];
	disableSerialization;

	_display = findDisplay 97000;
	ctrlShow [97002, true];
	_ctrl = [97005,97501,97502,97503,97504,97505,97506,97507,97508,97509,97510,97512,97513,97515,97517,97115,97800,97801,97805,98122,98133,98144,98155,98166,98177,98188,98199,98210,98220,98230,98240,98260,98270,98280,98290,99714,99715,99716,97720,99719,99718,99721,99722,97519,10515,10616,10617,10618,10719,10720,10721];
	{(_display displayCtrl _x) ctrlShow false;} forEach _ctrl;

	_background_iPhone_X_base = _display displayCtrl 97001;
	_background_iPhone_X_background = _display displayCtrl 97002;
	_iPhone_X_clock_home = _display displayCtrl 97500;

	_angle = (ctrlAngle _background_iPhone_X_base select 0);

	_wallpaperActive = "A3PL_Common\GUI\phone\iPhone_X_background_%1.paa";

	if (_angle < 0) then {
		noesckey = (findDisplay 97000) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

		_progressTime = 1.5;
		_startTime = time;
		_endTime = _startTime + _progressTime;
		_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";

		while {time <= _endTime} do {
			_progress = linearConversion[_startTime, _endTime, time, -90, 0];
			_background_iPhone_X_base ctrlSetAngle [_progress,0.5,0.5];
			_background_iPhone_X_background ctrlSetAngle [_progress,0.5,0.5];
			_background_iPhone_X_base ctrlCommit 0;
			_background_iPhone_X_background ctrlCommit 0;
		};

		_background_iPhone_X_base ctrlSetAngle [0,0.5,0.5];
		_background_iPhone_X_background ctrlSetAngle [0,0.5,0.5];
		_background_iPhone_X_base ctrlCommit 0;
		_background_iPhone_X_background ctrlCommit 0;
		_background_iPhone_X_background ctrlSetText format[_wallpaperActive, (A3PL_settings select 0)];

		(findDisplay 97000) displayRemoveEventHandler ["KeyDown", noesckey];
	};

	_ctrl2 = [97004,97006,97007,97008,97009,97010,97011,97012,97016,97106,97107,97108,97109,97110,97111,97112,97117,97500];
	{
		(_display displayCtrl _x) ctrlShow true;
	} forEach _ctrl2;

	if ((player getVariable ["job","unemployed"]) IN ["dispatch"]) then
	{
		ctrlShow [97013,true];
		ctrlShow [97113,true];
		ctrlShow [97014,true];
		ctrlShow [97015,true];
	};

	_background_iPhone_X_background ctrlSetText format[_wallpaperActive, (A3PL_settings select 0)];
	_iPhone_X_clock_home ctrlSetTextColor [1,1,1,1];

	player setVariable ["iPhone_X_lastSMS", []];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ListNumberReceive",
{
	private ["_listNumberClient"];
	_listNumberClient = [_this,0,[],[[]]] call BIS_fnc_param;
	systemChat (format["%1", _this]);
	if (_listNumberClient isEqualTo [[]]) then {_listNumberClient = [];};

	A3PL_iPhoneX_ListNumberClient = _listNumberClient;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Master",
{
	disableSerialization;
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};

	if (A3PL_phoneInCall) then {
		closeDialog 0;
		createDialog "iPhone_X";
	} else {
		if(dialog) exitWith {};
		createDialog "iPhone_X";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_MasterAddPhoneNumber",
{
	disableSerialization;

	if(dialog) exitWith {};

	createDialog "iPhone_X_addPhoneNumber";

	_display = findDisplay 97850;

	_iPhone_X_phoneNumberPrimary = _display displayCtrl 97851;
	_iPhone_X_phoneNumberSecondary = _display displayCtrl 97852;

	if !(isNil "A3PL_phoneNumberPrimary") then {ctrlEnable [97851, false];};
	if !(isNil "A3PL_phoneNumberSecondary") then {ctrlEnable [97852, false];};
	if (isNil "A3PL_phoneNumberPrimary") then {ctrlEnable [97852, false];};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_NewSMS",
{
	private ["_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff","_toFind","_replaceBy","_a"];
	disableSerialization;

	{ctrlDelete _x;} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_toNum = _x select 1;
			_message = _x select 2;

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
					_numberFind = _message find _toFind;
					if (_numberFind isEqualTo -1) exitWith {};
					_splitMessage = _message splitString "";
					_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
					_splitMessage set [_numberFind, _replaceBy];
					_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};

			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t>",_size,_message];
			_type = ["iPhone_X_sendSMS", "iPhone_X_receiveSMS"] select ((_x select 1) == A3PL_phoneNumberActive);
			_tmp = _display ctrlCreate [_type, -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98111);
			_textCtrl = (_tmp controlsGroupCtrl 98112);
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

			_tmp ctrlSetPosition _posGrp;
			_textCtrl ctrlSetPosition _posTxt;
			_backgroundCtrl ctrlSetPosition _posBG;
			_tmp ctrlCommit 0;
			_textCtrl ctrlCommit 0;
			_backgroundCtrl ctrlCommit 0;
			_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_NewSMSEnterprise",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhoneX_ConversationsMS", []]);

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_message = _x select 1;
			_position = _x select 2;
			_a = 0;
       		while {_a < 11} do {
	            _toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
	            _replaceBy = _replaceBy select _a;
	            _numberCharToReplace = count _toFind;
	            _numberFind = _message find _toFind;
            	while {_numberFind != -1} do {
	           		_numberFind = _message find _toFind;
	            	if (_numberFind isEqualTo -1) exitWith {};
		            _splitMessage = _message splitString "";
		            _splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		            _splitMessage set [_numberFind, _replaceBy];
		            _message = _splitMessage joinString "";
	            };
            _a = _a + 1;
        	};
			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t><br></br><t color='#F10000'>From : %3</t><br></br><t color='#F10000'>Position : %4</t>",_size,_message, _fromNum, _position];
			_tmp = _display ctrlCreate ["iPhone_X_SMSEnterprise", -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98058);
			_textCtrl = (_tmp controlsGroupCtrl 98059);
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3'] spawn A3PL_iPhoneX_AppSMS;", _forEachIndex, _fromNum, _fromNum]];
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

		_tmp ctrlSetPosition _posGrp;
		_textCtrl ctrlSetPosition _posTxt;
		_backgroundCtrl ctrlSetPosition _posBG;
		_tmp ctrlCommit 0;
		_textCtrl ctrlCommit 0;
		_backgroundCtrl ctrlCommit 0;
		_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_CurrentConversation", A3PL_phoneNumberEnterprise];
	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_PhoneNumberActive",
{
	private ["_phoneNumberActive"];
	_phoneNumberActive = [_this,0,"",[""]] call BIS_fnc_param;

	if (_phoneNumberActive isEqualTo "") exitWith {diag_log "ERROR - PHONE NUMBER ACTIVE"};

	A3PL_phoneNumberActive = _phoneNumberActive;

	if (!isNull (findDisplay 97000)) then {[] call A3PL_iPhoneX_Home;};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_PhoneNumberEnterprise",
{
	private ["_phoneNumberEnterprise"];
	_phoneNumberEnterprise = [_this,0,"",[""]] call BIS_fnc_param;

	if (_phoneNumberEnterprise isEqualTo "") exitWith {diag_log "ERROR - PHONE NUMBER ENTERPRISE"};

	A3PL_phoneNumberEnterprise = _phoneNumberEnterprise;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_PhoneNumberPrimary",
{
	private ["_phoneNumberPrimary"];
	_phoneNumberPrimary = [_this,0,"",[""]] call BIS_fnc_param;

	if (_phoneNumberPrimary isEqualTo "") exitWith {diag_log "ERROR - PHONE NUMBER PRIMARY"};

	A3PL_phoneNumberPrimary = _phoneNumberPrimary;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_PhoneNumberSecondary",
{
	private ["_phoneNumberSecondary"];
	_phoneNumberSecondary = [_this,0,"",[""]] call BIS_fnc_param;

	if (_phoneNumberSecondary isEqualTo "") exitWith {diag_log "ERROR - PHONE NUMBER SECONDARY"};

	A3PL_phoneNumberSecondary = _phoneNumberSecondary;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveCall",
{
	private["_from","_display","_iPhone_X_phoneNumber","_iPhone_X_unhook_hangup","_exists"];
	disableSerialization;

	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_from = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	_ownerID = owner _unit;

	if !(A3PL_phoneNumberActive isEqualTo _phoneNumberContact) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};

	if !(A3PL_phoneOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};

	if (A3PL_phoneCallOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};
	if (A3PL_phoneInCall) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _ownerID];};

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", []];
	A3PL_phoneInCall = false;

	[player] remoteExec ["Server_iPhoneX_GetListNumber",2];

	waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
	waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};

	A3PL_phoneCallOn = true;
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", _from];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", A3PL_phoneNumberActive];
	player setVariable ["A3PL_iPhoneX_CallSettings", ["2", _from]];

	if ((A3PL_settings select 2) isEqualTo 0) then {
		_soundReceive = "receivecall_sound_%1";
		_soundReceive = format[_soundReceive, (A3PL_settings select 1)];
		_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D [_soundReceive,10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
	};

	if (!isNull (findDisplay 97000)) then {[] call A3PL_iPhoneX_AppCall};

	["Un individu essai de vous joindre sur votre téléphone",Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveCallSwitchboard",
{
	private["_from","_display","_iPhone_X_phoneNumber","_iPhone_X_unhook_hangup","_exists"];
	disableSerialization;

	_index = _this select 0;
	_from = _this select 1;
	_fromNum = _this select 2;
	_phoneNumberContact = _this select 3;

	if !(A3PL_phoneNumberActive isEqualTo _phoneNumberContact) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};

	if !(A3PL_phoneOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};

	if (A3PL_phoneCallOn) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};
	if (A3PL_phoneInCall) exitWith {[] remoteExec ["A3PL_iPhoneX_EndCall", _from];};

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", []];
	A3PL_phoneInCall = false;

	[player] remoteExec ["Server_iPhoneX_GetListNumber",2];

	waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
	waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};

	_exists = [A3PL_switchboard, _fromNum] call BIS_fnc_findNestedElement;

	A3PL_phoneCallOn = true;
	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", _fromNum];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", A3PL_phoneNumberActive];
	player setVariable ["A3PL_iPhoneX_CallSettings", ["2", _fromNum]];

	if (!isNull (findDisplay 97000)) then {[] call A3PL_iPhoneX_appCall};

	if (!(_exists isEqualTo [])) then {
		A3PL_switchboard = ([A3PL_switchboard, (_exists select 0)] call BIS_fnc_removeIndex);
		if ((player getVariable ["job","unemployed"]) IN ["dispatch"]) then {[A3PL_switchboard] remoteExec ["Server_iPhoneX_setSwitchboardSD",2];};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_ReceiveSMS",
{
	private ["_uid","_from","_message","_SMS","_conversations","_nameContact","_exists","_phoneNumberContact","_date","_hour","_minute","_time","_display","_ctrlDisplay","_ctrlGrp"];
	disableSerialization;

	_uid = getPlayerUID player;
	_from = _this select 0;
	_message = _this select 1;
	_to = _this select 2;
	_position = _this select 3;
	_SMS = A3PL_SMS;
	_conversations = A3PL_conversations;

	if(isNil "A3PL_contacts") then {[player] remoteExec ["Server_iPhoneX_GetContacts",2];};


	_nameContact = [A3PL_contacts, _from] call BIS_fnc_findNestedElement;
	if (_nameContact isEqualTo []) then {_nameContact = _from} else {
		_nameContact = [A3PL_contacts, [(_nameContact select 0), 0]] call BIS_fnc_returnNestedElement;
	};

	if ((_to isEqualTo "911") OR (_to isEqualTo "300") OR (_to isEqualTo "350") OR (_to isEqualTo "380") OR (_to isEqualTo "4000") OR (_to isEqualTo "4001") OR (_to isEqualTo "4002") OR (_to isEqualTo "4003") OR (_to isEqualTo "4004") OR (_to isEqualTo "4005") OR (_to isEqualTo "4006") OR (_to isEqualTo "4007") OR (_to isEqualTo "4008") OR (_to isEqualTo "4009") OR (_to isEqualTo "4010")) then
	{
		if (_to isEqualTo A3PL_phoneNumberEnterprise) then
		{
			if (!(_to isEqualTo "911")) then {_position = "inconnue"};
			_SMS pushBack [_from, _message, _position];

			{
			ctrlDelete _x;
			} count (player getVariable ["iPhoneX_ConversationsMS", []]);

			[] call A3PL_iPhoneX_NewSMSEnterprise;

			_date = date;
			_hour = str (_date select 3);
			_minute  = str (_date select 4);
			_time = format["%1h%2", if(count _hour == 1) then {("0" + _hour)} else {_hour}, if(count _minute == 1) then {("0" + _minute)} else {_minute}];

			_nameContact = format ["%1", _nameContact];

			player setVariable ["iPhone_X_lastSMS",[_namecontact, _message, _time, _from]];

			if ((A3PL_settings select 2) isEqualTo 0) then
			{
				if ((_to isEqualTo "911") OR (_to isEqualTo "112" OR (_to isEqualTo "119"))) then
				{
					playSound3D ["A3PL_Common\GUI\phone\sounds\emergency_sound.ogg", player, false, getPosASL player, 20, 1, 5];
					["You receive an SMS on your phone (DISPATCH)",Color_Yellow] call A3PL_Player_Notification;
				} else {
					playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 20, 1, 5];
					["You receive an SMS on your phone (COMPANY)",Color_Yellow] call A3PL_Player_Notification;
				};
			};
		};
	} else {
		_exists = [_conversations, _from] call BIS_fnc_findNestedElement;
		if (_exists isEqualTo []) then
		{
			_conversations pushBack [_nameContact, _from, _message];
			A3PL_conversations = [_conversations,[],{_x select 0},"ASCEND"] call BIS_fnc_sortBy;
			[_uid, _nameContact, _from, _message] remoteExec ["Server_iPhoneX_SaveConversation",2];

			{
			ctrlDelete _x;
			} count (player getVariable ["iPhoneX_PhoneConversations", []]);
		} else {
			[player, _from, _message] remoteExec ["Server_iPhoneX_SaveLastSMS", 2];
		};

		if (_to isEqualTo A3PL_phoneNumberActive) then
		{
			_phoneNumberContact = player getVariable ["iPhoneX_CurrentConversation", ""];

			if (_from isEqualTo _phoneNumberContact) then
			{
				_SMS pushBack [_from, A3PL_phoneNumberActive, _message];

				{
				ctrlDelete _x;
				} count (player getVariable ["iPhoneX_ConversationsMS", []]);

				[] call A3PL_iPhoneX_newSMS;
			};

			_date = date;
			_hour = str (_date select 3);
			_minute  = str (_date select 4);
			_time = format["%1h%2", if(count _hour == 1) then {("0" + _hour)} else {_hour}, if(count _minute == 1) then {("0" + _minute)} else {_minute}];

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
				_numberFind = _message find _toFind;
				if (_numberFind isEqualTo -1) exitWith {};
				_splitMessage = _message splitString "";
				_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
				_splitMessage set [_numberFind, _replaceBy];
				_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};

			player setVariable ["iPhone_X_lastSMS",[_namecontact, _message, _time, _from]];

			if ((A3PL_settings select 2) isEqualTo 0) then {playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 20, 1, 5];};

			["You receive a SMS",Color_Yellow] call A3PL_Player_Notification;
			playSound3D ["A3PL_Common\GUI\phone\sounds\notification_sound.ogg", player, false, getPosASL player, 20, 1, 5];
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SendCall",
{
	private["_phoneNumberContact","_display","_iPhone_X_phoneNumber","_exists"];
	disableSerialization;

	_phoneNumberContact = _this select 0;

	_display = findDisplay 97000;

	_iPhone_X_phoneNumber = _display displayCtrl 97661;
	_iPhone_X_informations = _display displayCtrl 97670;

	_error = false;

	if (_phoneNumberContact in ["Number", ""]) exitWith {hint "Number invalid.";};
	if ((count _phoneNumberContact) > 10) exitWith {hint "Number invalid.";};
	if !(isNil "A3PL_phoneNumberPrimary") then {if (A3PL_phoneNumberPrimary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberSecondary") then {if (A3PL_phoneNumberSecondary isEqualTo _phoneNumberContact) then {_error = true};};
	if !(isNil "A3PL_phoneNumberEnterprise") then {if (A3PL_phoneNumberEnterprise isEqualTo _phoneNumberContact) then {_error = true};};

	if (_error) exitWith {["You can not call this number",Color_Red] call A3PL_Player_Notification; _error = false;};

	systemChat "here1";
	player setVariable ["A3PL_iPhoneX_CallSettings", ["1", _phoneNumberContact]];
	systemChat (format["%1", player getVariable ["A3PL_iPhoneX_CallSettings", []]]);
	[] call A3PL_iPhoneX_AppCall;

	_iPhone_X_phoneNumber ctrlSetText _phoneNumberContact;
	_iPhone_X_informations ctrlSetText "Call in progress...";

	player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", []];
	player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", []];
	player setVariable ["A3PL_iPhoneX_CallSettings", []];
	player setVariable ["A3PL_iPhoneX_SoundCall", []];
	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;

	_error = false;

	if ((_phoneNumberContact isEqualTo "911")) then
	{
		A3PL_phoneCallOn = true;
		player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", A3PL_phoneNumberActive];
		player setVariable ["A3PL_iPhoneX_CallSettings", ["1", _phoneNumberContact, "Call in progress..."]];
		[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["Server_iPhoneX_callSwitchboard",2];
		_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D ["sendcall_sound",10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
		ctrlShow [97667,true];
		ctrlShow [97663,true];
		buttonSetAction [97663, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",[]];if !(_sound isEqualTo []) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 20, 1, 5];[] spawn A3PL_iPhoneX_EndCall;_fd = [""fifr""] call A3PL_Lib_FactionPlayers;_cops = [""dispatch""] call A3PL_Lib_FactionPlayers;{[A3PL_phoneNumberActive] remoteExec [""A3PL_iPhoneX_EndCallSwitchboard"", _x];} foreach _cops;{[A3PL_phoneNumberActive] remoteExec [""A3PL_iPhoneX_EndCallSwitchboard"", _x];} foreach _fd;"];
	} else {
		[player] remoteExec ["Server_iPhoneX_GetListNumber",2];
		systemChat "here2";
		waitUntil {!(isNil "A3PL_iPhoneX_ListNumberClient")};
		waitUntil {!(A3PL_iPhoneX_ListNumberClient isEqualTo [])};
		systemChat "here3";

		_exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement;

		if (!(_exists isEqualTo [])) then {
			A3PL_phoneCallOn = true;
			player setVariable ["A3PL_iPhoneX_PhoneNumberSendCall", A3PL_phoneNumberActive];
			player setVariable ["A3PL_iPhoneX_PhoneNumberReceiveCall", _phoneNumberContact];
			player setVariable ["A3PL_iPhoneX_CallSettings", ["1", _phoneNumberContact, "Call in progress..."]];
			systemChat "here4";
			[player, A3PL_phoneNumberActive, _phoneNumberContact] remoteExec ["A3PL_iPhoneX_ReceiveCall", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)];
			_sound = "Land_HelipadEmpty_F" createVehicle position player; _sound attachTo [player, [0, 0, 0]]; _sound say3D ["sendcall_sound",10,1]; player setVariable ["A3PL_iPhoneX_SoundCall",_sound];
			ctrlShow [97667,true];
			ctrlShow [97663,true];
			buttonSetAction [97663, "_sound = player getVariable [""A3PL_iPhoneX_SoundCall"",""""]; if !(_sound isEqualTo []) then {deleteVehicle _sound;}; playSound3D [""A3PL_Common\GUI\phone\sounds\endcall_sound.ogg"", player, false, getPosASL player, 20, 1, 5]; [] spawn A3PL_iPhoneX_EndCall; _phoneNumberContact = player getVariable [""A3PL_iPhoneX_PhoneNumberReceiveCall"",""""]; _exists = [A3PL_iPhoneX_ListNumberClient, _phoneNumberContact] call BIS_fnc_findNestedElement; if (!(_exists isEqualTo [])) then {[] remoteExec [""A3PL_iPhoneX_EndCall"", ((A3PL_iPhoneX_ListNumberClient select (_exists select 0)) select 1)]};"];
		} else {
			systemChat "not online";
			uiSleep 1; if (!isNull (findDisplay 97000)) then {[] spawn A3PL_iPhoneX_Home;}; player say3D ["endcall_sound",10,1]; A3PL_iPhoneX_ListNumberClient = []; _iPhone_X_phoneNumber ctrlSetText ""; _iPhone_X_informations ctrlSetText "";
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SendSMS",
{
	private ["_message","_SMS","_phoneNumberContact","_display","_ctrlDisplay","_ctrlGrp"];
	disableSerialization;

	_message = _this select 0;

	if (_message isEqualTo "Message...") exitWith {["Invalid message",Color_Red] call A3PL_Player_Notification;};

	_message = _message splitString "'%" joinString " ";
	_message = _message splitString '"' joinString " ";

	_SMS = A3PL_SMS;
	_phoneNumberContact = player getVariable ["iPhoneX_CurrentConversation", ""];

	playSound3D ["A3PL_Common\GUI\phone\sounds\smssend.ogg", player, false, getPosASL player, 20, 1, 5];
	uiSleep random 0.2;

	_SMS pushBack [A3PL_phoneNumberActive, _phoneNumbercontact, _message];
	[player, A3PL_phoneNumberActive, _phoneNumberContact, _message] remoteExec ["Server_iPhoneX_SendSMS", 2];

	{
		ctrlDelete _x;
	} count (player getVariable ["iPhoneX_ConversationsMS", []]);
	[] call A3PL_iPhoneX_NewSMS;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SetSettings",
{
	private ["_settings"];
	_settings = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_settings isEqualTo [[]]) then {_settings = [];};
	A3PL_settings = _settings;

	if (!isNull (findDisplay 97000)) then {[] spawn A3PL_iPhoneX_Home;};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Settings",
{
	private["_display","_background_iPhone_X_base","_background_iPhone_X_background","_background_iPhone_X_shadow_home","_background_iPhone_X_bottom","_iPhone_X_SIM_active","_iPhone_X_nameContact_notifications","_iPhone_X_SMS_notifications","_iPhone_X_time_notifications","_wallpaperActive","_lastSMSFrom","_lastSMS","_lastSMSTime"];
	disableSerialization;

	_display = findDisplay 97000;

	_background_iPhone_X_base = _display displayCtrl 97001;
	_background_iPhone_X_background = _display displayCtrl 97002;
	_background_iPhone_X_shadow_home = _display displayCtrl 97115;
	_background_iPhone_X_bottom = _display displayCtrl 97004;
	_iPhone_X_SIM_active = _display displayCtrl 97800;
	_iPhone_X_nameContact_notifications = _display displayCtrl 97802;
	_iPhone_X_SMS_notifications = _display displayCtrl 97803;
	_iPhone_X_time_notifications = _display displayCtrl 97804;
	_iPhone_X_snowflake_01 = _display displayCtrl 99001;

	_wallpaperActive = "A3PL_Common\GUI\phone\iPhone_X_background_%1.paa";

	_lastSMS = player getVariable ["iPhone_X_lastSMS", []];

	_background_iPhone_X_base ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_base.paa";
	_background_iPhone_X_bottom ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_bottom.paa";

	if (A3PL_phoneOn && A3PL_phoneCallOn) exitWith {[] call A3PL_iPhoneX_AppCall; [] call A3PL_iPhoneX_Clock;};

	if !(A3PL_phoneOn) then {
		_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";
	} else {
		_background_iPhone_X_background ctrlSetText format[_wallpaperActive, (A3PL_settings select 0)];
		_background_iPhone_X_shadow_home ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";
		ctrlShow [97115, true];
		ctrlShow [97501, true];
		ctrlShow [97800, true];
		if !(isNil "A3PL_phoneNumberActive") then {_iPhone_X_SIM_active ctrlSetText format["%1", A3PL_phoneNumberActive];};

		if !(isNil "_lastSMS") then {
			if !(_lastSMS isEqualTo []) then {ctrlShow [97005, false]; ctrlShow [97801, true]; ctrlShow [97805, true]; ctrlShow [97005, true]; _lastSMSFrom = (_lastSMS select 0); _lastSMSFrom = toUpper _lastSMSFrom; _iPhone_X_nameContact_notifications ctrlSetText format["%1", _lastSMSFrom]; _iPhone_X_SMS_notifications ctrlSetText format["%1", (_lastSMS select 1)]; _iPhone_X_time_notifications ctrlSetText format["Received at: %1", (_lastSMS select 2)];};
		};

		[] call A3PL_iPhoneX_Clock;
		_progress1 = safeZoneX + safeZoneW * 0.805468754;
		_progress2 = safeZoneY + safeZoneH * 0.34541667;
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Silent",
{
	private["_display"];
	disableSerialization;

	_display = findDisplay 97000;
	_iphone_X_silent = _display displayCtrl 97717;

	if ((A3PL_settings select 2) isEqualTo 0) then {
		[player, [1]] remoteExec ["Server_iPhoneX_saveSilent",2];
		_iphone_X_silent ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	} else {
		[player, [0]] remoteExec ["Server_iPhoneX_saveSilent",2];
		_iphone_X_silent ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_hud",
{
	private["_display"];
	disableSerialization;

	_display = findDisplay 97000;
	_iphone_X_hud = _display displayCtrl 99719;

	if (profilenamespace getVariable ["A3PL_HUD_Enabled",true]) then {
		profilenamespace setVariable ["A3PL_HUD_Enabled",false];
		_iphone_X_hud ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		profilenamespace setVariable ["A3PL_HUD_Enabled",true];
		_iphone_X_hud ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_twitter",
{
	private["_display"];
	disableSerialization;

	_display = findDisplay 97000;
	_iphone_X_twitter = _display displayCtrl 99718;

	if (profilenamespace getVariable ["A3PL_Twitter_Enabled",true]) then {
		profilenamespace setVariable ["A3PL_Twitter_Enabled",false];
		_iphone_X_twitter ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		profilenamespace setVariable ["A3PL_Twitter_Enabled",true];
		_iphone_X_twitter ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_idplayer",
{
	private["_display"];
	disableSerialization;

	_display = findDisplay 97000;

	_iphone_X_idplayer= _display displayCtrl 99721;
	if (profilenamespace getVariable ["Player_EnableID",true]) then {
		profilenamespace setVariable ["Player_EnableID",false];
		_iphone_X_idplayer ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		profilenamespace setVariable ["Player_EnableID",true];
		_iphone_X_idplayer ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_notification",
{
	private["_display"];
	disableSerialization;

	_display = findDisplay 97000;

	_iphone_X_notification = _display displayCtrl 99722;

	if (profilenamespace getVariable ["A3PL_HINT_Enabled",true]) then {
		profilenamespace setVariable ["A3PL_HINT_Enabled",false];
		_iphone_X_notification ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentOFF.paa";
	} else {
		profilenamespace setVariable ["A3PL_HINT_Enabled",true];
		_iphone_X_notification ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_icon_silentON.paa";
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SMS",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_phoneNumberContact = [_this,0,"",[""]] call BIS_fnc_param;
	_result = [_this,1,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_SMS = _result;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_toNum = _x select 1;
			_message = _x select 2;

			_a = 0;
			while {_a < 11} do {
				_toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
				_replaceBy = _replaceBy select _a;
				_numberCharToReplace = count _toFind;
				_numberFind = _message find _toFind;
				while {_numberFind != -1} do {
				_numberFind = _message find _toFind;
				if (_numberFind isEqualTo -1) exitWith {};
				_splitMessage = _message splitString "";
				_splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
				_splitMessage set [_numberFind, _replaceBy];
				_message = _splitMessage joinString "";
				};
				_a = _a + 1;
			};

			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t>",_size,_message];
			_type = ["iPhone_X_sendSMS", "iPhone_X_receiveSMS"] select ((_x select 1) == A3PL_phoneNumberActive);
			if((_x select 1) == A3PL_phoneNumberActive) then {
				_type = "iPhone_X_receiveSMS";
			} else {
				_type = "iPhone_X_sendSMS";
			};
			_tmp = _display ctrlCreate [_type, -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98111);
			_textCtrl = (_tmp controlsGroupCtrl 98112);
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

		_tmp ctrlSetPosition _posGrp;
		_textCtrl ctrlSetPosition _posTxt;
		_backgroundCtrl ctrlSetPosition _posBG;
		_tmp ctrlCommit 0;
		_textCtrl ctrlCommit 0;
		_backgroundCtrl ctrlCommit 0;
		_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_CurrentConversation", _phoneNumberContact];
	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SMSEnterprise",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_SMS = _result;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 97510);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 97511);
	_ctrlList = [];

	if (!(A3PL_SMS isEqualTo [])) then {
		{
			_fromNum = _x select 0;
			_message = _x select 1;
			_position = _x select 2;
			_a = 0;
       		while {_a < 11} do {
	            _toFind = [";)","<3",":)",":fuck",":hi",":o",":dac",":p",":@",":-(",":("];
	            _toFind = _toFind select _a;
	            _replaceBy = ["<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_cleinoeil.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_coeur.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_content.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_fuck.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_hi.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_o.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_ok.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_p.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pascontent.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_pleure.paa'/>","<img size='1' color='#FFFFFF' image='A3PL_Common\GUI\phone\smileys\iPhone_X_icon_triste.paa'/>"];
	            _replaceBy = _replaceBy select _a;
	            _numberCharToReplace = count _toFind;
	            _numberFind = _message find _toFind;
            	while {_numberFind != -1} do {
	           		_numberFind = _message find _toFind;
	            	if (_numberFind isEqualTo -1) exitWith {};
		            _splitMessage = _message splitString "";
		            _splitMessage deleteRange [(_numberFind +1), _numberCharToReplace -1];
		            _splitMessage set [_numberFind, _replaceBy];
		            _message = _splitMessage joinString "";
	            };
            _a = _a + 1;
        	};
			_size = 0.5 * safezoneH;
			_message = format["<t size='%1' color='#000000'>%2</t><br></br><t color='#F10000'>From : %3</t><br></br><t color='#F10000'>Position : %4</t>",_size,_message, _fromNum, _position];
			_tmp = _display ctrlCreate ["iPhone_X_SMSEnterprise", -1, _ctrlGrp];
			_backgroundCtrl = (_tmp controlsGroupCtrl 98058);
			_textCtrl = (_tmp controlsGroupCtrl 98059);
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3'] spawn A3PL_iPhoneX_AppSMS;", _forEachIndex, _fromNum, _fromNum]];
			_textCtrl ctrlSetStructuredText parseText _message;
			_posGrp = ctrlPosition _tmp;
			_posBG = ctrlPosition _backgroundCtrl;
			_posTxt = ctrlPosition _textCtrl;
			_textHeight = ctrlTextHeight _textCtrl;

			if (!(_ctrlList isEqualTo [])) then {
				_tmpPos = ctrlPosition (_ctrlList select ((count _ctrlList) - 1));
				_posGrp set [1, ((_tmpPos select 1) + (_tmpPos select 3) + 0.001)];
			} else {
				_posGrp set [1, (_posGrp select 1) + 0.005];
			};

			if (_textHeight > (_posBG select 3)) then {
				_diff = (_textHeight - (_posBG select 3));
				_posGrp set [3, ((_posGrp select 3) + _diff)];
				_posBG set [3, ((_posBG select 3) + _diff)];
				_posTxt set [3, ((_posTxt select 3) + (_diff))];
				_posTxt set [1, (((_posBG select 3) / 2) - ((_posTxt select 3) / 2))];
			};

		_tmp ctrlSetPosition _posGrp;
		_textCtrl ctrlSetPosition _posTxt;
		_backgroundCtrl ctrlSetPosition _posBG;
		_tmp ctrlCommit 0;
		_textCtrl ctrlCommit 0;
		_backgroundCtrl ctrlCommit 0;
		_ctrlList pushBack _tmp;
		} forEach A3PL_SMS;
	};

	player setVariable ["iPhoneX_CurrentConversation", A3PL_phoneNumberEnterprise];
	player setVariable ["iPhoneX_ConversationsMS", _ctrlList];

	_ctrlGrp ctrlSetAutoScrollSpeed 0.000001;
	_ctrlGrp ctrlSetAutoScrollDelay 0.000001;
	uiSleep 0.2;
	_ctrlGrp ctrlSetAutoScrollSpeed -1;
	ctrlSetFocus _ctrlGrp;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Start",
{
	private["_display","_background_iPhone_X_base","_background_iPhone_X_background","_background_iPhone_X_shadow","_progressTime","_startTime","_endTime","_progress","_background_iPhone_X_bottom","_renderSurface","_cam","_iPhone_X_text_faceID","_goggles"];
	disableSerialization;

	ctrlShow [97005, false];
	noesckey = (findDisplay 97000) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

	_display = findDisplay 97000;

	_background_iPhone_X_base = _display displayCtrl 97001;
	_background_iPhone_X_background = _display displayCtrl 97002;
	_background_iPhone_X_shadow = _display displayCtrl 97114;

	_background_iPhone_X_base ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_base.paa";
	_background_iPhone_X_background ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_ON.paa";
	_background_iPhone_X_shadow ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_background_OFF.paa";

	ctrlShow [97114, true];

	_progressTime = 3;
	_startTime = time;
	_endTime = _startTime + _progressTime;

	playSound3D ["A3PL_Common\GUI\phone\sounds\startup_iphone.ogg", player, false, getPosASL player, 20, 1, 5];

	while {time <= _endTime} do {
		_progress = linearConversion[_startTime, _endTime, time, 1, 0];
		_background_iPhone_X_shadow ctrlSetTextColor [0,0,0,_progress];
		_background_iPhone_X_shadow ctrlCommit 0;
	};

	ctrlShow [97114, false];

	_background_iPhone_X_shadow ctrlSetTextColor [0,0,0,1];
	_background_iPhone_X_shadow ctrlCommit 0;

	_background_iPhone_X_bottom = _display displayCtrl 97004;
	_background_iPhone_X_bottom ctrlSetText "A3PL_Common\GUI\phone\iPhone_X_bottom.paa";

	ctrlShow [97004, true];
	ctrlShow [97116, true];

	_renderSurface = _display displayCtrl 97216;
	_renderSurface ctrlSetText "#(argb,512,512,1)r2t(faceID,1)";
	_cam = "camera" camCreate (getPos player);
	_cam cameraEffect ["Internal", "Back", "faceID"];
	_cam camSetTarget player;
	_cam attachTo [player, [0.1, 0.75, 1.5] ];
	_cam camSetFov 0.325;
	_cam camCommit 0;

	_iPhone_X_text_faceID = _display displayCtrl 97217;

	_progressTime = 2;
	_startTime = time;
	_endTime = _startTime + _progressTime;

	while {time <= _endTime} do {
		_size = 0.6 * safezoneH;
		_iPhone_X_text_faceID ctrlSetStructuredText parseText format["<t size='%1' color='#FFFFFF' align='center'>FaceID</t>",_size];
		sleep 0.5;
		_iPhone_X_text_faceID ctrlSetStructuredText parseText format["<t size='%1' color='#FFFFFF' align='center'>.FaceID.</t>",_size];
		sleep 0.5;
		_iPhone_X_text_faceID ctrlSetStructuredText parseText format["<t size='%1' color='#FFFFFF' align='center'>..FaceID..</t>",_size];
		sleep 0.5;
		_iPhone_X_text_faceID ctrlSetStructuredText parseText format["<t size='%1' color='#FFFFFF' align='center'>...FaceID...</t>",_size];
		sleep 0.5;
	};

	_size = 0.6 * safezoneH;
	_iPhone_X_text_faceID ctrlSetStructuredText parseText format["<t size='%1' color='#FFFFFF' align='center'>- %2 -</t>",_size, name player];

	uiSleep 1;
	camDestroy _cam;
	ctrlShow [97004, false];
	ctrlShow [97116, false];
	ctrlShow [97005, true];
	(findDisplay 97000) displayRemoveEventHandler ["KeyDown", noesckey];

	[] spawn A3PL_iPhoneX_Settings;

	A3PL_phoneOn = true;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_Switchboard",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_switchboard = _result;

	_display = findDisplay 97000;
	_ctrlDisplay = (_display displayCtrl 98260);
	_ctrlGrp = (_ctrlDisplay controlsGroupCtrl 98261);
	_ctrlList = [];

	{ctrlDelete _x;} count (player getVariable ["A3PL_iPhoneX_SwitchboardClient", []]);

	if (!(A3PL_switchboard isEqualTo [])) then {
		{
			_from = _x select 0;
			_fromNum = _x select 1;
			_tmp = _display ctrlCreate ["iPhone_X_switchboard", -1, _ctrlGrp];
			_ctrlList pushBack _tmp;
			_pos = ctrlPosition _tmp;
			_pos set [1, (_pos select 1) + (_pos select 3) * _forEachIndex];
			(_tmp controlsGroupCtrl 98056) ctrlSetText _fromNum;
			_tmp ctrlAddEventHandler ["MouseButtonDown",format ["[%1, '%2', '%3', '%4'] spawn A3PL_iPhoneX_receiveCallSwitchboard;", _forEachIndex, _from, _fromNum, A3PL_phoneNumberActive]];
			_tmp ctrlSetPosition _pos;
			_tmp ctrlCommit 0;
		} forEach A3PL_switchboard;
	};
	player setVariable ["A3PL_iPhoneX_SwitchboardClient", _ctrlList];
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SwitchboardReceive",
{
	private ["_uid","_from","_message","_SMS","_conversations","_nameContact","_exists","_phoneNumberContact","_date","_hour","_minute","_time","_display","_ctrlDisplay","_ctrlGrp"];
	disableSerialization;

	_from = _this select 0;
	_to = _this select 1;

	_nameContact = [A3PL_contacts, _from] call BIS_fnc_findNestedElement;
	if (_nameContact isEqualTo []) then {_nameContact = _from} else {
		_nameContact = [A3PL_contacts, [(_nameContact select 0), 0]] call BIS_fnc_returnNestedElement;
	};

	if ((_to isEqualTo "911")) then
	{
		if(!isNil "A3PL_phoneNumberEnterprise") then {
			if ((_to isEqualTo A3PL_phoneNumberEnterprise) && ((A3PL_settings select 2) isEqualTo 0)) then
			{
				["An individual trying to join your institution",Color_Yellow] call A3PL_Player_Notification;
				playSound3D ["A3PL_Common\GUI\phone\sounds\emergency_sound.ogg", player, false, getPosASL player, 20, 1, 5];
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_iPhoneX_SwitchboardSend",
{
	private ["_phoneNumberContact","_result","_display","_ctrlDisplay","_ctrlGrp","_ctrlList","_fromNum","_toNum","_message","_type","_tmp","_textCtrl","_backgroundCtrl","_posGrp","_posTxt","_textHeight","_posBG","_tmpPos","_diff"];
	disableSerialization;
	_result = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_result isEqualTo [[]]) then {_result = [];};
	A3PL_switchboard = _result;
}] call Server_Setup_Compile;

["A3PL_iPhoneX_DeleteContact",
{
	private _number = ctrlText 97610;
	[player,_number] remoteExec ["Server_iPhoneX_DeleteContact",2];
	[] spawn {
		uiSleep 0.5;
		[] call A3PL_iPhoneX_AppContactsList;
	};
}] call Server_Setup_Compile;