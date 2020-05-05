enableSaving [false,false];

if(isDedicated) exitWith {};
showChat false;
waitUntil{!(isNull player)};

// Freeze player
player enableSimulation false;

[] spawn
{
	waitUntil{sleep 0.05; (!isNil "A3PL_ServerLoaded")};
	waitUntil{sleep 0.05; A3PL_ServerLoaded};

	Player_Loaded = false;

	waitUntil {sleep 0.05; ((vehicle player) isEqualTo player)};
	waitUntil {sleep 0.05; !isNil "A3PL_Player_Initialize"};

	[] call A3PL_Player_Initialize;
};