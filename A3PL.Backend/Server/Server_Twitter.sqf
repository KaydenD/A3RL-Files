["Server_Twitter_HandleMsg",
{
	private ["_player","_msg","_msgcolor","_namecolor","_namepicture","_playerid","_name","_query"];
	_playerid = param [0,""];
	_msg = param [1,""];
	_msgcolor = param [2,""];
	_namepicture = param [3,""];
	_name = param [4,""];
	_namecolor = param [5,""];

	_query = format["INSERT INTO chatlog (name, steamid, chatmessage, messageinfo) VALUES('%1','%2','%3', '%4')",_name,_playerid,([_msg] call Server_Twitter_StripQuotes),([[_namepicture,_namecolor,_msgcolor]] call Server_Database_Array)];
	[_query,1] call Server_Database_Async;

	
	if (!isDedicated) then //just so this works in editor
	{
		[_msg,_msgcolor,_namepicture,_name,_namecolor,""] remoteExec ["A3PL_Twitter_NewMsg", 2]; //target everyone
	} else
	{
		[_msg,_msgcolor,_namepicture,_name,_namecolor,""] remoteExec ["A3PL_Twitter_NewMsg", -2]; //target everyone except server
	};
},true] call Server_Setup_Compile;

//remove ' from string
["Server_Twitter_StripQuotes",
{
	private ["_msg","_del"];
	_msg = toArray (param [0,""]);
	_del = [];
	{
		if (_x == 39) then {_del pushback _forEachIndex};
	} foreach _msg;
	
	{
		_msg deleteAt (_x - _forEachIndex);
	} foreach _del;
	
	_msg = toString _msg;
	_msg;
},true] call Server_Setup_Compile;