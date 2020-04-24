/*
	iPhoneX by Neyzhak
*/
['Server_iPhoneX_AddPhoneNumber', 
{
	private ["_unit","_phoneNumber","_type","_serialNumber","_query","_result"];
	_unit = [_this,0,"",[""]] call BIS_fnc_param;
	_phoneNumber = [_this,1,"",[""]] call BIS_fnc_param;
	_type = [_this,2,"",[""]] call BIS_fnc_param;

	if (_unit isEqualTo "" || _phoneNumber isEqualTo "" || _type isEqualTo "") exitWith {};

	_serialNumber = [];
	while {(count _serialNumber < 15)} do {
		_serialNumber = [];
		for "_i" from 0 to 14 do {
			_serialNumber pushBack (selectRandom ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",0,1,2,3,4,5,6,7,8,9]);
		};
	};
	_serialNumber = _serialNumber joinString "";
	_query = format ["INSERT INTO iphone_phone_numbers (player_id, phone_number, type_id, serial_number) VALUES ('%1', '%2', '%3', '%4')", _unit, _phoneNumber, _type, _serialNumber];
	_result = [_query,1] call Server_Database_Async;
}] call Server_Setup_Compile;

['Server_iPhoneX_CallSwitchboard', 
{
	private ["_unit","_phoneNumberActive","_ownerID","_playerUID","_queryDelete","_queryAdd","_resultAdd"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	if (_phoneNumberContact isEqualTo "911") then {
		A3PL_iPhoneX_switchboardSD pushBack [_ownerID, _phoneNumberActive];
		[_phoneNumberActive, _phoneNumberContact] remoteExec ["A3PL_iPhoneX_switchboardReceive"];
		[A3PL_iPhoneX_switchboardSD] remoteExec ["A3PL_iPhoneX_switchboardSend", _ownerID];
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_CheckPhoneNumberIsUsed', 
{
	private ["_unit", "_phoneNumber","_type","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumber = [_this,1,"",[""]] call BIS_fnc_param;
	_type = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumber isEqualTo "" || _type isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE phone_number='%1'", _phoneNumber];
	_result = [_query,2] call Server_Database_Async;

	[_result] remoteExec ["A3PL_iPhoneX_getPhoneNumberIsUsed", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_CheckPhoneNumberSubscription', 
{
	private ["_unit","_type","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_type = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _type isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='%2'", _playerUID, _type];
	_result = [_query,2] call Server_Database_Async;

	[_result] remoteExec ["A3PL_iPhoneX_getPhoneNumberSubscription", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_DeleteContact', 
{
	private ["_unit","_phoneNumberContact","_playerUID","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "") exitWith {};
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["DELETE FROM iphone_contacts WHERE player_id='%1' AND phone_number_contact='%2'", _playerUID, _phoneNumberContact];
	[_query,1] call Server_Database_Async;


	[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetContacts', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	//FISD
	_nameContactSD = "911 Emergency";
	_phoneNumberContactSD = "911";
	_noteContactSD = "Emergency";

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT name_contact, phone_number_contact, note_contact FROM iphone_contacts WHERE player_id='%1' ORDER BY name_contact", _playerUID];
	_result = [_query,2,true] call Server_Database_Async;

	if (_result isEqualTo []) then
	{
		_query = format ["INSERT INTO iphone_contacts (player_id, name_contact, phone_number_contact, note_contact) VALUES ('%1', '%2', '%3', '""%4""')", _playerUID, _nameContactSD, _phoneNumberContactSD, _noteContactSD];
		[_query,1] call Server_Database_Async;
		sleep 2;
		[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
	} else {
		[_result] remoteExec ["A3PL_iPhoneX_Contacts", _ownerID];
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_GetConversations', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_nameContactSD = "911 Emergency";
	_phoneNumberContactSD = "911";
	_message = "No message";

	_query = format ["SELECT name_contact, phone_number_contact, last_sms FROM iphone_conversations WHERE player_id='%1' ORDER BY name_contact", _playerUID];
	_result = [_query,2,true] call Server_Database_Async;

	if (_result isEqualTo []) then
	{
		_query2 = format ["INSERT INTO iphone_conversations (player_id, name_contact, phone_number_contact, last_sms) VALUES ('%1','%2','%3','""%4""')", _playerUID, _nameContactSD, _phoneNumberContactSD, _message];
		[_query2,1] call Server_Database_Async;

		sleep 2;

		[_unit] remoteExec ["Server_iPhoneX_GetConversations",2];
	} else {
		[_result] remoteExec ["A3PL_iPhoneX_Conversations", _ownerID];
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_GetEvents', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = "SELECT name_owner_ev, name_ev, description_ev, price_ev, position_ev, phone_number_ev, date_start_ev, time_start_ev FROM event ORDER BY creation_date ASC";
	_result = [_query,2,true] call Server_Database_Async;

	diag_log "------------- EVENTS -------------";
	diag_log format ["Events for player : %1", _playerUID];
	diag_log format ["Query : %1", _query];
	diag_log format ["Result : %1", _result];
	diag_log "-----------------------------------------";

	[_result] remoteExec ["A3PL_iPhoneX_events", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetListNumber', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	[A3PL_iPhoneX_ListNumber] remoteExec ["A3PL_iPhoneX_ListNumberReceive", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetPhoneNumber', 
{
	private ["_unit","_ownerID","_playerUID","_queryPrimary","_resultPrimary","_querySecondary","_resultSecondary","_queryEnterprise","_resultEnterprise","_queryActive","_resultActive","_inList"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_queryPrimary = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='1'", _playerUID];
	_resultPrimary = [_queryPrimary,2] call Server_Database_Async;

	if !(_resultPrimary isEqualTo []) then
	{
		if (_resultPrimary isEqualType []) then {_resultPrimary = _resultPrimary select 0;};
		_resultPrimary remoteExec ["A3PL_iPhoneX_phoneNumberPrimary", _ownerID];
	};

	_querySecondary = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='2'", _playerUID];
	_resultSecondary = [_querySecondary,2] call Server_Database_Async;

	if !(_resultSecondary isEqualTo []) then
	{
		if (_resultSecondary isEqualType []) then {_resultSecondary = _resultSecondary select 0;};
		_resultSecondary remoteExec ["A3PL_iPhoneX_phoneNumberSecondary", _ownerID];
	};

	_queryEnterprise = format ["SELECT phone_number FROM iphone_phone_numbers WHERE player_id='%1' AND type_id='3'", _playerUID];
	_resultEnterprise = [_queryEnterprise,2] call Server_Database_Async;

	if !(_resultEnterprise isEqualTo []) then
	{
		if (_resultEnterprise isEqualType []) then {_resultEnterprise = _resultEnterprise select 0;};
		[_resultEnterprise] remoteExec ["A3PL_iPhoneX_phoneNumberEnterprise", _ownerID];
		if (_resultEnterprise isEqualTo "911") then {[A3PL_iPhoneX_switchboardSD] remoteExec ["A3PL_iPhoneX_switchboardSend",2]};
	};

	_queryActive = format ["SELECT phone_number_active FROM iphone_phone_numbers_active WHERE player_id='%1'", _playerUID];
	_resultActive = [_queryActive,2] call Server_Database_Async;

	if !(_resultActive isEqualTo []) then
	{
		if (_resultActive isEqualType []) then {_resultActive = _resultActive select 0;};
		_resultActive remoteExec ["A3PL_iPhoneX_phoneNumberActive", _ownerID];
	} else {
		if !(_resultPrimary isEqualTo []) then
		{
			[_unit, _resultPrimary] remoteExec ["Server_iPhoneX_savePhoneNumberActive", 2];
		};
	};

	[_unit] remoteExec ["Server_iPhoneX_GetContacts",2];
	[_unit] remoteExec ["Server_iPhoneX_GetConversations",2];


	if !(_resultPrimary isEqualTo []) then
	{
		if(!isNil"A3PL_iPhoneX_ListNumber") then {A3PL_iPhoneX_ListNumber = []};
		_inList = ([A3PL_iPhoneX_ListNumber, _resultPrimary] call BIS_fnc_findNestedElement);
		if (_inList isEqualTo []) then {
			A3PL_iPhoneX_ListNumber pushBack [_resultPrimary, _ownerID];
		} else {
			A3PL_iPhoneX_ListNumber set [(_inList select 0), [_resultPrimary, _ownerID]];
		};
	};

	if !(_resultSecondary isEqualTo []) then
	{
		if(!isNil"A3PL_iPhoneX_ListNumber") then {A3PL_iPhoneX_ListNumber = []};
		_inList = ([A3PL_iPhoneX_ListNumber, _resultSecondary] call BIS_fnc_findNestedElement);
		if (_inList isEqualTo []) then {
			A3PL_iPhoneX_ListNumber pushBack [_resultSecondary, _ownerID];
		} else {
			A3PL_iPhoneX_ListNumber set [(_inList select 0), [_resultSecondary, _ownerID]];
		};
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_GetPhoneNumberActive', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT phone_number_active FROM iphone_phone_numbers_active WHERE player_id='%1'", _playerUID];
	_result = [_query,2] call Server_Database_Async;

	if !(_result isEqualTo []) then
	{
		if (_result isEqualType []) then {_result = _result select 0;};
		_result remoteExec ["A3PL_iPhoneX_phoneNumberActive", _ownerID];
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_GetSettings', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT wallpaper_id, sound_id, silent_id FROM iphone_settings WHERE player_id='%1'", _playerUID];
	_result = [_query,2] call Server_Database_Async;

	if (_result isEqualTo []) then
	{
		_query2 = format ["INSERT INTO iphone_settings (player_id) VALUES ('%1')", _playerUID];
		[_query2,1] call Server_Database_Async;
		[[2,1,0]] remoteExec ["A3PL_iPhoneX_SetSettings", _ownerID];
	} else {
		[_result] remoteExec ["A3PL_iPhoneX_SetSettings", _ownerID];
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_GetSMS', 
{
	private ["_unit","_phoneNumberActive","_phoneNumberContact","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT from_num, to_num, message FROM iphone_messages WHERE (from_num='%1' AND to_num='%2') OR (from_num='%2' AND to_num='%1') ORDER BY date", _phoneNumberActive, _phoneNumberContact];
	_result = [_query,2,true] call Server_Database_Async;

	[_phoneNumberContact, _result] remoteExec ["A3PL_iPhoneX_SMS", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetSMSEnterprise', 
{
	private ["_unit","_phoneNumberActive","_phoneNumberContact","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["SELECT from_num, message, position FROM iphone_messages WHERE to_num='%1' ORDER BY date", _phoneNumberContact];
	_result = [_query,2,true] call Server_Database_Async;

	[_result] remoteExec ["A3PL_iPhoneX_SMSEnterprise", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetSwitchboardFD', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	[A3PL_iPhoneX_switchboardFD] remoteExec ["A3PL_iPhoneX_switchboard", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_GetSwitchboardSD', 
{
	private ["_unit","_ownerID","_playerUID","_query","_result"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;

	if (isNil "_unit") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	[A3PL_iPhoneX_switchboardSD] remoteExec ["A3PL_iPhoneX_switchboard", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveContact', 
{
	private ["_uid","_ownerPhoneNumber","_nameContact","_phoneNumberContact","_query"];
	_uid  = [_this,0,"",[""]] call BIS_fnc_param;
	_nameContact = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;
	_noteContact = [_this,3,"",[""]] call BIS_fnc_param;

	if (_uid isEqualTo "" || _nameContact isEqualTo "" || _phoneNumberContact isEqualTo "") exitWith {};

	_query = format ["INSERT INTO iphone_contacts (player_id, name_contact, phone_number_contact, note_contact) VALUES ('%1', '%2', '%3', '""%4""')", _uid, _nameContact, _phoneNumberContact, _noteContact];
	[_query,1] call Server_Database_Async;
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveConversation', 
{
	private ["_uid","_nameContact","_phoneNumberContact","_query"];
	_uid  = [_this,0,"",[""]] call BIS_fnc_param;
	_nameContact = [_this,1,"",[""]] call BIS_fnc_param;
	_phoneNumberContact = [_this,2,"",[""]] call BIS_fnc_param;
	_message = [_this,3,"",[""]] call BIS_fnc_param;

	if (_uid isEqualTo "" || _nameContact isEqualTo "" || _phoneNumberContact isEqualTo "" || _message isEqualTo "") exitWith {};

	_query = format ["INSERT INTO iphone_conversations (player_id, name_contact, phone_number_contact, last_sms) VALUES ('%1','%2','%3','""%4""')", _uid, _nameContact, _phoneNumberContact, _message];
	[_query,1] call Server_Database_Async;
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveEvent', 
{
	private ["_uid","_ownerPhoneNumber","_nameContact","_phoneNumberContact","_query"];
	_uid  = [_this,0,"",[""]] call BIS_fnc_param;
	_nameOwner = [_this,1,"",[""]] call BIS_fnc_param;
	_nameEvent = [_this,2,"",[""]] call BIS_fnc_param;
	_description = [_this,3,"",[""]] call BIS_fnc_param;
	_price = [_this,4,"",[""]] call BIS_fnc_param;
	_position = [_this,5,"",[""]] call BIS_fnc_param;
	_phoneNumber = [_this,6,"",[""]] call BIS_fnc_param;
	_date = [_this,7,"",[""]] call BIS_fnc_param;
	_time = [_this,8,"",[""]] call BIS_fnc_param;

	if (_uid isEqualTo "" || _nameOwner isEqualTo "" || _nameEvent isEqualTo "" || _description isEqualTo "" || _price isEqualTo "" || _position isEqualTo "" || _phoneNumber isEqualTo "" || _date isEqualTo "" || _time isEqualTo "") exitWith {};

	_query = format ["INSERT INTO event (player_id, name_owner_ev, name_ev, description_ev, price_ev, position_ev, phone_number_ev, date_start_ev, time_start_ev) VALUES ('%1', '%2', '%3', '%4', '%5', '%6', '%7', '%8', '%9')", _uid, _nameOwner, _nameEvent, _description, _price, _position, _phoneNumber, _date, _time];
	[_query,1] call Server_Database_Async;
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveLastSMS', 
{
	private ["_uid","_nameContact","_phoneNumberContact","_message","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberContact = [_this,1,"",[""]] call BIS_fnc_param;
	_message = [_this,2,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberContact isEqualTo "" || _message isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["UPDATE iphone_conversations SET last_SMS='""%1""' WHERE phone_number_contact='%2' AND player_id='%3'", _message, _phoneNumberContact, _playerUID];
	[_query,1] call Server_Database_Async;

	[_unit] remoteExec ["A3PL_iPhoneX_getConversations",2];
}] call Server_Setup_Compile;

['Server_iPhoneX_SavePhoneNumberActive', 
{
	private ["_unit","_phoneNumberActive","_ownerID","_playerUID","_queryDelete","_queryAdd","_resultAdd"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["INSERT INTO iphone_phone_numbers_active (player_id, phone_number_active) VALUES ('%1', '%2')", _playerUID, _phoneNumberActive];
	_result = [_query,1] call Server_Database_Async;

	_phoneNumberActive remoteExec ["A3PL_iPhoneX_phoneNumberActive", _ownerID];
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveSilent', 
{
	private ["_unit","_sound","_ownerID","_playerUID","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_silent = [_this,1,[],[[]]] call BIS_fnc_param;

	if (isNil "_unit" || _silent isEqualTo []) exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	if (_silent isEqualType []) then {_silent = _silent select 0;};

	_query = format ["UPDATE iphone_settings SET player_id = '%1', silent_id = '%2' WHERE player_id='%1'", _playerUID, _silent];
	[_query,1] call Server_Database_Async;

	[_unit] remoteExec ["Server_iPhoneX_getSettings",2];
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveSound', 
{
	private ["_unit","_sound","_ownerID","_playerUID","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_sound = [_this,1,[],[[]]] call BIS_fnc_param;

	if (isNil "_unit" || _sound isEqualTo []) exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	if (_sound isEqualType []) then {_sound = _sound select 0;};

	_query = format ["UPDATE iphone_settings SET player_id = '%1', sound_id = '%2' WHERE player_id='%1'", _playerUID, _sound];
	[_query,1] call Server_Database_Async;

	[_unit] remoteExec ["Server_iPhoneX_getSettings",2];
}] call Server_Setup_Compile;

['Server_iPhoneX_SaveWallpaper', 
{
	private ["_unit","_wallpaper","_ownerID","_playerUID","_query"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_wallpaper = [_this,1,[],[[]]] call BIS_fnc_param;

	if (isNil "_unit" || _wallpaper isEqualTo []) exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	if (_wallpaper isEqualType []) then {_wallpaper = _wallpaper select 0;};

	_query = format ["UPDATE iphone_settings SET player_id = '%1', wallpaper_id = '%2' WHERE player_id='%1'", _playerUID, _wallpaper];
	[_query,1] call Server_Database_Async;

	[_unit] remoteExec ["Server_iPhoneX_getSettings",2];
}] call Server_Setup_Compile;

['Server_iPhoneX_SendSMS', 
{
	private ["_unit","_from","_to","_message","_query","_exists"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_from  = [_this,1,"",[""]] call BIS_fnc_param;
	_to = [_this,2,"",[""]] call BIS_fnc_param;
	_message = [_this,3,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _from isEqualTo "" || _to isEqualTo "" || _message isEqualTo "") exitWith {};

	_position = mapGridPosition _unit;
	_query = format ["INSERT INTO iphone_messages (from_num, to_num, message, position) VALUES ('%1', '%2', '""%3""', '%4')", _from, _to, _message, _position];
	[_query,1] call Server_Database_Async;

	if ((_to isEqualTo "911") OR (_to isEqualTo "300") OR (_to isEqualTo "350") OR (_to isEqualTo "380") OR (_to isEqualTo "4000") OR (_to isEqualTo "4001") OR (_to isEqualTo "4002") OR (_to isEqualTo "4003") OR (_to isEqualTo "4004") OR (_to isEqualTo "4005") OR (_to isEqualTo "4006") OR (_to isEqualTo "4007") OR (_to isEqualTo "4008") OR (_to isEqualTo "4009") OR (_to isEqualTo "4010")) then
	{
		if (_to isEqualTo "911") then {
			_cops = ["police"] call A3PL_Lib_FactionPlayers;
			{[_from, _message, _to, _position] remoteExec ["A3PL_iPhoneX_receiveSMS", _x];} foreach _cops;
		};
		if ((_to isEqualTo "300") OR (_to isEqualTo "350") OR (_to isEqualTo "380") OR (_to isEqualTo "4000") OR (_to isEqualTo "4001") OR (_to isEqualTo "4002") OR (_to isEqualTo "4003") OR (_to isEqualTo "4004") OR (_to isEqualTo "4005") OR (_to isEqualTo "4006") OR (_to isEqualTo "4007") OR (_to isEqualTo "4008") OR (_to isEqualTo "4009") OR (_to isEqualTo "4010")) then {
			[_from, _message, _to, _position] remoteExec ["A3PL_iPhoneX_receiveSMS", civilian];
		};
	} else {
		_exists = [A3PL_iPhoneX_ListNumber, _to] call BIS_fnc_findNestedElement;

		if (!(_exists isEqualTo [])) then {
			[_from, _message, _to, _position] remoteExec ["A3PL_iPhoneX_receiveSMS", ((A3PL_iPhoneX_ListNumber select (_exists select 0)) select 1)];
		};
	};
}] call Server_Setup_Compile;

['Server_iPhoneX_SetSwitchboardFD', 
{
	private ["_switchboardFD","_fd"];
	_switchboardFD = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_switchboardFD isEqualTo "") exitWith {};

	A3PL_iPhoneX_switchboardFD = _switchboardFD;

	_fd = ["fifr"] call A3PL_Lib_FactionPlayers;
	{
		[A3PL_iPhoneX_switchboardFD] remoteExec ["A3PL_iPhoneX_switchboard", _x];
	} foreach _fd;
}] call Server_Setup_Compile;

['Server_iPhoneX_SetSwitchboardSD', 
{
	private ["_unit","_cops"];
	_switchboardSD = [_this,0,[],[[]]] call BIS_fnc_param;

	if (_switchboardSD isEqualTo "") exitWith {};

	A3PL_iPhoneX_switchboardSD = _switchboardSD;
	_cops = ["police"] call A3PL_Lib_FactionPlayers;
	{
		[A3PL_iPhoneX_switchboardSD] remoteExec ["A3PL_iPhoneX_switchboard", _x];
	} foreach _cops;
}] call Server_Setup_Compile;

['Server_iPhoneX_UpdatePhoneNumberActive', 
{
	private ["_unit","_phoneNumberActive","_ownerID","_playerUID","_queryDelete","_queryAdd","_resultAdd"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_phoneNumberActive = [_this,1,"",[""]] call BIS_fnc_param;

	if (isNil "_unit" || _phoneNumberActive isEqualTo "") exitWith {};
	_ownerID = owner _unit;
	_playerUID = getPlayerUID _unit;
	if (_playerUID == "") exitWith {};

	_query = format ["UPDATE iphone_phone_numbers_active SET phone_number_active='%2' WHERE player_id='%1'", _playerUID, _phoneNumberActive];
	_result = [_query,1] call Server_Database_Async;

	_phoneNumberActive remoteExec ["A3PL_iPhoneX_phoneNumberActive", _ownerID];
}] call Server_Setup_Compile;