["Server_Garage_UpdateAddons",
{
	private ["_query","_veh"];
	_veh = param [0,objNull];
	_addons = param [1,[]];
	_var = _veh getVariable ["owner",[]];
	if((count _var) isEqualTo 0) exitWith {};
	_id = _var select 1;

	_addons = [_addons] call Server_Database_Array;
	diag_log format["SERVER GARAGE DIAG VAR : %1",_addons];

	_query = format ["UPDATE objects SET tuning = '%2' WHERE id = '%1'",_id,_addons];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;