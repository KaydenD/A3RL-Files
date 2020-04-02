['A3PL_Criminal_Ziptie', {
	private ['_obj'];
	_obj = _this select 0;

	//1 No hands up
	//2 Hands up
	//3 Kneeled hands up
	//4 Kneeled
	//5 Prone
	//5 unconscious
	_Cuffed = _obj getVariable ["Zipped",true];
	if (animationState _obj IN ["amovpercmstpsnonwnondnon","amovpercmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpercmstpsraswlnrdnon"]) exitwith
	{
		[[player,_obj,1],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

	if (animationState _obj == "a3pl_idletohandsup") exitwith
	{
		[[player,_obj,2],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

	if (animationState _obj == "a3pl_handsuptokneel") exitwith
	{
		[[player,_obj,3],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

	if (animationState _obj IN ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon"]) exitwith
	{
		[[player,_obj,4],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

	if (animationState _obj IN ["amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon"]) exitwith
	{
		[[player,_obj,5],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

	if (animationState _obj == "unconscious") exitwith
	{
		[[player,_obj,5],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["zipties", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Zipped",Nil,true];
	};

}] call Server_Setup_Compile;


['A3PL_Criminal_Unzip', {
	private ['_obj'];
	_obj = _this select 0;

	//7 Uncuff
	_Zipped = _obj getVariable ["Zipped",true];
	if ((animationState _obj IN ["a3pl_handsuptokneel"])&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Zipped",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelkicked")&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Zipped",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelcuffed")&&(_Zipped)) exitwith
	{
		["zipties",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Zipped",false,true];
	};

}] call Server_Setup_Compile;

["A3PL_Criminal_RemoveTime",{
	if (1000 > (player getVariable ["player_cash",0])) exitwith {[localize "STR_A3PL_CRIMINAL_NOMONEY"] call A3PL_Player_notification;};
	if(!(player getVariable "jailed")) exitwith {[localize "STR_A3PL_CRIMINAL_NOJAIL"] call A3PL_Player_notification;};
	player setVariable ["jailed",false,true];
	player setVariable ["jailtime",null,true];

	[player] remoteExec ["Server_Criminal_RemoveJail", 2];


	player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 1000,true];

	[localize "STR_A3PL_CRIMINAL_TRACKERREMOVE"] call A3PL_Player_notification;

}] call Server_Setup_Compile;

["A3PL_Criminal_Work", {

	if (animationstate player == "Acts_carFixingWheel") exitwith {[localize "STR_A3PL_CRIMINAL_CANTWORK", Color_Red] call A3PL_Player_Notification;};
	if (player getVariable ["working",true]) exitwith {[localize "STR_A3PL_CRIMINAL_CANTWORK", Color_Red] call A3PL_Player_Notification;};

	[localize "STR_A3PL_CRIMINAL_STARTWORK", Color_Yellow] call A3PL_Player_Notification;

	player setVariable ["working",true,true];

	Player_ActionCompleted = false;

	["Manufacturing license plates...",60] spawn A3PL_Lib_LoadAction;
	player playmove "Acts_carFixingWheel";
	while {sleep 1; !Player_ActionCompleted } do
	{
		if (animationstate player != "Acts_carFixingWheel") then {
			player playmove "Acts_carFixingWheel";
		};
		if (!(vehicle player == player)) exitwith {}; //inside a vehicle
		if (player getVariable ["Incapacitated",false]) exitwith {}; //is incapacitated
		if (!alive player) exitwith {}; //is no longer alive
	};
	player playmove "";

		_chance = selectRandom[1,2];
		if(_chance == 2) then {
			_time = player getVariable "jailtime";
			_newTime = _time - 1;
			[localize "STR_A3PL_CRIMINAL_LOWERED", Color_Green] call A3PL_Player_Notification;
			[_newTime, player] remoteExec ["Server_Police_JailPlayer",2];
		};
		[localize "STR_A3PL_CRIMINAL_FINISHEDWORK", Color_Green] call A3PL_Player_Notification;
		player setVariable ["working",false,true];

	}] call Server_Setup_Compile;

	["A3PL_Criminal_PickCar", {
			private ["_car"];
			_car = param [0,objNull];


			if (animationstate player == "Acts_carFixingWheel") exitwith {[localize "STR_A3PL_CRIMINAL_PERFORMING", Color_Red] call A3PL_Player_Notification;};
			if (!(vehicle player == player)) exitwith {[localize "STR_A3PL_CRIMINAL_INSIDECAR", Color_Red] call A3PL_Player_Notification;};
			if (player getVariable ["picking",true]) exitwith {[localize "STR_A3PL_CRIMINAL_ALREADYPICK", Color_Red] call A3PL_Player_Notification;};
			if ((count (["police"] call A3PL_Lib_FactionPlayers)) < 2) exitWith {["System: There need to be atleast 2 cops online to lock pick this vehicle!", Color_Red] call A3PL_Player_Notification;};

			player playmove "Acts_carFixingWheel";
			[localize "STR_A3PL_CRIMINAL_STARTRPICK", Color_Yellow] call A3PL_Player_Notification;
			player setVariable ["picking",true,true];
			["Attempting to lockpick vehicle...",44] spawn A3PL_Lib_LoadAction;

			[_car] spawn
			{
				private ["_t","_c","_car","_s"];
				_car = param [0,objNull];
				_t = 60; //seconds it takes to repair
				_c = 0; //countdown
				_s = false; //succeed?
				while {player getVariable ["picking",false]} do
				{
					if (animationstate player != "Acts_carFixingWheel") then {
						player playmove "Acts_carFixingWheel";
					};
					_c = _c + 1;
					if (!(vehicle player == player)) exitwith {}; //inside a vehicle
					if ((player distance _car) > 9) exitwith {[localize "STR_A3PL_CRIMINAL_DISTANCE", Color_Red] call A3PL_Player_Notification;}; //too far away
					if (player getVariable ["Incapacitated",false]) exitwith {}; //is incapacitated
					if (!alive player) exitwith {}; //is no longer alive
					if (!alive _car) exitwith {}; //car is no longer alive
					if (!(player_itemClass == "v_lockpick")) exitwith {}; //not carrying lockpick anymore
					if (!(["v_lockpick",1] call A3PL_Inventory_Has)) exitwith {}; //doesn't have a lockpick in inventory array anymore


					if (_c >= _t) exitwith {_s = true;}; //if _c reaches _t we exit the loop and set _s to true
					uiSleep 1;
				};
				player switchMove "";
				player setVariable ["picking",false,true];
				if (!_s) exitwith
				{
					[localize "STR_A3PL_CRIMINAL_LOCKFAIL", Color_Red] call A3PL_Player_Notification;

					if (vehicle player == player) then
					{
						player switchMove "";
					};
				};

			_chance = selectRandom[1];  // 50% chance of success
			[player_item] call A3PL_Inventory_Clear;
			[[player,"v_lockpick",-1],"Server_Inventory_Add",false,false] call BIS_FNC_MP;
			if(_chance == 1) then {
				_car setVariable ["locked",false,true];
				[localize "STR_A3PL_CRIMINAL_LOCKSUCCESS", Color_Green] call A3PL_Player_Notification;
			} else {
				[localize "STR_A3PL_CRIMINAL_LOCKFAIL", Color_Red] call A3PL_Player_Notification;
				_y = 20;
				while {_y > 0} do {

				playSound3D ["A3\Sounds_F\sfx\alarmCar.wss", _car, true, _car, 3, 1, 100];
				uiSleep 2;
				_y = _y - 1;
				};

			};
		};
		}] call Server_Setup_Compile;


	["A3PL_Criminal_MafiaStart",
	{
		if(!([] call A3PL_Player_AntiSpam)) exitWith {};
		if ((player getVariable ["job","unemployed"]) == "mafia") exitwith {[localize "STR_A3PL_CRIMINAL_MAFIASTOP",Color_Red]; [] call A3PL_NPC_LeaveJob};
		player setVariable ["job","mafia"];
		[localize "STR_A3PL_CRIMINAL_MAFIASTART",Color_Green] call A3PL_Player_Notification;
	}] call Server_Setup_Compile;

	["A3PL_Criminal_CartelStart",
	{
		if(!([] call A3PL_Player_AntiSpam)) exitWith {};
		if ((player getVariable ["job","unemployed"]) == "cartel") exitwith {[localize "STR_A3PL_CRIMINAL_CARTELSTOP",Color_Red]; [] call A3PL_NPC_LeaveJob};
		player setVariable ["job","cartel"];
		[localize "STR_A3PL_CRIMINAL_CARTELSTART",Color_Green] call A3PL_Player_Notification;
	}] call Server_Setup_Compile;
