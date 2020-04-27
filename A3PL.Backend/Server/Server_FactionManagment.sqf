["Server_FactionManagment_Init", {
	private ["_faction", "_target", "_data"];
	_faction = param[0, ""];
	_target = param[1, ""];
	_id = [_faction] call Server_FactionManagment_ID;
	_ranks = [format["SELECT id, name, pay FROM factionranks WHERE fid = %1", _id], 2, true] call Server_Database_Async;
	_players = [format["SELECT name, rank FROM players WHERE faction = '%1'", _faction], 2, true] call Server_Database_Async;

	[_id, _ranks, _players] remoteExec ["A3RL_FactionManagment_Setup", _target];
}, true] call Server_Setup_Compile;


["Server_FactionManagment_ID", {
	_faction = param[0, ""];
	_id = [format["SELECT id FROM factions WHERE NAME = '%1'", _faction], 2, true] call Server_Database_Async;
	_id = ((_id select 0) select 0);

	_id;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_AddRank", {
	_name = param[0, ""];
	_fid = param[1, 0];

	_query = format ["INSERT INTO factionranks (fid, name) VALUES (%1, '%2')",_fid,_name];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_SetRank", {
	_name = param[0, ""];
	_rank = param[1, ""];

	_query = format ["UPDATE players SET rank = %1 WHERE name = '%2'",_rank,_name];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_RemoveRank", {
	_rank = param[0, 0];
	_inrank = [format["SELECT name FROM players WHERE rank = %1", _rank], 2, true] call Server_Database_Async;

	{
		_query = format ["UPDATE players SET rank = 0 WHERE name = '%1'",_x select 0];
		[_query,1] spawn Server_Database_Async;
	} forEach _inrank;

	_query = format ["DELETE FROM factionranks WHERE id = %1",_rank];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_SetPay", {
	_rank = param[0, 0];
	_pay = param[1, 0];

	_query = format ["UPDATE factionranks SET pay = %1 WHERE id = %2",_pay,_rank];
	[_query,1] spawn Server_Database_Async;
}, true] call Server_Setup_Compile;