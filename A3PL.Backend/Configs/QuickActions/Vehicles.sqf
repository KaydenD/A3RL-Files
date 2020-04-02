//////////////////////////////////////////Vehicles//////////////////////////////////////////////////////////////////////////////////////
//unflip
[
	"",
	"Unflip vehicle", //Repair Vehicle
	{
		private ["_intersect"];
		_intersect = player_objintersect;
		if (isNull _intersect) exitwith {};
		[_intersect] call A3PL_Vehicle_Unflip;
	}
],

[
	"A3PL_Patrol",
	"Open/Close Door", //Open/Close Door
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "boatdoor") exitwith {};

		if (_veh animationPhase "boatdoor" < 0.5) then
		{
			_veh animate ["boatDoor",1];
		} else
		{
			_veh animate ["boatDoor",0];
		};
	}
],

[
	"A3PL_Patrol",
	localize"STR_INTSECT_TOGGLEPUMP", //Toggle Pump
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "extPump") exitwith {};

		if (_veh animationPhase "extPump" < 0.1) then
		{
			_veh animate ["extPump",1];
			[[_veh], "A3PL_Intersect_WaterCannon", true, false] call BIS_fnc_MP;
		} else
		{
			_veh animate ["extPump",0];
		};
	}
],

[
	"A3PL_Patrol",
	localize"STR_INTSECT_TOGGLEPRESS", //Toggle Pressure
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "extPressure") exitwith {};

		if (_veh animationPhase "extPressure" < 0.4) then
		{
			_veh animate ["extPressure",0.5];
		};

		if ((_veh animationPhase "extPressure" > 0.4) && (_veh animationPhase "extPressure" < 0.6)) then
		{
			_veh animate ["extPressure",1];
		};

		if (_veh animationPhase "extPressure" > 0.6) then
		{
			_veh animate ["extPressure",0];
		};
	}
],

[
	"A3PL_Jayhawk",
	"Board Helicopter (Seat)",
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		[_veh] spawn
		{
			private ["_veh"];
			_veh = _this select 0;
			_veh animate ["door3",1];
			sleep 0.5;
			_veh lock 1;
			moveOut player;
			_value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");_list = fullCrew [_veh, "cargo"];_freeseats = count _list;if (_freeseats >= _value) exitwith {};
			player action ["GetInCargo", _veh];
			_veh lock 2;
		};
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_BOARDHELISSIDE", //Board Helicopter (Side)
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		[_veh] spawn
		{
			private ["_veh"];
			_veh = _this select 0;
			_veh lock 1;
			moveOut player;
			player action ["GetInTurret", _veh,[1]];
			_veh lock 2;
		};
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_SWITCHBAT", //Switch Battery
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "Battery" < 0.5) exitwith
		{
			_veh animate ["battery",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["battery",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_APUGEN", //APU Generator
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "gen1" < 0.5) exitwith
		{
			if (_veh animationPhase "battery" < 0.5) exitwith {hintSilent "Battery is off"};
			if (_veh animationPhase "ecs" < 0.5) exitwith {hintSilent "ECS is not on APU Boost"};
			if (_veh animationPhase "fuelpump" > 0.5) exitwith {hintSilent "Fuel Pump is not on APU Boost"};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {hintSilent "APU Control is not on APU Boost"};

			_veh animate ["gen1",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen1",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	format [localize"STR_INTSECT_ENGGEN",1], //ENG Generator NO.%1
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "gen2" < 0.5) exitwith
		{
			_veh animate ["gen2",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen2",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	format [localize"STR_INTSECT_ENGGEN",2], //ENG Generator NO.%1
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "gen3" < 0.5) exitwith
		{
			_veh animate ["gen3",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["gen3",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_ECSSTART", //ECS/Start
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "ecs" < 0.5) exitwith
		{
			_veh animate ["ecs",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ecs",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_FUELPUMP", //Fuel Pump
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "fuelpump" < 0.5) exitwith
		{
			_veh animate ["fuelpump",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["fuelpump",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_APUCONT", //APU Control
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "apucontrol" < 0.5) exitwith
		{
			_veh animate ["apucontrol",1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["apucontrol",0];//Done
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_WINDSHIELD", //Windshield
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "Windshield" < 0.5) exitwith
		{
			_veh animateSource ["Windshield",0.1];
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
			[_veh] spawn
			{
				private ["_veh"];
				_veh = _this select 0;
				if (_veh animationPhase "battery" < 0.5) exitwith {_veh animateSource ["Windshield",0];};
				_veh animateSource ["Windshield",1];
				waitUntil {_veh animationSourcePhase "battery" > 0.99};
				_veh animateSource ["Windshield",0.1];
				waitUntil {_veh animationSourcePhase "battery" < 0.15};
			};
		};
		_veh animateSource ["Windshield",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_SWITCHIGN", //Switch Ignition
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
		//Are we turning it on or off?
		if (_veh animationPhase "ignition_Switch" > 0.5) exitwith
		{
			_veh animate ["ignition_Switch",0];
			_veh engineOn false;
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		if (_veh animationPhase "ignition_Switch" < 0.5) exitwith
		{
			if (_veh animationPhase "battery" < 0.5) exitwith {hintSilent "Battery is off"};
			if (_veh animationPhase "ecs" > 0.5) exitwith {hintSilent "ECS is not on Engine"};
			if (_veh animationPhase "fuelpump" < 0.5) exitwith {hintSilent "Fuel Pump is not on Fuel Prime"};
			if (_veh animationPhase "apucontrol" < 0.5) exitwith {hintSilent "APU Control is not on APU Boost"};
			if (_veh animationPhase "gen1" < 0.5) exitwith {hintSilent "APU is OFF"};
			if (_veh animationPhase "ctail" > 0.5) exitwith {hintSilent "Helicopter is not unfolded"};

			if (_veh animationPhase "gen2" < 0.5) exitwith {hintSilent "Generator 2 is not turned on"};
			if (_veh animationPhase "gen3" < 0.5) exitwith {hintSilent "Generator 3 is not turned on"};

			_veh animate ["gen1",0];
			_veh animate ["ignition_Switch",1];
			[_veh] spawn
			{
				private ['_veh'];
				_veh = _this select 0;
				sleep 1;
				_veh engineOn true;
			};
			playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
		};
		_veh animate ["ignition_Switch",0];
		playSound3D ["a3\ui_f\data\Sound\CfgCutscenes\repair.wss", player];
	}
],

[
	"",
	localize"STR_INTSECT_TOGGLEFLOATS", //"Toggle Floats",
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Floats" < 0.5) then //if the button is turned to the off side
		{
			 _veh animateSource ["Floats",1];
		} else
		{
			_veh animateSource ["Floats",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGGLEFP", //Toggle Fuelpump
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Fuelpump" < 0.5) then //if the button is turned to the off side
		{
			 _veh animateSource ["Fuelpump",1];
		} else
		{
			_veh animateSource ["Fuelpump",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGGLEGEAR", //Toggle Gear
	{
		_veh = player_objintersect;
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Gear" < 0.5) then //if the button is turned to the off side
		{
			 player action ["LandGearUp",_veh];
		} else
		{
			player action ["LandGear",_veh];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGGLEBAT", //Toggle Battery
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) then //if the button is turned to the off side
		{
			 _veh animateSource ["Batteries",1];
		} else
		{
			_veh animateSource ["Batteries",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_ADJFLDWN", //Adjust Flaps Downward
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Flaps" < 0.5) then //if the button is turned to the off side
		{
			 _veh animateSource ["Flaps",0.5];
			 player action ["flapsDown",_veh];
		} else
		{
			if (_veh animationSourcePhase "Flaps" == 0.5) then
			{
				_veh animateSource ["Flaps",1];
				player action ["flapsDown",_veh];
			};
		};
	}
],

[
	"",
	localize"STR_INTSECT_ADJFLUP", //Adjust Flaps Upward
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Flaps" > 0.5) then //if the button is turned to the off side
		{
			 _veh animateSource ["Flaps",0.5];
			 player action ["flapsUp",_veh];
		} else
		{
			if (_veh animationSourcePhase "Flaps" == 0.5) then
			{
				_veh animateSource ["Flaps",0];
				player action ["flapsUp",_veh];
			};
		};
	}
],

[
    "",
    "Open/Close Locker",
    {
        [] call A3PL_Intersect_HandleDoors;
    }
],

[
    "",
    "Store in locker",
    {
       private ["_veh","_name","_attached"];

		if (!isNull Player_Item) exitwith
		{
			[] call A3PL_Placeables_QuickAction;
		};

		_attached = [] call A3PL_Lib_Attached;
		if (count _attached == 0) exitwith {};

		if ((typeOf (_attached select 0)) IN Config_Placeables) then
		{
			[] call A3PL_Placeables_QuickAction;
		};
    }
],

[
    "",
    "Rent locker",
    {
       [player_objintersect] call A3PL_Locker_Rent;
    }
],

[
	"",
	localize"STR_INTSECT_SWITCHGEN", //Switch Generator
	{
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Generator" < 0.5) then //if the button is turned to the off side
		{
			 _veh animateSource ["Generator",1];
		} else
		{
			_veh animateSource ["Generator",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_SWITCHIGN2", //Switch Ignition/Starter
	{
		private ["_veh"];
		_veh = player_objintersect;
		//if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "Batteries" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Generator" < 0.9 && (_veh isKindOf "A3PL_Goose_Base")) exitwith {["Airplane: Generator is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Fuelpump" < 0.9) exitwith {["Airplane: Fuel Pump is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Ignition" < 0.9) then //if the button is turned to the middle
		{
			if (!(_veh getVariable ["clearance",false])) exitwith {["Aircraft: No ATC clearance, please switch to 126mhz for clearance", Color_Red] call A3PL_Player_Notification;};
			_veh animateSource ["Ignition",1]; //switch engine on
			uiSleep 0.5;
			_veh engineOn true;
		}else
		{
			//shutdown right engine
			_veh animateSource ["Ignition",0];
			_veh engineOn false;
			//remove atc clearance
			//_veh setVariable ["clearance",false,true];
		};
	}
],

[
	"",
	"Switch Ignition/Starter Left",
	{
		private ["_lEngRPM1","_veh","_leftEngineOn"];

		_veh = player_objintersect;
		if (!(_veh isKindOf "A3PL_Goose_Base")) exitwith {};
		if (_veh animationSourcePhase "goose_bat" < 0.9) exitwith {["Airplane: Battery is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_gen" < 0.9) exitwith {["Airplane: Generator is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_fuelpump" < 0.9) exitwith {["Airplane: Fuel Pump is turned off", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "goose_ign" == 0.5) then //if the button is turned to the middle
		{
			//first check if left engine is running
			_lEngRPM1 = _veh animationPhase "rotorL";
			uiSleep 0.1;
			if (_lEngRPM1 == (_veh animationPhase "rotorL")) then
			{
				_leftEngineOn = false;
			} else
			{
				_leftEngineOn = true;
			};

			//continue with the script
			if (_leftEngineOn) then //left engine is on
			{
				_veh animate ["rotorL",(_veh animationPhase "rotorL")];
				_veh animateSource ["goose_ign",0];
			} else //left engine is off
			{
				if (!isEngineOn _veh) exitwith {["Airplane: Startup the right engine first", Color_Red] call A3PL_Player_Notification;};
				 _veh animateSource ["goose_ign",0]; //switch engine on
				 _veh animate ["rotorL",10000];
			};

			 _t = 0;
			 waituntil {sleep 1; _t = _t + 1; if (_t > 4) exitwith{}; _veh animationSourcePhase "goose_ign" == 0};
			 _veh animateSource ["goose_ign",0.5];
		};
	}
],

[
	"",
	localize"STR_INTSECT_EXRELADDER", //Extend/Retract Ladder
	{
		[player_objintersect,"ladder",false] call A3PL_Lib_ToggleAnimation;//Need to be changed
	}
],

[
	"",
	localize"STR_INTSECT_PICKUPLAD", //Pickup Ladder
	{
		[player_objintersect] spawn A3PL_Pickup_Ladder;//Need to be changed to call A3PL_Pickup_Ladder
	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",1], //Climb Up Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderUp", _veh, 0, 0];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",2], //Climb Up Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderUp", _veh, 1, 0];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",3], //Climb Up Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderUp", _veh, 2, 0];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",4], //Climb Up Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderUp", _veh, 3, 0];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBUPL",5], //Climb Up Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderUp", _veh, 4, 0];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",1], //Climb Down Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderDown", _veh, 0, 1];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",2], //Climb Down Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderDown", _veh, 1, 1];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",3], //Climb Down Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderDown", _veh, 2, 1];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",4], //Climb Down Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderDown", _veh, 3, 1];


	}
],

[
	"",
	format [localize"STR_INTSECT_CLIMBDOWNL",5], //Climb Down Ladder %1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		player action ["ladderDown", _veh, 4, 1];


	}
],

[
	"",
	localize"STR_INTSECT_TOGCOLLIGHT", //Toggle Collision Lights
	{
		_veh = player_objIntersect;
		_collisionLightOn = _veh getVariable ["collisionLightOn",true];
		if (_collisionLightOn) then
		{
			player action ["CollisionLightOff", _veh];
			_veh animateSource ["collision_lights",0];
			["You Turned Collision Lights Off", Color_Red] call A3PL_Player_Notification;
			player_objIntersect setVariable ["collisionLightOn",false,true];
		} else
		{
			player_objIntersect setVariable ["collisionLightOn",true,true];
			player action ["CollisionLightOn", _veh];
			_veh animateSource ["collision_lights",1];
			["You Turned Collision Lights On", Color_Green] call A3PL_Player_Notification;
		};
	}
],

[
    "",
    localize"STR_INTSECT_TOGGRAMP", //Toggle Ramp
    {
        _veh = player_objintersect;

        if ((_veh animationSourcePhase "truck_flatbed") < 0.3) then
        {
            [_veh,0] spawn A3PL_Vehicle_TowTruck_Ramp_down;
        } else
        {
			[_veh,-0.230112] spawn A3PL_Vehicle_TowTruck_Ramp_up;
        };
    }
],

[
    "",
    localize"STR_INTSECT_TOGREARSPOTL", //Toggle Rear Spotlight
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Spotlights" < 0.5) then
        {
            _veh animate ["Spotlight_Switch",1];_veh animate ["Spotlights",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};

        } else
        {
            _veh animate ["Spotlight_Switch",0];_veh animate ["Spotlights",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
        };

    }
],

[
    "",
    localize"STR_INTSECT_ENTERASENG", //Enter as Engineer
    {
        _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInCargo", _veh, 0];
		_veh lock 2;
    }
],


[
    "",
    localize"STR_INTSECT_ENTASCAP", //Enter as Captain
    {
        _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [1]];
		_veh lock 2;
    }
],

[
    "",
    localize"STR_INTSECT_ENTERASGUN", //Enter as Gunner
    {
        _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
    }
],

[
    "",
    localize"STR_INTSECT_ENTERASBOWG", //Enter as Bow Gunner
    {
        _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [2]];
		_veh lock 2;
    }
],

[
	"",
	localize"STR_INTSECT_TOGLPF", //Toggle Left Platform
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Platform_1" == 0) then
		{
			_veh animate ["Platform_1",1];
		} else
		{
			_veh animate ["Platform_1",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGRPF", //Toggle Right Platform
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Platform_2" == 0) then
		{
			_veh animate ["Platform_2",1];
		} else
		{
			_veh animate ["Platform_2",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_GRABLLB", //Grab Left Lifebuoy
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Lifebuoy_1" == 0) then
		{
			_veh animate ["Lifebuoy_1",1];
			["Lifebuoy",1] call A3PL_Inventory_add;
			["Lifebuoy"] call A3PL_Inventory_Use;
			sleep 2;
			_Lifebuoy = Player_Item;
			_Lifebuoy setVariable ["locked",false,true];
			_rope = ropeCreate [_veh, "Lifebuoy_1_point", _Lifebuoy, [0.00587467,0.55251,0.329934], 15];
			_veh setVariable ["Left_rope",_rope,true];
		};
	}
],

[
	"",
	localize"STR_INTSECT_PUTBACKLLB", //Put Back Left Lifebuoy
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Lifebuoy_1" == 1 && player_itemClass == "Lifebuoy") then
		{
			[false] call A3PL_Inventory_PutBack;
			["Lifebuoy",-1] call A3PL_Inventory_add;
			_veh animate ["Lifebuoy_1",0];
			_rope = _veh getVariable "Left_rope";
			ropeDestroy _rope;
		};
	}
],

[
	"",
	localize"STR_INTSECT_GRABRLB", //Grab Right Lifebuoy
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Lifebuoy_2" == 0) then
		{
			_veh animate ["Lifebuoy_2",1];
			["Lifebuoy",1] call A3PL_Inventory_add;
			["Lifebuoy"] call A3PL_Inventory_Use;
			sleep 2;
			_Lifebuoy = Player_Item;
			_rope = ropeCreate [_veh, "Lifebuoy_2_point", _Lifebuoy, [0.00587467,0.55251,0.329934], 15];
			_Lifebuoy setVariable ["locked",false,true];
			_veh setVariable ["Right_rope",_rope,true];
		};
	}
],

[
	"",
	localize"STR_INTSECT_PBRLIFEB", //Put Back Right Lifebuoy
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Lifebuoy_2" == 1 && player_itemClass == "Lifebuoy") then
		{
			[false] call A3PL_Inventory_PutBack;
			["Lifebuoy",-1] call A3PL_Inventory_add;
			_veh animate ["Lifebuoy_2",0];
			_rope = _veh getVariable "Right_rope";
			ropeDestroy _rope;
		};
	}
],

[
    "",
    localize"STR_INTSECT_REARFLOODL", //Rear Floodlights
    {
        _veh = vehicle player;

        if (_veh animationPhase "Ambo_Switch_7" < 0.5) then
        {
            _veh animate ["Ambo_Switch_7",1];_veh animate ["R_Floodlights",1];
        } else
        {
            _veh animate ["Ambo_Switch_7",0];_veh animate ["R_Floodlights",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_INTLIGHTS", //Interior Lights
    {
        _veh = vehicle player;

        if (_veh animationPhase "Ambo_Switch_10" < 0.5) then
        {
            _veh animate ["Ambo_Switch_10",1];_veh animate ["Interior_Lights",1];
        } else
        {
            _veh animate ["Ambo_Switch_10",0];_veh animate ["Interior_Lights",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_USESTRETCH", //Use Stretcher
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Stretcher" == 0) then
        {
            _veh animateSource ["Stretcher", 21];//animateSource to 25 to hide stretcher
        } else
        {
            _veh animateSource ["Stretcher", 0];
        };
    }
],


[
	"",
	localize"STR_INTSECT_TAKELADDER", //Take Ladder
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Ladder" == 0) then
		{
			_veh animate ["Ladder",1];
			_Ladder = createVehicle ["A3PL_Ladder", position player, [], 0, "CAN_COLLIDE"];
			_Ladder setVariable ["class","Ladder",true];
			[_Ladder] spawn A3PL_Pickup_Ladder;
		};
	}
],

[
	"",
	localize"STR_INTSECT_PUTBACKLAD", //Put Back Ladder
	{
		_veh = player_objIntersect;
		_Ladder = nearestObject [player, "A3PL_Ladder"];
		if (_veh animationPhase "Ladder" == 1) then
		{
			detach _Ladder;
			deleteVehicle _Ladder;
			_veh animate ["Ladder",0];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",1], //Take Hose %1
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Hose_1" < 0.99) then
		{
			_val = _veh animationPhase "Hose_1";
			_valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_1",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",2], //Take Hose %1
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Hose_2" < 0.99) then
		{
			_val = _veh animationPhase "Hose_2";
			_valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_2",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",3], //Take Hose %1
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Hose_3" < 0.99) then
		{
			_val = _veh animationPhase "Hose_3";
			_valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_3",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",4], //Take Hose %1
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Hose_4" < 0.99) then
		{
			_val = _veh animationPhase "Hose_4";
			_valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_4",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TAKEHOSE",5], //Take Hose %1
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Hose_5" < 0.99) then
		{
			_val = _veh animationPhase "Hose_5";
			_valu = _val + 0.25;
			if (_valu >= 1) then {_valu = 1};
			_veh animate ["Hose_5",_valu];
			["FD_Hose",1] call A3PL_Inventory_add;
			["FD_Hose"] call A3PL_Inventory_Use;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",1], //Put Back Hose %1
	{
		_veh = player_objIntersect;

		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			_val = _veh animationPhase "Hose_1";
			_valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_1",_valu];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",2], //Put Back Hose %1
	{
		_veh = player_objIntersect;

		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			_val = _veh animationPhase "Hose_2";
			_valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_2",_valu];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",3], //Put Back Hose %1
	{
		_veh = player_objIntersect;

		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			_val = _veh animationPhase "Hose_3";
			_valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_3",_valu];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",4], //Put Back Hose %1
	{
		_veh = player_objIntersect;

		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			_val = _veh animationPhase "Hose_4";
			_valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_4",_valu];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_PUTBACKHOSE",5], //Put Back Hose %1
	{
		_veh = player_objIntersect;

		if (player_itemClass == "FD_Hose") then
		{
			[false] call A3PL_Inventory_PutBack;
			["FD_Hose",-1] call A3PL_Inventory_add;
			_val = _veh animationPhase "Hose_5";
			_valu = _val - 0.25;
			if (_valu <= 0) then {_valu = 0};
			_veh animate ["Hose_5",_valu];
		};
	}
],


[
	"",
	localize"STR_INTSECT_TOGCONTCOV", //Toggle Controller Cover
	{
		_veh = player_objIntersect;

		if (_veh animationPhase "Controller_Cover" == 0) then
		{
			_veh animate ["Controller_Cover",1];
		} else
		{
			_veh animate ["Controller_Cover",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGDSFOUT", //Toggle DS Front Outrigger
	{
		_veh = vehicle player;

		if (_veh animationPhase "Outrigger_1" == 0) then
		{
			_veh animate ["Outrigger_1",1];_veh animate ["Outrigger_1_1_Flash",1];_veh animate ["Outrigger_1_2_Flash",1];_veh animate ["FT_Switch_1",1];
		} else
		{
			_veh animate ["Outrigger_1",0];_veh animate ["Outrigger_1_1_Flash",0];_veh animate ["Outrigger_1_2_Flash",0];_veh animate ["FT_Switch_1",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGDROUT", //Toggle DS Rear Outrigger
	{
		_veh = vehicle player;

		if (_veh animationPhase "Outrigger_2" == 0) then
		{
			_veh animate ["Outrigger_2",1];_veh animate ["Outrigger_2_1_Flash",1];_veh animate ["Outrigger_2_2_Flash",1];_veh animate ["FT_Switch_2",1];
		} else
		{
			_veh animate ["Outrigger_2",0];_veh animate ["Outrigger_2_1_Flash",0];_veh animate ["Outrigger_2_2_Flash",0];_veh animate ["FT_Switch_2",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGPSFOUT", //Toggle PS Front Outrigger
	{
		_veh = vehicle player;

		if (_veh animationPhase "Outrigger_3" == 0) then
		{
			_veh animate ["Outrigger_3",1];_veh animate ["Outrigger_3_1_Flash",1];_veh animate ["Outrigger_3_2_Flash",1];_veh animate ["FT_Switch_3",1];
		} else
		{
			_veh animate ["Outrigger_3",0];_veh animate ["Outrigger_3_1_Flash",0];_veh animate ["Outrigger_3_2_Flash",0];_veh animate ["FT_Switch_3",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGPSROUT", //Toggle PS Rear Outrigger
	{
		_veh = vehicle player;

		if (_veh animationPhase "Outrigger_4" == 0) then
		{
			_veh animate ["Outrigger_4",1];_veh animate ["Outrigger_4_1_Flash",1];_veh animate ["Outrigger_4_2_Flash",1];_veh animate ["FT_Switch_4",1];
		} else
		{
			_veh animate ["Outrigger_4",0];_veh animate ["Outrigger_4_1_Flash",0];_veh animate ["Outrigger_4_2_Flash",0];_veh animate ["FT_Switch_4",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TORADSOUT", //Toggle/Raise DS Outriggers
	{
		_veh = vehicle player;

		if (_veh animationPhase "OutriggerFoot_1" == 0) then
		{
			_veh animate ["OutriggerFoot_1",1];_veh animate ["OutriggerFoot_2",1];_veh animate ["FT_Switch_5",1];
		} else
		{
			_veh animate ["OutriggerFoot_1",0];_veh animate ["OutriggerFoot_2",0];_veh animate ["FT_Switch_5",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TORAPSOUT", //Toggle/Raise PS Outriggers
	{
		_veh = vehicle player;

		if (_veh animationPhase "OutriggerFoot_3" == 0) then
		{
			_veh animate ["OutriggerFoot_3",1];_veh animate ["OutriggerFoot_4",1];_veh animate ["FT_Switch_6",1];
		} else
		{
			_veh animate ["OutriggerFoot_3",0];_veh animate ["OutriggerFoot_4",0];_veh animate ["FT_Switch_6",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_PSFLOODL", //PS Floodlights
	{
		_veh = vehicle player;

		if (_veh animationPhase "PS_Floodlights" == 0) then
		{
			_veh animate ["FT_Switch_9",1];_veh animate ["PS_Floodlights",1];
		} else
		{
			_veh animate ["FT_Switch_9",0];_veh animate ["PS_Floodlights",0];
		};

		if (_veh animationPhase "ft_switch_9" < 0.5) then
		{
			_veh animate ["ft_switch_9",1];_veh animate ["driver_floodlight",1];
			_veh setHit ["light_s",1];
		} else
		{
			_veh animate ["ft_switch_9",0];_veh animate ["driver_floodlight",0];
			_veh setHit ["light_s",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_DSFLOODL", //DS Floodlights
	{
		_veh = vehicle player;

		if (_veh animationPhase "DS_Floodlights" == 0) then
		{
			_veh animate ["FT_Switch_8",1];_veh animate ["DS_Floodlights",1];
		} else
		{
			_veh animate ["FT_Switch_8",0];_veh animate ["DS_Floodlights",0];
		};

		if (_veh animationPhase "ft_switch_8" < 0.5) then
		{
			_veh animate ["ft_switch_8",1];_veh animate ["passenger_floodlight",1];
			_veh setHit ["light_s2",1];
		} else
		{
			_veh animate ["ft_switch_8",0];_veh animate ["passenger_floodlight",0];
			_veh setHit ["light_s2",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_PERILIGHT", //Perimeter Lights
	{
		_veh = vehicle player;

		if (_veh animationPhase "FT_Switch_10" == 0) then
		{
			_veh animate ["FT_Switch_10",1];_veh animate ["DS_Floodlights",1];_veh animate ["PS_Floodlights",1];_veh animate ["FT_Switch_8",0];_veh animate ["FT_Switch_9",0];
		} else
		{
			_veh animate ["FT_Switch_10",0];_veh animate ["DS_Floodlights",0];_veh animate ["PS_Floodlights",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_LADDERFLOODL", //Ladder Floodlight
	{
		_veh = vehicle player;

		if (_veh animationPhase "Ladder_Spotlight" == 0) then
		{
			_veh animate ["FT_Switch_11",1];_veh animate ["Ladder_Spotlight",1];
		} else
		{
			_veh animate ["FT_Switch_11",0];_veh animate ["Ladder_Spotlight",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_LADDERCAM", //Ladder Cam
	{
		_veh = vehicle player;

		if (_veh animationPhase "Ladder_Cam" == 0) then
		{
			_veh animate ["FT_Switch_12",1];_veh animate ["Ladder_Cam",1];_veh animate ["Reverse_Cam",0];
		} else
		{
			_veh animate ["FT_Switch_12",0];_veh animate ["Ladder_Cam",0];
		};
	}
],

[
    "",
    localize"STR_INTSECT_ENTASLADOP", //Enter as Ladder Operator
    {
        _veh = player_objIntersect;
		_veh lock 0;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
    }
],

[
    "A3PL_Rear_Ladder",
    "Climb Left Ladder",
    {
        _veh = player_objIntersect;
		if (isNull _veh) exitwith {};
		if (typeOf _veh != "A3PL_Rear_Ladder") exitWith {};
        player action ["ladderUp", _veh, 1, 0];
    }
],

[
    "A3PL_Rear_Ladder",
    "Climb Right Ladder",
    {
        _veh = player_objIntersect;
		if (isNull _veh) exitwith {};
		if (typeOf _veh != "A3PL_Rear_Ladder") exitWith {};
        player action ["ladderUp", _veh, 0, 0];
    }
],

[
	"",
	localize"STR_INTSECT_LORALADRACK", //Lower/Raise Ladder Rack
	{
		_veh = player_objIntersect;

	   if (_veh animationSourcePhase "Ladder_Holder" == 0) then
		{
			_veh animateSource  ["Ladder_Holder", 1];
		} else
		{
			_veh animateSource  ["Ladder_Holder", 0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TONOFFPUMP", //Turn On\Off Pump
	{
		_veh = player_objIntersect;
		if (!(_veh isKindOf "Car")) exitwith {};
		if (_veh animationPhase "FT_Pump_Switch" == 0) then
		{
			_veh animate ["FT_Pump_Switch", 1];
			_PumpSound = createSoundSource ["A3PL_FT_Pump", getpos _veh, [], 0];
			_PumpSound attachTo [_veh, [0, 0, 0], "pos_switches"];
			_veh setVariable ["PumpSound",_PumpSound,true];
		} else
		{
			_veh animate ["FT_Pump_Switch", 0];
			_PumpSound = _veh getVariable "PumpSound";
			deleteVehicle _PumpSound;
		};
	}
],

[
	"A3PL_Pierce_Pumper",
	localize"STR_INTSECT_OPCLDISCH", //Open/Close Discharge
	{
		private ["_veh"];
		_veh = player_objintersect;
		_animName = player_nameintersect;
		if ((!(_veh isKindOf "Car")) OR (_animName == "")) exitwith {};

		if (_animName == "ft_lever_8" && (_veh animationPhase "ft_lever_8" < 0.5)) then
		{
			[_veh] spawn A3PL_FD_EngineLoop;
		};

		[_veh,_animName,false] call A3PL_Lib_ToggleAnimation;

	}
],

[
	"A3PL_Pierce_Heavy_Ladder",
	localize"STR_INTSECT_CONHOSETOLADIN", //Connect Hose To Ladder Inlet
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"A3PL_Pierce_Pumper",
	localize"STR_INTSECT_CONHOSETOENGIN", //Connect Hose To Engine Inlet
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"A3PL_Pierce_Pumper",
	localize"STR_INTSECT_CONHOSETOENGDIS", //Connect Hose To Engine Discharge
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
    "",
    localize"STR_INTSECT_TGLFAIRAVAIL", //Toggle Fair Available
    {
        _veh = player_objintersect;

        if ((_veh animationSourcePhase "Fair_Available") < 0.5) then
        {
            _veh animateSource ["Fair_Available",1];
        } else
        {
            _veh animateSource ["Fair_Available",0];
        };
    }
],

[
	"",
	localize"STR_INTSECT_STARTFAIR", //Start Fair
	{
		[player_objIntersect] call A3PL_JobTaxi_FareStart;
	}
],

[
	"",
	localize"STR_INTSECT_PAUSEFAIR", //Pause Fair
	{
		[player_objIntersect] call A3PL_JobTaxi_FarePause;
	}
],

[
	"",
	localize"STR_INTSECT_STOPFAIR", //Stop Fair
	{
		[player_objIntersect] call A3PL_JobTaxi_FarePause;
	}
],

[
	"",
	localize"STR_INTSECT_RESETFAIR", //Reset Fair
	{
		[player_objIntersect] call A3PL_JobTaxi_FareReset;
	}
],

[
	"",
	localize"STR_INTSECT_ENTCODR", //Enter as Co-Driver
	{
		private ["_veh"];
		_veh = player_objIntersect;

		[_veh] spawn
		{
			_veh = param [0,objNull];
			_veh animateDoor ["Door_RF", 1];
			sleep 0.4;
			player moveInGunner _veh;
			_veh animateDoor ["Door_RF", 0];
		};

	}
],

[
    "A3PL_P362",
    localize"STR_INTSECT_AIRSUSCONT", //Air Suspension Control
    {
        _veh = player_objintersect;

        if (_veh animationSourcePhase "ASC" < 0.8) then
        {
            _veh animate ["ASC_Switch",1];
			_veh animateSource ["ASC",1];
			_veh setCenterOfMass [[0.00631652,0.1,-1.03015],8];
			_veh setMass [35000,8];
        } else
        {
            _veh animate ["ASC_Switch",0];
			_veh animateSource ["ASC",0];
			_veh setMass [13000,8];
			_veh setCenterOfMass [[0.00631652,-0.28197,-1.03015],8];
        };
    }
],

[
    "",
    localize"STR_INTSECT_LEFTALLLIGHT", //Left Alley Light
    {
        _veh = player_objintersect;

        if (_veh animationPhase "PD_Switch_9" < 0.5) then
        {
            _veh animate ["PD_Switch_9",1];
			_veh animate ["DS_Floodlights",1];
        } else
        {
            _veh animate ["PD_Switch_9",0];
			_veh animate ["DS_Floodlights",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_RIGHTALLLIGHT", //Right Alley Light
    {
        _veh = player_objintersect;

        if (_veh animationPhase "PD_Switch_10" < 0.5) then
        {
            _veh animate ["PD_Switch_10",1];_veh animate ["PS_Floodlights",1];
        } else
        {
            _veh animate ["PD_Switch_10",0];_veh animate ["PS_Floodlights",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_TOGSPOTLIGHT", //Toggle Spotlight
    {
        _veh = player_objintersect;

        if (_veh animationSourcePhase "Spotlight" < 0.5 && _veh animationPhase "Spotlight_Addon" > 0.5) then
        {
            _veh animateSource ["Spotlight",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};

        } else
        {
            _veh animateSource ["Spotlight",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
        };

    }
],

[
    "",
    localize"STR_INTSECT_RADARMASTER", //Radar Master
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Radar_Master" < 0.5) then
        {
            _veh animate ["Radar_Master",1];
			if ((_veh animationPhase "Radar_Front" < 0.5) && (_veh animationPhase "Radar_Rear" < 0.5)) then
			{
				_veh animate ["Radar_Front",1];
			};
        } else
        {
            _veh animate ["Radar_Master",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_REARRADAR", //Rear Radar
    {
        _veh = player_objintersect;
		if (_veh animationPhase "Radar_Rear" < 0.5) then
        {
            _veh animate ["Radar_Rear",1];
			_veh animate ["Radar_Front",0];
			if (player == driver _veh) then
			{
				_veh setVariable ["forward",false,false];
			} else
			{
				_veh setVariable ["forward",false,true];
			};

        };
    }
],

[
    "",
    localize"STR_INTSECT_FRONTRADAR", //Front Radar
    {
        _veh = player_objintersect;
		if (_veh animationPhase "Radar_Front" < 0.5) then
        {
            _veh animate ["Radar_Front",1];
			_veh animate ["Radar_Rear",0];
			if (player == driver _veh) then
			{
				_veh setVariable ["forward",true,false];
			} else
			{
				_veh setVariable ["forward",true,true];
			};

        };
    }
],
[
	"",
	localize"STR_INTSECT_RESETLOCKFAST", //Reset Lock/Fast
	{
		_veh = vehicle player;
		if (player == driver _veh) then
		{
			_veh setVariable ["lockfast",nil,false];
			_veh setVariable ["locktarget",nil,false];
			[_veh,"lockfast",0] call A3PL_Police_RadarSet;
			[_veh,"locktarget",0] call A3PL_Police_RadarSet;
		} else
		{
			_veh setVariable ["lockfast",nil,true];
			_veh setVariable ["locktarget",nil,true];
			[_veh,"lockfast",0] call A3PL_Police_RadarSet;
			[_veh,"locktarget",0] call A3PL_Police_RadarSet;
		};
	}
],

[
    "",
    localize"STR_INTSECT_TURNONOFFLAP", //Turn On/Off Laptop
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Laptop_Top" < 0.5) then
        {
            private ["_playersRE"];
            _playersRE = [driver _veh];
            {
                if (_veh getCargoIndex _x == 0) exitwith {_playersRE pushback _x};
            } foreach (crew _veh);
            [(netID _veh)] remoteExec ["A3PL_fnc_Boot_Ambulance",_playersRE, false];
            _veh animateSource ["Laptop_Top",1];
        } else
        {
            _veh animateSource ["Laptop_Top",0];
        };

        if (_veh animationPhase "rotate_1" < 0.5) then
        {
            private ["_playersRE"];
            _playersRE = [driver _veh];
            {
                if (_veh getCargoIndex _x == 0) exitwith {_playersRE pushback _x};
            } foreach (crew _veh);
            [(netID _veh)] remoteExec ["A3PL_fnc_Boot_Ambulance",_playersRE, false];
            _veh animateSource ["rotate_1",1];
        } else
        {
            _veh animateSource ["rotate_1",0];
        };
    }
],
[
    "",
    localize"STR_INTSECT_ACCPOLDB", //Access Police Database
    {
        if (isNull (findDisplay 211)&& player_objintersect animationPhase "Laptop_Top" > 0.5) then //prevent dialog opening if already open
        {
            if((player getVariable ["job","unemployed"] in ["fifr"])) then {
				[] call A3PL_FD_DatabaseOpen;
			} else {
				[] call A3PL_Police_DatabaseOpen;
			};
        };

        if (isNull (findDisplay 211)&& player_objintersect animationPhase "rotate_2" > 0.5) then //prevent dialog opening if already open
        {
            if((player getVariable ["job","unemployed"] in ["fifr"])) then {
				[] call A3PL_FD_DatabaseOpen;
			} else {
				[] call A3PL_Police_DatabaseOpen;
			};
        };
    }
],

[
    "",
    localize"STR_INTSECT_SWIVELLAP", //Swivel Laptop
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Laptop" < 0.5) then
        {
            _veh animate ["Laptop",1];
        } else
        {
            _veh animate ["Laptop",0];
        };

        if (_veh animationPhase "rotate_2" < 0.5) then
        {
            _veh animate ["rotate_2",1];
        } else
        {
            _veh animate ["rotate_2",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_HIGHBEAM", //High Beam
    {
        _veh = player_objintersect;

        if (_veh animationSourcePhase "High_Beam" == 0) then
        {
            _veh animate ["High_Beam_Switch",1];_veh animateSource ["High_Beam",1];
        } else
        {
            _veh animate ["High_Beam_Switch",0];_veh animateSource ["High_Beam",0];
        };
    }
],

[
	"",
	localize"STR_INTSECT_REVERSECAM", //Reverse Cam
	{
		_veh = player_objintersect;

		if (_veh animationPhase "Reverse_Cam" == 0) then
		{
			_veh animate ["Reverse_Cam",1];
		} else
		{
			_veh animate ["Reverse_Cam",0];
		};
	}
],

[
    "",
    localize"STR_INTSECT_AIRHORN", //Airhorn
    {
        _veh = player_objintersect;

        if (_veh animationPhase "FT_Switch_33" < 0.5) then
        {
            [5] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [5] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_ELECHORN", //Electric Horn
    {
        _veh = player_objintersect;

        if (_veh animationPhase "FT_Switch_34" < 0.5) then
        {
            [6] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [6] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_ELECAIRH", //Electric Airhorn
    {
        _veh = player_objintersect;

        if (_veh animationPhase "FT_Switch_35" < 0.5) then
        {
            [7] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [7] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_RUMBLERMAN", //Rumbler Manual
    {
        _veh = player_objintersect;

        if (_veh animationPhase "FT_Switch_36" < 0.5) then
        {
            [8] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [8] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_T3YELP", //T3 Yelp
    {
        _veh = player_objintersect;

        if (_veh animationPhase "FT_Switch_37" < 0.5) then
        {
            [9] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [9] call A3PL_Vehicle_SirenHotkey;
			[_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_MASTERON", //Master On
    {
		[2] call A3PL_Vehicle_SirenHotkey;
    }
],

[
    "",
    localize"STR_INTSECT_TOGLIGHTB", //Toggle Lightbar
    {
       _veh = player_objintersect;

        if (_veh animationSourcePhase "lightbar" < 0.5) then
        {
            [2] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            [1] call A3PL_Vehicle_SirenHotkey;
        };
    }
],

[
    "",
    localize"STR_INTSECT_DIRECTMASTER", //Directional Master
    {
       _veh = player_objintersect;

        if (_veh animationPhase "Directional_Switch" < 0.5) then
        {
            _veh animate ["Directional_Switch",1];_veh animate ["Directional",1];if (_veh animationPhase "Directional_Control_Noob" == 0) then{_veh animate ["Directional_L",1];};if (_veh animationPhase "Directional_Control_Noob" == 17.5) then{_veh animate ["Directional",0];_veh animate ["Directional_S",0];_veh animate ["Directional_F",1];};
        } else
        {
            _veh animate ["Directional_Switch",0];_veh animate ["Directional",0];if (_veh animationPhase "Directional_Control_Noob" == 17.5) then{_veh animate ["Directional",0];_veh animate ["Directional_S",0];_veh animate ["Directional_F",0];};
        };

        if (_veh animationPhase "powerswitch_1" < 0.5) then
        {
            _veh animate ["powerswitch_1",1];_veh animate ["Directional",1];if (_veh animationPhase "Directional_Control_Noob" == 0) then{_veh animate ["Directional_L",1];};if (_veh animationPhase "Directional_Control_Noob" == 17.5) then{_veh animate ["Directional",0];_veh animate ["Directional_S",0];_veh animate ["Directional_F",1];};
        } else
        {
            _veh animate ["powerswitch_1",0];_veh animate ["Directional",0];if (_veh animationPhase "Directional_Control_Noob" == 17.5) then{_veh animate ["Directional",0];_veh animate ["Directional_S",0];_veh animate ["Directional_F",0];};
        };
    }
],

[
    "",
    localize"STR_INTSECT_DIRECTCONTR", //Directional Control
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Directional_Control_Noob" == 0) then
        {
            _veh animate ["Directional_Control_Noob",6.5];_veh animate ["Directional_L",0];_veh animate ["Directional_R",1];//Right
        };
        if (_veh animationPhase "Directional_Control_Noob" == 6.5) then
        {
            _veh animate ["Directional_Control_Noob",12];_veh animate ["Directional_R",0];_veh animate ["Directional_S",1];//Split
        };
        if (_veh animationPhase "Directional_Control_Noob" == 12) then
        {
            _veh animate ["Directional_Control_Noob",17.5];_veh animate ["Directional_S",0];if (_veh animationPhase "Directional_Switch" == 1) then {_veh animate ["Directional_F",1];_veh animate ["Directional",0];};//Flash
        };
        if (_veh animationPhase "Directional_Control_Noob" == 17.5) then
        {
            _veh animate ["Directional_Control_Noob",0];_veh animate ["Directional_F",0];_veh animate ["Directional_L",1];if (_veh animationPhase "Directional_Switch" == 1) then{_veh animate ["Directional",1];};//Left
        };
    }
],

[
    "",
    localize"STR_INTSECT_SIRENMASTER", //Siren Master
    {
        _veh = player_objintersect;

        if (_veh animationPhase "Siren_Control_Switch" < 0.5) then
        {
            _veh animate ["Siren_Control_Switch",1];
            [3] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            _veh animate ["Siren_Control_Switch",0];
            [_veh] call A3PL_Vehicle_SoundSourceClear;
        };

        if (_veh animationPhase "sirenswitch_1" < 0.5) then
        {
            _veh animate ["sirenswitch_1",1];
            [3] call A3PL_Vehicle_SirenHotkey;
        } else
        {
            _veh animate ["sirenswitch_1",0];
            [_veh] call A3PL_Vehicle_SoundSourceClear;
        };
    }
],

[
    "",
    localize"STR_INTSECT_SIRENCONTR", //Siren Control
    {
		[4] call A3PL_Vehicle_SirenHotkey;
    }
],

[
    "",
    "Toggle Compartment 1",
    {
        _veh = player_objintersect;

        if (_veh animationSourcePhase "Cargo_Door_1" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_1",1];
        } else
        {
            _veh animateSource ["Cargo_Door_1",0];
        };
    }
],

[
    "",
    "Toggle Compartment 2",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_2" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_2",1];
        } else
        {
            _veh animateSource ["Cargo_Door_2",0];
        };
    }
],

[
    "",
    "Toggle Compartment 3",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_3" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_3",1];
        } else
        {
            _veh animateSource ["Cargo_Door_3",0];
        };
    }
],

[
    "",
    "Toggle Compartment 4",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_4" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_4",1];
        } else
        {
            _veh animateSource ["Cargo_Door_4",0];
        };
    }
],

[
    "",
    "Toggle Compartment 5",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_5" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_5",1];
        } else
        {
            _veh animateSource ["Cargo_Door_5",0];
        };
    }
],

[
    "",
    "Toggle Compartment 6",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_6" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_6",1];
        } else
        {
            _veh animateSource ["Cargo_Door_6",0];
        };
    }
],

[
    "",
    "Toggle Compartment 7",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_7" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_7",1];
        } else
        {
            _veh animateSource ["Cargo_Door_7",0];
        };
    }
],

[
    "",
    "Toggle Compartment 8",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_8" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_8",1];
        } else
        {
            _veh animateSource ["Cargo_Door_8",0];
        };
    }
],

[
    "",
    "Toggle Compartment 9",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_9" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_9",1];
        } else
        {
            _veh animateSource ["Cargo_Door_9",0];
        };
    }
],

[
    "",
    "Toggle Compartment 10",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_10" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_10",1];
        } else
        {
            _veh animateSource ["Cargo_Door_10",0];
        };
    }
],

[
    "",
    "Toggle Compartment 11",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_11" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_11",1];
        } else
        {
            _veh animateSource ["Cargo_Door_11",0];
        };
    }
],

[
    "",
    "Toggle Compartment 12",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_12" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_12",1];
        } else
        {
            _veh animateSource ["Cargo_Door_12",0];
        };
    }
],

[
    "",
    "Toggle Compartment 13",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_13" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_13",1];
        } else
        {
            _veh animateSource ["Cargo_Door_13",0];
        };
    }
],

[
    "",
    "Toggle Compartment 14",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_14" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_14",1];
        } else
        {
            _veh animateSource ["Cargo_Door_14",0];
        };
    }
],

[
    "",
    "Toggle Compartment 15",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_15" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_15",1];
        } else
        {
            _veh animateSource ["Cargo_Door_15",0];
        };
    }
],

[
    "",
    "Toggle Compartment 16",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_16" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_16",1];
        } else
        {
            _veh animateSource ["Cargo_Door_16",0];
        };
    }
],

[
    "",
    "Toggle Compartment 17",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_17" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_17",1];
        } else
        {
            _veh animateSource ["Cargo_Door_17",0];
        };
    }
],

[
    "",
    "Toggle Compartment 18",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_18" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_18",1];
        } else
        {
            _veh animateSource ["Cargo_Door_18",0];
        };
    }
],

[
    "",
    "Toggle Compartment 19",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_19" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_19",1];
        } else
        {
            _veh animateSource ["Cargo_Door_19",0];
        };
    }
],

[
    "",
    "Toggle Compartment 20",
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Cargo_Door_20" < 0.5) then
        {
            _veh animateSource ["Cargo_Door_20",1];
        } else
        {
            _veh animateSource ["Cargo_Door_20",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_OPCLDOOR", //Open\Close Door
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase player_nameintersect == 0) then
        {
            _veh animateDoor [player_nameintersect, 1];
        } else
        {
            _veh animateDoor [player_nameintersect, 0];
        };
    }
],

[
	"A3PL_MailTruck",
	localize"STR_INTSECT_OPCLMAILTD", //Open/Close Mailtruck Door
	{
		_veh = player_objintersect;
		if(_veh getVariable ["locked",true]) exitWith
		{
			["System: This vehicle is locked", Color_Red] call A3PL_Player_Notification;
		};
		if (_veh animationSourcePhase "mailtruck_trunk" < 0.5) then
		{
			_veh animateSource ["mailtruck_trunk",1];
		} else
		{
			_veh animateSource ["mailtruck_trunk",0];
		};
	}
],

[
	"A3PL_Drill_Trailer",
	localize"STR_INTSECT_REDRARM", //Retract/Extend Drill Arm
	{
		_drill = player_objintersect;
		if (typeOf _drill != "A3PL_Drill_Trailer") exitwith {};
		if (player getVariable ["job","unemployed"] != "oil") exitwith {["System: You are not on the oil recovery job and cannot control the drill",Color_Red] call A3PL_Player_Notification;};
		_a = _drill animationSourcePhase "drill_arm_position";
		if (_a > 0) exitwith
		{
			//check if the drill is retracted
			if (_drill animationSourcePhase "drill" > 0) exitwith {["System: You need to retract the drill itself before you can move the position of the drill arm",Color_Red] call A3PL_Player_Notification;};
			_drill animateSource ["drill_arm_position",0];
		};
		_drill animateSource ["drill_arm_position",1];
	}
],

[
	"A3PL_Drill_Trailer",
	localize"STR_INTSECT_REDRARMD", //Retract/Extend Drill
	{
		_drill = player_objintersect;
		if (typeOf _drill != "A3PL_Drill_Trailer") exitwith {};
		[_drill] call A3PL_JobWildcat_Drill;
	}
],

[
	"A3PL_PumpJack",
	localize"STR_INTSECT_STARTJPUMP", //Start Jack Pump
	{
		_pump = player_objintersect;
		if (typeOf _pump != "A3PL_PumpJack") exitwith {};
		if (player getVariable ["job","unemployed"] != "oil") exitwith {["System: You are not on the oil recovery job and cannot control the pump",Color_Red] call A3PL_Player_Notification;};
		[_pump] call A3PL_JobOil_PumpStart;
	}
],

[
	"",
	localize"STR_INTSECT_CONGASHOSE", //Connect Gas Hose
	{
		[player_objintersect] spawn A3PL_Hydrogen_Connect;
	}
],

[
	"",
	localize"STR_INTSECT_LRRAMP", //Lower/Raise Ramp
	{
		[player_objintersect] call A3PL_Vehicle_TrailerRamp;
	}
],

[
	"A3PL_Ski_Base",
	localize"STR_INTSECT_PUSKI", //Pickup ski
	{
		private ["_name"];
		if (!isNull player_item) exitwith
		{
			["You can't pickup/drop this item because you have something in your hand", Color_Red] call a3pl_player_notification;
		};
		[] call A3PL_Placeables_QuickAction;
	}
],

[
	"A3PL_Ski_Base",
	localize"STR_INTSECT_ATTDETROPE", //Attach/Detach Rope
	{
		private ["_ski","_boat","_rope"];

		_ski = player_objintersect;

		if (!(_ski isKindOf "A3PL_Ski_Base")) exitwith {["System: Are you looking at a ski?", Color_Red] call a3pl_player_notification;};
		if (!(isNull (ropeAttachedTo _ski))) exitwith
		{
			{
				ropeDestroy _x;
			} foreach (ropes (ropeAttachedTo _ski));
			["System: Rope was detached succesfully", Color_Red] call a3pl_player_notification;
		};

		_boat = nearestObjects [_ski, ["C_Boat_Civil_01_F"], 10];
		_boat = _boat - [_ski];

		if (count _boat < 1) exitwith {["System: There is no boat nearby to attach a rope to", Color_Red] call a3pl_player_notification;};
		_boat = _boat select 0;

		if (!(isNull attachedTo _boat)) exitwith
		{
			["System: You cannot attach a ski to a boat that's on a trailer", Color_Red] call a3pl_player_notification;
		};

		if (_boat == _ski) exitwith {["System Error: Unable to attach a rope", Color_Red] call a3pl_player_notification;};
		if ((ropeAttachedTo _boat) == _ski) exitwith {["System Error: Unable to attach a rope", Color_Red] call a3pl_player_notification;};

		_rope = ropeCreate [_boat, [0, -2.2, -0.5], _ski, "rope", 10];
		if (isNull _rope) exitwith {["System: Error occured when trying to create a rope", Color_Red] call a3pl_player_notification;};
		["System: Rope was attached succesfully", Color_Green] call a3pl_player_notification;
	}
],

[
	"",
	localize"STR_INTSECT_ENTERDRIVER", //Enter as Driver
	{
		private ["_veh","_anim"];
		//Dont forget a check if locked
		_veh = player_objintersect;
		_anim = player_nameIntersect;

		if(_veh getVariable ["locked",true]) exitWith
		{
			["System: Vehicle is locked", Color_Red] call A3PL_Player_Notification;
		};

		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith
		{
			["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;
		};

		[_veh,_anim] spawn
		{
			private ["_veh"];
			_veh = _this select 0;
			_anim = _this select 1;

			_veh lock 1;
			player action ["GetInDriver", _veh];
			switch (true) do
			{
				case (_veh isKindOf "helicopter"):
				{
					_veh animate [_anim,1];
					sleep 2;
					_veh animate [_anim,0];
				};

				case (_veh isKindOf "car"):
				{
					sleep 0.8;
					_veh animate [_anim,1];
					sleep 1;
					_veh animate [_anim,0];
				};
			};
			_veh lock 2;
		};
	}
],

[
	"",
	localize"STR_INTSECT_LUVEHDOORS", //Lock/Unlock Vehicle Doors
	{
		_locked = player_objIntersect getVariable ["locked",true];
		if (_locked) then
		{
			player_objIntersect setVariable ["locked",false,true];
			["System: You unlocked the vehicle doors", Color_Green] call A3PL_Player_Notification;
		} else
		{
			player_objIntersect setVariable ["locked",true,true];

			["System: You locked the vehicle doors", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_REPVEH", //Repair Vehicle
	{
		private ["_intersect"];
		_intersect = player_objintersect;
		if (isNull _intersect) exitwith {};
		[_intersect] call A3PL_Vehicle_Repair;
	}
],

[
	"",
	localize"STR_INTSECT_RESSCOOT", //Reset Scooter
	{
		private ["_intersect"];
		_intersect = player_objintersect;
		if (isNull _intersect) exitwith {};
		_pos = getPos _intersect;
		_intersect setPos [_pos select 0,_pos select 1,_pos select 2];
	}
],

[
	"A3PL_Yacht",
	localize"STR_INTSECT_USEYACHTL", //Use Yacht Ladder
	{
		private ["_veh","_name","_posTop","_posBottom","_setPos"];
		_veh = player_objIntersect;
		_name = player_nameIntersect;

		//first find out if we are interactiving with ladder1 or ladder2
		if (_name == "yacht_ladder2") then
		{
			//first figure out if we are on the bottom or on top
			_posTop = player distance (_veh modelToWorld(_veh selectionPosition "ladder2_down"));
			_posBottom = player distance (_veh modelToWorld(_veh selectionPosition "ladder2_up"));

			if (_posTop < _posBottom) then
			{
				_setpos = (_veh modelToWorld (_veh selectionPosition "ladder2_up"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3.45];
			} else
			{
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder2_down"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3];
			};

		} else
		{
			_posTop = player distance (_veh modelToWorld(_veh selectionPosition "ladder1_down"));
			_posBottom = player distance (_veh modelToWorld(_veh selectionPosition "ladder1_up"));

			if (_posTop < _posBottom) then
			{
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder1_up"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3.45];
			} else
			{
				_setpos = (_veh modelToWorld(_veh selectionPosition "ladder1_down"));
				player setpos [_setpos select 0,_setpos select 1,(_setpos select 2) - 3];
			};
		};
	}
],

[
	"",
	localize"STR_INTSECT_ENTCOPIL", //Enter as Co-Pilot
	{
		_veh = player_objintersect;

		if(_veh getVariable ["locked",true]) exitWith {
			["Vehicle Locked", Color_Red] call A3PL_Player_Notification;
		};

		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith
		{
			["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;
		};

		player moveInTurret [_veh,[0]];

	}
],

[
	"",
	localize"STR_INTSECT_ENTASPASS", //Enter as Passenger
	{
		private ["_veh","_value","_list","_freeseats"];
		//Dont forget a check if locked
		_veh = player_objintersect;
		_anim = player_nameIntersect;

		_value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");
		_list = fullCrew [_veh, "cargo"];
		_freeseats = count _list;
		if (_freeseats >= _value && (!(typeOf _veh IN [(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])]))) exitwith {};
		if(_veh getVariable ["locked",true]) exitWith {
			["Vehicle Locked", Color_Red] call A3PL_Player_Notification;
		};

		if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith
		{
			["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;
		};

		//alternate vehicle entry for goose
		if ((_veh isKindOf "Plane") or ((typeOf _veh) IN ["red_blimp_base","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])) exitwith
		{
			player moveInCargo _veh;
		};
		
		[_veh,_anim] spawn
		{
			private ["_veh"];
			_veh = _this select 0;
			_anim = _this select 1;
			_veh animate [_anim,1];
			sleep 1;
			if (_veh isKindOf "helicopter") then
			{
				sleep 2;
			};
			_veh animate [_anim,0];
		};
		_veh lock 1;
		if (_veh isKindOf "helicopter") then
		{
			player action ["GetInTurret", _veh, [0]];
		} else
		{
			_value = getNumber (configFile >> "CfgVehicles" >> (typeOf _veh) >> "transportSoldier");_list = fullCrew [_veh, "cargo"];_freeseats = count _list;if (_freeseats >= _value) exitwith {};
			player action ["GetInCargo", _veh];
		};
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_EXITVEH", //Exit Vehicle
	{
		private ["_veh","_anim"];
		//Dont forget a check if locked
		_veh = player_objintersect;
		_anim = player_nameintersect;

		[_veh,_anim] spawn
		{
			private ["_veh"];
			_veh = _this select 0;
			_anim = _this select 1;

			_veh animate [_anim,1];
			sleep 1;
			if (_veh isKindOf "helicopter") then
			{
				if (_anim == "door3") exitwith {};
				sleep 2;
			};
			_veh animate [_anim,0];
		};
		_veh lock 1;
		player leaveVehicle _veh;
		unassignVehicle player;
		player action ["GetOut", _veh];
		[]spawn {if (player getVariable ["Cuffed",true]) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[[player,"a3pl_handsupkneelcuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;};};
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_IGNITION", //Ignition
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (isEngineOn _veh) exitwith
		{
			_veh engineOn false;
			["You turned the engine off", Color_Red] call A3PL_Player_Notification;
		};
		_veh setVariable ["Ignition",true,false];
		_veh engineOn true;
		[_veh] spawn {
			sleep 0.1;
			(_this select 0) setVariable ["Ignition",nil,false];
			["You turned the engine on", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGSIR", //Toggle Siren
	{
		private ["_veh","_atc","_sirenObj"];
		_veh = player_objintersect;
		_atc = attachedObjects _veh;
		_sirenObj = _veh getVariable "sirenObj";

		if (isNil "_sirenObj") then
		{
			_sirenObj = createSoundSource ["A3PL_PoliceSiren", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["sirenObj",_sirenObj,true];
		} else
		{
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["sirenObj",Nil,true];
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {
					deleteVehicle _x;
				};
			}foreach nearestObjects [_veh,[],10];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",1], //Toggle Manual %1
	{
		private ["_veh","_atc","_sirenObj"];
		_veh = player_objintersect;
		_atc = attachedObjects _veh;
		_sirenObj = _veh getVariable "manualObj";

		if (isNil "_sirenObj") then
		{
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM1", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else
		{
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",2], //Toggle Manual %1
	{
		private ["_veh","_atc","_sirenObj"];
		_veh = player_objintersect;
		_atc = attachedObjects _veh;
		_sirenObj = _veh getVariable "manualObj";

		if (isNil "_sirenObj") then
		{
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM2", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else
		{
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_TOGMANUAL",3], //Toggle Manual %1
	{
		private ["_veh","_atc","_sirenObj"];
		_veh = player_objintersect;
		_atc = attachedObjects _veh;
		_sirenObj = _veh getVariable "manualObj";

		if (isNil "_sirenObj") then
		{
			_sirenObj = createSoundSource ["A3PL_PoliceSirenM3", getpos _veh, [], 0];
			_sirenObj attachTo [_veh,[0,0,0]];
			_veh setVariable ["manualObj",_sirenObj,true];
		} else
		{
			detach _sirenObj;
			deleteVehicle _sirenObj;
			_veh setVariable ["manualObj",Nil,true];
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGHEADL", //Toggle Head Lights
	{
		private ["_veh","_trailerArray"];
		_veh = player_objintersect;
		if (isLightOn _veh) then
		{
			player action ["lightOff",_veh];
			["You turned the vehicle lights off", Color_Red] call A3PL_Player_Notification;
			//_veh animate ["lightSwitch",0];
			_veh animateSource ["Head_Lights",0];

			//handle trailer lights
			_trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
			_trailerArray = _trailerArray select 0;
			if (!isNil "_trailerArray") then //if the selection was succesfull
			{
				_trailerArray animate ["Tail_Lights",0];
			};
		} else
		{
			player action ["lightOn",_veh];
			["You turned the vehicle lights on", Color_Red] call A3PL_Player_Notification;
			//_veh animate ["lightSwitch",1];
			_veh animateSource ["Head_Lights",3000];

			//handle trailer lights
			_trailerArray = nearestObjects [(_veh modelToWorld [0,-4,0]), ["A3PL_Trailer_Base"], 6.5];
			_trailerArray = _trailerArray select 0;
			if (!isNil "_trailerArray") then //if the selection was succesfull
			{
				_trailerArray animate ["Tail_Lights",1];
			};
		};
	}
],

[
	"",
	localize"STR_INTSECT_OPCLTRUNK", //Open/Close Trunk
	{
		private ["_veh"];
		_veh = player_objintersect;
		if (_veh animationSourcePhase "trunk" < 0.5) then
		{
			_veh animateSource ["trunk",1];
			["You opened the trunk", Color_Red] call A3PL_Player_Notification;
		} else
		{
			_veh animateSource ["trunk",0];
			["You closed the trunk", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_TOGWARNL", //Toggle Warning Lights
	{
		private ["_veh"];
		_veh = player_objintersect;
		_lights = ((_veh animationPhase "indicator_L" > 0.5) && (_veh animationPhase "indicator_R" > 0.5));
		if (_lights) then
		{
			_veh animate ["indicator_L",0];
			_veh animate ["indicator_R",0];
			["You turned off the warning lights", Color_Red] call A3PL_Player_Notification;
		} else
		{
			_veh animate ["indicator_L",1];
			_veh animate ["indicator_R",1];
			["You turned the warning lights on", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_HITCHTRLER", //Hitch Trailer
	{
		_f = false;
		if (typeOf player_objintersect == "A3PL_DrillTrailer_Default") then
		{
			if (((player_objintersect animationSourcePhase "drill") > 0) OR ((player_objintersect animationSourcePhase "drill_arm_position") > 0)) then
			{
				_f = true;
			};
		};

		if (_f) exitwith {["System: You can't hitch this trailer if the drill or drill arm is extended", Color_Red] call A3PL_Player_Notification;};

		[player_objIntersect] call A3PL_Vehicle_Trailer_Hitch;
	}
],

[
	"",
	localize"STR_INTSECT_CLIMBINTYA",  //Climb Onto Yacht
	{
		player setPos (player_objintersect modelToWorld (player_objintersect selectionPosition "climbYacht"));
	}
],

[
	"",
	localize"STR_INTSECT_UNHITCHTRL", //Unhitch Trailer
	{
		[player_objintersect] call A3PL_Vehicle_Trailer_Unhitch;
	}
],

[
	"",
	localize"STR_INTSECT_OPCLTRAILD", //Open/Close Trailer Door
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "door" < 0.1) then
		{
			[_veh] spawn {
				_veh = _this select 0;
				_veh animate ["door_lock",1];
				sleep 1.9;
				_veh animate ["Door",1];
			};
		} else
		{
			[_veh] spawn {
				_veh = _this select 0;
				_veh animate ["Door",0];
				sleep 1.9;
				_veh animate ["door_lock",0];
			};
		};
	}
],

[
	"",
	localize"STR_INTSECT_LRTRAILERR", //Lock/Unlock Trailer Doors
	{
		_locked = player_objIntersect getVariable ["locked",true];
		if (_locked) then
		{
			player_objIntersect setVariable ["locked",false,true];
			["System: You unlocked the vehicle doors", Color_Green] call A3PL_Player_Notification;
		} else
		{
			player_objIntersect setVariable ["locked",true,true];

			["System: You locked the vehicle doors", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_LRTRAILERR", //Lower/Raise Trailer Ramp
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "ramp1" < 0.1) then
		{
			[_veh] spawn {
				_veh = _this select 0;
				_veh animate ["ramp1",1];
				sleep 1.9;
				_veh animate ["ramp2",1];
			};
		} else
		{
			[_veh] spawn {
				_veh = _this select 0;
				_veh animate ["ramp2",0];
				sleep 1.9;
				_veh animate ["ramp1",0];
			};
		};
	}
],

//atego
[
	"",
	localize"STR_INTSECT_UnloadVehicle",
	{
		[player_Objintersect] spawn A3PL_Vehicle_TowTruck_Unloadcar;
	}
],

[
	"",
	localize"STR_INTSECT_LoadVehicle",
	{
		[player_objIntersect] spawn A3PL_Vehicle_TowTruck_Loadcar;
	}
],

[
	"",
	format [localize"STR_INTSECT_ENTASGUN",1],  //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [0]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",2], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [1]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",3], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [2]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",4], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [3]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",5], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [4]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",6], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [5]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",7], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [6]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",8], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [7]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",9], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [8]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",10], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [9]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",11], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [10]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",12], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [11]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",13], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [12]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",14], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [13]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",15], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [14]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",16], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [15]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",17], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [16]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",18], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [17]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",19], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [18]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_ENTASGUN",20], //Enter as Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInTurret", _veh, [19]];
		_veh lock 2;
	}
],

[
	"",
	format [localize"STR_INTSECT_SITINSEAT",1], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 0];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",2], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 1];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",3], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 2];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",4], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 3];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",5], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 4];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",6], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 5];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",7], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 6];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",8], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 7];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",9], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 8];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",10], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 9];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",11], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 10];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",12], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 11];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",13], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 12];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",14], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 13];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",15], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 14];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",16], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 15];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",17], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 16];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",18],
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 17];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",19], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 18];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",20], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 19];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",21], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 20];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",22], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 21];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",23],
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 22];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",24], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 23];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",25], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 24];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",26], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 25];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",27], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 26];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",28], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 27];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",29], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 28];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",30], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 29];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",31], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 30];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",32], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 31];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",33], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 32];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",34], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 33];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",35], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 34];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",36], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 35];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",37], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 36];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",38], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 37];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",39], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 38];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",40], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 39];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",41], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 40];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",42], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 41];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",43], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 42];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",44], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 43];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",45], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 44];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",46], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 45];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",47], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 46];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",48], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 47];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",49], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 48];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_SITINSEAT",50], //Sit In Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["getInCargo", _veh, 49];
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_MOVETODRIVER", //Move to Driver
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToDriver", _veh];
		_veh lock 2;
	}
],



[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",1], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [0]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",2], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [1]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",3], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [2]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",4], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [3]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",5], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [4]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",6], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [5]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",7], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [6]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",8], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [7]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",9], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [8]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",10], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [9]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",11], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [10]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",12], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [11]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",13], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [12]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",14], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [13]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",15], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [14]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",16], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [15]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",17], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [16]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",18], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [17]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",19], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [18]];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVTOGUNNR",20], //Move to Gunner %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["MoveToTurret", _veh, [19]];
		_veh lock 2;
	}
],

[
	"",
	localize"STR_INTSECT_MOVETOCOPIL", //Move to Co-Pilot
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 0];
		_veh lock 2;
	}
],

[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",1], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 0];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",2], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 1];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",3], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 2];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",4], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 3];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",5], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 4];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",6], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 5];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",7], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 6];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",8], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 7];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",9], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 8];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",10], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 9];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",11], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 10];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",12], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 11];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",13], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 12];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",14], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 13];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",15], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 14];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",16], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 15];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",17], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 16];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",18], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 17];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",19], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 18];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",20], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 19];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",21], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 20];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",22], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 21];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",23], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 22];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",24], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 23];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",25], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 24];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",26], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 25];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",27], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 26];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",28], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 27];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",29], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 28];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",30], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 29];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",31], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 30];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",32], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 31];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",33], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 32];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",34], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 33];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",35], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 34];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",36], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 35];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",37], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 36];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",38], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 37];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",39], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 38];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",40], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 39];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",41], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 40];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",42], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 41];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",43], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 42];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",44], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 43];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",45], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 44];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",46], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 45];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",47], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 46];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",48], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 47];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",49], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 48];
		_veh lock 2;
	}
],
[
	"",
	format [localize"STR_INTSECT_MOVETOSEAT",50], //Move to Seat %1
	{
		private ["_veh"];
		_veh = player_objIntersect;_anim = player_nameIntersect;
		if(_veh getVariable ["locked",true]) exitWith {["Vehicle Locked", Color_Red] call A3PL_Player_Notification;};if (animationState player IN ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"]) exitWith {["System: You cannot enter a vehicle when handcuffed/surrendered", Color_Red] call A3PL_Player_Notification;};
		_veh lock 1;
		player action ["moveToCargo", _veh, 49];
		_veh lock 2;
	}
],

[
	"A3PL_Jayhawk",
	localize"STR_INTSECT_UNFOJAYHWK", //Unfold/Fold Jayhawk
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if ((_veh animationSourcePhase "Jayhawk_Fold") > 0.5) exitwith
		{
			_veh animateSource ["Jayhawk_Fold",0];
			_veh animate ["RotorManual",0];
		};
		if ((_veh animationSourcePhase "Jayhawk_Fold") < 0.5) exitwith
		{
			_veh animate ["RotorManual",1-(_veh animationPhase "rotor")];
			waitUntil {_veh animationPhase "rotor" == 0;};
			_veh animateSource ["Jayhawk_Fold",1];
		};
	}
],

[
    "",
    localize"STR_INTSECT_COCKLIGHT", //Cockpit Lights
    {
		private ["_delete","_d","_veh"];
		_veh = player_objIntersect;
        _delete = false;
        _d = objNull;
		if(_veh animationSourcePhase "Cockpit_Lights" > 0.5)then
        {
        	_veh animateSource ["Cockpit_Lights",0];
			if (!(player == (vehicle player turretUnit [0]))) then
			{
				if(isnull (_veh turretUnit [0]))then
				{
					_delete=true;
					_d = createAgent ["VirtualMan_F", [0,0,0], [], 0, "FORM"];
					_d moveInTurret [_veh,[0]];
				};
			};
        	(_veh turretUnit [0]) action ["searchlightOff",  _veh];
        	if(_delete)then{moveout _d; deleteVehicle _d;};
        }
        else
        {
        	_veh animateSource ["Cockpit_Lights",1];
        	if(isnull (_veh turretUnit [0]))then
        	{
        		_delete=true;
        		_d = createAgent ["VirtualMan_F", [0,0,0], [], 0, "FORM"];
        		_d moveInTurret [_veh,[0]];
        	};
        	(_veh turretUnit [0]) action ["searchlightOn",  _veh];
        	if(_delete)then{moveout _d; deleteVehicle _d;};
        };
    }
],

[
    "",
    localize"STR_INTSECT_TOGDOZBLAD", //Toggle Dozer Blade
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "groundShov" < 0.5) then
        {
            _veh animateSource ["groundShov",1];
        } else
        {
            _veh animateSource ["groundShov",-0.5];
        };
    }
],

[
    "",
    localize"STR_INTSECT_DETATTACHM", //Detach Attachment
    {
		[] spawn
		{
			_veh = player_objintersect;
			_posveh = _veh selectionPosition "Turret1_pos";
			_pos = _veh modeltoworld _posveh;
			if(!([] call A3PL_Player_AntiSpam)) exitWith {};
			if ((_veh animationPhase "Bucket") > 0.5) then
			{
				_Bucket = "A3PL_MiniExcavator_Bucket" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
				_veh removeMagazineTurret  ["A3PL_JackhammerMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
				sleep 2;
				_Bucket setVariable ["class","ME_Bucket",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Bucket",0];
				_Bucket attachTo [_veh, [(_posveh select 0),(_posveh select 1),(_posveh select 2)-0.6]];
				detach _Bucket;
				sleep 2;
				_veh animate ["Attachment",0];
			};
			if ((_veh animationPhase "Jackhammer") > 0.5) then
			{
				_Bucket = "A3PL_MiniExcavator_Jackhammer" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				_veh removeMagazineTurret  ["A3PL_BucketMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Bucket",[0,0]];
				_veh removeMagazineTurret  ["A3PL_JackhammerMag",[0]];
				_veh removeWeaponTurret ["A3PL_Machinery_Pickaxe",[0,0]];
				sleep 2;
				_Bucket setVariable ["class","ME_Jackhammer",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Jackhammer",0];
				_Bucket attachTo [_veh, _posveh];
				detach _Bucket;
				sleep 2;
				_veh animate ["Attachment",0];
			};
			if ((_veh animationPhase "Claw") > 0.5) then
			{
				_Bucket = "A3PL_MiniExcavator_Claw" createvehicle [0,0,0];
				[player,_veh,_Bucket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
				sleep 2;
				_Bucket setVariable ["class","ME_Claw",true];
				_Bucket setVariable ["owner",getPlayerUID player,true];
				_veh animate ["Claw",0];
				_Bucket attachTo [_veh, _posveh];
				detach _Bucket;
				sleep 2;
				_veh animate ["Attachment",0];
			};
		};
    }
],

[
    "",
    localize"STR_INTSECT_CONNBUCKET", //Connect Bucket
    {
        _veh = player_objIntersect;
        if (_veh animationPhase "Attachment" < 0.5) then
        {
            _veh animate ["Bucket",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],

[
    "A3PL_MiniExcavator",
    localize"STR_INTSECT_CONNECTCLAW", //Connect Claw
    {
        _veh = player_objIntersect;

		if (_veh animationPhase "Attachment" < 0.5) then
        {
            _veh animate ["Claw",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],

[
    "",
    localize"STR_INTSECT_CONNJACKHAM", //Connect Jackhammer
    {
        _veh = player_objIntersect;

        if (_veh animationPhase "Attachment" < 0.5) then
        {
            _veh animate ["Jackhammer",1];
			_veh animate ["Attachment",1];
			[Player_ItemClass,-1] call A3PL_Inventory_Add;
			[false] call A3PL_Inventory_PutBack;
        };
    }
],

[
    "",
    localize"STR_INTSECT_OPERATMODE", //Operations Mode
    {
        _veh = player_objIntersect;
        if (player == (driver _veh)) then
        {
            player action ["moveToTurret", _veh, [0]];
        };
    }
],

[
    "",
    localize"STR_INTSECT_DRIVEMODE", //Drive Mode
    {
        _veh = player_objIntersect;
        if (player == (_veh turretUnit [0])) then
        {
            player action ["moveToDriver", _veh];
        };
    }
],


[
    "",
    localize"STR_INTSECT_TOGGLESL", //Toggle Searchlight
    {
        _veh = player_objIntersect;
        if (_veh animationSourcePhase "Spotlight" < 0.5) then
        {
            _veh animateSource ["Spotlight",1];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};

        } else
        {
            _veh animateSource ["Spotlight",0];
			if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
        };

    }
],

[
	"",
	localize"STR_INTSECT_TOGROTBR", //Toggle Rotor Brake
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if ((!("inspect_hitengine1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitengine2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithrotor4" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvrotor3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hittransmission1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitfuel1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear3" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitgear4" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithstabilizerl11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hithstabilizerr11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitlight1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitpitottube1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitpitottube2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitstaticport1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitstaticport2" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_hitvstabilizer11" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_intake1" IN (player_objIntersect getVariable "Inspection")))or(!("inspect_intake2" IN (player_objIntersect getVariable "Inspection")))) exitwith {["Aircraft: Please complete the pre flight check", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_rotor_brake" < 0.5) then {_veh animate ["switch_rotor_brake",1];["Aircraft: Rotor Brake Disengaged", Color_Green] call A3PL_Player_Notification;} else {_veh animate ["switch_rotor_brake",0];["Aircraft: Rotor Brake Engaged", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	localize"STR_INTSECT_TOGBATT", //Toggle Batteries
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "switch_rotor_brake" < 0.5) exitwith {["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationSourcePhase "Batteries" < 0.5) then {_veh animateSource ["Batteries",1];["Aircraft: Batteries On", Color_Green] call A3PL_Player_Notification;} else {_veh animateSource ["Batteries",0];["Aircraft: Batteries Off", Color_Red] call A3PL_Player_Notification;sleep 0.5;_veh animate ["Switch_Radio_Atc",1];["Aircraft: ATC Radio Off", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	localize"STR_INTSECT_TOGATCR",
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Batteries" < 0.5) exitwith {_veh animate ["Switch_Radio_Atc",0];["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "Switch_Radio_Atc" < 0.5) then
		{
			_veh animate ["Switch_Radio_Atc",1];
			["Aircraft: ATC Radio On", Color_Green] call A3PL_Player_Notification;
			if ((player getVariable "job") IN ["police","uscg","fifr","faa"]) then {_veh setVariable ["clearance",true,true];};
			TF_lr_dialog_radio = player call TFAR_fnc_VehicleLR;
			TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;
			call TFAR_fnc_onLrDialogOpen;
		};
		if (_veh animationPhase "Switch_Radio_Atc" > 0.5) then
		{
			TF_lr_dialog_radio = player call TFAR_fnc_VehicleLR;
			TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;
			call TFAR_fnc_onLrDialogOpen;
		};
	}
],

[
	"",
	format [localize"STR_INTSECT_THROTCL",1], //Throttle Closed (Engine 1)
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "Switch_Radio_Atc" < 0.5) exitwith {["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["Aircraft: No ATC clearance, please switch to 126mhz for clearance", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle" < 0.5) then {_veh animate ["switch_throttle",1];["Aircraft: Throttle Closed (Engine 1)", Color_Green] call A3PL_Player_Notification;} else {_veh animate ["switch_throttle",0];["Aircraft: Throttle Open (Engine 1)", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	format [localize"STR_INTSECT_TOGSTARENG",1], //Toggle Starter (Engine 1)
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "switch_throttle" < 0.5) exitwith {["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["Aircraft: No ATC clearance, please switch to 126mhz for clearance", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_starter" < 0.5) then {_veh animate ["switch_starter",1];["Aircraft: Starter Engaged (Engine 1)", Color_Green] call A3PL_Player_Notification;} else {_veh engineOn false;_veh animate ["switch_starter",0];["Aircraft: Starter Disengaged (Engine 1)", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	format [localize"STR_INTSECT_THROTCL",2], //Throttle Closed (Engine 2)
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationPhase "switch_starter" < 0.5) exitwith {["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["Aircraft: No ATC clearance, please switch to 126mhz for clearance", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle2" < 0.5) then {_veh animate ["switch_throttle2",1];_veh animatesource ["throttleRTD1",0];["Aircraft: Throttle Closed (Engine 2)", Color_Green] call A3PL_Player_Notification;} else {_veh animate ["switch_throttle2",0];["Aircraft: Throttle Open (Engine 2)", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	format [localize"STR_INTSECT_TOGSTARENG",2], //Toggle Starter (Engine 2)
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if ((_veh animationPhase "switch_throttle2" < 0.5)or(player_objintersect animationSourcePhase "Inspect_Panel2_1" > 0.5)or(player_objintersect animationSourcePhase "Inspect_Panel1_1" > 0.5)) exitwith {["Aircraft: Please contact a FAA CFI for instructions", Color_Red] call A3PL_Player_Notification;};
		if (!(_veh getVariable ["clearance",false])) exitwith {["Aircraft: No ATC clearance, please switch to 126mhz for clearance", Color_Red] call A3PL_Player_Notification;};
		if (_veh animationPhase "switch_throttle2" > 0.5) then
		{
			["Aircraft: Starter Engaged (Engine 2)", Color_Green] call A3PL_Player_Notification;
			_veh animate ["switch_starter",2];
			sleep 1;
			_veh engineOn true;
			//_veh setVariable ["clearance",false,true];
			//_veh setVariable ["walk_around",false,true];
			sleep 32;
			_veh animate ["switch_starter",0];
			["Aircraft: Starter Disengaged (Engine 2)", Color_Red] call A3PL_Player_Notification;
			sleep 0.5;
			["Aircraft: Starter Disengaged (Engine 1)", Color_Red] call A3PL_Player_Notification;
			sleep 0.5;
			_veh animate ["switch_throttle",0];
			["Aircraft: Throttle Open (Engine 1)", Color_Red] call A3PL_Player_Notification;
			sleep 0.5;
			_veh animate ["switch_throttle2",0];
			["Aircraft: Throttle Open (Engine 2)", Color_Red] call A3PL_Player_Notification;
		}
		else
		{_veh engineOn false;_veh animate ["switch_starter",1];["Aircraft: Starter Disengaged (Engine 2)", Color_Red] call A3PL_Player_Notification;};
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPENG",1], //Inspect Engine #%1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Inspect_Panel1_1" < 0.5) exitwith {};
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitengine1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPENG",2], //Inspect Engine #%2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Inspect_Panel2_1" < 0.5) exitwith {};
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitengine2";
		_veh setVariable ["Inspection",_Inspection,true];

	}
],

[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",1], //Inspect Main Rotor #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",2], //Inspect Main Rotor #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",3], //Inspect Main Rotor #3
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor3";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPMAINROT",4], //Inspect Main Rotor #4
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithrotor4";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","#1"],//Inspect Main Tail 1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","#2"], //Inspect Main Tail 2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPTAILROT","Hub"], //Inspect Main Tail Hub
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvrotor3";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	localize"STR_INTSECT_INSPTRANS", //Inspect Transmission
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hittransmission1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	localize"STR_INTSECT_INSPFUEL", //Inspect Fuel
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitfuel1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPGEAR",1],//Inspect Gear #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPGEAR",2],//Inspect Gear #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPGEAR",3],//Inspect Gear #3
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear3";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPGEAR",4],//Inspect Gear #4
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitgear4";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPHORSTAB",1], //Inspect Horizontal stabilizer #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithstabilizerl11";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPHORSTAB",2], //Inspect Horizontal stabilizer #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hithstabilizerr11";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	localize "STR_INTSECT_INSPLL", //Inspect Landing Light
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitlight1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPPTUB",1], //Inspect Pitot Tube #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitpitottube1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPPTUB",2], //Inspect Pitot Tube #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitpitottube2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPSTP",1],//Inspect Static Port #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitstaticport1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPSTP",2],//Inspect Static Port #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitstaticport2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	localize"STR_INTSECT_INSPVERSTAB", //Inspect Vertical Stabilizer
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_hitvstabilizer11";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPINT",1], //Inspect Intake #1
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_intake1";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	format [localize"STR_INTSECT_INSPINT",2], //Inspect Intake #2
	{
		private ["_veh"];
		_veh = player_objIntersect;
		_Inspection = _veh getVariable "Inspection";
		_Inspection pushBack "inspect_intake2";
		_veh setVariable ["Inspection",_Inspection,true];
	}
],

[
	"",
	"Toggle Left Engine Hatch", //Toggle Left Engine Hatch
	{
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Inspect_Panel1_1" < 0.5) then
        {
            _veh animateSource ["Inspect_Panel1_1",1];
        } else
        {
            _veh animateSource ["Inspect_Panel1_1",0];
        };
    }
],

[
	"",
	"Toggle Right Engine Hatch", //Toggle Right Engine Hatch
	{
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "Inspect_Panel2_1" < 0.5) then
        {
            _veh animateSource ["Inspect_Panel2_1",1];
        } else
        {
            _veh animateSource ["Inspect_Panel2_1",0];
        };
    }
],

[
    "",
    localize"STR_INTSECT_SPINSIGN", //Spin Sign
    {
        _veh = player_objIntersect;

        if (_veh animationSourcePhase "LPlate" < 0.5) then
        {
            _veh animateSource ["LPlate",1];
        } else
        {
            _veh animateSource ["LPlate",0];
        };
    }
],

[
	"",
	localize"STR_INTSECT_USEJERRYC", //Use jerrycan
	{
		[player_objintersect] spawn A3PL_Vehicle_Jerrycan;
	}
],

[
	"",
	localize"STR_INTSECT_ANCHOR", //Drop/Retrieve Anchor
	{
		[player_objintersect] spawn A3PL_Vehicle_Anchor;
	}
],

[
	"A3PL_WheelieBin",
	"Pickup bin",
	{
		if ((player getVariable ["job","unemployed"]) != "waste") exitwith {["System: You are not working for Waste Management!"] call A3PL_Player_Notification;};
		[player_objintersect] call A3PL_Inventory_Pickup;
	}
],

[
	"A3PL_WheelieBin",
	"Load bin onto truck",
	{
		[player_objintersect] call A3PL_Waste_LoadBin;
	}
],

[
	"A3PL_P362_Garbage_Truck",
	"Unload bin from truck",
	{
		[player_objintersect,player_nameintersect] call A3PL_Waste_UnloadBin;
	}
],

[
	"",
	"Flip Left Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin1" < 0.5) then
		{
			[_veh,"bin1"] call A3PL_Waste_FlipBin;
		};
	}
],

[
	"",
	"Lower Left Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin1" > 0.5) then
		{
			_veh animateSource  ["Bin1", 0.1];
		};
	}
],

[
	"",
	"Flip Right Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin2" < 0.5) then
		{
			[_veh,"bin2"] call A3PL_Waste_FlipBin;
		};
	}
],

[
	"",
	"Lower Right Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationSourcePhase "Bin2" > 0.5) then
		{
			_veh animateSource  ["Bin2", 0.1];
		};
	}
],

[
	"",
	"Open Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationPhase "Lid" < 0.5) then
		{
			_veh animate  ["Lid", 1];
		};
	}
],

[
	"",
	"Close Bin",
	{
		_veh = player_objIntersect;
		if (_veh animationPhase "Lid" > 0.5) then
		{
			_veh animate  ["Lid", 0];
		};
	}
],

[
	"",
	"Lower/Raise Car Ramp", //
	{
		[player_objintersect] call A3PL_Vehicle_TrailerAttachObjects;
	}
],

[
	"",
	"Toggle Mooring Line", //
	{
		[] call A3PL_Vehicle_Mooring;
	}
],

[
    "",
    "Toggle Hitch", //
    {
        _veh = player_objIntersect;
        if (_veh animationSourcePhase "Hitch_Fold" < 0.5) then
        {
            _veh animateSource ["Hitch_Fold",1];
        } else
        {
            _veh animateSource ["Hitch_Fold",0];
        };
    }
],

[
	"C_Van_02_transport_F",
	"Drivers Door", //Open/Close Door
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "door1") exitwith {};

		if (_veh animationSourcePhase "Door_1_source" == 0) then
		{
			_veh animateDoor ["Door_1_source", 1];
		} else
		{
			_veh animateDoor ["Door_1_source", 0];
		};
	}
],

[
	"C_Van_02_transport_F",
	"Passengers Door", //Open/Close Door
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "door2") exitwith {};

		if (_veh animationSourcePhase "Door_2_source" < 0.5) then
		{
			_veh animateDoor ["Door_2_source", 1];
		} else
		{
			_veh animateDoor ["Door_2_source", 0];
		};
	}
],

[
	"C_Van_02_transport_F",
	"Side Door", //Open/Close Door
	{
		private ["_veh","_name"];
		_veh = player_objintersect;
		_name = Player_NameIntersect;
		if (_name != "door3") exitwith {};

		if (_veh animationSourcePhase "Door_3_source" < 0.5) then
		{
			_veh animateDoor ["Door_3_source", 1];
		} else
		{
			_veh animateDoor ["Door_3_source", 0];
		};
	}
],

[
    "",
    "Toggle Gooseneck", //
    {
       [player_objintersect] call A3PL_Vehicle_Toggle_Gooseneck;
    }
]
