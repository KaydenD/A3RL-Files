Server_Setup_Files = [
	['Functions', 'A3PL_Player'],
	['Functions', 'A3PL_ATM'],
	['Functions', 'A3PL_Lib'],
	['Functions', 'A3PL_Interaction'],
	['Functions', 'A3PL_Config'],
	['Functions', 'A3PL_Inventory'],
	['Functions', 'A3PL_Loading'],
	['Functions', 'A3PL_Gear'],
	['Functions', 'A3PL_Items'],
	['Functions', 'A3PL_Level'],
	['Functions', 'A3PL_VehicleInit'],
	['Functions', 'A3PL_Intersect'],
	['Functions', 'A3PL_Shop'],
	['Functions', 'A3PL_Loop'],
	['Functions', 'A3PL_Dispatch'],
	['Functions', 'A3PL_Placeables'],
	['Functions', 'A3PL_EventHandlers'],
	['Functions', 'A3PL_Police'],
	['Functions', 'A3PL_Hydrogen'],
	['Functions', 'A3PL_Housing'],
	['Functions', 'A3PL_Youtube'],
	['Functions', 'A3PL_Storage'],
	['Functions', 'A3PL_Store_Robbery'],
	['Functions', 'A3PL_NPC'],
	['Functions', 'A3PL_JobMcfisher'],
	['Functions', 'A3PL_JobFisherman'],
	['Functions', 'A3PL_JobRoadWorker'],
	['Functions', 'A3PL_JobFarming'],
	['Functions', 'A3PL_JobOil'],
	['Functions', 'A3PL_JobWildcat'],
	['Functions', 'A3PL_JobMechanic'],
	['Functions', 'A3PL_JobTaxi'],
	['Functions', 'A3PL_Vehicle'],
	['Functions', 'A3PL_HUD'],
	['Functions', 'A3PL_USCG'],
	['Functions', 'A3PL_Medical'],
	['Functions', 'A3PL_Drugseffects'],
	['Functions', 'A3PL_Bowling'],
	['Functions', 'A3PL_Admin'],
	['Functions', 'A3PL_JobVDelivery'],
	['Functions', 'A3PL_JobMDelivery'],
	['Functions', 'A3PL_JobPicking'],
	['Functions', 'A3PL_Phone'],
	['Functions', 'A3PL_Uber'],
	['Functions', 'A3PL_Goose'],
	['Functions', 'A3PL_Dogs'],
	['Functions', 'A3PL_ATC'],
	['Functions', 'A3PL_Government'],
	['Functions', 'A3PL_FD'],
	['Functions', 'A3PL_Fire'],
	['Functions', 'A3PL_Resources'],
	['Functions', 'A3PL_SFP'],
	['Functions', 'A3PL_Twitter'],
	['Functions', 'A3PL_Factory'],
	['Functions', 'A3PL_Business'],
	['Functions', 'A3PL_Garage'],
	['Functions', 'A3PL_Prison'],
	['Functions', 'A3PL_Heist_Bank'],
	['Functions', 'A3PL_IE'],
	['Functions', 'A3PL_DMV'],
	['Functions', 'A3PL_Waste'],
	['Functions', 'A3PL_Delivery'],
	['Functions', 'A3PL_Exterminator'],
	['Functions', 'A3PL_Criminal'],
	//['Functions', 'A3PL_Christmas'],
	//['Functions', 'A3PL_Halloween'], //Halloween event
	['Functions', 'A3PL_Hunting'],
	['Functions', 'A3PL_Moonshine'],
	['Functions', 'A3PL_Lumber'],
	['Functions','A3PL_Combine'],
	['Functions','A3PL_Karts'],
	['Functions','A3PL_ShopStock'],
	['Functions','A3PL_Chopshop'],
	['Functions','A3PL_Markers'],
	['Functions', 'A3PL_Locker'],
	['Functions', 'A3PL_iPhoneX'],
	['Backend', 'Server_Setup'],
	['Server', 'Server_JobVDelivery'],
	['Server', 'Server_JobMDelivery'],
	['Server', 'Server_Shop'],
	['Server', 'Server_Police'],
	['Server', 'Server_Vehicle'],
	['Server', 'Server_Database'],
	['Server', 'Server_Core'],
	['Server', 'Server_Player'],
	['Server', 'Server_Inventory'],
	['Server', 'Server_Gear'],
	['Server', 'Server_Housing'],
	['Server', 'Server_Locker'],
	['Server', 'Server_Hydrogen'],
	['Server', 'Server_Storage'],
	['Server', 'Server_NPC'],
	['Server', 'Server_JobMcfisher'],
	['Server', 'Server_JobFisherman'],
	['Server', 'Server_JobFarming'],
	['Server', 'Server_JobOil'],
	['Server', 'Server_JobWildcat'],
	['Server', 'Server_JobRoadworker'],
	['Server', 'Server_JobPicking'],
	['Server', 'Server_Bowling'],
	['Server', 'Server_Log'],
	['Server', 'Server_Youtube'],
	['Server', 'Server_Uber'],
	['Server', 'Server_Dogs'],
	['Server', 'Server_Government'],
	['Server', 'Server_Fire'],
	['Server', 'Server_Fuel'],
	['Server', 'Server_Twitter'],
	['Server', 'Server_Resources'],
	['Server', 'Server_Factory'],
	['Server', 'Server_Business'],
	['Server', 'Server_Garage'],
	['Server', 'Server_IE'],
	['Server', 'Server_DMV'],
	['Server', 'Server_Shopstock'],
	['Server', 'Server_Hunting'],
	['Server', 'Server_Lumber'],
	['Server', 'Server_Criminal'],
	['Server', 'Server_Chopshop'],
	['Server', 'Server_iPhoneX'],
	['Server', 'Server_SpeedCam'],
	['Configs', 'Config_Setup'],
	['Configs', 'Config_Gear'],
	['Configs', 'Config_Shops'],
	['Configs', 'Config_Level'],
	['Configs', 'Config_Jobs'],
	['Configs', 'Config_Items'],
	['Configs', 'Config_Intersect'],
	['Configs', 'Config_Dispatch'],
	['Configs', 'Config_NPC'],
	['Configs', 'Config_Medical'],
	['Configs', 'Config_Interactions'],
	['Configs', 'Config_Resources'],
	['Configs', 'Config_Factories'],
	['Configs', 'Config_Business'],
	['Configs', 'Config_Garage'],
	['Configs', 'Config_Government'],
	['Configs', 'Config_Licenses'],
	['Configs', 'Config_CombineItems']
];

Server_Setup_Compile = {
	private ["_name", "_code", "_forServer", "_compile", "_compileBlock"];

	_name = param [0,""];
	_code = param [1,{}];
	_forServer = param [2,false];
	_compileBlock = param [3,false];
	_compile = formatText ["%1 = %2;", _name, _code];

	if (isServer) then
	{
		call compile str(_compile);
	} else
	{
		call compile str _compile;
	};

	if (_compileBlock) exitwith {}; //no need to go further, this is for singleplayer purpose

	if(_forServer isEqualTo false) then {
		publicVariable _name;
	} else
	{
		publicVariableServer _name;
		if (!isServer) then
		{
			missionNameSpace setVariable [_name,nil]; //we dont need to keep this on the client
		};
	};
};

Server_Setup_SetupFiles =
{
	private ["_folder", "_name","_maindir"];

	_maindir = param [0,"A3PL.Backend"];

	{
		_folder = _x select 0;
		_name = _x select 1;

		//call compile loadFile format ["\%3\%1\%2.sqf", _folder, _name,_maindir ];
		call compile preprocessFile format ["\%3\%1\%2.sqf", _folder, _name,_maindir ];

	} forEach Server_Setup_Files;

	A3PL_FilesSetup = true;
};

private ["_folder"];
_folder = param [0,""];
[_folder] call Server_Setup_SetupFiles;
A3PL_FilesSetup = true;
publicVariableServer "A3PL_FilesSetup";
if (!isServer) then
{
	Server_Setup_Files = nil;
	Server_Setup_SetupFiles = nil;
	A3PL_FilesSetup = nil;
};
//USE THIS TO START SENDING SCRIPTS:
//hint "SENDING SCRIPTS TO SERVER!";
//private ["_folder"]; _folder = "A3PL.Backend"; [_folder] call (compile preprocessFileLineNumbers format ["\%1\init.sqf",_folder]);
