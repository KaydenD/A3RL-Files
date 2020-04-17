["Server_NPC_RequestJob",
{
	private ["_player","_job"];
	//we will request a job change here
	_player = param [0,ObjNull];
	_job = param [1,""];
	if (isNull _player) exitwith {}; // player is null? maybe disconnected
	if (_job == "") exitwith {}; //no job specified, means im an idiot

	//we can always add something here to check any conditions if we want

	//lets change the job
	_player setVariable ["job",_job,true];
	[] remoteExec ["A3PL_Player_SetMarkers", _player];
	//Send a response back
	[[1,_job],"A3PL_NPC_TakeJobResponse",_player,false] call BIS_fnc_MP;

	//add radio if EMS/Police/USCG/dispatch
	if (backpack _player != "A3PL_LR") then {
		if (_job IN ["uscg","fifr","police","dispatch","usms","doj","pdo","dao"]) then
		{
			_player addBackpackGlobal "A3PL_LR";
		};
	};

	if (_job in ["dispatch"]) then {
		Server_Dispatchers pushBack _player;
	};

	if (_job == "faa") then
	{
		_player setposATL [2664.96,5200.17,0.0273218];
		if (backpack _player != "tf_anarc164") then
		{
			_player addBackpackGlobal "tf_anarc164";
		};
	};

},true] call Server_Setup_Compile;
