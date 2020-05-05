["Server_FactionManagment_Init", {
	private ["_faction", "_target", "_data"];
	_faction = param[0, ""];
	_target = param[1, ""];
	_id = [_faction] call Server_FactionManagment_ID;
	_ranks = [format["SELECT id, name, pay FROM factionranks WHERE fid = %1", _id], 2, true] call Server_Database_Async;
	_players = [format["SELECT name, rank FROM players WHERE faction = '%1'", _faction], 2, true] call Server_Database_Async;
	_faction = [A3RL_Factions, _target getVariable ["job","unemployed"]] call BIS_fnc_findNestedElement;
	_factionAccount = (A3RL_Factions select (_faction select 0)) select 2;

	[_id, _ranks, _players, _factionAccount] remoteExec ["A3RL_FactionManagment_Setup", _target];
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
	_target = param[2, ""];
	_somthing = false;

	_query = format ["INSERT INTO factionranks (fid, name) VALUES (%1, '%2')",_fid,_name];
	_somthing = [_query,2] spawn Server_Database_Async;

	waitUntil {isNull(_somthing)};

	_ranks = [format["SELECT id FROM factionranks WHERE name = '%1'", _name], 2, true] call Server_Database_Async;

	A3RL_FactionRanks pushBack [((_ranks select 0) select 0), _fid, _name, 0, 0];
	publicVariable "A3RL_FactionRanks";

	[] remoteExec ["A3RL_FactionManagment_RefreshRanks", _target];
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

["Server_FactionManagment_Startup", {
	A3RL_FactionRanks = ["SELECT id, fid, name, pay, managment FROM factionranks", 2, true] call Server_Database_Async;
	publicVariable "A3RL_FactionRanks";

	A3RL_Factions = ["SELECT id, name, money FROM factions", 2, true] call Server_Database_Async;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_HandlePayCheck", {
	_player = param[0, objNull];
	_faction = [A3RL_Factions, _player getVariable ["job","unemployed"]] call BIS_fnc_findNestedElement;

	_factionAccount = (A3RL_Factions select (_faction select 0)) select 2;
	_fid = (A3RL_Factions select (_faction select 0)) select 0;

	_amount = 0;
	{
		if((_x select 1) == _fid) exitWith {
			_amount = (_x select 3);
		};
	} forEach A3RL_FactionRanks;

	if(_factionAccount >= _amount) then {
		A3RL_Factions select (_faction select 0) set [2, (_factionAccount - _amount)];
		_player setVariable ["Player_Bank",(_player getVariable ["Player_Bank",0]) + _amount,true];
		["I have received my paycheck, it has been deposited into my bank account directly",'#17ED00'] remoteExec ["A3PL_Player_Notification", _player];
	} else {
		["Your faction does't have enough money to pay you",'#FD1703'] remoteExec ["A3PL_Player_Notification", _player];
	};
}, true] call Server_Setup_Compile;

["Server_FactionManagment_SaveFaction", {
	{
		_query = format ["UPDATE factions SET money = %1 WHERE id = %2",_x select 2, _x select 0];
		[_query,1] spawn Server_Database_Async;
	} forEach A3RL_Factions;
}, true] call Server_Setup_Compile;

["Server_FactionManagment_SetNewFaction", {
	_hire = param[0, false];
	_target = param[1, objNull];
	_player = param[2, objNull];

	_faction = "citizen";
	if(_hire) then {
		_faction = _player getVariable ["faction", "citizen"];
		["You have been hired!",'#17ED00'] remoteExec ["A3PL_Player_Notification", _target];
	} else {
		_target setVariable ["job", "unemployed", true];
		["You have been fired!",'#FD1703'] remoteExec ["A3PL_Player_Notification", _target];
	};

	_query = format ["UPDATE players SET faction = '%1' WHERE name = '%2'",_faction,(_target getVariable ["name", ""])];
	[_query,1] spawn Server_Database_Async;

	_target setVariable ["faction", _faction, true];
}, true] call Server_Setup_Compile;