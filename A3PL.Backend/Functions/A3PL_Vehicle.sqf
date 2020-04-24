//This function clears all soundSources from an object
//[_veh,true] call A3PL_Vehicle_SoundSourceClear <- that will clear all siren objects from vehicle
//[_veh,false,true] call A3PL_Vehicle_SoundSourceClear <- that will clear only manual siren object from vehicle
//[_veh,false,false] call A3PL_Vehicle_SoundSourceClear <- that will clear only the siren object from vehicle
["A3PL_Vehicle_SoundSourceClear",
{
	private ["_veh"];
	_veh = param [0,objNull];
	_clearAll = param [1,true];
	_clearManual = param [2,true];
	_clearAnim = param [3,true];

	if (_clearAnim) exitwith {{deleteVehicle _x} forEach (_veh getVariable "SoundSource");_veh animate ["SoundSource_1",0, true];_veh animate ["SoundSource_2",0, true];_veh animate ["SoundSource_3",0, true];_veh animate ["SoundSource_4",0, true];_veh animate ["SoundSource_5",0, true];_veh animate ["SoundSource_6",0, true];_veh animate ["SoundSource_7",0, true];_veh animate ["SoundSource_8",0, true];_veh animate ["SoundSource_9",0, true];_veh animate ["SoundSource_10",0, true];_veh animate ["SoundSource_11",0, true];_veh animate ["SoundSource_12",0, true];_veh animate ["SoundSource_13",0, true];_veh animate ["SoundSource_14",0, true];_veh animate ["SoundSource_15",0, true];_veh animate ["SoundSource_16",0, true];_veh animate ["SoundSource_17",0, true];_veh animate ["SoundSource_18",0, true];_veh animate ["SoundSource_19",0, true];_veh animate ["SoundSource_20",0, true];};

	if (_clearAll) exitwith
	{
		{
			if ((typeOf _x) == "#dynamicSound") then
			{
				deleteVehicle _x;
			};
		} forEach (attachedObjects _veh);
	};

	if (_clearManual) then
	{
		deleteVehicle (_veh getVariable ["manual",objNull]); //We have to do it this way because setVariable doesn't work on soundSources... retarded and causes siren getting stuck on rare occasions
	} else
	{
		deleteVehicle (_veh getVariable ["siren",objNull]);
	};

}] call Server_Setup_Compile;

["A3PL_Vehicle_SoundSourceCreate",
{
	private ["_sirenType","_veh","_classname","_Siren","_SoundSource_1","_SoundSource_2","_SoundSource_3","_SoundSource_4"];
	_veh = _this;
	_classname = typeOf _veh;
	switch (true) do
	{
		case (_classname IN ["A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Tahoe_FD"]): {_sirenType = "fire_FR";};
		case (_classname IN ["A3PL_F150_Marker_PD","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_RBM","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_Silverado_PD","A3PL_VetteZR1_PD"]): {_sirenType = "police";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"]): {_sirenType = "ems";};
		case (_classname IN ["A3PL_P362_TowTruck","A3PL_F150_Marker"]): {_sirenType = "civ";};
		case (_classname IN ["A3PL_Yacht","A3PL_Container_Ship","A3PL_Yacht_Pirate","A3PL_Cutter","A3PL_Motorboat","A3PL_RHIB"]): {_sirenType = "Ship";};
		default {_sirenType = "police";};
	};
	switch (_sirenType) do
	{
		case "police":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			/* _SoundSource_1 = createSoundSource ["A3PL_Old_SD_Siren", [0,0,0], [], 0]; */
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_FSS_Phaser", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FSS_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_FSS_Rumbler", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire":
		{
			_SoundSource_1 = createSoundSource ["A3PL_EQ2B_Wail", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Warble", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_AirHorn_1", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "fire_FR":
		{
			_SoundSource_1 = createSoundSource ["A3PL_FSUO_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority3", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_FIPA20A_Priority", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Horn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "ems":
		{
			_SoundSource_1 = createSoundSource ["A3PL_Whelen_Siren", [0,0,0], [], 0];
			_SoundSource_1 attachTo [_veh, [0,0,0], "SoundSource_1"];
			_SoundSource_2 = createSoundSource ["A3PL_Whelen_Priority", [0,0,0], [], 0];
			_SoundSource_2 attachTo [_veh, [0,0,0], "SoundSource_2"];
			_SoundSource_3 = createSoundSource ["A3PL_Whelen_Priority2", [0,0,0], [], 0];
			_SoundSource_3 attachTo [_veh, [0,0,0], "SoundSource_3"];
			_SoundSource_4 = createSoundSource ["A3PL_Electric_Airhorn", [0,0,0], [], 0];
			_SoundSource_4 attachTo [_veh, [0,0,0], "SoundSource_4"];
			_Siren = [_SoundSource_1,_SoundSource_2,_SoundSource_3,_SoundSource_4];
			_veh setVariable ["SoundSource",_Siren,true];
		};
		case "civ": {};
		case "Ship": {};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_SirenHotkey",
{
	private ["_veh","_sirenObj","_manObj","_atc","_animname","_animsource","_classname","_has","_sirenType"];
	params[["_action",0,[0]]];
	_veh = vehicle player;
	_sirenObj = _veh getVariable ["siren",objNull];
	_manObj = _veh getVariable ["manual",objNull];
	_classname = typeOf _veh;
	switch (true) do
	{
		case (_classname IN ["A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]): {_sirenType = "fire";};
		case (_classname IN ["A3PL_Tahoe_FD"]): {_sirenType = "fire_FR";};
		case (_classname IN ["A3PL_F150_Marker_PD","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_RBM","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_Silverado_PD","A3PL_VetteZR1_PD"]): {_sirenType = "police";};
		case (_classname IN ["Jonzie_Ambulance","A3PL_E350","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"]): {_sirenType = "ems";};
		case (_classname IN ["A3PL_P362_TowTruck","A3PL_F150_Marker"]): {_sirenType = "civ";};
		case (_classname IN ["A3PL_Yacht","A3PL_Container_Ship","A3PL_Yacht_Pirate","A3PL_Cutter","A3PL_Motorboat","A3PL_RHIB"]): {_sirenType = "Ship";};
		default {_sirenType = "police";};
	};
	switch (_sirenType) do
	{
		case "police":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 : /* Lights Only */
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;

					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" == 0) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{

						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" < 0.5) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
			};
		};
		case "ems":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 : /* Lights Only */
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" > 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
			};
		};
		case "fire_FR":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 : /* Lights Only */
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
					_veh animate ["Directional_Switch",1];
					_veh animate ["Directional_F",1];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 6 :
				{
					if (_veh animationPhase "SoundSource_4" > 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_4",1, true];
						_veh animate ["FT_Switch_37",1];
					}else
					{
						_veh animate ["SoundSource_4",0, true];
						_veh animate ["FT_Switch_37",0];
					};
				};
			};
		};
		case "fire":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animate ["Siren_Control_Switch",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
						_veh animate ["Directional_Switch",0];
						_veh animate ["Directional_F",0];
					};
				};
				case 2 : /* Lights Only */
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh call A3PL_Vehicle_SoundSourceCreate;
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];

					};
				};
				case 3 :
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh call A3PL_Vehicle_SoundSourceCreate;
					_veh animateSource ["Lightbar",1];
					player action ["lightOn",_veh];
					_veh animate ["Siren_Control_Switch",1];
					_veh animate ["Siren_Control_Noob",12];
					_veh animate ["SoundSource_1",1, true];
				};
				case 4 :
				{
					if (_veh animationPhase "SoundSource_2" < 0.5) then
					{
						_veh animate ["SoundSource_2",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_2",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
				case 5 :
				{
					if (_veh animationPhase "SoundSource_3" < 0.5 && {!A3PL_Manual_KeyDown}) then
					{
						_veh animate ["SoundSource_3",1, true];
						_veh animate ["FT_Switch_36",1];
					}else
					{
						_veh animate ["SoundSource_3",0, true];
						_veh animate ["FT_Switch_36",0];
					};
				};
			};
		};
		case "civ":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
					_veh animate ["Siren_Control_Switch",0];
					_veh animate ["Directional_Switch",0];
					_veh animate ["Directional_F",0];
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 : /* Lights Only */
				{
					if (_veh animationSourcePhase "lightbar" > 0.5) then
					{
						[_veh,false,false,true] call A3PL_Vehicle_SoundSourceClear;
						_veh animate ["Directional_Switch",0];
						_veh animate ["Directional_F",0];
					} else
					{
						_veh animateSource ["Lightbar",1];
						player action ["lightOn",_veh];
						_veh animate ["Directional_Switch",1];
						_veh animate ["Directional_F",1];
					};
				};
			};
		};
		case "Ship":
		{
			switch (_action) do
			{
				case 1 : /* Code 1, Turn everything off */
				{
					if (_veh animationPhase "SoundSource_1" > 0.5) then
					{
						_veh animateSource ["Lightbar",0];
					};
				};
				case 2 :
				{
					if (_veh animationPhase "SoundSource_1" < 0.5) then
					{
						_veh animate ["SoundSource_1",1, true];
					};
				};
			};
		};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_DestroyedMsg",
{
	["Server: One of your vehicles was destroyed, it has been removed from your storage", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Vehicle_Repair",
{
	private ["_car"];
	_car = param [0,objNull];
	if (isNull _car) exitwith {};
	if (animationstate player == "Acts_carFixingWheel") exitwith {["You are already repairing a vehicle", Color_Red] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {["System: You can't be inside a vehicle to repair this", Color_Red] call A3PL_Player_Notification;};
	if (player getVariable ["repairing",false]) exitwith {["You are already repairing a vehicle", Color_Red] call A3PL_Player_Notification;};

	player playmove "Acts_carFixingWheel";
	["System: You are now repairing this vehicle", Color_Yellow] call A3PL_Player_Notification;
	player setVariable ["repairing",true,false];
	[_car] spawn
	{
		private ["_t","_c","_car","_s"];
		_car = param [0,objNull];
		_t = 20; //seconds it takes to repair
		_c = 0; //countdown
		_s = false; //succeed?
		while {player getVariable ["repairing",false]} do
		{
			_c = _c + 1;
			if (!(vehicle player == player)) exitwith {}; //inside a vehicle
			if (!(player_itemClass == "repairwrench")) exitwith {}; //not carrying repair wrench anymore
			if (!(["repairwrench",1] call A3PL_Inventory_Has)) exitwith {}; //doesn't have a repair wrench in inventory array anymore
			if (player getVariable ["Incapacitated",false]) exitwith {}; //is incapacitated
			if (!alive player) exitwith {}; //is no longer alive
			if (!alive _car) exitwith {}; //car is no longer alive

			if (_c >= _t) exitwith {_s = true;}; //if _c reaches _t we exit the loop and set _s to true
			uiSleep 1;
		};

		player setVariable ["repairing",nil,false];
		if (!_s) exitwith
		{
			["System: Vehicle repairing failed", Color_Red] call A3PL_Player_Notification;
			[player_item] call A3PL_Inventory_Clear;
			if (vehicle player == player) then
			{
				player switchMove "";
			};
		};

		["Vehicle has been repaired", Color_Red] call A3PL_Player_Notification;
		_car setdammage 0;
		[player_item] call A3PL_Inventory_Clear;
		[[player,"repairwrench",-1],"Server_Inventory_Add",false,false] call BIS_FNC_MP;
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_Trailer_Unhitch",
{
	private ["_truck","_TruckArray","_FrontTrailer","_trailer"];
	_trailer = _this select 0;

	_TruckArray = nearestObjects [(_trailer modelToWorld [0,3,0]), A3PL_HitchingVehicles, 6.5];
	if (count _TruckArray == 0) exitwith {hintSilent "No vehicle nearby";};
	_Truck = _TruckArray select 0;

	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];


	_trailer animateSource ["Hitched",0];
	_truck animateSource ["Hitched",0];


	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];

}] call Server_Setup_Compile;


["A3PL_Vehicle_Trailer_Hitch",
{
	private ["_truck","_TruckArray","_FrontTrailer","_trailer","_offset","_ramp"];
	_trailer = param [0,objNull];
	_offset = 3;
	_ramp = false;
	if (typeOf _trailer IN ["A3PL_Lowloader"]) then
	{
		_offset = 5;
		if (_trailer animationPhase "ramp" > 0) then
		{
			_ramp = true;
		};
	};
	if (_ramp) exitwith
	{
		["System: Please raise the ramp before hitching the trailer", Color_Red] call A3PL_Player_Notification;
	};

	_TruckArray = nearestObjects [(_trailer modelToWorld [0,_offset,0]), A3PL_HitchingVehicles, 30];
	if (count _TruckArray == 0) exitwith {hintSilent "No vehicle nearby";};
	_truck = _truckArray select 0;
	_truck allowDamage false;

	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];

	switch(true) do {
		case (typeOf _trailer isEqualTo "A3PL_Lowloader"): {
			_trailer attachTo [_truck, [0, -6.185, -0.2]];
			detach _trailer;
		};
		case (typeOf _trailer isEqualTo "A3PL_Tanker_Trailer"): {
			_trailer attachTo [_truck, [0, -6.9, -0.05]];
			detach _trailer;
		};
		case (typeOf _trailer isEqualTo "A3PL_Box_Trailer"): {
			_trailer attachTo [_truck, [0, -7.9, -0.05]];
			detach _trailer;
		};

		//RAM
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -7.55, -0.85]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -4.485, -0.85]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck isEqualTo "A3PL_Ram")): {
			_trailer attachTo [_truck, [0, -5.48, -0.85]];
			detach _trailer;
		};

		//F150
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck IN ["A3PL_F150","A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -7.73, -0.28]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck IN ["A3PL_F150","A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -4.73, -0.48]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck IN ["A3PL_F150","A3PL_F150_Marker"])): {
			_trailer attachTo [_truck, [0, -5.75, -0.48]];
			detach _trailer;
		};

		//Silverado
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Silverado")): {
			_trailer attachTo [_truck, [0, -7.87, -0.42]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Silverado")): {
			_trailer attachTo [_truck, [0, -4.84, -0.53]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Silverado")): {
			_trailer attachTo [_truck, [0, -5.84, -0.53]];
			detach _trailer;
		};

		//Tahoe
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Tahoe")): {
			_trailer attachTo [_truck, [0, -7.5, -0.13]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Tahoe")): {
			_trailer attachTo [_truck, [0, -4.48, -0.31]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Tahoe")): {
			_trailer attachTo [_truck, [0, -5.5, -0.23]];
			detach _trailer;
		};

		//Wrangler
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -7.08, -0.9]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -4.02, -0.95]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -5.02, -1]];
			detach _trailer;
		};

		//X5
		case ((typeOf _trailer isEqualTo "A3PL_Car_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -7.28, -0.23]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -4.25, -0.35]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Wrangler")): {
			_trailer attachTo [_truck, [0, -5.25, -0.32]];
			detach _trailer;
		};

		//Camaro
		case ((typeOf _trailer isEqualTo "A3PL_Drill_Trailer") && (typeOf _truck == "A3PL_Camaro")): {
			_trailer attachTo [_truck, [0, -4.38, -0.32]];
			detach _trailer;
		};
		case ((typeOf _trailer isEqualTo "A3PL_Small_Boat_Trailer") && (typeOf _truck == "A3PL_Camaro")): {
			_trailer attachTo [_truck, [0, -5.36, -0.22]];
			detach _trailer;
		};

		default {};
	};

	if ((!(local _truck)) OR (!(local _trailer))) then
	{
		[[_truck,_trailer],"Server_Vehicle_Trailer_Hitch",false,false] call bis_fnc_mp;
	};
	

	_trailer animateSource ["Hitched",20];
	_truck animateSource ["Hitched",20];


	[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	[_truck] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerAttach",
{
	private ["_trailer","_boats","_boat"];

	_trailer = param [0,objNull];
	if (typeOf _trailer != "A3PL_Small_Boat_Trailer") exitwith {["System: Incorrect type (try again)", Color_Red] call A3PL_Player_Notification;};
	_boats = nearestObjects [_trailer, ["Ship"], 6];
	if (count _boats < 1) exitwith
	{
		["System: It doesn't seem like any boats are nearby", Color_Red] call A3PL_Player_Notification;
	};

	_boat = _boats select 0;

	switch (typeOf _boat) do
	{
		case ("A3PL_RHIB"): {_boat attachTo [_trailer,[0,-0.57,0.9]];};
		case default {_boat attachTo [_trailer,[0,-0.25,0.9]]; };
	};
	[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_BigTrailerAttach",
{
	private ["_trailer","_boats","_boat"];

	_trailer = param [0,objNull];
	//if (typeOf _trailer != "A3PL_Boat_Trailer") exitwith {["System: Incorrect type (try again)", Color_Red] call A3PL_Player_Notification;};
	_boats = nearestObjects [_trailer, ["Ship"], 12];
	if (count _boats < 1) exitwith
	{
		["System: It doesn't seem like any boats are nearby", Color_Red] call A3PL_Player_Notification;
	};

	_boat = _boats select 0;

	switch (typeOf _boat) do
	{
		case ("A3PL_RHIB"): {_boat attachTo [_trailer,[0,-0.57,0.9]];};
		case ("A3PL_RBM"): {_boat attachTo [_trailer,[-0.199707,-1.18896,2.68]];};
		case default {_boat attachTo [_trailer,[0,-0.25,0.9]]; };
	};
	[_boat] remoteExec ["Server_Vehicle_EnableSimulation", 2];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerRamp",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {["System: You are not looking at a trailer", Color_Red] call a3pl_player_notification;};
	if (!(_trailer isKindOf "Car")) exitwith {["System: You are not looking at a vehicle to lower/raise the ramp", Color_Red] call a3pl_player_notification;};
	if (!(local _trailer)) exitwith {["System: Locality issue, you are not the owner of this trailer. Re-hitch the trailer/re-enter the vehicle and try again", Color_Red] call a3pl_player_notification;};
	_truck = getPos _trailer nearestObject "A3PL_P362";
	//first check if ramp is up
	if ((_trailer animationPhase "ramp") < 0.5) then
	{
		//lower the ramp
		_trailer animate ["ramp",1];

		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationPhase "ramp" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationPhase "ramp" < 0.9) exitwith {_trailer animate ["ramp",0]};
			if (!(local _trailer)) exitwith {_trailer animate ["ramp",0]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	} else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehicles = _vehicles - [_truck];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 6.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

		//raise the ramp
		_trailer animate ["ramp",0];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_Toggle_Gooseneck",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {["System: You are not looking at a trailer", Color_Red] call a3pl_player_notification;};
	if (!(_trailer isKindOf "Car")) exitwith {["System: You are not looking at a vehicle to lower/raise the ramp", Color_Red] call a3pl_player_notification;};
	if (!(local _trailer)) exitwith {["System: Locality issue, you are not the owner of this trailer. Re-hitch the trailer/re-enter the vehicle and try again", Color_Red] call a3pl_player_notification;};
	_truck = getPos _trailer nearestObject "A3PL_P362";
	//first check if ramp is up
	if ((_trailer animationSourcePhase "Gooseneck_Hide") < 0.5) then
	{
		//lower the ramp
		_trailer animateSource ["Gooseneck_Hide",1];

		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationSourcePhase "Gooseneck_Hide" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationSourcePhase "Gooseneck_Hide" < 0.9) exitwith {_trailer animateSource ["Gooseneck_Hide",0]};
			if (!(local _trailer)) exitwith {_trailer animateSource ["Gooseneck_Hide",0]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	} else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehicles = _vehicles - [_truck];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 6.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

		//raise the ramp
		_trailer animateSource ["Gooseneck_Hide",0];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_TrailerAttachObjects",
{
	private ["_trailer"];
	_trailer = param [0,objNull];
	if (isNull _trailer) exitwith {["System: You are not looking at a trailer", Color_Red] call a3pl_player_notification;};
	if (!(_trailer isKindOf "Car")) exitwith {["System: You are not looking at a trailer", Color_Red] call a3pl_player_notification;};
	if (!(local _trailer)) exitwith {["System: Locality issue, you are not the owner of this trailer. Re-hitch the trailer/re-enter the vehicle and try again", Color_Red] call a3pl_player_notification;};
	//first check if ramp is up
	if ((_trailer animationsourcePhase "Ramp") < 0.5) then
	{
		//lower the ramp
		_trailer animatesource ["Ramp",1];
		[_trailer] spawn
		{
			private ["_trailer","_t"];
			_trailer = param [0,objNull];
			if (isNull _trailer) exitwith {};
			_t = 0;
			waitUntil {sleep 0.1; _t = _t + 0.1; (_t >= 6) OR ((_trailer animationsourcePhase "Ramp" >= 1))}; //wait until the the ramp is fully lowered
			if (_trailer animationsourcePhase "Ramp" < 0.9) exitwith {_trailer animatesource ["Ramp",0]};
			if (!(local _trailer)) exitwith {_trailer animatesource ["Ramp",0]};

			//disable simulation on trailer so vehicles can be moved up
			[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];

			//detach the vehicles on the trailer
			{
				detach _x;
			} foreach (attachedObjects _trailer);
		};
	} else
	{
		private ["_vehicles","_vehiclesTrailer"];

		//attach all vehicles on the trailer
		_vehicles = nearestObjects [_trailer, ["Air","Thing","LandVehicle","Ship"], 10]; //nearest vehicles
		_vehicles = _vehicles - [_trailer];
		_vehiclesTrailer = []; //vehicles actually on the trailer
		{
			if ((getpos _x) inArea [_trailer modelToWorld [0,0,0], 3.1, 1,(getDir _trailer+90), true]) then
			{
				_vehiclesTrailer pushback _x;
			};
		} foreach _vehicles;

		//attach only the vehicles on the actual trailer
		{
			//_x attachTo [_trailer];
			[_x,_trailer] call BIS_Fnc_AttachToRelative;
		} foreach _vehiclesTrailer;

		//enablesimulation on the trailer again
		[_trailer] remoteExec ["Server_Vehicle_EnableSimulation", 2];
		_trailer animatesource ["Ramp",0];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_AtegoLightbar",
{
	private ["_isOn"];

	_veh = param [0,objNull];
	if (isNull _veh) exitwith {};

	//first check if lightbar is on
	_isOn = _veh animationSourcePhase "lightbar" > 0;

	if (_isOn) then
	{
		//turn it off
		_veh animateSource ["lightbar",0];
		_veh animateSource ["beacons",0];
	} else
	{
		//turn vehicle lights on
		player action ["lightOn",_veh];
		//lightbar anims
		_veh animateSource ["lightbar",1];
		_veh animateSource ["beacons",1];
	};

}] call Server_Setup_Compile;


["A3PL_Vehicle_AtegoLower",
{
	private ["_veh","_car"];
	_veh = param [0,objNull];
	_car = objNull;

	//first make sure locality matches
	if (!local _veh) exitwith {["System: This vehicle is not local to you, please enter as the driver",Color_Red] call A3PL_Player_Notification;};

	//if there is a vehicle attached we need to make sure it moves along so lets execute our vehicle move function
	_attached = [_veh] call A3PL_Lib_Attached;
	{
		if (_x isKindOf "Car") exitwith {_car = _x};
	} foreach _attached;

	if ((!isNull _car) && (!local _car)) exitwith
	{
		["System: The vehicle on the flatbed is not local to you - request send to change locality - please try again in a moment",Color_Yellow] call A3PL_Player_Notification;
		//[[_car,player],"Server_Bowling_LocalityRequest",false,false] call BIS_fnc_MP;
		[_car,player] remoteExec ["Server_Bowling_LocalityRequest",2];
	};

	//okay we found a car that is attached
	if (!isNull _car) then
	{
		//detach it
		detach _car;

		//move it down with the bed
		_car setVariable ["originalMass",getMass _car,false];
		_car setMass 800;
		[_veh,_car,false] call A3PL_Vehicle_AtegoMoveCar;
	};

	//okay now animate the bed down
	_veh animateSource ["truck_flatbed",1];

	//wait until it reaches full extension
	waituntil {uiSleep 0.1; ((_veh animationSourcePhase "truck_flatbed") == 1)};

	//eject the player otherwise he will become stuck since simulation is disabled
	if (player IN _veh) then
	{
		moveOut player;
		["System: You have been ejected out of the vehicle, you cannot be in the vehicle while the flatbed is down",Color_Yellow] call A3PL_Player_Notification;
	};

	//send request to server to disable simulation globally upon reaching full extension
	[_veh] remoteExec ["Server_Vehicle_EnableSimulation", 2];

}] call Server_Setup_Compile;

//toggles rope (ONLY DOWN, UP IS HANDLED BY TOW)
["A3PL_Vehicle_TowTruck_Unloadcar",
{
	private ["_truck","_towpoint","_towing","_alignment","_distance","_height","_Eheight","_angle","_shift","_roleon","_pullup","_traytilt","_unload","_pushdown","_roleoff","_Ramp_up","_Edistance","_towingmass","_truckmass","_Fuel_lvl","_Supported_Vehicles","_UnSupported_Vehicles","_wheel1","_wheel2","_type","_stablecar","_stablize"];
	_truck = _this select 0;
	_towing = _truck getVariable "Towed_Car";
	if ((!local _truck) OR ((!isNull _towing) && (!local _towing))) exitWith {[player,_truck,_towing] remoteExec ["Server_Vehicle_AtegoHandle", 2];["System Locality Issue: Setting vehicle local to you"] call A3PL_Player_Notification;};
	if (_truck == _towing) exitWith {};
	_pushdown = true;
	_roleoff = true;
	_distance = 0;
	_Edistance = 0;
	_height = 0;
	_Eheight = 0;
	_shift = 0;
	_angle = 0;
	_towingXYZ = _towing getVariable "XYZ";
	_height = _towingXYZ select 0;
	_Edistance = _towingXYZ select 1;
	_distance = _towingXYZ select 2;
	_Eheight = _towingXYZ select 3;
	_towingdir = _towingXYZ select 4;
	_truckmass = _towingXYZ select 5;
	_towingmass = getMass _towing;
	//_totalmass = _truckmass - _towingmass;
	//_truck setMass [_totalmass,17];
	_Fuel_lvl = fuel _truck;
	//_truck setFuel 0;
	if ((_truck animationSourcePhase "truck_flatbed") < 0.5) then {[_truck,_angle] spawn A3PL_Vehicle_TowTruck_Ramp_down;}else {_angle = -0.230112;};
	while {_pushdown} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_Eheight],"flatbed_middle"];
		_distance = _distance - 0.01;
		_Eheight = _Eheight - 0.002346;
		if (_distance <= -2.2) then {_pushdown = false;_height = _Eheight;};
		sleep 0.01;
	};
	while {_roleoff} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_height],"flatbed_middle"];
		_towing setvectorUp [0,_angle,1];
		_distance = _distance - 0.012;
		_height = _height - 0.000846;
		_angle = _angle + 0.000846;
		If (_angle >= 0) then {_roleoff = false;};
		sleep 0.01;
	};
	//[_towing] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	detach _towing;
	_towing setPos getPos _towing;
	_towing setVelocity [0, 0, 1];
	//_truck setFuel _Fuel_lvl;
	_truck setVariable ["Towing",false,true];
	_towing setVariable ["Towed", false, true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Loadcar",
{
	private ["_truck","_towpoint","_towing","_alignment","_distance","_height","_Eheight","_angle","_shift","_roleon","_pullup","_traytilt","_unload","_pushdown","_roleoff","_Ramp_up","_Edistance","_towingmass","_truckmass","_Fuel_lvl","_Supported_Vehicles","_UnSupported_Vehicles","_wheel1","_wheel2","_type","_stablecar","_stablize"];
	_truck = _this select 0;
	_towpoint = "Land_HelipadEmpty_F" createVehicleLocal (getpos _truck);
	_towpoint attachTo [_truck,[0,-6.41919,-2.1209]];
	_towing = (getpos _towpoint) nearestObject "AllVehicles";
	_alignment = [_truck, _towing] call BIS_fnc_relativeDirTo;
	if ((_towpoint distance _towing) >= 6) exitWith {deleteVehicle _towpoint;["Towtruck: Vehicle too far away", Color_Yellow] call A3PL_Player_Notification;};
	deleteVehicle _towpoint;
	if (_alignment > 182) exitWith  {["Towtruck: Vehicle not positioned correctly", Color_Yellow] call A3PL_Player_Notification;};
	if (_alignment < 178) exitWith  {["Towtruck: Vehicle not positioned correctly", Color_Yellow] call A3PL_Player_Notification;};
	if ((_truck animationSourcePhase "truck_flatbed") < 0.5) exitWith {["Towtruck: Ramp needs to be on the ground", Color_Yellow] call A3PL_Player_Notification;};
	if (_truck == _towing) exitWith {["Towtruck: Vehicle not positioned correctly", Color_Yellow] call A3PL_Player_Notification;};
	if ((!local _truck) OR ((!isNull _towing) && (!local _towing))) exitWith {[player,_truck,_towing] remoteExec ["Server_Vehicle_AtegoHandle", 2];["System Locality Issue: Setting vehicle local to you"] call A3PL_Player_Notification;};
	{unassignVehicle _x;_x action ["EJECT", vehicle _x];sleep 0.4;} foreach crew _towing;
	_towing engineOn false;
    //[_towing] remoteExec ["Server_Vehicle_EnableSimulation", 2];
	sleep 0.5;
	_distance = -5.7323;
	_height = 0.373707;
	_Eheight = 0.373707;
	_angle = 0;
	_shift = 0;
	_towing setvectorUp [0,_angle,1];
	_towingdir = [_towing, _truck] call BIS_fnc_relativeDirTo;
	if (_towingdir > 170 && _towingdir < 190) then  {_towingdir = 180;} else {_towingdir = 0;};
	_roleon = true;
	_pullup = true;
	_traytilt = true;
	_unload = false;
	_pushdown = true;
	_roleoff = true;
	_Ramp_up = true;
	_Edistance = 0;
	_towingmass = getMass _towing;
	_truckmass = getMass _truck;
	_Fuel_lvl = fuel _truck;
	//_truck setFuel 0;
	_Supported_Vehicles = ["Jonzie_Datsun_Z432"];
	_UnSupported_Vehicles = ["A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_P362_TowTruck","A3PL_Box_Trailer","A3PL_Tanker_Trailer","A3PL_Lowloader","A3PL_Boat_Trailer","A3PL_MobileCrane"];
	if ((typeOf _towing) in _UnSupported_Vehicles) then {["Towtruck: You can't tow this vehicle", Color_Red] call A3PL_Player_Notification;};
	if !((typeOf _towing) in _Supported_Vehicles) then
	{
		_wheel1 = _towing selectionPosition "wheel_1_1_bound";
		_wheel2 = _towing selectionPosition "wheel_2_2_bound";

		_height = -(_wheel1 select 2) - 1;
		_Edistance = -((_wheel1 select 1)+(_wheel2 select 1))/2;
		_distance = _Edistance - 5.5;
		_shift = -((_wheel1 select 0)+(_wheel2 select 0))/2;
	};
	_type = typeOf _towing;
	switch (_type) do
	{
		case "A3PL_E350": {_height = _height - 0.2;_shift = _shift + 0.1;};
		case "Jonzie_Ambulance": {_height = _height - 0.2;_Edistance = _Edistance - 0.4;};
		case "A3PL_Small_Boat_Trailer": {_height = _height + 0.3;_Edistance = _Edistance - 1;_shift = _shift - 0.5;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Drill_Trailer": {_shift = _shift - 0.4;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MiniExcavator": {_towingmass = 2500;_height = _height + 0.5;_Edistance = _Edistance - 1.4;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
	};
	while {_roleon} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_height],"flatbed_middle"];
		_towing setDir _towingdir;
		_towing setvectorUp [0,_angle,1];
		_distance = _distance + 0.01;
		_height = _height + 0.000846;
		_angle = _angle - 0.000846;
		If (_angle <= -0.23) then {_roleon = false;_Eheight = _height;};
		sleep 0.01;
		//hintSilent format ["_distance %1,_height %2, _angle %3",_distance,_height,_angle];
	};
	while {_pullup} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" == 1};
		_towing attachTo [_truck,[_shift,_distance,_Eheight],"flatbed_middle"];
		_distance = _distance + 0.01;
		_Eheight = _Eheight + 0.002346;
		if (_distance >= _Edistance) then {_pullup = false;};
		sleep 0.01;
	};
	[_truck,_angle] spawn A3PL_Vehicle_TowTruck_Ramp_up;
	switch (_type) do
	{
		case "A3PL_E350": {_Endheight = _Eheight + 0.2;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "Jonzie_Ambulance": {_Endheight = _Eheight + 0.35;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Ram": {_Endheight = _Eheight - 0.1;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_PD": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_PD_Slicktop": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Tahoe_FD": {_Endheight = _Eheight - 0.05;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Camaro": {_Endheight = _Eheight + 0.04;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Gallardo": {_Endheight = _Eheight + 0.04;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MailTruck": {_Endheight = _Eheight - 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_VetteZR1": {_Endheight = _Eheight + 0.06;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_CRX": {_Endheight = _Eheight + 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Small_Boat_Trailer": {_Endheight = _Eheight + 0.08;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_Drill_Trailer": {_Endheight = _Eheight + 0.02;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_MiniExcavator": {_Endheight = _Eheight - 0.15;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
		case "A3PL_P362": {_Endheight = _Eheight + 0.2;_towing attachTo [_truck,[_shift,_distance,_Endheight],"flatbed_middle"];};
	};
	_totalmass = _towingmass + _truckmass;
	//_truck setMass [_totalmass,17];
	_towing setPos getPos _towing;
	//_truck setFuel _Fuel_lvl;
	_towing setVariable ["XYZ", [_height,_Edistance,_distance,_Eheight,_towingdir,_truckmass,_angle], true];
	_towing setVariable ["Towed", true, true];
	_truck setVariable ["Towed_Car",_towing,true];
	_truck setVariable ["Towing",true,true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Ramp_up",
{
	private ["_truck","_angle","_Ramp_up","_towing"];
	_truck = _this select 0;
	_angle = _this select 1;
	_towing = _truck getVariable "Towed_Car";
	_truck animateSource ["truck_flatbed",0];
	_truck animate ["Ramp_Switch",0];
	if (isNil {_towing}) exitWith  {};
	_Ramp_up = true;
	while {_Ramp_up} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" < 1};
		_angle = _angle + 0.00025567911;
		If (_angle >= -0.00153407466) then {_angle = 0;_Ramp_up = false;};
		_towing setvectorUp [0,_angle,1];
		sleep 0.01;
	};
	_towing setPos getPos _towing;
}] call Server_Setup_Compile;

["A3PL_Vehicle_TowTruck_Ramp_down",
{
	private ["_truck","_angle","_Ramp_down","_towing"];
	_truck = _this select 0;
	_angle = _this select 1;
	_towing = _truck getVariable "Towed_Car";
	_truck animateSource ["truck_flatbed",1];
	_truck animate ["Ramp_Switch",1];
	if (isNil {_towing}) exitWith  {};
	_Ramp_down = true;
	while {_Ramp_down} do
	{
		waitUntil {_truck animationSourcePhase "truck_flatbed" > 0.3};
		_angle = _angle - 0.00025567911;
		If (_angle <= -0.2301112) then {_angle = -0.2301112;_Ramp_down = false;};
		_towing setvectorUp [0,_angle,1];
		sleep 0.01;
	};
	_towing setPos getPos _towing;
}] call Server_Setup_Compile;

//used in admin menu to delete and also delete all attached objects
["A3PL_Vehicle_Despawn",
{
	private ["_veh"];
	_veh = param [0,objNull];

	[_veh] remoteExec ["Server_Vehicle_Despawn", 2];

}] call Server_Setup_Compile;


// made by Jonzie, added by Zan
['A3PL_Pickup_Ladder',
{
	private ["_Ladder"];
	_Ladder = _this select 0;
	_Ladder attachTo [player,  [0, 1, 0]];
	sleep 2;
	_Ladder setdir 180;
	Ladderkeydown =
	{
		_Ladder = nearestObject [player, "A3PL_Ladder"];
		_key = _this select 1;
		_return = false;

		switch _key do
		{
		 case 201:
			{
				_val = _Ladder animationPhase "Ladder";
				_valu = _val + 0.01;
				if (_valu >= 1) then {_valu = 1};
				_Ladder animate ["Ladder",_valu];
				_return = true;

			};
		 case 209:
			{
				_val = _Ladder animationPhase "Ladder";
				_valu = _val - 0.01;
				if (_valu <= 0) then {_valu = 0};
				_Ladder animate ["Ladder",_valu];
				_return = true;
			};
		};

		_return;
	};


waituntil {!(IsNull (findDisplay 46))};
_Ladderkeys = (FindDisplay 46) DisplayAddEventHandler ["keydown","_this call Ladderkeydown"];

waitUntil {attachedTo _Ladder != player};
(finddisplay 46) displayremoveeventhandler ["keydown",_Ladderkeys];

}] call Server_Setup_Compile;

["A3PL_Vehicle_Mooring",
{
	private ["_veh","_pos","_boat","_towpos","_rope_1","_MooringPos","_boatrope"];
	_veh = player_objintersect;
	_Pos = Player_NameIntersect;
	_boat = vehicle player;
	if (_boat == _veh) exitWith {};
	if (!(_boat isKindOf "Ship")) exitWith {["System: You must be in a boat",Color_yellow] call A3PL_Player_Notification;};
	_towpos = _boat selectionPosition ["Anchor", "Memory"];
	_MooringPos = _veh selectionPosition Player_NameIntersect;
	_boatrope = nearestObject [_boat, "rope"];
	if(_veh == (ropeAttachedTo _boat)) exitwith {{deleteVehicle _x;} forEach (nearestObjects [_boat, ["rope"], 5])};
	_Rope_1 = ropeCreate [_veh,_MooringPos, _boat, _towpos, 15];
}] call Server_Setup_Compile;

['A3PL_Vehicle_CreateRescueBasket', {
	private ['_veh'];
	_veh = vehicle player;
	_basket = "A3PL_RescueBasket" createVehicle [0,0,0];
	_basket allowdamage false;
	_basket setVariable ["locked",false,true];
	_basket attachTo [_veh, [0,999999,0] ];
	_veh setVariable ["basket",_basket,true];
	_basket setVariable ["vehicle",_veh,true];
},true] call Server_Setup_Compile;

['A3PL_Vehicle_Anchor', {
	private ["_veh","_typeOf","_anchor","_anchorX","_sealevel","_Anchorpos","_AnchorWorldpos","_AnchorX_pos","_AnchorX_Height","_Rope_1","_config_offsetY","_relPos","_offsetX","_offsetZ","_offsetY","_length"];
	_veh = _this select 0;
	_typeOf = typeOf _veh;
	_sealevel = abs (getTerrainHeightASL getPos _veh);
	_anchor = _veh getVariable "Boat_Anchor";
	if (isNil "_anchor") then {_anchor = objNull;};
	if ((speed _veh) > 5) exitWith {/*hintSilent "You need to stop first!";*/};
	if (_veh getVariable ["InUse",false]) exitWith {["System: Anchor already in use",Color_yellow] call A3PL_Player_Notification;};
	//if (!local _veh) exitwith {[netID _veh,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];["System: The boat is not local to you - request send to change locality - please try again",Color_yellow] call A3PL_Player_Notification;};
	if (isNull _anchor) then
	{
		_veh setVariable ["InUse",true,true];
		_Anchorpos = _veh selectionPosition "Anchor_Release";
		_AnchorWorldpos = _veh modelToWorld _Anchorpos;
		_anchorX = "A3PL_Anchor" createvehicle _AnchorWorldpos;
		_anchorX setPos [_AnchorWorldpos select 0,_AnchorWorldpos select 1,_AnchorWorldpos select 2];
		_AnchorX_pos = getPosATL _anchorX;
		_AnchorX_Height = _AnchorX_pos select 2;
		_Rope_1 = ropeCreate [_veh, "Anchor", _anchorX, [0, 0, 0.4], (_AnchorX_Height + 4)];//
		sleep 1;
		_anchor = "Land_HelipadEmpty_F" createvehicle _AnchorWorldpos;
		_anchor setDir getDir _veh;
		_veh setVariable ["Boat_Anchor",_anchor,true];
		sleep 0.5;
		/*while {_AnchorX_Height > 2} do {_AnchorX_pos = getPosATL _anchorX;_AnchorX_Height = _AnchorX_pos select 2;sleep 1;hintSilent format ["%1",_AnchorX_Height];};
		waitUntil {(not isNull _veh)};
		_anchor setPosATL [getPos _anchorX select 0, getPos _anchorX select 1, 0];
		_config_offsetY = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "offsetY");
		_config_offsetY = 9.5;
		_relPos = _anchor worldToModel position _veh;
		_offsetX = _relPos select 0;
		_offsetZ = _relPos select 1;
		_offsetY = _sealevel + _config_offsetY;
		_offsetY = _sealevel + 4;
		hintSilent format ["%1,%2",_config_offsetY,_sealevel];
		_veh attachTo [_anchor,[_offsetX,_offsetZ,_offsetY]];*/
		[_veh, _anchor] call BIS_fnc_attachToRelative;
		_veh setVariable ["InUse",false,true];
	}
	else
	{
		_veh setVariable ["InUse",true,true];
		if (count ropes _veh < 1) exitwith {_anchorX = nearestObject [_veh, "A3PL_Anchor"];_veh setVariable ["Boat_Anchor",objNull,true];deleteVehicle _anchor;deleteVehicle _anchorX;_veh setVariable ["InUse",false,true];};
		_Rope_1 = (ropes _veh) select 0;
		_length = ropeLength _Rope_1;
		_windspeed = (_length/10);
		if(typeOf _veh == "A3PL_Yacht")then {_Rope_1 = (nearestObjects [(_veh modeltoworld (_veh selectionPosition ["Anchor", "Memory"])), ["rope"], 30])select 0;};
		ropeUnwind [_Rope_1, _windspeed, 0];
		while {_length > 0.6} do {_length = ropeLength _Rope_1;sleep 0.2;};//hintSilent format ["%1",_length];
		waitUntil {_length < 0.6};
		sleep 2;
		_anchorX = nearestObject [_veh, "A3PL_Anchor"];
		if(typeOf _veh == "A3PL_Yacht")then {{deleteVehicle _x;} forEach (nearestObjects [(_veh modeltoworld (_veh selectionPosition ["Anchor", "Memory"])), ["rope"], 30])}else
		{{ropeDestroy _x;} foreach (ropes _veh)};
		detach _veh;
		sleep 0.1;
		_veh setVariable ["Boat_Anchor",objNull,true];
		deleteVehicle _anchor;
		deleteVehicle _anchorX;
		_veh setVariable ["InUse",false,true];
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_DisableSimulation",
{
	private["_veh"];
	_veh = _this select 0;
	if ((speed _veh) > 3) exitWith {["System: You need to stop the boat before disabling simulation!",Color_yellow] call A3PL_Player_Notification;};

	if ((typeOf _veh) IN ["A3PL_Cutter"]) then
	{
		if (simulationEnabled _veh) then
		{
			[_veh] remoteExec ["Server_Vehicle_EnableSimulation", 2];
			["System: You disabled simulation for this vehicle, you need to re-enable it to use doors or enter the seats!",Color_Green] call A3PL_Player_Notification;
		} else
		{

			[_veh] remoteExec ["Server_Vehicle_EnableSimulation", 2];
			["System: You enabled simulation for this vehicle, you can now use doors or enter the seats!",Color_Green] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Vehicle_SecureHelicopter",
{
	private ["_cutter","_helis","_heli"];

	_cutter = param [0,objNull];
	if (typeOf _cutter != "A3PL_Cutter") exitwith {["System: Incorrect type (try again)", Color_Red] call A3PL_Player_Notification;};
	_helis = nearestObjects [_cutter, ["A3PL_Jayhawk","C_Heli_Light_01_civil_F","Heli_Medium01_Coastguard_H","Heli_Medium01_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Medic_H","Heli_Medium01_Veteran_H"], 50];
	if (count _helis < 1) exitwith
	{
		["System: It doesn't seem like any helicopters are nearby", Color_Red] call A3PL_Player_Notification;
	};

	_heli = _helis select 0;


	switch (typeOf _heli) do
	{
		case ("A3PL_Jayhawk"): {_heli attachTo [_cutter,[0,-17,-5.5]];};
		case ("C_Heli_Light_01_civil_F"): {_heli attachTo [_cutter,[0,-17,-7.2]];};
		case ("Heli_Medium01_Coastguard_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Sheriff_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Luxury_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Military_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Medic_H"): {_heli attachTo [_cutter,[0,-17,-5]];};
		case ("Heli_Medium01_Veteran_H"): {_heli attachTo [_cutter,[0,-17,-5]];};

	};
	["System: Attached helicopter to cutter!", Color_Green] call A3PL_Player_Notification;

	[_heli] remoteExec ["Server_Vehicle_EnableSimulation", 2];

}] call Server_Setup_Compile;

["A3PL_Vehicle_UnsecureHelicopter",
{
	private ["_cutter","_helis","_heli"];

	_cutter = param [0,objNull];
	if (typeOf _cutter != "A3PL_Cutter") exitwith {["System: Incorrect type (try again)", Color_Red] call A3PL_Player_Notification;};
	_helis = nearestObjects [_cutter, ["A3PL_Jayhawk","C_Heli_Light_01_civil_F"], 50];
	if (count _helis < 1) exitwith
	{
		["System: It doesn't seem like any helicopters are nearby", Color_Red] call A3PL_Player_Notification;
	};

	_heli = _helis select 0;
	{
		detach _x;
	} foreach (attachedObjects _cutter);
	["System: Detached helicopter from cutter!", Color_Green] call A3PL_Player_Notification;

	[_heli] remoteExec ["Server_Vehicle_EnableSimulation", 2];

}] call Server_Setup_Compile;

["A3PL_Vehicle_Jerrycan",
{
	private ["_veh","_jerryCan","_newFuel"];
	 _veh = param [0,objNull];

	//exits
	if (isNull _veh) exitwith {};
	if (typeOf _veh IN ["A3PL_RBM","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H","A3PL_Motorboat","A3PL_RHIB","A3PL_Yacht"]) exitwith {["System:You can't a Jerry Can with this vehicle, it takes avgas (Kerosene)",Color_Red] call A3PL_Player_Notification;};
	if (player_itemClass != "jerrycan") exitwith {["System: You don't have a jerrycan",Color_Red] call A3PL_Player_Notification;};
	if (!local _veh) exitwith {["System Locality Issue: Only the last driver of the vehicle can fuel the vehicle, please enter and exit the driver seat first"] call A3PL_Player_Notification;};
	//take jerrycan from the player
	_jerryCan = Player_Item;
	[player_itemClass,-1] call A3PL_Inventory_Add;
	Player_Item = objNull;
	Player_ItemClass = '';

	//attach jerrycan to vehicle
	detach _jerryCan;
	_attachpoint = _veh selectionPosition "gasTank";
	_attachpoint set [0,(_attachPoint select 0) - 0.3];
	_attachpoint set [2,(_attachPoint select 2) + 0.2];
	_jerryCan attachTo [_veh,_attachpoint];
	_jerryCan setVectorDirAndUp [[0,1,0],[1,0,0]];
	playSound3D ["A3PL_Common\effects\gasoline.ogg", _jerrycan, false, getPos _jerryCan, 1.36, 1.1, 0];
	uiSleep 4.5;
	_jerryCan setVectorDirAndUp [[0,1,0],[0,0,1]];
	uiSleep 1;
	deleteVehicle _jerryCan;

	//give fuel
	_veh setFuel ((fuel _veh) + 0.25);

	//give emppty _jerryCan
	[[player,"jerrycan_empty",1],"Server_Inventory_Add",false,false] call BIS_FNC_MP;

}] call Server_Setup_Compile;

["A3PL_Create_RescueBasket",
{
	_veh = vehicle player;
	_basket = "A3PL_RescueBasket" createVehicle [0,0,0];
	_basket allowdamage false;
	_basket setVariable ["locked",false,true];
	_basket attachTo [_veh, [0,999999,0] ];
	_veh setVariable ["basket",_basket,true];
	_basket setVariable ["vehicle",_veh,true];
}] call Server_Setup_Compile;

["A3PL_Vehicle_GiveKeys",
{
	private ["_veh","_player","_target","_actualKeys","_vehName"];
	_player = param [0,objNull];
	_target = param [1,objNull];

	_veh = nearestObjects[getPos player,["Car","Ship","Truck","Plane","Air","Tank"],10];
	if ((count _veh) isEqualTo 0) exitWith {
		["There is no vehicle nearby!", Color_Red] remoteExec ["A3PL_Player_Notification", _player];
	};

	_veh = _veh select 0;
	if (((_veh getVariable ["owner",""]) select 0) != (getPlayerUID player)) exitWith {
		["The nearest vehicle is not yours!", Color_Red] remoteExec ["A3PL_Player_Notification", _player];
	};

	_actualKeys = _veh getVariable ["keyAccess",[""]];
	_actualKeys pushBack (getPlayerUID _target);
	_veh setVariable ["keyAccess",_actualKeys,true];
	_vehName = getText(configFile >> "cfgVehicles" >> typeOf _veh >> "DisplayName");
	[format["You gave the keys of your %1 to %2",_vehName,_target getVariable["name","ERROR"]], Color_Green] remoteExec ["A3PL_Player_Notification", _player];
	[format["%1 gave you the keys of his %2",_player getVariable["name","ERROR"], _vehName], Color_Green] remoteExec ["A3PL_Player_Notification", _target];

}] call Server_Setup_Compile;

["A3PL_Vehicle_Unflip",
{
	private ["_car","_success"];
	_car = param [0,objNull];
	if (isNull _car) exitwith {};
	if (animationstate player == "Acts_carFixingWheel") exitwith {["You are already repairing a vehicle", Color_Red] call A3PL_Player_Notification;};
	if (!(vehicle player == player)) exitwith {["System: You can't be inside a vehicle to repair this", Color_Red] call A3PL_Player_Notification;};
	if (player getVariable ["repairing",false]) exitwith {["You are already repairing a vehicle", Color_Red] call A3PL_Player_Notification;};

	["System: You are unflipping this vehicle", Color_Yellow] call A3PL_Player_Notification;

	Player_ActionCompleted = false;
	_success = true;

	["Unflipping...",15] spawn A3PL_Lib_LoadAction;
	while {sleep 0.5; !Player_ActionCompleted } do
	{
		if ((player distance2D _car) > 10) exitWith {["System: You have gone too far from the car!", Color_Red] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;}; //inside a vehicle
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;}; //is incapacitated
		if (!alive player) exitwith {_success = false;}; //is no longer alive
		player playmove "Acts_carFixingWheel";
	};

	if (!_success) exitWith {Player_ActionDoing = false;};

	[_car] spawn
	{
		private ["_car","_normalVec"];
		_car = param [0,objNull];
		_normalVec = surfaceNormal getPos _car;
		_car setVectorUp _normalVec;
		_car setPosATL [getPosATL _car select 0, getPosATL _car select 1, 0];
	};
	player switchMove "";
	["System: The vehicle has been unflipped!", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
