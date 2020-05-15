/*
// Enable drugs system
// Types of drugs in array,If passed out or not
player setvariable ["drugs_array",[[["alcohol",0],["cocaine",0],["shrooms",0],['weed_5g',0],false],true];
player getvariable "drugs_array";


// ["shrooms",10] spawn A3PL_Drugs_Add;



*/

["A3PL_Drugs_Use_Old",
{
	private ["_item"];
	_item = param [0,""];
	switch (_item) do
	{
		case ("beer"): 
		{
			if (!isNil "Player_IsDrinking") exitwith {["System: You are already drinking something",Color_Red] call A3PL_Player_Notification;};
			Player_IsDrinking = true;
			[_item,-1] call A3PL_Inventory_Add;
			[] spawn
			{
				player playAction "Gesture_drink";
				Player_Item attachTo [player, [-0.03,0,0.1], 'LeftHand'];
				Player_Item setVectorDirAndUp [[0,0,1],[1,0,0]];
				sleep 3;
				Player_Item setVectorDirAndUp [[0,-1,0],[1,0,0]];
				sleep 3;
				Player_Item setVectorDirAndUp [[0,0,1],[1,0,0]];
				sleep 4.5;
				[false] call A3PL_Inventory_PutBack;
				Player_IsDrinking = nil;
				["alcohol",3] call A3PL_Drugs_Add; 
				
				//decrease some thirst
				Player_Thirst = Player_Thirst + 15;
				[] call A3PL_Lib_VerifyThirst;
				profileNamespace setVariable ["player_thirst",Player_Thirst];
				//Reset the warning variables for drinking
				if (Player_Thirst > 50) then { A3PL_ThirstWarning1 = Nil; };	
				if (Player_Thirst > 20) then { A3PL_ThirstWarning2 = Nil; };
				if (Player_Thirst > 10) then { A3PL_ThirstWarning3 = Nil; };				
			};
		};
		case ("beer_gold"): 
		{
			if (!isNil "Player_IsDrinking") exitwith {["System: You are already drinking something",Color_Red] call A3PL_Player_Notification;};
			Player_IsDrinking = true;
			[_item,-1] call A3PL_Inventory_Add;
			[] spawn
			{
				player playAction "Gesture_drink";
				Player_Item attachTo [player, [-0.03,0,0.1], 'LeftHand'];
				Player_Item setVectorDirAndUp [[0,0,1],[1,0,0]];
				sleep 3;
				Player_Item setVectorDirAndUp [[0,-1,0],[1,0,0]];
				sleep 3;
				Player_Item setVectorDirAndUp [[0,0,1],[1,0,0]];
				sleep 4.5;
				[false] call A3PL_Inventory_PutBack;
				Player_IsDrinking = nil;
				["alcohol",6] call A3PL_Drugs_Add; 
				
				//decrease some thirst
				Player_Thirst = Player_Thirst + 15;
				[] call A3PL_Lib_VerifyThirst;
				profileNamespace setVariable ["player_thirst",Player_Thirst];
				//Reset the warning variables for drinking
				if (Player_Thirst > 50) then { A3PL_ThirstWarning1 = Nil; };	
				if (Player_Thirst > 20) then { A3PL_ThirstWarning2 = Nil; };
				if (Player_Thirst > 10) then { A3PL_ThirstWarning3 = Nil; };				
			};			
		};
		case ("cocaine"): {["cocaine",10] call A3PL_Drugs_Add; [false] call A3PL_Inventory_PutBack; [_item,-1] call A3PL_Inventory_Add;};
		case ("shrooms"): {["shrooms",5] call A3PL_Drugs_Add; [false] call A3PL_Inventory_PutBack; [_item,-1] call A3PL_Inventory_Add;};
		case ("shrooms"): {["shrooms",5] call A3PL_Drugs_Add; [false] call A3PL_Inventory_PutBack; [_item,-1] call A3PL_Inventory_Add;};
	};
}] call Server_Setup_Compile;

// every 60 seconds
["A3PL_Drugs_Loop",
{
	private ["_drugsArray","_consumption"];
	_drugsarray = player getvariable ["drugs_array", [[["alcohol",0],["cocaine",0],["shrooms",0]],false]];
	_consumption = _this select 0; // If TRUE, doesn't reduce effect. only FALSE in the loop.
	{
		//Ignore the entire script if the drug is set to 0.
		if (_x select 1 != 0) then {
			switch (_x select 0) do {
			case "alcohol": { 
				//person had too much alcohol, time for some keks.
				if (_x select 1 > 100) then {
					((_drugsarray select 0) select _forEachIndex) set [1,100]; //Set to 100
					//[player,"torso","alcohol_poisoning"] call A3PL_Medical_ApplyWound; THIS IS NOT ENABLED, CHECK ABCDEFGHIJKLMN
				};
				//Give the effect to the person
					resetCamShake;
					enableCamShake true;
					addCamShake [((_x select 1)*0.5), 100, 2];
					
				// removes X amount of the variable to reduce the effect if the loop is ran.
				if (!_consumption) then {((_drugsarray select 0) select _forEachIndex) set [1,((_x select 1)-2)];};
				
				//Remove all the effects
				if (_x select 1 <= 0) exitwith {
					((_drugsarray select 0) select _forEachIndex) set [1,0]; //Set to 0
					resetCamShake;
				};
			};
			case "cocaine": { 
				//person had too much cocaine, time for some keks.
				if (_x select 1 > 100) then {
					((_drugsarray select 0) select _forEachIndex) set [1,100]; //Set to 100
				};
				//Check if person has less than 70% for running speed
				if (_x select 1 < 60) then {  player setAnimSpeedCoef ((0.40/60*(_x select 1))+1)} else {player setAnimSpeedCoef 1.4;};
				"filmGrain" ppEffectEnable true; 
				"filmGrain" ppEffectAdjust [(0.50/100*(_x select 1)), -1, 0.5, (-0.5+(0.5/100*(_x select 1))), 2, true]; 
				"filmGrain" ppEffectCommit 1;

				//Chance of screen shaking 1/20 every 60 sec if person didn't use alcohol.
				if ((floor random 20 == 6) && (_drugsarray select 0 select 0 select 1 == 0)) then {enableCamShake true; addCamShake [60, 5, 500];};
				
				// removes X amount of the variable to reduce the effect if the loop is ran.
				if (!_consumption) then {((_drugsarray select 0) select _forEachIndex) set [1,((_x select 1)-2)];};
				
				//Remove all the effects
				if (_x select 1 <= 0) exitwith {
					((_drugsarray select 0) select _forEachIndex) set [1,0]; //Set to 0
					player setAnimSpeedCoef 1;
					"filmGrain" ppEffectEnable false; 	
				};
			};
			case "shrooms": { 
				//person had too much cocaine, time for some keks.
				if (_x select 1 > 100) then {
					((_drugsarray select 0) select _forEachIndex) set [1,100]; //Set to 100
					//[player,"torso","shrooms_poisoning"] call A3PL_Medical_ApplyWound; THIS IS NOT ENABLED, CHECK ABCDEFGHIJKLMN
				};
				"colorCorrections" ppEffectEnable true;
				"colorCorrections" ppEffectAdjust [0.5, 0.5, 0, [(random 10),(random 10),(random 10),0.2], [1,1,5,2], [(random 5),(random 5),(random 5),(random 5)]]; 
				"colorCorrections" ppEffectCommit 40;
				player setstamina 100;
				if (_x select 1 < 70) then {  player setAnimSpeedCoef ((0.20/60*(_x select 1))+1)} else {player setAnimSpeedCoef 1.2;};

								
				//Chance on a random explotion
				if (round random (300/(_x select 1)) == 1) then {
					_fscriptedCharge = "DemoCharge_Remote_Ammo_Scripted" createVehicleLocal [(getpos player select 0),(getpos player select 1),30];
					_fscriptedCharge setdammage 1;
				
				if (round random (500/(_x select 1)) == 1) then {
					_randommodels = [
						"Land_Cargo20_blue_F",
						"Land_Cargo20_brick_red_F",
						"Land_LuggageHeap_05_F",
						"Land_Device_disassembled_F",
						"ArrowDesk_R_F",
						"Land_Scrap_MRAP_01_F",
						"WaterPump_01_forest_F",
						"Land_PressureWasher_01_F",
						"WaterPump_01_sand_F",
						"Land_AirIntakePlug_03_F",
						"Land_WoodenCrate_01_stack_x5_F",
						"Land_WoodenPlanks_01_messy_F",
						"Land_Boat_03_abandoned_F",
						"Land_Boat_01_abandoned_red_F",
						"Land_Addon_01_ruins_F",
						"Land_Shop_Town_02_ruins_F",
						"Land_Church_01_V1_F",
						"Land_LightHouse_F",
						"Land_Airport_Tower_F"
					];
					_locobject = (_randommodels select round random (count _randommodels)-1) createVehicleLocal (player modelToWorld [(random 10),((random 30)+30),(random 10)]);
					sleep 5;
					deletevehicle _locobject;
				};
				// removes X amount of the variable to reduce the effect if the loop is ran.
				if (!_consumption) then {((_drugsarray select 0) select _forEachIndex) set [1,((_x select 1)-2)];};
				
				//Remove all the effects
				if (_x select 1 <= 0) exitwith {
					((_drugsarray select 0) select _forEachIndex) set [1,0]; //Set to 0
					player setAnimSpeedCoef 1;
					"colorCorrections" ppEffectEnable false; 	
				};
			};};
			default {};
			};	
		};
	} foreach (_drugsarray select 0);
	player setvariable ["drugs_array",_drugsarray,true];
}] call Server_Setup_Compile;

["A3PL_Drugs_Add",
{
	private ["_drugsType","_amount","_drugsArray"];
	
	_drugstype = param [0,""];
	_amount = param [1,1];
	_drugsarray = player getvariable ["drugs_array",[[["alcohol",0],["cocaine",0],["shrooms",0]],false]];
	{
	if (_drugstype == (_x select 0)) then {
		((_drugsarray select 0) select _forEachIndex) set [1,(_amount+(_x select 1))];
	};
	} foreach (_drugsarray select 0);
	
	[true] spawn A3PL_Drugs_Loop;
}] call Server_Setup_Compile;


["A3PL_Drugs_Use",
{
	private ["_item","_drugcooldown","_until"];
	_item = param [0,""];
	if(_item in ["weed_5g", "weed_10g", "weed_15g", "weed_20g", "weed_25g", "weed_30g", "weed_35g", "weed_40g", "weed_45g", "weed_50g", "weed_55g", "weed_60g", "weed_65g", "weed_70g", "weed_80g", "weed_85g", "weed_90g", "weed_95g", "weed_100g"]) then {_item = "weed"};
	_drugcooldown = player getVariable ["drugcooldown", diag_tickTime];
	if (_drugcooldown > diag_tickTime) exitwith {["If you take drugs you will overdose, you must wait " + str(ceil((_drugcooldown-diag_tickTime)/60)) + " minutes!",Color_Red] call A3PL_Player_Notification;};

	detach Player_Item;
	deleteVehicle Player_Item;
	Player_Item = objNull;
	Player_ItemClass = '';

	switch (_item) do
	{
		case ("shrooms"): 
		{
			player setVariable ["drugcooldown", diag_tickTime+(5*60), true];
			"colorCorrections" ppEffectEnable true;
			"colorCorrections" ppEffectAdjust [0.5, 0.5, 0, [(random 10),(random 10),(random 10),0.2], [1,1,5,2], [(random 5),(random 5),(random 5),(random 5)]]; 
			"colorCorrections" ppEffectCommit 40;
			player enableFatigue false;

			sleep 10;
			player enableFatigue true;
			"colorCorrections" ppEffectEnable false; 
		};
		case ("weed"):
		{
			[] spawn{
				"chromAberration" ppEffectEnable true; 
				"radialBlur" ppEffectEnable true; 
				enableCamShake true; 
					
				//Let's go for 45secs of effetcs 
				for "_i" from 0 to 300 do 
				{ 
					"chromAberration" ppEffectAdjust [random 0.25,random 0.25,true]; 
					"chromAberration" ppEffectCommit 1;    
					"radialBlur" ppEffectAdjust  [random 0.02,random 0.02,0.15,0.15]; 
					"radialBlur" ppEffectCommit 1; 
					addcamShake[random 3, 1, random 3]; 
					sleep 1; 
				}; 
			};
			[_until] spawn {
				waitUntil {
					// Wait 20 seconds
					_until = diag_tickTime + 20;
					waitUntil {sleep 1; diag_tickTime > _until;};

					if(([player,"blood"] call A3PL_Medical_GetVar) < 5000) then {
						[player,[250]] call A3PL_Medical_ApplyVar;
						if(([player,"blood"] call A3PL_Medical_GetVar) == 5000) then{
							true; // Stop Loop
						}else{
							false; // Continue Loop
						}
					}else{
						true; // Stop Loop
					};
				};

				"chromAberration" ppEffectAdjust [0,0,true]; 
				"chromAberration" ppEffectCommit 5; 
				"radialBlur" ppEffectAdjust  [0,0,0,0]; 
				"radialBlur" ppEffectCommit 5; 
				sleep 4; 
				
				"chromAberration" ppEffectEnable false; 
				"radialBlur" ppEffectEnable false; 
				resetCamShake;
			};
		};
		case ("cocaine"):
		{
			["FilmGrain", 2000, [0.6, 0.15, 3, 0.2, 1.0, 0]] spawn 
			{
				params ["_name", "_priority", "_effect", "_handle"]; 
				player setAnimSpeedCoef 1.2;
				while { 
				_handle = ppEffectCreate [_name, _priority]; 
				_handle < 0; 
				} do { 
				_priority = _priority + 1; 
				}; 
				_handle ppEffectEnable true; 
				_handle ppEffectAdjust _effect; 
				_handle ppEffectCommit 5; 
				waitUntil {ppEffectCommitted _handle}; 
				uiSleep 60; 
				_handle ppEffectEnable false; 
				ppEffectDestroy _handle; 
				player setAnimSpeedCoef 1;
			};
		};
	};
}] call Server_Setup_Compile;