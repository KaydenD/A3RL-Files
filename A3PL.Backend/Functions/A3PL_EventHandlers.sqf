#include "\a3\editor_f\Data\Scripts\dikCodes.h"
["A3PL_EventHandlers_Setup",
{

	[] call A3PL_EventHandlers_HandleDamage;
	[] call A3PL_EventHandlers_FiredNear;
	[] call A3PL_EventHandlers_Take;
	[] call A3PL_EventHandlers_Fired;
	[] call A3PL_EventHandlers_TFRAnimation;
	[] call A3PL_EventHandlers_OpenMap;

	[] spawn
	{
		waitUntil {!isnull (findDisplay 46)};
		//params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
		(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call A3PL_EventHandlers_HandleDown;}];
		(findDisplay 46) displayAddEventHandler ["KeyUp", {_this call A3PL_EventHandlers_HandleUp;}];

		//Add the E-Menu
		["A3PL","interaction_key", "Open interaction wheel",
		{
			if(!isNil "A3PL_MedicalVar_Unconscious") exitWith {};
			if (!isNil "A3PL_Interaction_KeyDown") exitwith {};
			A3PL_Interaction_KeyDown = true;

			if(alive player) then {
				[player_objintersect] call A3PL_Interaction_loadInteraction;
			};
		},
		{
			if(player getVariable ["Incapacitated",false]) exitWith {};
			if (!isNil "A3PL_Interaction_KeyDown") then
			{
				A3PL_Interaction_KeyDown = Nil;
			};

			//check if interaction is open and close it
			if (!isNull (findDisplay 1000)) then
			{
				(findDisplay 1000) closeDisplay 0;
			};
			true;
		}, [DIK_E, [false, false, false]]] call CBA_fnc_addKeybind;


		(findDisplay 46) displayAddEventHandler ["MouseButtonUp", //this and the code below down in HandleUp fix the scroll menu
		{
			private ["_button"];
			_button = (param [1,-1]) + 65536;
			if (_button IN (actionKeys "Action")) then
			{
				[] spawn A3PL_Interaction_ActionKey;
			};
		}];
	};
}] call Server_Setup_Compile;

["A3PL_EventHandlers_OpenMap",
{
	addMissionEventHandler ["Map", {
		params ["_mapIsOpened","_mapIsForced"];
		if (_mapIsOpened or _mapIsForced) then
		{
			[] call A3PL_Markers_OpenMap;
		} else
		{
			("A3PL_Map_Filter" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_Fired",
{
	player addEventHandler ["Fired",
	{
		private ["_weapon"];
		_weapon = param [1,""]; //classname of weapon

		if (_weapon IN ["A3PL_FireAxe","A3PL_Pickaxe","A3PL_Shovel","A3PL_Scythe"]) then
		{
			player playAction "GestureSwing";
			if (player inArea "LumberJack_Rectangle") then
			{
				if (_weapon == "A3PL_FireAxe") then {[] call A3PL_Lumber_FireAxe;};
			} else
			{
				if ((player getVariable ["faction","citizen"]) IN ["fifr","police"]) then {[] call A3PL_FD_HandleFireAxe};
			};
		};
		if (_weapon == "A3PL_Jaws") then
		{
			[] call A3PL_FD_HandleJaws;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleDown",
{
	params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

	if(isNil "A3PL_Manual_KeyDown") then {A3PL_Manual_KeyDown = false};

	/*
	if (_dikCode == 18) exitWith {
		if(!isNil "A3PL_MedicalVar_Unconscious") exitWith {};
		if (!isNil "A3PL_Interaction_KeyDown") exitwith {};
		A3PL_Interaction_KeyDown = true;

		if(alive player) then {
			[player_objintersect] call A3PL_Interaction_loadInteraction;
		};

	};
	*/

	/* Phone */
	if (_dikCode == 34) exitWith {
		closeDialog 0;
		if (!([] call A3PL_Lib_HasPhone)) exitwith {["You don't have phone"] call A3PL_Player_Notification;};
		//[] call A3PL_iPhoneX_Master;
		[] call A3PL_Phone_Open;
	};
/*
	//Golfing hit
	if ((_dikCode == 57) && A3PL_Player_Golfing) exitWith {
		[] spawn A3PL_Golf_Hitmode;
		true;
	};

	if ((_dikCode == 14) && A3PL_Player_Golfing) exitWith {
		[] spawn A3PL_Golf_Backspace;
		true;
	};
*/

	/////////////////////
	//  ADMIN RELATED  //
	/////////////////////

	// Admin Menu //

	if (_dikCode == 59) exitWith {
		if (pVar_AdminMenuGranted) exitWith
		{
			[] call A3PL_AdminOpen;
		};
	};

	// Cursor Target Menu //

	if (_dikCode == 60) exitWith {
		if (pVar_AdminMenuGranted) then {
			if (pVar_CursorTargetEnabled) then {
				pVar_CursorTargetEnabled = false;
			} else {
				[] spawn A3PL_AdminCursorTarget;
			};
		};
	};


	// Spectate //
	if (_dikCode == 61) exitWith {
		if (pVar_AdminMenuGranted) then {
			disableSerialization;
			pVar_AdminPrePosition = getPosATL player;

			player hideObjectGlobal true;

			if (!isObjectHidden player) then
			{
				[player] remoteExec ["A3PL_Lib_HideObject", 2];
				uisleep 0.5;
			};

			["Initialize", [player, [], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
			//[player,"spectate",[format ["ENABLED"]]] remoteExec ["Server_AdminLoginsert", 2];

			_spectatorCamera = ["GetCamera"] call BIS_fnc_EGSpectatorCamera;
			_magicCarpet = "logic" createVehicleLocal (getpos _spectatorCamera);
			player attachTo [_magicCarpet,[0,0,0]];
			while {!isNull (findDisplay 60492)} do
			{
				_magicCarpet setPosATL (getPosATL _spectatorCamera);
				uiSleep 0.1;
			};

			[] spawn {
				waitUntil {!isNull findDisplay 49};
				["Terminate"] call BIS_fnc_EGSpectator;
				[player,false] remoteExec ["A3PL_Lib_HideObject", 2];
				(findDisplay 49) closeDisplay 1;
				waitUntil {isNull findDisplay 49};
			};

			deleteVehicle _magicCarpet;
			detach player;
			player setposATL (missionNameSpace getVariable ['pVar_AdminPrePosition',getposATL player]);
			pVar_AdminPrePosition = nil;
			player hideObjectGlobal true;
		};
	};

	// Debug //

	if (_dikCode == 62) exitWith {
		if ((player getVariable ["dbVar_AdminLevel",0]) != 3) exitWith {};

		[] call A3PL_Debug_Open;
	};

	/* Holster */
	if (_dikCode == 35 && _ctrlKey) exitWith {

		if (currentWeapon player != "") exitWith {
			A3PL_Holster = currentWeapon player;
			player action ["SwitchWeapon", player, player, 100];
			player switchCamera cameraView;

			true;
		};

		if(!isNil "A3PL_Holster" && {A3PL_Holster != ""}) exitWith {
			player selectWeapon A3PL_Holster;

			true;
		};
	};

	if(vehicle player == player && !(animationState player in ["A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","A3PL_HandsupKneel"])) then {
		//1 - Wave
		if(_dikCode == 2) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			player playAction "Gesture_wave";
			true;
		};

		//2 - Flip Off
		if(_dikCode == 3) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			player playAction "Gesture_finger";
			true;
		};

		//3 - Watching You
		if(_dikCode == 4) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			player playAction "Gesture_watching";
			true;
		};

		//4 - House Dance
		if(_dikCode == 5) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			if ((animationState player) != "A3PL_Dance_House1") then
			{
				[player, "A3PL_Dance_House1"] remoteExec ["A3PL_Lib_SyncAnim",0];
			} else
			{
				[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
			};
			true;
		};
		//5 - Samba Dance
		if(_dikCode == 6) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			if ((animationState player) != "A3PL_Dance_Samba") then
			{
				[player, "A3PL_Dance_Samba"] remoteExec ["A3PL_Lib_SyncAnim",0];
			} else
			{
				[player, ""] remoteExec ["A3PL_Lib_SyncAnim",0];
			};
			true;
		};
		//6 - Dab
		if(_dikCode == 7) exitWith {
			if(isNil {player getVariable "Cuffed"} || isNil {player getVariable "Zipped"}) exitWith{["System: You cannot perform this action while restrained!",Color_Red] call A3PL_Player_Notification;};
			player playAction "gesture_dab";
			true;
		};
	};

	//Siren Hotkeys
	if ((_dikCode > 1 && _dikCode < 5) && {vehicle player != player} && {typeOf vehicle player in Config_Police_Vehs} && {(player == driver (vehicle player))}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		true;
	};

	//Siren Hotkeys (up)
	if ((_dikCode > 5 && _dikCode < 14) && {vehicle player != player} && {!A3PL_Manual_KeyDown} && {typeOf vehicle player in Config_Police_Vehs} && {(player == driver (vehicle player))}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		A3PL_Manual_KeyDown = true;
		true;
	};

		/* Cursortarget options w/ extra check */
	//Numpad 1; Attach Cursortarget ADMIN
	if ((_dikCode == 79) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	[player_objintersect] call A3PL_Admin_AttachTo;
	true;
	};

	//Numpad 2; Detach Cursortarget ADMIN
	if ((_dikCode == 80) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	[] call A3PL_Admin_DetachAll;
	true;
	};

	//Numpad 3; Impound Cursortarget ADMIN
	if ((_dikCode == 81) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	[[player_objintersect],"Server_Police_Impound",false] call BIS_FNC_MP;
	true;
	};

	//Numpad 4; Delete Cursortarget ADMIN
	if ((_dikCode == 75) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	[player_objintersect] call A3PL_Vehicle_Despawn;
	true;
	};

	//Numpad 5; Move in Cursortarget ADMIN
	if ((_dikCode == 76) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	player moveInCargo player_objintersect;
	true;
	};

	//Numpad 6; Eject all Cursortarget ADMIN
	if ((_dikCode == 77) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted) exitWith {
			{ moveout _x } forEach crew CursorTarget;
			true;
	};

	if ((_dikCode == 82) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted)  exitWith {
			player moveInDriver cursorTarget;
			true;
	};

	//Numpad 7; Heal Cursortarget
	if ((_dikCode == 71) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
		player_objintersect setVariable ["A3PL_Medical_Alive",true,true];
		player_objintersect setVariable ["A3PL_Wounds",[],true];
		player_objintersect setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
		true;
	};

	//Numpad 8; Repair Cursortarget
	if ((_dikCode == 72) && pVar_CursorTargetEnabled && pVar_AdminMenuGranted ) exitWith {
	player_objintersect setdammage 0;
	true;
	};
	//player moveInDriver player_objintersect;
	 /*END Cursortarget options */
	false;
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleUp", //exit with true to overwrite default arma keys, and prevent rpt errors
{
	params["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

	//enter text on chatbox
	if ((_dikCode IN [28,156]) && (!isNull (findDisplay 5125))) exitwith {[] call A3PL_Twitter_Send;true;};
	//open chatbox
	if ((_dikCode == 20) && (isNull (findDisplay 5125))) exitwith {[] call A3PL_Twitter_Open;true;};

	//handle key downs
	/*
	if (_dikCode == 18) exitWith
	{
		if(player getVariable ["Incapacitated",false]) exitWith {};
		if (!isNil "A3PL_Interaction_KeyDown") then
		{
			A3PL_Interaction_KeyDown = Nil;
		};

		//check if interaction is open and close it
		if (!isNull (findDisplay 1000)) then
		{
			(findDisplay 1000) closeDisplay 0;
		};
		true;
	};
	*/

	//Siren Hotkeys (up)
	_dikCodeBegin = 4;
	if (vehicle player IN ["A3PL_Pierce_Pumper","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","Jonzie_Ambulance","A3PL_Tahoe_FD","A3PL_Tahoe_PD","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"]) then {_dikCodeBegin = 5};
	if ((_dikCode > _dikCodeBegin && _dikCode < 14) && {vehicle player != player} && {typeOf vehicle player in Config_Police_Vehs}) exitWith {
		[(_dikCode-1)] call A3PL_Vehicle_SirenHotkey;
		A3PL_Manual_KeyDown = false;
		true;
	};

	//Scroll menu
	if (_dikCode IN (actionKeys "Action")) then
	{
		[] spawn A3PL_Interaction_ActionKey;
		true;
	};
}] call Server_Setup_Compile;

["A3PL_EventHandlers_FiredNear",
{
	player addEventHandler ["FiredNear",
	{
		private ["_distance","_weaponClass","_except"];

		_distance = param [2,100];
		_weaponClass = param [3,""];
		_except = ["A3PL_Machinery_Bucket","A3PL_Machinery_Pickaxe","A3PL_Taser","A3PL_High_Pressure_Holder","A3PL_FireAxe","A3PL_Pickaxe","A3PL_Shovel","A3PL_Jaws","A3PL_High_Pressure","A3PL_Scythe",
				  "A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue",
				  "A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_FireExtinguisher"];

		if(_distance <= 30 && (!(_weaponClass IN _except))) then
		{
			Player_LockView = true;
			Player_LockView_Time = time + (2 * 60);
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_HandleDamage",
{
	player addEventHandler ["HandleDamage",
	{
		private ["_damage","_bullet","_unit","_dmg"];
		_unit = _this select 0;
		_selection = _this select 1;
		_damage = _this select 2;
		_source = _this select 3;
		_projectile = _this select 4;
		_dmg = 0;

		if (_damage > 0) then
		{
			private ["_hit"];
			_hit = _unit getVariable ["getHit",[]];
			_hit pushback [_selection,_damage,_projectile,_source];
			_unit setVariable ["getHit",_hit,false];
		};

		if (diag_tickTime <= ((missionNameSpace getVariable ["A3PL_HitTime",diag_ticktime-0.2]) + 0.1)) then {} else
		{
			A3PL_HitTime = diag_ticktime;
			[_unit] spawn A3PL_Medical_Hit;
		};
		_dmg;
	}];
	/*
	player addEventHandler ["HandleDamage",
	{
		private ["_source","_bullet","_damage"];
		_damage = _this select 2;
		_source = _this select 3;
		_bullet = _this select 4;


		// Taser script
		if (_bullet == "A3PL_TaserBullet") then
		{
			[] call A3PL_Lib_Ragdoll;

			[] spawn
			{
				player setVariable ["Tazed",true,true];
				sleep 7;
				player setVariable ["Tazed",nil,true];
			};
			_damage = 0;
		};

		//Only allow damage for certain projectiles
		if (_bullet IN ["B_45ACP_Ball","B_45ACP_Ball_Green","B_9x21_Ball"]) then
		{

		} else
		{
			_damage = 0;
		};

		//Handle the damage
		if (damage player + _damage >= 0.9) then
		{
			if (!(player getVariable ["Incapacitated",false])) then
			{
				[_source] call A3PL_Medical_Kill;
			};
			_damage = 0;
		};

		//Handle the return value
		_damage
	}];
	*/


}] call Server_Setup_Compile;

//Take eventhandler for player
["A3PL_EventHandlers_Take",
{
	player addEventHandler ["Take",
	{
		//deal with FD nozzle stuff
		_itemClass = param [2,""];
		if (_itemClass == "A3PL_High_Pressure_Holder") then
		{
			player setAmmo ["A3PL_High_Pressure_Holder",0];
		};
		if (_itemClass IN ["A3PL_High_Pressure_Water_Mag","A3PL_Medium_Pressure_Water_Mag","A3PL_Low_Pressure_Water_Mag"]) then
		{
			player removeMagazine _itemClass;
		};

		if (_itemClass == "A3PL_FD_Mask") then
		{
			["System: Item was added to your inventory instead",Color_Green] call A3PL_Player_Notification;
			removeGoggles player;
			player removeItem "A3PL_FD_Mask";
			["fd_mask",1] call A3PL_Inventory_Add;
		};

		//deal with weapons of axe type
		if (_itemClass == "A3PL_Shovel") then
		{
			player removeMagazines "A3PL_ShovelMag";
			player addMagazine "A3PL_ShovelMag";
		};
		if (_itemClass == "A3PL_Pickaxe") then
		{
			player removeMagazines "A3PL_PickAxeMag";
			player addMagazine "A3PL_PickAxeMag";
		};
		if (_itemClass == "A3PL_Jaws") then
		{
			player removeMagazines "A3PL_FireaxeMag";
			player addMagazine "A3PL_FireaxeMag";
		};

		if (_itemClass == "A3PL_Fireaxe") then
		{
			player removeMagazines "A3PL_FireaxeMag";
			player addMagazine "A3PL_FireaxeMag";
		};

		if (_itemClass == "A3PL_Scythe") then
		{
			player removeMagazines "A3PL_ScytheMag";
			player addMagazine "A3PL_ScytheMag";
		};

		if (_itemClass IN ["U_B_Protagonist_VR","U_I_Protagonist_VR","U_O_Protagonist_VR"]) then
		{
			if (!(["motorhead"] call A3PL_Lib_hasPerk)) then
			{
				["System: This is a donator item, please purchase the motorhead perk on the forum in order to use this item!",Color_Red] call A3PL_Player_Notification;

				if ((uniform player) == _itemClass) then
				{
					removeUniform player;
				};
				player removeItem _itemClass;

			};
		};
	}];
}] call Server_Setup_Compile;

//adds the EventHandler that will make the player play the animation when using radio
["A3PL_EventHandlers_TFRAnimation",
{
	["player", "OnBeforeTangent",
	{
		[(_this select 4)] spawn A3PL_EventHandlers_Transmitting;
	}, player] call TFAR_fnc_addEventHandler;

	player addEventHandler["WeaponDeployed",{player setVariable["a3pl_TFAR_Deployed",(_this select 1)]}];

	player addEventHandler ["Reloaded", {
		params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
		if (player getVariable["a3pl_transmittingGesture",false]) then
		{
			player addMagazine _newMagazine;
		};
	}];
}] call Server_Setup_Compile;

["A3PL_EventHandlers_Transmitting",
{
	params["_transmiting"];
	private ["_vest"];

	if (player getVariable["a3pl_TFAR_Deployed",false]) exitWith {};
	if (_transmiting) then
	{
		player setVariable ["a3pl_transmittingGesture", true];
		if (player getVariable["a3pl_TFAR_Deployed",false]) exitWith {};
		_vest = vest player;
		if (_vest !="") then //Play animation with vest
		{
			player playActionNow "a3pl_Radio03";
		} else  //Play animation without vest
		{
			player playActionNow "a3pl_Radio01";
		};
	} else {
		player playActionNow "GestureNod";
		player setVariable ["a3pl_transmittingGesture", false];
	};
}] call Server_Setup_Compile;


