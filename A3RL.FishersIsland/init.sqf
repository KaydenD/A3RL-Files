enableSaving [false,false];

if(isDedicated) exitWith {};
showChat false;
waitUntil{!(isNull player)};

player enableSimulation false;
[] spawn {
	waitUntil{uiSleep 0.05; (!isNil "A3PL_ServerLoaded")};
	waitUntil{uiSleep 0.05; A3PL_ServerLoaded};

	Player_Loaded = false;

	waitUntil {uiSleep 0.05; ((vehicle player) isEqualTo player)};
	waitUntil {uiSleep 0.05; !isNil "A3PL_Player_Initialize"};

	[] call A3PL_Player_TeamspeakID;
	[] call A3PL_Player_Initialize;
};