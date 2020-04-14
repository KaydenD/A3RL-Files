/////////////////////////////////
// Setting up Server Variables //
/////////////////////////////////

['Server_Core_Variables', {
	// Used in Server_A3Save
	A3PL_RetrievedInventory = true;
	Server_Storage_ListVehicles = [];
	server setVariable ['Server_DroppedItems', [], true];

	Server_AptList = nearestObjects [[3594.66,6664.16,0], ["Land_A3PL_Motel"], 5000];

	//Setvariable all apt buildings, this will allow us to keep track of which appartment is assigned later
	{
		_x setVariable ["Server_AptAssigned",[],false];
	} foreach Server_AptList;

	//Variable that stores a list of owned/sold houses
	Server_HouseList = [];

	//Variable that stores all fishing buoys
	Server_FishingBuoys = [];

	//greenhouses
	Server_JobFarming_GreenHouses = [];

	//Variable that stores the vehicle delivery job list
	Server_JobVDelivery_JobList = [];

	//variable that stores the current vehicle deliveries in progress
	Server_JobVDelivery_Deliveries = [];

	//Mdelivery
	Server_JobMDelivery_JobList = [];
	Server_JobMDelivery_Deliveries = [];

	//List of all jailed players
	//[obj,uid,time]
	Server_Jailed_Players = [];

	//Dispatchers
	Server_Dispatchers = [];
	Server_Dispatch_Active = [];

	//Youtube Bullshit
	A3PL_Youtube_Queue = []; //List of player submitted URLS (already checked to be valid)
	A3PL_Youtube_Viewers = []; //List of players in queue
	A3PL_Current_Video = ""; //Current Video URL
	A3PL_Playing_Video = false; //Video currently playing
	A3PL_Video_Preparing = false; //Video has been sent and is in queue
	A3PL_PrepTime = 0;
	A3PL_Skip = 5;

	A3PL_Uber_Drivers = [];
	A3PL_Uber_Riders = [];

	A3PL_HitchingVehicles = ["A3PL_Car_Base","A3PL_Truck_Base"];  //a copy of this variable also exist on the client
	Player_MaxWeight = 20; //copy on the client too!

	// Fire Variables //

	Server_TerrainFires = [];
	Server_ObjectFires = [];
	Server_FireLooping = true;

	//markerlist
	Server_JobRoadWorker_Marked = [];
	publicVariable "Server_JobRoadWorker_Marked";

}, true] call Server_Setup_Compile;

//saves a variable into the persistent variables table
//COMPILE BLOCK WARNING!!!!
["Server_Core_SavePersistentVar",
{
	if (!isDedicated) exitwith {};

	private ["_var","_query"];
	_var = param [0,""];
	_toArray = param [1,true];

	if (_toArray) then
	{
		_query = format ["UPDATE persistent_vars SET value='%2' WHERE var = '%1'",_var,[(call compile _var)] call Server_Database_Array];
	} else
	{
		_query = format ["UPDATE persistent_vars SET value='%2' WHERE var = '%1'",_var,(call compile _var)];
	};

	[_query,1] spawn Server_Database_Async;

},true,true] call Server_Setup_Compile;


//Run this to save mayor vars and other stuff into the database
["Server_Core_SavePersistentVars",
{
	/* fix this later
	["Tax_Property_Balance",false] call Server_Core_SavePersistentVar;
	["Tax_Income_Balance",false] call Server_Core_SavePersistentVar;
	["Tax_Sales_Balance",false] call Server_Core_SavePersistentVar;
	*/
},true] call Server_Setup_Compile;

//Change a blacklisted variable for player from server
["Server_Core_ChangeVar", {
	private ["_obj", "_variable", "_value"];

	_obj = param [0,objNull];
	_variable = param [1,"ERROR"];
	_value = param [2,"ERROR"];

	//end if no player was sent
	if (isNull _obj) exitWith {};

	//end if no variable was sent
	if ((str _variable) == "ERROR") exitWith {};

	//end if no value was sent
	if ((str _value) == "ERROR") exitWith {};

	//change variable
	_obj setVariable [_variable, _value, true];

	//Create log of variable change
	//Diag_Log format['LOG: %1 (%2), %3, %4 (A3PL_Server_ChangeVar)', (getPlayerUID _player), name _player, _variable, _value];
}, true] call Server_Setup_Compile;

//get a list of default vehicles so they aren't cleaned up later
["Server_Core_GetDefVehicles",
{
	Server_Core_DefVehicles = allMissionObjects "All";
},true] call Server_Setup_Compile;

//cleanup items
["Server_Core_Clean",
{
	private ["_toDelete","_items","_objects","_allMO","_ignore"];
	_objects = 0;
	_toDelete = [];
	_allMO = allMissionObjects "All";
	_ignore = ["A3PL_Anchor","A3PL_FSS_Siren","A3PL_FSS_Phaser","A3PL_FSS_Priority","A3PL_FSS_Rumbler","A3PL_EQ2B_Wail","A3PL_Whelen_Warble","A3PL_AirHorn_1","A3PL_FSUO_Siren","A3PL_Whelen_Priority3","A3PL_FIPA20A_Priority","A3PL_Electric_Horn","A3PL_Whelen_Siren","A3PL_Whelen_Priority""A3PL_Whelen_Priority2""A3PL_Electric_Airhorn","A3PL_Lifebuoy","A3PL_rescueBasket","A3PL_Ladder","A3PL_OilBarrel","A3PL_MiniExcavator_Bucket","A3PL_MiniExcavator_Jackhammer","A3PL_MiniExcavator_Claw","A3PL_TapeSign","A3PL_PlasticBarrier_01","A3PL_PlasticBarrier_02","A3PL_Road_Bollard","A3PL_RoadBarrier","A3PL_AAA_Box","A3PL_Corn","A3PL_Marijuana","A3PL_Wheat","A3PL_Lettuce","A3PL_Coco_Plant","A3PL_Sugarcane_Plant","A3PL_DeliveryBox","A3PL_Net","A3PL_Stinger","A3PL_Camping_Light","Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F","Land_WoodenTable_small_F","Land_cargo_house_slum_F","Rope","A3PL_Yacht_Pirate","A3PL_Pumpjack","A3PL_OilBarrel","A3PL_Drillhole","A3PL_Ladder","A3PL_FireObject","A3PL_FD_HoseEnd1_Float","A3PL_FD_HoseEnd2_Float","A3PL_FD_HoseEnd2","A3PL_FD_HoseEnd1","A3PL_FD_EmptyPhysx","A3PL_FD_yAdapter","A3PL_FD_HydrantWrench_F","Box_GEN_Equip_F","A3PL_Container_Hook","A3PL_MobileCrane","A3PL_Container_Ship","A3PL_RoadCone_x10","A3PL_RoadCone","Land_A3PL_Tree3","Rabbit_F","A3PL_Grainsack_Malt","A3PL_Grainsack_Yeast","A3PL_Grainsack_CornMeal","A3PL_Distillery","A3PL_Distillery_Hose","A3PL_Jug","A3PL_Jug_Green","Land_A3PL_EstateSign","Land_A3PL_FireHydrant","A3PL_Cannabis","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F","Land_Can_Dented_F","O_Heli_Light_02_unarmed_F","SoundSource_4","SoundSource_3","SoundSource_2","SoundSource_1"];

	{
		if (((_x getVariable ["clean",0]) > 0) && ((Server_Core_DefVehicles find _x) == -1)) then
		{

			//check if this is an item that has pickup set to false in Config_Items
			private ["_class"];
			_skip = false;
			_class = _x getVariable ["class",nil];
			if (!isNil "_class") then
			{
				if (!([_class,"canPickup"] call A3PL_Config_GetItem)) then {_skip = true;};
			};
			//if not skipped
			if (!_skip) then
			{
				_toDelete pushback _x;
			};
		} else
		{
			_x setVariable ["clean",1,false]; //mark unused
		};
	} foreach _allMO;

	{
		if (!isNil {_x getVariable ["keyAccess",nil]}) then
		{
			if ((count crew _x) > 0) then //check in-use otherwise reset clean
			{
				//_x setVariable ["clean",nil,false];
			} else
			{
				//deal with impounding vehicle (disabled)
			};
		} else
		{
			if ((!isNull (attachedTo _x)) OR (!isNil {_x getVariable ["bItem",nil]}) OR ((typeOf _x) IN _ignore)) then //check if the object is attached to something (player,vehicle etc)
			{
				_x setVariable ["clean",nil,false];
			} else
			{
				deleteVehicle _x;
				_objects = _objects + 1;
			};
		};
	} foreach _toDelete;

	//[format ["Server Cleanup: %1 unused objects deleted",_objects]] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;

//repairs all terrain objects
["Server_Core_RepairTerrain",
{
	private ["_c"];

	_c = 0;

	{
		if (getDammage _x == 1) then
		{
			_x setDammage 0;
			_c = _c + 1;
		};
	} foreach nearestTerrainObjects [[6690.16,7330.15,0], [], 10000];

	//[format ["Server Debug: %1 terrain objects were repaired",_c]] remoteExec ["A3PL_Player_Notification", -2];
},true] call Server_Setup_Compile;

["Server_Core_Restart",
{
	"IUqof456sd=!&L" serverCommand "#lock";
	[format ["!!! ALERT !!! Restart in 10 minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
	[format ["!!! ALERT !!! Restart in 10 minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
	[format ["!!! ALERT !!! Restart in 10 minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
	["A3PL_Common\effects\airalarm.ogg",2500,0,10] spawn A3PL_FD_FireStationAlarm;
	
	0 setRain 1;  
	0 setFog [0.1, 0, 10];
	setWind [10, 10, true];
	0 setGusts 1;
	0 setOvercast 1;
	0 setLightnings 1;
	forceWeatherChange;

	for "_i" from 0 to 2 do {
		sleep 140;
		[format ["!!! ALERT !!! Restart in a few minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
		[format ["!!! ALERT !!! Restart in a few minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
		[format ["!!! ALERT !!! Restart in a few minutes"],Color_Red] remoteExec ["A3PL_Player_Notification", -2];
		["A3PL_Common\effects\airalarm.ogg",2500,0,10] spawn A3PL_FD_FireStationAlarm;
	};
	sleep 120;
	{
		"IUqof456sd=!&L" serverCommand format ["#kick %1",name _x];
	} forEach AllPlayers;
	sleep 10;
	"IUqof456sd=!&L" serverCommand "#restartserver";
},true] call Server_Setup_Compile;