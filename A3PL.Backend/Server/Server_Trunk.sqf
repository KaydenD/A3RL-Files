//Be VERY careful with this. It will make a LOT of database updates.
["Server_Trunk_Save", {
	{
		_id = _x getVariable ["owner", ["false","ROADSID"]];
		if !(_id IN ["WASTE","DELIVER","EXTERMY","KARTING","DMV", "ROADSID"]) then {
			_inv = [weaponCargo _x,magazineCargo _x,itemCargo _x,backpackCargo _x,_x getVariable ["storage",[]]];
			_query = format ["UPDATE objects SET inventory = '%2' WHERE id = '%1'",_id, _inv];
			[_query,1] spawn Server_Database_Async;
		};
	} forEach Server_Storage_ListVehicles;
}, true] call Server_Setup_Compile;