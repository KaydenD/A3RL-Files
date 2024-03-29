//Set ladder numbers
['A3PL_FD_SetLadderNumber',
{
	private ["_veh"];
	_veh = _this select 0;
	_type_1 = _this select 1;
	_type_2 = _this select 2;

	_TruckNumber = {(typeOf _x == _type_1) OR (typeOf _x == _type_2)} count vehicles;
	_Number1 = 0;
	_Number2 = 0;
	_Number3 = _TruckNumber;
	while {_Number3 > 9} do {_Number3 = _Number3 - 10; _Number2 = _Number2 + 1; if (_Number2 > 9) then { _Number1 = _Number1 + 1; _Number2 = 0};};
	if (_Number1 < 1) then {_Number1 = 0;};
	if (_Number2 < 1) then {_Number2 = 0;};
	if (_Number3 < 1) then {_Number3 = 0;};
	_TruckNumber1 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number1];
	_TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number2];
	_TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number3];
	_veh setObjectTextureGlobal [8, _TruckNumber2 ];
	_veh setObjectTextureGlobal [9, _TruckNumber3 ];

}] call Server_Setup_Compile;

['A3PL_FD_SetPumperNumber',
{
	private ["_veh"];
	_veh = _this select 0;
	_type_1 = _this select 1;

	_TruckNumber = {(typeOf _x == _type_1)} count vehicles;
	_Number1 = 0;
	_Number2 = 0;
	_Number3 = _TruckNumber;
	while {_Number3 > 9} do {_Number3 = _Number3 - 10; _Number2 = _Number2 + 1; if (_Number2 > 9) then { _Number1 = _Number1 + 1; _Number2 = 0};};
	if (_Number1 < 1) then {_Number1 = 0;};
	if (_Number2 < 1) then {_Number2 = 0;};
	if (_Number3 < 1) then {_Number3 = 0;};
	_TruckNumber1 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number1];
	_TruckNumber2 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number2];
	_TruckNumber3 = format ["\A3PL_FD\textures\Truck_Numbers\%1.paa", _Number3];
	_veh setObjectTextureGlobal [8, _TruckNumber2 ];
	_veh setObjectTextureGlobal [9, _TruckNumber3 ];

}] call Server_Setup_Compile;

["A3PL_FD_HandleJaws",
{
	private ["_intersect","_nameintersect"];
	//get the intersect variables
	_intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	_nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];

	//front left/driver
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["glass2","door_lf","door_lf2","door_lf3","door_lf4","door_lf5","door_lf6"])) exitwith
	{
		if ((round random 10) > 6) then //30% chance
		{
			["System: You attempted to use the jaws of life on this door, you were succesful and the driver has been ejected",Color_Green] call A3PL_Player_Notification;
			moveOut (driver _intersect);
		} else
		{
			["System: You attempted to use the jaws of life on this door, the door did not open",Color_Red] call A3PL_Player_Notification;
		};
	};

	//passenger
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["glass3","glass4","glass5","door_lb","door_rb","door_rf","door_lb2","door_lb3","door_lb4","door_lb5","door_lb6","door_rb2","door_rb3","door_rb4","door_rb5","door_rb6","door_rf2","door_rf3","door_rf4","door_rf5","door_rf6"])) exitwith
	{
		if ((round random 10) > 6) then //30% chance
		{
			["System: You attempted to use the jaws of life on this door, you were succesful and the passengers have been ejected",Color_Green] call A3PL_Player_Notification;
			{
				moveOut _x;
			} foreach (crew _intersect);
		} else
		{
			["System: You attempted to use the jaws of life on this door, the door did not open",Color_Red] call A3PL_Player_Notification;
		};
	};

	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 10)) exitwith
	{
		if ((round random 10) > 6) then //30% chance
		{
			["System: You attempted to use the jaws of life on this door, you were succesful and the passengers have been ejected",Color_Green] call A3PL_Player_Notification;
			{
				moveOut _x;
			} foreach (crew _intersect);
		} else
		{
			["System: You attempted to use the jaws of life on this door, the door did not open",Color_Red] call A3PL_Player_Notification;
		};
	};
}] call Server_Setup_Compile;

//Handle fire axe doors and its destruction :3
["A3PL_FD_HandleFireAxe",
{
	private ["_intersect","_nameintersect"];

	//get the intersect variables
	_intersect = missionNameSpace getVariable ["player_objintersect",objNull];
	_nameIntersect = missionNameSpace getVariable ["player_nameintersect",""];

	//distance to door < 2 and we are looking at a door
	if ((player distance (_intersect modelToWorld (_intersect selectionPosition _nameIntersect)) < 2) && (_nameIntersect IN ["door_bankvault","door_1","door_2","door_3","door_4","door_5","door_6","door_7","door_8","door_9","door_10","door_11","door_12","door_13","door_14","door_15","door_16","door_17","door_18","door_19","door_20","door_21","door_22","door_23","door_24","door_25","door_26","door_27","door_28","door_29","door_30","door_31","door_32","door_33","door_34","door_35","door_36","door_37","door_38","door_39","door_40","door_41","door_42","door_43","door_44","door_45","door_46","door_47","door_48","door_49","door_50","storagedoor1","storagedoor2","storagedoor3","sdstoragedoor3","sdstoragedoor6","door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"])) then
	{
		private ["_var"];
		if (_nameIntersect IN ["door_1_button","door_2_button","door_3_button","door_4_button","door_5_button","door_6_button","door_7_button","door_8_button","door_9_button","door_10_button","door_11_button","door_12_button","door_13_button","door_14_button","door_15_button","door_16_button","door_17_button","door_18_button","door_19_button","door_20_button","door_21_button","door_22_button","door_23_button","door_24_button","door_25_button","door_26_button","door_27_button","door_28_button","door_29_button","door_30_button","door_1_button2","door_2_button2","door_3_button2","door_4_button2","door_5_button2","door_6_button2","door_7_button2","door_8_button2","door_9_button2","door_10_button2","door_11_button2","door_12_button2","door_13_button2","door_14_button2","door_15_button2","door_16_button2","door_17_button2","door_18_button2","door_19_button2","door_20_button2","door_21_button2","door_22_button2","door_23_button2","door_24_button2","door_25_button2","door_26_button2","door_27_button2","door_28_button2","door_29_button2","door_30_button2","door_8_button1","door_8_button2"]) then {[] call A3PL_Intersect_HandleDoors;};
		_var = format ["damage_%1",_nameintersect]; //ex. damage_door1
		if (((_intersect getVariable [_var,0]) + 0.2) > 1) exitwith //open door and reset damage variable
		{
			_intersect animate [_nameIntersect,1];
			_intersect setvariable [_var,0,false];
			if (_nameIntersect in ["storagedoor1","storagedoor2","storagedoor3"]) then {[] spawn {_intersect = cursorobject;_intersect animateSource ["storagedoor",1];sleep 60;_intersect animateSource ["storagedoor",0];};};
			if (_nameIntersect == "door_bankvault") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["door_bankvault",1];sleep 20;_intersect animateSource ["door_bankvault",0];};};
			if (_nameIntersect == "sdstoragedoor3") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["StorageDoor",1];sleep 60;_intersect animateSource ["StorageDoor",0];};};
			if (_nameIntersect == "sdstoragedoor6") then {[] spawn {_intersect = cursorobject;_intersect animateSource ["StorageDoor2",1];sleep 60;_intersect animateSource ["StorageDoor2",0];};};
		};
		_intersect setVariable [_var,(_intersect getVariable [_var,0]) + 0.2,false]; //local variable cause why global it, 5 hits to destroy door
	};
}] call Server_Setup_Compile;

//Connect an adapter to a source such as a fire hydrant
["A3PL_FD_ConnectAdapter",
{
	private ["_hydrant","_adapter","_itemClass","_pos","_dir"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	//check for correct types just to make sure (ropes can cause crashes sometimes)
	_hydrant = param [0,objNull];
	if (!((typeOf _hydrant) IN ["Land_A3PL_FireHydrant","Land_A3PL_Gas_Station"])) exitwith {["System: You are not interacting with a Fire Hydrant/Gas storage",Color_Red] call A3PL_Player_Notification;};
	if (((count (attachedObjects _hydrant)) > 0) && (typeOf _hydrant == "Land_A3PL_FireHydrant")) exitwith {["System: There is already an adapter connected to this water source",Color_Red] call A3PL_Player_Notification;};
	if (player_itemClass != "FD_adapter") exitwith {["System: You are not holding the proper adapter",Color_Red] call A3PL_Player_Notification;};

	switch (typeOf _hydrant) do
	{
		case ("Land_A3PL_FireHydrant"): {_pos = [-0.005,0.15,-0.076]; _dir = -180; _hydrant animateSource ["cap_hide",1];};
		case ("Land_A3PL_Gas_Station"): {_pos = [-3.72154,3.51953,-2.1]; _dir = -90;};
	};

	_adapter = createVehicle ["A3PL_FD_HoseEnd1_Float",_hydrant modelToWorld _pos, [], 0, "CAN_COLLIDE"];
	_adapter setDir (getDir _hydrant + _dir);

	_itemClass = "FD_adapter";
	//get rid of item
	[[player,_adapter,_itemClass], "Server_Inventory_Drop", false] call BIS_fnc_MP;	//also sets itemclass on new adapter
	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";
	call A3PL_FD_ConnectAnimation;

}] call Server_Setup_Compile;

["A3PL_FD_WrenchRotate",
{
	private ["_wrench"];
	_wrench = param [0,objNull];

	if (_wrench animationSourcePhase "WrenchRotation" < 0.5) then
	{
		_wrench animateSource ["WrenchRotation",1];
	} else
	{
		_wrench animateSource ["WrenchRotation",0];
	};

	call A3PL_FD_ConnectAnimation;
}] call Server_Setup_Compile;

["A3PL_FD_ConnectWrench",
{
	private ["_hydrant"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	//check for correct types just to make sure (ropes can cause crashes sometimes)
	_hydrant = param [0,objNull];
	if (!(_hydrant isKindOf "Land_A3PL_FireHydrant")) exitwith {["System: You are not interacting with a Fire Hydrant",Color_Red] call A3PL_Player_Notification;};

	_newWrench = createVehicle ["A3PL_FD_HydrantWrench_F",_hydrant modelToWorld [0,-0.25,0.445], [], 0, "CAN_COLLIDE"];
	_newWrench setDir (getDir _hydrant);

	//get rid of item
	[[player,_newWrench,"FD_hydrantwrench"], "Server_Inventory_Drop", false] call BIS_fnc_MP;	//also sets itemclass on new adapter
	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";
	call A3PL_FD_ConnectAnimation;

}] call Server_Setup_Compile;

//Connects a hose based on holding rolled hose
["A3PL_FD_ConnectHose",
{
	private ["_end"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_end = param [0,objNull];
	if (!(_end isKindOf "A3PL_FD_HoseEnd1_Float")) exitwith {["System: You are not interacting with a hose adapter located on a water source",Color_Red] call A3PL_Player_Notification;};
	if (!((attachedTo _end) isKindOf "Land_A3PL_FireHydrant")) exitwith {["System: You are not interacting with a Fire Hydrant",Color_Red] call A3PL_Player_Notification;};
	if ((count (ropes _end)) > 0) exitwith {["System: There is already a hose connected to this adapter",Color_Red] call A3PL_Player_Notification;};

}] call Server_Setup_Compile;

//Connect a hose adapter to a source when holding adapter with hose attached
["A3PL_FD_ConnectHoseAdapter",
{
	private ["_end","_endName","_myAdapter","_TOEnd","_TOmyAdapter","_dirOffset","_attachOffset","_memOffset","_animate","_otherEnd"];
	_end = param [0,objNull];
	_endName = param [1,""];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_myAdapter = call A3PL_Lib_AttachedFirst;
	_otherEnd = [_myAdapter] call A3PL_FD_FindOtherEnd; //check other end

	//IF THIS IS REMOVED IT CAN CAUSE SERVER CRASH IF ADAPTER CONNECTED TO SAME ADAPTER
	if (_otherEnd == _end) exitwith
	{
		["System: You cannot connect it like this",Color_Red] call A3PL_Player_Notification;
	};

	_TOEnd = typeOf _end;
	_TOmyAdapter = typeOf _myAdapter;

	if (!(_TOEnd IN ["A3PL_FD_HoseEnd1_Float","A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_FD_yAdapter","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Tanker_Trailer","A3PL_Fuel_Van"])) exitwith {["System: You are not interacting with a proper hose adapter/inlet",Color_Red] call A3PL_Player_Notification;};
	if (!(_TOmyAdapter IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])) exitwith {["System: You are not holding the correct adapter type (report this if it is a bug)",Color_Red] call A3PL_Player_Notification;};

	if (_TOmyAdapter == "A3PL_FD_HoseEnd1" && _TOEnd == "A3PL_FD_HoseEnd1_Float") exitwith {["System: You are connecting a male-adapter into a male adapter, use the other adapter on the other side",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd1" && _TOEnd == "A3PL_FD_HoseEnd1") exitwith {["System: You are connecting a male-adapter into a male adapter, use the other adapter on the other side",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd2" && _TOEnd == "A3PL_FD_HoseEnd2") exitwith {["System: You are connecting a female-adapter into a female adapter, use the other adapter on the other side",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd2" && _endName == "fd_yadapter_in") exitwith {["System: You are connecting a female-adapter into a female Y-adapter inlet, use the other adapter on the other side of your hose",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd1" && _endName == "fd_yadapter_out1") exitwith {["System: You are connecting a male-adapter into a male Y-adapter outlet, use the other adapter on the other side of your hose",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd1" && _endName == "fd_yadapter_out2") exitwith {["System: You are connecting a male-adapter into a male Y-adapter outlet, use the other adapter on the other side of your hose",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd1" && _endName == "fd_yadapter_out2") exitwith {["System: You are connecting a male-adapter into a male Y-adapter outlet, use the other adapter on the other side of your hose",Color_Red] call A3PL_Player_Notification;};
	if (_TOmyAdapter == "A3PL_FD_HoseEnd2" && _endName IN ["inlet_ds"]) exitwith {["System: You are connecting a female-adapter into a female ladder inlet, use the other adapter on the other side of your hose",Color_Red] call A3PL_Player_Notification;};

	switch (_endName) do
	{
		case ("fd_yadapter_in"): {_dirOffset = -90; _attachOffset = [-0.15,0,0]; _end setVariable ["inlet",_myAdapter,true]}; //set additional value so we can check later what adapter was connected to the inlet of the y-adapter
		case ("fd_yadapter_out1"): {_dirOffset = 115; _attachOffset = [0.07,-0.10,0];};
		case ("fd_yadapter_out2"): {_dirOffset = 60; _attachOffset = [0.07,0.10,0];};
		case ("inlet_r"): {_dirOffset = -180; _attachOffset = [0,0,0]; _memOffset = "inlet_r"; _animate = "Inlet_R_Cap";};
		case ("inlet_ds"): {_dirOffset = -90; _attachOffset = [0,0,0]; _memOffset = "inlet_ds"; _animate = "Inlet_DS_Cap";};
		case ("outlet_ps"): {_dirOffset = 90; _attachOffset = [0.05,0,0]; _memOffset = "outlet_ps"; _animate = "Outlet_PS_Cap";};
		case ("outlet_ds"): {_dirOffset = -90; _attachOffset = [-0.05,0,0]; _memOffset = "outlet_ds"; _animate = "Outlet_DS_Cap";};

		//tanker
		case ("outlet_1"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_1"; _animate = "outlet_1_cap";};
		case ("outlet_2"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_2"; _animate = "outlet_2_cap";};
		case ("outlet_3"): {_dirOffset = 90; _attachOffset = [0,0,0]; _memOffset = "outlet_3"; _animate = "outlet_3_cap";};
		case ("outlet_4"): {_dirOffset = 90; _attachOffset = [0.12,0,0]; _memOffset = "outlet_4"; _animate = "outlet_4_cap";};
		case default {_dirOffset = -180; _attachOffset = [0,-0.04,0];};
	};
	switch (_TOEnd) do
	{
		case ("A3PL_Fuel_Van"): {_dirOffset = 180; _attachOffset = [0,0,0]; _memOffset = "outlet_1"; _animate = "outlet_1_cap";};
	};
	_dir = getDir _end + _dirOffset;

	if (!isNil "_memOffset") then
	{
		_myAdapter attachTo [_end,_attachOffset,_memOffset];
	} else
	{
		_myAdapter attachTo [_end,_attachOffset];
	};

	if (!isNil "_animate") then { _end animate [_animate,1]; };

	_myAdapter setDir (_dir + (360 - (getDir _end)));

	call A3PL_FD_ConnectAnimation;

}] call Server_Setup_Compile;

["A3PL_FD_ConnectAnimation",
{
	//play move
	player playmove "Acts_carFixingWheel";
	[] spawn
	{
		sleep 4;
		player switchmove "";
	};
}] call Server_Setup_Compile;

//This function can find a rope on an object, the first one it finds though
["A3PL_FD_FindHose",
{
	private ["_obj","_ropes"];
	_obj = param [0,objNull];
	_hose = objNull;

	//find the hose
	_ropes = ropes _obj;
	if (count _ropes == 0) then
	{
		_obj = ropeAttachedTo _obj;
		_ropes = ropes _obj;
		if (count _ropes != 0) then
		{
			_hose = _ropes select 0;
		};
	} else
	{
		_hose = _ropes select 0;
	};

	_hose;
}] call Server_Setup_Compile;

//find other end of rope
["A3PL_FD_FindOtherEnd",
{
	private ["_oEnd","_end"];
	_end = param [0,objNull];
	_oEnd = objNull;

	_oEnd = ropeAttachedTo _end;

	if (isNull _oEnd OR _oEnd == _end) then
	{
		private ["_ropeAttached"];
		_ropeAttached = ropeAttachedObjects _end;
		if (count _ropeAttached != 0) then
		{
			_oEnd = _ropeAttached select 0;
		};
	};

	_oEnd;

}] call Server_Setup_Compile;

//this can find an adapter based on memory point, returns string of memory point (discharge/inlet) it is attached to, or just returns the end if we need
["A3PL_FD_FindAdapterCap",
{
	private ["_end","_selectionNames","_veh","_foundCap","_found"];
	_end = param [0,objNull];
	_veh = param [1,objNull];
	_memToFindEnd = param [2,""];
	_foundCap = "";
	if (isNull _veh) exitwith {_foundcap;};

	//this will return the _end instead if we found one
	if (_memToFindEnd != "") exitwith
	{
		private ["_selectionPosition","_foundEnd"];
		_foundEnd = objNull;
		_selectionPosition = _veh modelToWorld (_veh selectionPosition _memToFindEnd);
		{
			if ((typeOf _x IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && ((_selectionPosition distance _x) < 0.1)) exitwith
			{
				_foundEnd = _x;
			};
		} foreach (attachedObjects _veh);
		_foundEnd;
	};

	_selectionNames = ["inlet_r","inlet_ds","inlet_ps","outlet_ds","outlet_ps","outlet_1","outlet_2","outlet_3","outlet_4"];
	{
		_selectionPosition = _veh modelToWorld (_veh selectionPosition _x);
		if ((_end distance _selectionPosition) < 0.1) exitwith
		{
			_found = _x;
		};
	} foreach _selectionNames;

	if (isNil "_found") exitwith {_foundCap;};

	switch (_found) do
	{
		case ("inlet_r"): {_foundCap = "inlet_r_cap"};
		case ("inlet_ds"): {_foundCap = "inlet_ds_cap"};
		case ("inlet_ps"): {_foundCap = "inlet_ps_cap"};
		case ("outlet_ds"): {_foundCap = "outlet_ds_cap"};
		case ("outlet_ps"): {_foundCap = "outlet_ps_cap"};
		case ("outlet_1"): {_foundCap = "outlet_1_cap"};
		case ("outlet_2"): {_foundCap = "outlet_2_cap"};
		case ("outlet_3"): {_foundCap = "outlet_3_cap"};
		case ("outlet_4"): {_foundCap = "outlet_4_cap"};
	};

	_foundCap;
}] call Server_Setup_Compile;

//Grab a hose (adapter)
["A3PL_FD_GrabHose",
{
	private ["_end","_hose","_otherEnd","_ropeLength","_attachedTo","_nozzleClass","_connectedMem"];
	_end = param [0,objNull];
	_nozzleClass = "A3PL_High_Pressure"; //if we ever change the nozzle classname we can change it here

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	//do checks
	if (!isNull Player_Item) exitwith { _format = format["System: You are already holding an object"]; [_format, Color_Red] call A3PL_Player_Notification; };
	if (!(typeOf _end IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])) exitwith {["System: You are not interacting with the correct typeOf adapter (report this)",Color_Red] call A3PL_Player_Notification;};
	if (isPlayer (attachedTo _end)) exitwith {["System: Another player is holding this hose, you can't pick it up",Color_Red] call A3PL_Player_Notification;};
	//find other adapter end
	_otherEnd = [_end] call A3PL_FD_FindOtherEnd;
	if (!local _end) exitwith
	{
		[netID _end,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];["System: The hose is not local to you - request send to change locality - please try again",Color_yellow] call A3PL_Player_Notification;
		if (!local _otherEnd && !isNull _otherend) then {[netID _otherEnd,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];};
	};
	if (isPlayer (attachedTo _otherEnd)) exitwith {["System: Another player is holding this hose, you can't pick it up",Color_Red] call A3PL_Player_Notification;};
	//if the end we are connected to is attached to a Y-Adapter we need to do an additional check, and nil the variable if required otherwise the source stays active
	_attachedTo = attachedTo _end;
	if (typeOf _attachedTo == "A3PL_FD_yAdapter") then
	{
		//check if _end == the variable assigned
		if (_end == _attachedTo getVariable ["inlet",objNull]) then
		{
			_attachedTo setVariable ["inlet",objNull,true];
		};
	};
	//end of the Y-adapter additional check

	//check if we need to close animate an inlet/discharge
    _connectedMem = [_end,(attachedTo _end)] call A3PL_FD_FindAdapterCap;
	if (_connectedMem != "") then {(attachedTo _end) animate [_connectedMem,0]};

	//attach
	_end attachTo [player,[0,0,0],"RightHand"];
	Player_Item = _end;

	//find hose
	_hose = [_end] call A3PL_FD_FindHose;
	_ropeLength = ropeLength _hose - 0.25;
	_ropeLength = _ropeLength - 2;

	//loop
	player setvariable ["pressure","high",false]; //set pressure, we can change this later using the interaction menu
	missionNamespace setVariable ["A3PL_FD_FiredCount",0];
	A3PL_FD_PlayerFiredIndex = player addEventHandler ["Fired",{[(param [0,objNull])] call A3PL_FD_WaterFiredEH;}];
	while {(attachedTo _end == player) && (!isNull _end)} do
	{
		if (!(vehicle player == player)) exitwith {detach _end};
		if ((_end distance _otherEnd) > _ropeLength) exitwith {detach _end; [format ["System: Hose has been dropped because you can't carry it further than it's length! (curdist: %1,obj: %2)",(player distance _otherEnd),_otherEnd],Color_Red] call A3PL_Player_Notification;};
		if (currentWeapon player == "A3PL_High_Pressure") then
		{
			private ["_hasMag","_shouldMag","_bullets","_shouldBullets","_source"];
			_hasMag = (handgunMagazine player) select 0; //could be Nil if no magazine, this will not return out of index error if array size is 0!
			if (isNil "_hasMag") then {_hasMag = ""}; //take care of Nil value, this happends if there is no handgunMagazine

			//change magazine if pressure changed
			switch (player getVariable ["pressure","high"]) do
			{
				case ("high"): {_shouldMag = "A3PL_High_Pressure_Water_Mag"};
				case ("medium"): {_shouldMag = "A3PL_Medium_Pressure_Water_Mag"};
				case ("low"): {_shouldMag = "A3PL_Low_Pressure_Water_Mag"};
			};

			//add a magazine if it is not the correct one, and load it
			if (_hasMag != _shouldMag) then
			{
				player addMagazine _shouldMag;
				player addWeapon _nozzleClass;
			};

			//add bullets based on source
			_source = [_end] call A3PL_FD_FindSource; //we also handle checks on the source itself (proper valves opened etc)
			_bullets = player ammo _nozzleClass;
			if (!isNull _source) then //valid source
			{
				/*
				if (typeOf _source == "Land_A3PL_FireHydrant") exitwith //explicit this source because it's unlimited
				{
					if (_bullets < 10) then
					{
						player setAmmo [_nozzleClass,1000];
					};
				};
				*/

				if (typeOf _source == "A3PL_Pierce_Pumper") then
				{
					_shouldBullets = [_source,[_end,true] call A3PL_FD_FindSource] call A3PL_FD_SourceAmount;
				} else
				{
					_shouldBullets = [_source] call A3PL_FD_SourceAmount;
				};

				hintSilent format ["DEBUG: WATER GALLONS LEFT %1",_shouldBullets];
				if (((_bullets - _shouldBullets > 10) OR (_bullets - _shouldBullets < -10)) OR (_shouldBullets == 0 && _bullets != 0)) then //only perform a setammo in certain cases
				{
					player setAmmo [_nozzleClass,_shouldBullets];
				};
			} else //not a valid source so set the ammo to 0
			{
				if (_bullets != 0) then //we dont want to continously setAmmo, that would be stupid so only do it if there aren't 0 bullets in it already, according to wiki setAmmo has global effect
				{
					player setAmmo [_nozzleClass,0];
				};
			};

		};
		sleep 0.1;
	};
	player removeEventHandler ["Fired",A3PL_FD_PlayerFiredIndex];
	A3PL_FD_PlayerFiredIndex = nil;
	player setAmmo [_nozzleClass,0];
	player setvariable ["pressure",nil,false];
	Player_Item = objNull;
	player globalChat "FD Hose Loop-Ended";

}] call Server_Setup_Compile;

//Every 5 shots set a variable on the source
["A3PL_FD_WaterFiredEH",
{
	private ["_inlet","_source","_veh","_water"];
	_veh = param [0,objNull];

	if ((_veh == player) && (currentWeapon player != "A3PL_High_Pressure")) exitwith {};

	if (typeOf _veh == "A3PL_Pierce_Heavy_Ladder") then
	{
		_inlet = [objNull,_veh,"inlet_r"] call A3PL_FD_FindAdapterCap;
	} else
	{
		_inlet = [] call A3PL_Lib_AttachedFirst;
	};

	if ((isNull _inlet) OR (!(typeOf _inlet IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))) exitwith {};

	_source = [_inlet] call A3PL_FD_FindSource;
	if (typeOf _source != "A3PL_Pierce_Pumper") exitwith {};

	_firedCount = missionNamespace getVariable ["A3PL_FD_FiredCount",0];
	_firedCount = _firedCount + 1;
	if (_firedCount >= 10) then //this determins how quick it refreshes
	{
		_water = _source getVariable ["water",0];
		if (_water >= 5) then
		{
			_source setVariable ["water",_water - 10,true]; //this too
			_source animate ["Water_Gauge1",((_water - 10) / 500)]; //this too
		};
		_firedCount = 0;
	};
	missionNamespace setVariable ["A3PL_FD_FiredCount",_firedCount];

}] call Server_Setup_Compile;

//this is the loop we run while we are controlling the heavy ladder
["A3PL_FD_LadderHeavyLoop",
{
	private ["_veh","_sourceAmount","_inlet","_ammoWaterGun","_setZero","_otherEnd"];
	_veh = param [0,objNull];
	if (typeOf _veh != "A3PL_Pierce_Heavy_Ladder") exitwith {};

	if (missionNameSpace getVariable ["A3PL_FD_LadderHeavyLoopRunning",false]) exitwith {};
	A3PL_FD_LadderHeavyLoopRunning = true;

	//while we are controlling the watercannon
	//add fired eventhandler
	missionNamespace setVariable ["A3PL_FD_FiredCount",0];
	_veh addEventHandler ["Fired",{[(param [0,objNull])] call A3PL_FD_WaterFiredEH;}];

	while {(player IN _veh) && (call A3PL_Lib_ReturnTurret == 1)} do
	{
		sleep 1;
		if ((!(player IN _veh)) OR (!(call A3PL_Lib_ReturnTurret == 1))) exitwith {};
		//check if inlet is connected
		//end,veh,memory
		_inlet = [objNull,_veh,"inlet_r"] call A3PL_FD_FindAdapterCap;

		//var to know if we should empty the ammo for the watergun
		_setZero = false;

		//get vehicle ammo
		_ammoWaterGun = player ammo "A3PL_High_Pressure";

		//Locality check
		/*
		if ((!isNull (driver _veh)) && !local _veh) then
		{
			["Server Warning: You are operating a watercannon on a vehicle that you are not the network owner off, owner change cannot be attempted because there is a driver in the vehicle!",Color_Red] call A3PL_Player_Notification;
		} else
		{
			//attempt locality change, if we dont own the vehicle
			if (!local _veh) then
			{
				[netID _veh,netID player] remoteExec ["A3PL_Lib_ChangeLocality", 2];
				["Server Warning: You are not the network owner of this vehicle, an attempt was send to the server to change this. You may need to enter as driver on this vehicle manually to fix this if this message keeps appearing!",Color_Green] call A3PL_Player_Notification;
			};
		};
		*/

		//okay we found inlet, and our pump shift is engaged
		if ((!isNull _inlet) && (_veh animationPhase "FT_Pump_Switch" > 0.5)) then
		{
			//check if it is connected to a valid source
			_source = [_inlet] call A3PL_FD_FindSource;
			if (!isNull _source) then
			{
				_otherEnd = [_inlet,true] call A3PL_FD_FindSource; //get adapter here
				_sourceAmount = [_source,_otherEnd] call A3PL_FD_SourceAmount;
				hintSilent format ["DEBUG: GALLONS WATER LEFT %1",_sourceAmount];
				if (_sourceAmount != 0 && ((_ammoWaterGun - _sourceAmount > 10) OR (_ammoWaterGun - _sourceAmount < -10))) then
				{
					_veh setVehicleAmmoDef (0.001 * _sourceAmount);
				} else
				{
					if (_sourceAmount == 0) then {_setZero = true;};
				};
			} else
			{
				_setZero = true;
			};
		} else
		{
			_setZero = true;
		};

		if (_setZero && (_ammoWaterGun != 0)) then //only set to 0 if it isn't 0
		{
			_veh setVehicleAmmoDef 0;
		};
	};

	_veh removeAllEventHandlers "Fired";
	A3PL_FD_LadderHeavyLoopRunning = nil;
}] call Server_Setup_Compile;

["A3PL_FD_DropHose",
{
	private ["_adapter"];
	_adapter = param [0,objNull];

	detach _adapter;
}] call Server_Setup_Compile;

//Roll a hose back up so it can be stored
["A3PL_FD_RollHose",
{
	private ["_end","_hose","_ropes"];
	_end = param [0,objNull];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	if (!(typeOf _end IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_GasHose"])) exitwith {["System: You are not interacting with the correct typeOf adapter (report this)",Color_Red] call A3PL_Player_Notification;};

	//get all the ropes attached to this object
	_ropes = ropes _end;

	//get the hose object
	_hose = [_end] call A3PL_FD_FindHose;

	//delete all the objects attached to the rope
	deleteVehicle (ropeAttachedTo _end);
	{
		deleteVehicle _x;
	} foreach (ropeAttachedObjects _end);

	deleteVehicle _end;

	//add the hose to the player
	["fd_hose",1] call A3PL_Inventory_Add;
	["System: You rolled up the hose, it has been added to your inventory",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//Deploy hose on ground, creates two extenders to connect between
["A3PL_FD_DeployHose",
{
	private ["_adapter1","_adapter2","_rope"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ItemClass != "FD_Hose") exitwith {["System: You are not holding a hose",Color_Red] call A3PL_Player_Notification;};
	_lengths = param [0,objNull];
	[[player,objNull,Player_ItemClass], "Server_Inventory_Drop", false] call BIS_fnc_MP;

	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";

	//create adapters
	_adapter2 = createVehicle ["A3PL_FD_HoseEnd1",(player modelToWorld [0,5,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter1 = createVehicle ["A3PL_FD_HoseEnd2",(player modelToWorld [0,0,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter2 allowDamage false;_adapter1 allowDamage false;

	//create rope between them
	_rope = ropeCreate [_adapter1, [0,0.03,0.00], _adapter2, [0,0.03,0.00], _lengths];
}] call Server_Setup_Compile;

["A3PL_FD_GasDeployHose",
{
	private ["_adapter1","_adapter2","_rope"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ItemClass != "FD_Hose") exitwith {["System: You are not holding a hose",Color_Red] call A3PL_Player_Notification;};
	_lengths = param [0,objNull];
	[[player,objNull,Player_ItemClass], "Server_Inventory_Drop", false] call BIS_fnc_MP;

	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = "";

	//create adapters
	_adapter2 = createVehicle ["A3PL_GasHose",(player modelToWorld [0,5,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter1 = createVehicle ["A3PL_FD_HoseEnd1",(player modelToWorld [0,0,0.5]), [], 0, "CAN_COLLIDE"];
	_adapter2 allowDamage false;_adapter1 allowDamage false;

	//create rope between them
	_rope = ropeCreate [_adapter1, [0,0.03,0.00], _adapter2, [0,0.14,0.00], 30];
}] call Server_Setup_Compile;

//This function can loop through all ropes and its attached objects until it finds the other end (we then check if it's a valid water source once found)
["A3PL_FD_FindSource",
{
	private ["_end","_latestObject","_source","_otherEnd","_adapter","_hydrants","_hydrant","_m"];
	_end = param [0,objNull];
	_getAdapter = param [1,false]; //get the latest end instead of the source
	_latestObject = _end;
	_source = objNull;

	while {!isNull _latestObject} do
	{
		_m = true; //move on with adapter check

		//find other adapter end
		_otherEnd = [_latestObject] call A3PL_FD_FindOtherEnd;

		//if the other end isNull we are save to exit
		if (isNull _otherEnd) exitwith {};

		//check what it is attached to
		_attachedTo = [_otherEnd] call A3PL_Lib_FindAttached;

		//if the other end is connected to a adapter on a firehydrant we are save to exit here (since we found a source)
		if ((typeOf _attachedTo) == "A3PL_FD_HoseEnd1_Float") exitwith
		{
			//Now we just make sure here that the adapter is in fact connected to a hydrant, otherwise we will still return a null object
			private ["_hydrants","_adapter","_hydrant"];
			_latestObject = objNull;
			_adapter = _attachedTo;
			if (isNull _adapter) exitwith {};
			_hydrants = nearestObjects [_adapter, ["Land_A3PL_FireHydrant"], 1]; //CHANGE TO TERRAIN OBJECTS WHEN FIRE HYDRANTS ARE TERRAIN OBJECTS INSTEAD
			if (count _hydrants < 1) exitwith {};
			_hydrant = _hydrants select 0;

			if (typeOf _hydrant == "Land_A3PL_FireHydrant") then
			{
				_latestObject = _hydrant;
			};
		};

		if ((typeOf _attachedTo) IN ["A3PL_Pierce_Pumper","A3PL_Tanker_Trailer"]) exitwith
		{
			_latestObject = _attachedTo;
		};

		//if the other end is connected to a Y-Adapter we need to continue on with the inlet, to make sure people dont connect outlets into inlets....
		if ((typeOf _attachedTo) == "A3PL_FD_yAdapter") then
		{
			_otherEnd = (attachedTo _otherEnd) getVariable ["inlet",objNull];
			_m = false;
		};

		//check if we are connected to an extender, if we are NOT connected to an extender it is safe to exit the loop or it will keep bouncing back and forth looking for the adapter end
		if ((typeOf _attachedTo) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) then
		{
			_otherEnd = _attachedTo;
		} else
		{
			if (_m) then //make sure that we did not find an adapter, otherwise the script will end :(
			{
				_otherEnd = objNull;
			};
		};

		//otherwise set _latestobject
		_latestObject = _otherEnd;
	};

	player globalchat format ["Other End: %1",_latestObject];

	//exit if we need the adapter instead
	if (_getAdapter) exitwith
	{
		_source = _otherEnd; _source;
	};

	//now check if it is a valid source
	if (typeOf _latestObject in ["Land_A3PL_FireHydrant","A3PL_Pierce_Pumper","A3PL_Tanker_Trailer"]) then
	{
		_source = _latestObject;
	} else
	{
		_source = objNull;
	};
	_source;
}] call Server_Setup_Compile;

//check the validity of a water source
["A3PL_FD_SourceAmount",
{
	private ["_source","_amount","_line","_end"];
	_source = param [0,objNull];
	_end = param [1,objNull];
	_amount = 0;

	if (isNull _source) exitwith {_amount;}; // no use doing anything below this is the source is a null object

	//handle every source different
	switch (typeOf _source) do
	{
		case ("Land_A3PL_FireHydrant") do
		{
			private ["_wrench"];
			//now check if the wrench is actually in the open position
			_wrench = (nearestObjects [_source, ["A3PL_FD_HydrantWrench_F"], 1]) select 0; //TERRAIN OBJECTS LATER
			if (!isNil "_wrench") then
			{
				if (_wrench animationSourcePhase "WrenchRotation" > 0.5) then
				{
					_amount = 1000;
				};
			};
		};

		case ("A3PL_Pierce_Pumper") do
		{
			if (_source animationPhase "ft_lever_7" < 0.5) exitwith {}; //no water on pump cause valve closed
			_line = [_end,_source] call A3PL_FD_FindAdapterCap;

			if (_line == "outlet_ds_cap" && (_source animationPhase "ft_lever_10" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
			if (_line == "outlet_ps_cap" && (_source animationPhase "ft_lever_1" > 0.5)) then
			{
				_amount = _source getVariable ["water",0];
			};
		};
	};

	_amount;
}] call Server_Setup_Compile;

["A3PL_FD_ChangeHosePressure",
{
	private ["_currentPressure","_newPressure"];
	_currentPressure = player getvariable ["pressure","high"];
	switch (_currentPressure) do
	{
		case ("high"): {_newPressure = "medium"};
		case ("medium"): {_newPressure = "low"};
		case ("low"): {_newPressure = "high"};
	};

	player setvariable ["pressure",_newPressure,false];
}] call Server_Setup_Compile;

["A3PL_FD_EngineLoop",
{
	private ["_veh","_end","_water","_source","_sourceAmount","_i"];
	_veh = param [0,objNull];

	if (missionNameSpace getVariable ["A3PL_FD_EngineLoopRunning",false]) exitwith {};
	A3PL_FD_EngineLoopRunning = true;

	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 3) exitwith {_veh animate ["ft_lever_8",0,true]}; _veh animationPhase "ft_lever_8" > 0};
	while {(_veh animationPhase "ft_lever_8" > 0)} do
	{
		_end = [objNull,_veh,"inlet_ds"] call A3PL_FD_FindAdapterCap;
		if (!isNull _end) then
		{
			_source = [_end] call A3PL_FD_FindSource;
			if (!isNull _source) then
			{
				_sourceAmount = [_source] call A3PL_FD_SourceAmount;
				if (_sourceAmount >= 5) then
				{
					player globalChat "START";
					if (_veh animationPhase "ft_lever_8" > 0.9 && _veh animationPhase "ft_lever_11" > 0.9 && _veh animationPhase "FT_Pump_Switch" > 0.9) then //make sure the driver side aux intake/hydrant to tank is open, intake valve, and pump shift
					{
						_water = _veh getVariable ["water",0];
						if (_water < 1800) then
						{
							_veh setVariable ["water",_water + 5,true];
							_veh animate ["Water_Gauge1",(_water + 5) / 1800];
						};
						if (typeOf _source == "A3PL_Pierce_Pumper") then
						{
							_source setVariable ["water",_water - 5,true];
							_source animate ["Water_Gauge1",(_water - 5) / 1800];
						};
					};
				};
			};
		};
		uiSleep 1;
	};

	A3PL_FD_EngineLoopRunning = nil;
}] call Server_Setup_Compile;

["A3PL_FD_MaskOff",
{
	if (goggles player != "A3PL_FD_Mask") exitwith {["System: You are not wearing the oxygen mask",Color_Red] call A3PL_Player_Notification;};
	removegoggles player;

	["fd_mask",1] call A3PL_Inventory_Add;
	["System: You took off your oxygen mask, it is now in your inventory",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_FD_MaskOn",
{
	private ["_mask"];
	_mask = missionNameSpace getVariable ["player_item",objNull];
	if (isNull _mask OR player_itemClass != "fd_mask") exitwith {["System: You are not holding a mask",Color_Red] call A3PL_Player_Notification;};

	["fd_mask",-1] call A3PL_Inventory_Add;

	removegoggles player;
	_mask attachto [player,[-0.12,-0.15,-0.73],"RightHand"];
	player playaction "gesture_maskon";
	[_mask] spawn
	{
		disableSerialization;
		private ["_mask","_overlay","_currentOverlay"];
		_mask = param [0,objNull];

		sleep 2.5;
		deleteVehicle _mask;
		player_item = objNull; player_itemClass = "";
		player addgoggles "A3PL_FD_Mask";
		["\A3PL_Common\HUD\mask\mask_normal.paa"] call A3PL_HUD_SetOverlay;

		// start a loop to manage dirt/removing HUD
		player setvariable ["Overlay_Dirt",0,false];
		_overlay = "\A3PL_Common\HUD\mask\mask_normal.paa";
		_currentOverlay = "\A3PL_Common\HUD\mask\mask_normal.paa";
		while {goggles player == "A3PL_FD_Mask"} do
		{
			sleep 1;
			_dirtLevel = player getVariable ["Overlay_Dirt",0];
			if (_dirtLevel < 50) then {_overlay = "\A3PL_Common\HUD\mask\mask_normal.paa";};
			if (_dirtLevel >= 50) then { _overlay = "\A3PL_Common\HUD\mask\mask_dirt1.paa"; };
			if (_dirtLevel >= 100) then { _overlay = "\A3PL_Common\HUD\mask\mask_dirt2.paa"; };
			player setvariable ["Overlay_Dirt",_dirtLevel + 1,false];

			if (_currentOverlay != _overlay) then
			{
				_currentOverlay = _overlay;
				[_overlay] call A3PL_HUD_SetOverlay;
			};
		};
		[""] call A3PL_HUD_SetOverlay;
	};
}] call Server_Setup_Compile;

//clean the mask
["A3PL_FD_SwipeMask",
{
	//animation
	player playaction "gesture_headswipe";
	player setvariable ["Overlay_Dirt",0,false];
}] call Server_Setup_Compile;

["A3PL_FD_FireAlarm",
{
	_building = param [0,objNull];
	_building setVariable["FireAlarm",true,true];

	//Chance to be broken
	if (((round random 100) > 85) && (_building getVariable["FireAlarmCanBroke",true])) then {
		_building setVariable["FireAlarmBroke",true,true];
		["The fire alarm is broken!",Color_Red] call A3PL_Player_Notification;
	} else {
		[_building,"A3PL_Common\effects\firealarm.ogg",60] spawn A3PL_FD_AlarmLoop;
		["You have triggered the fire alarm!",Color_Yellow] call A3PL_Player_Notification;
		if ((count(["fifr"] call A3PL_Lib_FactionPlayers)) >= 1) exitwith {
			_marker = createMarker [format ["firealarm_%1",random 4000], position _building];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "A3PL_Markers_FIFD";

			_marker setMarkerText "Fire Alarm Triggered!";
			_marker setMarkerColor "ColorRed";
			{
				if((_x getVariable ["job",""]) in ["fifr"]) then {
					["!!! ALERT !!! A fire alarm has been triggered!", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
					["!!! ALERT !!! A fire alarm has been triggered!", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
					["!!! ALERT !!! A fire alarm has been triggered!", Color_Yellow] remoteExec ["A3PL_Player_Notification",_x];
				};
			} forEach allPlayers;
			["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
			sleep 300;
			deleteMarker _marker;
		};
	};
}] call Server_Setup_Compile;

["A3PL_FD_AlarmLoop",
{
	_building = param [0,objNull];
	_alarm = param [1,""];
	_loop = param [2,30];
	_dist = param [3,200];
	_sound = param [4,5];
	_sleep = 0;
	switch(_alarm) do {
		case "A3PL_Common\effects\firealarm.ogg": {_sleep = 3.4;};
		case "A3PL_Common\effects\airalarm.ogg": {_sleep = 0;};
		case "A3PL_Common\effects\firecall.ogg": {_sleep = 4.17;};
	};
	for "_i" from 0 to _loop do {
		playSound3D [_alarm, _building, false, getPosASL _building, 5, 1, _dist];
		sleep _sleep;
	};
}] call Server_Setup_Compile;

["A3PL_FD_SetFireAlarm",
{
	_building = param [0,objNull];
	if(_building getVariable ["FireAlarmBroke",false]) exitWith {["This alarm is broken, impossible to re-activate.",Color_Red] call A3PL_Player_Notification;};
	if(_building getVariable ["FireAlarm",false]) then {
		_building setVariable["FireAlarm",false,true];
		playSound3D ["A3PL_Common\effects\firealarm.ogg", _building, false, getPosASL _building, 5, 1, 200];
	} else {
		["This alarm is already active.",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_CheckFireAlarm",
{
	_building = param [0,objNull];
	if (((round random 100) > 85) && (_building getVariable["FireAlarmCanBroke",true])) then {
		_building setVariable["FireAlarmBroke",true,true];
		["The fire alarm is broken!",Color_Red] call A3PL_Player_Notification;
	} else {
		playSound3D ["A3PL_Common\effects\firealarm.ogg", _building, false, getPosASL _building, 2, 1, 100];
		_building setVariable["FireAlarmCanBroke",false,true];
		["This alarm is working properly.",Color_Green] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_RepairFireAlarm",
{
	_building = param [0,objNull];
	if(_building getVariable ["FireAlarmBroke",false]) then {
		if (!Player_ActionCompleted) exitwith {["You are already doing an action",Color_Red] call A3PL_Player_Notification;};
		Player_ActionCompleted = false;
		["Alarm repair ...",30] spawn A3PL_Lib_LoadAction;
		while {sleep 1.5; !Player_ActionCompleted } do {
			player playMove "Acts_carFixingWheel";
		};
		_building setVariable["FireAlarmBroke",false,true];
		_building setVariable["FireAlarmCanBroke",false,true];
		["You have repaired this alarm, you can now re-activate it.",Color_Green] call A3PL_Player_Notification;
	} else {
		["This alarm is not broken.",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_FD_FireStationAlarm",
{
	private _alarm = param [0,"A3PL_Common\effects\firecall.ogg"];
	private _distance = param [1,100];
	private _loop = param [2,0];
	private _sound = param [3,5];
	private _FireHousesPos = [[6031.07,7348.9,0.120704],[4470.77,7033.89,0.0245123],[10168.3,8548.8,0.0136862],[2651.5,5481.73,0.0356779]];
	{[nearestObject [_x,"Land_A3PL_Firestation"],_alarm,_loop,_distance,_sound] spawn A3PL_FD_AlarmLoop;} foreach _FireHousesPos;
}] call Server_Setup_Compile;

// FIFD COMPUTER
['A3PL_FD_ShowHydrant',{
	private _FireHydrants = nearestobjects [player,["Land_A3PL_FireHydrant"], 800];
	private _markersList = [];

	{
		_var = ((str(_x)splitString " :") select 1) splitString "";
		_hydrantID = format["%1%2%3",_var select 0, _var select 1, _var select 2];

		_marker = createMarkerLocal [format ["firehydrant_%1",_hydrantID], (getpos _x)];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "A3PL_Markers_FIFD";
		_marker setMarkerTextLocal format["Fire Hydrant #%1",_hydrantID];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerAlphaLocal 0.8;

		_markersList pushBack (_marker);
	} forEach _FireHydrants;
	sleep 120;
	{deleteMarkerLocal _x;} forEach _markersList;
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseArgu',{
	params[["_edit","",[""]],["_index",0,[0]]];
	_array = _edit splitString " ";
	_return = _array select _index;
	_return
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseRequireLogin',
[
	"sendcall","showhydrant","addhistory"//,"lookhistory","lookpatient"
]
] call Server_Setup_Compile;

['A3PL_FD_DatabaseEnterReceive',
{
	disableSerialization;

	private ["_newstruct","_display","_control"];
	params["_name","_command",["_return",""]];
	_output = "";
	//what command did we use?
	switch (_command) do {

		case "lookpatient":
		{
			if (count _return > 0) then
			{
				_output = format ["<t align='center'>Name: %1</t><br /><t align='center'>Sex: %2</t><br /><t align='center'>DOB: %3</t><br /><t align='center'>Passport: %4</t><br />",
				_name,
				(_return select 0),
				(_return select 1),
				(_return select 2)
				];
			} else
			{
				_output = format ["Can not find %1 in the database.",_name];
			};
		};

		case "lookhistory":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 at %3 - EMS : %4</t><br />",_x select 5,_x select 3,_x select 2,_x select 4]);
				} foreach _return;
			} else
			{
				_output = format ["Can not find %1 in the database.",_name];
			};
		};
		case "addhistory":
		{
			_output = _return;
		};
		default {_output = "Unknown Error - Please, contact FIFD developper."};
	};

	//Okay lets send output to struct
	_newstruct = format["%1<br />%2",(player getVariable "FDDatabaseStruc"),_output];
	player setVariable ["FDDatabaseStruc",_newstruct,false];
	[_newstruct] call A3PL_FD_UpdateComputer;

}] call Server_Setup_Compile;

['A3PL_FD_UpdateComputer',
{
	params[["_input","",[""]],["_new",false,[false]]];

	_display = findDisplay 211;
	_control = _display displayCtrl 1100;

	//Max 21 Lines
	_array = [_input, "<br />"] call CBA_fnc_split;

	if(count _array > 21) then {
		_remove = (count _array) - 21;

		for "_i" from 0 to _remove-1 do {
			_array deleteAt 0;
		};
	};

	//Rebuild out text
	_text = [_array, "<br />"] call CBA_fnc_join;

	player setVariable ["FDDatabaseStruc",_text,false];

	//Update our control
	_control ctrlSetStructuredText parseText _text;
}] call Server_Setup_Compile;

['A3PL_FD_DatabaseEnter',
{
	private ["_display","_control","_edit","_edit0","_newstruct"];
	disableSerialization;
	_display = findDisplay 211;

	_control = _display displayCtrl 1401;
	_edit = ctrlText _control;

	//First enter the entered command into the computer
	_newstruct = format["%1<br />%2",(player Getvariable "FDDatabaseStruc"),"> "+_edit];
	player setVariable ["FDDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_FD_UpdateComputer;

	//Okay now we need to clear the rscedit
	_control = _display displayCtrl 1401;
	_control ctrlSetText "";

	//Okay now lets do some magic
	_edit0 = [_edit,0] call A3PL_FD_DatabaseArgu;
	if ((_edit0 IN A3PL_FD_DatabaseRequireLogin) && (!(player getVariable "FDDatabaseLogin"))) exitwith
	{
		_newstruct = format["%1<br />%2",(player Getvariable "FDDatabaseStruc"),"You don't have permission to use this command"];
		player setVariable ["FDDatabaseStruc",_newstruct,false];

		[_newstruct] call A3PL_FD_UpdateComputer;
	};
	_output = "";
	switch (_edit0) do {
		case "help":
		{
			_output = "
			<t align='center'>help - Show all commands </t><br />
			<t align='center'>clear - Clear screen</t><br />
			<t align='center'>login [password] - Login to use commands</t><br />
			<t align='center'>lookpatient [firstname] [lastname] - View patient information</t><br />
			<t align='center'>addhistory [firstname] [lastname] [location] [infos] - Add a line to a patient's medical record</t><br />
			<t align='center'>lookhistory [firstname] [lastname] - View a patient's medical record</t><br />
			<t align='center'>sendcall - Trigger alarm stations</t><br />
			<t align='center'>showhydrant - See fire hydrant</t><br />
			";
		};
		case "clear": {_output = "<t align='center'>F.I.F.D. Database</t><br /><t align='center'>Enter 'help' for the list of available commands</t>";};
		case "login":
		{
			private ["_pass"];
			_pass = [_edit,1] call A3PL_FD_DatabaseArgu;
			if (_pass == "fistfdw") then
			{
				player setVariable ["FDDatabaseLogin",true,false];
				_output = "You are connected";
			} else
			{
				_output = "Error: Incorrect password";
			};
		};
		case "lookpatient":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);

			[[player,_name,_edit0],"Server_FD_Database",false,false] call BIS_FNC_MP;

			//Output
			_output = format ["Search a patient in F.I.F.D Database...",_name];
		};
		case "sendcall":
		{
			["A3PL_Common\effects\firecall.ogg",150,2,10] spawn A3PL_FD_FireStationAlarm;
		};

		case "showhydrant":
		{
			[] spawn A3PL_FD_ShowHydrant;
			_output = format ["Display of the nearest fire hydrants...",_name];
		};

		case "lookhistory":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);

			[[player,_name,_edit0],"Server_FD_Database",false,false] call BIS_FNC_MP;

			//Output
			_output = format ["Search of the medical file in progress...",_name];
		};
		case "addhistory":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_FD_DatabaseArgu) + " " + ([_edit,2] call A3PL_FD_DatabaseArgu);
			_place = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {_array deleteAt 0;};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_place,_info,_issuedBy],_edit0],"Server_FD_Database",false,false] call BIS_FNC_MP;
			//Output
			_output = format ["Information added to the patient's file...",_name];
		};
		default {_output = "Error: Unknown command"};
	};

	//Okay lets send output to struct
	_control = _display displayCtrl 1100;
	if (_edit0 == "clear") then
	{
		_newstruct = _output;
	} else
	{
		_newstruct = format["%1<br />%2",(player getVariable "FDDatabaseStruc"),_output];
	};
	player setVariable ["FDDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_FD_UpdateComputer;

}] call Server_Setup_Compile;

["A3PL_FD_DatabaseOpen",
{
	private ["_display","_text"];

	if(!(player getVariable ["job","unemployed"] in ["fifr"])) exitWith {["Only FIFD members can log in",Color_Red] call A3PL_Player_Notification;};

	_text = "<t align='center'>F.I.F.D. Database</t><br /><t align='center'>Enter 'help' to see all the available commands</t><br />> please login";
	player setVariable ["FDDatabaseStruc",_text,false];
	player setVariable ["FDDatabaseLogin",false,false];
	disableSerialization;
	createDialog "Dialog_PoliceDatabase";
	_display = findDisplay 211;
	_display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 28) then {[] call A3PL_FD_DatabaseEnter;}"];

	[_text] call A3PL_FD_UpdateComputer;
}] call Server_Setup_Compile;