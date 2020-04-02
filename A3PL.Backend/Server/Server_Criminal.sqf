["Server_Criminal_RemoveJail", {
  	_player = param [0,objNull];

  _query = format ["UPDATE players SET jail='0' WHERE uid = '%1'",_player];
  _return = [_query, 2,true] call Server_Database_Async;


  _index = Server_Jailed_Players find _player;
  
  Server_Jailed_Players deleteAt _index;

  },true] call Server_Setup_Compile;
