["Server_Bowling_Setup",
{
	Pins = [];
	//get bowling object
	bowling = (nearestObjects [[2686.35,5576.4,0],["Land_Karmalanes"],20000]) select 0;
	bowling animate ["door1",0];
	bowling animate ["door2",0];

	[bowling modelToWorld [7.4,-22,-3.2],1] call Server_Bowling_Pins;
	[bowling modelToWorld [4.35,-22,-3.2],2] call Server_Bowling_Pins;
	[bowling modelToWorld [1.37,-22,-3.2],3] call Server_Bowling_Pins;
	[bowling modelToWorld [-1.6,-22,-3.2],4] call Server_Bowling_Pins;
	[bowling modelToWorld [-4.6,-22,-3.2],5] call Server_Bowling_Pins;
	[bowling modelToWorld [-7.6,-22,-3.2],6] call Server_Bowling_Pins;

	[bowling modelToWorld [6,-2.7,-2.9],1] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [5.7,-2.7,-2.9],1] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [6,-2,-2.9],1] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [5.7,-2,-2.9],1] call A3PL_Bowling_SpawnBall;

	[bowling modelToWorld [3,-2.7,-2.9],2] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [2.7,-2.7,-2.9],2] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [3,-2,-2.9],2] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [2.7,-2,-2.9],2] call A3PL_Bowling_SpawnBall;

	[bowling modelToWorld [0,-2.7,-2.9],3] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-.3,-2.7,-2.9],3] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [0,-2,-2.9],3] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-.3,-2,-2.9],3] call A3PL_Bowling_SpawnBall;

	[bowling modelToWorld [-3,-2.7,-2.9],4] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-3.3,-2.7,-2.9],4] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-3,-2,-2.9],4] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-3.3,-2,-2.9],4] call A3PL_Bowling_SpawnBall;

	[bowling modelToWorld [-6,-2.7,-2.9],5] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-6.3,-2.7,-2.9],5] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-6,-2,-2.9],6] call A3PL_Bowling_SpawnBall;
	[bowling modelToWorld [-6.3,-2,-2.9],6] call A3PL_Bowling_SpawnBall;

	//Bowling Lane Variables
	bowling setVariable
	[
		"lane1",
		[
			//Okay, first an array for each lane with the scores
			[],
			// Then we need to check what turn the lane is on
			1,
			// Then we need to check whether it's a first ball or second ball
			1,
			// And we need an array with the total score
			[],
			// We also need an array with the amount of players for that lane
			0,
			// and the current player playing
			0
		],
		true // broadcast
	];

	// Variables are seperate to prevent 'accidental overwriting'
	bowling setVariable ["lane2",[[],1,1,[],0,0],true];
	bowling setVariable ["lane3",[[],1,1,[],0,0],true];
	bowling setVariable ["lane4",[[],1,1,[],0,0],true];
	bowling setVariable ["lane5",[[],1,1,[],0,0],true];
	bowling setVariable ["lane6",[[],1,1,[],0,0],true];

	// Another variable for registrations
	bowling setVariable ["registrations",[[],[],[],[],[],[]],true];
},true] call Server_Setup_Compile;

// This will be a function that will spawn the pins, server side
["Server_Bowling_Pins",
{
	_loc = _this select 0;
	_alley = _this select 1; // what bowling alley are these pins

	// Classname of pin object
	_class = "A3PL_Pin";

	// Spawn the first pin
	_firstpin = createVehicle [_class, _loc, [], 0, "CAN_COLLIDE"];  // 1
	Pins = Pins + [[_alley,_firstpin]];


	// Spawn the rest of the pins with the firstpin being the relevance
	// http://4.bp.blogspot.com/-oVEZj33XbAA/UvJi0PFWISI/AAAAAAAADVM/igMaLlMFSa8/s1600/bowling-pins-diagram-hi.png
	{
		_pin = createVehicle [_class, (_firstpin modelToWorld _x), [], 0, "CAN_COLLIDE"];
		Pins = Pins + [[_alley,_pin]];
	} foreach
		[
			[-0.15,0.2,0], // 2
			[0.15,0.2,0], // 3
			[0.3,0.4,0], // 4
			[0,0.4,0], // 5
			[-0.3,0.4,0], // 6
			[0.45,0.6,0], // 7
			[-0.15,0.6,0], // 8
			[0.15,0.6,0], // 9
			[-0.45,0.6,0] // 10
		];
	PublicVariable "Pins";
},true] call Server_Setup_Compile;

["Server_Bowling_LocalPins",
{
	private ["_lane","_player"];
	_player = _this select 0;
	_lane = _this select 1;

	{
		if ((_x select 0) == _lane) then
		{
			if (!((owner (_x select 1)) == (owner _player))) then
			{
				(_x select 1) setOwner (owner _player);
			};
		};
	} foreach Pins;

},true] call Server_Setup_Compile;

["Server_Bowling_LocalityRequest",
{
	private ["_ball","_player"];
	_ball = _this select 0;
	_player = _this select 1;

	if (!((owner _ball) == (owner _player))) then
	{
		_ball setOwner (owner _player);
	};
},true] call Server_Setup_Compile;

["Server_Bowling_BLaneCheck",
{
	private ["_allPlayerNames","_var"];

	// Another array for player names
	_allPlayerNames = [];
	{
		if ((_x distance bowling) < 100) then
		{
			_allPlayerNames pushback (name _x);
		};
	} foreach allPlayers;

	// Okay now check registrations and make sure player is on the server
	_var = bowling getVariable ["registrations",[]];
	{
		private ["_lane"];
		_lane = _forEachIndex;
		{
			if (!(_x IN _allPlayerNames)) then
			{
				[_x,_lane+1] remoteExec ["A3PL_Bowling_BUnReg",2];
			};
		} foreach _x;
	} foreach _var;
},true] call Server_Setup_Compile;
