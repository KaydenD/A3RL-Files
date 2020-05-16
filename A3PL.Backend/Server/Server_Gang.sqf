["Server_Gang_Create", {
	params [["_owner",objNull,[objNull]],["_gangName","",[""]]];
	_uid = getPlayerUID _owner;
	_group = group _owner;
	_query = format ["SELECT id FROM gangs WHERE name='%1'",_gangName];
	_queryResult = [_query,2] call Server_Database_Async;

	if (!(count _queryResult isEqualTo 0)) exitWith {[format["The gang '%1' already exists!",_gangName], "#FD1703"] remoteExec ["A3PL_Player_Notification",_owner];};

	_gangMembers = [_uid];
	_query = format ["INSERT INTO gangs(owner, name, members) VALUES('%1','%2','%3')",_uid,_gangName,_gangMembers];
	[_query,1] call Server_Database_Async;

	uiSleep 0.05;

	_gang = [];
	_req = format["SELECT id, owner, name, members, bank, maxmembers, flag FROM gangs WHERE members LIKE '%2%1%2'",_uid,'%'];
	while {_gang isEqualTo []} do {
		_gang = [_req, 2] call Server_Database_Async;
	};
	_gang = [_gang select 0, _gang select 1, _gang select 2, [_gang select 3] call Server_Database_ToArray, _gang select 4, _gang select 5, _gang select 6];
	_group setVariable["gang_data",_gang,true];
	[_group] remoteExecCall ["A3RL_Gang_Created",_owner];
}, true] call Server_Setup_Compile;

["Server_Gang_DeleteGang", {
	_group = param [0,grpNull];
	_gang = _group getVariable["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_groupID = _gang select 0;
	_group setVariable["gang_data",nil,true];
	deleteGroup _group;
	[format["DELETE FROM gangs WHERE id = '%1'",_groupID], 1] call Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Gang_Load", {
	_player = param [0,objNull];
	_req = format["SELECT id, owner, name, members, bank, maxmembers, flag FROM gangs WHERE members LIKE '%2%1%2'",getPlayerUID _player,'%'];
	_gang = [_req, 2] call Server_Database_Async;
	if(count(_gang) > 0) then {
		_gang = [_gang select 0, _gang select 1, _gang select 2, [_gang select 3] call Server_Database_ToArray, _gang select 4, _gang select 5, _gang select 6];
		[_gang] remoteExec ["A3RL_Gang_SetData",_player];
	};
}, true] call Server_Setup_Compile;

["Server_Gang_SaveBank", {
	_group = param [0,grpNull];
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_groupID = _gang select 0;
	_bank = _gang select 4;
	[format ["UPDATE gangs SET bank='%1' WHERE id='%2'",_bank,_groupID], 1] call Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Gang_SaveMaxMembers", {
	_group = param [0,grpNull];
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_groupID = _gang select 0;
	_maxMembers = _gang select 5;
	[format ["UPDATE gangs SET maxmembers='%1' WHERE id='%2'",_maxMembers,_groupID], 1] call Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Gang_SaveMembers", {
	_group = param [0,grpNull];
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_groupID = _gang select 0;
	_members = _gang select 3;
	[format ["UPDATE gangs SET members='%1' WHERE id='%2'",_members,_groupID], 1] call Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_Gang_SetLead", {
	_group = param [0,grpNull];
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_groupID = _gang select 0;
	_owner = _gang select 1;
	[format ["UPDATE gangs SET owner='%1' WHERE id='%2'",_owner,_groupID], 1] call Server_Database_Async;
	_owner = [_owner] call A3PL_Lib_UIDToObject;
	["You have been appointed leader of your gang", "#17ED00"] remoteExec ["A3PL_Player_Notification",_owner];
}, true] call Server_Setup_Compile;