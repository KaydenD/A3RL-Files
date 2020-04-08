//add or remove a license
["Server_DMV_Add",
{
	private ["_target","_license","_add","_licenses","_uid"];
	_target = param [0,objNull];
	_uid = getPlayerUID _target;
	_license = param [1,"driver"];
	_add = param [2,true];
	_licenses = _target getVariable ["licenses",[]];
	
	if (_add) then
	{
		if (!(_license IN _licenses)) then
		{
			_licenses pushback _license;
			[format["Server: You were issued a %1 license",_license], Color_Green] remoteExec ["A3PL_Player_Notification",_target];
			[_uid,"license_add",_license, player getVariable "name"] call Server_Log_New;
		};
	} else
	{
		if (_license IN _licenses) then
		{
			_licenses = _licenses - [_license];
			[format["Server: Your %1 license was revoked",_license], Color_Red] remoteExec ["A3PL_Player_Notification",_target];
			[_uid,"license_revoke",_license, player getVariable "name"] call Server_Log_New;
		};
	};
	
	//set variable
	_target setVariable ["licenses",_licenses,true];
	
	//save to db
	_query = format ["UPDATE players SET licenses='%2' WHERE uid ='%1'",_uid,([_licenses] call Server_Database_Array)];		
	[_query,1] spawn Server_Database_Async;	
	
}] call Server_Setup_Compile;