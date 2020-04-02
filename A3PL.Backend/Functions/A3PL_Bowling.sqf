#define DEFAULTVAR [[],[],[],[],[],[]]
['A3PL_Bowling_Init', {
	bowling = (nearestObjects [[2686.35,5576.4,0],["Land_Karmalanes"],20000]) select 0;
}] call Server_Setup_Compile;

['A3PL_Bowling_Attached', {
	private["_ball"];

	_ball = _this select 0;

	_typeof = typeof _ball;
	[_ball,_typeof] spawn {
		private ["_veh","_ballDeleted","_typeof"];

		_veh = _this select 0;
		_typeof = _this select 1;
		_ballDeleted = false;

		while {(_veh IN (attachedObjects player)) OR (_ballDeleted)} do
		{
			if ((!(vehicle player == player)) && (!(_ballDeleted))) then
			{
				if (((typeof _veh) IN ["A3PL_Package"]) OR ((typeof _veh) IN A3PL_CratesAndFurniture) OR ((typeof _veh) IN A3PL_WeaponCrates)) then
				{
					detach _veh;
					_veh setpos (getpos _veh);
				} else
				{
					detach _veh;
					deleteVehicle _veh;
					_ballDeleted = true;
				};
			};

			if ((_ballDeleted) && (vehicle player == player)) then
			{
				_veh = _typeof createvehicle (getpos player);

				_veh setVariable ["pickup",false,true];

				_veh attachto [player, [0.035,-.11,-0.1], "RightHandMiddle1"];

				_veh setdir (getdir player + 180);
				_veh setpos (getpos _veh);

				_ballDeleted = false;
			};

			if (!(alive player)) exitwith {detach _veh;};
			sleep 0.1;
		};

		if (_veh IN (attachedobjects player)) then
		{
			detach _veh;
		};
		_veh setVariable ["pickup",true,true];
	};
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BOpen', {
	private ["_display","_var","_controlLB","_controlR","_controlK"];
	disableserialization;
	closeDialog 0;
	createDialog "A3PL_BowlingRegister";
	_display = findDisplay 10;
	_var = bowling getVariable ["registrations",DEFAULTVAR];
	_controlLB = [_display displayCtrl 1500,_display displayCtrl 1501,_display displayCtrl 1502,_display displayCtrl 1503,_display displayCtrl 1504,_display displayCtrl 1505];
	_controlR = [_display displayCtrl 1600,_display displayCtrl 1604,_display displayCtrl 1608,_display displayCtrl 1602,_display displayCtrl 1606,_display displayCtrl 1610];
	_controlK = [_display displayCtrl 1612,_display displayCtrl 1613,_display displayCtrl 1614,_display displayCtrl 1615,_display displayCtrl 1616,_display displayCtrl 1617];

	{
		_x ctrlEnable false;
	} foreach _controlK;

	{
		(_controlLB select _forEachIndex) lbAdd "Nobody";
	} foreach _var;

	{
		private ["_a"];
		_a = _forEachIndex;

		if ((count _x) > 0) then
		{
			lbClear (_controlLB select _a);
		};

		{
			(_controlLB select _a) lbAdd _x;
			if (name player == _x) then
			{
				if (_forEachIndex == 0) then
				{
					(_controlK select _a) ctrlEnable true;
				};

			};
		} foreach _x;
	} foreach _var;
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BRefresh', {

	private ["_display","_var","_controlLB","_controlR","_controlK"];
	disableserialization;
	_display = findDisplay 10;

	_var = bowling getVariable ["registrations",DEFAULTVAR];
	_controlLB = [_display displayCtrl 1500,_display displayCtrl 1501,_display displayCtrl 1502,_display displayCtrl 1503,_display displayCtrl 1504,_display displayCtrl 1505];
	_controlR = [_display displayCtrl 1600,_display displayCtrl 1604,_display displayCtrl 1608,_display displayCtrl 1602,_display displayCtrl 1606,_display displayCtrl 1610];
	_controlK = [_display displayCtrl 1612,_display displayCtrl 1613,_display displayCtrl 1614,_display displayCtrl 1615,_display displayCtrl 1616,_display displayCtrl 1617];

	{
		_x ctrlEnable false;
	} foreach _controlK;

	{
		lbClear (_controlLB select _forEachIndex);
		(_controlLB select _forEachIndex) lbAdd "Nobody";
	} foreach _var;

	{
		private ["_a"];
		_a = _forEachIndex;

		if ((count _x) > 0) then
		{
			lbClear (_controlLB select _a);
		};

		{
			(_controlLB select _a) lbAdd _x;
			if (name player == _x) then
			{
				if (_forEachIndex == 0) then
				{
					(_controlK select _a) ctrlEnable true;
				};
			};
		} foreach _x;
	} foreach _var;

}, false] call Server_Setup_Compile;

['A3PL_Bowling_BReg', {
	private ["_var","_lane","_name","_allVar","_indexFind","_found"];
	_name = _this select 0;
	_lane = _this select 1;

	_allVar = bowling getVariable ["registrations",DEFAULTVAR];
	_var = _allVar select (_lane - 1);
	_found = false;

	{
		if ((_x find _name) > -1) then
		{
			_found = true;
		};
	} foreach _allVar;

	if (!(_found)) then
	{
		_var = _var + [_name];
		_allVar set [(_lane - 1),_var];
		bowling setVariable ["registrations",_allVar,true];
	};
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BRegL', {
	private ["_controlR","_var","_indexFind","_display","_found"];
	disableserialization;
	_lane = param [0,-1];
	if(_lane isEqualTo -1) exitwith {};

	[] call A3PL_Bowling_BRefresh;

	_display = findDisplay 10;
	_controlLB = [_display displayCtrl 1500,_display displayCtrl 1501,_display displayCtrl 1502,_display displayCtrl 1503,_display displayCtrl 1504,_display displayCtrl 1505];
	_controlR = [_display displayCtrl 1600,_display displayCtrl 1604,_display displayCtrl 1608,_display displayCtrl 1602,_display displayCtrl 1606,_display displayCtrl 1610];

	_allVar = bowling getVariable ["registrations",DEFAULTVAR];
	_var = _allVar select (_lane - 1);
	_indexFind = _var find (name player);
	if (_indexFind > -1) exitwith {
		[_lane] call A3PL_Bowling_BUnRegL;
	};

	_found = false;
	{
		if ((_x find (name player)) > -1) then
		{
			_found = true;
		};
	} foreach _allVar;

	{
		for "_i" from 0 to 5 do
		{
			if ((_x lbText _i) == (name player)) then
			{
				_found = true;
			};
		};
	} foreach _controlLB;
	if (_found) exitwith {["You are already registered in a lane", Color_Red] call A3PL_Player_Notification;};


	[(name player),_lane] remoteExec ["A3PL_Bowling_BReg", 2];
	[] call A3PL_Bowling_BRefresh;

	for "_i" from 0 to 5 do
	{
		if (((_controlLB select (_lane -1)) lbText _i) == "Nobody") then
		{
			(_controlLB select (_lane -1)) lbDelete _i;
		};
	};
	(_controlLB select (_lane -1)) lbAdd (name player);
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BRestart', {
	private _players = 0;
	{
		_players = _players + 1;
	} foreach ((bowling getVariable ["registrations",DEFAULTVAR]) select (_this - 1));

	[_this,_players] spawn A3PL_Bowling_ResetLane;
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BScoreOpen', {
	disableSerialization;
	private ["_display","_control"];
	closeDialog 0;
	createDialog "A3PL_BowlingScoring";
	_display = findDisplay 11;
	_control = _display displayCtrl 2100;
	_control lbadd "Lane 1";
	_control lbadd "Lane 2";
	_control lbadd "Lane 3";
	_control lbadd "Lane 4";
	_control lbadd "Lane 5";
	_control lbadd "Lane 6";
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BScoreScript', {

	private ["_index","_display","_control","_scores","_players"];

	_index = _this;
	_display = findDisplay 11;
	_control = _display displayCtrl 1500;
	lbClear _control;
	_control lbAdd "-";
	_scores = (bowling getVariable (format ["lane%1",(_index + 1)])) select 3;
	_players = (bowling getVariable ["registrations",DEFAULTVAR]) select _index;

	{
		if (_forEachIndex == 0) then
		{
			lbClear _control;
		};
		_control lbAdd (format ["%1 - Score: %2",(_players select (_forEachIndex)),_x]);
	} foreach _scores;

}, false] call Server_Setup_Compile;

['A3PL_Bowling_BUnreg', {
	private ["_var","_lane","_name","_allVar","_indexFind"];

	_name = _this select 0;
	_lane = _this select 1;
	_var = (bowling getVariable ["registrations",DEFAULTVAR]) select (_lane - 1);
	_allVar = bowling getVariable ["registrations",DEFAULTVAR];
	_indexFind = _var find _name;

	if (_indexFind > -1) then
	{
		_var deleteAt _indexFind;
		_allVar set [(_lane - 1),_var];
		bowling setVariable ["registrations",_allVar,true];
	};
}, false] call Server_Setup_Compile;

['A3PL_Bowling_BUnregL', {
	private ["_var","_allVar","_indexFind","_display","_controlLB","_controlR","_controlK","_first"];
	disableserialization;

	_lane = param [0,-1];
	if(_lane isEqualTo -1) exitwith {};
	
	[] call A3PL_Bowling_BRefresh;
	_var = (bowling getVariable ["registrations",DEFAULTVAR]) select (_lane - 1);
	_allVar = bowling getVariable ["registrations",DEFAULTVAR];
	_indexFind = _var find (name player);

	if (_indexFind > -1) then
	{
		[(name player),_lane] remoteExec ["A3PL_Bowling_BUnReg", 2];

		_display = findDisplay 10;
		_controlLB = [_display displayCtrl 1500,_display displayCtrl 1501,_display displayCtrl 1502,_display displayCtrl 1503,_display displayCtrl 1504,_display displayCtrl 1505];
		_controlR = [_display displayCtrl 1600,_display displayCtrl 1604,_display displayCtrl 1608,_display displayCtrl 1602,_display displayCtrl 1606,_display displayCtrl 1610];
		_controlK = [_display displayCtrl 1612,_display displayCtrl 1613,_display displayCtrl 1614,_display displayCtrl 1615,_display displayCtrl 1616,_display displayCtrl 1617];
		[] call A3PL_Bowling_BRefresh;
		(_controlK select (_lane - 1)) ctrlEnable false;

		for "_i" from 0 to 5 do
		{
			if (((_controlLB select (_lane -1)) lbText _i) == (name player)) then
			{
				(_controlLB select (_lane -1)) lbDelete _i;
			};
		};

		_first = ((_controlLB select (_lane -1)) lbText 0);
		if (_first == "") then
		{
			(_controlLB select (_lane -1)) lbAdd "Nobody";
		};
	};
}, false] call Server_Setup_Compile;

['A3PL_Bowling_CheckBallAlley', {

	private ["_positionX","_lane"];

	_positionX = _this select 0;
	_positionY = _this select 1;
	_lane = 0;

	if ((_positionY > 1) OR (_positionY < -25)) exitwith
	{
		_lane;
	};

	if ((_positionX < 8.5) && (_positionX > 6)) exitwith
	{
		_lane = 1;
		_lane
	};

	if ((_positionX <= 6) && (_positionX > 3)) exitwith
	{
		_lane = 2;
		_lane
	};

	if ((_positionX <= 3) && (_positionX > 0)) exitwith
	{
		_lane = 3;
		_lane
	};

	if ((_positionX <= 0) && (_positionX > -3)) exitwith
	{
		_lane = 4;
		_lane
	};

	if ((_positionX <= -3) && (_positionX > -6)) exitwith
	{
		_lane = 5;
		_lane
	};

	if ((_positionX <= -6) && (_positionX > -9)) exitwith
	{
		_lane = 6;
		_lane
	};

	_lane

}, false] call Server_Setup_Compile;

['A3PL_Bowling_CountScore', {

	private ["_alley","_score","_pins"];

	_alley = _this;

	_score = 0;
	_pins = [];
	{
		if ((_x select 0) == _alley) then {
			if (((((_x select 1) call BIS_fnc_getPitchBank) select 1) > 1) OR ((((_x select 1) call BIS_fnc_getPitchBank) select 1) < -1) ) then
			{
				_score = _score + 1;
				_pins = _pins + [_x select 1];
			};
		};
	} foreach Pins;

	_score = [_score,_pins];
	_score
}, false] call Server_Setup_Compile;

['A3PL_Bowling_KickL', {
	private ["_controlLB","_display"];
	disableserialization;

	[] call A3PL_Bowling_BRefresh;
	_display = findDisplay 10;
	_controlLB = [_display displayCtrl 1500,_display displayCtrl 1501,_display displayCtrl 1502,_display displayCtrl 1503,_display displayCtrl 1504,_display displayCtrl 1505];

	[((_controlLB select (_this - 1)) lbText (lbCurSel (_controlLB select (_this - 1)))),_this] remoteExec ["A3PL_Bowling_BUnReg", 2];
}, false] call Server_Setup_Compile;

['A3PL_Bowling_PickupBall', {

	private ["_ball","_id1","_id2"];
	_ball = _this select 0;
	if ((count ([] call A3PL_Lib_Attached)) > 0) exitwith {["You are already carrying something", Color_Red] call A3PL_Player_Notification;};
	//if (!(_ball getVariable "pickup")) exitwith {};
	_ball setVariable ["pickup",false,true];
	//_ball = _this select 0;
	systemchat format ["System Debug: Ball %1",_ball];
	[_ball,player] remoteExec ["Server_Bowling_LocalityRequest", 2];

	_attachpoint = switch (true) do
	{
		case ((typeOf _ball) == "A3PL_Ammo_Crate"):
		{
			_export = [[0,1.2,1.25]];
			_export
		};

		case ((typeOf _Ball) == "GroundWeaponHolder"):
		{
			_export = [[0,.7,1]];
			_ball = _ball getVariable "container";
			_export
		};

		default
		{
			_export = [[0.035,-.11,-0.1],"RightHandMiddle1"];
			_export
		};
	};

	if ((count _attachpoint) == 1) then
	{
		_ball attachto [player, (_attachpoint select 0)];
	} else
	{
		_ball attachto [player, (_attachpoint select 0), (_attachpoint select 1)];
	};

	[_ball] call A3PL_Bowling_Attached;
}, false] call Server_Setup_Compile;

['A3PL_Bowling_RemovePins', {

	private ["_alley"];
	_alley = _this select 0;

	{
		if ((_x select 0) == _alley) then {
			deletevehicle (_x select 1);
		};
	} foreach Pins;

}, false] call Server_Setup_Compile;

['A3PL_Bowling_ResetBall', {

	private ["_lane","_nr"];
	_lane = _this;
	_nr = floor (random 1.99);

	if (_lane == 1) exitwith
	{
		[bowling modelToWorld [6,-2.7,-2.9],1] call A3PL_Bowling_SpawnBall;
	};

	if (_lane == 2) exitwith
	{
		if (_nr == 0) then
		{
			[bowling modelToWorld [5.7,-2.7,-2.9],2] call A3PL_Bowling_SpawnBall;
		} else
		{
			[bowling modelToWorld [3,-2.2,-2.9],2] call A3PL_Bowling_SpawnBall;
		};
	};

	if (_lane == 3) exitwith
	{
		if (_nr == 0) then
		{
			[bowling modelToWorld [2.7,-2.7,-2.9],3] call A3PL_Bowling_SpawnBall;
		} else
		{
			[bowling modelToWorld [0,-2.2,-2.9],3] call A3PL_Bowling_SpawnBall;
		};
	};

	if (_lane == 4) exitwith
	{
		if (_nr == 0) then
		{
			[bowling modelToWorld [-.3,-2.7,-2.9],4] call A3PL_Bowling_SpawnBall;
		} else
		{
			[bowling modelToWorld [-3,-2.2,-2.9],4] call A3PL_Bowling_SpawnBall;
		};
	};

	if (_lane == 5) exitwith
	{
		if (_nr == 0) then
		{
			[bowling modelToWorld [-3.3,-2.7,-2.9],5] call A3PL_Bowling_SpawnBall;
		} else
		{
			[bowling modelToWorld [-6,-2.2,-2.9],5] call A3PL_Bowling_SpawnBall;
		};
	};

	if (_lane == 6) exitwith
	{
		[bowling modelToWorld [-6.3,-2.7,-2.9],6] call A3PL_Bowling_SpawnBall;
	};

}, false] call Server_Setup_Compile;

['A3PL_Bowling_ResetLane', {

	private ["_players","_lane","_scoreArray","_scores"];
	_lane = _this select 0;
	_players = _this select 1;

	_CurrentPlayer = 0;
	_BallNumber = 1;
	_BallScoreOne = 2;
	_BallScoreTwo = 3;
	_TurnScore = 4;
	_TurnNumber = 5;
	_BallScoreOnePrev = 6;
	_BallScoreTwoPrev = 7;
	_TurnScorePrev = 8;
	_TotalScore1 = 9;
	_TotalScore2 = 10;
	_TotalScore3 = 11;

	_leader = (((bowling getVariable ["registrations",DEFAULTVAR]) select (_lane - 1)) select 0);
	if (isNil "_leader") exitwith {["Nobody is registered on this lane!", Color_Red] call A3PL_Player_Notification;};
	if (!((_leader) == (name player))) exitwith {["You are not the leader (first registered) of this lane!", Color_Red] call A3PL_Player_Notification;};

	if (_players < 2 && (!(isServer))) exitwith {["You need at least two players to play the game!", Color_Red] call A3PL_Player_Notification;};
	if (_players > 6) exitwith {["You can't play with more than 6 players on one lane!", Color_Red] call A3PL_Player_Notification;};

	["Game launched!", Color_Green] call A3PL_Player_Notification;
	[player,_lane] remoteExec ["Server_Bowling_LocalPins", 2];

	sleep 2;
	_lane spawn A3PL_Bowling_ResetPins;

	_scoreArray = [];
	_scores = [];

	for "_x" from 0 to (_players - 1) do
	{
		_scoreArray pushBack [];
		_scores pushBack 0;
	};

	bowling setVariable [(format ["lane%1",_lane]),[_scoreArray,1,1,_scores,_players,1],true];

	bowling setObjectTextureGlobal [(_currentPlayer + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",1])];
	bowling setObjectTextureGlobal [(_BallNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",1])];
	bowling setObjectTextureGlobal [(_BallScoreOne + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_BallScoreOnePrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_BallScoreTwoPrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_TurnScorePrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
	bowling setObjectTextureGlobal [(_TotalScore1 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",0])];
	bowling setObjectTextureGlobal [(_TotalScore2 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",0])];
	bowling setObjectTextureGlobal [(_TotalScore3 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",0])];
	bowling setObjectTextureGlobal [(_TurnNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",1])];

}, false] call Server_Setup_Compile;

['A3PL_Bowling_ResetPins', {
	private ["_lane","_pin","_relativePins","_pinCount"];
	_relativePins =
	[
		[-0.15,0.2,-.23],
		[0.15,0.2,-.23],
		[0.3,0.4,-.23],
		[0,0.4,-.23],
		[-0.3,0.4,-.23],
		[0.45,0.6,-.23],
		[-0.15,0.6,-.23],
		[0.15,0.6,-.23],
		[-0.45,0.6,-.23]
	];

	_firstPinPos =
	[
		[7.4,-22,-2],
		[4.35,-22,-2],
		[1.37,-22,-2],
		[-1.6,-22,-2],
		[-4.6,-22,-2],
		[-7.6,-22,-2]
	];

	_lane = _this;
	_pin = player;

	{
		if (((_x select 0) == _lane)) then
		{
			(_x select 1) spawn {
				_x = _this;
				_x enablesimulation false;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
				sleep 0.1;
				_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
			};
		};
	} foreach Pins;

	sleep 4;

	{
		if ((_x select 0) == _lane) exitwith
		{
			_pin = _x select 1;
		};
	} foreach Pins;

	if (_pin == player) exitwith {["Bowling: Erreur lors de la recherche de la quille!", Color_Red] call A3PL_Player_Notification;};

	_pin setpos (bowling modelToWorld (_firstPinPos select (_lane - 1)));
	_pin setDir 98;
	_pinCount = 0;

	{
		if (((_x select 0) == _lane) && (!(_x select 1 == _pin))) then
		{
			(_x select 1) setpos (_pin modelToWorld (_relativePins select _pinCount));
			_pinCount = _pinCount + 1;
		};
	} foreach Pins;

	{
		if (((_x select 0) == _lane)) then
		{
			(_x select 1) spawn {
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				sleep 0.1;
				_this setposATL [((getposATL _this) select 0),((getposATL _this) select 1),((getposATL _this) select 2) - 0.15];
				_this enablesimulation true;
			};
		};
	} foreach Pins;

}, false] call Server_Setup_Compile;

['A3PL_Bowling_SpawnBall', {

	private ["_ball","_vel","_dir"];

	_ball = createVehicle ["A3PL_ball", (_this select 0), [], 0, "CAN_COLLIDE"];
	_ball setVariable ["pickup",false,true];
	_ball setVariable ["lane",(_this select 1),true];

	_vel = velocity _ball;
	_dir = (direction _ball) + (direction bowling);
	_speed = 3 + (floor (random 2));

	_ball setVelocity [
	(_vel select 0) + (sin _dir * _speed),
	(_vel select 1) + (cos _dir * _speed),
	0
	];

}, false] call Server_Setup_Compile;

['A3PL_Bowling_ThrowBall', {

	private ["_ball","_vel","_dir","_speed","_alley"];
	_ball = _this select 0;

	_ball disableCollisionWith player;

	if ((typeof _ball) == "A3PL_Ball") then
	{
		[_ball] spawn {

			private ["_locBall","_bowlingalley","_alley","_returninfo","_returnscore","_returnpins","_oldVar","_arr1","_arr2","_arr3","_arr4","_arr5","_detectedSecond","_correctLane","_currentPlayer","_regList"];
			_ball = _this select 0;

			_bowlingalley =  nearestObject [player, "Land_KarmaLanes"];
			if (isNull _bowlingalley) exitwith
			{
				["Vous devez lancer la balle sur une piste!", Color_Red] call A3PL_Player_Notification;
				deleteVehicle _ball;
				(_ball getVariable "lane") call A3PL_Bowling_ResetBall;
			};

			_locBall = _bowlingalley worldToModel (getPos _ball);
			_alley = _locBall call A3PL_Bowling_CheckBallAlley;

			[player,_alley] remoteExec ["Server_Bowling_LocalPins", 2];
			sleep 1;

			_speed = 37;
			_vel = velocity player;
			_dir = direction player;

			detach _ball;
			_ball setVelocity [
			(_vel select 0) + (sin _dir * _speed),
			(_vel select 1) + (cos _dir * _speed),
			(_vel select 2) - 5
			];

			if (((_bowlingalley worldToModel (getpos player)) select 1) <= -4) then
			{
				[] call A3PL_Lib_Ragdoll;
				["System: You slipped", Color_Red] call a3pl_player_notification;

				_ball setVelocity [
				(_vel select 0) + (sin (_dir + random(20)) * _speed),
				(_vel select 1) + (cos (_dir + random(20)) * _speed),
				0
				];
			};

			sleep 0.5;

			if (_alley == 0) exitwith
			{
				["You need to throw the ball onto a bowling lane!", Color_Red] call A3PL_Player_Notification;
				deleteVehicle _ball;
				(_ball getVariable "lane") call A3PL_Bowling_ResetBall;
			};

			if (((bowling getVariable (format ["lane%1",_alley])) select 1) == 11) exitwith
			{
				["The game is over. Check the scores and see who won!", Color_Green] call A3PL_Player_Notification;
			};

			_correctLane = false;
			{
				if (name player == _x) then
				{
					_correctLane = true;
				};
			} foreach ((bowling getVariable ["registrations",DEFAULTVAR]) select (_alley - 1));

			if (!(_correctLane)) exitwith
			{
				["You are not registered on this lane!", Color_Red] call A3PL_Player_Notification;
				deleteVehicle _ball;
				(_ball getVariable "lane") call A3PL_Bowling_ResetBall;
			};

			_currentPlayer = false;
			_currentPlayerSup = (bowling getVariable (format ["lane%1",_alley])) select 5;
			_regList = (bowling getVariable ["registrations",DEFAULTVAR]) select (_alley - 1);

			if ((_regList select (_currentPlayerSup - 1)) == (name player)) then
			{
				_currentPlayer = true;
			};

			if (!(_currentPlayer)) exitwith
			{
				["This is not your turn, please play in order of the registrations!", Color_Red] call A3PL_Player_Notification;
				deleteVehicle _ball;
				(_ball getVariable "lane") call A3PL_Bowling_ResetBall;
			};

			sleep 0.5;

			bowling say3D "BowlingStrike";

			sleep 2;
			_returninfo = _alley call A3PL_Bowling_CountScore;
			_returnscore = _returninfo select 0;
			_returnpins = _returninfo select 1;

			_detectedSecond = false;

			if (((bowling getVariable (format ["lane%1",_alley])) select 2) == 1) then
			{
				if (((bowling getVariable (format ["lane%1",_alley])) select 4) == 0) then
				{
					_oldVar = bowling getVariable (format ["lane%1",_alley]);
					_arr1 = (_oldVar select 0);
					_arr2 = (_oldVar select 1);
					_arr3 = 2;
					_arr4 = (_oldVar select 3);
					_arr5 = (_oldVar select 4);
					bowling setVariable [(format ["lane%1",_alley]),[_arr1,_arr2,_arr3,_arr4,_arr5],true];
				};

				_pinstomoveup = [];

				{
					if (((_x select 0) == _alley) && (!((_x select 1) in _returnpins))) then
					{
						_pinstomoveup = _pinstomoveup + [_x select 1];
					};
				} foreach Pins;

				{
					_x spawn {
						_x = _this;
						_x enablesimulation false;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) + 0.2];

						sleep 4;

						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						sleep 0.1;
						_x setposATL [((getposATL _x) select 0),((getposATL _x) select 1),((getposATL _x) select 2) - 0.2];
						_x enablesimulation true;

					};
				} foreach _pinstomoveup;
			} else
			{
				_detectedSecond	= true;
				_alley spawn A3PL_Bowling_ResetPins;

				if (((bowling getVariable (format ["lane%1",_alley])) select 4) == 0) then
				{
					_oldVar = bowling getVariable (format ["lane%1",_alley]);
					_arr1 = (_oldVar select 0);
					_arr2 = (_oldVar select 1);
					_arr3 = 1;
					_arr4 = (_oldVar select 3);
					_arr5 = (_oldVar select 4);

					bowling setVariable [(format ["lane%1",_alley]),[_arr1,_arr2,_arr3,_arr4,_arr5],true];
				};
			};

			if ((!(_detectedSecond)) && (_returnscore == 10)) then
			{
				_detectedSecond	= true;
				_alley spawn A3PL_Bowling_ResetPins;

				if (((bowling getVariable (format ["lane%1",_alley])) select 4) == 0) then
				{
					_oldVar = bowling getVariable (format ["lane%1",_alley]);
					_arr1 = (_oldVar select 0);
					_arr2 = (_oldVar select 1);
					_arr3 = 1;
					_arr4 = (_oldVar select 3);
					_arr5 = (_oldVar select 4);

					bowling setVariable [(format ["lane%1",_alley]),[_arr1,_arr2,_arr3,_arr4,_arr5],true];
				};
			};

			sleep 1.5;

			if (!(((bowling getVariable (format ["lane%1",_alley])) select 4) == 0)) then
			{
				[_alley,_returnscore] spawn A3PL_CalculateAlleyScore;
			};

			_bowlingalley animate [format ["Sweeper%1_Down",_alley],0];

			sleep 1.2;
			_bowlingalley animate [format ["Sweeper%1_Back",_alley],-1];

			sleep 1.2;
			_bowlingalley animate [format ["Sweeper%1_Down",_alley],1];

			sleep 1;
			_bowlingalley animate [format ["Sweeper%1_Back",_alley],0];

			deleteVehicle _ball;
			_alley call A3PL_Bowling_ResetBall;

		};
	} else
	{
		_speed = 3;
		_ball setVelocity [
		(_vel select 0) + (sin _dir * _speed),
		(_vel select 1) + (cos _dir * _speed),
		(_vel select 2) + 5
		];
	};

}, false] call Server_Setup_Compile;

['A3PL_CalculateAlleyScore', {

	private ["_vars","_lane","_score","_scores","_turn","_ball","_totalscores","_players","_currentPlayers","_totalscore","_scoresCurrent","_currentPlayerOld","_oldTurn","_playerTotalScore"];

	_lane = _this select 0;
	_score = _this select 1;

	_CurrentPlayerSel = 0;
	_BallNumber = 1;
	_BallScoreOne = 2;
	_BallScoreTwo = 3;
	_TurnScore = 4;
	_TurnNumber = 5;
	_BallScoreOnePrev = 6;
	_BallScoreTwoPrev = 7;
	_TurnScorePrev = 8;
	_TotalScore1 = 9;
	_TotalScore2 = 10;
	_TotalScore3 = 11;

	_vars = bowling getVariable (format ["lane%1",_lane]);
	_scores = _vars select 0;
	_turn = _vars select 1;
	_ball = _vars select 2;
	_totalscores = _vars select 3;
	_players = _vars select 4;
	_currentPlayer = _vars select 5;
	_playerTotalScore = _totalscores select (_currentPlayer - 1);

	_previousball1 = -1;
	_previousball2 = -1;
	_previousball = -1;

	if (_turn > 1) then
	{
		if (_turn == 2) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 0;
			_previousball2 = (_scores select (_currentPlayer -1)) select 1;
		};

		if (_turn == 3) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 2;
			_previousball2 = (_scores select (_currentPlayer -1)) select 3;
		};

		if (_turn == 4) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 4;
			_previousball2 = (_scores select (_currentPlayer -1)) select 5;
		};

		if (_turn == 5) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 6;
			_previousball2 = (_scores select (_currentPlayer -1)) select 7;
		};

		if (_turn == 6) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 7;
			_previousball2 = (_scores select (_currentPlayer -1)) select 8;
		};

		if (_turn == 7) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 9;
			_previousball2 = (_scores select (_currentPlayer -1)) select 10;
		};

		if (_turn == 8) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 11;
			_previousball2 = (_scores select (_currentPlayer -1)) select 12;
		};

		if (_turn == 9) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 13;
			_previousball2 = (_scores select (_currentPlayer -1)) select 14;
		};

		if (_turn == 10) then
		{
			_previousball1 = (_scores select (_currentPlayer -1)) select 15;
			_previousball2 = (_scores select (_currentPlayer -1)) select 16;
		};
	};

	if (_ball == 2) then
	{
		_previousball = (_scores select (_currentPlayer -1)) select (0 + ((_turn * 2) - 2));
	};

	if (_ball == 1) then
	{
		if (_previousball1 == 10) then
		{
			_playerTotalScore = _playerTotalScore + 10 + _score;
		} else
		{
			_playerTotalScore = _playerTotalScore + _score;

			_tempArray = toArray (format ["%1",_playerTotalScore]);

			if (count _tempArray == 1) then
			{
				_tempArray = [[48,48], _tempArray] call BIS_fnc_arrayPushStack
			};

			if (count _tempArray == 2) then
			{
				_tempArray = [[48], _tempArray] call BIS_fnc_arrayPushStack
			};

			bowling setObjectTextureGlobal [(_TotalScore1 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 0) - 48)]])];
			bowling setObjectTextureGlobal [(_TotalScore2 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 1) - 48)]])];
			bowling setObjectTextureGlobal [(_TotalScore3 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 2) - 48)]])];
		};

		if (_score == 10) then
		{
			bowling setObjectTextureGlobal [(_BallScoreOne + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","X"])];
			bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
			bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
		} else
		{
			bowling setObjectTextureGlobal [(_BallScoreOne + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_score])];
		};

		if ((_previousball2+_previousball1 == 10) && (!(_previousball1 == 10))) then
		{
			_playerTotalScore = _playerTotalScore + _score;
		};

		sleep 1;

		_ball = 2;
		_scoresCurrent = _scores select (_currentPlayer -1);
		_scoresCurrent pushBack _score;
		_scores set [(_currentPlayer - 1),_scoresCurrent];
		_totalscores set [(_currentPlayer -1),_playerTotalScore];

		if (_score == 10) then
		{
			_ball = 1;

			_scoresCurrent pushBack 0;
			_scores set [(_currentPlayer - 1),_scoresCurrent];

			bowling setObjectTextureGlobal [(_BallNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",1])];
			bowling setObjectTextureGlobal [(_BallScoreOne + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
			bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
			bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];

			bowling setObjectTextureGlobal [(_TotalScore1 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];
			bowling setObjectTextureGlobal [(_TotalScore2 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];
			bowling setObjectTextureGlobal [(_TotalScore3 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];

			if (_currentPlayer == _players) then
			{
				_currentplayer = 1;
				_turn = _turn + 1;
			} else
			{
				_currentplayer = _currentplayer + 1;
			};

			bowling setObjectTextureGlobal [(_CurrentPlayerSel + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_currentplayer])];

			if (_turn == 10) then
			{
				bowling setObjectTextureGlobal [(_TurnNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","X"])];
			} else
			{
				bowling setObjectTextureGlobal [(_TurnNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_turn])];
			};

		} else
		{
			bowling setObjectTextureGlobal [(_BallNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","2"])];
		};

		bowling setVariable [(format ["lane%1",_lane]),[_scores,_turn,_ball,_totalscores,_players,_currentPlayer],true];
	} else
	{
		if (_score == 10) then
		{
			bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","spare"])];
			bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
		} else
		{
			bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",(_score - _previousball)])];
			bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_score])];
		};

		if (_previousball1 == 10) then
		{
			_playerTotalScore = _playerTotalScore + (_score - _previousball);
		};

		_playerTotalScore = _playerTotalScore + (_score - _previousball);

		_tempArray = toArray (format ["%1",_playerTotalScore]);

		if (count _tempArray == 1) then
		{
			_tempArray = [[48,48], _tempArray] call BIS_fnc_arrayPushStack
		};

		if (count _tempArray == 2) then
		{
			_tempArray = [[48], _tempArray] call BIS_fnc_arrayPushStack
		};

		bowling setObjectTextureGlobal [(_TotalScore1 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 0) - 48)]])];
		bowling setObjectTextureGlobal [(_TotalScore2 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 1) - 48)]])];
		bowling setObjectTextureGlobal [(_TotalScore3 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",format ["%1",((_tempArray select 2) - 48)]])];

		sleep 1;

		_ball = 1;
		_scoresCurrent = _scores select (_currentPlayer -1);
		_scoresCurrent pushBack (_score - _previousball);
		_scores set [(_currentPlayer - 1),_scoresCurrent];
		_oldTurn = parseNumber format ["%1",_turn];
		_currentPlayerOld = parseNumber (format ["%1",_currentPlayer]);
		_totalscores set [(_currentPlayer -1),_playerTotalScore];

		if (_currentPlayer == _players) then
		{
			_currentplayer = 1;
			_turn = _turn + 1;
			_oldTurn = _oldTurn + 1;
		} else
		{
			_currentplayer = _currentplayer + 1;
		};

		bowling setVariable [(format ["lane%1",_lane]),[_scores,_turn,_ball,_totalscores,_players,_currentPlayer],true];

		sleep 2;

		bowling setObjectTextureGlobal [(_BallNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",1])];
		bowling setObjectTextureGlobal [(_BallScoreOne + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
		bowling setObjectTextureGlobal [(_BallScoreTwo + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
		bowling setObjectTextureGlobal [(_TurnScore + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","-"])];
		bowling setObjectTextureGlobal [(_CurrentPlayerSel + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_currentplayer])];

		bowling setObjectTextureGlobal [(_TotalScore1 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];
		bowling setObjectTextureGlobal [(_TotalScore2 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];
		bowling setObjectTextureGlobal [(_TotalScore3 + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","0"])];

		if (_currentPlayerOld == _players) then
		{
			if (_turn == 10) then
			{
				bowling setObjectTextureGlobal [(_TurnNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","X"])];
			} else
			{
				bowling setObjectTextureGlobal [(_TurnNumber + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_turn])];
			};
		};

		if (_oldTurn > 1) then
		{
			if (_oldTurn == 2) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 0;
				_previousball2 = (_scores select (_currentPlayer -1)) select 1;
			};

			if (_oldTurn == 3) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 2;
				_previousball2 = (_scores select (_currentPlayer -1)) select 3;
			};

			if (_oldTurn == 4) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 4;
				_previousball2 = (_scores select (_currentPlayer -1)) select 5;
			};

			if (_oldTurn == 5) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 6;
				_previousball2 = (_scores select (_currentPlayer -1)) select 7;
			};

			if (_oldTurn == 6) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 7;
				_previousball2 = (_scores select (_currentPlayer -1)) select 8;
			};

			if (_oldTurn == 7) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 9;
				_previousball2 = (_scores select (_currentPlayer -1)) select 10;
			};

			if (_oldTurn == 8) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 11;
				_previousball2 = (_scores select (_currentPlayer -1)) select 12;
			};

			if (_oldTurn == 9) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 13;
				_previousball2 = (_scores select (_currentPlayer -1)) select 14;
			};

			if (_oldTurn == 10) then
			{
				_previousball1 = (_scores select (_currentPlayer -1)) select 15;
				_previousball2 = (_scores select (_currentPlayer -1)) select 16;
			};

			if (_previousball1 == 10) then
			{
				bowling setObjectTextureGlobal [(_BallScoreOnePrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","X"])];
			} else
			{
				bowling setObjectTextureGlobal [(_BallScoreOnePrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_previousball1])];
			};

			if ((_previousball2 + _previousball1 == 10) && (!(_previousball1 == 10))) then
			{
				bowling setObjectTextureGlobal [(_BallScoreTwoPrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa","spare"])];
			} else
			{
				bowling setObjectTextureGlobal [(_BallScoreTwoPrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_previousball2])];
				bowling setObjectTextureGlobal [(_TurnScorePrev + ((_lane - 1) * 12)),(format ["\A3PL_Bowling\Numbers\%1.paa",_previousball2+_previousball1])];
			};
		};
	};
}, false] call Server_Setup_Compile;