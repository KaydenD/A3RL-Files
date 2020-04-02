["A3PL_JobFisherman_DeployNet",
{
	private ["_overwater","_a"];

	/* if (!(player getVariable ["job","unemployed"] == "fisherman")) exitwith {
		["System: You are not a fisherman and thus cannot deploy a net",Color_Red] call A3PL_Player_Notification;
	}; */

	if (!(vehicle player == player)) exitwith {
		["System: You are inside a vehicle and cannot deploy a net",Color_Red] call A3PL_Player_Notification;
	};

	_overwater = !(position player isFlatEmpty  [-1, -1, -1, -1, 2, false] isEqualTo []);
	if (!(_overwater)) exitwith {
		["System: You are not in the water and cannot deploy a net",Color_Red] call A3PL_Player_Notification;
	};

	/* Clean up any deleted buoys */
	{
		if(isNull _x) then {
			A3PL_FishingBuoy_Local deleteAt _forEachIndex;
		};
	} forEach A3PL_FishingBuoy_Local;

	if(count A3PL_FishingBuoy_Local >= 8) exitWith {
		["System: You already have 8 nets deployed!",Color_Red] call A3PL_Player_Notification;
	};

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	A3PL_FishingBuoy_Local pushBack player_objIntersect;
	[[player,player_objIntersect],"Server_JobFisherman_DeployNet",false,false] call BIS_fnc_MP;

	//["System: Send request to server to deploy a net",Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobFisherman_RetrieveNet",
{
	private ["_fishes","_buoy"];

	params[["_buoy",objNull,[objNull]]];

	if (isNull _buoy) exitwith {};

	/* if (!(player getVariable ["job","unemployed"] == "fisherman")) exitwith {
		["System: You are not a fisherman and thus cannot retrieve a net",Color_Red] call A3PL_Player_Notification;
	}; */

	_fishstate = _buoy getVariable ["fishstate",-1];
	if (_fishstate < 0) exitwith {
		["System: Error, unable to pickup this net",Color_Red] call A3PL_Player_Notification;
	};

	if (_fishstate < 50) exitwith {
		_message = format["System: This net is only %1%2 full, wait until it's 100%3.",(_fishstate * 2),"%","%"];
		[_message,Color_Red] call A3PL_Player_Notification;
	};

	if(_buoy getVariable ["used",false]) exitWith {
		["System: Buoy already collected",Color_Red] call A3PL_Player_Notification;
	};

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_buoy setVariable ["used",true,true];
	[[player,_buoy],"Server_JobFisherman_GrabNet",false,false] call BIS_fnc_MP;

}] call Server_Setup_Compile;

["A3PL_JobFisherman_DeployNetSuccess",
{
	[4] call A3PL_JobFisherman_DeployNetResponse;
}] call Server_Setup_Compile;

["A3PL_JobFisherman_DeployNetResponse",
{
	private ["_r"];
	_r = param [0,1];

	switch _r do
	{
		case 0: {["Server: You don't have a bucket to store the fish in",Color_Red] call A3PL_Player_Notification;};
		case 1: {["Server: An error occured on the server, unable to retrieve net",Color_Red] call A3PL_Player_Notification;};
		case 2: {["Server: You don't seem to have a net to deploy",Color_Red] call A3PL_Player_Notification;};
		case 3: {["Server: You picked up the net and received a bucket of fish",Color_Green] call A3PL_Player_Notification;};
		case 4: {["Server: You succesfully deployed a net",Color_Green] call A3PL_Player_Notification;};
		case 5: {["Server: You picked up the net and received a bucket of fish and a mullet you can use for shark/turtle fishing!",Color_Green] call A3PL_Player_Notification;};
		case 6: {["Server: You picked up the net and received a bucket of fish, with the mullet as bait you also caught a catshark!",Color_Green] call A3PL_Player_Notification;};
		case 7: {["Server: You picked up the net and received a bucket of fish, your mullet as bait caught a shark but the shark escaped!",Color_Green] call A3PL_Player_Notification;};
		case 8: {["Server: You picked up the net and received a bucket of fish, your mullet as bait caught a turtle but it escaped!",Color_Green] call A3PL_Player_Notification;};
		case 9: {["Server: You picked up the net and received a bucket of fish, your mullet as bait caught an ILLEGAL turtle",Color_Green] call A3PL_Player_Notification;};
	};

}] call Server_Setup_Compile;

["A3PL_JobFisherman_Bait",
{
	private ["_buoy","_bait"];
	_buoy = param [0,objNull];
	_bait = "none";

	if (!(["mullet",1] call A3PL_Inventory_Has)) exitwith {["System: You don't have a mullet to bait this net with!",Color_Red] call A3PL_Player_Notification;};

	switch (true) do
	{
		case ((player inArea "A3PL_Marker_Fish3") OR (player inArea "A3PL_Marker_Fish6") OR (player inArea "A3PL_Marker_Fish7")): {_bait = "shark"};
		case ((player inArea "A3PL_Marker_Fish5") OR (player inArea "A3PL_Marker_Fish8")): {_bait = "turtle"};
	};

	if (_bait == "none") exitwith {["System: Bait can only be used in a shark or turtle area to catch shark or turtle",Color_Red] call A3PL_Player_Notification;};

	if ((_buoy getVariable ["bait","none"]) == "none") then
	{
		["mullet",-1] call A3PL_Inventory_Add;
		_buoy setVariable ["bait",_bait,true];
		["System: You succesfully baited this net with a mullet",Color_Green] call A3PL_Player_Notification;
	} else
	{
		["System: This net is already baited",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;
