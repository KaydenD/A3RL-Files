["A3PL_JobRoadworker_RepairTerrain",
{
	private ["_tObjects","_obj","_timeLeft"];

	if (!(vehicle player == player)) exitwith {["System: You can't be in a vehicle when repairing objects", Color_Red] call A3PL_Player_Notification;};
	_tObjects = nearestTerrainObjects [player, [], 5];
	if (count _tObjects < 1) exitwith {["System: There doesn't seem to be a terrain object nearby", Color_Red] call A3PL_Player_Notification;};
	_obj = _tObjects select 0;
	if (getDammage _obj < 1) exitwith {["System: This object doesn't seem to be damaged", Color_Red] call A3PL_Player_Notification;};
	_obj setDammage 0;

	_timeLeft = missionNameSpace getVariable ["A3PL_JobRoadworker_Timer",(diag_ticktime-2)];
	if (_timeLeft > diag_ticktime) exitwith {[format ["You need to wait %1 more seconds before you will be paid for repairing terrain objects again.",round(_timeLeft-diag_ticktime)],Color_Red] call A3PL_Player_Notification;};
	missionNameSpace setVariable ["A3PL_JobRoadworker_Timer",(diag_ticktime + (60 + random 3))];

	["System: You succesfully repaired a terrain object and earned $75", Color_Green] call A3PL_Player_Notification;
	[[player, 'Player_Cash', ((player getVariable 'Player_Cash') + 75)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_Loop",
{
	player setVariable ["TerrainRepaired",nil,false];//clear the list
}] call Server_Setup_Compile;

//ALL THE ABOVE IS OLD STUFF, MIGHT WANT TO REMOVE IT LATER!!!

["A3PL_JobRoadWorker_ToggleMark",
{
	private ["_veh"];
	_veh = param [0,objNull];

	if (isNull _veh) then
	{
		_veh = player_objintersect;
		if (!(_veh isKindOf "LandVehicle")) then {_veh = cursorobject};
		if (isNull _veh) exitwith {["System: Couldn't find a vehicle to impound, are you looking at it?", Color_Red] call A3PL_Player_Notification;};
	};

	//if (_veh distance player > 7) exitWith {["System: You are too far away from the vehicle to mark it for impound", Color_Red] call A3PL_Player_Notification;};

	if (_veh getVariable ["impound",false]) then
	{
		[_veh] remoteExec ["Server_JobRoadWorker_UnMark", 2];
		["System: You unmarked this vehicle for impounding it cost you $500", Color_Red] call A3PL_Player_Notification;
		player setVariable ["player_bank",(player getVariable ["player_bank",0])-500,true];
	} else
	{
		[_veh] remoteExec ["Server_JobRoadWorker_Mark", 2];
		["System: You marked this vehicle for impounding and received $200 - message was send to all available roadworks", Color_Green] call A3PL_Player_Notification;
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+200,true];

	};
}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_MarkResponse",
{
	private ["_veh"];
	_veh = param [0,objNull];
	_license = (_veh getvariable ["owner",["0","ERROR"]]) select 1;

	[format ["Server: A new vehicle is available for impounding, it has been marked on the map (License: %1)",_license], Color_Green] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_MarkerLoop",
{
	if (!((player getVariable ["job","unemployed"]) IN ["Roadside_Service","police","fifr"])) exitwith {};

	{
		deleteMarkerLocal _x;
	} foreach A3PL_Jobroadworker_MarkerList;

	A3PL_Jobroadworker_MarkerList = [];

	{
		_lp = (_x getvariable ["owner",["0","ERROR"]]) select 1;
		_marker = createMarkerLocal [format ["impound_%1",random 4000], _x];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_warning";

		_marker setMarkerTextLocal format ["Vehicle marked for impound (LP: %1)",_lp];
		_marker setMarkerColorLocal "ColorRed";

		A3PL_Jobroadworker_MarkerList pushback _marker;
	} foreach Server_JobRoadWorker_Marked;

}] call Server_Setup_Compile;

["A3PL_JobRoadWorker_Impound",
{
	private ["_car","_cars"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if ((player getVariable ["job","unemployed"]) != "Roadside_Service") exitwith {["System: You dont seem to be working here as a Roadside Service Worker", Color_Red] call A3PL_Player_Notification;};

	_cars = nearestObjects [player, ["Car"], 10];
	_car = objNull;
	{
		if (_x getVariable ["impound",false]) exitwith {_car = _x;};
	} foreach _cars;

	if (isNull _car) exitwith {["System: It doesn't seem like there is a car nearby that is marked for impounding", Color_Red] call A3PL_Player_Notification;};
	if ((_car getVariable ["Towed",true])) exitwith {["System: Unload car before impounding", Color_Red] call A3PL_Player_Notification;};
	["System: Send request to server to impound this vehicle, you were rewarded with $2000", Color_Green] call A3PL_Player_Notification;
	[_car,player] remoteExec ["Server_JobRoadWorker_Impound",2];
}] call Server_Setup_Compile;
