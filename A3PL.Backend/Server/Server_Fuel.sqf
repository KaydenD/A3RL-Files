["Server_Fuel_Save",
{
	private ["_query"];
	{
		_query = format ["UPDATE fuelstations SET fuel = '%1' WHERE id = '%2'",(_x getVariable ["petrol",0]),_forEachIndex];
		[_query,1] spawn Server_Database_Async;
		uiSleep 2;
	} foreach FuelStations;
},true] call Server_Setup_Compile;

["Server_Fuel_Load",
{
	private ["_querry"];
	_querry = ["SELECT id,fuel FROM fuelstations", 2, true] call Server_Database_Async;
	{
		(FuelStations select (_x select 0)) setVariable ["petrol",(_x select 1),true];
	} foreach _querry;
},true] call Server_Setup_Compile;

["Server_Fuel_Vehicle",
{
	private ["_query","_veh","_var","_id"];
	_veh = param [0,objNull];
	_var = _veh getVariable ["owner",[]];
	_id = _var select 1;
	_query = format ["UPDATE objects SET fuel = '%2' WHERE id = '%1'",_id,(fuel _veh)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;