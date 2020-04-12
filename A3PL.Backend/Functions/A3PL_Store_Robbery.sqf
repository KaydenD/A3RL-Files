["A3PL_Store_Robbery_RobStore",
{
	private ["_store","_cooldown","_success","_cops","_timeElapsed"];
	_store = param [0,objNull];
	_type = param [1,0];
	_cooldown = _store getVariable ["cooldown",[objNull,false]];
	
	//if last player disconnected there is a chance the cooldown timer was never reset
	if (isNull(_cooldown select 0)) then
	{
		_cooldown = [objNull,false];
	};
	
	//check if we are on cooldown
	if (_cooldown select 1) exitwith {["System: This store has been recently robbed",Color_Red] call A3PL_Player_Notification;};
	
	//check if we have a weapon to rob the store with
	if ((currentWeapon player) == "") exitwith {["System: You are not brandishing a weapon to rob this store with!",Color_Red] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["","A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow"]) exitwith {["System: You can't rob the store with this weapon! Nice try though :)",Color_Red] call A3PL_Player_Notification;};	

	//get array of cops on the server
	_cops = ["police"] call A3PL_Lib_FactionPlayers;
	
	//make sure there is atleast 3 police online before we can rob the store
	if ((count _cops) < 3) exitWith {["System: There need to be atleast 3 cops online to rob this store!", Color_Red] call A3PL_Player_Notification;};
	
	//robbing the store start
	["System: Attempting to rob this store, stay close to the cash register! - Cooldown reset in 3 mins", Color_Green] call A3PL_Player_Notification;
	["System Beware: You will receive double the reward if 5 or more cops are online!", Color_Green] call A3PL_Player_Notification;
	_success = true;
	_store setVariable ["cooldown",[player,true],true];
	Player_ActionCompleted = false;
	
	//Mark on map/sound alarm
	playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];
	[_store] remoteExec ["A3PL_Store_Robbery_Alert", _cops];

	["Robbing store...",28] spawn A3PL_Lib_LoadAction;
	_timeElapsed = 0;
	while {sleep 0.5; !Player_ActionCompleted } do
	{
		if ((player distance2D _store) > 4) exitWith {["System: You moved too far away from the cash register, this store robbery failed!", Color_Red] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;}; //inside a vehicle
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;}; //is incapacitated
		if (!alive player) exitwith {_success = false;}; //is no longer alive
		_timeElapsed = _timeElapsed + 0.5;
		if (_timeElapsed == 28) then {playSound3D ["A3PL_Common\effects\burglaralarm.ogg", _store, false, getPosASL _store, 1, 1, 200];}; //replay the sound
	};
  
	// All those exitWith's only exit the while loop..
	if (!_success) exitWith {_store setVariable ["cooldown",[objNull,false],true]; Player_ActionDoing = false;};
	
	//success!!
	["System: You successfully robbed this store!", Color_Green] call A3PL_Player_Notification;
	[_type] call A3PL_Store_Robbery_Reward;
	
	sleep 180;
	_store setVariable ["cooldown",nil,true];
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Reward",
{
	private ["_cops","_reward","_reward2","_type"];
	_type = param [0,0];

	//get amount of cops
	_cops = count(["police"] call A3PL_Lib_FactionPlayers);

	if(_type == 3) then 
	{ // diamonds
		_reward = 2+ceil((random _cops)*1.5); // min 2, max (cops_number*1.5)+2
		["diamond_tourmaline_ill",_reward] call A3PL_Inventory_add;
		[format ["System: You received %1 tourmaline diamond!",str(_reward)],Color_Green] call A3PL_Player_Notification;
	};

	if(_type == 2) then 
	{ // blueprints
		_reward = ceil(random _cops);
		if(_reward < 2) then {_reward = 2;}; // min glock reward = 2
		if(_reward > 6) then {_reward = 6;}; // max glock reward = 6

		_reward2 = ceil(random _cops);
		if(_reward2 < 4) then {_reward2 = 4;}; // min magazine reward = 2
		if(_reward2 > 15) then {_reward2 = 15;}; // max magazine reward = 15

		["Blueprint_Pistol_Illegal",_reward] call A3PL_Inventory_add;
		["Blueprint_Pistol_Ammo_Illegal",_reward2] call A3PL_Inventory_add;
		[format ["System: You received %1x glock blueprints and %2 glock magazines!",str(_reward),str(_reward2)],Color_Green] call A3PL_Player_Notification;
	};

	if(_type == 0) then 
	{ // shop
		//if less than 5 cops, we have a low reward
		if(_cops < 5) then 
		{
			_reward = 2000 + (round (random 3000));
			[format ["System: You robbed %1 from this store!",str(_reward)], Color_Green] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
		};
		
		//if 5 or more cops, we have a higher reward
		if(_cops > 4) then 
		{
			_reward = 4000 + (round (random 4000));
			[format ["System: You robbed %1 from this store!",str(_reward)], Color_Green] call A3PL_Player_Notification;
			player setVariable ["player_cash",((player getVariable ["player_cash",0]) + _reward),true];
		};
	};

}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Alert",
{
	private ["_store"];
	_store = param [0,objNull];
  
	[format ["A store is being robbed, it has been marked on your map. Store name: %1",_store],Color_Red] call A3PL_Player_Notification;
	[_store] spawn A3PL_Store_Robbery_Marker;
}] call Server_Setup_Compile;

["A3PL_Store_Robbery_Marker",
{
	private ["_store"];
	_store = param [0,objNull];
	
	//create marker
	_marker = createMarkerLocal [format ["store_robbery_%1",round (random 1000)],_store];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal "Alarm Triggered!";
	
	//wait 30 seconds and delete marker
	uiSleep 30;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;
