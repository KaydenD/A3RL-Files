["Server_EvidenceLocker_Save", {
	private["_locker", "_items"];
	_locker = _this select 0;
	_items = [];
	{
		_class = _x select 0;
		_amounts = _x select 1;
		{
			_items pushBack [_x, _amounts select _forEachIndex];
		} forEach _class;
	} forEach [getWeaponCargo _locker, getMagazineCargo _locker, getItemCargo _locker, getBackpackCargo _locker];
	
	_query = format ["UPDATE persistent_vars SET value ='%1' WHERE var = 'Evidence_Locker'",
		([_items] call Server_Database_Array)
	];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_EvidenceLocker_Load", {
	_query = "SELECT value FROM persistent_vars WHERE var='Evidence_Locker'";
	_return = [_query, 2] call Server_Database_Async;
	
	if((count _return) == 0) exitWith {}; 
	
	//_return 
	{
		_this select 0 addItemCargoGlobal [_x select 0, _x select 1];
	} forEach _return;
}, true] call Server_Setup_Compile;