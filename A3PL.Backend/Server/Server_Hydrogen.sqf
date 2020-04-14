["Server_Hydrogen_Save", {
	private ["_gasstations"];
	_gasstations = [A3PL_GasHose1,A3PL_GasHose2,A3PL_GasHose3,A3PL_GasHose4,A3PL_GasHose4_1,A3PL_GasHose4_3,A3PL_GasHose4_4,A3PL_GasHose5];
	
	{
		_station = nearestObject [_x,"Land_A3PL_Gas_Station"];
		
		_query = format ["UPDATE fuelstations SET fuel=%2 WHERE id ='%1'",_x,(_station getVariable ["petrol",0])];
		[_query,1] spawn Server_Database_Async;
	} forEach _gasstations;
}, true] call Server_Setup_Compile;

["Server_Hydrogen_Load", {
	private ["_data"];
	_data = ["SELECT * FROM fuelstations", 2, true] call Server_Database_Async;
	
	{
		_station = nearestObject [_x select 0,"Land_A3PL_Gas_Station"];
		_station setVariable ["petrol", _x select 1, true];
	} forEach _data;
}, true] call Server_Setup_Compile;