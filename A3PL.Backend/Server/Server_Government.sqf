//minutes before mayor gets elected
#define VOTETIME 1440
["Server_Government_SetTax",
{
	private ["_taxRate","_taxChanged","_success","_oldRate"];

	_taxChanged = param [0,""];
	_taxRate = param [1,0];
	_oldRate = 0;
	_success = false;

	{
		if (_x select 0 == _taxChanged) exitwith
		{
			_oldRate = _x select 1;
			Config_Government_Taxes set [_forEachIndex,[(_x select 0),_taxRate]];
			_success = true;
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);

	if (!_success) exitwith {}; //failed to change tax cause its probably not defined

	publicVariable "Config_Government_Taxes";
	[_taxChanged,_oldRate,_taxRate] remoteExec ["A3PL_Government_NewTax", -2]; //change to -2
	["Config_Government_Taxes",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

//add a balance to something, can also remove from another balance if more arguments supplied
["Server_Government_AddBalance",
{
	private ["_addBalance","_amount","_takeBalance","_fail","_newAmount"];
	_addBalance = param [0,""]; //what balance to add
	_amount = param [1,0]; //amount to add
	_takeBalance = param [2,""]; //if we need to take it from another balance

	{
		if ((_x select 0) == _takeBalance) then
		{
			if ((_x select 1) < _amount) exitwith {_fail = true;}; //make sure players cant take more money then there is
			Config_Government_Balances set [_forEachIndex,[_x select 0,(_x select 1) - _amount]];
		};
		if (!isNil "_fail") exitwith {}; //exit loop if we exited previously
		if ((_x select 0) == _addBalance) then
		{
			_newAmount = (_x select 1) + _amount;
			if (_newAmount < 0) then {_newAmount = 0;};
			Config_Government_Balances set [_forEachIndex,[_x select 0,_newAmount]];
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	publicVariable "Config_Government_Balances";
	["Config_Government_Balances",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_ChangeLaw",
{
	private ["_lawIndex","_newLaw","_lawDo"];

	_lawDo = param [0,0];
	_lawIndex = param [1,0];
	_newLaw = param [2,""];

	switch (_lawdo) do
	{
		case (-1): //remove
		{
			Config_Government_Laws deleteAt _lawIndex;
		};

		case (0): //change
		{
			Config_Government_Laws set [_lawIndex,_newLaw];
		};

		case (1): //add
		{
			_lawIndex = count Config_Government_Laws;
			Config_Government_Laws pushback _newLaw;
		};
	};

	publicVariable "Config_Government_Laws";

	["Config_Government_Laws",true] call Server_Core_SavePersistentVar;
	[_lawIndex] remoteExec ["A3PL_Government_NewLaw", -2]; //change to -2
},true] call Server_Setup_Compile;

//starts a vote, admin triggered
["Server_Government_StartVote",
{
	private ["_time"];
	_time = param [0,VOTETIME]; //if no time defined, use the default

	Server_Government_CCandidates = missionNameSpace getVariable ["Server_Government_Candidates",[]]; //CCandidates as is Current Canidates
	if (count Server_Government_CCandidates < 1) exitwith {}; //NO CANDIDATES, BE CAREFULL SCRIPT WILL EXIT HERE WITHOUT NOTIFY!!!
	publicVariable "Server_Government_CCandidates";
	[_time] remoteExec ["A3PL_Government_NewVote", -2]; //change to -2
	Server_Government_Voted = []; //list to keep track of people who already voted

	//nil the candidates
	Server_Government_Candidates = [];
	["Server_Government_Candidates",true] call Server_Core_SavePersistentVar;
	//end of nilling candidates

	[_time] spawn
	{
		private ["_time","_votes","_winner","_winnerUID","_votes"];
		_time = param [0,VOTETIME];
		uiSleep (_time*60);

		//determine winner
		_votes = -1;
		_winner = "";
		_winnerUID = "";
		{
			private ["_vot"];
			_vot = _x select 2;
			if (_vot > _votes) then {_winner = _x select 0; _winnerUID = _x select 1; _votes = _vot;};
		} foreach (missionNameSpace getVariable ["Server_Government_CCandidates",[]]);

		if (_winner != "") then
		{
			[_winner] remoteExec ["A3PL_Government_NewMayor", -2]; //change to -2
			A3PL_Mayor = [_winnerUID,_winner];
			publicVariable "A3PL_Mayor";
			["A3PL_Mayor",true] call Server_Core_SavePersistentVar;
		};
		Server_Government_Voted = nil; //clear mem
		Server_Government_CCandidates = nil;
		publicVariable "Server_Government_CCandidates";
	};
},true] call Server_Setup_Compile;

["Server_Government_AddCandidate",
{
	private ["_player","_candidates","_exist"];
	_player = param [0,objNull];
	_candidates = missionNameSpace getVariable ["Server_Government_Candidates",[]];
	if ((!isPlayer _player) OR (isNull _player)) exitwith {};
	_uid = getPlayerUID _player;

	{
		if (_x select 1 == _uid) exitwith {_exist = true};
	} foreach _candidates; //check if already candidate

	if (!isNil "_exist") exitwith {}; //already exist

	_candidates pushback [(_player getVariable ["name",name _player]),_uid,0]; //name,uid,votes
	Server_Government_Candidates = _candidates;
	["Server_Government_Candidates",true] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_Government_AddVote",
{
	private ["_player","_voting","_uid"];
	_player = param [0,objNull];
	_voting = param [1,""];
	if ((!isPlayer _player) OR (isNull _player)) exitwith {};
	_uid = getPlayerUID _player;

	if (_uid IN Server_Government_Voted) exitwith {}; //this player already voted;
	Server_Government_Voted pushback _uid;

	//add the new vote
	{
		if ((_x select 1) == _voting) exitwith
		{
			Server_Government_CCandidates set [_forEachIndex,[_x select 0,_x select 1,(_x select 2)+1]];
			publicVariable "Server_Government_CCandidates";
		};
	} foreach (missionNameSpace getVariable ["Server_Government_CCandidates",[]]);
},true] call Server_Setup_Compile;

//this will send info back to the client, get database  info
["Server_Government_FactionSetupInfo",
{
	private ["_leader","_faction","_uid","_factionPlayers","_allRanks","_ranks"];
	_leader = param [0,objNull];
	_faction = param [1,""];
	_uid = getPlayerUID _leader;

	if (hasInterface) then //just to test in editor
	{
		_factionPlayers = [["Kane","_SP_PLAYER_"]];
		if (isNil "Server_Government_FactionRanks") then { Server_Government_FactionRanks = [["police",[]],["fifr",[]],["uscg",[]]]; };

	} else
	{
		_factionPlayers = [format ["SELECT name,uid FROM players WHERE faction='%1'",_faction], 2,true] call Server_Database_Async;
	};
	_allRanks = missionNameSpace getVariable ["Server_Government_FactionRanks",[]];
	_ranks = [];
	{
		if ((_x select 0) == _faction) exitwith {_ranks = _x select 1;}; //filter out the other ranks
	} foreach _allRanks;

	if (hasInterface) then //editor
	{
		[_factionPlayers,_ranks] remoteExec ["A3PL_Government_FactionSetupReceive", 0]; //change to -2
	} else
	{
		[_factionPlayers,_ranks] remoteExec ["A3PL_Government_FactionSetupReceive", (owner _leader)];
	};
},true] call Server_Setup_Compile;

//sets a rank to a person in a faction
["Server_Government_SetRank",
{
	private ["_person","_faction","_rank","_ranks","_index"];
	_faction = param [0,""];
	_person = param [1,""];
	_rank = param [2,""];

	_ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	_index = _ranks select 1; //the index of a faction
	_ranks = _ranks select 0;

	{
		//remove from other ranks
		private ["_persons","_rankx"];
		_rankx = _x select 0;
		_persons = _x select 1;
		if (_person IN _persons) then
		{
			_persons = _persons - [_person];
			_ranks set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
			systemChat format ["removed for %1",_rankx];
		};

		if (_rankx == _rank) then
		{
			_persons pushback _person;
		};
	} foreach _ranks;
},true] call Server_Setup_Compile;

//adds a rank to a faction
["Server_Government_AddRank",
{
	private ["_faction","_rank","_exist","_ranks","_index"];
	_faction = param [0,""];
	_rank = param [1,""];
	_exist = false;

	_ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;

	_index = _ranks select 1; //the index of a faction
	_ranks = _ranks select 0;

	{
		if ((_x select 0) == _rank) exitwith {_exist = true;};//check if rank exist already
	} foreach _ranks;
	if (_exist) exitwith {};

	_ranks pushback [_rank,[],0]; //rank name,players in rank,rank pay
	Server_Government_FactionRanks set [_index,[_faction,_ranks]];
},true] call Server_Setup_Compile;

//removes a rank from a faction
["Server_Government_RemoveRank",
{
	private ["_faction","_rank","_index"];
	_faction = param [0,""];
	_rank = param [1,""];

	_ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	_index = _ranks select 1;
	_ranks = _ranks select 0;
	{
		if (_x select 0 == _rank) exitwith {_ranks deleteAt _forEachIndex;};
	} foreach _ranks;

	Server_Government_FactionRanks set [_index,[_faction,_ranks]];
},true] call Server_Setup_Compile;


//sets a rank pay of a faction
["Server_Government_SetPay",
{
	private ["_faction","_rank","_pay","_ranks","_index"];
	_faction = param [0,""];
	_rank = param [1,""];
	_pay = param [2,0];
	_ranks = [_faction,"ranks"] call A3PL_Config_GetRanks;
	_index = _ranks select 1; //the index of a faction
	_ranks = _ranks select 0;
	{
		if ((_x select 0) == _rank) then {_ranks set [_forEachIndex,[(_x select 0),(_x select 1),_pay]]};
	} foreach _ranks;
	//Server_Government_FactionRanks set [_index,[_faction,_ranks]]; arma does this shit already
},true] call Server_Setup_Compile;
