["A3PL_Lib_CloseInventoryDialog",
{
	private ["_t"];
	_t = 0;
	while {isNull (findDisplay 602)} do
	{
		uiSleep 0.1;
		_t = _t + 0.1;
		if (_t > 5) exitwith {};
	};
	closeDialog 602;

}] call Server_Setup_Compile;

["A3PL_Lib_Skiptime",
{
	private ["_amount"];

	_amount = param [0,1];
	skiptime _amount;
}] call Server_Setup_Compile;

//Returns all the players on a specific faction
["A3PL_Lib_FactionPlayers",
{
	private ["_factionPeople","_faction"];
	_faction = param [0,"unemployed"];
	_returnID = param [1,false];

	//return list of people on a faction
	_factionPeople = [];
	{
		if ((_x getVariable ["job","unemployed"] == _faction)) then
		{
			if (_returnID) then
			{
				_factionPeople pushback (owner _x);
			} else
			{
				_factionPeople pushback _x;
			};
		};
	} foreach allPlayers;

	_factionPeople;
}] call Server_Setup_Compile;

//Converts a UID to a object, returns objNull if doesn't exist
["A3PL_Lib_UIDToObject",
{
	private ["_uid","_player"];
	_uid = param [0,""];
	_player = objNull;
	{
		if (getPlayerUID _x == _uid) exitwith
		{
			_player = _x;
		};
	} foreach allPlayers;
	_player
}] call Server_Setup_Compile;

//Forces the player to become a ragdoll
['A3PL_Lib_Ragdoll', {
    if (vehicle player != player) exitWith {};
    private "_can";
    _can = "Land_Can_V3_F" createVehicleLocal [0,0,0];
	player allowDamage false;
    _can setMass 1e10;
    _can attachTo [player, [0,0,0], "Spine3"];
    _can setVelocity [0,0,6];
    detach _can;
	disableUserInput true;
    _can spawn {
		sleep 0.1;
		player setVelocity [0,0,20];
		sleep 0.1;
        deleteVehicle _this;
		sleep 1;
		player allowDamage true;
		uiSleep 25;
		disableUserInput false;
		disableUserInput true;
		disableUserInput false;
    };
}] call Server_Setup_Compile;

["A3PL_Lib_ChangeLocality",
{
	private ["_veh", "_player"];
	_veh = param [0,objNull,[objNull,""]];
	_player = param [1,objNull,[objNull,""]];

	if (typeName _veh == "STRING") then { _veh = objectFromNetId _veh; }; //netId is better than sending objects across the network
	if (typeName _player == "STRING") then { _player = objectFromNetId _player; };

	_veh setOwner (owner _player);
}] call Server_Setup_Compile;

//Formats _number with correct commas
['A3PL_Lib_FormatNumber', {
	private ["_number", "_return"];

	_number = [_this, 0, 0, [0]] call BIS_fnc_param;
	_return = [_number, 1, 0, true] call CBA_fnc_formatNumber;

	_return;
}] call Server_Setup_Compile;

//Formats _seconds into correct _format (MM:SS | HH:MM:SS | etc)
['A3PL_Lib_FormatTime', {
	private ["_seconds", "_format", "_return"];

	_seconds = [_this, 0, 0, [0]] call BIS_fnc_param;
	_format = [_this, 1, 'MM:SS', ['']] call BIS_fnc_param;
	_return = [_seconds, _format] call CBA_fnc_formatElapsedTime;

	_return;
}] call Server_Setup_Compile;

//opens dialogs
['A3PL_Lib_CreateDialog', {
	private ['_name'];

	_name = [_this, 0, '', ['']] call BIS_fnc_param;

	createDialog _name;
}] call Server_Setup_Compile;

//closes dialog
['A3PL_Lib_CloseDialog', {
	private ['_number'];

	_number = [_this, 0, 0, [0]] call BIS_fnc_param;

	closeDialog _number;
}] call Server_Setup_Compile;

//refreshes cursorTarget
['A3PL_Lib_RevealNearest', {
	{
		player reveal _x;
	} forEach (nearestObjects [(vehicle player), [], 10]);
}] call Server_Setup_Compile;

//Returns true if _object is within the _distance of _target
//WARNING COMPILE BLOCK FUNCTION
['A3PL_Lib_InDistance', {
	private ['_object', '_target', '_distance'];

	_object = [_this, 0, objNull, [player]] call BIS_fnc_param;
	_target = _this select 1;
	_distance = [_this, 2, 0, [0]] call BIS_fnc_param;

	if ((typeName _target) == "STRING") then {
		_target= call compile _target;
	};

	if ((_object distance _target) <= _distance) exitWith {
		true
	};

	false;
},false,true] call Server_Setup_Compile;

//Returns the distance (number) to a specific memorypoint of object, returns -1 if mem point or object not found
['A3PL_Lib_MemPointDistance', {
	private ['_mempoint', '_target','_selectionPosition'];

	_target = _this select 0; // Object

	if (_target == objNull) exitwith {-1};

	_mempoint = _this select 1; //Memory point

	_selectionPosition = _target selectionPosition [_mempoint, "Memory"];

	if ([[0,0,0], _selectionPosition] call BIS_fnc_areEqual) exitwith {-1};

	_distance = player distance (_target modelToWorld _selectionPosition);

	_distance;
}] call Server_Setup_Compile;

//Makes sure that hunger doesn't go over 100
['A3PL_Lib_VerifyHunger',
{
	if (Player_Hunger > 100) exitWith
	{
		Player_Hunger = 100;
	};

	if (Player_Hunger < 0) exitWith
	{
		Player_Hunger = 0;
	};
}] call Server_Setup_Compile;

//Makes sure that thirst doesn't go over 100
['A3PL_Lib_VerifyThirst', {
	if (Player_Thirst > 100) exitWith {
		Player_Thirst = 100;
	};

	if (Player_Thirst < 0) exitWith {
		Player_Thirst = 0;
	};
}] call Server_Setup_Compile;

["A3PL_Lib_SyncAnim",
{
	if (isDedicated) exitwith {};
	private ['_player', '_anim'];
	_player = param [0,objNull];
	_anim = param [1,""];
	_player switchMove _anim;
}] call Server_Setup_Compile;

['A3PL_Lib_Gesture',
{
	private ['_anim','_player'];
	_anim = param [0,"gesture_stop"];
	_player = param [1,player];
	_player playAction _anim;
}] call Server_Setup_Compile;

['A3PL_Lib_Sit',
{
	private ["_obj","_name"];
	_obj = param [0,objNull];
	_name = param [1,""];
	if ((isNull _obj) OR (_name == "")) exitwith {};

	if (animationState player IN ["hubsittingchairb_idle1","hubsittingchairb_idle2","hubsittingchairb_idle3","incapacitated"]) exitwith { [[player,""],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;	};

	player setPos (_obj modelToWorld (_obj selectionPosition _name));
	player setDir (([(_obj modelToWorld (_obj selectionPosition _name)),(_obj modelToWorld (_obj selectionPosition format ["%1_dir",_name]))] call A3PL_Lib_RelDir));

	if (_name IN ["bed_1","bed_2","bed_3"]) then
	{
		[[player,"A3PL_Bed"],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
	} else
	{
		private ["_r","_anim"];
		_r = round random 2;
		_anim = "hubsittingchairb_idle1";
		switch (_r) do
		{
			case (1): {_anim = "hubsittingchairb_idle2"};
			case (2): {_anim = "hubsittingchairb_idle3"};
		};
		[[player,_anim],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
	};

}] call Server_Setup_Compile;

["A3PL_Lib_RelDir",
{
	private ["_orig","_dest"];
	_orig = param [0,[0,0,0]];
	_dest = param [1,[0,0,0]];
	_dir = ((((_dest select 0) - (_orig select 0)) atan2 ((_dest select 1) - (_orig select 1))) + 360) % 360;
	_dir;
}] call Server_Setup_Compile;

//Function to move into something as a passenger
['A3PL_Lib_MoveInPass', {
	private ["_veh","_anim","_detain"];
	_veh = param [0,objNull];
	_detain = param [1,true];

	_anim = animationState player;

	player setVariable ["dragged",false,true];
	_veh lock 1;
	player moveInCargo _veh;
	_veh lock 2;
	if (_detain) then
	{
		[_veh,_anim] spawn
		{
			_veh = param [0,objNull];
			sleep 2;
			waituntil {vehicle player == player};
			sleep 0.5;
			player setVelocityModelSpace [0,3,1];
			[[player,"A3PL_HandsupKneelCuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_fnc_MP;
		};
	};
}] call Server_Setup_Compile;

//Returns all attached objects and deletes the null objects
["A3PL_Lib_AttachedAll",
{
	private ["_obj","_attachedObjects"];
	_obj = param [0,player];
	_attachedObjects = attachedobjects _obj;
	_attachedObjects = _attachedObjects - [objNull];
	_attachedObjects;
}] call Server_Setup_Compile;

//Returns attached object in array format
["A3PL_Lib_Attached",
{
	_player = param [0,player];
	_attachedObjects = attachedobjects _player;
	_return = [];

	{
		if (isNull _x) then
		{
			_attachedObjects = _attachedObjects - [_x];
		};
	} foreach _attachedobjects;

	if (count _attachedObjects > 1) then
	{
		{
			if (_forEachIndex != 0) then
			{
				detach _x;
			};
		} foreach _attachedObjects;
	};

	if (count _attachedObjects == 0) exitwith
	{
		_return;
	};

	_return = [(_attachedObjects select 0)];
	_return;

}] call Server_Setup_Compile;

//Returns first attached object after formatting with A3PL_Lib_Attached
["A3PL_Lib_AttachedFirst",
{
	private ["_attached"];
	_attached = [] call A3PL_Lib_Attached;
	_return = objNull;
	if (count _attached == 0) exitwith
	{
		_return;
	};
	_return = _attached select 0;
	_return;
}] call Server_Setup_Compile;

['A3PL_Lib_vectorDirAndUpRelative',
{
    private ["_o1","_o2","_v"];
    _o1 = _this select 0;
    _o2 = _this select 1;
    _v = _o2 worldToModelVisual [0,0,0];
    [
        _o2 worldToModelVisual vectorDirVisual _o1 vectorDiff _v,
        _o2 worldToModelVisual vectorUpVisual _o1 vectorDiff _v
    ]
}] call Server_Setup_Compile;

['A3PL_Lib_attachToRelative',
{
    private ["_o","_v"];
    _o = _this select 0;
    _v = [_o,player] call A3PL_Lib_vectorDirAndUpRelative;
    _o attachTo [_this select 1];
    _o setVectorDirAndUp _v;
}] call Server_Setup_Compile;

['A3PL_lib_CheckIfFurniture',
{
	private ["_obj","_modelName","_return","_furnitureArray"];
	_obj = _this select 0;
	_modelname = typeOf _obj;
	_return = false;
	_furnitureArray = [];

	if (isNil "_modelName") exitwith {};

	{
		_furnitureArray pushback (_x select 3);
	} foreach Config_Items;

	_furnitureArray pushback "A3PL_Crate";
	_furnitureArray pushback "A3PL_Clothing";

	if (_modelName IN _furnitureArray) then
	{
		_return = true;
	};

	_return;
}] call Server_Setup_Compile;

//This can check if the object is colliding with something
['A3PL_Lib_checkCollision',
{
	private ["_obj","_bb","_car","_e1","_e2","_posStart","_posEnd","_intersect"];
	_obj = _this select 0;

	_bb = boundingBoxReal _obj;
	_e1 = _bb select 0;
	_e2 = _bb select 1;

	//Bottom-left -> bottom-right
	_posStart = _e1;
	_posEnd = [_e2 select 0,_e1 select 1,_e1 select 2];
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _posStart),AGLTOASL (_obj modelToWorld _posEnd ),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};

	_posStart = [_e1 select 0,_e2 select 1,_e1 select 2];
	_posEnd = [_e1 select 0,_e2 select 1,_e1 select 2];
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _posStart),AGLTOASL (_obj modelToWorld _posEnd ),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};


	_posStart = [_e1 select 0,_e1 select 1,_e2 select 2];
	_posEnd = [_e1 select 0,_e2 select 1,_e2 select 2];
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _posStart),AGLTOASL (_obj modelToWorld _posEnd ),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};

	_posStart = [_e1 select 0,_e2 select 1,_e2 select 2];
	_posEnd = _e2;
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _posStart),AGLTOASL (_obj modelToWorld _posEnd ),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};

	//Now try extremes (diagonal)
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _e1),AGLTOASL (_obj modelToWorld _e2),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};

	//Now try extremes (diagonal) -> other way
	_intersect = lineIntersectsWith [AGLTOASL (_obj modelToWorld _e2),AGLTOASL (_obj modelToWorld _e1),_obj,objNull,true];
	if (count _intersect > 0) exitwith
	{
		_intersect;
	};
	_return = [];
	_return;

}] call Server_Setup_Compile;

//This will find our nearest marker and return it
["A3PL_Lib_NearestMarker",
{
	private ["_objPos","_d"];
	_objPos = param [0,[0,0,0]];
	_nearm = ObjNull;
	_nearest = 100;
	{
		_d = _objPos distance (getMarkerPos _x);
		if ( _d < _nearest) then
		{
			_nearest = _d;
			_nearm = _x;
		};
	} foreach (allMapMarkers);
	_nearm;
}] call Server_Setup_Compile;

//Mirror based on a direction, also can take an object as second argument
["A3PL_Lib_Mirror",
{
	private ["_obj","_mirrorDir","_diff","_newDir"];
	_obj = param [0,objNull];
	_mirrorDir = param [1,[],[objNull,[]]];
	if (typeName _mirrorDir == "OBJECT") then
	{
		_mirrorDir = getDir _mirrorDir;
	};

	_diff = (getDir _obj) - (_mirrorDir-90); //90 for apartment

	_newDir = (getDir _obj) - (_diff*2);
	_newDir
}] call Server_Setup_Compile;

//Returns a vectorDirAndUp from vector diff between two memory points
["A3PL_Lib_VectorDirUpMem",
{
	private ["_obj","_mem1","_mem2","_start","_end","_vDir","_vSide","_vUp","_vectorDirAndUp"];

	_obj = param [0,objNull];
	_mem1 = param [1,""];
	_mem2 = param [2,""];

	_start = _obj selectionPosition _mem1;
	_end = _obj selectionPosition _mem2;
	_vDir = _start vectorFromTo _end;

	_vSide = [-(_vDir select 1), _vDir select 0, 0];
	_vUp = _vDir vectorCrossProduct _vSide;

	_vectorDirAndUp = [_vDir,_vUp];
	_vectorDirAndUp;
}] call Server_Setup_Compile;

//Simple animation toggle, used in siren script and probably others
["A3PL_Lib_ToggleAnimation",
{
	private ["_obj","_animationName","_animateSource"];
	_obj = param [0,objNull];
	_animationName = param [1,""];
	_animateSource = param [2,true];
	_forceOnOff = param [3,-1]; //0 off 1 on

	if (_animateSource) then
	{
		if (_forceOnOff != -1) exitwith {_obj animateSource [_animationName,_forceOnOff];};

		if (_obj animationSourcePhase _animationName < 0.5) then
		{
			_obj animateSource [_animationName,1];
		} else
		{
			_obj animateSource [_animationName,0];
		};
	} else
	{
		if (_forceOnOff != -1) exitwith {_obj animate [_animationName,_forceOnOff];};
		if (_obj animationPhase _animationName < 0.5) then
		{
			_obj animate [_animationName,1];
		} else
		{
			_obj animate [_animationName,0];
		};
	};
}] call Server_Setup_Compile;

["A3PL_Lib_SwitchLight",
{
	private ["_obj","_name"];

	_obj = param [0,objNull];
	_name = param [1,""];

	_animName = _name splitString "_";
	if (count _animName < 2) exitwith {};

	_animName = format ["%1_%2",_animName select 0,_animName select 1];
	[_obj,_animName,false] call A3PL_Lib_ToggleAnimation;
}] call Server_Setup_Compile;

//Returns in what position of a turret we are
["A3PL_Lib_ReturnTurret",
{
	private ["_turret","_role","_arr"];
	_turret = -1;
	_role = assignedVehicleRole player;

	if (count _role < 2) exitwith {_turret;};
	_arr = _role select 1;
	if (count _arr < 1) exitwith {_turret};
	_turret = _arr select 0;
	_turret;
}] call Server_Setup_Compile;

//Can Find An attached object, because sometimes you want to find something that is in attachedobjects rather than attachedTo
["A3PL_Lib_FindAttached",
{
	private ["_obj","_otherObj"];
	_obj = param [0,objNull];
	_otherObj = objNull;

	if (!isNull attachedTo _obj) exitwith {_otherObj = attachedTo _obj; _otherObj};

	//basically finds the latter
	{
		_otherObj = _x;
	} foreach (attachedObjects _obj);

	_otherObj;
}] call Server_Setup_Compile;

//convert a vehicle string to an object
["A3PL_Lib_vehStringToObj",
{
	private ["_veh"];
	_veh = param [0,""];
	{
		_check = format ["%1",_x];
		if (_check == _veh) exitwith
		{
			_veh = _x;
		};
	} foreach (nearestObjects [player, [], 20]);

	_veh;
}] call Server_Setup_Compile;

//convert a faction variable (eg. 'police','uscg') to US Coast Guard,Sheriff Department etc.
["A3PL_Lib_ParseFaction",
{
	private ["_faction","_return"];
	_faction = param [0,""];
	_return = "ERROR";
	switch (_faction) do
	{
		case ("uscg"): {_return = "US Coast Guard"};
		case ("police"): {_return = "Sheriff Department"};
		case ("fifr"): {_return = "FIFR"};
	};

	_return;
}] call Server_Setup_Compile;

["A3PL_Lib_HideObject",
{
	private ["_object","_hide"];
	_object = param [0,objNull];
	_hide = param [1,true];

	if (isServer) then
	{
		_object hideObjectGlobal _hide;
	} else
	{
		_object hideObject _hide;
	};
}] call Server_Setup_Compile;

//select a value from a random array
["A3PL_Lib_ArrayRandom",
{
	private ["_array","_return"];
	_array = _this;
	if (count _array == 0) exitwith {["System: Zero divisor error in Lib_ArrayRandom"] call A3PL_Player_Notification;};
	_return = _array select (round (random (count _array-1)));
	_return;
}] call Server_Setup_Compile;

["A3PL_Lib_PPEffect",
{
	private ["_effect","_priority","_value"];
	_effect = param [0,"DynamicBlur"];
	_value = param [1,[]];
	_priority = 400;
	switch (_effect):
	{
		case ("DynamicBlur"): {_priority = 400;};
		case ("FilmGrain"): {_priority = 2000;};
	};
	while
	{
		_effect = ppEffectCreate ["DynamicBlur", _priority];
		_effect < 0
	} do
	{
		_priority = _priority + 1;
	};
	_effect ppEffectEnable true;
	_effect ppEffectAdjust _value;
	_effect ppEffectCommit 0;
	_effect;
}] call Server_Setup_Compile;

//needs to be spawned
["A3PL_Lib_LoadAction",
{
	disableSerialization;
	private ["_text","_time","_actionTime","_control","_percent","_opacity","_controlPosition"];
	_text = param [0,""];
	_actionTime = param [1,5];
	_time = 0;
	_display = uiNamespace getVariable "Dialog_HUD_LoadAction";
	Player_ActionDoing = true;
	//set vars to screen
	_control = _display displayCtrl 351;
	_control ctrlSetStructuredText parseText format ["<t align='center'>%1</t>",_text];
	_control = _display displayCtrl 350;
	_control progressSetPosition 0;
	_control = _display displayCtrl 352;
	_control ctrlSetStructuredText parseText "<t size='1.8' font='RobotoCondensed' align='center' color='#B8B8B8'>0%</t>";

	(_display displayCtrl 394) ctrlSetFade 0;
	(_display displayCtrl 350) ctrlSetFade 0;
	(_display displayCtrl 351) ctrlSetFade 0;
	(_display displayCtrl 352) ctrlSetFade 0;
	(_display displayCtrl 394) ctrlCommit 0;
	(_display displayCtrl 350) ctrlCommit 0;
	(_display displayCtrl 351) ctrlCommit 0;
	(_display displayCtrl 352) ctrlCommit 0;

	_controlPosition = _display displayCtrl 350;
	while {(_time < _actionTime) && Player_ActionDoing} do
	{
		_percent = _time / _actionTime;
		_control ctrlSetStructuredText parseText format ["<t size='1.8' font='RobotoCondensed' align='center' color='#B8B8B8'>%2%1</t>","%",round(_percent*100)];
		_controlPosition progressSetPosition _percent;
		uiSleep 0.1;
		_time = _time + 0.1;
	};

	(_display displayCtrl 394) ctrlSetFade 1;
	(_display displayCtrl 350) ctrlSetFade 1;
	(_display displayCtrl 351) ctrlSetFade 1;
	(_display displayCtrl 352) ctrlSetFade 1;
	(_display displayCtrl 394) ctrlCommit 0;
	(_display displayCtrl 350) ctrlCommit 0;
	(_display displayCtrl 351) ctrlCommit 0;
	(_display displayCtrl 352) ctrlCommit 0;

	//set completed
	Player_ActionCompleted = true;
	Player_ActionDoing = false;
}] call Server_Setup_Compile;

["A3PL_Lib_AnimBusStopInit",
{
	Server_AllBusStops = nearestObjects [[6420.21,7001.08,0], ["Land_A3PL_BusStop"], 5000, false];
},true] call Server_Setup_Compile;

["A3PL_Lib_AnimBusStop",
{
	{
		if (_x animationSourcePhase "advert_roll" >= 1.8) then
		{
			_x animateSource ["advert_roll",0.35,true];
		};
		_x animateSource ["advert_roll",1.8];
	} foreach Server_AllBusStops;
},true] call Server_Setup_Compile;

["A3PL_Lib_HasPhone",
{
	private ["_player","_items","_hasPhone"];
	_player = param [0,player];
	_items = assignedItems _player + items _player;
	_hasPhone = false;
	{
		_split = _x splitstring "_";
		{
			if (_x == "Cellphone") exitwith {_hasPhone = true};
		} foreach _split;
		if (_hasPhone) exitwith {};
	} foreach _items;
	_hasPhone;
}] call Server_Setup_Compile;

["A3PL_Lib_MetersToMiles",
{
	private ["_meters","_miles"];
	_meters = param [0,0];
	_miles = _meters * 0.000621371;
	_miles;
}] call Server_Setup_Compile;

["A3PL_Lib_JobVehicle_Assign",
{
	private ["_class"];
	_class = param [0,""];
	_pos = param [1,[]];
	_job = param [2,""];
	_assignTime = param [3,1200];
	_inArea = param [4,""]; //if this vehicle needs to stay in specific area

	[[_class,_pos,format ["%1",toUpper _job],player], "Server_Vehicle_Spawn", false, false] call BIS_fnc_MP;
	["System: Send request to server to spawn and assign job vehicle, please wait...",Color_Yellow] call A3PL_Player_Notification;

	//wait for job vehicle assignment
	_t = 0;
	waituntil {sleep 0.5; _t = _t + 0.5; if (_t > 5) exitwith {true;}; !isNull (player getVariable ["jobVehicle",objNull]);};
	if (isNull (player getVariable ["jobVehicle",objNull])) exitwith
	{
		["System: There was an error spawning your job vehicle, please try re-taking the job",Color_Red] call A3PL_Player_Notification;
	};
	_veh = player getVariable ["jobVehicle",objNull];
	["System: Your job vehicle has spawned, please take good care of your vehicle or you may be penalized!"] call A3PL_Player_Notification;

	/* //assign timer for vehicle
	player setVariable ["jobVehicleTimer",(diag_tickTime + _assignTime)]; */

	while {(player getVariable ["job","unemployed"]) == _job} do
	{
		if (isNull _veh) exitwith {["System: Your job vehicle has been destroyed!",Color_Red] call A3PL_Player_Notification; true;};
		if (getDammage _veh >= 1) exitwith {["System: Your job vehicle has been destroyed!",Color_Red] call A3PL_Player_Notification; true;};
		if ((player distance2D _veh) > 100) exitwith {["System: You walked too far away from your job vehicle, it has been returned.",Color_Red] call A3PL_Player_Notification; true;};
		/* if ((player getVariable ["jobVehicleTimer",diag_tickTime]) <= diag_tickTime) exitwith {["System: You reached the maximum time to use this job vehicle, it has been returned!",Color_Red] call A3PL_Player_Notification; true;}; */
		//if ((_inArea != "") && (!(player inArea _inArea))) exitwith {["System: Your job vehicle exited the area it needs to stay in! (e.g. go karts only in Sally Speedway!)",Color_Red] call A3PL_Player_Notification; true;};
		sleep 10;
	};
	[_veh] call A3PL_Vehicle_Despawn;

	player setVariable ["jobVehicle",nil,true];
	/* player setVariable ["jobVehicleTimer",nil]; */

}] call Server_Setup_Compile;

["A3PL_Lib_JobMsg",
{
	private ["_msg","_colour"];
	_msg = param [0,"No messsage provided, report this"];


	[_msg, Color_Yellow] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

//check if we have a perk
["A3PL_Lib_hasPerk",
{
	private ["_perks","_perk"];
	_perk = param [0,""];
	_hasPerk = false;
	if (_perk IN (player getVariable ["perks",[]])) then
	{
		_hasPerk = true;
	};
	_hasPerk;
}] call Server_Setup_Compile;
