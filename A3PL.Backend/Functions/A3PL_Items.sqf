["A3PL_Items_Thirst",
{
	private ["_classname", "_quality", "_format"];

	_classname = Player_ItemClass;
	if (Player_ItemClass == "") exitwith
	{
		["System: Unable to retrieve class from item you are trying to drink",Color_Red] call A3PL_Player_Notification;
	};
	//get quality
	_quality = [_classname, "quality"] call A3PL_Config_GetThirst;
	if(_classname == "waterbottle") then {["waterbottlempty", 1] call A3PL_Inventory_Add;};
	if (!isNil "Player_isDrinking") exitwith
	{
		["You are already drinking something",Color_Red] call A3PL_Player_Notification;
	};
	if(_classname == "coke") then {A3RLFatigueFreeTimeLeft = 180; player enableFatigue false;};
	Player_isDrinking = true;

	//take items away
	[_classname, -1] call A3PL_Inventory_Add;

	//animation
	player playAction "Gesture_drink";
	Player_Item attachTo [player, [-0.03,0,0.1], 'LeftHand'];
	//Player_Item setVectorDirAndUp [[0,0,1],[1,0,0]];
	sleep 3;
	Player_Item setVectorDirAndUp [[0,0,-1],[0,-1,0]];
	sleep 3;
	Player_Item setVectorDirAndUp [[0,1,0],[0,0,1]];
	sleep 4.5;
	[false] call A3PL_Inventory_PutBack;

	//add vars
	Player_Thirst = Player_Thirst + _quality;
	[] call A3PL_Lib_VerifyThirst;
	profileNamespace setVariable ["player_thirst",Player_Thirst];
	Player_IsDrinking = nil;

	//reset warnings
	//Reset the warning variables for drinking
	if (Player_Thirst > 50) then { A3PL_ThirstWarning1 = Nil; };
	if (Player_Thirst > 20) then { A3PL_ThirstWarning2 = Nil; };
	if (Player_Thirst > 10) then { A3PL_ThirstWarning3 = Nil; };

	//msg
	_format = format["System: You drank a %1 and satisfied %2%3 of your thirst", [_classname, "name"] call A3PL_Config_GetItem, _quality,"%"];
	[_format, Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Items_Food",
{
	private ["_classname", "_quality", "_format"];

	_classname = Player_ItemClass;
	if (Player_ItemClass == "") exitwith
	{
		["System: Unable to retrieve class from item you are trying to eat",Color_Red] call A3PL_Player_Notification;
	};

	_quality = [_classname, "quality"] call A3PL_Config_GetFood;
	if (typeName _quality == "STRING") exitwith
	{
		[format ["System: There was an error retrieving the quality value of this food item, report this bug with itemclass: %1",_classname],Color_Red] call A3PL_Player_Notification;
	};

	if (!isNil "Player_isEating") exitwith
	{
		["You are already eating something",Color_Red] call A3PL_Player_Notification;
	};

	if (!([_classname,1] call A3PL_Inventory_Has)) exitwith
	{
		["System: Did you attempt to eat something you don't have?",Color_Red] call A3PL_Player_Notification;
	};

	Player_isEating = true;

	//close inventory dialog
	[0] call A3PL_Lib_CloseDialog;

	//play animation
	player playActionNow "gesture_eat";

	//remove the items from inventory
	[_classname, -1] call A3PL_Inventory_Add;

	//add hunger quality
	Player_Hunger = Player_Hunger + _quality;

	//verifiy that hunger does not go over 100
	[] call A3PL_Lib_VerifyHunger;

	//save in profilenamespace
	profileNamespace setVariable ["player_hunger",Player_Hunger];

	//display notification
	if (_quality > 0) then
	{
		_format = format["System: You ate a %1 and satisified %2%3 hunger", [_classname, "name"] call A3PL_Config_GetItem, _quality,"%"];
		[_format, Color_Green] call A3PL_Player_Notification;
	} else
	{
		_format = format["System: You were poisoned by eating a %1, your health points dropped by %2%3", [_classname, "name"] call A3PL_Config_GetItem,(-(_quality)),"%"];
		[_format, Color_Red] call A3PL_Player_Notification;
		_damage = ((getdammage player) + (- (_quality/100)));
		if (_damage >= 1) then
		{
			[] call A3PL_Medical_Kill;
			Player_Hunger = 20;
			profileNamespace setVariable ["player_hunger",Player_Hunger];
			A3PL_HungerWarning3 = Nil;
			A3PL_HungerWarning1 = Nil;
		} else
		{
			player setDammage ((getdammage player) + (- (_quality/100)));
		};
	};

	//Reset the warning variables for eating
	if (Player_Hunger > 50) then
	{
		A3PL_HungerWarning1 = Nil;
	};

	if (Player_Hunger > 20) then
	{
		A3PL_HungerWarning2 = Nil;
	};

	if (Player_Hunger > 10) then
	{
		A3PL_HungerWarning3 = Nil;
	};

	[] spawn
	{
		sleep 3;
		//remove item from your hand
		[false] call A3PL_Inventory_PutBack;
		Player_isEating = Nil;
	};

}] call Server_Setup_Compile;

["A3PL_Items_ThrowPopcornClient",
{
	private ["_remoteExecuteList"];

	if (!(player_itemclass == "popcornbucket")) exitwith {["System: You do not have a bucket of popcorn",Color_Red] call A3PL_Player_Notification;};

	//loop through players
	_remoteExecuteList = [];
	{
		if (player distance _x < 25) then
		{
			_remoteExecuteList pushback _x;
		};
	} foreach allPlayers;

	[[player],"A3PL_Items_ThrowPopcorn",_remoteExecuteList,false] call BIS_fnc_MP;
	player playaction "Gesture_throw";
}] call Server_Setup_Compile;

["A3PL_Items_ThrowPopcorn",
{
	if (isDedicated) exitwith {};
	private ["_playerVelocity","_playerDir","_player","_popcorn"];

	_player = param [0,objNull];
	if ((isNull _player) OR (!isPlayer _player)) exitwith {};

	//create a bunch of popcorn
	_popcorn = [];
	for "_i" from 0 to 15 do
	{
		_v = "A3PL_Popcorn" createVehicleLocal (getPos _player);
		_v attachTo [_player,[0,0,0],"RightHand"];
		_popcorn pushback _v;
	};

	//velocity of popcorn
	_playerVelocity = velocity _player;
	_playerDir = eyeDirection _player;
	_playerDir = (_playerDir select 0) atan2 (_playerDir select 1);
	{
		_dir = (_playerDir-20) + random 40;
		detach _x;
		_x setVelocity [((_playerVelocity select 0) + (sin _dir * 5)), ((_playerVelocity select 1) + (cos _dir * 5)), ((_playerVelocity select 2) + (2+random 3))];
	} foreach _popcorn;

	//delete all popcorn after 5 seconds
	uiSleep 5;
	{
		deleteVehicle _x;
	} foreach _popcorn;
}] call Server_Setup_Compile;

["A3PL_Items_GrabPopcorn",
{
	//first check if we already have popcorn
	if (["popcornbucket",1] call A3PL_Inventory_Has) then
	{
		["System: You already have a bucket of popcorn",Color_Red] call A3PL_Player_Notification;
	} else
	{
		[[player,"popcornbucket",1],"Server_Inventory_Add",false] call Bis_fnc_MP;
		["System: Send request to get popcorn, it should appear in your inventory",Color_Green] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;


["A3PL_Items_IgniteRocket",
{
	private ["_rocket","_color"];

	_rocket = param [0,objNull];
	if ((isPlayer (attachedTo _rocket)) && (!((attachedTo _rocket) isKindOf "Car"))) exitwith {["System: It looks like this rocket is attached to a player",Color_Red] call A3PL_Player_Notification;};
	if (!local _rocket) exitwith {["System Locality Exception: It looks like this rocket is not local to you, pick up and place again to fix this",Color_Red] call A3PL_Player_Notification;};
	if ((_rocket animationSourcePhase "fuse") > 0) exitwith {};
	_color = _rocket getVariable ["class","rocket_blue"];

	_rocket setVariable ["inUse",true,true];

	//ignite rocket fuse
	_rocket animateSource ["fuse",2];
	uiSleep 4;

	//rocket goes up
	[_rocket,_color] remoteExec ["A3PL_Items_RemoteRocket", -2]; // change to -2
	_rocket setVelocity [(-20 + (random 40)),(-20 + (random 40)),(50 + random 50)];

	//rocket reaches point of explosion
	uiSleep 3;
	deleteVehicle _rocket;
}] call Server_Setup_Compile;

["A3PL_Items_RemoteRocket",
{
	private ["_rocket","_color","_pos","_i","_r","_g","_b","_s1","_sparks"];

	_rocket = param [0,objNull];
	_color = param [1,"rocket_blue"];
	systemChat "run";
	//wait until the rocket is deleted, upon deletion we will do our fireworks :D
	_i = 0;
	_pos = getPos _rocket;
	waitUntil {_i = _i + 1; if (_i > 100) exitwith {true}; if (!isNull _rocket) then {_pos = getpos _rocket;}; sleep 0.1; isNull _rocket};
	if (_i > 100) exitwith {};

	_sparks = [];

	for "_ii" from 0 to 15 do
	{
		_s = "#particlesource" createVehicleLocal _pos;
		_sparks pushback _s;
	};

	_r = 0;
	_g = 0;
	_b = 1;

	switch (_color) do
	{
		case "rocket_blue": {_r = 0.02; _g = 0; _b =1};
		case "rocket_red": {_r = 1; _g = 0; _b = 0.02};
		case "rocket_green": {_r = 0.02; _g = 1; _b = 0};
		case "rocket_yellow": {_r = 0.95; _g = 0.95; _b = 0.05};
	};

	//lightpoint
	_lP = "#lightpoint" createVehiclelocal _pos;
	_lP setLightBrightness 30;
	_lP setLightDayLight true;
	_lP setLightAmbient [_r,_g,_b];
	_lP setLightColor [_r,_g,_b];

	//sound
	_logic = "Logic" createVehiclelocal _pos;
	_logic say3D [(["firework1","firework2","firework3"] call BIS_fnc_selectRandom), 1500, 1];

	{
		_vel = [(-10 + random 20),(-10 + random 20),(-10 + random 20)];
		_x setParticleCircle [0, [0, 0, 30]];
		_x setParticleRandom [0.5, [0, 0, 0], [0, 0, 0], 0, 0.5, [_r,_g,_b, 1], 1, 0];
		_x setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], _vel, 0, 70, 0, 0, [0.5,1], [[_r,_g,_b, 1],[_r,_g,_b, 0.5]], [0.08], 1, 0, "", "",_x];
		_x setDropInterval 0.01;
	} foreach _sparks;

	uisleep 1;

	//main
	_pS = "#particlesource" createVehicleLocal [(_pos select 0),(_pos select 1),((_pos select 2) + random 10)];
	_xx = [-7,7] call BIS_fnc_selectRandom;
	_yy = [-5,7] call BIS_fnc_selectRandom;
	_zz = [-8,5] call BIS_fnc_selectRandom;
	_pS setParticleCircle [0, [_xx, _yy, _zz]];
	_pS setParticleRandom [0, [0, 0, 0], [_xx, _yy, _zz], 0, 0.5, [_r,_g,_b, 1], 1, 0];
	_pS setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 1.5, [0, 0, 0], [_xx, _yy, _zz], 0, 50, 0, 0, [0.5,1], [[_r, _g,_b, 1],[_r, _g, _b, 0.5]], [0.08], 1, 0, "", "",_pS];
	_pS setDropInterval 0.0005;


	uiSleep 1;
	deleteVehicle _pS;
	{
		deleteVehicle _x;
	} foreach _sparks;

	uiSleep 3;
	deleteVehicle _lP;
	deleteVehicle _logic;
}] call Server_Setup_Compile;

["A3PL_Items_FillBottle",
{
	private ["_classname"];
	_classname = Player_ItemClass;
	
	if(_classname != "waterbottlempty") exitwith {
		["System: You do not have an empty bottle in hand!",Color_Red] call A3PL_Player_Notification;
	};
	if (!([_classname,1] call A3PL_Inventory_Has)) exitwith {
		["System: You do not have an empty bottle in hand!",Color_Red] call A3PL_Player_Notification;
	};
	//remove the item from inventory
	[_classname, -1] call A3PL_Inventory_Add;
	["waterbottle", 1] call A3PL_Inventory_Add;
	[false] call A3PL_Inventory_PutBack;
}] call Server_Setup_Compile;
