//setup the loops that will run
['A3PL_Loop_Setup', {
	//give paycheck every 60 minutes (can be changed) - player must then go pick it up
	["itemAdd", ["Loop_LockView", {[] spawn A3PL_Loop_LockView;}, 0.25, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_RoadSigns", {[] spawn A3PL_Loop_RoadSigns;}, 0.5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Paycheck", {[] spawn A3PL_Loop_Paycheck;}, 60, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_PlayTime", {[] spawn A3PL_Loop_PlayTime;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_HUD", {[] spawn A3PL_HUD_Loop;}, 1, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Hunger", {[] spawn A3PL_Loop_Hunger;}, 960, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_Thirst", {[] spawn A3PL_Loop_Thirst;}, 380, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["A3PL_BowlingAmbient", {{_x say3D "BowlingAmbient"} foreach A3PL_BowlingAlleys}, 120]] call BIS_fnc_loop; //bowling alley sounds

	//create array for A3PL_Player_DrawText
	["itemAdd", ["Loop_NameTags", {[] spawn A3PL_Player_NameTags;}, 0.5, 'seconds']] call BIS_fnc_loop;
	["itemAdd", ["Loop_BusinessTags", {[] spawn A3PL_Player_BusinessTags;}, 1, 'seconds']] call BIS_fnc_loop;

	//for roadworker markers
	["itemAdd", ["Loop_RoadworkerMarkers", {[] spawn A3PL_JobRoadWorker_MarkerLoop;}, 5, 'seconds']] call BIS_fnc_loop;

	//medical system
	["itemAdd", ["Loop_Medical", {[] spawn A3PL_Medical_Loop;}, 3, 'seconds']] call BIS_fnc_loop;

	//GPS system for FIFR/SD/USCG
	["itemAdd", ["Loop_GPS", {[] spawn A3PL_Police_GPS;}, 2, 'seconds']] call BIS_fnc_loop;

	//Drugs system
	["itemAdd", ["Drugs_Loop", {[false] spawn A3PL_Drugs_Loop;}, 60, 'seconds']] call BIS_fnc_loop;


	["itemAdd", ["Loop_Fatigue", {[] spawn A3RL_Fatigue_Handler;}, 5, 'seconds']] call BIS_fnc_loop;
	//halloween loops
	// ["itemAdd", ["Hw_angel_loop", {[] spawn A3PL_Halloween_Randomiser;}, 30, 'seconds']] call BIS_fnc_loop;

}] call Server_Setup_Compile;

["A3RL_Fatigue_Handler",
{
	if (isNil "A3RLFatigueFreeTimeLeft" || {A3RLFatigueFreeTimeLeft < 0}) then {A3RLFatigueFreeTimeLeft = 0;};
	
	if(A3RLFatigueFreeTimeLeft > 0) exitWith {
		player enableFatigue false;
		A3RLFatigueFreeTimeLeft = A3RLFatigueFreeTimeLeft - 5;
	};
	player enableFatigue true;
}] call Server_Setup_Compile;

["A3PL_Loop_RoadSigns",
{
	disableSerialization;
	if(vehicle player != player) then {
		if(isNil "A3PL_Last_Road") then {A3PL_Last_Road = "";};
		if(isNil "A3PL_Last_RoadID") then {A3PL_Last_RoadID = 0;};

		_roadObject = str (roadAt (vehicle player));
		_roadID = parseNumber (( _roadObject splitString ":" ) select 0);

		if(A3PL_Last_RoadID != _roadID) then {
			A3PL_Last_RoadID = _roadID;
			_title = "";

			{
				_a = _x select 0;
				_b = _x select 1;

				if(_a < _b) then {
					if(_roadID >= _a && _roadID <= _b) exitWith {
						_title = _x select 2;
					};
				} else {
					if(_roadID >= _b && _roadID <= _a) exitWith {
						_title = _x select 2;
					};
				};
			} forEach roadDB;

			if(_title != "") then {
				if(_title != A3PL_Last_Road) then {
					A3PL_Last_Road = _title;
					[] spawn {
						disableSerialization;
						_road = A3PL_Last_Road;

						_display = uiNamespace getVariable "A3PL_HUDDisplay";
						_ctrl = _display displayCtrl 9520;
						_ctrlBack = _display displayCtrl 9521;

						_ctrl ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center' size='3' >%1</t>",_road];
						_ctrl ctrlSetFade 0;
						_ctrl ctrlCommit 0.5;

						_ctrlBack ctrlSetFade 0;
						_ctrlBack ctrlCommit 0.5;

						uiSleep 3.5;

						if(_road != A3PL_Last_Road) exitWith {};

						_ctrl ctrlSetFade 1;
						_ctrl ctrlCommit 0.5;
						_ctrlBack ctrlSetFade 1;
						_ctrlBack ctrlCommit 0.5;
					};
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_Loop_LockView",
{
	if(player getVariable ["A3RL_Blindfolded", false] && (cameraView == "EXTERNAL")) exitWith {player switchCamera "INTERNAL";};

	if(Player_LockView && (!(player getVariable["pVar_RedNameOn",false]))) then {

		if((cameraView == "EXTERNAL") && (vehicle player == player)) then {
			player switchCamera "INTERNAL";
		};

		if(Player_LockView_Time <= time) then {
			Player_LockView = false;
		};
	};
}] call Server_Setup_Compile;

//add paycheck money - players have to pick it up from the bank
["A3PL_Loop_Paycheck",
{
	private ["_job", "_payment", "_directDeposit"];

	Player_PayCheckTime = Player_PayCheckTime + 1;
	if (Player_PayCheckTime >= 20) then
	{
		call A3RL_Gang_CapturedPaycheck;
		if(player getVariable ["job","unemployed"] in ["police", "usms", "fifr", "uscg", "doj", "dao", "pdo", "faa", "dmv", "dispatch", "gov"]) then {
			[player] remoteExec ["Server_FactionManagment_HandlePayCheck", 2];
		} else {
			player setVariable["Player_Paycheck", ((player getVariable ["Player_Paycheck", 0]) + 250), true];
			["I have received a paycheck, I have to go to the bank to pick it up", Color_Green] call A3PL_Player_Notification;
		};
		Player_PayCheckTime = 0;
	};
	profileNameSpace setVariable ["Player_PayCheckTime",Player_PayCheckTime];
}] call Server_Setup_Compile;

//add second to player's playtime every 1 second
["A3PL_Loop_PlayTime",
{
	Player_PlayTime = Player_PlayTime + 1;
}] call Server_Setup_Compile;

//reduce hunger every loop
["A3PL_Loop_Hunger",
{
	private ["_amount"];

	_amount = round(random(3));

	//Don't continue hunger if we're jailed.
	if(player getVariable ["jailed",false]) exitWith {};

	//popcorn eating
	if (player_ItemClass == "popcornbucket") exitwith
	{
		A3PL_EatingPopcorn = true;
		Player_Item attachTo [player,[0,0,0],"RightHand"];
		player playActionNow "gesture_eat";
		[] spawn
		{
			uisleep 4;
			A3PL_EatingPopcorn = Nil;
		};
	};

	Player_Hunger = Player_Hunger - _amount;

	if ((Player_Hunger >= 45) && (Player_Hunger <= 50) && (isNil "A3PL_HungerWarning1") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning1 = true;
		["I am starting to feel hungry", Color_Yellow] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 15) && (Player_Hunger <= 20) && (isNil "A3PL_HungerWarning2") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning2 = true;
		["I am really hungry now, I should really eat something", Color_Red] call A3PL_Player_Notification;
	};

	if ((Player_Hunger >= 5) && (Player_Hunger <= 10) && (isNil "A3PL_HungerWarning3") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_HungerWarning3 = true;
		["I might pass out if I don't eat something soon", Color_Red] call A3PL_Player_Notification;
	};

	[] call A3PL_Lib_VerifyHunger;
	profileNamespace setVariable ["player_hunger",Player_Hunger];

	if (Player_Hunger <= 0) then
	{
		private ["_effect"];
		profileNamespace setVariable ["player_hunger",Player_Hunger];
		A3PL_HungerWarning3 = Nil;
		A3PL_HungerWarning1 = Nil;

		if (!isNil "A3PL_HungerEmpty") exitwith {};
		[] spawn
		{
			A3PL_HungerEmpty = true;
			_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			["System: I am really hungry now and my vision is getting blurry. I should really eat something!!!"] call A3PL_Player_Notification;
			while {Player_Hunger <= 0} do
			{
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_HungerEmpty = nil;
			_effect ppEffectEnable false;
			ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;

//reduce thirst every loop
["A3PL_Loop_Thirst",
{
	private ["_amount"];
	_amount = round(random(2));

	if(player getVariable ["jailed",false]) exitWith {}; //if jailed don't continue

	Player_Thirst = Player_Thirst - _amount;
	[] call A3PL_Lib_VerifyThirst;

	if ((Player_Thirst >= 45) && (Player_Thirst <= 50) && (isNil "A3PL_ThirstWarning1") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning1 = true;
		["I am starting to feel thirsty", Color_Yellow] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 15) && (Player_Thirst <= 20) && (isNil "A3PL_ThirstWarning2") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning2 = true;
		["I am really thirsty now, I should really drink something", Color_Red] call A3PL_Player_Notification;
	};

	if ((Player_Thirst >= 5) && (Player_Thirst <= 10) && (isNil "A3PL_ThirstWarning3") && (!(player getVariable ["Incapacitated",false]))) then
	{
		A3PL_ThirstWarning3 = true;
		["I might pass out if I don't drink something soon", Color_Red] call A3PL_Player_Notification;
	};

	if (Player_Thirst <= 0) then
	{
		private ["_effect"];
		profileNamespace setVariable ["player_thirst",Player_Thirst];
		A3PL_ThirstWarning3 = Nil;
		A3PL_ThirstWarning1 = Nil;

		if (!isNil "A3PL_ThirstEmpty") exitwith {};
		[] spawn
		{
			A3PL_ThirstEmpty = true;
			//_effect = ["DynamicBlur",[2]] call A3PL_Lib_PPEffect;
			["System: I am really thirsty now, I can't run anymore because I'm dehydrated"] call A3PL_Player_Notification;
			while {Player_Thirst <= 0} do
			{
				uiSleep 1;
				player setStamina 0;
			};
			A3PL_ThirstEmpty = nil;
			//_effect ppEffectEnable false;
			//ppEffectDestroy _effect;
		};
	};
}] call Server_Setup_Compile;
