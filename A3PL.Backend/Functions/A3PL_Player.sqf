//variables that can be changed from client
['A3PL_Player_VariablesSetup',
{
	private ["_uid","_num"];
	Player_Paycheck = 0;
	Player_PaycheckTime = profileNamespace getVariable ["player_payCheckTime",0];
	if (!(typeName Player_PayCheckTime == "SCALAR")) then {Player_payCheckTime = 0; Player_payCheckTime = profileNamespace setVariable ["player_payCheckTime",0]; };
	Player_PaycheckXP = 0;
	Player_PlayTime = 0; //in seconds
	Player_Job = 'unemployed';
	Player_MaxWeight = 500; //copy of this is on the server too, beware!
	Player_Weight = 0;
	Player_Hunger = profileNamespace getVariable ["player_hunger",100];
	if (!(typeName Player_Hunger == "SCALAR")) then { Player_Hunger = 100; Player_Hunger = profileNamespace setVariable ["player_hunger",100]; };
	Player_Thirst = profileNamespace getVariable ["player_thirst",100];
	if (!(typeName Player_Thirst == "SCALAR")) then { Player_Thirst = 100; Player_Thirst = profileNamespace setVariable ["player_thirst",100]; };
	Player_illegalItems = ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle","drill_bit","diamond_ill","diamond_emerald_ill","diamond_ruby_ill","diamond_sapphire_ill","diamond_alex_ill","diamond_aqua_ill","diamond_tourmaline_ill","v_lockpick","zipties"];
	Player_DogIllegalItems = ["seed_marijuana","marijuana","cocaine","shrooms","cannabis_bud","cannabis_bud_cured","cannabis_grinded_5g","weed_5g","weed_10g","weed_15g","weed_20g","weed_25g","weed_30g","weed_35g","weed_40g","weed_45g","weed_50g","weed_55g","weed_60g","weed_65g","weed_70g","weed_75g","weed_80g","weed_85g","weed_90g","weed_95g","weed_100g","jug_moonshine","turtle"];
	Player_ActionCompleted = true;
	Player_ActionDoing = false;
	Player_Item = objNull;
	Player_ItemClass = '';
	Player_Notifications = [];
	A3PL_FishingBuoy_Local = [];
	Player_AntiSpam = false;
	Player_AntiListboxSpam = false;

	//halloween vars
	/* A3PL_Halloween_AngelModeEnabled = false;
	A3PL_Owns_Guardianscript = false; */

	//Start defining twitter
	A3PL_TwitterChatLog = [];
	A3PL_TwitterMsg_Array = [];
	A3PL_TwitterMsg_Counter = 0;
	pVar_AdminTwitter = false;
	//End defining twitter

	//View Lock
	Player_LockView = false;
	Player_LockView_Time = 0;

	Color_Yellow = '#E1BB00';
	Color_White = '#ffffff';
	Color_Red = '#FD1703';
	Color_Green = '#17ED00';
	Color_Blue = '#001cf0';
	Color_Orange = '#ff9d00';

	A3PL_Uber_JobActive = false;
	A3PL_Uber_ActiveRequest = objNull;

	//iPhoneX
	A3PL_phoneOn = false;
	A3PL_phoneCallOn = false;
	A3PL_phoneInCall = false;
	A3PL_contacts =  [];
	A3PL_SMS = [];
	iPhoneX_CheckPhoneNumberIsUsed = [];
	iPhoneX_CheckPhoneNumberSubscription = [];

	//Set iPhoneX
	[player] remoteExec ["Server_iPhoneX_GetPhoneNumber",2];
	[player] remoteExec ["Server_iPhoneX_GetContacts",2];
	[player] remoteExec ["Server_iPhoneX_GetSettings",2];
	[player] remoteExec ["Server_iPhoneX_GetConversations",2];

	player setvariable ["A3PL_Call_Status",[player,0,""],true];
	//Twitterprofile = [current icon, current name color, current text color,[[icon location,icon name]],[[name color hex,name]],[[text color hex,name]]
	if (isServer) then {player setvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202","Citizen"]],[["#B5B5B5","Default"]]],true]}; //only works in editor for testing purposes

	//road workers
	A3PL_Jobroadworker_MarkerList = [];

	//impound retrieval objects
	A3PL_Jobroadworker_Impounds = [Shop_ImpoundRetrieve,Shop_ImpoundRetrieve_1,Shop_ImpoundRetrieve_2,Shop_ImpoundRetrieve_3];
	A3PL_Chopshop_Retrivals = [Shop_Chopshop_Retrieve_1];
	A3PL_Jobroadworker_MarkBypass = //vehicles that will go straight to impound lot
	[
	"K_F450_normal","A3PL_BoatTrailer_Normal","A3PL_VNL_Black","A3PL_VNL_Blue","A3PL_VNL_White","A3PL_VNL_Red","A3PL_VNL_Purple","A3PL_Lowloader_Default","A3PL_DrillTrailer_Default",
	"A3PL_Pierce_Ladder","A3PL_Tanker_Normal","A3PL_Boxtrailer_Normal",
	"A3PL_Atego_Yellow","A3PL_Atego_Yellow","A3PL_Atego_Orange","A3PL_Atego_Green","A3PL_Atego_Red","A3PL_Atego_Black",
	"K_Scooter_Black","K_Scooter_DarkBlue","K_Scooter_Green","K_Scooter_Grey","K_Scooter_LightBlue","K_Scooter_Orange","K_Scooter_Pink","K_Scooter_Red","K_Scooter_White","K_Scooter_Stickers"
	];

	/* Build Our Road DB */

	preRoadDB = [
		[[2670.18,5430.98,0],[2698.19,5348.81,0],"Air Road"],
		[[2714.99,5393.35,0],[2777.74,5206.04,0],"Aviation Road"],
		[[2714.99,5393.35,0],[2777.74,5206.04,0],"FAA Road"],
		[[2583.63,5701.83,0],[3524.07,7534.87,0],"Stoney Highway"],
		[[2712.91,5484.81,0],[2539.25,5623.4,0],"Lubbock Main St."],
		[[2657.59,5532.85,0],[2643.33,5532.16,0],"Taco Hell"],
		[[2538.33,5651.11,0],[2431.39,5725.07,0],"Fishers Street"],
		[[2757.58,5555.65,0],[2491.48,5400.05,0],"Fire Street"],
		[[2437.57,5508.42,0],[2328.61,5581.16,0],"Gas Street"],
		[[2440.55,5439.34,0],[2354.82,5494.87,0],"Impound Street"],
		[[2380.23,5538.68,0],[2289.21,5408.94,0],"High Tree Street"],
		[[2316.94,5460.44,0],[2267.44,5496.11,0],"White Street"],
		[[2443.98,5345.12,0],[2041.17,4968.53,0],"Coast Guard Road"],
		[[2126.13,5118.36,0],[2863.63,5475.24,0],"Beach Air Road"],
		[[2764.01,5541.48,0],[3550.25,5688.5,0],"Double Tree Road"],
		[[2887.25,5603.51,0],[3393.67,5968.89,0],"Constr. Road"],
		[[2899.34,5697.17,0],[3018.86,5741.67,0],"Mine Road"],
		[[2997.3,5841.31,0],[2946.15,5942.68,0],"Unknown Factory"],
		[[3304.49,5798.15,0],[3160.35,5897.81,0],"Clinic Road"],
		[[3333.85,5856.51,0],[3277.29,5867.69,0],"Clinic"],
		[[3357.03,5981.64,0],[3401.59,6137.5,0],"Two House Road"],
		[[3501.79,6095.79,0],[3557.42,6054.48,0],"Bilt Road"],
		[[3609.34,6200.27,0],[3531.22,6307.48,0],"Beach Rock Road"],
	//	[[3851.79,6661.52,0],[3406.23,6661.55,-2],"Motel Road"],
		[[3628.95,7516.29,0],[3610.25,7510.44,0],"Taco Hell"],
		[[3507.24,7452.05,0],[3524.82,7607.57,0],"East Stoney Road"],
		[[3527.63,7561.69,0],[3592.75,7556.69,0],"Import Road"],
		[[3500.99,7455.58,0],[3418.89,7465.16,0],"1st Street"],
		[[3504.83,7494.03,0],[3421.94,7503.4,0],"2nd Street"],
		[[3515.43,7604.74,0],[3433.25,7614,0],"3rd Street"],
		[[3411.11,7464.13,0],[3427.85,7617.29,0],"Stoney Main Road"],
		[[3403.39,7465.24,0],[3335.51,7474.81,0],"Stoney Motel"],
		[[3832.33,7083.95,0],[4152.19,6395.23,0],"Beach Valley Road"],
		[[4074.94,6389.59,0],[4153.15,6193.42,0],"West Valley Road"],
		[[4153.73,6196.44,0],[4153.6,6396.53,0],"East Valley Road"],
		//[[4150.5,6303.51,0],[4079.69,6304.43,0],"Center Valley Road"]
		[[4153.52,6189.73,0],[4141.38,5949.51,0],"Beach Valley Hwy"],
		[[3834.25,6376.47,0],[11732,9261.72,0],"MSR"]

	];

	roadDB = [];

	{
		_a = _x select 0;
		_b = _x select 1;
		_name = _x select 2;

		_roadObject = str (roadAt _a);
		_aID = parseNumber (( _roadObject splitString ":" ) select 0);
		_roadObject = str (roadAt _b);
		_bID = parseNumber (( _roadObject splitString ":" ) select 0);

		roadDB pushBack [_aID,_bID,_name];
	} forEach preRoadDB;

	//Check A3PL_Intersect for more info
	//A3PL_ObjIntersect replaces cursortarget and is more reliable (is Nil when there is no intersection or object distance > 20m)
	//A3PL_NameIntersect returns the memory interaction point if
	//1. 2D distance (player-interaction point/memory point) < 3m
	//2. Object distance < 20m
	//Otherwise value returns ""
	Player_NameIntersect = "";
	Player_ObjIntersect = player;
	Player_selectedIntersect = 0;

	A3PL_Respawn_Time = 60 * 10;
	//a copy of this variable also exist on the server
	A3PL_HitchingVehicles = ["A3PL_Car_Base","A3PL_Truck_Base"];

	_uid = getPlayerUID player;
	_num = _uid select [(count _uid)-7,count _uid];
	player setVariable ["phone_number",_num,true];

	[] spawn {
		uiSleep 20;
		Player_Paycheck = 0;

		//increase long range freq range, just to be sure this is set afterwards
		TF_MAX_ASIP_FREQ = 130;
	};

	//change to imperial system
	setSystemOfUnits 2;

	//increase long range freq range
	TF_MAX_ASIP_FREQ = 130;
}] call Server_Setup_Compile;

["A3PL_Player_AntiSpam",
{
	if(Player_AntiSpam) exitWith {
		[localize "STR_PLAYER_ANTISPAM", Color_Red] call A3PL_Player_Notification; //System: Anti-spam, slow down!
		false
	};

	Player_AntiSpam = true;

	[] spawn {
		uiSleep 1.25;
		Player_AntiSpam = false;
	};

	true
}] call Server_Setup_Compile;

["A3PL_Player_AntiListboxSpam",
{
	if(Player_AntiListboxSpam) exitWith {
		false
	};

	Player_AntiListboxSpam = true;

	[] spawn {
		uiSleep 0.01;
		Player_AntiListboxSpam = false;
	};

	true
}] call Server_Setup_Compile;


//creates an array which drawText will use to draw player tags on the screen, we dont want to run complicated scripts onEachFrame
["A3PL_Player_NameTags",
{
	private ["_players","_pos","_name","_tags"];
	_players = nearestObjects [player, ["C_man_1"], 10];
	_players = _players - [player];

	_tags = [];
	{
		if (simulationEnabled _x) then
		{
			_uid = getPlayerUID _x;
			_saved = profileNamespace getVariable ["A3PL_NameTags",[]];
			_savedName = "";

			{
				_sUID = _x select 0;
				_sName = _x select 1;

				if(_sUID == _uid) exitWith {
					_savedName = _sName;
				}
			} forEach _saved;


			//Check if the player has a mask with this - we have no masks, so can't check atm
			_hasMaskCheck = false;
			if (goggles _x IN ["A3PL_Anon_mask","G_Balaclava_blk","G_Balaclava_combat","G_Balaclava_TI_G_tna_F","G_Balaclava_lowprofile","G_Balaclava_oli","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_blk_F","G_Balaclava_TI_blk_F"]) then {_hasMaskCheck = true;};


			_cansee = (([objNull, "VIEW"] checkVisibility [eyePos player, eyePos _x]) > 0) && (!isObjectHidden _x);
			if (_cansee) then
			{
				_id = _x getVariable ["db_id",-1];

				if(_savedName != "" && !_hasMaskCheck) then {
					_name = format["%1 - %2",_id,_savedName];
				} else {
					_name = format["%1 - Unknown",_id];
				};

				_tags pushback [_x,_name];
			};
		};
	} foreach _players;
	A3PL_Player_TagsArray = _tags;
}] call Server_Setup_Compile;

//gets nearest businesses, and business items
["A3PL_Player_BusinessTags",
{
	private ["_bus","_tags","_iTags","_items"];
	_bus = nearestObjects [player, ["Land_A3PL_Showroom","Land_A3PL_Cinema","Land_A3PL_Gas_Station","Land_A3PL_Garage","land_smallshop_ded_smallshop_01_f","land_smallshop_ded_smallshop_02_f"], 50];
	_items = nearestObjects [player, [], 10];
	_tags = [];
	_iTags = [];
	{
		_bName = _x getVariable ["bName",""];
		if (_bName != "") then
		{
			private ["_pos"];
			switch (typeOf _x) do
			{
				case ("Land_A3PL_Showroom"): {_pos = _x modelToWorld [10,0,0];};
				case ("land_smallshop_ded_smallshop_02_f"): {_pos = _x modelToWorld [8,0,0];};
				case ("land_smallshop_ded_smallshop_01_f"): {_pos = _x modelToWorld [8,0,0];};
				case ("Land_A3PL_Garage"): {_pos = _x modelToWorld [6,2,-1];};
				case ("Land_A3PL_Cinema"): {_pos = _x modelToWorld [0,9,-1];};
				case ("Land_A3PL_Gas_Station"): {_pos = _x modelToWorld [-3.5,-0.65,-1];};
			};
			_tags pushback [_pos,_bName];
		};
	} foreach _bus;

	{
		_bItem = _x getVariable ["bItem",[]];
		if (count _bItem != 0) then
		{
			private ["_icon","_businessItem"];
			if (_x isKindOf "Car") then {_icon = "\A3\ui_f\data\map\VehicleIcons\iconcar_ca.paa";};
			if (isNil "_icon") then {_icon = "\A3\ui_f\data\map\VehicleIcons\iconcratewpns_ca.paa";};
			_businessItem = _bItem select 2;
			if (_businessItem) then {_businessItem = "business";} else {_businessItem = "consumer";};
			_iTags pushback [_x modelToWorld [0,0,0.75],format ["$%1 - %2 (%3 item)",_bItem select 0,_bItem select 1,_businessItem],_icon];//pos,display,icon
		};
	} foreach _items;

	A3PL_Player_bTagsArray = _tags;
	A3PL_Player_biTagsArray = _iTags;
}] call Server_Setup_Compile;

//Responsible for drawing 3D icons each frame
["A3PL_Player_DrawText",
{
	["A3PL_DrawText", "onEachFrame",
	{
		{
			_p = _x select 0;
			_pos = visiblePositionASL _p;
			_pos set [2, ((_p modelToWorld [0,0,0]) select 2) + 2];
			if (_p getVariable ["pVar_RedNameOn",false]) then {
				drawIcon3D ["", [0.98,0,0,1],_pos, 0.2, 0.2, 45,format ["%2: %1 (OOC)",((_x select 0) getvariable["name",name (_x select 0)]), [] call A3PL_AdminGetRank], 1, 0.03, "EtelkaNarrowMediumPro"];
			} else {
				drawIcon3D ["", [1, 1, 1, 1],_pos, 0.2, 0.2, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
			};
		} foreach (missionNameSpace getVariable ["A3PL_Player_TagsArray",[]]);

		//business names
		{
			drawIcon3D ["\a3\ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa", [1, 1, 1, 1],_x select 0, 0.5, 0.5, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
		} foreach (missionNameSpace getVariable ["A3PL_Player_bTagsArray",[]]);

		//business items that are for sale
		{
			drawIcon3D [_x select 2, [1, 1, 1, 1],_x select 0, 0.5, 0.5, 45, _x select 1, 1, 0.03, "EtelkaNarrowMediumPro"];
		} foreach (missionNameSpace getVariable ["A3PL_Player_biTagsArray",[]]);
	}] call BIS_fnc_addStackedEventHandler;
}] call Server_Setup_Compile;
//["A3PL_DrawText", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

//First function that loads when player joins
['A3PL_Player_Initialize', {
	private ["_myVersion"];
	//#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

	//do a version check first
	if ((getNumber (configFile >> "CfgPatches" >> "A3PL_Common" >> "requiredVersion")) != (missionNameSpace getVariable ["Server_ModVersion",0])) exitwith
	{
		[] spawn
		{
			titleText ["Your A3PL mods are outdated, please sync with ArmA3Sync - You will be kicked in 5 seconds", "BLACK"];
			uiSleep 5;
			player setVariable ["A3PL_Outdated",1,true];
		};
	};

	//GET FUCKED SCROLLMENU
	//Replaced with our own action key ;)
	inGameUISetEventHandler ["PrevAction", "if (Player_selectedIntersect > 0) then {Player_selectedIntersect = Player_selectedIntersect - 1;}; true"];
	inGameUISetEventHandler ["NextAction", "Player_selectedIntersect = Player_selectedIntersect + 1; true"];
	inGameUISetEventHandler ["Action", "true;"]; //block scroll option
	showHUD [true,false,false,false,false,false,false,true,false]; //hide scroll option
	player addAction ["", {}]; //and this breaks the scroll menu
	//Additional bypass for scroll menu inside A3PL_EventHandlers

	//Setup some bowling stuff
	[] call A3PL_Bowling_Init;

	//Setup normal variables
	[] call A3PL_Player_VariablesSetup;

	//Setup blacklisted variables - function loaded by server only
	[[player], 'Server_Player_BLVariablesSetup', false] call BIS_fnc_MP;

	//Start loading process
	[] call A3PL_Loading_Start;

	//Initialise the HUD
	[] call A3PL_HUD_Init;

	//Setup loops
	[] call A3PL_Loop_Setup;

	//Setup Eventhandlers
	[] call A3PL_EventHandlers_Setup;

	//Setup intersection oneachframe, used for interaction menu
	[] call A3PL_Intersect_Lines;

	//setup name tags
	[] call A3PL_Player_DrawText;

	//Setup interaction menu
	//['player', [DIK_E], -100, 'call A3PL_Interaction;'] call CBA_fnc_fleximenu_add;

	//debug - allow to teleport to map click
	//onMapSingleClick "(vehicle player) setpos _pos;";

	[] spawn A3PL_Housing_Init;
	
	//Markers setup
	[player] spawn A3PL_Player_SetMarkers;
}] call Server_Setup_Compile;

['A3PL_Player_TeamspeakID', {
	player setVariable ["A3PL_TeamspeakID", (floor random 9999999999) toFixed 0 ]; 
}] call Server_Setup_Compile;

['A3PL_Abort_Blocker', {
	/*
	(findDisplay 49) displayAddEventHandler ["Load", {
		params ["_display","_key"];
		((findDisplay 49) displayCtrl 104) ctrlEnable false;
	}];
	*/
	[] spawn {
		while {true} do
		{
			waitUntil{!isNull (findDisplay 49)};
			_abortButton = (findDisplay 49) displayCtrl 104;
			_abortButton ctrlEnable false;
			_timeLeft = 10;
			while {isNull (findDisplay 49) && _timeLeft > 0} do {
				_abortButton ctrlSetText (format ["Abort (%1)", _timeLeft]);
				_timeLeft = _timeLeft - 1;
				uiSleep 1.0;
			};
			_abortButton ctrlEnable true;
			waitUntil{isNull (findDisplay 49)};
		};

	};
}] call Server_Setup_Compile;

['A3PL_Player_NewPlayer',{
	disableSerialization;
	private ["_display","_control","_sex","_day","_month","_year"];
	waituntil {sleep 0.1; isNull(findDisplay 15)};
	createDialog "Dialog_NewPlayer";
	_display = findDisplay 111;
	noEscape = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then {true}"];
	_sex = _display displayCtrl 1403;
    _day = _display displayCtrl 1404;
    _month = _display displayCtrl 1405;
    _year = _display displayCtrl 1406;
    _control = _display displayCtrl 2100;
	_sex lbAdd "Male";
	_sex lbSetData [(lbSize _sex) - 1, "male"];
	_sex lbAdd "Female";
	_sex lbSetData [(lbSize _sex) - 1, "female"];

	for "_i" from 1 to 31 do {
		_day lbAdd str _i;
		_day lbSetData [(lbSize _day)-1,str(_i)];
	};

	for "_l" from 1 to 12 do {
		_month lbAdd str _l;
		_month lbSetData [(lbSize _month)-1,str(_l)];
	};

	for "_k" from 1920 to 2001 do {
		_value = 2001 - (_k - 1920);
		_year lbAdd str _value;
		_year lbSetData [(lbSize _year)-1,str(_value)];
	};
	//Structured text
	_control = _display displayCtrl 2100;

	//message
	if (isNil "A3PL_NewPlayerRequested") then
	{
		[localize "STR_PLAYER_PLSENTERDET", Color_Green] call a3pl_player_notification; //System: It looks like you are a new player, please enter your details
	} else
	{
		[localize "STR_PLAYER_NAMEINUSE", Color_Red] call a3pl_player_notification; //System: Server was unable to create your character, maybe the name is already in use?
	};
	A3PL_NewPlayerRequested = true;
}] call Server_Setup_Compile;

['A3PL_Player_NewPlayerSubmit',{
	private ["_display","_control","_firstname","_lastname","_checkname","_forbiddenChars","_acceptedChars","_c","_sex","_dob","_day","_month","_year"];
	_display = findDisplay 111;
	//Structured text
	_control = _display displayCtrl 1400;
	_firstname = ctrlText _control;
	_control = _display displayCtrl 1401;
	_lastname = ctrlText _control;
	_sex = lbData [1403,(lbCurSel 1403)];
	_day = lbData [1404,(lbCurSel 1404)];
	_day = parseNumber _day;
    _month = lbData [1405,(lbCurSel 1405)];
	_month = parseNumber _month;
    _year = lbData [1406,(lbCurSel 1406)];
	_year = parseNumber _year;
	
	if (count _firstname < 2) exitwith
	{
		[localize "STR_PLAYER_FIRSTN2CHAR", Color_Red] call a3pl_player_notification; //System: Please enter a firstname that's longer than 2 characters
	};

	if (count _lastname < 2) exitwith
	{
		[localize "STR_PLAYER_LASTN2CHAR", Color_Red] call a3pl_player_notification; //System: Please enter a lastname that's longer than 2 characters
	};

	if (_sex isEqualTo "") exitWith {
		["Please enter your Sex",Color_Red] call A3PL_Player_Notification;
	};

	if (_day isEqualTo 0 || _month isEqualTo 0 || _year isEqualTo 0) exitWith {
		["Please enter your DOB",Color_Red] call A3PL_Player_Notification;
	};

    _dob = format ["%1/%2/%3",_day, _month, _year];

	//check the player name for invalid characters
	_checkname = _firstname + _lastname;
	_checkname = toArray _checkname;
	_acceptedChars = toArray "abcdefghijklmnopqrstuvwxyz";
	_forbiddenUsed = false;
	{
		if (!(_x IN _acceptedChars)) exitwith
		{
			_forbiddenUsed = true;
		};
	} foreach _checkname;

	if (_forbiddenUsed) exitwith
	{
		[localize "STR_PLAYER_FORBCHAR", Color_Red] call a3pl_player_notification; //System: You used forbidden characters in your name, please resolve this
		[localize "STR_PLAYER_CAPITALLETT", Color_Red] call a3pl_player_notification; //System: Do not use capital letters, this will be done automatically
	};

	if (format["%1 %2", _firstname, _lastName] != profileName) exitWith {
		["The first and last name entered do not match with your ArmA 3 profile name", Color_Red] call a3pl_player_notification;
	};

	//fix capital letters
	_c = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	_firstname = toArray _firstname;
	_firstname set [0,_c select (_acceptedChars find (_firstname select 0))];
	_firstname = toString _firstname;

	_lastname = toArray _lastname;
	_lastname set [0,_c select (_acceptedChars find (_lastname select 0))];
	_lastname = toString _lastname;

	[[player,(_firstname + " " + _lastname), (ctrlText 1402), _sex, _dob],"Server_Gear_NewReceive",false,false] call BIS_FNC_MP;
	[format ["Welcome to Fishers Island, New York. This is where you'll begin your new adventure.",(_firstname + " " + _lastname)], Color_Green] call a3pl_player_notification;
	closeDialog 0;
}] call Server_Setup_Compile;

//check if has enough money
['A3PL_Player_HasCash', {
	private ['_amount', '_cash'];

	_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
	_cash = player getVariable 'Player_Cash';

	//Check if player has _amount in cash
	if (_cash >= _amount) exitWith {true};

	false
}] call Server_Setup_Compile;

//check if has enough money
['A3PL_Player_HasBank', {
	private ['_amount', '_bank'];

	_amount = [_this, 0, 0, [0]] call BIS_fnc_param;
	_bank = player getVariable 'Player_Bank';

	//Check if player has _amount in bank
	if (_bank >= _amount) exitWith {true};

	false
}] call Server_Setup_Compile;

//add paycheck money - players have to pick it up from the bank - very simple right now
['A3PL_Player_PickupPaycheck', {
	private ['_paycheckAmount', '_format'];

	_paycheckAmount = Player_Paycheck;
	//_xpAmount = Player_PaycheckXP;

	//make sure they have a paycheck to pickup
	if (Player_Paycheck < 1) exitWith
	{
		[localize "STR_PLAYER_NOPAYCHCOL", Color_Red] call A3PL_Player_Notification; //System: There doesn't seem to be a paycheck to collect
	};

	//reset variables
	Player_Paycheck = 0;
	//Player_PaycheckXP = 0;

	//Change bank variable
	[[player, 'Player_Bank', ((player getVariable 'Player_Bank') + _paycheckAmount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	//add xp
	//[_xpAmount] call A3PL_Player_AddXP;

	//display notification
	_format = format[localize "STR_PLAYER_SIGNEDREC", [_paycheckAmount] call A3PL_Lib_FormatNumber]; //I signed my paycheck and received $%1 into my bank account
	[_format, Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//displays a notification (will display the 5 previous before reseting) --- [message, color] call A3PL_Player_Notification;
["A3PL_Player_Notification", {
	private ['_msg', '_color', '_title', '_final', '_i'];

	_msg = param [0,""];
	_color = param [1,Color_Red];

	//Run our hud function and dont delete it...
	[_msg,_color] call A3PL_HUD_Message;

	_i = 0;

	_title = "<t align = 'center' shadow = '1' size='1.1' font='PuristaBold'>Arma 3 Reality Life<br />Notifications</t>";

	_final = "";

	Player_Notifications = [[_msg,_color]] + Player_Notifications;

	{
		if(_i <= 4) then {
			_final = format["<br /><br /><t align='center' color='%2'>%1</t>", (_x select 0), (_x select 1)] + _final;

			_i = _i + 1;
		};
	} forEach Player_Notifications;
	if (profilenamespace getVariable ["A3PL_HINT_Enabled",true]) then {
	//hint parseText (_title + _final);
	};

	if((count(Player_Notifications)) > 4) then {
		Player_Notifications deleteAt 5;
	};

}] call Server_Setup_Compile;

//adds x XP to player
['A3PL_Player_AddXP', {
	private ['_amount', '_currentXP', '_finalXP'];

	_amount = _this select 0;
	_currentXP = player getVariable 'Player_XP';
	_finalXP = (_currentXP + _amount);

	//send to server to change variable
	[[player, 'Player_XP', _finalXP], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	//check to see if player level is correct after change
	[] call A3PL_Player_VerifyLevel;
}] call Server_Setup_Compile;

//if the xp is more than needed it will 'level up' the player
['A3PL_Player_VerifyLevel', {
	private ['_currentLevel', '_currentXP', '_XPForNextLevel'];

	_currentLevel = player getVariable 'Player_Level';
	_currentXP = player getVariable 'Player_XP';
	_XPForNextLevel = [_currentLevel, 'next'] call A3PL_Config_GetLevel;

	if (_currentXP >= _XPForNextLevel) then {
		[[player, 'Player_Level', (_currentLevel + 1)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
		[] call A3PL_Player_VerifyLevel;
	};
}] call Server_Setup_Compile;

//retrieve a player tag (medical)
["A3PL_Player_GetNameTag",
{
	private ["_player","_uid","_name","_saved"];
	_player = param [0,objNull];
	_uid = getPlayerUID _player;

	_saved = profileNamespace getVariable ["A3PL_NameTags",[]];
	_name = "Unknown";

	{
		_sUID = _x select 0;
		_sName = _x select 1;

		if(_sUID == _uid) exitWith {
			_name = _sName;
		}
	} forEach _saved;

	_name;
}] call Server_Setup_Compile;

["A3PL_Player_OpenNametag",
{
	private ["_player","_uid","_name","_saved"];
	_player = param [0,objNull];
	_uid = getPlayerUID _player;

	A3PL_Nametag_Uid = _uid;
	_saved = profileNamespace getVariable ["A3PL_NameTags",[]];
	_name = "";

	{
		_sUID = _x select 0;
		_sName = _x select 1;

		if(_sUID == _uid) exitWith {
			_name = _sName;
		}
	} forEach _saved;

	createDialog "Dialog_Nametag";
	ctrlSetText [1400, _name];

}] call Server_Setup_Compile;

["A3PL_Player_OpenNametag",{

	params[["_uid","",[""]]];

	A3PL_Nametag_Uid = _uid;
	_saved = profileNamespace getVariable ["A3PL_NameTags",[]];
	_name = "";

	{
		_sUID = _x select 0;
		_sName = _x select 1;

		if(_sUID == _uid) exitWith {
			_name = _sName;
		}
	} forEach _saved;

	createDialog "Dialog_Nametag";
	ctrlSetText [1400, _name];

}] call Server_Setup_Compile;

["A3PL_Player_SaveNametag",{

	_saved = profileNamespace getVariable ["A3PL_NameTags",[]];
	_name = ctrlText 1400;

	_id = -1;

	{
		_sUID = _x select 0;

		if(_sUID == A3PL_Nametag_Uid) exitWith {
			_id = _forEachIndex;
		}
	} forEach _saved;

	if(_id > -1) then {
		_saved set [_id,[A3PL_Nametag_Uid,_name]];
	} else {
		_saved pushBack [A3PL_Nametag_Uid,_name];
	};

	profileNamespace setVariable ["A3PL_NameTags",_saved];

}] call Server_Setup_Compile;

//hostage, spawn this
["A3PL_Player_TakeHostage",
{
	private ["_target","_ehFired","_ehReload"];
	_target = param [0,objNull];

	if (player distance _target > 2) exitWith {["Ran too far away",Color_Red] call A3PL_Player_notification;};
	if (!(_target IN allPlayers)) exitwith {[localize "STR_PLAYER_NOTLOOKINGVALPL",Color_Red] call A3PL_Player_notification;}; //System: You are not looking at a valid player
	if ((handgunWeapon player == "") OR ((handgunWeapon player) IN ["A3PL_Pickaxe","A3PL_Shovel","A3PL_High_Pressure"])) exitwith {["System: You are not carrying a handgun",Color_Red] call A3PL_Player_notification;};
	if (!isNil "A3PL_EnableHostage") exitwith {[localize "STR_PLAYER_TAKESOMEONEHOST",Color_Red] call A3PL_Player_Notification;}; //System: You are already taking someone hostage!

	A3PL_EnableHostage = true;
	A3PL_HostageMode = "hostage";
	A3PL_HostageTarget = _target;
	A3PL_HostageReloading = false;

	_ehFired = player addEventHandler ["Fired",
	{
		if (A3PL_HostageMode == "hostage") exitwith
		{
			if ((!isNull A3PL_HostageTarget)&&((handgunWeapon player) !="A3PL_Taser")) then { [] remoteExec ["A3PL_Medical_Die",A3PL_HostageTarget];};

			A3PL_EnableHostage = false;
		};
	}];

	_ehReload = (findDisplay 46) displayAddEventHandler ["KeyDown",
	{
		if ((_this select 1) in actionKeys "ReloadMagazine") then
		{
			[] spawn
			{
				A3PL_HostageReloading = true;
				uiSleep 3.5;
				if (!isNil "A3PL_HostageReloading") then {A3PL_HostageReloading = false};
			};
			false;
		};
	}];

	//set animation
	player playAction "gesture_takehostage";
	[_target,"A3PL_TakenHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2]; //change to -2
	_target attachto [player,[-0.05,0.2,-0.02]];//_target attachTo [player,[-0.14,-0.15,-1.45],"LeftHand"];
	uiSleep 2;

	while {A3PL_EnableHostage} do
	{
		if (A3PL_HostageMode == "hostage" && !A3PL_HostageReloading) then { player playAction "gesture_takehostageloop"; };
		if (A3PL_HostageMode == "shoot" && !A3PL_HostageReloading) then { player playAction "gesture_takehostageshootloop"; };
		uiSleep 2;
		if ((isNull A3PL_HostageTarget) OR (([_target,"blood"] call A3PL_Medical_GetVar) <= 0)) exitwith {}; //change (false) to player alive check
	};

	player playaction "gesture_stop";
	player removeEventHandler ["Fired",_ehFired];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_ehReload];
	A3PL_EnableHostage = nil; A3PL_HostageMode = nil; A3PL_HostageTarget = nil; A3PL_HostageReloading = nil;

	if (([_target,"blood"] call A3PL_Medical_GetVar) > 0) then //if alive target
	{
		[_target,"A3PL_ReleasedHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2]; //change to -2
		if (([player,"blood"] call A3PL_Medical_GetVar) > 0) then {[player,"A3PL_ReleaseHostage"] remoteExec ["A3PL_Lib_SyncAnim",-2];}; //if alive player
		sleep 3;
		detach _target;
		if (([_target,"blood"] call A3PL_Medical_GetVar) > 0) then {[_target,""] remoteExec ["A3PL_Lib_SyncAnim",-2];}; //if alive target
		if (([player,"blood"] call A3PL_Medical_GetVar) > 0) then {[player,""] remoteExec ["A3PL_Lib_SyncAnim",-2];}; //if alive player
	} else
	{
		detach _target;
	};
}] call Server_Setup_Compile;

["A3PL_Player_SetMarkers",
{
	_player = param [0,objNull];
	_job = player getVariable ["job","unemployed"];
	_faction = _player getVariable ["faction","citizen"];

	if (!(["motorhead"] call A3PL_Lib_hasPerk)) then {deleteMarkerLocal "perk_store_marker";};
	if(_job != "uscg") then {{_x setMarkerAlpha 0;} forEach ["USCG_Shop","USCG_Boat","USCG_Boat_Spawn","USCG_Vehicle","USCG_Aircraft"];} else {{_x setMarkerAlpha 1;} forEach ["USCG_Shop","USCG_Boat","USCG_Boat_Spawn","USCG_Vehicle","USCG_Aircraft"];};
	if(_job != "faa") then {{_x setMarkerAlpha 0;} forEach ["FAA_vehicles","FAA_shop"];} else {{_x setMarkerAlpha 1;} forEach ["FAA_vehicles","FAA_shop"];};
	if(_job != "doj") then {{_x setMarkerAlpha 0;} forEach ["weaponsNPC"];} else {{_x setMarkerAlpha 1;} forEach ["weaponsNPC"];};
	if(_job != "police") then {{_x setMarkerAlpha 0;} forEach ["SD_equipment","SDVehicles"];} else {{_x setMarkerAlpha 1;} forEach ["SD_equipment","SDVehicles"];};
	if(_job != "fifr") then {{_x setMarkerAlpha 0;} forEach ["FifrEquipment","FifrVehicles"];} else {{_x setMarkerAlpha 1;} forEach ["FifrEquipment","FifrVehicles"];};
	if(_job != "waste") then {
		{_x setMarkerAlpha 0;} forEach ["trash_bin_1","trash_bin_2","trash_bin_3","trash_bin_4","trash_bin_5","trash_bin_6","trash_bin_7","trash_bin_8","trash_bin_9","trash_bin_10","trash_bin_11","trash_bin_12","trash_bin_13","trash_bin_14","trash_bin_15","trash_bin_16","trash_bin_17","trash_bin_18","trash_bin_19","trash_bin_20","trash_bin_21","trash_bin_22","trash_bin_23","trash_bin_24","trash_bin_25","trash_bin_26","trash_bin_27","trash_bin_28","trash_bin_29","trash_bin_30","trash_bin_31","trash_bin_32","trash_bin_33","trash_bin_34","trash_bin_35","trash_bin_36","trash_bin_37","trash_bin_38","trash_bin_39","trash_bin_40","trash_bin_41","trash_bin_42","trash_bin_43"];
	} else {
		{_x setMarkerAlpha 1;} forEach ["trash_bin_1","trash_bin_2","trash_bin_3","trash_bin_4","trash_bin_5","trash_bin_6","trash_bin_7","trash_bin_8","trash_bin_9","trash_bin_10","trash_bin_11","trash_bin_12","trash_bin_13","trash_bin_14","trash_bin_15","trash_bin_16","trash_bin_17","trash_bin_18","trash_bin_19","trash_bin_20","trash_bin_21","trash_bin_22","trash_bin_23","trash_bin_24","trash_bin_25","trash_bin_26","trash_bin_27","trash_bin_28","trash_bin_29","trash_bin_30","trash_bin_31","trash_bin_32","trash_bin_33","trash_bin_34","trash_bin_35","trash_bin_36","trash_bin_37","trash_bin_38","trash_bin_39","trash_bin_40","trash_bin_41","trash_bin_42","trash_bin_43"];
	};
	if(_faction != "admin") then {
		{_x setMarkerAlphaLocal 0;} forEach ["A3PL_Marker_Hunting_1","A3PL_Marker_Hunting","A3PL_Marker_Hunting_3","A3PL_Marker_Hunting_2","A3PL_Marker_Fish4","A3PL_Marker_Fish3","A3PL_Marker_SallySpeedway","OilSpawnArea","CemeteryArea","Area_DrugDealer9","Area_DrugDealer8","Area_DrugDealer7","Area_DrugDealer6","Area_DrugDealer5","Area_DrugDealer4","Area_DrugDealer3","Area_DrugDealer2","Area_DrugDealer1","Area_DrugDealer","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14","A3PL_Markers_Fish6","A3PL_Markers_Fish1","LumberJack_Rectangle","A3PL_Marker_Sand1","A3PL_Marker_Sand2","A3PL_Marker_Fish1","A3PL_Marker_Fish2","A3PL_Marker_Fish8","A3PL_Marker_Fish7","A3PL_Marker_Fish5","A3PL_Marker_Fish6","Picking_Apple_1","Fishing1","Fishing2","Fishing3","Fishing3_1","Fishing4","Fishing5","Fishing5_1","Fishing6"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["A3PL_Marker_Hunting_1","A3PL_Marker_Hunting","A3PL_Marker_Hunting_3","A3PL_Marker_Hunting_2","A3PL_Marker_Fish4","A3PL_Marker_Fish3","A3PL_Marker_SallySpeedway","OilSpawnArea","CemeteryArea","Area_DrugDealer9","Area_DrugDealer8","Area_DrugDealer7","Area_DrugDealer6","Area_DrugDealer5","Area_DrugDealer4","Area_DrugDealer3","Area_DrugDealer2","Area_DrugDealer1","Area_DrugDealer","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14","A3PL_Markers_Fish6","A3PL_Markers_Fish1","LumberJack_Rectangle","A3PL_Marker_Sand1","A3PL_Marker_Sand2","A3PL_Marker_Fish1","A3PL_Marker_Fish2","A3PL_Marker_Fish8","A3PL_Marker_Fish7","A3PL_Marker_Fish6","A3PL_Marker_Fish5","Picking_Apple_1","Fishing1","Fishing2","Fishing3","Fishing3_1","Fishing4","Fishing5","Fishing5_1","Fishing6"];
	};
	if((_job != "fisherman") && (_job != "uscg")) then {
		{_x setMarkerAlphaLocal 0;} forEach ["Fishing1","Fishing2","Fishing3","Fishing3_1","Fishing4","Fishing5","Fishing5_1","Fishing6"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["Fishing1","Fishing2","Fishing3","Fishing3_1","Fishing4","Fishing5","Fishing5_1","Fishing6"];
	};
	if((_job != "mafia")) then {
		{_x setMarkerAlphaLocal 0;} forEach ["mafia_marker"];
	} else {
		{_x setMarkerAlphaLocal 1;} forEach ["mafia_marker"];
	};
}] call Server_Setup_Compile;
