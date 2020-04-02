// Starting Fire via Function //

["A3PL_Fire_StartFire", {
	private ["_position"];
	_position = param [0,[]];
	_dir = windDir;
	if (count _position < 3) exitwith {}; //not valid position
	[_position,_dir] remoteExec ["Server_Fire_StartFire", 2];
}] call Server_Setup_Compile;

// Remove All Active Fires //

["A3PL_Fire_RemoveFires", {
	[] remoteExec ["Server_Fire_RemoveFires", 2];
}] call Server_Setup_Compile;

// Pause/Unpause Fire Spreading //

["A3PL_Fire_PauseFire", {
	[] remoteExec ["Server_Fire_PauseFire", 2];
}] call Server_Setup_Compile;

// Starting Fire via Matches //

["A3PL_Fire_Matches", {
	_status = missionNamespace getVariable "FireCooldown";
	if (player_itemClass != "matches") exitwith {["System: You don't have matches!",Color_Red] call A3PL_Player_Notification;};
	if ((count(["fifr"] call A3PL_Lib_FactionPlayers)) < 5) exitwith {["System: There needs to be a minimum of 5 FIFR online to start fires!",Color_Red] call A3PL_Player_Notification;};
	if (_status == 1) exitwith {["System: You cannot light a fire, one is currently in progress!",Color_Red] call A3PL_Player_Notification;};

	_matches = Player_Item;
	[player_itemClass,-1] call A3PL_Inventory_Add;
	Player_Item = objNull;
	Player_ItemClass = '';
	deleteVehicle _matches;

	missionNamespace setVariable ["FireCooldown",1,true];
	[getpos player,getdir player] call A3PL_Fire_StartFire;

	_marker = createMarker [format ["fire_%1",random 4000], position player];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "mil_dot";

	_marker setMarkerText "Fire Reported!";
	_marker setMarkerColor "ColorRed";

	//msg FIFR
	_firemen = ["fifr"] call A3PL_Lib_FactionPlayers;
	["!!! ALERT !!! A fire has been reported! It is marked on your map!", Color_Red] remoteExec ["A3PL_Player_Notification",_firemen];

	["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;


	/* ["A fire has been spotted! Check your map for the location!"] remoteExec ["A3PL_Lib_JobMsg", _fifr]; */
	uiSleep 600;
	missionNamespace setVariable ["FireCooldown",0,true];
	deleteMarker _marker;
}] call Server_Setup_Compile;
