["Server_Criminal_RemoveJail", {
  	_player = param [0,objNull];

  _query = format ["UPDATE players SET jail='0' WHERE uid = '%1'",getPlayerUID _player];
  _return = [_query, 2,true] call Server_Database_Async;


  _index = [Server_Jailed_Players, _player] call BIS_fnc_findNestedElement;
  
  Server_Jailed_Players deleteAt (_index select 0);

  },true] call Server_Setup_Compile;
