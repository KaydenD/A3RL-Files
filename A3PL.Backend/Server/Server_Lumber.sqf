["Server_Lumber_TreeRespawn",
{
	private ["_randPos","_trees","_tree"];
	_trees = count nearestObjects [(getMarkerPos "LumberJack_Rectangle"), ["Land_A3PL_Tree3"], 190, true];
	
	for "_i" from 1 to (50-_trees) do
	{
		_randPos = ["LumberJack_Rectangle"] call CBA_fnc_randPosArea;
		_tree = createVehicle ["Land_A3PL_Tree3", _randPos, [], 0, "CAN_COLLIDE"];
		_tree setDir (random 360);
	};
},true] call Server_Setup_Compile;