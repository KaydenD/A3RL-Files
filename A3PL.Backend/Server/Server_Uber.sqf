/*
 *
 * Functions To Whitelist
 *
 * A3PL_Uber_RecieveRequest (server->client)
 *
 * Server_Uber_addDriver (client->server)
 * Server_Uber_removeDriver (client->server)
 * Server_Uber_requestDriver (client->server)
*/


["Server_Uber_addDriver",
{

	_u = _this select 0;
	_user = getPlayerUID _u;

	//add a driver
	if(!(_u in A3PL_Uber_Drivers)) then {
		A3PL_Uber_Drivers pushBack _u;
	};

	_u setVariable ["job","uber",true];

}, true] call Server_Setup_Compile;



["Server_Uber_removeDriver",
{

	params[["_user",objNull,[objNull]]];

	if(_user in A3PL_Uber_Drivers) then {
		_id = A3PL_Uber_Drivers find _user;
		A3PL_Uber_Drivers deleteAt _id;
	};

	if(_user getVariable ["job","unemployed"] != "uber") exitWith {};
	_user setVariable ["job","unemployed",true];

}, true] call Server_Setup_Compile;



["Server_Uber_flushDrivers",
{

	{
		if (isNull _x) then {
			A3PL_Uber_Drivers deleteAt _forEachIndex;
		};
	} forEach A3PL_Uber_Drivers;

}, true] call Server_Setup_Compile;



["Server_Uber_requestDriver", {

	private ["_user"];

	params[["_user",objNull,[objNull]]];

	[] call Server_Uber_flushDrivers;

	if(count A3PL_Uber_Drivers < 1) then
	{
		["No Available Uber Drivers", Color_Red] remoteExec ["A3PL_Player_Notification", _user];
	} else
	{

		["Uber Requested", Color_Green] remoteExec ["A3PL_Player_Notification", _user];
		{
			[_user] remoteExec ["A3PL_Uber_RecieveRequest", _x];
		} forEach A3PL_Uber_Drivers;
	};

}, true] call Server_Setup_Compile
