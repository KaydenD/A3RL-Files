["Server_Setup_SetupDatabase",
{
	["Database", "SQL", "TEXT2"] call Server_Database_Setup;
	//["Database", "SQL_RAW_v2", "ADD_QUOTES"] call Server_Database_Setup;
	//"extDB3" callExtension "9:START_RCON:RCON";
	//"extDB3" callExtension "9:ADD_PROTOCOL:RCON:rcon";
	//diag_log "extDB3: RCON protocol Enabled";

	//lock database
	"extDB3" callExtension "9:LOCK";
	diag_log "extDB3: Locked";

	A3PL_DatabaseSetup = true;
},true] call Server_Setup_Compile;

["Server_Setup_ResetPlayerDB",
{
	private ["_query","_query2"];
	_query = "UPDATE players SET position = '[0,0,0]',job = 'unemployed'";
	_query2 = "UPDATE objects SET impounded = '2' WHERE impounded = '3'";
	_query3 = "UPDATE objects SET stolen = '0' WHERE stolen = '1'";
	_query4 = "UPDATE objects SET numpchange = '0' WHERE numpchange = '1'";
	[_query, 1] call Server_Database_Async;
	[_query2, 1] call Server_Database_Async;
	[_query3, 1] call Server_Database_Async;
	[_query4, 1] call Server_Database_Async;
},true] call Server_Setup_Compile;


//COMPILE BLOCK WARNING, COPY OF THIS IN fn_preinit.sqf
["Server_Setup_Init", {
	private ["_mods","_pVars"];

	ASAGNDJSN = true;
	publicVariable "ASAGNDJSN";

	waitUntil {(isNil 'A3PL_FilesSetup') isEqualTo false};

	//setup database
	[] call Server_Setup_SetupDatabase;
	waitUntil {(isNil 'A3PL_DatabaseSetup') isEqualTo false};
	Server_Setup_SetupDatabase = Nil;

	//setup server variables
	[] call Server_Core_Variables;

	//Setup 'HandleDisconnect' missionEventHandler (located in Server_Gear)
	[] call Server_Gear_HandleDisconnect;

	//Call the initial server storage
	[] call Server_Storage_Init;

	//Temporary Hotfix
	//all this crap runs into post-init
	[] spawn {
		waitUntil {!isNil "npc_bank"};
		[] call Server_Bowling_Setup;

		if (isDedicated) then //just to skip it in editor
		{
			[] call Server_Housing_Initialize;
		};

		//Get all the bus stops, using in loop later
		[] call A3PL_Lib_AnimBusStopInit;
		[] call Server_Shop_BlackMarketPos;
		[] call Server_JobFarming_DrugDealerPos;
		[] spawn Server_JobWildcat_RandomizeOil; //create the oil positions
		[] call Server_Core_GetDefVehicles; //create the defaulte vehicles array (for use in cleanup script)
		[] call Server_JobPicking_Init; //get the marker locations for picking locations
		[] spawn Server_Lumber_TreeRespawn; //spawn trees for lumberyacking
		//resource stuff, deprecated
		//Server_Ores = [] call Server_Resources_SearchMarkers; //create a list of markers where we will spawn ores
		//[] spawn Server_Resources_SpawnOres; //this will use Server_Ores

		//load stock values
		[] spawn Server_ShopStock_Load;

		/*iPhoneX*/
		//A3PL_iPhoneX_ListNumber = [];
		A3PL_iPhoneX_switchboardSD = [];
		A3PL_iPhoneX_switchboardFD = [];
		//[] call Server_iPhoneX_GetPhoneNumber;

		//Load fuel
		//Get All FuelStations
		private _FuelPositions = [
			[11293.7,9040.11,-0.00473404],
			[10228.2,8490.94,-0.00918436],
			[9924.96,8135.35,0.000571251],
			[6182.39,7425.36,0.000577927],
			[6249.88,7077.72,-0.00662994],
			[4165.8,6170.87,-0.00375271],
			[4624.15,4683.7,-0.0806308],
			[3435.99,7519.7,0.000520706],
			[2851.2,5555.24,-0.0508699],
			[2413.74,5496.1,0.00263214],
			[9751.54,7587.71,0.00143003]
		];
		FuelStations = [];
		{
			_tank = nearestObject [_x,"Land_A3PL_Gas_Station"];
			FuelStations pushBack _tank;
		} foreach _FuelPositions;

		//spawn cranes
		_craneright = createVehicle ["A3PL_MobileCrane", [3693.044,7625.027,39.260], [], 0, "CAN_COLLIDE"];
		_craneright setDir 52.482;
		_craneright setFuel 0;

		//Spawn Crane Left Import Export
		_craneleft = createVehicle ["A3PL_MobileCrane", [3659.797,7681.037,37.850], [], 0, "CAN_COLLIDE"];
		_craneleft setDir 232.025;
		_craneleft setFuel 0;

		//Load locker
		[] spawn Server_Locker_Load;
	};

	[] call Server_IE_Init; //init the ImportExport system

	[] call Server_Setup_ResetPlayerDB;

	//assign server loops - every 60 minutes
	//["itemAdd", ["Server_Youtube_Loop", { [] call Server_Youtube_Loop; }, 1]] call BIS_fnc_loop;
	["itemAdd", ["Server_PoliceLoop", { [] call Server_Police_JailLoop; }, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BLaneCheck", {[] call Server_Bowling_BLaneCheck;}, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_Fishing", {[] call Server_fisherman_loop;}, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BlackMarket", {[] call Server_Shop_BlackMarketPos;}, 1200]] call BIS_fnc_loop; //black market changes pos every 20min
	["itemAdd", ["Server_Loop_BlackMarketNear", {[] call Server_Shop_BlackMarketNear;}, 55]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_VDelivery", {[] call Server_JobVDelivery_Loop;}, 30]] call BIS_fnc_loop;
	//["itemAdd", ["Server_Loop_Farming", {[] call Server_JobFarming_Loop;}, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_DealerPos", {[] call Server_JobFarming_DrugDealerPos;}, 1200]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_VarsSave", {[] spawn Server_Core_SavePersistentVars;}, 60]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_MDelivery", {[] spawn Server_JobMDelivery_Loop;}, 35]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_RepairTerrain", {[] spawn Server_Core_RepairTerrain;}, 300]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_BusinessLoop", {[] spawn Server_Business_Loop;}, 60]] call BIS_fnc_loop; //delete expired businesses etc
	["itemAdd", ["Server_Loop_FogLoop", {10 setFog 0;}, 1800]] call BIS_fnc_loop;

	//deprecated ["itemAdd", ["Server_Loop_SpawnOres", {[] spawn Server_Resources_SpawnOres;}, 600]] call BIS_fnc_loop; //5min

	//cleanup
	["itemAdd", ["Server_Loop_Cleanup", {[] spawn Server_Core_Clean;}, 900]] call BIS_fnc_loop; //every 15 minutes run the cleanup loop

	//oil randomization, 60 min
	["itemAdd", ["Server_Loop_OilRandomization", {[] spawn Server_JobWildcat_RandomizeOil;}, 3600]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_ResTimeCheck", {[] spawn Server_JobWildcat_CheckResTimers;}, 60]] call BIS_fnc_loop;

	//Fire
	["itemAdd", ["Server_Fire_FireLoop", {[] spawn Server_Fire_FireLoop;}, 10]] call BIS_fnc_loop; //Spread fire every 10sec, edit the number to increase spread time

	//bus stops
	["itemAdd", ["Server_Lib_AnimBusStop", {[] spawn A3PL_Lib_AnimBusStop;}, 10]] call BIS_fnc_loop; //Bus stop

	//Picking loop
	["itemAdd", ["Server_Loop_Picking", {[] spawn Server_JobPicking_Loop;}, 55]] call BIS_fnc_loop;

	//tree respawn for lumberyack
	["itemAdd", ["Server_Loop_TreeRespawn", {[] spawn Server_Lumber_TreeRespawn;}, 1800]] call BIS_fnc_loop;

	//loop for import_export
	["itemAdd", ["Server_Loop_IE", {[] spawn Server_IE_ShipImport;}, 2100]] call BIS_fnc_loop; //35 minutes

	//loop for animals
	["itemAdd", ["Server_Loop_Goats",
	{
		["goat",[8703.66,8172.92,0],["Goat","Goat02","Goat03"],200,13] spawn Server_Hunting_SpawnLoop;
	}, 62]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_Boars",
	{
		["wildboar",[6601.76,7517.37,0],["WildBoar"],230,13] spawn Server_Hunting_SpawnLoop;
	}, 65]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_Sheep",
	{
		["sheep",[6934.04,7442.04,0],["Sheep","Sheep02","Sheep03"],200,13] spawn Server_Hunting_SpawnLoop;
	}, 68]] call BIS_fnc_loop;

	//save stock values every 70 sec
	["itemAdd", ["Server_Loop_SaveStockValues",
	{
		[] spawn Server_ShopStock_Save;
	}, 70]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_SaveLockers",
	{
		[] spawn Server_Locker_Save;
	}, 600]] call BIS_fnc_loop;

	//lastly load all the persistent vars from database
	_pVars = ["SELECT * FROM persistent_vars", 2, true] call Server_Database_Async;
	{
		_compile = formatText ['%1 = %2;',(_x select 0),([(_x select 1)] call Server_Database_ToArray)];
		call compile str(_compile);

		//if we require to pv this variable then
		if ((_x select 2) == 1) then
		{
			publicVariable (_x select 0);
		};
	} foreach _pVars;

	//check addons
	Server_ModVersion = getNumber (configFile >> "CfgPatches" >> "A3PL_Common" >> "requiredVersion");
	publicVariable "Server_ModVersion";

	//Tell clients that server is setup
	A3PL_ServerLoaded = true;
	publicVariable "A3PL_ServerLoaded";
},true,true] call Server_Setup_Compile;