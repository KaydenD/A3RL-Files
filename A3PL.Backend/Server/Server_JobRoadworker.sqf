//mark for impound
["Server_JobRoadWorker_Mark",
{
	_veh = param [0,objNull];
	if (isNull _veh) exitwith {};

	_veh setVariable ["impound",true,true];

	//send message to all roadworkers, second argument is true it will return array of ID
	_roadworkers = ["Roadside_Service",true] call A3PL_Lib_FactionPlayers;

	//push vehicle to the back of master array
	Server_JobRoadWorker_Marked pushback _veh;
	publicVariable "Server_JobRoadWorker_Marked";

	[_veh] remoteExec ["A3PL_JobRoadWorker_MarkResponse", _roadworkers];
},true] call Server_Setup_Compile;

["Server_JobRoadWorker_UnMark",
{
	_veh = param [0,objNull];
	if (isNull _veh) exitwith {};

	_veh setVariable ["impound",nil,true];

	//take vehicle to the back of master array
	if (_veh IN Server_JobRoadWorker_Marked) then
	{
		Server_JobRoadWorker_Marked = Server_JobRoadWorker_Marked - [_veh];
		publicVariable "Server_JobRoadWorker_Marked";
	};

},true] call Server_Setup_Compile;

["Server_JobRoadWorker_Impound",
{
	private ["_veh","_player"];
	_veh = param [0,objNull];
	_player = param [1,objNull];

	if (((_veh getVariable "owner") select 0) != (getPlayerUID _player)) then
	{
		[_player,"Player_Cash",((_player getVariable ["player_cash",0]) + 2000)] call Server_Core_ChangeVar;
	};

	[_veh] call Server_Police_Impound;
},true] call Server_Setup_Compile;
