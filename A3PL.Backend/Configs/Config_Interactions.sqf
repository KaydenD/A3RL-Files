A3PL_Interaction_Options =
[
	[
		"Recompile",
		{if (isServer) then {["A3PL.Backend"] call Server_Setup_SetupFiles} else {[[],"Server_Setup_SetupFiles",false,false,true] call BIS_FNC_MP;}; player globalChat localize "STR_INTER_FILESREC";}, //A3PL Files Recompiled.
		{(getPlayerUID player) IN ["_SP_PLAYER_","76561198131427403","76561198105892308"]} //jason
	],

	/* //check job vehicle time
	[
		"Check job vehicle time",
		{
			[format ["System: You have %1 minutes left to use your assigned job vehicle",((player getVariable ["jobVehicleTimer",diag_tickTime]) - diag_tickTime) / 60],Color_Green] call A3PL_Player_Notification;
		},
		{!isNull (player getVariable ["jobVehicle",objNull])}
	], */

	[
		"Climb",
		{
			player setPos(cursorobject modelToWorld [0,-4.6,1]);
		},
		{((typeOf cursorobject) IN ["A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder"]) && ((player distance (cursorObject modeltoworld [0,-5,-1])) < 3)}
	],


	[
		"Give Keys",
		{
			if(!([] call A3PL_Player_AntiSpam)) exitWith {}; [player, cursorObject] remoteExec ["A3PL_Vehicle_GiveKeys",player];
		},
		{isPlayer cursorObject && alive cursorObject && (player distance cursorObject < 8)}
	],

	[
		localize "STR_INTER_DOGSIT",
		{
			player_objintersect playMoveNow "Dog_Sit";
		},
		{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"])}
	],

	[
		localize "STR_INTER_DOGFOLLOW",
		{
			player_objintersect setVariable["doFollow",true,true];
		},
		{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"])}
	],

	[
		localize "STR_INTER_DOGSTOPFOLLOW",
		{
			player_objintersect setVariable["doFollow",false,true];
		},
		{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"])}
	],

	[
		"Deliver package",
		{
			[] call A3PL_Delivery_Deliver;
		},
		{ private ["_found"]; _found = false; {if ((typeOf _x) == "A3PL_DeliveryBox") exitwith {_found = true; true;}} foreach ([player] call A3PL_Lib_AttachedAll); _found;}
	],

	/* [ //get licence plate
		"Check VIN",
		{
			private ["_veh"];
			_veh = cursorObject;

				_id = (_veh getVariable ["owner",[]]) select 1;
				[format ["Number Plate: %1",_id],Color_Green] call A3PL_Player_Notification;
		},
		{((cursorObject isKindOf) IN ["A3PL_RHIB","A3PL_Jayhawk","C_Scooter_Transport_01_F"]) && ((cursorObject distance player) < 6) && ((player getVariable ["job","unemployed"]) IN ["police","uscg"])}
		/* ((cursorObject isKindOf) IN ["Ship","Helicopter","Plane"]) &&  */
	/* ], */

	[
		"Panic Button",
		{
			[] spawn A3PL_Police_Panic;
		},
		{((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && !(player getVariable "zipped") && !(player getVariable ["panicActive",false])}
	],

	[
		"Confirm Panic",
		{
			[(player getVariable "job")] spawn A3PL_Police_Panic;
		},
		{((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && (player getVariable "panicActive") && !(player getVariable "zipped")}
	],

	[
		"Rob Store",
		{
			[player_objintersect] spawn A3PL_Store_Robbery_RobStore;
		},
		{(vehicleVarName player_objintersect IN ["Robbable_Shop_1","Robbable_Shop_2","Robbable_Shop_3","Robbable_Shop_4","Robbable_Shop_5"]) && (player distance cursorobject < 2)}
	],
	
	[
		"Rob store (blueprints)",
		{
			[player_objintersect,2] spawn A3PL_Store_Robbery_RobStore;
		},
		{(vehicleVarName player_objintersect IN ["Robbable_Blueprints_1"]) && (player distance cursorobject < 2)}
	],
	
	[
		"Rob store (diamonds)",
		{
			[player_objintersect,3] spawn A3PL_Store_Robbery_RobStore;
		},
		{(vehicleVarName player_objintersect IN ["Robbable_Diamonds_1"]) && (player distance cursorobject < 2)}
	],	

	[
		"Check In",
		{
			[player_objintersect] spawn A3PL_SFP_CheckIn;
		},
		{((player getVariable ["job","unemployed"]) IN ["security"]) && (vehicleVarName player_objintersect IN ["Robbable_Shop_1","Robbable_Shop_2"]) && (player distance cursorobject < 2)}
	],

	[
		"Start Working",
		{
			[] spawn A3PL_Criminal_Work;
		},
		{(typeOf ([] call A3PL_Intersect_cursortarget) == "Land_ToolTrolley_02_F") && (player distance cursorobject < 2)}
	],

	[
		"Lock Pick Car", //Lock pick car
		{
			private ["_intersect"];
			_intersect = player_objintersect;
			if (isNull _intersect) exitwith {};
			if ((typeOf _intersect) IN ["A3PL_Jayhawk","A3PL_Cutter"]) exitWith {["System: You cannot lockpick this type of vehicle!", Color_Red] call A3PL_Player_Notification;};
			[_intersect] call A3PL_Criminal_PickCar;
		},
		{(vehicle player == player) && (player distance cursorObject < 7) && (player_ItemClass == "v_lockpick")}
	],

	[
		localize "STR_INTER_OPENLICMENU", //Open licensing menu
		{
			[] call A3PL_DMV_Open;
		},
		{((player getVariable ["job","unemployed"]) IN ["doj","dmv","uscg"])}
	],


	[
		"Check Speed",
		{
			[] call A3PL_DMV_Speed;
		},
		{((player getVariable ["job","unemployed"]) IN ["dmv"]) && (vehicle player != player)}
	],

	[
		localize "STR_INTER_GETINC", //Get in crane
		{
			player moveInDriver cursorobject;
		},
		{((typeOf cursorobject) == "A3PL_MobileCrane") && (player distance cursorobject < 30) && ((count (crew cursorobject)) == 0)}
	],

	[
		localize "STR_INTER_EXITC", //Exit crane
		{
			player action ["eject",vehicle player];
		},
		{((typeOf (vehicle player)) == "A3PL_MobileCrane")}
	],

	[
		localize "STR_INTER_RESETC", //Reset crane
		{
			[] call A3PL_IE_CraneReset;
		},
		{((typeOf (vehicle player)) == "A3PL_MobileCrane")}
	],

	[
		localize "STR_INTER_SHOWCCONT", //Show crane controls
		{
			[localize "STR_INTER_SHOWCONT1",Color_Yellow] call A3PL_Player_Notification; //System: Use the movement keys to move the crane around
			[localize "STR_INTER_SHOWCONT2",Color_Yellow] call A3PL_Player_Notification; //System: Press PAGE UP and PAGE DOWN to turn the crane
			[localize "STR_INTER_SHOWCONT3",Color_Yellow] call A3PL_Player_Notification; //System: Press HOME and END to move the boom up and down
			[localize "STR_INTER_SHOWCONT4",Color_Yellow] call A3PL_Player_Notification; //System: Press DELETE and INSERT to move the hook up and down
			[localize "STR_INTER_SHOWCONT5",Color_Yellow] call A3PL_Player_Notification; //System: Press , and . to rotate the hook around
			[localize "STR_INTER_SHOWCONT6",Color_Yellow] call A3PL_Player_Notification; //System: Press SPACE to pickup/drop a container
		},
		{(typeOf vehicle player) == "A3PL_MobileCrane"}
	],

	[
		localize "STR_INTER_PLACERC", //Place a roadcone
		{[] call A3PL_Placeables_PlaceCone;},
		{(typeOf (([] call A3PL_Lib_Attached) select 0)) == "A3PL_RoadCone_x10"}
	],
	//end of merge

	//taxi fair
	[
		localize "STR_INTER_SETUPTAXIFEE", //Setup taxi fare
		{[] call A3PL_JobTaxi_SetupFare;},
		{typeOf (vehicle player) == "A3PL_CVPI_Taxi"}
	],

	//Open medical system
	[
		localize "STR_INTER_OPENMED", //Open medical
		{[player] spawn A3PL_Medical_Open;},
		{true}
	],

	//Open inventory crafting system
	[
		"Combine Items", //Open inventory crafting
		{[] call A3PL_Combine_Open;},
		{true}
	],

	//hostage
	[
		localize "STR_INTER_TAKEPHOST", //Take person hostage
		{[cursorobject] spawn A3PL_Player_TakeHostage;},
		{isNil "A3PL_EnableHostage" && (handgunWeapon player != "") && (cursorobject IN allPlayers) && (player distance cursorobject < 2)&&(([cursorobject, player] call BIS_fnc_relativeDirTo) < 220)&&(([cursorobject, player] call BIS_fnc_relativeDirTo) > 130)}
	],

	[
		localize "STR_INTER_RELHOST", //Release hostage
		{A3PL_EnableHostage = false;},
		{!isNil "A3PL_EnableHostage"}
	],

	[
		localize "STR_INTER_POINTGFOR", //Point gun forward
		{A3PL_HostageMode = "shoot"},
		{!isNil "A3PL_EnableHostage" && A3PL_HostageMode == "hostage"}
	],

	[
		localize "STR_INTER_POINTGHOST", //Point gun at hostage
		{A3PL_HostageMode = "hostage"},
		{!isNil "A3PL_EnableHostage" && A3PL_HostageMode == "shoot"}
	],

	//end of hostage

	[
		localize "STR_INTER_SELLVEH", //Sell vehicle
		{[player_objintersect] call A3PL_Business_Sell;},
		{(player_objintersect isKindOf "All") && {(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))} && ((player getVariable "job") == "business")}
	],

	[
		localize "STR_INTER_BUYVEH", //Buy vehicle
		{[player_objintersect] call A3PL_Business_BuyItem;},
		{(player_objintersect isKindOf "All") && (!isNil {player_objintersect getVariable ["bitem",nil]})}
	],

	[
		localize "STR_INTER_PLANTSEED", //Plant seed
		{[] call A3PL_JobFarming_Plant;},
		{(player_itemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca","seed_sugar"]) && ((surfaceType getpos player) == "#cype_plowedfield")}
	],

	[
		localize "STR_INTER_SEARCHSEED", //Search for seeds
		{[] call A3PL_JobFarming_SearchSeeds;},
		{((surfaceType getpos player) == "#cype_plowedfield")}
	],
	/*
	[
		localize "STR_INTER_OPENFACTIONS", //Open faction setup
		{[(player getVariable ["faction","citizen"])] call A3PL_Government_FactionSetup},
		{(player getVariable ["faction","citizen"]) IN ["police","uscg","fifr"]}
	],
	*/
	[
		localize "STR_INTER_PROSPECTG", //Prospect ground
		{[] call A3PL_JobWildCat_ProspectOpen},
		{(vehicle player == player) && (!(animationState player IN ["a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","a3pl_handsuptokneel","A3PL_HandsupToKneel","A3PL_HandsupKneelGetCuffed","A3PL_Cuff","A3PL_HandsupKneelCuffed","A3PL_HandsupKneelKicked","A3PL_CuffKickDown","a3pl_idletohandsup","a3pl_kneeltohandsup","A3PL_HandsupKneel"]))&& ((surfaceType getpos player) IN ["#cype_plowedfield","#cype_grass","#cype_forest","#cype_soil","#cype_beach","#GtdMud","#GtdDirt","#cype_beach"])&& (!(isOnRoad player))}
	],

	[
		localize "STR_INTER_CHECKTANKC", //Check tanker content
		{[format ["System: There seems to be %1 gallons of petrol in this tanker",(cursorObject getVariable ["petrol",0])], Color_Green] call A3PL_Player_Notification;},
		{(typeOf cursorObject == "A3PL_Tanker_Trailer")}
	],

	[
		"Check Truck content", //Check tanker content
		{[format ["System: There seems to be %1 gallons of Kerosene in this truck",(cursorObject getVariable ["petrol",0])], Color_Green] call A3PL_Player_Notification;},
		{(typeOf cursorObject == "A3PL_Fuel_Van")}
	],


	[
		localize "STR_INTER_SHOWID", //Show ID
		{if(!([] call A3PL_Player_AntiSpam)) exitWith {}; [player] remoteExec ["A3PL_Hud_IDCard",cursorObject];},
		{isPlayer cursorObject && alive cursorObject && (player distance cursorObject < 4)}
	],

	[
		localize "STR_INTER_GRABID", //Grab ID
		{[cursorObject] spawn A3PL_Hud_IDCard;},
		{isPlayer cursorObject && alive cursorObject && (player distance cursorObject < 4) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && animationState cursorObject IN ["a3pl_handsuptokneel","a3pl_handsupkneelgetcuffed","a3pl_cuff","a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","a3pl_cuffkickdown","a3pl_idletohandsup","a3pl_kneeltohandsup","a3pl_handsuptokneel","a3pl_handsupkneel"]}
	],

	[
		localize "STR_INTER_SETNAMET", //Set Nametag
		{[(getPlayerUID cursorObject)] call A3PL_Player_OpenNametag;},
		{isPlayer cursorObject && (player distance cursorObject < 5)}
	],

	[
		localize "STR_INTER_JAILP", //Jail Player
		{[cursorObject] call A3PL_Police_StartJailPlayer},
		{isPlayer cursorObject && alive cursorObject && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && (player distance cursorObject < 4)}
	],

	/* [
		localize "STR_INTER_THROWPOP", //Throw popcorn
		{[] call A3PL_Items_ThrowPopcornClient;},
		{(player_itemclass == "popcornbucket" && (vehicle player == player))}
	], */

	[
		"Light a fire", //Throw popcorn
		{[] spawn A3PL_Fire_Matches;},
		{(player_itemclass == "matches" && (vehicle player == player))}
	],

	[
		localize "STR_INTER_SEARCHP", //Search Player
		{
			[cursorObject] call A3PL_Police_SearchPlayer;
		},
		{isPlayer cursorObject && alive cursorObject && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && (player distance cursorObject < 3)}
	],
	
	//Evidence_Locker
	[
		"Lockpick",
		{[] spawn A3RL_EvidenceLocker_Lockpick;},
		{((typeOf cursorObject) == "B_supplyCrate_F") && (cursorObject getVariable ["locked", true])}
	],
	
	[
		"Virtual Inventory",
		{[] spawn A3RL_EvidenceLocker_Open;},
		{((typeof cursorObject) == "B_supplyCrate_F") && (!(cursorObject getVariable ["locked", true]))}
	],
	
	[
		"Secure",
		{[] spawn A3RL_EvidenceLocker_Secure;},
		{((typeof cursorObject) == "B_supplyCrate_F") && (!(cursorObject getVariable ["locked", true])) && (player getVariable["job", "unemployed"] == "usms")}
	],

	[
		"Put on Blindfold",
		{[cursorObject] spawn A3RL_Blindfold;},
		{isPlayer cursorObject && alive cursorObject && (player distance cursorObject < 3) && Player_ItemClass == "headbag" && !(cursorObject getVariable ["A3RL_Blindfolded", false]) 
		&& (animationState cursorObject IN ["a3pl_idletohandsup", "a3pl_handsuptokneel", "amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon", "amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon", "unconscious"]
		|| cursorObject getVariable ["Zipped", true] || cursorObject getVariable ["Cuffed", true])}
	],

	[
		"Take Off Blindfold",
		{[cursorObject] spawn A3RL_Remove_Blindfold;},
		{isPlayer cursorObject && alive cursorObject && (player distance cursorObject < 3) && cursorObject getVariable ["A3RL_Blindfolded", false]}
	],

	[
		"Take Off Blindfold",
		{[] spawn A3RL_Remove_Blindfold_Receive;},
		{!(player getVariable ["Zipped", true]) && !(player getVariable ["Cuffed", true]) && player getVariable ["A3RL_Blindfolded", false]}
	],

	[
		localize "STR_INTER_SEIZEITEMS", //Seize Items
		{
			_items = nearestObjects [player,["groundWeaponHolder"],3];
			{
				deleteVehicle _x;
				{
					_classes = _x select 0;
					_amounts = _x select 1;
					{
						Evidence_Locker addItemCargoGlobal [_x, _amounts select _forEachIndex];
					} forEach _classes;
				} forEach [getWeaponCargo _x, getMagazineCargo _x, getItemCargo _x, getBackpackCargo _x];
			} forEach _items;
			
			_curArr = Evidence_Locker getVariable ["storage",[]];
			{
				private["_item", "_x", "_handled"];
				_handled = false;
				_item = _x;
				{
					private["_x"];
					if(_item getVariable ["Class", ""] == (_x select 0)) exitWith {
						_handled = true;
						_curArr set [_forEachIndex, [_x select 0, (_x select 1) + (_item getVariable ["amount",1])]]
					};
				} forEach _curArr;
				if(!_handled) then {_curArr pushBack [_item getVariable ["Class", ""], (_item getVariable ["amount",1])];};
				deleteVehicle _item;
			} forEach (nearestObjects [player,[] call A3RL_EvidenceLocker_SeizeAble,3]);
			Evidence_Locker setVariable ["storage",_curArr, true];
		},
		{((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && ((count (nearestObjects [player,["groundWeaponHolder"],3]) > 0) || (count (nearestObjects [player,[] call A3RL_EvidenceLocker_SeizeAble,3]) > 0)) }
	],

	[
		localize "STR_INTER_REPAIRTEROB", //Repair terrain object
		{
			[] call A3PL_JobRoadworker_RepairTerrain;
		},
		{((player getVariable ["job","unemployed"]) IN ["roadworker","Roadside_Service"]) && (vehicle player == player)}
	],

	[ 
		"Open Trunk", 
		{
			[vehicle player] call A3RL_VITrunk_Open;
		},
		{(vehicle player != player) && {!((vehicle player) getVariable ["locked", true])}}
	],

	[
		"Open Trunk",
		{
			[cursorObject] call A3RL_VITrunk_Open;

		},
		{(vehicle player == player) && {(simulationEnabled cursorObject)} && {!isNil "player_objintersect"} && {!(cursorObject getVariable ["locked", true])} && {cursorObject isKindOf "AllVehicles"}}
	],

	[
		localize "STR_INTER_MARKIMPPOL", //Unmark/Mark - impound (Police/FIFR)
		{
			[] call A3PL_Police_Impound;
		},
		{((player_nameintersect IN ["doorL","doorR","Door_LF","Door_LF2","Door_LF3","Door_LF4","Door_LF5","Door_LF6","Door_LB","Door_LB2","Door_LB3","Door_LB4","Door_LB5","Door_LB6","Door_RF","Door_RF2","Door_RF3","Door_RF4","Door_RF5","Door_RF6","Door_RB","Door_RB2","Door_RB3","Door_RB4","Door_RB5","Door_RB6"]) OR (player_objintersect isKindOf "Car") OR (player_objintersect isKindOf "Ship")) && ((player getVariable ["job","unemployed"]) IN ["police","fifr","uscg","usms"])&&(player distance cursorObject < 5) }
	],

	[
		localize "STR_INTER_IMPUSC", //Impound (USCG)
		{
			[] call A3PL_Police_Impound;
		},
		{(cursorObject isKindOf "Ship") AND ((player getvariable ["job","unemployed"]) == "uscg") && (player distance cursorObject < 5)}
	],

	[
		localize "STR_INTER_MARKFORIMP", //Unmark/Mark for impound
		{
			[] call A3PL_JobRoadWorker_ToggleMark;
		},
		{(player_objintersect isKindOf "Car") && (getPlayerUID player IN (player_objintersect getVariable ["keyAccess",[]])) && (!((typeOf player_objintersect) IN A3PL_Jobroadworker_MarkBypass)) && (player distance cursorObject < 5)}
	],

	[ //Lock Vehicle that you are inside of
		localize "STR_INTER_LOCKV", //Lock Vehicle
		{
			vehicle player setVariable ["locked",true,true];
			[localize "STR_INTER_LOCKVD", Color_Red] call A3PL_Player_Notification; //System: You locked the vehicle doors
		},
		{(vehicle player != player) && {(getPlayerUID player in (vehicle player getVariable ["keyAccess",[]]))} && {!(vehicle player getVariable ["locked",true])}}
	],

	[ //Lock Vehicle you're looking at
		localize "STR_INTER_LOCKV", //Lock Vehicle
		{
			player_objintersect setVariable ["locked",true,true];
			[localize "STR_INTER_LOCKVD", Color_Red] call A3PL_Player_Notification; //System: You locked the vehicle doors
			playSound3D ["A3PL_Cars\Common\Sounds\A3PL_Car_Lock.ogg", cursorObject, true, cursorObject, 3, 1, 30];
		},
		{(vehicle player == player) && {(simulationEnabled player_objintersect)} && {!isNil "player_objintersect"} && {(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))} && {!(player_objintersect getVariable ["locked",true])}}
	],

	[ //Unlock Vehicle that you are inside of
		localize "STR_INTER_UNLOCKV", //Unlock Vehicle
		{
			vehicle player setVariable ["locked",false,true];
			[localize "STR_INTER_UNLOCKVD", Color_Green] call A3PL_Player_Notification; //System: You unlocked the vehicle doors
		},
		{(vehicle player != player) && {(getPlayerUID player in (vehicle player getVariable ["keyAccess",[]]))} && {(vehicle player getVariable ["locked",true])}}
	],

	[ //Unlock Vehicle you're looking at
		localize "STR_INTER_UNLOCKV", //Unlock Vehicle
		{
			player_objintersect setVariable ["locked",false,true];
			[localize "STR_INTER_UNLOCKVD", Color_Green] call A3PL_Player_Notification; //System: You unlocked the vehicle doors
			playSound3D ["A3PL_Cars\Common\Sounds\A3PL_Car_Lock.ogg", cursorObject, true, cursorObject, 3, 1, 30];
		},
		{(vehicle player == player) && (simulationEnabled player_objintersect) && ((player distance player_objintersect) < 15) && ((getPlayerUID player) IN (player_objintersect getVariable ["keyAccess",[]])) && (player_objintersect getVariable ["locked",true])}
	],

	[ //for trailers
		localize "STR_INTER_ATTACHNB", //Attach nearest boat
		{
			[cursorObject] call A3PL_Vehicle_TrailerAttach;
		},
		{((vehicle player == player) && (cursorObject distance player < 5)) && {(simulationEnabled cursorObject)} && {(typeOf cursorObject == "A3PL_Small_Boat_Trailer")}}
	],

	[ //for trailers
		localize "STR_INTER_ATTACHNB", //Attach nearest boat
		{
			[cursorObject] call A3PL_Vehicle_BigTrailerAttach;
		},
		{((vehicle player == player) && (cursorObject distance player < 5)) && {(simulationEnabled cursorObject)} && {(typeOf cursorObject == "A3PL_Lowboy")}&& {(cursorObject animationSourcePhase "RBM_Supports" > 0.5)}}
	],

	[ //Unlock Vehicle you're looking at
		localize "STR_INTER_DETACHBOAT", //Detach boat
		{
			_Boat = ((attachedObjects player_objintersect) select 0);
			_Trailer = player_objintersect;
			[[_Boat],"Server_Vehicle_TrailerDetach",false,false] call bis_fnc_mp;
		},
		{((vehicle player == player) && (cursorObject distance player < 5))&& (!(((attachedObjects player_objintersect) select 0) getVariable ["locked",true]))}
	],

	[ //Unlock Vehicle you're looking at
		localize "STR_INTER_DETACHBOAT", //Detach boat
		{
			if (!(cursorObject isKindOf "Ship")) exitwith {};
			[[cursorObject],"Server_Vehicle_TrailerDetach",false,false] call bis_fnc_mp;
		},
		{((vehicle player == player) && (cursorObject distance player < 5)) && ({(typeOf (attachedTo cursorObject)) IN ["A3PL_Boat_Trailer","A3PL_Small_Boat_Trailer"]})&& (!(cursorObject getVariable ["locked",true]))}
	],

	[ //get in yacht
		localize "STR_INTER_CLIMBINYACHT", //Climb onto yacht
		{
			private ["_veh"];
			_veh = player_objintersect;
			if (!(_veh isKindOf "A3PL_Yacht")) exitwith {};
			player setpos (_veh modeltoworld [-1,-25,-5]);
		},
		{(vehicle player == player) && (player_objintersect isKindOf "A3PL_Yacht") && ((player distance (player_objintersect modeltoworld [-1,-25,-5])) < 10)}
	],

	[ //get in yacht
		"Climb onto RBM", //Climb onto RBM
		{
			private ["_veh"];
			_veh = cursorObject;
			if (!(_veh isKindOf "A3PL_RBM")) exitwith {};
			player setpos (_veh modeltoworld [0,-4.16406,0]);
		},
		{(vehicle player == player) && (cursorObject isKindOf "A3PL_RBM") && ((cursorObject distance player) < 10)}
	],

	[ //get in Cutter
		"Climb onto Cutter", //Climb onto Cutter
		{
			private ["_veh"];
			_veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter")) exitwith {};
			player setpos (_veh modeltoworld [0,-8,-9]);
		},
		{(vehicle player == player) && (cursorObject isKindOf "A3PL_Cutter") && ((cursorObject distance player) < 50)}
	],

	[ //get in Cutter
		"Enter as Captain", //Cutter driver seat
		{
			private ["_veh"];
			_veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter")) exitwith {};
			player moveInDriver _veh;
		},
		{(vehicle player == player) && (cursorObject isKindOf "A3PL_Cutter") && ((cursorObject distance player) < 10) && (!(cursorObject getVariable ["locked",true]))}
	],

	[ //get in Cutter
		"Enter as Passenger", //Cutter passanger seat
		{
			private ["_veh"];
			_veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter")) exitwith {};
			player moveInCargo _veh;
		},
		{(vehicle player == player) && (cursorObject isKindOf "A3PL_Cutter") && ((cursorObject distance player) < 10) && (!(cursorObject getVariable ["locked",true]))}
	],

	[ //get in Cutter
		"Enter as Gunner", //Cutter passanger seat
		{
			private ["_veh"];
			_veh = cursorObject;
			if (!(_veh isKindOf "A3PL_Cutter")) exitwith {};
			player moveInCommander _veh;
		},
		{(vehicle player == player) && (cursorObject isKindOf "A3PL_Cutter") && ((cursorObject distance player) < 10) && (!(cursorObject getVariable ["locked",true]))}
	],

	[
		localize "STR_INTER_INVENTORY", //Inventory
		{
			[] call A3PL_Inventory_Open;
		},
		{true}
	],

	//EMS
	[
		localize "STR_INTER_REVIVE", //Revive
		{[[],"A3PL_Medical_Revive",player_objintersect,false] call BIS_FNC_MP;},
		{(player_objintersect getVariable ["incapacitated",false]) && {player getVariable ["job","unemployed"] == "fifr"}}
	],

	[
		localize "STR_INTER_THROWBB", // Throw Bowling Ball
		{[(([] call A3PL_Lib_Attached) select 0)] call A3PL_Bowling_ThrowBall},
		{((typeOf (([] call A3PL_Lib_Attached) select 0)) == "A3PL_Ball")} // visible if true
	],

	[
		localize "STR_INTER_DROPBB", // Drop Bowling Ball
		{detach (([] call A3PL_Lib_Attached) select 0);}, // code to run
		{((typeOf (([] call A3PL_Lib_Attached) select 0)) == "A3PL_Ball")} // visible if true
	],

	//Furniture locking to prevent option to move it.
	[
		localize "STR_INTER_UNFREEZE", //(Un)Freeze
		{
			if(player_objintersect getVariable ["locked",true]) then {
				player_objintersect setVariable ["locked",false];
			} else {
				player_objintersect setVariable ["locked",true];
			};
		},
		{Player_NameIntersect == "furniture" && ((player_objintersect getVariable ["stock",-1]) < 0)}
	],

	[
		localize "STR_INTER_CUFFP", // Cuff person
		{
			private ["_obj"];
			_obj = call A3PL_Intersect_cursorObject;
			if (!(Player_NameIntersect IN ["leftforearm","rightforearm"])) exitwith {};

			if (Player_ItemClass == "handcuffs") then
			{
				[_obj] call A3PL_Police_Cuff;
			} else
			{
				[localize "STR_INTER_CUFFPD", Color_Red] call A3PL_Player_Notification; //You need handcuffs to do this!
			};
		}, // code to run
		{(((Player_NameIntersect == "leftforearm") OR (Player_NameIntersect == "rightforearm")) && (typeOf (call A3PL_Intersect_cursorObject) == "C_man_1"))} // visible if true
	],

	[
		localize "STR_INTER_UNCUFFP", // Uncuff person
		{
			private ["_obj"];
			_obj = call A3PL_Intersect_cursorObject;
			if (!(Player_NameIntersect IN ["leftforearm","rightforearm"])) exitwith {};

			if (Player_ItemClass != "") then
			{
				[localize "STR_INTER_UNCUFFPD", Color_Red] call A3PL_Player_Notification; //You have something in your hands and can't perform this action!
			} else
			{
				[_obj] call A3PL_Police_Uncuff;
			};
		}, // code to run
		{(((Player_NameIntersect == "leftforearm") OR (Player_NameIntersect == "rightforearm")) && (typeOf (call A3PL_Intersect_cursorObject) == "C_man_1") && ((animationState (call A3PL_Intersect_cursorObject)) IN ["a3pl_handsupkneelcuffed","a3pl_handsupkickeddown"]))} // visible if true
	],

	[
		localize "STR_INTER_KICKPDOWN", // Kick person down
		{
			private ["_obj"];
			_obj = call A3PL_Intersect_cursorObject;
			if (!(Player_NameIntersect IN ["spine3"])) exitwith {};

			[_obj] call A3PL_Police_CuffKick;
		}, // code to run
		{((Player_NameIntersect == "spine3") && (typeOf (call A3PL_Intersect_cursorObject) == "C_man_1") && ((animationState (call A3PL_Intersect_cursorObject)) IN ["a3pl_handsupkneelcuffed"]))} // visible if true
	],

	[
		localize "STR_INTER_SURRENDER", //Surrender
		{
			[player,true] call A3PL_Police_Surrender;
		}, // code to run
		{(((animationState player) IN ["amovpercmstpsnonwnondnon","amovpercmrunsnonwnondf","amovpercmrunsnonwnondb"]) && (vehicle player == player))} // visible if true
	],

	[
		localize "STR_INTER_ENDSURRENDER", // End surrender
		{
			[player,true] call A3PL_Police_Surrender;
		}, // code to run
		{((animationState player IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (vehicle player == player))} // visible if true
	],

	[
		localize "STR_INTER_KNEELDOWN", // Kneel down
		{
			[player,false] call A3PL_Police_Surrender;
		}, // code to run
		{((animationState player IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (vehicle player == player))} // visible if true
	],

	[
		localize "STR_INTER_STANDUP", // Stand up
		{
			[player,true] call A3PL_Police_Surrender;
		}, // code to run
		{((animationState player IN ["a3pl_handsuptokneel","a3pl_kneeltohandsup"]) && (vehicle player == player))} // visible if true
	],

	[
		localize "STR_INTER_STOPDRGING", // Stop dragging
		{
			[call A3PL_Intersect_cursorObject] call A3PL_Police_Drag;
		}, // code to run
		{(((call A3PL_Intersect_cursorObject) IN (attachedobjects player)) && (vehicle player == player) && (isPlayer(call A3PL_Intersect_cursorObject)))} // visible if true
	],

	[
		localize "STR_INTER_DETAINSUSINVEH", // Detain suspect in vehicle
		{
			if (!((call A3PL_Intersect_cursorObject) isKindOf "Car")) exitwith {};
			[call A3PL_Intersect_cursorObject] call A3PL_Police_Detain;
		}, // code to run
		{(((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && ((call A3PL_Intersect_cursorObject) isKindOf "Car") && (((player distance player_objintersect) < 6)))} // visible if true
	],

	[
		localize "STR_INTER_EJECTALLP", // Eject all passengers
		{
			[player_objintersect] call A3PL_Police_unDetain;
		}, // code to run
		{(((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && ((player_objintersect) isKindOf "Car") && (((player distance player_objintersect) < 6)))} // visible if true
	],

	[
		localize "STR_INTER_EATITEM", // Eat Item
		{[] call A3PL_Items_Food;}, // code to run
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Items_Food')} // visible if true
	],

	[
		localize "STR_INTER_DRINKITEM", // Drink Item
		{[] spawn A3PL_Items_Thirst;}, // code to run
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Items_Thirst')} // visible if true
	],

	[
		localize "STR_INTER_USEDRUGS", // Use drugs
		{[Player_ItemClass,1] call A3PL_Drugs_Use; }, // code to run
		{(([Player_ItemClass, 'fnc'] call A3PL_Config_GetItem) isEqualTo 'A3PL_Drugs_Use')} // visible if true
	],

	[
		localize "STR_INTER_PUTITEMB", // Put Item Back
		{[] call A3PL_Inventory_PutBack;},
		{((isNull Player_Item) isEqualTo false) && (!(player_itemClass IN ["ticket"]))} // visible if true
	],

	[
		localize "STR_INTER_DESTROYT", // Destroy ticket
		{[player_item] call A3PL_Inventory_Clear;},
		{((isNull Player_Item) isEqualTo false) && (player_itemClass IN ["ticket"])} // visible if true
	],

	[
		localize "STR_INTER_WRITET", //Write ticket
		{[] call A3PL_Police_OpenTicketMenu;},
		{(vehicle player == player) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms","doj"]) && (!(player_itemclass == "ticket"))}
	],

	[
		localize "STR_INTER_THROWIT", //Throw Item
		{[] call A3PL_Inventory_Throw;},
		{((isNull Player_Item) isEqualTo false) && ([Player_ItemClass, 'canDrop'] call A3PL_Config_GetItem)} // visible if true
	],

	[
		localize "STR_INTER_DROPITEM", //Drop Item
		{[] call A3PL_Inventory_Drop;}, // code to run
		{([Player_ItemClass, 'canDrop'] call A3PL_Config_GetItem)} // visible if true
	],

	[
		localize "STR_INTER_PICKUPITEM", // Pickup Item
		{[player_objintersect] call A3PL_Inventory_Pickup;}, // code to run
		{(((isNull Player_Item) isEqualTo true) && ((call A3PL_Intersect_cursorObject) in (server getVariable 'Server_DroppedItems')))} // visible if true
	],

	[
		localize "STR_INTER_EXITMOTORB", // Exit Motorboat
		{
			private ["_veh"];
			_veh = vehicle player;
			if (_veh getVariable ["locked",true]) exitwith {[localize "STR_INTER_EXITMOTORBD",Color_Red] call A3PL_Player_Notification;}; //System: Unable to exit, this vehicle is locked
			_veh lock 1;
			player action ["getOut",_veh];
			_veh lock 2;

		}, // code to run
		{((vehicle player) isKindOf "Ship")} // visible if true
	],

	[
		localize "STR_INTER_PASSENGERMB", //Passenger Motorboat
		{
			private ["_veh"];
			_veh = cursorObject;
			if (_veh getVariable ["locked",true]) exitwith {[localize "STR_INTER_UNABLEENT",Color_Red] call A3PL_Player_Notification;}; //System: Unable to enter, this vehicle is locked
			_veh lock 1;
			//player action ["getInCargo", _veh];
			player moveInCargo _veh;
			_veh lock 2;
		}, // code to run
		{(cursorobject isKindOf "Ship") && (player distance cursorObject < 5)} // visible if true
	],

	[
		localize "STR_INTER_ENTERMB", //Enter Motorboat
		{
			private ["_veh"];
			_veh = cursorObject;
			if (_veh getVariable ["locked",true]) exitwith {[localize "STR_INTER_UNABLEENT",Color_Red] call A3PL_Player_Notification;}; //System: Unable to enter, this vehicle is locked
			_veh lock 1;
			player action ["getInDriver", _veh];
			_veh lock 2;
		}, // code to run
		{(cursorobject isKindOf "Ship") && (player distance cursorObject < 5)} // visible if true
	],

	[
		localize "STR_INTER_TOGGLESL", //Toggle Searchlight
		{
			_veh = vehicle player;
			if (_veh animationSourcePhase "Spotlight" < 0.5) then
			{
				_veh animateSource ["Spotlight",1];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOn",_veh];};

			} else
			{
				_veh animateSource ["Spotlight",0];
				if (_veh animationSourcePhase "Head_Lights" < 0.5) then{player action ["lightOff",_veh];};
			};

		}, // code to run
		{(typeOf (vehicle player) == "A3PL_Jayhawk") && (player == ((vehicle player) turretUnit [0]))} // visible if true
	],

	[
		localize "STR_INTER_TOGGLERB", //Toggle Rescue Basket
		{
			private ["_veh","_rope"];
			_veh = vehicle player;
			_basket = _veh getVariable "basket";
			if (((count (crew _basket)) > 0) && (_veh animationPhase "Basket" > 0.5)) exitwith {[localize "STR_INTER_TOGGLERBD",Color_Red] call A3PL_Player_Notification;}; //System: You can't retrieve the basket with someone in it
			if (_basket isEqualTo objNull) then {[] call A3PL_Create_RescueBasket;};
			if (count ropes _veh > 0) exitwith
			{
				{
					ropeDestroy _x;
				} foreach (ropes _veh);
				_basket attachTo [_veh, [0, 999999, 0] ];//[-0.2, -0.37, 1.9] I've added the basket to the model
				_veh animate ["Basket",0];
			};
			[(driver _veh),_veh,_basket] remoteExec ["Server_Vehicle_AtegoHandle", 2];
			detach _basket;
			_veh animate ["Basket",1];
			_basket setpos (_veh modelToWorld [4,2,-1]);
			_rope = ropeCreate [_veh, "rope", _basket, [-0.3, 0.2, 0.25], 3];
		}, // code to run
		{((typeOf (vehicle player) == "A3PL_Jayhawk") && ((player == ((vehicle player) turretUnit [0])) OR (player == ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player))) && ((speed vehicle player) < 30))} // visible if true
	],

	[
		localize "STR_INTER_EXITINTOHEIL", // Exit Into Heil
		{
			[] spawn {
				private ["_veh"];
				_veh = vehicle player;
				_heli = vehicle player getVariable "vehicle";
				_crew = crew _heli;
				_available = true;
				{if ((_heli getCargoIndex _x) == 6) exitwith {_available = false;};} foreach (crew _heli);
				if (!_available) exitwith {_veh lock 0; unassignVehicle player;player leaveVehicle _veh;player action ["GetOut", _veh]; sleep 1.5;_veh lock 0; player moveInCargo _heli; [localize "STR_INTER_EXITINTOHEILD",Color_Red] call A3PL_Player_Notification;}; //System: Can't get into heil somebody is on the stretcher
				_veh lock 0;
				unassignVehicle player;
				player leaveVehicle _veh;
				player action ["GetOut", _veh];
				sleep 1.5;
				_veh lock 0;
				player moveInCargo [_heli, 6];
			};
		}, // code to run
		{(("A3PL_rescueBasket" == (typeOf (vehicle player))))} // visible if true
	],

	[
		localize "STR_INTER_INCREASERL", // Increase Rope Length
		{
			private ["_veh"];
			_veh = vehicle player;
			if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
			if (count ropes _veh < 1) exitwith {};
			ropeUnwind [(ropes _veh) select 0,2,(ropeLength ((ropes _veh) select 0)) + 5];

		}, // code to run
		{((typeOf (vehicle player) == "A3PL_Jayhawk") && (local vehicle player) && ((player == ((vehicle player) turretUnit [0])) OR (player == ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player))))} // visible if true
	],

	[
		localize "STR_INTER_DECREASERL", // Decrease Rope Length
		{
			private ["_veh"];
			_veh = vehicle player;
			if (typeOf _veh != "A3PL_Jayhawk") exitwith {};
			if (count ropes _veh < 1) exitwith {};
			ropeUnwind [(ropes _veh) select 0,2,(ropeLength ((ropes _veh) select 0)) - 5];

		}, // code to run
		{((typeOf (vehicle player) == "A3PL_Jayhawk") && (local vehicle player) && ((player == ((vehicle player) turretUnit [0])) OR (player == ((vehicle player) turretUnit [1])) OR (player == (driver vehicle player))))}
 // visible if true
	],


	[
		localize "STR_INTER_TOGGLEAH", // Toggle Autohover
		{
			private ["_veh"];
			_veh = vehicle player;
			if (isAutoHoverOn _veh) then
			{
				player action ["autoHoverCancel", _veh];
			} else
			{
				player action ["autoHover", _veh];
			};

		}, // code to run
		{(((vehicle player) isKindOf "Helicopter")) && (((player == (vehicle player turretUnit [0]))) OR (player == (driver vehicle player)))}
	],

	//transponders
	[
		localize "STR_INTER_USETRANS", //Use transponder
		{
			[] call A3PL_ATC_Transponder;
		},
		{(((vehicle player) isKindOf "Air")) && (((player == (vehicle player turretUnit [0]))) OR (player == (driver vehicle player)))}
	],

	[
		localize "STR_INTER_TOGGLEC", //Toggle Control
		{
			private ["_veh"];
			_veh = vehicle player;
			if (!isCopilotEnabled _veh) then
			{
				_veh enableCopilot true;
				player action ["UnlockVehicleControl", _veh];
			}
			else
			{
				_veh enableCopilot false;
				player action ["SuspendVehicleControl", _veh];
				player action ["LockVehicleControl", _veh];
			};
		},
		{(((vehicle player) isKindOf "Air") && (player == (driver vehicle player)))}
	],

	[
		localize "STR_INTER_TAKEC", //Take Control
		{
			private ["_veh"];
			_veh = vehicle player;
			player action ["TakeVehicleControl", _veh];
		},
		{(((vehicle player) isKindOf "Air") && (player == (vehicle player turretUnit [0]))&& (isCopilotEnabled vehicle player))}
	],

	[
		localize "STR_INTER_RELEASEC", //Release Control
		{
			private ["_veh"];
			_veh = vehicle player;
			player action ["SuspendVehicleControl", _veh];
		},
		{(((vehicle player) isKindOf "Air") && (player == (vehicle player turretUnit [0]))&& (isCopilotEnabled vehicle player))}
	],

	//atc job
	[
		localize "STR_INTER_OPENRADARS", //Open radar screen
		{
			[] spawn A3PL_ATC_RadarStart;
		},
		{(player getVariable ["job","unemployed"] == "faa")}
	],

	//goose specific
	[
		localize "STR_INTER_RESETPLANEV", //Reset plane velocity
		{

			_veh = vehicle player;
			_veh setVelocity [0,0,0];
		},
		{(local (vehicle player)) && ((vehicle player) isKindOf "Plane") && ((speed vehicle player) < 10)}
	],

	[
		localize "STR_INTER_EXITVEH", //Exit vehicle
		{
			if ((speed vehicle player) < 1) then
			{
				player action ["GetOut",vehicle player];
				[]spawn {if (player getVariable ["Cuffed",true]) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[[player,"a3pl_handsupkneelcuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;};};
			} else
			{
				player action ["eject", vehicle player];
				[]spawn {if (player getVariable ["Cuffed",true]) then {sleep 1.5;player setVelocityModelSpace [0,3,1];[[player,"a3pl_handsupkneelcuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;};};
			};
		},
		{((vehicle player) != player) && (!(vehicle player getVariable ["locked",true]))}
	],

	[
		localize "STR_INTER_PPFOR", // Push plane forward
		{
			_veh = vehicle player;
			_vel = velocity _veh;
			_dir = direction _veh;
			_speed = 5;
			if(_veh getHit "hitengine" == 1) exitWith {["System: You cannot push a plane with a broken engine!",Color_Red] call A3PL_Player_Notification;};
			_veh setVelocity [
				(_vel select 0) + (sin _dir * _speed),
				(_vel select 1) + (cos _dir * _speed),
				(_vel select 2)
			];
		}, // code to run
		{((vehicle player) isKindOf "Plane") && (local (vehicle player))} // visible if true
	],

	[
		localize "STR_INTER_PBPLANE", // Push-back plane
		{
			_veh = vehicle player;
			_vel = velocity _veh;
			_dir = direction _veh;
			_speed = -5;
			if(_veh getHit "hitengine" == 1) exitWith {["System: You cannot push a plane with a broken engine!",Color_Red] call A3PL_Player_Notification;};
			_veh setVelocity [
				(_vel select 0) + (sin _dir * _speed),
				(_vel select 1) + (cos _dir * _speed),
				(_vel select 2)
			];
		}, // code to run
		{((vehicle player) isKindOf "Plane") && (local (vehicle player))} // visible if true
	],
	[
		localize "STR_INTER_DEPLOYPAR", //Deploy Parachute
		{
			player action ["openParachute"];
		},
		{((backpack player) isKindOf "B_Parachute")}
	],
	//FD Ladder
	//This also calls our LadderHeavyLoop!
	[
		localize "STR_INTER_SWITCHCON", //Switch Controls
		{
			private ["_veh","_turretPos","_newTurretPos"];
			_veh = vehicle player;
			_turretPos = call A3PL_Lib_ReturnTurret;
			if (_turretPos == -1) exitwith {};
			if (_turretPos == 0) then { _newTurretPos = 1; } else {_newTurretPos = 0;};
			_veh lock 0;
			player action ["moveToTurret", _veh, [_newTurretPos]];
			if (_newTurretPos == 1) then {[_veh] spawn A3PL_FD_LadderHeavyLoop};
			_veh lock 2;
		},
		{(call A3PL_Lib_ReturnTurret IN [0,1]) && (typeOf vehicle player IN ["A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Ladder"]) && !((vehicle player) getVariable ["locked",true])}
	],

	//FD INTERACTIONS
	[
		localize "STR_INTER_DEPLOYFH", //Deploy Fire Hose
		{
			[30] call A3PL_FD_DeployHose;
		}, // code to run
		{player_ItemClass == "FD_Hose"} // visible if true
	],

	[
		localize "STR_INTER_DROPHOSEA", //Drop Hose Adapter
		{
			[(call A3PL_Lib_AttachedFirst)] call A3PL_FD_DropHose;
		},
		{(typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2","A3PL_GasHose"]}
	],
	/*
	[
		localize "STR_INTER_SETNPRES", //Set nozzle pressure
		{
			[] call A3PL_FD_ChangeHosePressure;
		},
		{(typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"] && (currentWeapon player == "A3PL_High_Pressure")}
	],
	*/
	//Put mask on
	[
		localize "STR_INTER_PUTMASKON", //Put mask on
		{
			[] call A3PL_FD_MaskOn;
		},
		{player_itemClass == "fd_mask"}
	],

	[
		localize "STR_INTER_PUTMASKOFF", //Take off mask
		{
			[] call A3PL_FD_MaskOff;
		},
		{goggles player == "A3PL_FD_Mask"}
	],

	[
		localize "STR_INTER_CLEANMASK", //Clean mask
		{
			[] call A3PL_FD_SwipeMask;
		},
		{goggles player == "A3PL_FD_Mask"}
	],

	[
		"Deploy Gas Hose", //Deploy Gas Hose
		{
			[50] call A3PL_FD_GasDeployHose;
		}, // code to run
		{(player_ItemClass == "FD_Hose")&&(player getVariable ["job","unemployed"] == "oil")} // visible if true
	],

	//Sand gathering
	[
		localize "STR_INTER_DIGGROUND", //Dig ground
		{
			[] spawn A3PL_Resources_StartDigging;
		},
		{currentWeapon player == "A3PL_Shovel" && (vehicle player == player)&& ((surfaceType getpos player) IN ["#cype_beach"])}
	],

	[
		localize "STR_INTER_HIGHBEAM", //High beam
		{
			_veh = vehicle player;
			if (_veh animationSourcePhase "High_Beam" < 0.5) then
			{
				_veh animateSource ["High_Beam",1];
			} else
			{
				_veh animateSource ["High_Beam",0];
			};
		},
		{(vehicle player) isKindOf "Car"}
	],

	[
		localize "STR_INTER_RESETLOCKF", //Reset lock/fast
		{
			_veh = vehicle player;
			if (player == driver _veh) then
			{
				_veh setVariable ["lockfast",nil,false];
				_veh setVariable ["locktarget",nil,false];
				[_veh,"lockfast",0] call A3PL_Police_RadarSet;
				[_veh,"locktarget",0] call A3PL_Police_RadarSet;
			} else
			{
				_veh setVariable ["lockfast",nil,true];
				_veh setVariable ["locktarget",nil,true];
				[_veh,"lockfast",0] call A3PL_Police_RadarSet;
				[_veh,"locktarget",0] call A3PL_Police_RadarSet;
			};
		},
		{(typeOf vehicle player IN ["A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_CVPI_PD_Slicktop","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD"])}
	],

	//bank
	[
		localize "STR_INTER_CHECKBPMONEY", //Check backpack money
		{
			[] call A3PL_BHeist_CheckCash;
		},
		{backpack player == "A3PL_Backpack_Money"}
	],

	//housing
	[
		localize "STR_INTER_SPAWNSTORAGEB", //Spawn storage box
		{
			private ["_house"];
			if(!([] call A3PL_Player_AntiSpam)) exitWith {};
			_house = nearestObjects [player, ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed1","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4"], 10];
			if (count _house < 1) exitwith {[localize "STR_INTER_FINDHOUSEN",Color_Red] call A3PL_Player_Notification;}; //System: Couldn't find house nearby, report this bug
			_house = _house select 0;
			[player,_house] remoteExec ["Server_Housing_LoadBox", 2];
		},
		{(player distance (player getVariable ["house",objNull]) < 8)}
	],

	[
		localize "STR_INTER_STORESTORAGEB", //Store storage box
		{
			private ["_house","_box"];
			if(!([] call A3PL_Player_AntiSpam)) exitWith {};

			_box = nearestObjects [player, ["Box_GEN_Equip_F"], 10];
			if (count _box < 1) exitwith {[localize "STR_INTER_FINDSTORAGEN",Color_Red] call A3PL_Player_Notification;}; //System: Couldn't find the storage nearby, report this bug
			_box = _box select 0;
			_house = _box getVariable ["house", objNull];
			if(isNull _house) exitWith {["Error storing box, Please report this.",Color_Red] call A3PL_Player_Notification;};
			[_house,_box] remoteExec ["Server_Housing_SaveBox", 2];
		},
		{(player distance (nearestObject [player, "Box_GEN_Equip_F"]) < 5)}
	],

	//greenhouses
	[
		localize "STR_INTER_RENTGH", //Rent ($350)
		{
			[cursorobject] call A3PL_JobFarming_BuyGreenhouse;
		},
		{(typeOf cursorobject == "Land_A3PL_GreenHouse") && ((player distance cursorobject) < 4.3)}
	],
	
	// Gather Mushrooms
	[
		"Gather", 
		{
			[] spawn A3RL_Mushroom_Gather;
		},
		{player inArea "mushroom_zone"}
	],

	[
		localize"STR_INTSECT_REPVEH", //Repair Vehicle
		{
			private ["_intersect"];
			_intersect = player_objintersect;
			if (isNull _intersect) exitwith {};
			[_intersect] call A3PL_Vehicle_Repair;
		},
		{(player_ItemClass == "repairwrench") && (vehicle player == player)&& (player distance cursorObject < 5)}
	],

	[
		"Toggle Anchor", //Toggle Anchor
		{
			private ["_veh"];
			_veh = cursorObject;
			[_veh] spawn A3PL_Vehicle_Anchor;
		}, // code to run
		{((typeOf cursorObject) IN ["A3PL_Motorboat","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_RHIB","A3PL_Yacht","A3PL_Yacht_Pirate","A3PL_RBM","A3PL_Container_Ship"]) && ((player distance cursorObject) < 15) && (!(cursorObject getVariable ["locked",true]))&& ((speed cursorObject) < 5)} // visible if true
	],

	[
		"Toggle Anchor", //Toggle Anchor
		{
			private ["_veh"];
			_veh = vehicle player;
			[_veh] spawn A3PL_Vehicle_Anchor;
		}, // code to run
		{((typeOf vehicle player) IN ["A3PL_Motorboat","A3PL_Motorboat_Rescue","A3PL_Motorboat_Police","A3PL_RHIB","A3PL_Yacht","A3PL_Yacht_Pirate","A3PL_RBM","A3PL_Container_Ship"]) && (!(vehicle player getVariable ["locked",true]))&& ((speed vehicle player) < 5)} // visible if true
	],

	[
		"Tie down helicopter", //Tie helicopter down
		{
			private ["_veh"];
			_veh = cursorObject;
			[_veh] call A3PL_Vehicle_SecureHelicopter;
		}, // code to run
		{((typeOf cursorObject) IN ["A3PL_Cutter"]) && ((speed vehicle player) < 1) && ((player distance cursorObject) < 15)} // visible if true
	],

	[
		"Untie helicopter", //Tie helicopter down
		{
			private ["_veh"];
			_veh = cursorObject;
			[_veh] call A3PL_Vehicle_UnsecureHelicopter
		}, // code to run
		{((typeOf cursorObject) IN ["A3PL_Cutter"]) && ((speed vehicle player) < 1) && ((player distance cursorObject) < 15)} // visible if true
	],

	[
		"Toggle Anchor",
		{
			private ["_veh"];
			_veh = cursorObject;
			[_veh] call A3PL_Vehicle_DisableSimulation;
		},
		{((typeOf cursorObject) IN ["A3PL_Cutter"]) && ((player distance cursorObject) < 30) && (!(cursorObject getVariable ["locked",true])) && ((speed cursorObject) < 4)} // visible if true
	],

	[
		"Knockout",
		{
			[] remoteExec ["A3RL_KnockedOut", cursorObject];
			player switchMove "AwopPercMstpSgthWrflDnon_End2";
		},
		{isPlayer cursorObject && alive cursorObject && {player distance cursorObject < 3} && {currentWeapon player != ""} && {!(animationState cursorObject IN["incapacitated"])}} 

	]

];

publicVariable "A3PL_Interaction_Options";
