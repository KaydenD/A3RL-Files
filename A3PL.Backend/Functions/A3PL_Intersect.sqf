	//Player_ObjIntersect replaces cursortarget and is more reliable (is Nil when there is no intersection or object distance > 20m)
	//Player_ObjIntersect replaces cursortarget and is more reliable (is Nil when there is no intersection or object distance > 20m)
	//Player_NameIntersect returns the memory interaction point if
	//1. 2D distance (player-interaction point/memory point) < 3m
	//2. Object distance < 20m
	//Otherwise value returns ""
	// LIMITATION WARNING: If fire geometry and/or memory points are not properly setup some actions may not show up

// This will calculate a new array (based on defined condition) and feed it to A3PL_Intersect_Lanes based on current nameintersect
['A3PL_Intersect_ConditionCalc',
{
	_name = param[0, "null"];
	_newArray = [];
	_arrayToSearch = Config_IntersectArray;
	if ((typeOf vehicle player) IN Config_Intersect_Cockpits) then
	{
		_arrayToSearch = Config_Intersect_CockpitActions;
	};

	{
		if (_name ==  (_x select 0)) then
		{
			if (call (_x select 3)) then
			{
				_newArray pushback _x;
			};
		};
	} foreach _arrayToSearch;
	_newArray;
}] call Server_Setup_Compile;

['A3PL_Intersect_Spikes', {
	private ["_veh","_spike","_wheelLF","_wheelRF","_wheelLB","_wheelRB","_hit"];

	_veh = vehicle player;
	_spike = nearestObjects [player, ["A3PL_Stinger"], 3];
	if (count _spike < 1) exitwith {};
		_wheelLF = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [-1,1.1,-1]),AGLToASL (_veh modelToWorldVisual [-1,0,-3]),_veh];
		_wheelRF = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [1,1.1,-1]),AGLToASL (_veh modelToWorldVisual [1,0,-3]),_veh];
		_wheelLB = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [-1,-2.4,-1]),AGLToASL (_veh modelToWorldVisual [-1,-1.4,-3]),_veh];
		_wheelRB = lineIntersectsWith [AGLToASL (_veh modelToWorldVisual [1,-2.4,-1]),AGLToASL (_veh modelToWorldVisual [1,-1.4,-3]),_veh];

	//systemchat format ["%1 %2 %3 %4",_wheelLF,_wheelRF,_wheelLB,_wheelRB];

	_spike = _spike select 0;
	if (_spike IN _wheelLF) then
	{
		_hit = _veh getVariable "wheelLFSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelLFSpiked",true,false];
		"wheel_1_1_steering" call A3PL_Police_SpikeHit;
		[_veh] spawn {
			_veh = _this select 0;
			sleep 20;
			_veh setVariable ["wheelLFSpiked",nil,false];
		};
	};

	if (_spike IN _wheelRF) then
	{
		_hit = _veh getVariable "wheelRFSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelRFSpiked",true,false];
		"wheel_2_1_steering" call A3PL_Police_SpikeHit;
		[_veh] spawn {
			_veh = _this select 0;
			sleep 20;
			_veh setVariable ["wheelRFSpiked",nil,false];
		};
	};

	if (_spike IN _wheelLB) then
	{
		_hit = _veh getVariable "wheelLBSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelLBSpiked",true,false];
		"wheel_1_2_steering" call A3PL_Police_SpikeHit;
		[_veh] spawn {
			_veh = _this select 0;
			sleep 20;
			_veh setVariable ["wheelLBSpiked",nil,false];
		};
	};

	if (_spike IN _wheelRB) then
	{
		_hit = _veh getVariable "wheelRBSpiked";
		if (!isNil "_hit") exitwith {};
		_veh setVariable ["wheelRBSpiked",true,false];
		"wheel_2_2_steering" call A3PL_Police_SpikeHit;
		[_veh] spawn {
			_veh = _this select 0;
			sleep 20;
			_veh setVariable ["wheelRBSpiked",nil,false];
		};
	};
}] call Server_Setup_Compile;

//Our exclusion for Intersect_Lines, this is an alternative drawIcon function for cockpit interactions
["A3PL_Intersect_Cockpit",
{
	private ["_obj","_actions","_finalActions","_config","_doubles","_countConfig","_interactWith","_newConfig"];
	_obj = vehicle player;

	//get a list of the actual actions
	_config = [];
	{
		if (call (_x select 3)) then
		{
			_config pushback _x;
		};
	} foreach Config_Intersect_CockpitActions;
	if (count _config == 0) exitwith {};

	//draw all the icons that should be displayed, but exclude any double entries
	_doubles = [];
	{
		_name = _x select 0;
		if (_name IN _doubles) then {} else
		{
			_doubles pushback _name;
			_posAGL = _obj modelToWorldVisual (_obj selectionPosition [_name,"Memory"]);
			_icon = _x select 2;
			drawIcon3D [_icon, [1,1,1,1], _posAGL, 1, 1, 45,"", 1, 0.05, "PuristaSemiBold"];
		};
	} foreach _config;

	//check if we are looking near any of the icons
	{
		private ["_name"];
		_name = _x select 0;
		_configVec = _x select 4;
		_playerVec = ((vectorDirVisual _obj) vectorDotProduct (getCameraViewDirection player)) - 0.05;

		if ((_configVec > _playerVec) && (_configVec < (_playerVec + 0.1))) exitwith
		{
			_interactWith = _name;
		};
	} foreach _config;

	//only do this when we are interacting with something
	if (!isNil "_interactWith") then
	{
		//clear the _config with only the items we are looking at
		_newConfig = [];
		{
			if ((_x select 0) == _interactWith) then
			{
				_newConfig pushback _x;
			};
		} foreach _config;
		_config = _newConfig;

		//not sure what this does anymore, but its needed
		_countConfig = (count _config) - 1;
		if (player_selectedIntersect > _countConfig) then
		{
			player_selectedIntersect = _countConfig;
		};

		//our _posAGL
		_posAGL = _obj modelToWorldVisual (_obj selectionPosition [_interactWith,"Memory"]);

		//display current actions
		_configSel = _config select Player_selectedIntersect;
		_name = format ["→ %1 ←",_configSel select 1];
		drawIcon3D ["", [1,1,1,1], _posAGL, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];

		//Okay so now lets take care of the actions above and below
		if (_countConfig > player_selectedIntersect) then
		{
			_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) - 0.03];
			_configSel = _config select (Player_selectedIntersect + 1);
			_name = _configSel select 1;
			_icon = _configSel select 2;
			drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
		};

		if (player_selectedIntersect > 0) then
		{
			_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) + 0.04];
			_configSel = _config select (Player_selectedIntersect - 1);
			_name = _configSel select 1;
			_icon = _configSel select 2;
			drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
		};

		//and finally set our vars, so that our quickaction function can use it
		Player_NameIntersect = _interactWith;
		Player_ObjIntersect = _obj;
	} else
	{
		Player_ObjIntersect = objNull;
		Player_NameIntersect = "";
	};
}] call Server_Setup_Compile;

['A3PL_Intersect_Lines', {
		if (isDedicated) exitwith {};

		["A3PL_Intersect_Lines", "onEachFrame", {

			//Spikestrip code
			if (count (nearestObjects [player, ["A3PL_Stinger"], 3]) > 0) then
			{
				if (_veh == player) exitwith {};
				[] call A3PL_Intersect_Spikes;
			};

			//if we are inside a specific cockpit/vehicle we will exit here and switch to our alternative method of handling intersections
			if (((typeOf vehicle player) IN Config_Intersect_Cockpits) && (cameraView == "INTERNAL")) exitwith
			{
				[] call A3PL_Intersect_Cockpit;
			};

			_begPos = positionCameraToWorld [0,0,0]; // <----- THIS IS WHERE THE ISSUE IS MOST LIKELY
			_begPosASL = AGLToASL _begPos;
			_endPos = positionCameraToWorld [0,0,1000]; // <----- THIS IS WHERE THE ISSUE IS
			_endPosASL = AGLToASL _endPos;

			_ins = lineIntersectsSurfaces [_begPosASL, _endPosASL, player, objNull, true, 1, "FIRE", "NONE"];
			_isWHS = (typeOf cursorObject) IN ["WeaponHolderSimulated"];
			if (_ins isEqualTo []) exitWith {};
			
			_ins select 0 params ["_pos", "_norm", "_obj", "_parent"];

			if (isNull _obj && !_isWHS) exitwith
			{
				private ["_cur"];
				_cur = cursortarget;
				if (!isNull cursortarget) exitwith
				{
					Player_ObjIntersect = cursortarget;
					Player_NameIntersect = "";
					{
						if (_x select 0 == (typeOf _cur)) then
						{
							private ["_name","_icon"];
							_name = _x select 1;
							_icon = _x select 2;
							drawIcon3D [_icon, [1,1,1,1], getpos _cur, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
						};
					} foreach Config_Intersect_NoNameNoFire; //this config contains objects which does not contain a named intersection nor fire geometry, but does return a cursortarget object
				};
				Player_ObjIntersect = player;
				Player_NameIntersect = "";
			};

			if(_isWHS) then {
				_obj = cursorObject;
				_parent = cursorObject;
			};

			if (((!(getModelInfo _parent select 2)) && !_isWHS) OR (((player distance _obj) > 20) && !(typeOf _obj == "Land_buildingsCasino2"))) exitWith {
				Player_NameIntersect = "";
				Player_ObjIntersect = _obj;

				{
					if (_x select 0 == (typeOf _obj)) then
					{
						private ["_name","_icon"];
						_name = _x select 1;
						_icon = _x select 2;
						drawIcon3D [_icon, [1,1,1,1], getpos _obj, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
					};
				} foreach Config_Intersect_NoName;

			};

			_ins2 = [_parent, "FIRE"] intersect [_begPos, _endPos];

			if (_ins2 isEqualTo [] && !_isWHS) exitWith {
				Player_NameIntersect = "";
				Player_ObjIntersect = _veh;

				if ((typeOf (nearestObject [player, "GroundWeaponHolder"])) == "GroundWeaponHolder") then
				{
					if (([eyepos player nearestObject "GroundWeaponHolder",eyepos player] call bis_fnc_distance2d) < 1.1) then
					{
						private ["_cur"];
						_cur = (eyepos player) nearestObject "GroundWeaponHolder";
						Player_ObjIntersect = _cur;
						Player_NameIntersect = "";
						{
							if (_x select 0 == (typeOf _cur)) then
							{
								private ["_name","_icon"];
								_name = _x select 1;
								_icon = _x select 2;
								drawIcon3D [_icon, [1,1,1,1], getpos _cur, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
							};
						} foreach Config_Intersect_NoNameNoFire;
					};
				};


				if ((typeOf cursortarget) IN ["GroundWeaponHolder"]) exitwith
				{
						private ["_cur"];
						_cur = cursortarget;
						Player_ObjIntersect = _cur;
						Player_NameIntersect = "";
						{
							if (_x select 0 == (typeOf _cur)) then
							{
								private ["_name","_icon"];
								_name = _x select 1;
								_icon = _x select 2;
								drawIcon3D [_icon, [1,1,1,1], getpos _cur, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];
							};
						} foreach Config_Intersect_NoNameNoFire;
				};
			};

			if(_isWHS) then {
				_ins2 = [["", ""]];			
			};
			_ins2 select 0 params ["_name", "_dist"];
			_posAGL = _obj modelToWorldVisual [.1,.55,-.61];

			if (!_isWHS) then {
				_posAGL = _obj modelToWorldVisual (_obj selectionPosition [_name,"Memory"]);
			} else {
				_name = "headBag";
			};
			
			diag_log _name;

			if (([_posAGL,ASLToAGL (getposASL player)] call BIS_fnc_distance2D) > 3) exitwith {
				Player_NameIntersect = "";
				Player_ObjIntersect = _obj;
			};

			if (player_nameIntersect != _name) then
			{
				Player_selectedIntersect = 0;
			};

			Player_NameIntersect = _name;
			Player_ObjIntersect = _obj;

			_icon = "\a3\ui_f\data\map\GroupIcons\icon_default.paa";

			_config = (_name call A3PL_Intersect_ConditionCalc);
			//This is the count of config (1 == 0)
			_countConfig = (count _config) - 1;
			if ( player_selectedIntersect > _countConfig) then
			{
				player_selectedIntersect = _countConfig;
			};

			if(player_selectedIntersect < 0) exitWith {};

			_configSel = _config select Player_selectedIntersect;
			_name = format ["→ %1 ←",_configSel select 1];
			_icon = _configSel select  2;

			drawIcon3D [_icon, [1,1,1,1], _posAGL, 1, 1, 45,_name, 1, 0.05, "PuristaSemiBold"];

			//Okay so now lets take of the actions above and below
			if (_countConfig > player_selectedIntersect) then
			{
				_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) - ((_begPosASL distance _posAGL) / 50)];
				_configSel = _config select (Player_selectedIntersect + 1);
				_name = _configSel select 1;
				_icon = _configSel select 2;
				drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
			};


			if (player_selectedIntersect > 0) then
			{
				_posAGL = [_posAGL select 0,_posAGL select 1, (_posAGL select 2) + ((_begPosASL distance _posAGL) / 35)];
				_configSel = _config select (Player_selectedIntersect - 1);
				_name = _configSel select 1;
				_icon = _configSel select 2;
				drawIcon3D ["", [1,1,1,1], _posAGL, 0, 0, 0,_name, 1, 0.036, "PuristaSemiBold"];
			};

		}] call BIS_fnc_addStackedEventHandler;
}] call Server_Setup_Compile;

//Currently has a limit of 20m. Can be changed in A3PL_Intersect_Lines
//This function simply returns player object if player is not looking at anything (aka nothing is being intersected)
['A3PL_Intersect_Cursortarget', {
	if (isNil "Player_ObjIntersect") exitwith {player};

	Player_ObjIntersect
}] call Server_Setup_Compile;

['A3PL_Intersect_CursortargetName', {
	if (isNil "Player_NameIntersect") exitwith {player};

	Player_NameIntersect
}] call Server_Setup_Compile;

['A3PL_Intersect_HandleDoors', {
	//Handles the door opening closing since some objects have different animationsource names
	private ["_obj","_name","_split"];
	_obj = call A3PL_Intersect_cursortarget;
	_name = Player_NameIntersect;

	//run prison script
	if (typeOf _obj == "Land_A3PL_Prison") exitwith
	{
		[_obj,_name] call A3PL_Prison_HandleDoor;
	};

	_split = _name splitstring "_";

	//PD script
	/*
	if (typeOf _obj == "Land_A3PL_Sheriffpd") exitwith
	{
		if (count _split > 2) then
		{
			_doorN = _split select 1;//doornumber
			[_obj,format ["%1_%2",_split select 0,_split select 1]] call A3PL_Lib_ToggleAnimation;
		};
	};
	*/

	//garage door
	if (((_split select 0) find "garagedoor") != -1) exitwith
	{
		if ((typeOf _obj) IN ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Greenhouse","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1"]) exitwith
		{
			if (isNil {_obj getVariable "unlocked"}) exitwith
			{
				_format = format['System: This garage is locked'];
				[_format, Color_Red] call A3PL_Player_Notification;
			};

			if (count _split > 2) then
			{
				[_obj,(_split select 0),false] call A3PL_Lib_ToggleAnimation;
			} else
			{
				[_obj,(_split select 0)] call A3PL_Lib_ToggleAnimation;
			};

		};

		_canUse = true;
		switch (typeOf _obj) do
		{
			case ("Land_A3PL_Firestation"): {
				if (!((player getVariable ["job","unemployed"]) IN ["fifr"]) && !(["vfd",player] call A3PL_DMV_Check)) exitwith {
					_canUse = false;
				};
			};
		};

		if (!_canUse) exitwith {["System: You can't use this door/button"] call A3PL_Player_Notification;};

		[_obj,(_split select 0)] call A3PL_Lib_ToggleAnimation;
	};

	//normal door handle
	if ((_split select 0) == "door") then
	{
		private ["_canUse"];

		//sometimes we can't use a door like a cell door
		_canUse = true;
		switch (typeOf _obj) do
		{
			case ("Land_A3PL_Sheriffpd"): { if ((_name IN ["door_3","door_4","door_11","door_18","door_19","door_20","garagedoor_button"]) && !((player getVariable ["job","unemployed"]) IN ["police","uscg"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Clinic"): { if ((_name IN ["door_5","door_6","door_7","door_8","door_9","door_10","door_11"]) && !((player getVariable ["job","unemployed"]) IN ["fifr"])) exitwith {_canUse = false}; };
			case ("Land_A3PL_Prison"): { if (((_name find "button") != -1) && ((player getVariable ["job","unemployed"]) != "police")) exitwith {_canUse = false}; };
			case ("Land_A3PL_Firestation"): { if ((player getVariable ["job","unemployed"]) != "fifr") exitwith {_canUse = false}; };
		};
		if (!_canUse) exitwith {["System: You can't use this door/button"] call A3PL_Player_Notification;};

		//house
		if ((typeOf _obj) IN ["Land_A3PL_Motel","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Greenhouse","Land_Mansion01","Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3"]) exitwith
		{
			switch (true) do
			{
				case ((typeOf _obj) == "Land_A3PL_Motel"):
				{
					if (_name IN ["door_9","door_10","door_11","door_12","door_13","door_14","door_15","door_16"]) then
					{
						if ((_obj getVariable ["Door_1_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_2_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_3_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_4_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_5_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_6_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_7_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
						if ((_obj getVariable ["Door_8_locked",true])) exitwith {_format = format['System: This door is locked'];[_format, Color_Red] call A3PL_Player_Notification;};
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3"]):
				{
					if (_name IN ["door_1","door_2","door_3"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format['System: This door is locked'];
							[_format, Color_Red] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) == "Land_Mansion01"):
				{
					if (_name IN ["door_8","door_1"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format['System: This door is locked'];
							[_format, Color_Red] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};

				case ((typeOf _obj) IN ["Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_Greenhouse","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4"]):
				{
					if (_name IN ["door_1","door_2"]) then
					{
						if (isNil {_obj getVariable "unlocked"}) exitwith
						{
							_format = format['System: This door is locked'];
							[_format, Color_Red] call A3PL_Player_Notification;
						};

						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					} else
					{
						[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;
					};
				};
			};
		};

		//animate the door
		[_obj,format ["%1_%2",(_split select 0),(_split select 1)],false] call A3PL_Lib_ToggleAnimation;

		//in some cases 2 doors need to open (sheriff PD)
		if ((_name IN ["door_3_button","door_3_button2","door_5_button","door_5_button2","door_7_button","door_7_button2","door_9_button","door_9_button2"]) && ((typeOf _obj) == "Land_A3PL_Sheriffpd")) then
		{
			_doorN = (parseNumber (_split select 1)) + 1;
			[_obj,format ["%1_%2",(_split select 0),_doorN],false] call A3PL_Lib_ToggleAnimation;
		};
	};

	/* old shit
	_CatalinaObjects = ["Land_Coffee_DED_Coffee_02_F","Land_Bank_DED_House_01_F","Land_Ranch_DED_Ranch_02_F","Land_Ranch_DED_Ranch_01_F"];
	_CatalinaHouses = ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Greenhouse"];
	_Other = ["A3PL_Jayhawk_Normal","Land_A3PL_Clinic","Land_A3PL_Cinema","land_market_ded_market_01_f","A3PL_Yacht","A3PL_Yacht_Pirate","land_market_ded_market_05_f","land_smallshop_ded_smallshop_01_f","land_smallshop_ded_smallshop_02_f","Land_A3PL_Showroom","Land_A3PL_Sheriffpd","Land_Taco_DED_Taco_01_F","Land_A3PL_Gas_Station"];
	_Lockers = ["Land_A3PL_Locker"];

	if ((typeOf _obj) == "Land_Bank_DED_House_01_F") exitwith
	{
		[_obj,_name,false] call A3PL_Lib_ToggleAnimation;
	};

	if ((typeOf _obj) IN _CatalinaHouses) exitwith
	{

		if (_name == "garagebutton") exitwith
		{
			if (_obj animationSourcePhase "Door" < 0.5) then
			{
				_obj animateSource ["door",1];
			} else
			{
				_obj animateSource ["door",0];
			};
		};

		if (_name IN ["door1","door2","door3"]) then
		{
			_unlocked = _obj getVariable "unlocked";
			if (isNil "_unlocked") exitwith
			{
				_format = format['System: This door is locked'];
				[_format, Color_Red] call A3PL_Player_Notification;
			};

			if (_obj animationPhase _name < 0.5) then
			{
				_obj animate [_name,1];
			} else
			{
				_obj animate [_name,0];
			};
		} else
		{
			if (_obj animationPhase _name < 0.5) then
			{
				_obj animate [_name,1];
			} else
			{
				_obj animate [_name,0];
			};
		};
	};

	if ((typeOf _obj) == "Land_A3PL_Motel") exitwith
	{

		if (_name IN ["door1_2","door2_2","door3_2","door4_2","door5_2","door6_2","door7_2","door8_2"]) exitwith
		{
			if (_obj animationPhase _name < 0.5) then
			{
				_obj animate [_name,1];
			} else
			{
				_obj animate [_name, 0];
			};
		};

		_unlocked = _obj getVariable [(format ["%1_unlocked",(_name splitString "_") select 0]),Nil];
		if (!isNil "_unlocked") then
		{
			if (_obj animationPhase _name < 0.5) then
			{
				_obj animate [_name,1];
			} else
			{
				_obj animate [_name,0];
			};
		} else
		{
			_format = format["System: This door is locked"];
			[_format, Color_Red] call A3PL_Player_Notification;
		};
	};

	//Open door as normal if this is an A3PL building, because these are public places
	if ((typeOf _obj) IN _Other) exitwith
	{
		if (typeOf _obj == "land_a3pl_sheriffpd") exitwith
		{
			if (_name IN ["door1","door2"]) then
			{
				if (_obj animationPhase _name < 0.5) then
				{
					_obj animate [_name,1];
				} else
				{
					_obj animate [_name,0];
				};
			};
		};

		if (_obj getVariable ["locked",false]) exitwith
		{
			_format = format['System: This door is locked'];
			[_format, Color_Red] call A3PL_Player_Notification;
		};

		if (_obj animationPhase _name < 0.5) then
		{
			_obj animate [_name,1];
		} else
		{
			_obj animate [_name,0];
		};
	};

	if ((typeOf _obj) IN _CatalinaObjects) exitwith
		{
			if (_name == "door1") then
			{
				if (_obj animationPhase "Door_1_rot" < 0.5) then {
					_obj animate ["Door_1_rot",1];
				} else
				{
					_obj animate ["Door_1_rot",0];
				};
			};

			if (_name == "door2") then
			{
				if (_obj animationPhase "Door_2_rot" < 0.5) then {
					_obj animate ["Door_2_rot",1];
				} else
				{
					_obj animate ["Door_2_rot",0];
				};
			};

			if (_name == "door3") then
			{
				if (_obj animationPhase "Door_3_rot" < 0.5) then {
					_obj animate ["Door_3_rot",1];
				} else
				{
					_obj animate ["Door_3_rot",0];
				};
			};

			if (_name == "door4") then
			{
				if (_obj animationPhase "Door_4_rot" < 0.5) then {
					_obj animate ["Door_4_rot",1];
				} else
				{
					_obj animate ["Door_4_rot",0];
				};
			};

			if (_name == "door5") then
			{
				if (_obj animationPhase "Door_5_rot" < 0.5) then {
					_obj animate ["Door_5_rot",1];
				} else
				{
					_obj animate ["Door_5_rot",0];
				};
			};

			if (_name == "door6") then
			{
				if (_obj animationPhase "Door_6_rot" < 0.5) then {
					_obj animate ["Door_6_rot",1];
				} else
				{
					_obj animate ["Door_6_rot",0];
				};
			};
		};

	if ((typeOf _obj) == "Land_A3PL_Garage") exitwith
	{
		if (_name == "door1") then
		{
			if (_obj animationPhase "door1" < 0.5) then {
				_obj animate ["door1",1];
			} else
			{
				_obj animate ["door1",0];
			};
		};

		if (_name == "garage_1_button") then
		{
			if (_obj animationSourcePhase "GarageDoor1" < 2) then {
				_obj animateSource ["GarageDoor1",3.1];
			} else
			{
				_obj animateSource ["GarageDoor1",0];
			};
		};

		if (_name == "garage_2_button") then
		{
			if (_obj animationSourcePhase "GarageDoor2" < 2) then {
				_obj animateSource ["GarageDoor2",3.1];
			} else
			{
				_obj animateSource ["GarageDoor2",0];
			};
		};
	};

	if ((typeOf _obj) == "Land_A3PL_CH") exitwith
	{

		if (_name IN ["door1","door2","door3","door4","door5","door6","door7"]) then
		{

			if (_obj animationPhase _name < 0.5) then
			{
				_obj animate [_name,1];
			} else
			{
				_obj animate [_name,0];
			};
		};

		if (_name IN ["door8_button1","door8_button2"]) then
		{
			if (_obj animationPhase "door8" < 0.5) then
			{
				_obj animate ["door8",1];
			} else
			{
				_obj animate ["door8",0];
			};
		};
	};

	if ((typeOf _obj) == "land_a3pl_firestation") exitwith
	{

		switch (true) do
		{
			case (_name IN ["big_door_1_1_2","big_door_1_2_2","big_door_1_switch_1","big_door_1_switch_2"]): {_name = "big_door_1";};
			case (_name IN ["big_door_2_1_2","big_door_2_2_2","big_door_2_switch_1","big_door_2_switch_2"]): {_name = "big_door_2";};

			case (_name IN  ["bay_door_1","bay_door_1_switch_1"]): {_name = "bay_1";};
			case (_name IN  ["bay_door_2","bay_door_2_switch_1"]): {_name = "bay_2";};
			case (_name IN  ["bay_door_3","bay_door_3_switch_1"]): {_name = "bay_3";};
			case (_name IN  ["bay_door_4","bay_door_4_switch_1"]): {_name = "bay_4";};
			case (_name IN  ["bay_door_5","bay_door_5_switch_1"]): {_name = "bay_5";};
			case (_name IN  ["bay_door_6","bay_door_6_switch_1"]): {_name = "bay_6";};
			case (_name IN  ["bay_door_7","bay_door_7_switch_1"]): {_name = "bay_7";};
			case (_name IN  ["bay_door_8","bay_door_8_switch_1"]): {_name = "bay_8";};
		};

		[_obj,_name] call A3PL_Lib_ToggleAnimation;

	};
	*/
}] call Server_Setup_Compile;
