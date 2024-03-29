["Server_EvidenceLocker_Save", {
	_box = nearestObject [[4776.12,6315.75,0.00143862], "B_supplyCrate_F"];
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box,_box getVariable ["storage",[]]];

	_query = format ["UPDATE persistent_vars SET value ='%1' WHERE var = 'Evidence_Locker'",_items];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_EvidenceLocker_Load", {
	_query = "SELECT value FROM persistent_vars WHERE var='Evidence_Locker'";
	_return = [_query, 2] call Server_Database_Async;
	_cargo = call compile (_return select 0);
	_box = nearestObject [[4776.12,6315.75,0.00143862], "B_supplyCrate_F"];

	clearItemCargoGlobal _box; 
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	{_box addWeaponCargoGlobal [_x,1]} foreach (_cargo select 0);
	{_box addMagazineCargoGlobal [_x,1]} foreach (_cargo select 1);
	{_box addItemCargoGlobal [_x,1]} foreach (_cargo select 2);
	{_box addBackpackCargoGlobal [_x,1]} foreach (_cargo select 3);
	_box setVariable ["storage",(_cargo select 4),true];
	_box setVariable ["locked", true, true];
}, true] call Server_Setup_Compile;