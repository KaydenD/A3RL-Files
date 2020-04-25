/**
*
*	Author: Kane
*	Website: http://arma3projectlife.com/
*	Name: fn_preinit.sqf
*	Description: Runs pre-init systems
*
**/
#include "Server_Macro.hpp"

diag_log "RUNNING SERVER INIT";

SewuTL926P8Gnm9YUKYnDNhPtReUZ7 = true;
publicVariable "SewuTL926P8Gnm9YUKYnDNhPtReUZ7";

[] spawn
{
	waitUntil {sleep 0.2; !isNil "A3PL_FilesSetup"};
	diag_log "A3PL_FilesSetup received";
	if (!hasInterface) then
	{
		sleep 4;
	};
	diag_log "Waiting for Server_Setup_Init";
	waitUntil {sleep 0.2; !isNil "Server_Setup_Init"};

	[] spawn Server_Setup_Init;
};

Server_Setup_Compile = {
	private ["_name", "_code", "_forServer", "_compile"];

	_name = param [0,""];
	_code = param [1,{}];
	_forServer = param [2,false];
	_compile = formatText ["%1 = %2;", _name, _code];

	if (isServer) then
	{
		call compile str(_compile);
	} else
	{
		call compileFinal str _compile;
	};

	if(_forServer isEqualTo false) then {
		publicVariable _name;
	};
};

//ALL THE COMPILE BLOCKS
//ALL THE COMPILE BLOCKS
//ALL THE COMPILE BLOCKS
//ALL THE COMPILE BLOCKS
//ALL THE COMPILE BLOCKS

["Server_ShopStock_Load",
{
	private ["_stocks"];
	_stocks = ["SELECT object,stock FROM shops ORDER BY id ASC", 2, true] call Server_Database_Async;

	{
		private ["_object","_stock"];
		_object = call compile (_x select 0);
		_stock = call compile (_x select 1);
		_object setVariable ["stock",_stock,true];
	} foreach _stocks;
},true] call Server_Setup_Compile;


['A3PL_ATM_Transfer', {
	private ['_amount', '_sendTo', '_sendToCompile', '_format'];

	_amount = round(parseNumber(ctrlText 5372));
	_sendTo = lbData [5472, (lbCurSel 5472)];
	_sendToCompile = call compile _sendTo;

	if (_sendToCompile isEqualTo player) exitWith {
		[localize "STR_A3PL_ATM_SELFT", Color_Red] call A3PL_Player_Notification;
	};

	if (((lbCurSel 5472) == -1) || (_amount <= 0)) exitWith {
		[localize "STR_A3PL_ATM_INVALID", Color_Red] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWIth {
		[localize "STR_A3PL_ATM_INSUFFICENT", Color_Red] call A3PL_Player_Notification;
	};

	//todo transfer notification

	[[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
	[[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	//todo send message to reciever

	_format = format[localize "STR_A3PL_ATM_TRANSFERS", [_amount] call A3PL_Lib_FormatNumber, (name _sendTo)];
	[_format, Color_Green] call A3PL_Player_Notification;

	[0] call A3PL_Lib_CloseDialog;
},false,true] call Server_Setup_Compile;

//Compile BLOCK warning
["A3PL_Debug_Execute", {

	private ["_display","_debugText","_chosenExecType","_remoteExecType","_compileRdy"];
	_display = findDisplay 155;
	_debugText = ctrlText 1400;
	_chosenExecType = lbText [2100,lbCurSel 2100];
	_remoteExecType = clientOwner;

	switch (_chosenExecType) do {
		case "Serveur": {_remoteExecType = 2};
		case "Global": {_remoteExecType = 0};
		case "All Clients": {_remoteExecType = -2};
		case "Local": {_remoteExecType = clientOwner};
		default {_remoteExecType = clientOwner};
	};

	[_debugText] remoteExec ["A3PL_Debug_ExecuteCompiled",_remoteExecType];
},false,true] call Server_Setup_Compile;

["A3PL_Debug_ExecuteCompiled", {

	private ["_debugText"];
	_debugText = param [0,"Rien"];

	if (_debugText == "Rien") exitWith {};

	call compile _debugText;
},false,true] call Server_Setup_Compile;

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

["A3PL_Loading_Request", {

	[] spawn {
		private ["_waiting","_display","_control", '_format',"_pos"];
		
		//Whitelisting Check
		[[player],"Server_Whitelisting_Check",false,false,false] call BIS_FNC_MP;
		
		disableSerialization;

		_display = findDisplay 15;

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Server functions received</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.3;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>30%</t>";
		_control ctrlSetStructuredText (parseText _format);

		// Do not start doing any of this until we are in the game
		waitUntil {sleep 0.5; player == player};
		_pos = getpos player;
		sleep 1;
		
		//Send request to server to load player gear
		[[player],"Server_Gear_Load",false,false,false] call BIS_FNC_MP;

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Receiving player gear</t>";
		_control ctrlSetStructuredText (parseText _format);

		_waiting = 0;
		while {isNil "A3PL_RetrievedInventory"} do
		{
			sleep 2;
			_waiting = _waiting + 2;
			if (_waiting > 10) then
			{
				// send request again after 10sec of no reply
				[[player],"Server_Gear_Load",false,false,false] call BIS_FNC_MP;
				_waiting = 0;
			};
		};

		// Enable drugs system
		// Types of drugs in array,If passed out or not
		player setvariable ["drugs_array",[[["alcohol",0],["cocaine",0],["shrooms",0]],false],true];
		player setVariable ["Zipped",false,true];
		player setVariable ["DoubleTapped",false,true];
		player setVariable ["picking",false,true];
		player setVariable ["working",false,true];

		// use this sleep instead of this while in editor
		if (isServer) then {
			sleep 2;
		} else
		{
			//If position is changed by the server we have loaded the gear
			while {_pos isEqualTo (getpos player)} do
			{
				sleep 0.4;
				_format = "<t size='1' align='center' color='#B8B8B8'>Receiving player gear.</t>";
				_control ctrlSetStructuredText (parseText _format);
				sleep 0.4;
				_format = "<t size='1' align='center' color='#B8B8B8'>Receiving player gear..</t>";
				_control ctrlSetStructuredText (parseText _format);
				sleep 0.4;
				_format = "<t size='1' align='center' color='#B8B8B8'>Receiving player gear...</t>";
				_control ctrlSetStructuredText (parseText _format);
			};
		};

		//okay, we are out of the loop, lets set the markers for houses
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.4;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>40%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Assigning house/appartment...</t>";
		_control ctrlSetStructuredText (parseText _format);


		// Stats retrieved succesfully
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.5;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>50%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Player gear loaded</t>";
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		_format = "<t size='1' align='center' color='#B8B8B8'>Initializing current vehicles...</t>";
		_control ctrlSetStructuredText (parseText _format);


		//Comment next line to disable all client vehicle inits from config (might help in debugging lag etc)
		A3PL_Vehicle_HandleInitU = toArray (format ["%1",A3PL_Vehicle_HandleInitU]);
		A3PL_Vehicle_HandleInitU deleteAt 0;
		A3PL_Vehicle_HandleInitU deleteAt ((count A3PL_Vehicle_HandleInitU) - 1);
		A3PL_Vehicle_HandleInitU = toString A3PL_Vehicle_HandleInitU;
		A3PL_HandleVehicleInit = compileFinal A3PL_Vehicle_HandleInitU;


		sleep 2;

		// Vehicles loaded
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.9;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>70%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Vehicles initialized succesfully</t>";
		_control ctrlSetStructuredText (parseText _format);

		sleep 2;

		[] call A3PL_Medical_Init;
		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>80%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Medical system initialized</t>";
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		//Once done loading everything lets closeDialog
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 1;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>100%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Player initialized succesfully</t>";
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		_display displayRemoveEventHandler ["KeyDown", noEscape];

		[0] call A3PL_Lib_CloseDialog;

		player setVariable ["tf_voiceVolume", 1, true];
		cutText["","BLACK IN"];

		//load the admins
		[] call A3PL_Admin_Check;

		player enableSimulation true;
		player setvariable ["FinishedLoading",true,true];

		showChat false;
	};
},false,true] call Server_Setup_Compile;
/*
["A3PL_ATC_GetInAircraft",
{
	private ["_veh","_atcText","_status","_active"];

	_veh = param [0,objNull];
	A3PL_ATC_IsListeningATC = false;

	while {player IN _veh} do
	{
		_active = call TFAR_fnc_activeLRRadio;
		if (!isNil "_active" && (_active select 1 IN ["driver_radio_settings","gunner_radio_settings"])) then
		{

			//Sync gunner seat to driver seat LR frequency
			if (player != driver _veh) then
			{
				if (([_veh,"gunner_radio_settings"] call TFAR_fnc_getLrFrequency) != ([_veh,"driver_radio_settings"] call TFAR_fnc_getLrFrequency)) then
				{
					[[_veh, "driver_radio_settings"],[_veh, "gunner_radio_settings"]] call TFAR_fnc_CopySettings;
				};
			};

			_frequency = (parseNumber ((call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency)) == 127; //check if we are on ATIS

			//if we are on ATIS then do the following
			if (_frequency) then
			{
				//check status
				_status = call compile ("Arma2Net.Unmanaged" callExtension "ATIS ['ATIS_Status']");

				//Get ATC text
				if (isNil "A3PL_ATC_ATISTEXT") then
				{
					_atcText = "Fishers Island Elisabeth Field. Currently no ATIS information is available. No takeoff clearances until tower is occupied";
				} else
				{
					_atcText = A3PL_ATC_ATISTEXT;
				};

				if (_status != "SPEAKING") then
				{
					"Arma2Net.Unmanaged" callExtension format ["ATIS ['ATIS_Start',%1]",_atcText];
					A3PL_ATC_IsListeningATC = true;
				};
			} else
			{
				if (A3PL_ATC_IsListeningATC) then
				{
					"Arma2Net.Unmanaged" callExtension "ATIS ['ATIS_Stop']";
					A3PL_ATC_IsListeningATC = false;
				};
				A3PL_ATC_IsListeningATC = false;
			};
		};

		uiSleep 1;
	};

	if (A3PL_ATC_IsListeningATC) then
	{
		"Arma2Net.Unmanaged" callExtension "ATIS ['ATIS_Stop']";
	};
},false,true] call Server_Setup_Compile;
*/

["Server_Setup_Init", {
	private ["_mods","_pVars"];

	ASAGNDJSN = true;
	publicVariable "ASAGNDJSN";

	waitUntil {(isNil 'A3PL_FilesSetup') isEqualTo false};

	//setup database
	[] call Server_Setup_SetupDatabase;
	waitUntil {(isNil 'A3PL_DatabaseSetup') isEqualTo false};
	Server_Setup_SetupDatabase = Nil;

	[] call Server_Core_Variables;

	//Setup 'HandleDisconnect' missionEventHandler (located in Server_Gear)
	[] call Server_Gear_HandleDisconnect;

	//Call the initial server storage
	[] call Server_Storage_Init;

	//Load Fuel in Gas Station
	[] call Server_Hydrogen_Load;

	[] call Server_EvidenceLocker_Load;
	
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
		[] spawn Server_JobWildcat_RandomizeRes;
		[] call Server_Core_GetDefVehicles; //create the defaulte vehicles array (for use in cleanup script)
		[] call Server_JobPicking_Init; //get the marker locations for picking locations
		[] spawn Server_Lumber_TreeRespawn;
		//resource stuff, deprecated
		//Server_Ores = [] call Server_Resources_SearchMarkers; //create a list of markers where we will spawn ores
		//[] spawn Server_Resources_SpawnOres; //this will use Server_Ores

		[] spawn Server_ShopStock_Load;
		[] spawn Server_Locker_Load;

		/*iPhoneX*/
		A3PL_iPhoneX_ListNumber = [];
		A3PL_iPhoneX_switchboardSD = [];
		A3PL_iPhoneX_switchboardFD = [];
		//[] call Server_iPhoneX_GetPhoneNumber;

		//Load fuel
		/*Get All FuelStations*/
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

		//load fuel to stations
		//spawn cranes
		_craneright = createVehicle ["A3PL_MobileCrane", [3693.044,7625.027,39.260], [], 0, "CAN_COLLIDE"];
		_craneright setDir 52.482;
		_craneright setFuel 0;

		//Spawn Crane Left Import Export
		_craneleft = createVehicle ["A3PL_MobileCrane", [3659.797,7681.037,37.850], [], 0, "CAN_COLLIDE"];
		_craneleft setDir 232.025;
		_craneleft setFuel 0;
	};

	[] call Server_IE_Init; //init the ImportExport system

	[] call Server_Setup_ResetPlayerDB;


	//assign server loops - every 60 seconds
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

	// Save Gear and Player Variables //

	["itemAdd", ["Server_Loop_Gear_Save", {[] spawn Server_Gear_SaveLoop}, 300]] call BIS_fnc_loop;

	//deprecated ["itemAdd", ["Server_Loop_SpawnOres", {[] spawn Server_Resources_SpawnOres;}, 600]] call BIS_fnc_loop; //5min

	//cleanup
	["itemAdd", ["Server_Loop_Cleanup", {[] spawn Server_Core_Clean;}, 900]] call BIS_fnc_loop; //every 15 minutes run the cleanup loop

	//oil randomization, 60 min
	["itemAdd", ["Server_Loop_OilRandomization", {[] spawn Server_JobWildcat_RandomizeOil;}, 3600]] call BIS_fnc_loop;
	["itemAdd", ["Server_Loop_ResRandomization", {[] spawn Server_JobWildcat_RandomizeRes;}, 3600]] call BIS_fnc_loop;

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
	
	//Gas Station Save
	["itemAdd", ["Server_Loop_Server_GasSave", {[] spawn Server_Hydrogen_Save;}, 1800]] call BIS_fnc_loop; //30 minutes

	//Evidence Locker Save
	["itemAdd", ["Server_Loop_Server_EvidenceLockerSave", {[] spawn Server_EvidenceLocker_Save;}, 1800]] call BIS_fnc_loop; // 30 mintues

	["itemAdd", ["Server_Loop_Server_SaveTrunks", {[] spawn Server_Trunk_Save;}, 1500]] call BIS_fnc_loop; //Very database intensive, don't want it to run every 30 mins with the other loops. 

	//loop for animals
	["itemAdd", ["Server_Loop_Goats",
	{
		["goat",[8703.66,8172.92,0],["Goat","Goat02","Goat03"],200,13] spawn Server_Hunting_SpawnLoop;
	}, 120]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_Boars",
	{
		["wildboar",[6601.76,7517.37,0],["WildBoar"],230,13] spawn Server_Hunting_SpawnLoop;
	}, 123]] call BIS_fnc_loop;

	["itemAdd", ["Server_Loop_Sheep",
	{
		["sheep",[6934.04,7442.04,0],["Sheep","Sheep02","Sheep03"],200,13] spawn Server_Hunting_SpawnLoop;
	}, 125]] call BIS_fnc_loop;

	//save stock values every 70 sec
	["itemAdd", ["Server_Loop_SaveStockValues",
	{
		[] spawn Server_ShopStock_Save;
	}, 70]] call BIS_fnc_loop;


	["itemAdd", ["Server_Loop_SaveLockers",
	{
		[] spawn Server_Locker_Save;
	}, 1200]] call BIS_fnc_loop;

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


//////////////////////////
//  DATABASE FUNCTIONS  //
//////////////////////////


['Server_Database_ToArray', {
	private["_array"];
	_array = [_this,0,"",[""]] call BIS_fnc_param;
	if(_array == "") exitWith {[]};
	_array = toArray(_array);

	for "_i" from 0 to (count _array)-1 do
	{
		_sel = _array select _i;
		if(_sel == 96) then
		{
			_array set[_i,39];
		};
	};

	_array = toString(_array);
	_array = call compile format["%1", _array];
	_array;
},true,true] call Server_Setup_Compile;

['Server_Database_Setup', {
        private ['_database', '_protocol', '_protocolOptions', '_return', '_result', '_randomNumber', '_extDBCustomID'];

        _database = [_this,0,"",[""]] call BIS_fnc_param;
        _protocol = [_this,1,"",[""]] call BIS_fnc_param;
        _protocolOptions = [_this,2,"",[""]] call BIS_fnc_param;
        _return = false;

        if ( isNil {uiNamespace getVariable "extDBCustomID"} ) then {
                // extDB Version
                _result = "extDB3" callExtension "9:VERSION";

                diag_log format ["extDB3: Version: %1", _result];

                if(_result == "") exitWith {diag_log "extDB3: Failed to Load"; false};
                //if ((parseNumber _result) < 20) exitWith {diag_log "Error: extDB version 20 or Higher Required";};

                // extDB Connect to Database
                _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", _database]);

                if (_result select 0 isEqualTo 0) exitWith {
                        diag_log format ["extDB3: Error Database: %1", _result];
                        false
                };

                diag_log "extDB3: Connected to Database";

                // Generate Randomized Protocol Name
                _randomNumber = round(random(999999));
                _extDBCustomID = str(_randomNumber);

                extDBCustomID = compileFinal _extDBCustomID;

                // extDB Load Protocol
                _result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:%2:%3:%4", _database, _protocol, _extDBCustomID, _protocolOptions]);

                if ((_result select 0) isEqualTo 0) exitWith {
                        diag_log format ["extDB3: Error Database Setup: %1", _result];
                        false
                };

                diag_log format ["extDB3: Initalized %1 Protocol", _protocol];

                // Save Randomized ID
                uiNamespace setVariable ["extDBCustomID", _extDBCustomID];

                _return = true;
        }
        else {
                extDBCustomID = compileFinal str(uiNamespace getVariable "extDBCustomID");

                diag_log "extDB3: Already Setup";

                _return = true;
        };

        _return
}, true, true] call Server_Setup_Compile;

['Server_Database_Async', {
	private["_queryResult","_key","_return","_loop"];
	params [["_queryStmt","",[""]],["_mode",1,[0]],["_multiarr",false,[false]]];

	_key = "extDB3" callExtension format["%1:%2:%3", _mode, (call extDBCustomID), _queryStmt];

	if(EQUAL(_mode,1)) exitWith {true};

	_key = call compile format["%1",_key];
	_key = SEL(_key,1);

	_queryResult = "";
	_loop = true;
	while{_loop} do {
		_queryResult = EXTDB format["4:%1", _key];
		if (EQUAL(_queryResult,"[5]")) then {
			// extDB3 returned that result is Multi-Part Message
			_queryResult = "";
			while{true} do {
				_pipe = EXTDB format["5:%1", _key];
				if(_pipe == "") exitWith {_loop = false};
				_queryResult = _queryResult + _pipe;
			};
		} else {
			if (EQUAL(_queryResult,"[3]")) then {
				//diag_log format ["extDB3: uiSleep [4]: %1", diag_tickTime];
				//uiSleep 0.1;
			} else {
				_loop = false;
			};
		};
	};

	_queryResult = call compile _queryResult;

	if(EQUAL(SEL(_queryResult,0),0)) exitWith {diag_log format ["extDB3: Protocol Error: %1", _queryResult]; []};
	_return = SEL(_queryResult,1);
	if(!_multiarr && count _return > 0) then {
		_return = SEL(_return,0);
	};

	_return;
}, true, true] call Server_Setup_Compile;

["Server_Database_ArrayToSqlIN",
{
	private ["_return","_input","_return"];
	_input = param [0,""];
	_input = call compile (format ["%1",_input]);

	_return = toArray (format ["%1",_input]);
	_input = toArray (format ["%1",_input]);

	{
		if (_x == 91) then
		{
			_return set [_forEachIndex,40];
		};
		if (_x == 93) then
		{
			_return set [_forEachIndex,41];
		};
	} foreach _input;
	_return = toString _return;
	_return;
},true,true] call Server_Setup_Compile;

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


/////////////////////////////////
//  PLAYER GEAR AND VARIABLES  //
/////////////////////////////////


["Server_Gear_Load", {
	private ["_unit", "_uid", "_return", "_query", "_pos", "_loadout","_name","_houseVar","_ownsHouse","_houseObj","_job","_virtinv","_cash","_bank","_facStorage","_licenses","_twitterProfile","_perks","_ship","_adminWatch","_paycheck"];
	_unit = _this select 0;
	_uid = getPlayerUID _unit;

	_query = format ["SELECT position,loadout,name,faction,userkey,job,virtualinv,cash,bank,jail,ID,dob,pasportdate,player_fstorage,adminLevel,licenses,twitterprofile,perks,ship,adminWatch,medstats,paycheck FROM players WHERE uid='%1'", _uid];
	_return = [_query, 2] call Server_Database_Async;

	// Quick Checks //

	if (count _return == 0) exitwith {[_unit,true] call Server_Gear_New;};

	_name = _return select 2;

	if (_name == "") exitwith {[_unit,false] call Server_Gear_New;};

	// Assigning Values to Variables //

	//Possessive
	_keys = [(_return select 4)] call Server_Database_ToArray;
	_loadout = [(_return select 1)] call Server_Database_ToArray;
	_virtinv = [(_return select 6)] call Server_Database_ToArray;
	_facStorage = [(_return select 13)] call Server_Database_ToArray;

	_licenses = [(_return select 15)] call Server_Database_ToArray;
	_twitterProfile = call compile (_return select 16);
	_perks = call compile (_return select 17);
	_ship = [(_return select 18)] call Server_Database_ToArray;
	//Informative
	_pos = call compile (_return select 0);
	_job = _return select 5;
	_id = _return select 10;
	_passportdate = _return select 12;
	_cash = parseNumber (_return select 7);
	_bank = parseNumber (_return select 8);
	_jail = _return select 9;
	_dob = _return select 11;
	_faction = _return select 3;
	_AdminLevel = _return select 14;
	_adminWatch = _return select 19;
	_medStat = [(_return select 20)] call Server_Database_ToArray;
	_paycheck = parseNumber (_return select 21);

	//Medstats
	_unit setVariable ["A3PL_Wounds",_medStat select 0,true];
	_unit setVariable ["A3PL_MedicalVars",_medStat select 1,true];

	//Possessive
	_unit setVariable ["keys",_keys,true];								//House and car keys in vInventory.
	_unit setUnitLoadout _loadout;										//What the player is wearing.
	_unit setVariable ["twitterprofile",_twitterProfile,true];			//The "profiles" they can use and appear as in Twitter.
	_unit setVariable ["perks",_perks,true];							//Doesn't work for anything right now.
	_unit setVariable ["player_importing",(_ship select 0),true];		//What the player is importing.
	_unit setVariable ["player_exporting",(_ship select 1),true];		//What the player is exporting.
	_unit setVariable ["player_inventory",_virtinv,true];				//What is in the players vInventory.
	_unit setVariable ["player_fstorage",_facStorage,true];				//What is in the players factory inventories.
	_unit setVariable ["licenses",_licenses,true];						//Licenses the player holds.
	//Informative
	_unit setVariable ["name",_name,true];
	_unit setVariable ["job",_job,true];
	_unit setVariable ["db_id",_id,true];
	_unit setVariable ["date",_passportdate,true];
	_unit setpos _pos;
	_unit setVariable ["Player_Cash",_cash,true];
	_unit setVariable ["Player_Bank",_bank,true];
	_unit setVariable ["Player_Paycheck",_paycheck,true];
	_unit setVariable ["dob",_dob,true];
	_unit setVariable ["faction",_faction,true];
	_unit setVariable ["adminWatch",_adminWatch,true];
	_unit setVariable ["dbVar_AdminLevel",_AdminLevel,true];
	_unit setVariable ["Cuffed",false,true];

	//Scan if player owns a house, if not we will assign him an appartment
	_ownsHouse = false;
	{
		_houseVar = _x getVariable "owner";
		_roommates = _x getVariable ["roommates", []];
		if ((_houseVar select 0) == _uid || _uid IN _roommates) exitwith
		{
			_ownsHouse = true;
			_houseObj = _x;

			//give the key to the player if he doesn't have it
			_doorID = (_houseObj getVariable "doorid") select 1;
			if (!(_doorID IN _keys)) then
			{
				_keys pushback _doorID;
				_unit setVariable ["keys",_keys,true];
			};
		};
	} foreach Server_HouseList;

	if (!_ownsHouse) then
	{
		[_unit] call Server_Housing_AssignApt;
	} else
	{
		//setpos to house position
		if ([[0,0,0],_pos] call BIS_fnc_areEqual) then
		{
			//for some houses we need to set the player position a bit higher
			switch (typeOf _houseObj) do
			{
				case ("Land_Mansion01"): { _unit setpos [(getpos _houseObj select 0),(getpos _houseObj select 1),1]; };
				case default { _unit setpos (getpos _houseObj); };
			};

		};
		//set house var
		_unit setVariable ["house",_houseObj,true];
		//load items
		[_unit,_houseObj,_uid] call Server_Housing_LoadItems;
	};

	if ((!([[0,0,0],_pos] call BIS_fnc_areEqual)) && (!(_ownsHouse))) then //if our position is not [0,0,0] and we have an apartment
	{
		private ["_near"];
		_near = nearestObjects [_pos, ["Land_A3PL_Motel"], 14];
		if (count _near > 0) then
		{
			//still set the player to the apartment position since he spawned (close) back into an apartment
			[_unit] call Server_Housing_SetPosApt;
		};
	};

	//change 0,0,0 with whatever we set on server start later
	if (([[0,0,0],_pos] call BIS_fnc_areEqual) && (!(_ownsHouse))) then
	{
		[_unit] call Server_Housing_SetPosApt;
	};

	//Jail the player if needed...
	if(_jail > 0) then
	{
		_unit setPos [4795.31,6313.62,0];
		[_jail, _unit] call Server_Police_JailPlayer;
	};

	// Once all done send message to Client to tell him everything is assigned!
	// publicVariableClient is a priority message, cuts down on network traffic
	(owner _unit) publicVariableClient "A3PL_RetrievedInventory";
}, true,true] call Server_Setup_Compile;

["Server_Whitelisting_Check", {
	_unit = _this select 0;
	_uid = getPlayerUID _unit;

	_query = format ["SELECT name FROM whitelist WHERE uid='%1'", _uid];
	_return = [_query, 2] call Server_Database_Async;

	if (count _return == 0) exitwith 
	{
		"IUqof456sd=!&L" serverCommand format ["#kick %1", _uid];
	};
}, true,true] call Server_Setup_Compile;

["Server_Housing_Initialize",
{

	private ["_houses","_query","_return","_uid","_pos","_doorID","_near","_signs"];
	//also make sure to update _obj location if it's changed (just incase we move anything slightly with terrain builder), delete it if it cannot be found nearby
	_houses = ["SELECT uid,location,doorid,roommates FROM houses", 2, true] call Server_Database_Async;
	{
		private ["_pos","_uid","_doorid"];
		_uid = _x select 0;
		_pos = call compile (_x select 1);
		_doorid = _x select 2;
		_roommates = call compile (_x select 3);

		_near = nearestObjects [_pos, ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2"], 10,true];
		if (count _near == 0) exitwith
		{
			//DELETE from database
			//_query = format ["DELETE FROM houses WHERE location ='%1'",_pos];
			//[_query,1] spawn Server_Database_Async;
			[_uid,"House Deleted",["House deleted from table",_pos,_doorid]] call Server_Log_New;

		};
		_near = _near select 0;
		if (!([_pos,(getpos _near)] call BIS_fnc_areEqual)) then
		{
			//Update position in DB
			_query = format ["UPDATE houses SET location='%1' WHERE location ='%2'",(getpos _near),_pos];
			[_query,1] spawn Server_Database_Async;
		};

		//look for nearest for sale sign and set the texture to sold
		_signs = nearestObjects [_pos, ["Land_A3PL_EstateSign"], 25,true];
		if (count _signs > 0) then
		{
			(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
		};

		//Set variables
		_near setVariable ["doorID",[_uid,_doorid],true];
		_near setVariable ["owner",[_uid],true];
		_near setVariable ["roommates", _roommates, true];
		Server_HouseList pushback _near;
	} foreach _houses;
},true,true] call Server_Setup_Compile;

["Server_Housing_LoadItems",
{
	private ["_house","_player","_uid","_pitems"];
	_player = param [0,objNull];
	_house = param [1,objNull];
	_uid = param [2,""];

	//set furn loaded to true
	if (_house getVariable ["furn_loaded",false]) exitwith {};
	_house setVariable ["furn_loaded",true,false];

	_pitems = [format ["SELECT pitems FROM houses WHERE location = '%1'",(getpos _house)], 2] call Server_Database_Async;
	_pitems = call compile (_pitems select 0);

	[_house,_pitems] remoteExec ["A3PL_Housing_Loaditems", (owner _player)];
},true] call Server_Setup_Compile;

["Server_Housing_LoadBox",
{
	private ["_house","_player","_pos","_items","_box","_weapons","_magazines","_items","_vitems","_cargoItems","_actualitems"];
	_player = param [0,objNull];
	_house = param [1,objNull];
	_pos = getposATL _player;
	if (!isNil {_house getVariable "box_spawned"}) exitwith {};
	//set variable that disables the box to be spawned again
	_house setVariable ["box_spawned",true,false];

	if (isDedicated) then { _items = [format ["SELECT items,vitems FROM houses WHERE location = '%1'",(getpos _house)], 2, true] call Server_Database_Async;} else {_items = [[],[],[]];};
	_box = createVehicle ["Box_GEN_Equip_F",_pos, [], 0, "CAN_COLLIDE"]; //replace with custom ammo box later
	clearItemCargoGlobal _box; //temp until custom ammo box
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	//According to how stuff is saved into db
	_cargoItems = call compile ((_items select 0) select 0);
	_vitems = call compile ((_items select 0) select 1);
	_weapons = _cargoItems select 0;
	_magazines = _cargoItems select 1;
	_actualitems = _cargoItems select 2;
	_backpacks = _cargoItems select 3;

	//add items [["srifle_EBR_F"],[],[]]
	{_box addWeaponCargoGlobal [_x,1]} foreach _weapons;
	{_box addMagazineCargoGlobal [_x,1]} foreach _magazines;
	{_box addItemCargoGlobal [_x,1]} foreach _actualitems;
	{_box addBackpackCargoGlobal [_x,1]} foreach _backpacks;
	_box setVariable ["storage",_vitems,true];
},true] call Server_Setup_Compile;


["A3PL_CCTV_SetCamera",
{
	private ["_camNum","_mapCam","_camera"];
	_camNum = param [0,1];
	_mapCam = A3PL_CCTV_ALL select (param [1,0]); //the actual camera object placed on the map
	_camera = call compile format ["A3PL_CCTV_CAMOBJ_%1",_camNum];

	_camera attachto [_mapCam,(_mapCam selectionPosition "cam_pos")];
	_camera CamSetTarget (_mapCam modelToWorld (_mapCam selectionPosition "cam_dir"));
	_camera camCommit 0;
},false,true] call Server_Setup_Compile;

/*
["A3PL_Phone_Open",
{
	// make sure that TFR has our cellphone
	_radio = format["%1",(call TFAR_fnc_activeSwRadio)];
	_array = _radio splitString "_";
	if(!("A3PL" in _array)) exitWith {};

	//create config if doesn't exist
	if (isNil "A3PL_CellP_CreateConfigDone") then {[] call A3PL_CellP_CreateConfig;};

	/*
	if(isNil "batterylevel") then {batterylevel = 100;}; //local variable in namespace
	if (batterylevel == 0) exitwith {
		createdialog "emptyphone";
		_switch1 = "\A3PL_Common\phone\base\empty.paa";
		_switch2 = "\A3PL_Common\phone\base\empty2.paa";
		_switch = 0;
		while {cellphoneopen2 == 1} do {
			switch (_switch) do
			{
				case 0: {((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText _switch1; _switch = 1;};
				case 1: {((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText _switch2; _switch = 0;};
			};
			sleep 0.5;
		};
	};
	//There want a star slash here
	//1 == currently calling someone, 2 == currently being called, 3 == currenlty in an active call
	//Currently calling someone...
	if((player getvariable "A3PL_Call_Status" select 1) == 1) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Active"; //EDIT

		A3PL_Call_Status = 1;

		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
		ctrlSetText [1002, "Starting Call..."];
	};

	//currently being called...
	if((player getvariable "A3PL_Call_Status" select 1) == 2) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Incoming";

		//Create the incoming call dialog
		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
	};

	//Currently an active call...
	if((player getvariable "A3PL_Call_Status" select 1) == 3) exitWith {
		closeDialog 0;
		createDialog "Dialog_Phone_Active";

		ctrlSetText [1001, (player getvariable "A3PL_Call_Status" select 2)];
		ctrlSetText [1002, "Active..."];
	};

	// open cellphone and put down the background, not set: default background.
	createdialog "A3PL_Open_CellPhone";
	((uiNamespace getVariable "cellphone") displayCtrl 5521) ctrlSetText (profilenamespace getVariable ["CellPhone_Background","\A3PL_Common\phone\backgrounds\background01.paa"]);


	// puts down all the pictures, text and functions into the buttons
	{
	_piclocation = (A3PL_CellP_Applocations select _forEachIndex) select 1;
	_buttonlocation = (A3PL_CellP_Applocations select _forEachIndex) select 2;
	_textlocation = (A3PL_CellP_Applocations select _forEachIndex) select 3;
	_apptext2 = parseText format["<t font='EtelkaNarrowMediumPro' color='#FFFFFF' size='0.6' align='center'>%1</t>", (_x select 1)];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) buttonsetAction format ["[] call (compile ((A3PL_CellP_applications select %1) select 5))",_forEachIndex];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseEnter",format ["_var = '%1';((findDisplay 12198) displayCtrl %2) ctrlSetText _var;",(_x select 3),_piclocation]];
	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseExit",format ["_var = '%1';((findDisplay 12198) displayCtrl %2) ctrlSetText _var;",(_x select 2),_piclocation]];

//;


	((uiNamespace getVariable "cellphone") displayCtrl _buttonlocation) ctrlAddEventHandler ["MouseExit", {((findDisplay 12198) displayCtrl 1001) ctrlSetText (_x select 3);}];
	((uiNamespace getVariable "cellphone") displayCtrl _piclocation) ctrlSetText (_x select 2);
	((uiNamespace getVariable "cellphone") displayCtrl _textlocation) ctrlSetStructuredText _apptext2;

	} foreach A3PL_CellP_applications;


}] call Server_Setup_Compile;

*/

["A3PL_Garage_InstallUpgrades",
{
	private ["_vehicle","_variant","_animations", "_bChangeMass"];
	_vehicle 	= param [0, objNull, [objNull]];
	_variant 	= param [1, false, ["STRING", false, 0, []]];
	_animations 	= param [2, false, [[], false, "STRING"]];
	_bChangeMass 	= param [3, false, [false, 0]];

	//if !(local _vehicle) exitWith {false};

	/*---------------------------------------------------------------------------
		Get parameters from the config & the vehicle & prepare the local variables
	---------------------------------------------------------------------------*/
	private ["_vehicleType", "_listToSkip", "_addMass","_isCampaign"];
	_vehicleType = typeOf _vehicle;
	_skipRandomization = ({(_vehicleType isEqualTo _x) || (_vehicleType isKindOf _x) || (format ["%1", _vehicle] isEqualTo _x)} count (getArray(missionConfigfile >> "disableRandomization")) > 0 || !(_vehicle getVariable ["BIS_enableRandomization", true]));

	if (_bChangeMass isEqualType 0) then {
		_addMass = _bChangeMass;
		_bChangeMass = true;
	} else {
		_addMass = 0;
	};

	if (getNumber(missionConfigfile >> "CfgVehicleTemplates" >> "disableMassChange") == 1) then {
		_bChangeMass = false;
	};

	_isCampaign = isClass(campaignConfigFile >> "CfgVehicleTemplates");

	/*---------------------------------------------------------------------------
		Texture source selection & Set the selected texture
	---------------------------------------------------------------------------*/
	if !(_variant isEqualTo false) then {
		private ["_texturesToApply","_textureList","_textureSources","_textureSource","_probabilities","_materialsToApply"];
		_texturesToApply = [];
		_materialsToApply = [];
		_textureList = getArray(configFile >> "CfgVehicles" >> _vehicleType >> "TextureList");

		if (_variant isEqualType []) then {
			_textureList = _variant;
			_variant = "";
		};

		if (_variant isEqualType true) Then {
			if (count _textureList > 0) Then {
				_variant = _textureList select 0;
			} else {
				_variant = "";
			};
		};

		// 1 Support for the old method from Pettka
		if (_variant isEqualType 0) then {
			_variant = if ((_variant >= 0) && ((_variant * 2) <= (count _textureList) -2)) then {_textureList select (_variant * 2)} else {""};
		};

		// 2 Try from the config file (parents only)
		if (_vehicleType in ([(configFile >> "CfgVehicles" >> _variant), true] call BIS_fnc_returnParents)) then {
			private ["_cfgRoot"];
			_textureList = getArray(configFile >> "CfgVehicles" >> _variant >> "TextureList");
			_textureSources = [];
			_probabilities = [];
			for "_i" from 0 to (count _textureList -1) step 2 do {
				_textureSources append [_textureList select _i];
				_probabilities append [_textureList select (_i +1)];
			};
			_cfgRoot = (configFile >> "CfgVehicles" >> _variant >> "textureSources" >> ([_textureSources, _probabilities] call bis_fnc_selectRandomWeighted));
			_texturesToApply = getArray(_cfgRoot >> "textures");
			_materialsToApply = getArray(_cfgRoot >> "materials");
		};

		// 3 Try from the textureSources of the current vehicle
		if (count _texturesToApply == 0 && {isClass (configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant)}) then {
			_texturesToApply = getArray(configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant >> "textures");
			_materialsToApply = getArray(configfile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> _variant >> "materials");
		};

		// 4 Valid class from the campaign config file
		if (_isCampaign && {isClass (campaignConfigFile >> "CfgVehicleTemplates" >> _variant)}) then {
			if (count (getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures")) >= 1) then {
				_texturesToApply = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures");
				_materialsToApply = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "materials");
			} else {
				_texturesToApply = [];
				_materialsToApply = [];
				_textureList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "textureList")
			};
		};

		// 5 If _variant is a valid class from the mission config file, override textureList and empty texturesToApply
		if (isClass (missionConfigFile >> "CfgVehicleTemplates" >> _variant)) then {
			if (count (getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures")) >= 1) then {
				_texturesToApply = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textures");
				_materialsToApply = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "materials");
			} else {
				_texturesToApply = [];
				_materialsToApply = [];
				_textureList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "textureList")
			};
		};

		// 4 Else, randomize using the texture list (from the config of the current vehicle)
		if (!(_skipRandomization) && {count _texturesToApply == 0 && {count _textureList >= 2}}) then {
			private ["_cfgRoot"];
			_textureSources = [];
			_probabilities = [];
			for "_i" from 0 to (count _textureList -1) step 2 do {
				_textureSources append [_textureList select _i];
				_probabilities append [_textureList select (_i +1)];
			};
			_cfgRoot = configFile >> "CfgVehicles" >> _vehicleType >> "textureSources" >> ([_textureSources, _probabilities] call bis_fnc_selectRandomWeighted);
			_texturesToApply = getArray(_cfgRoot >> "textures");
			_materialsToApply = getArray(_cfgRoot >> "materials");
		};

		// change the textures
		{_vehicle setObjectTextureGlobal [_forEachindex, _x];} forEach _texturesToApply;

		// change the materials when it is appropriate
		{if (_x != "") then {_vehicle setObjectMaterialGlobal [_forEachindex, _x];};} forEach _materialsToApply;
	};

	/*---------------------------------------------------------------------------
		Animation sources
	---------------------------------------------------------------------------*/
	if !(_animations isEqualTo false) then {
		private ["_animationList","_resetAnimationSources"];
		_animationList = getArray(configFile >> "CfgVehicles" >> _vehicleType >> "animationList");

		// Find if whether or not the reset of the animation sources should be reset
		_resetAnimationSources = if (_animations isEqualType [] && {count _animations > 0 && {(_animations select 0) isEqualType true}}) then
		{
			[_animations] call bis_fnc_arrayShift
		} else {
			true
		};

		if (_resetAnimationSources) then {


			// reset animations
			{
				if (_x isEqualType "") then {
					_vehicle animatesource [_x, getNumber(configFile >> "CfgVehicles" >> _vehicleType >> "animationSources" >> _x >> "initPhase"), true];
				};
			} forEach _animationList;
		};

		// Exit if _animations is true (nothing else to do)
		if (_animations isEqualTo true) exitWith {};

		if (!(_skipRandomization) && {(_animations isEqualType "" || _variant isEqualType "")}) then {
			// 6 - Variant parameter - If the variant is a string and animation is either, an empty string or array
			if ((_variant isEqualType "") && {isClass (configFile >> "CfgVehicles" >> _variant) && {_animations isEqualTo "" || _animations isEqualTo []}}) then {
				_animationList = getArray(configFile >> "CfgVehicles" >> _variant >> "animationList");
			};

			// 5 - Variant parameter - Campaign
			if (_isCampaign && {(_variant isEqualType "") && {(_animations isEqualTo "" || _animations isEqualTo []) && {isClass (campaignConfigFile >> "CfgVehicleTemplates" >> _variant)}}}) then
			{
				_animationList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _variant >> "animationList");
			};

			// 4 - Variant parameter - Try from the mission config (_variant)
			if ((_variant isEqualType "") && {isClass (missionConfigFile >> "CfgVehicleTemplates" >> _variant) && {_animations isEqualTo "" || _animations isEqualTo []}}) then {
				_animationList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _variant >> "animationList");
			};

			// 3 - animation parameter - Try from the config (_animations)
			if (_animations isEqualType "" && {isArray (configFile >> "CfgVehicles" >> _animations >> "animationList")}) then {
				_animationList = getArray(configFile >> "CfgVehicles" >> _animations >> "animationList");
			};

			// 2 - animation parameter - Campaign
			if (_isCampaign && {_animations isEqualType "" && {isArray (campaignConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList")}}) then {
				_animationList = getArray(campaignConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList");
			};

			// 1 - animation parameter - Try from the mission config (template class name)
			if (_animations isEqualType "" && {isArray (missionConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList")}) then {
				_animationList = getArray(missionConfigFile >> "CfgVehicleTemplates" >> _animations >> "animationList");
			};
		};

		// 4 If (_animations is an array) then, use it
		if (_animations isEqualType [] && {count _animations > 1 && {count _animations mod 2 == 0 && {(_animations select 1) isEqualType 0}}}) then {
			_animationList = _animations;
		};

		// Change animation sources
		_vehicle setvariable ["bis_fnc_initVehicle_animations",_animationList];
		if (count _animationList > 1) then {
			private ["_CfgPath"];
			_CfgPath = (configfile >> "CfgVehicles" >> _vehicleType >> "AnimationSources");

			for "_i" from 0 to (count _animationList -1) step 2 do {
				private ["_source", "_lockCargoAnimationPhase", "_lockCargo", "_chance", "_rand", "_bLockCargo", "_bLockTurret", "_forceAnimatePhase", "_forceAnimate", "_phase", "_lockTurretAnimationPhase", "_lockTurret"];
				_source = _animationList select _i;
				_lockCargoAnimationPhase = getNumber(_CfgPath >> _source >> "lockCargoAnimationPhase");
				_lockCargo = getArray(_CfgPath >> _source >> "lockCargo");
				_forceAnimatePhase = getNumber(_CfgPath >> _source >> "forceAnimatePhase");
				_forceAnimate = getArray(_CfgPath >> _source >> "forceAnimate");
				_chance = _animationList select (_i+1);

				_phase = if ((random 1) <= _chance) then {1} else {0};

				_vehicle animatesource [_source, _phase, true];

				if (_forceAnimatePhase == _phase) then {
					for "_i" from 0 to (count _forceAnimate -1) step 2 do {

						_vehicle animatesource [(_forceAnimate select _i), (_forceAnimate select (_i +1)), true];
					};
				};

				_blockCargo = (_lockCargoAnimationPhase == _phase);
				{_vehicle lockCargo [_x, _blockCargo];} forEach _lockCargo;

				[_vehicle, _phase] call compile (getText(configfile >> "CfgVehicles" >> _vehicleType >> "AnimationSources" >> _source >> "onPhaseChanged"));
			};
		};
	};


	/*---------------------------------------------------------------------------
		Mass change
	---------------------------------------------------------------------------*/
	if (_bChangeMass) then {
		_bChangeMass = [_vehicle, _bChangeMass, _addMass] call bis_fnc_setVehicleMass;
	};

	/*---------------------------------------------------------------------------
		End of function
	---------------------------------------------------------------------------*/

	//true
}] call Server_Setup_Compile;

["A3RL_Server_SaveAll", {
	[] spawn Server_Gear_SaveLoop;
	[] spawn Server_Hydrogen_Save;
	[] spawn Server_EvidenceLocker_Save;
	[] spawn Server_ShopStock_Save;
	[] spawn Server_Locker_Save;
	[] spawn Server_Trunk_Save;
}] call Server_Setup_Compile;