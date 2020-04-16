["Server_EvidenceLocker_Save", {
	_box = nearestObject [[4776.12,6315.75,0.00143862], "B_supplyCrate_F"];
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box];

	_query = format ["UPDATE persistent_vars SET value ='%1' WHERE var = 'Evidence_Locker'",_items];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_EvidenceLocker_Load", {
	_query = "SELECT value FROM persistent_vars WHERE var='Evidence_Locker'";
	_return = [_query, 2] call Server_Database_Async;
	_box = nearestObject [[4776.12,6315.75,0.00143862], "B_supplyCrate_F"];

	{_box addWeaponCargoGlobal [_x,1]} foreach _return select 0;
	{_box addMagazineCargoGlobal [_x,1]} foreach _return select 1;
	{_box addItemCargoGlobal [_x,1]} foreach _return select 2;
	{_box addBackpackCargoGlobal [_x,1]} foreach _return select 3;
}, true] call Server_Setup_Compile;