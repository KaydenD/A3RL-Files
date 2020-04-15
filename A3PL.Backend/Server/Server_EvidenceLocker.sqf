["Server_EvidenceLocker_Save", {
	_box = Evidence_Locker;
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box];

	_query = format ["UPDATE persistent_vars SET value ='%1' WHERE var = 'Evidence_Locker'",([_items] call Server_Database_Array)];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_EvidenceLocker_Load", {
	_query = "SELECT value FROM persistent_vars WHERE var='Evidence_Locker'";
	_return = [_query, 2] call Server_Database_Async;
	
	//_return 
	{
		Evidence_Locker addItemCargoGlobal [_x select 0, _x select 1];
	} forEach _return;
}, true] call Server_Setup_Compile;