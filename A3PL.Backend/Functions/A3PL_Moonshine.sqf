["A3PL_Moonshine_Grind",
{
	private ["_output","_nearby","_input","_pos","_mixer"];
	_output = param [0,""];
	_mixer = param [1,objNull];
	switch (_output) do
	{
		case ("malt"): 
		{
			//check for wheat nearby
			_input = objNull;
			_nearby = nearestObjects [_mixer, ["A3PL_Sack"], 2];
			{
				if (_x getVariable "class" == "wheat") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["System: There is no wheat nearby to grind"] call A3PL_Player_Notification;};
			
			//wait
			if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
			Player_ActionCompleted = false;
			["Grinding wheat...",12] spawn A3PL_Lib_LoadAction;
			while {sleep 1.5; !Player_ActionCompleted } do {};				
			
			//delete the wheat and grind it
			_pos = getposATL _input;
			deleteVehicle _input;
			_malt = createvehicle ["A3PL_Grainsack_Malt", _pos, [], 0, "CAN_COLLIDE"];
			_malt setVariable ["owner",getPlayerUID player,true];
			_malt setVariable ["class","malt",true];
			["System: You grinded wheat into malt",Color_Green] call A3PL_Player_Notification;
		};
		case ("yeast"): 
		{
			//check for wheat nearby
			_input = objNull;
			_nearby = nearestObjects [_mixer, ["A3PL_Sack"], 2];
			{
				if (_x getVariable "class" == "wheat") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["System: There is no wheat nearby to grind"] call A3PL_Player_Notification;};
			
			//wait
			if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
			Player_ActionCompleted = false;
			["Grinding wheat...",12] spawn A3PL_Lib_LoadAction;
			while {sleep 1.5; !Player_ActionCompleted } do {};				
			
			//delete the wheat and grind it
			_pos = getposATL _input;
			deleteVehicle _input;
			_yeast = createvehicle ["A3PL_Grainsack_Yeast", _pos, [], 0, "CAN_COLLIDE"];
			_yeast setVariable ["owner",getPlayerUID player,true];
			_yeast setVariable ["class","yeast",true];
			["System: You grinded wheat into yeast",Color_Green] call A3PL_Player_Notification;			
		};
		case ("cornmeal"): 
		{
			//check for wheat nearby
			_input = objNull;
			_nearby = nearestObjects [_mixer, ["A3PL_CornCob"], 2];
			{
				if (_x getVariable "class" == "corn") exitwith {_input = _x;};
			} foreach _nearby;
			if (isNull _input) exitwith {["System: There is no corn cob nearby to grind"] call A3PL_Player_Notification;};
			
			//wait
			if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
			Player_ActionCompleted = false;
			["Grinding corn...",12] spawn A3PL_Lib_LoadAction;
			while {sleep 1.5; !Player_ActionCompleted } do {};			
			
			//delete the wheat and grind it
			_pos = getposATL _input;
			deleteVehicle _input;
			_cornmeal = createvehicle ["A3PL_Grainsack_CornMeal", _pos, [], 0, "CAN_COLLIDE"];
			_cornmeal setVariable ["owner",getPlayerUID player,true];
			_cornmeal setVariable ["class","cornmeal",true];
			["System: You grinded corn into cornmeal",Color_Green] call A3PL_Player_Notification;			
		};
	};
}] call Server_Setup_Compile;

["A3PL_Moonshine_InstallHose",
{		
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_dist","_hose","_hoses"];
	_dist = param [0,objNull]; //distillery
	_hoses = nearestObjects [_dist, ["A3PL_Distillery_Hose"], 2];
	if (count _hoses < 1) exitwith {["System: No distillery hose nearby",Color_Red] call A3PL_Player_Notification;};
	_hose = _hoses select 0;
	_hose attachto [_dist,[-0.53,0.48,-0.3]];
	["System: Hose succesfully installed",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_InstallJug",
{		
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_jug","_hose","_jugs"];
	_hose = param [0,objNull]; //distillery hose
	_jugs = nearestObjects [_hose, ["A3PL_Jug","A3PL_Jug_Green"], 2];
	if (count _jugs < 1) exitwith {["System: No jug nearby",Color_Red] call A3PL_Player_Notification;};
	_jug = _jugs select 0;
	_jug attachto [_hose,[-0.2,-0.17,-0.57]];
	["System: Jug succesfully connected",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_addItem",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_dist","_nearby"];
	_dist = param [0,objNull];
	_nearby = nearestObjects [_dist, ["A3PL_Grainsack_Malt","A3PL_Grainsack_Yeast","A3PL_Grainsack_CornMeal"], 2];
	
	//check for correct items
	if (count _nearby < 1) exitwith {["System: There is no Malt,Yeast,or Cornmeal nearby, move the item closer to the distillery",Color_Red] call A3PL_Player_Notification;};
	_nearby = _nearby select 0;
	_item = _nearby getVariable "class";
	
	//check for items already in dist
	_items = _dist getVariable ["items",[]];
	if (_item IN _items) exitwith {["System: This item (nearest) has already been added in the distillery, add a different item closer to the distillery",Color_Red] call A3PL_Player_Notification;};
	
	//take item and add it to array
	deleteVehicle _nearby;
	_items pushback _item;
	_dist setVariable ["items",_items,true];	
	
	//msg
	[format ["System: You added %1 into the distillery",[_item,"name"] call A3PL_Config_GetItem],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_CheckStatus",
{
	private ["_distillery"];
	_distillery = param [0,objNull];
	if (!(_distillery getVariable ["running",false])) exitwith {["System: This distillery is not running",Color_Red] call A3PL_Player_Notification;};
	
	[format ["System: This distillery has %1 seconds left until completion",(_distillery getVariable ["timeleft",180])],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Moonshine_Start",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_dist","_sound","_items","_timeLeft","_hose","_succes","_posSound"];
	_dist = param [0,objNull];
	if (_dist getVariable ["running",false]) exitwith {["System: This distillery is already running",Color_Red] call A3PL_Player_Notification;};
	
	//check for required items and attached objects
	_items = _dist getVariable ["items",[]];
	if (!(("malt" IN _items) && ("yeast" IN _items) && ("cornmeal" IN _items))) exitwith {["The required items to create moonshine are not in this distillery, Malt, Yeast and Cornmeal are required to make moonshine",Color_Red] call A3PL_Player_Notification;};
	if ((count ([_dist] call A3PL_Lib_AttachedAll)) < 1) exitwith {["System: There is no hose connected to the distillery",Color_Red] call A3PL_Player_Notification;};
	_hose = ([_dist] call A3PL_Lib_AttachedAll) select 0;	
	if ((count ([_hose] call A3PL_Lib_AttachedAll)) < 1) exitwith {["System: There is no jug connected to the hose, or the jug is full already",Color_Red] call A3PL_Player_Notification;};
	_jug = ([_hose] call A3PL_Lib_AttachedAll) select 0;
	
	//set running
	_dist setVariable ["running",true];
	
	//create sound
	_sound = createSoundSource ["A3PL_Boiling", (getpos _dist), [], 0];
	_posSound = getPos _dist;
	
	//loop
	_timeLeft = 180;
	_dist setVariable ["timeleft",_timeLeft,false];
	_succes = false;
	while {(_timeLeft > 0) && (_dist getVariable ["running",false])} do
	{
		//set sound position
		if (!([_posSound,(getpos _dist)] call BIS_fnc_areEqual)) then
		{
			_sound setPos (getpos _dist);
			_posSound = getpos _dist;
		};
		
		//check if hose connected
		if ((count ([_dist] call A3PL_Lib_AttachedAll))< 1) exitwith {["System: The hose was disconnected, one of your distillerys stopped working",Color_Red] call A3PL_Player_Notification; true;};
		
		//check if jug still connected
		if ((count ([_hose] call A3PL_Lib_AttachedAll)) < 1) exitwith {["System: The jug was removed from one of your distillery's, it has stopped",Color_Red] call A3PL_Player_Notification; true;};
		
		//do timeleft
		_timeLeft = _timeLeft - 1;
		_dist setVariable ["timeleft",_timeLeft,false];
		if (_timeLeft < 1) exitwith {_succes = true; true;};
		sleep 1;
	};
	_dist setVariable ["running",nil,true];
	deleteVehicle _sound;
	
	if (_succes) then
	{
		_dist setVariable ["items",nil,true];
		_position = getPosATL _jug;
		deleteVehicle _jug;
		_jug = createvehicle ["A3PL_Jug_Corked", _position, [], 0, "CAN_COLLIDE"];
		_jug setVariable ["owner",getPlayerUID player,true];
		_jug setVariable ["class","jug_moonshine",true];
		["System: One of your distillerys has finished creating moonshine",Color_Green] call A3PL_Player_Notification;
	} else
	{
		["System: One of your distillery's failed to finish",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;