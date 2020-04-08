["Server_fisherman_loop",
{
	//Server_FishingBuoys is variable with all fishingBuoys
	private ["_state","_tempRemove"];
	_tempRemove = [];

	{
		_state = _x getVariable ["fishstate",nil];
		if (!isNil "_state") then
		{
			if (_state >= 100) then
			{
				_tempRemove pushback _x;
			} else
			{
				_x setVariable ["fishstate",_state+10,true];
			};
		};
	} foreach Server_FishingBuoys;

	//delete all the fishing buoys that have a _state higher than 100
	{
		Server_FishingBuoys = Server_FishingBuoys - [_x];
		ropeDestroy (_x getVariable ["rope",objNull]);
		deleteVehicle (_x getVariable ["net",objNull]);
		deleteVehicle _x;
	} foreach _tempRemove;

}] call Server_Setup_Compile;

["Server_JobFisherman_DeployNet",
{
	private ["_pos","_buoy","_net","_rope"];
	params[["_player",objNull,[objNull]],["_buoy",objNull,[objNull]]];

	if (isNull _player) exitwith {
		diag_log format ["Error: _player isnull in Server_JobFisherman_DeployNet for %1",name _player]
	};

	if (isNull _buoy) exitwith {};
	if (!(typeOf _buoy == "A3PL_FishingBuoy")) exitwith {
		[[2],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
	};

	[[],"A3PL_JobFisherman_DeployNetSuccess",_player,false] call BIS_FNC_MP;

	_pos = getPos _buoy;
	_buoy setVariable ["fishstate",0,true];
	_buoy setVariable ["class",nil,true]; //prevent item pickup while fishing
	_buoy setVariable ["owner",getPlayerUID _player,true];

	Server_FishingBuoys pushBack _buoy;

	_net = createVehicle ["A3PL_Net", [_pos select 0,_pos select 1, (_pos select 2) - 1], [], 0, "CAN_COLLIDE"];
	_rope = ropeCreate [_buoy,"rope",_net,"rope",2];
	_buoy setVariable ["rope",_rope,false];
	_buoy setVariable ["net",_net,false];

	_buoy setOwner (owner _player);
	_net setOwner (owner _player);

},true] call Server_Setup_Compile;

["Server_JobFisherman_GrabNet",
{

	private ["_player"];
	_player = param [0,objNull];
	_buoy = param [1,objNull];
	if (isNull _player) exitwith {diag_log format ["Error: _player isnull in Server_JobFisherman_GrabNet for %1",name _player]};
	if (isNull _buoy) exitwith
	{
		diag_log format ["Error: _buoy isnull in Server_JobFisherman_GrabNet for %1",name _player];
		[[1],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
	};

	if (!(["bucket_empty",1,_player] call Server_Inventory_Has)) exitwith
	{
		[[0],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
	};

	[_player, "bucket_empty", -1] call Server_Inventory_Add;

	Server_FishingBuoys = Server_FishingBuoys - [_buoy];

	ropeDestroy (_buoy getVariable "rope");
	deleteVehicle (_buoy getVariable "net");
	deleteVehicle _buoy;

	//give player a bucket of fish
	switch (true) do
	{
		case ((_player inArea "A3PL_Marker_Fish1") OR (_player inArea "A3PL_Marker_Fish2") OR (_player inArea "A3PL_Marker_Fish4")):
		{
			[_player,"bucket_full",1] call Server_Inventory_Add;
			[_player,"mullet",1] call Server_Inventory_Add;
			[[5],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
		};

		case ((_buoy getVariable ["bait","none"]) == "shark"):
		{
			_random = random 10;
			if (_random > 7) exitwith
			{
				[_player,"bucket_full",1] call Server_Inventory_Add;
				[[7],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
			};
			_random = round (random 100);
			switch (true) do
			{
				case (_random >= 65): {[_player,"shark_2lb",1] call Server_Inventory_Add;};
				case (_random >= 40): {[_player,"shark_4lb",1] call Server_Inventory_Add;};
				case (_random >= 25): {[_player,"shark_5lb",1] call Server_Inventory_Add;};
				case (_random >= 10): {[_player,"shark_7lb",1] call Server_Inventory_Add;};
				case (_random >= 0): {[_player,"shark_10lb",1] call Server_Inventory_Add;};
			};
			[[6],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
		};

		case ((_buoy getVariable ["bait","none"]) == "turtle"):
		{
			[_player,"bucket_full",1] call Server_Inventory_Add;
			_random = random 10;
			// Lower chance if no CG on
			if ((count(["uscg","A3PL_Lib_FactionPlayers",false] call BIS_FNC_MP)) < 4) exitWith {
				if (_random <= 1) then
				{
					[[9],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
					[_player,"turtle",1] call Server_Inventory_Add;
				} else
				{
					[[8],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
				};
			};

			if (_random <= 4) then
			{
				[[9],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
				[_player,"turtle",1] call Server_Inventory_Add;
			} else
			{
				[[8],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
			};
		};

		case default
		{
			[_player,"bucket_full",1] call Server_Inventory_Add;
			[[3],"A3PL_JobFisherman_DeployNetResponse",_player,false] call BIS_FNC_MP;
		};
	};


	[getPlayerUID _player,"PickupItem",["Collected Net","bucket_full",1], _player getVariable "name"] call Server_Log_New;
}] call Server_Setup_Compile;
