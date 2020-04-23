 ["A3RL_HouseRobbery_Rob", {
	_house = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {["You must have a lockpick to break into the house", Color_Red] call A3PL_Player_Notification;};
	//if ((count (["police"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 police officers on-duty to rob a house", Color_Red] call A3PL_Player_Notification;}; 
	if(_house getVariable ["robbing", false]) exitWith {["The house is already being robbed", Color_Red] call A3PL_Player_Notification;};

	_alarm = false;
	_random = random 100;
	if(_random < 5) then {
		_alarm = true;
		[_house] call A3RL_HouseRobbery_Alarm;
	};

	Player_ActionCompleted = false;
	["Lockpicking house door...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  

	uiSleep 2.0;
	while{!Player_ActionCompleted} do 
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player || !(vehicle player == player)};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionCanceled = true;};
		if (!alive player) exitWith {Player_ActionCanceled = true;};
		if (!(vehicle player == player)) exitWith {Player_ActionCanceled = true;};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	if (!(vehicle player == player)) exitWith {};

	["v_lockpick",1] call A3PL_Inventory_Remove;

	if(!_alarm) then { [_house] call A3RL_HouseRobbery_Alarm; };

	_random = random 100;
	if(_random > 70) exitWith { ["Your lockpick broke", Color_Red] call A3PL_Player_Notification; };

	_house setVariable ["unlocked", true, true];
	["You have successful broke into the house", Color_Green] call A3PL_Player_Notification;

	[_house] call A3RL_HouseRobbery_Reward; 
}] call Server_Setup_Compile;


["A3RL_HouseRobbery_Alarm", {
	_house = param[0, objNull];

	["police", format ["A house is being robbed! Check your gps for a location", _name]] spawn A3RL_Notify_Robbery;
	_cops = ["police"] call A3PL_Lib_FactionPlayers;

	[_house] remoteExec ["A3RL_HouseRobbery_Marker", _cops];
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Marker",
{
	private ["_house"];
	_house = param [0,objNull];
	
	//create marker
	_marker = createMarkerLocal [format ["house_robbery_%1",round (random 1000)],_house];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal "Alarm Triggered!";
	
	//wait 30 seconds and delete marker
	uiSleep 30;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;


["A3RL_HouseRobbery_Reward", {
	private ["_house"];
	_house = param [0,objNull];

	_box = createVehicle ["Land_MetalCase_01_large_F", [(getpos _house select 0),(getpos _house select 1),1], [], 0, "CAN_COLLIDE"];

	

	uiSleep 300;
	deleteVehicle _box;
}] call Server_Setup_Compile;

["A3RL_HouseRobbery_Secure", {
	_house = param[0, objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	Player_ActionCompleted = false;
	["Securing house door...",60] spawn A3PL_Lib_LoadAction;
	player playMoveNow "Acts_carFixingWheel";  
	[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  

	uiSleep 2.0;
	while{!Player_ActionCompleted} do 
	{
		waitUntil{(animationstate player) != "acts_carfixingwheel" || Player_ActionCompleted || player getVariable ["Incapacitated",false] || !alive player || !(vehicle player == player)};
		player switchMove "";
		player playMoveNow "Acts_carFixingWheel";
		[player, ""] remoteExec ["switchMove", clientOwner*-1];  
		[player, "Acts_carFixingWheel"] remoteExec ["playMoveNow", clientOwner*-1];  
		if (player getVariable ["Incapacitated",false]) exitwith {Player_ActionCanceled = true;};
		if (!alive player) exitWith {Player_ActionCanceled = true;};
		if (!(vehicle player == player)) exitWith {Player_ActionCanceled = true;};
		uiSleep 2.0;
	};
	player switchMove ""; 
	[player, ""] remoteExec ["switchMove", clientOwner*-1];  
	if (player getVariable ["Incapacitated",false]) exitwith {};
	if(!alive player) exitWith {};
	if (!(vehicle player == player)) exitWith {};

	_house setVariable ["unlocked", false, true];
	["The door has been secured", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;