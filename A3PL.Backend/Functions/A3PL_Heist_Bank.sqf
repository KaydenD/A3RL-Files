#define MINCOPSREQUIRED 5
#define MONEYCHANCE 50
#define GEMCHANCE 30
#define MONEYPERPILE 180000
#define MAXMONEYPERBAG 540000
#define BANKTIMER 600

["A3PL_CCTV_Open", //spawn this function
{
	private ["_veh"];
	_distance = param [0,10000];

	disableSerialization;
	private ["_display"];

	createDialog "Dialog_CCTV";
	_display = findDisplay 27;

	//Check pip
	if (!isPipEnabled) then {["System: CCTV does not work if PiP is disabled, change PiP to Ultra in video options to fix it"] call A3PL_Player_Notification;};

	//Get all the cameras we can select
	A3PL_CCTV_ALL = nearestObjects [player, ["A3PL_CCTV"], _distance];
	{
		private ["_control"];
		_control = _display displayCtrl _x;
		{
			private ["_index"];
			_index = _control lbAdd format ["CCTV Camera %1",_forEachIndex+1];
			_control lbSetData [_index,format ["%1",_x]];
		} foreach A3PL_CCTV_ALL;
		_control lbSetCurSel _forEachIndex;
		switch (_x) do
		{
			case (2100): {_control ctrlAddEventHandler ["LBSelChanged",{[1,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2101): {_control ctrlAddEventHandler ["LBSelChanged",{[2,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2102): {_control ctrlAddEventHandler ["LBSelChanged",{[3,param [1,0]] call A3PL_CCTV_SetCamera}];};
			case (2103): {_control ctrlAddEventHandler ["LBSelChanged",{[4,param [1,0]] call A3PL_CCTV_SetCamera}];};
		};
	} foreach [2100,2101,2102,2103]; //idd of combo boxes

	//add eventhandler to check buttons
	_control = _display displayCtrl 2500; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[4,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2501; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[1,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];
	_control = _display displayCtrl 2502; _control ctrlAddEventHandler ["CheckBoxesSelChanged",{[2,param [0,ctrlNull],param [2,0]] call A3PL_CCTV_SetVision;}];

	//create cameras
	A3PL_CCTV_CAMOBJ_1 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_2 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_3 = "camera" camCreate (getpos player);
	A3PL_CCTV_CAMOBJ_4 = "camera" camCreate (getpos player);
	[1,0] call A3PL_CCTV_SetCamera;
	[2,1] call A3PL_CCTV_SetCamera;
	[3,2] call A3PL_CCTV_SetCamera;
	[4,3] call A3PL_CCTV_SetCamera;

	//set render surface references
	{
		private ["_rsRef"]; //render surface reference
		_rsRef = format ["A3PL_CCTV_%1_RT",_forEachIndex+1];
		_x cameraEffect ["INTERNAL", "BACK", _rsRef];
		_rsRef setPiPEffect [4];
		_x camCommit 0;
	} foreach [A3PL_CCTV_CAMOBJ_1,A3PL_CCTV_CAMOBJ_2,A3PL_CCTV_CAMOBJ_3,A3PL_CCTV_CAMOBJ_4];

	//delete vars and cameras once dialog is closed
	waitUntil {sleep 0.1; isNull _display};
	{
		_x cameraEffect ['TERMINATE', 'BACK'];
		camDestroy _x;
	} foreach [A3PL_CCTV_CAMOBJ_1,A3PL_CCTV_CAMOBJ_2,A3PL_CCTV_CAMOBJ_3,A3PL_CCTV_CAMOBJ_4];
	A3PL_CCTV_ALL = nil;
}] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTION
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

["A3PL_CCTV_SetVision",
{
	disableSerialization;
	private ["_rsRef","_display","_mode","_control","_checked"];
	_mode = param [0,4];
	_control = param [1,ctrlNull];
	_checked = param [2,0];

	if (_checked == 0) exitwith {};

	{
		_rsRef = format ["A3PL_CCTV_%1_RT",_x];
		_rsRef setPiPEffect [_mode];
	} foreach [1,2,3,4];

	//set uncheked on other buttons
	_display = findDisplay 27;
	{
		_ctrl = _display displayCtrl _x;
		if (_ctrl != _control) then {_ctrl ctrlSetChecked false;};
	} foreach [2500,2501,2502];
}] call Server_Setup_Compile;

["A3PL_BHeist_SetDrill",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_bank","_drill","_timer"];
	_bank = param [0,objNull];
	if (typeOf _bank != "Land_A3PL_Bank") exitwith {["System: You are not looking at the bank vault",Color_Red] call A3PL_Player_Notification;};
	//bank timer
	_timer = false;
	if (!isNil {_bank getVariable ["timer",nil]}) then
	{
		if (((serverTime - (_bank getVariable ["timer",0]))) < BANKTIMER) then {_timer = true};
	};
	if (_timer) exitwith {[format ["System: The bank has recently been robbed, try again in %1 seconds",BANKTIMER - ((_bank getVariable ["timer",0]) - serverTime)],Color_Red] call A3PL_Player_Notification;};
	//other checks
	if (_bank animationSourcePhase "door_bankvault" > 0) exitwith {["System: The bank vault is already open",Color_Red] call A3PL_Player_Notification;};
	if (backpack player != "A3PL_Backpack_Drill") exitwith {["System: You are not carrying a drill in your backpack",Color_Red] call A3PL_Player_Notification;};
	//place drill
	_drill = "A3PL_Drill_Bank" createvehicle (getpos player);
	_drill setdir (getdir _bank)-90;
	_drill setpos (_bank modelToWorld [-5.05,4.38,-2.1]);
	//set used
	removeBackpack player;
}] call Server_Setup_Compile;

["A3PL_BHeist_PickupDrill",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_drill"];
	_drill = param [0,objNull];
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["System: You are not looking at the drill",Color_Red] call A3PL_Player_Notification;};
	if (backpack player != "") exitwith {["System: You are wearing a backpack already, you need to drop what you have on your back first!",Color_Red] call A3PL_Player_Notification;};
	deleteVehicle _drill;
	player addBackpack "A3PL_Backpack_Drill";
}] call Server_Setup_Compile;

["A3PL_BHeist_InstallBit",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_drill"];
	_drill = param [0,objNull];
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["System: You are not looking at the drill",Color_Red] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 0.5) then
	{
		if (Player_ItemClass != "drill_bit") exitwith {["System: You are not carrying a drill bit in your hand",Color_Red] call A3PL_Player_Notification;};
		[] call A3PL_Inventory_Clear;
		["drill_bit", -1] call A3PL_Inventory_Add;
		_drill animate ["drill_bit",1];
	} else
	{
		["System: You disconnected the drill bit, it has been placed in your inventory",Color_Green] call A3PL_Player_Notification;
		["drill_bit", 1] call A3PL_Inventory_Add;
		_drill animate ["drill_bit",0];
	};
}] call Server_Setup_Compile;

["A3PL_BHeist_StartDrill",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_drill","_bank","_timeOut","_newDrillValue","_drillValue","_holder","_cops"];
	_drill = param [0,objNull];
	if ((count(["police"] call A3PL_Lib_FactionPlayers)) < MINCOPSREQUIRED) exitwith {[format ["System: There needs to be a minimum of %1 cops online to rob the bank!",MINCOPSREQUIRED],Color_Red] call A3PL_Player_Notification;};
	if (typeOf _drill != "A3PL_Drill_Bank") exitwith {["System: You are not looking at the drill",Color_Red] call A3PL_Player_Notification;};
	if (_drill animationPhase "drill_bit" < 1) exitwith {["System: Drill bit has not been installed",Color_Red] call A3PL_Player_Notification;};
	if (_drill animationSourcePhase "drill_handle" > 0) exitwith {["System: Drill has already been started",Color_Red] call A3PL_Player_Notification;};

	//bank object
	_bank = (nearestObjects [player, ["Land_A3PL_Bank"], 15]) select 0;
	[getPlayerUID player,"bankRobbery",[getPos _bank], player getVariable "name"] remoteExec ["Server_Log_New",2];
	{
		if((_x getVariable ["job",""]) in ["police"]) then {
			_target = _x;
			["!!! ALERT !!! A bank is being robbed somewhere!", Color_Green] remoteExec ["A3PL_Player_Notification",_target];
			["!!! ALERT !!! A bank is being robbed somewhere!", Color_Green] remoteExec ["A3PL_Player_Notification",_target];
			["!!! ALERT !!! A bank is being robbed somewhere!", Color_Green] remoteExec ["A3PL_Player_Notification",_target];
		};
	} forEach allPlayers;
	
	//bank alarm
	playSound3D ["A3PL_Common\effects\bankalarm.ogg", _bank, true, _bank, 3, 1, 250];

	//start drill
	_drill animateSource ["drill_handle",1];
	playSound3D ["A3PL_Common\effects\bankdrill.ogg", _drill, true, _drill, 3, 1, 100];
	_timeOut = (getNumber (configFile >> "CfgVehicles" >> "A3PL_Drill_Bank" >> "animationSources" >> "drill_handle" >> "animPeriod"));
	_drillValue = 0;
	["System: Vault drilling started",Color_Green] call A3PL_Player_Notification;
	while {uiSleep 1; ((_drill animationSourcePhase "drill_handle") < 1)} do
	{
		_newDrillValue = _drill animationSourcePhase "drill_handle";
		[format ["System: Vault drilling progress %2%1","%",round (((_newDrillValue*_timeOut)/_timeOut)*100)],Color_Green] call A3PL_Player_Notification;
		if (_newDrillValue <= _drillValue) exitwith {};
		if (isNull _drill) exitwith {};
		_drillValue = _newDrillValue;
	};
	if (((_drill animationSourcePhase "drill_handle") < 1) OR (isNull _drill)) exitwith {["System: Drilling cancelled",code_red] call A3PL_Player_Notification;}; //for some reason drilling failed

	//animate bank door open
	_bank animateSource ["door_bankvault",1];

	//bank timer
	_bank setVariable ["timer",serverTime];

	//put drill back in bag
	uiSleep 1;
	deleteVehicle _drill;
	/* _holder = createVehicle ["groundWeaponHolder", [2590.8,5565.23,0.1], [], 0, "can_collide"];
	_holder addBackPackCargoGlobal ["A3PL_Backpack_Drill",1]; */
	["System: Drilling completed. The drill and the drill bit both unfortunatly broke during drilling.",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//spawn function
["A3PL_BHeist_OpenDeposit",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_bank","_depositNr","_name","_cashOffset","_random","_itemClass","_cash","_class","_dist"];
	_bank = param [0,objNull];
	_name = param [1,""];
	_depositNr = parseNumber ((_name splitString "_") select 1);
	_dist = player distance2D _bank;
	if ((_bank animationSourcePhase "door_bankvault") < 0.95) exitwith {["System: The bank vault is closed, are you trying to open the deposit box through the walls...?"] call A3PL_Player_Notification;};
	if (Player_ActionDoing) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	["Lockpicking deposit box...",7] spawn A3PL_Lib_LoadAction;
	Player_ActionCompleted = false;
	//waitUntil {sleep 0.1; Player_ActionCompleted};
	
	_success = true;
	while {sleep 0.5; !Player_ActionCompleted } do
	{
		if (abs(_dist - (player distance2D _bank)) > 0.5) exitWith {["System: Action cancelled! - You are too far away from the deposit box!", Color_Red] call A3PL_Player_Notification; _success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;}; //inside a vehicle
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;}; //is incapacitated
		if (!alive player) exitwith {_success = false;}; //is no longer alive	
	};
	
	Player_ActionCompleted = false;	
	if (!_success) exitWith {Player_ActionDoing = false;};
	
	if (_bank animationPhase _name <= 0.01) then
	{
		//chance to get money
		_random = random 100;
		if (_random < MONEYCHANCE) then
		{
			if (_random < GEMCHANCE) then
			{
				switch (true) do
				{
					case (_random < 1): {_class = "diamond_ill";};
					case (_random < 4): {_class = "diamond_emerald_ill";};
					case (_random < 9): {_class = "diamond_ruby_ill";};
					case (_random < 19): {_class = "diamond_sapphire_ill";};
					case (_random < 30): {_class = "diamond_alex_ill";};
					case (_random < 50): {_class = "diamond_aqua_ill";};
					case (_random <= 100): {_class = "diamond_tourmaline_ill";};
				};
				_cash = createVehicle [(([_class,"class"]) call A3PL_Config_GetItem), position player, [], 0, "CAN_COLLIDE"];
				_cash enableSimulation false;
				_cash setVariable ["class",_class,true];
			} else
			{
				_cash = createVehicle ["A3PL_PileCash", position player, [], 0, "CAN_COLLIDE"];
			};
			_cashOffset = [[-0.6,5.17,-1.4],[-0.6,5.17,-1.73],[-0.6,5.17,-2.05],[-0.6,5.17,-2.4],[-0.6,5.17,-2.7],[-0.6,4.7,-1.4],[-0.6,4.7,-1.73],[-0.6,4.7,-2.05],[-0.6,4.7,-2.4],[-0.6,4.7,-2.7],[-0.6,4.2,-1.4],[-0.6,4.2,-1.73],[-0.6,4.2,-2.05],[-0.6,4.2,-2.4],[-0.6,4.2,-2.7],[-0.6,3.72,-1.4],[-0.6,3.72,-1.73],[-0.6,3.72,-2.05],[-0.6,3.72,-2.4],[-0.6,3.72,-2.7]] select (_depositNr-1);
			_cash setpos (_bank modelToWorld _cashOffset);
		};
		_bank animate [_name,1];
	} else
	{
		["System: This deposit box has already been opened",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_BHeist_CloseVault",
{
	private ["_bank"];
	_bank = param [0,objNull];
	if ((player getVariable ["job","unemployed"]) != "police") exitwith {["System: Only an on-duty sheriff can secure the vault door",Color_Red] call A3PL_Player_Notification;};
	if ((_bank animationSourcePhase "door_bankvault") < 0.95) exitwith {["System: The bank vault is already closed, you can't secure it"] call A3PL_Player_Notification;};
	_bank animateSource ["door_bankvault",0];
	for "_i" from 0 to 20 do
	{
		_bank animate [format ["deposit_%1",_i],0];
	};
	{
		deleteVehicle _x;
	} foreach (nearestObjects [_bank, ["A3PL_PileCash"], 20]);
}] call Server_Setup_Compile;

//spawn
["A3PL_BHeist_PickCash",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_cashPile","_container"];
	_cashPile = param [0,objNull];
	if (backpack player != "A3PL_Backpack_Money") exitwith {["System: You are not carrying a backpack to carry money in!",Color_Red] call A3PL_Player_Notification;};
	_container = backpackContainer player;
	if (((_container getVariable ["bankCash",0]) + MONEYPERPILE) >= MAXMONEYPERBAG) exitwith {["System: My bag is full of cash, I can't fit more money into the bag!",Color_Red] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	["Filling bag with money...",2] spawn A3PL_Lib_LoadAction;
	waitUntil {sleep 0.1; Player_ActionCompleted};
	Player_ActionCompleted = false;

	if (backpack player != "A3PL_Backpack_Money") exitwith {["System: You are not carrying a backpack to carry money in!",Color_Red] call A3PL_Player_Notification;};
	_container = backpackContainer player;
	if (((_container getVariable ["bankCash",0]) + MONEYPERPILE) > MAXMONEYPERBAG) exitwith {["System: My bag is full of cash, I can't fit more money into the bag!",Color_Red] call A3PL_Player_Notification;};
	if (isNull _cashPile) exitwith {};

	deleteVehicle _cashPile;
	_container setVariable ["bankCash",(_container getVariable ["bankCash",0]) + MONEYPERPILE,true];
}] call Server_Setup_Compile;

//Convert stolen money into real cash
["A3PL_BHeist_ConvertCash",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_container"];
	if (backpack player != "A3PL_Backpack_Money") exitwith {["System: You are not carrying a backpack to carry money in!",Color_Red] call A3PL_Player_Notification;};
	_container = backpackContainer player;
	_cash = _container getVariable ["bankCash",0];
	if (_cash < 1) exitwith {["System: There is no dirty money in this backpack to convert to real cash",Color_Red] call A3PL_Player_Notification;};
	player setVariable ["player_cash",(player getVariable ["player_cash",0])+_cash,true];
	_container setVariable ["bankCash",nil,true];
	[format ["System: You converted $%1 dirty money into laundered money, the cash is now in your inventory",_cash],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//check how much cash is in the backpack im carrying
["A3PL_BHeist_CheckCash",
{
	 private ["_container"];
	 if (backpack player != "A3PL_Backpack_Money") exitwith {};
	 _container = backpackContainer player;
	 [format ["System: There is $%1 of dirty money inside this backpack",(_container getVariable ["bankCash",0])],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;