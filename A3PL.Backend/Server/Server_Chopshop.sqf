["Server_Chopshop_Chop",
{
	private ["_veh","_player"];
	_veh = param [0,objNull];
	_player = param [1,objNull];


	if (((_veh getVariable "owner") select 0) != (getPlayerUID _player)) then
	{
		[_player,"Player_Cash",((_player getVariable ["player_cash",0]) + 6000)] call Server_Core_ChangeVar;
	};

	[_veh] call Server_Chopshop_Storecar;
},true] call Server_Setup_Compile;

["Server_Chopshop_Storecar",
{
	private ["_veh","_var","_id","_query"];
	_veh = param [0,objNull];
	if (isNull _veh) exitwith {};

	_var = _veh getVariable ["owner",nil];

	if (!isNil "_var") then
	{
		_id = _var select 1;
		_query = format ["UPDATE objects SET plystorage = '1',impounded='3',fuel='%2' WHERE id = '%1'",_id,(fuel _veh)];
		[_query,1] spawn Server_Database_Async;
	};

	[_veh] call Server_Vehicle_Despawn;

	if (!isNil "_id") then
	{
		private ["_player","_cash","_fine"];
		_player = [(_var select 0)] call A3PL_Lib_UIDToObject;

	};
},true] call Server_Setup_Compile;
