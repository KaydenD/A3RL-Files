// check for ccp license
// spawn the truck
// see map that tells you one location where there is targets to take out, rabbits, snakes, chickens
// kill targets and get money

/*
	player setVariable ["faction","doj",true];
	[] call A3PL_DMV_Open;

	player addWeapon "hgun_P07_F";
	player addMagazine "16Rnd_9x21_Mag";
	player addMagazine "16Rnd_9x21_Mag";
*/

["A3PL_Exterminator_Start",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_mask"];
	if (!(["ccp"] call A3PL_DMV_Check)) exitwith {["System: You do not have a CPP license, a CCP license is required for this job!"] call A3PL_Player_Notification;};
	if ((player getVariable ["job","unemployed"]) == "extermy") exitwith {["System: You stopped working for The Great Ratsby!",Color_Red]; [] call A3PL_NPC_LeaveJob};
	if (handgunWeapon player == "") exitwith {["System: You are not carrying a weapon, you need to equip a pistol to start this job!"] call A3PL_Player_Notification;};

	player setVariable ["job","extermy"];
	["System: Welcome to The Great Ratsby!",Color_Green] call A3PL_Player_Notification;
	["System: Go take your truck and check the map for your destination, take care of the pest and you will be rewarded!",Color_Green] call A3PL_Player_Notification;

	//player addUniform "A3PL_Exterminator_Uniform";
	["A3PL_Exterminator_Uniform"] call A3PL_Lib_ChangeUniformSafe;
	//player addgoggles "A3PL_FD_Mask";
	["A3PL_FD_Mask"] call A3PL_Lib_ChangeGoggles;
	_mask = createVehicle ["A3PL_FD_Mask_Obj", getpos player, [], 0, "CAN_COLLIDE"];
	_mask attachto [player,[-0.12,-0.15,-0.73],"RightHand"];
	player playaction "gesture_maskon";
	[_mask] spawn
	{
		sleep 2.5;
		deleteVehicle (param [0,objNull]);
	};

	["A3PL_Mailtruck",[6045.44,7506.83,0],"EXTERMY",1800] spawn A3PL_Lib_JobVehicle_Assign;
	[] call A3PL_Exterminator_PestStart;
}] call Server_Setup_Compile;

["A3PL_Exterminator_PestStart",
{
	private ["_houses","_animals"];
	//check if animals already exist
	_animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	if ((count _animals) >= 4) exitwith {[] spawn A3PL_Exterminator_Loop;};

	//spawn pest
	[] call A3PL_Exterminator_SpawnPest;

	//run loop
	[] spawn A3PL_Exterminator_Loop;
}] call Server_Setup_Compile;

["A3PL_Exterminator_SpawnPest",
{
	private ["_animals","_random","_animal","_animalType","_pos","_houses"];
	_animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	{deleteVehicle _x} foreach _animals;

	//find pos for the pest
	_houses = nearestObjects [[7661.16,6609.34,0], ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_modernhouse1", "Land_A3RL_modernhouse4","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2"], 6000,true];
	_pos = getpos (_houses select (floor(random ((count _houses)-1))));
	if (isNil "_pos") exitwith {[] call A3PL_Exterminator_SpawnPest;}; //if selection failed

	//check what animal to spawn
	_animalType = "Rabbit_F";

	//spawn the animals
	A3PL_Exterminator_PestAnimals = [];
	for "_i" from 0 to (8 + (round (random 2))) do
	{
		/*
			_civ = createGroup civilian;
			_animal = _civ createUnit ["Snake_random_F",_pos,[],20,"NONE"];
		*/
		_animal = createAgent [_animalType, _pos, [], 25, "NONE"];
		A3PL_Exterminator_PestAnimals pushback _animal;
	};
	publicVariable "A3PL_Exterminator_PestAnimals";
}] call Server_Setup_Compile;

["A3PL_Exterminator_Loop",
{
	private ["_animals"];
	_animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
	[_animals] call A3PL_Exterminator_KillEH;
	while {(player getVariable ["job","unemployed"]) == "extermy"} do
	{
		private ["_markers","_marker"];
		_animals = missionNameSpace getVariable ["A3PL_Exterminator_PestAnimals",[]];
		_markers = [];
		{
			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],getpos _x];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorRed";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal "Exterminate this animal!";
			_markers pushback _marker;
		} foreach _animals;

		//replace markers
		{ deleteMarkerLocal _x; } foreach (missionNameSpace getVariable ["A3PL_Exterminator_Markers",[]]);
		A3PL_Exterminator_Markers = _markers;

		uiSleep 2;
	};

	//delete all markers if we change job
	{ deleteMarkerLocal _x; } foreach A3PL_Exterminator_Markers;

}] call Server_Setup_Compile;

["A3PL_Exterminator_KillEH",
{
	private ["_animals"];
	_animals = param [0,[]];
	{
		_x removeAllEventHandlers "killed"; //remove previous added eventhandlers first
		_x addEventHandler ["killed",
		{
			if ((param [2,objNull]) == player) then //check if we killed the player
			{
				private ["_animal"];
				_animal = param [0,objNull];

				//get money and remove animal
				["System: You killed one of the animals and earned $300",Color_Green] call A3PL_Player_Notification;
				player setVariable ["player_cash",(player getVariable ["player_cash",0])+300,true];
				A3PL_Exterminator_PestAnimals = A3PL_Exterminator_PestAnimals - [_animal];
				publicVariable "A3PL_Exterminator_PestAnimals";
				deleteVehicle _animal;
				deleteVehicle _animal;

				//spawn new animals if this pest is under control
				if (count A3PL_Exterminator_PestAnimals <= 4) then
				{
					[] call A3PL_Exterminator_PestStart;
					["System: It looks like this pest is under control, check your map for a new location!",Color_Green] call A3PL_Player_Notification;
				};
			};
		}];
	} foreach _animals;
}] call Server_Setup_Compile;
