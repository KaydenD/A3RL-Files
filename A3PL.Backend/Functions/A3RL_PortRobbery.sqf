Config_PortRobbery_Reward = [
	//Item Class, Amount, IE, Steel, WEP, chance
	["", 2, true,true,true,5]
];

/*
	TODO: 
	CoolDown
	Distance Walk Away
	Npc Interaction

*/

["A3RL_PortRobbery_Rob",{
	_port = param[0, objNull];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	//if ((count (["uscg"] call A3PL_Lib_FactionPlayers)) < 3) exitWith {["There must be 3 USCG on-duty to rob the port!", Color_Red] call A3PL_Player_Notification;}; 
	if(!(currentWeapon player != "")) exitWith {["You must have a weapon to rob the port", Color_Red] call A3PL_Player_Notification;};
	_name = "Invaild Port";

	//Get Port Name
	switch(_port) do 
	{ 
		case portrobbery_IE: {_name = "Import/Export"; };
		case portrobbery_Steel: {_name = "Steel Mill"; };
		case portrobbery_Wep: {_name = "Weapons Factory"; };
	};

	["uscg", format ["!!! ALERT !!! The %1 is being robbed!", _name]] spawn A3RL_Notify_Robbery;

	Player_ActionCompleted = false;
	["Robbing the port...",60] spawn A3PL_Lib_LoadAction;
	["Stay within 30 feet of the port worker or the robbery will fail", Color_Red] call A3PL_Player_Notification;

	_success = true;
	while{Player_ActionDoing} do {
		if((player distance2D _port) > 3) exitWith {["You walked to far away from the port worker!", "red"] call A3PL_Player_Notification; _success = false; };
		if(!((vehicle player) == player)) exitWith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(Player_ActionInterrupted || !_success) exitWith {Player_ActionInterrupted = true;};

	["You have successful robbed the port!", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

/*
["A3RL_PortRobbery_GetReward", {
	_port = _this select 0;
	_portNumber = 0;
	
	_reward = [];
	_count = 0;

	switch(_port) do 
	{
		case portrobbery_IE: {_portNumber = 3};
		case portrobbery_Steel: {_portNumber = 4};
		case portrobbery_Wep: {_portNumber = 5};
	};

	{
		if(_x select _portNumber) then {
			
		};
	} forEach Config_PortRobbery_Reward;
}] call Server_Setup_Compile;
*/