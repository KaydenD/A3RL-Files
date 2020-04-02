["A3PL_Delivery_StartJob",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if ((player getVariable ["job","unemployed"]) == "deliver") exitwith {["System: You stopped working for Fishers Island Postal Service!",Color_Red]; [] call A3PL_NPC_LeaveJob};
	player setVariable ["job","deliver"];
	["System: Welcome to Fishers Island Postal Service!",Color_Green] call A3PL_Player_Notification;
	["System: Go take your truck and deliver the packages, check the label on the package for the address!",Color_Green] call A3PL_Player_Notification;
	player adduniform "A3PL_Mailman_Uniform";
	player addHeadGear "A3PL_Mailman_Cap";

	sleep (random 2 + 2);
	["A3PL_Mailtruck",[6056.77,7393.57,0],"DELIVER",1800] spawn A3PL_Lib_JobVehicle_Assign;

	sleep (random 2 + 2);
	[] call A3PL_Delivery_GenPackage;
}] call Server_Setup_Compile;

["A3PL_Delivery_Deliver",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_package","_pos","_label"];
	_package = objNull;
	{
		if ((typeOf _x) == "A3PL_DeliveryBox") exitwith {_package = _x; true;};
	} foreach ([player] call A3PL_Lib_AttachedAll);
	if (isNull _package) exitwith {["System: You are currently not carrying a package to deliver!",Color_Red] call A3PL_Player_Notification;};
	_label = _package getVariable ["label",[]];
	_pos = _label select 0;

	if ((player distance _pos) < 10) then
	{
		deleteVehicle _package;
		["System: You earned $500 for delivering this package",Color_Green] call A3PL_Player_Notification;
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+500,true];
		player setVariable ["jobVehicleTimer",(player getVariable ["jobVehicleTimer",0]) + 240,true]; //extend job vehicle time by 4 minutes
	} else
	{
		["System: You are not near the location to deliver this package to, please check the delivery label!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Delivery_Label",
{
	private ["_package","_address","_item","_label"];
	_package = param [0,objNull];
	_label = _package getVariable ["label",[]];
	_address = _label select 2;
	_item = _label select 1;
	if (count _label == 0) exitwith {["System: Unable to retrieve delivery label",Color_Red] call A3PL_Player_Notification;};
	[format ["System: Please deliver these %1 to the %2",_item,_address],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Delivery_Pickup",
{
	private ["_package"];
	_package = param [0,objNull];
	player playAction "Gesture_carry_box";
	[] call A3PL_Placeables_QuickAction;
	[_package] spawn
	{
		_package = param [0,objNull];
		_package setDir (getDir player);
		while {_package IN (attachedObjects player)} do
		{
			uiSleep 0.5;
			if (isNull _package) exitwith {};
		};
		player playAction "gesture_stop";
	};
}] call Server_Setup_Compile;

["A3PL_Delivery_GenPackage",
{
	private ["_locations","_package","_packages","_jobVeh"];
	_locations =
	[
		[[2685.63,5547.58,0],"Bowling balls","Silverton Community Centre"],
		[[2658.92,5488.49,0],"Water","Silverton Fire Department"],
		[[2565.87,5501.98,0],"Legal letters","Silverton City Hall"],
		[[2537.62,5605.59,0],"Golden fish","Silverton Bank"],
		[[2514.74,5646.93,0],"Fresh fish","Silverton Mcfishers"],
		[[2585.81,5437.9,0],"Donuts","Silverton Sheriff Department"],
		[[2362.44,5479.82,0],"Wrenches","Silverton Impound Facility"],
		[[2621.42,5609.62,0],"Jerry cans","Silverton General Store"],
		[[3541.06,5158.72,0],"Paintballs","Pinhead Larry NPC (Paintball)"],
		[[3803.6,6216.6,0],"Dirty money","Money launderer NPC"],

		[[3587.11,7497.87,0],"Taco shells","Stoney Creek Taco Hell"],
		[[3453.14,7515.06,0],"Light bulbs","Stoney Creek Hardware Store"],
		[[3428.95,7485.06,0],"Cheque books","Stoney Creek Bank"],
		[[3383.2,7518.96,0],"18+ magazines","Stoney Creek Apartments 1"],

		[[4171.13,6179.98,0],"'SQF scripting for dummies' books","Beach Valley Gas Station"],
		[[4139.38,5689.15,0],"Farming seeds","Seed Store NPC (Greenhouses Area)"],
		[[4770.13,6273.44,0],"Ball and chains","Department of Corrections (Prison)"],
		[[6472.46,5515.05,0],"Fireaxes","Hemluck Huck's lumberyard"],
		[[6961.03,5425.72,0],"Wheat","Moonshine Willy"],

		[[3803.6,6216.6,0],"Driver licenses","DOJ/DMV in Silverton"],

		[[7120.18,7249.38,0],"Gems","Gem store in Boulder City"],
		[[7147.02,7220.42,0],"Eviction notice","Furniture store in Boulder City"],
		[[7108.02,7199.19,0],"Mcfishers uniforms","Mcfishers in Boulder City"],
		[[6958.67,7015.32,0],"Pens","Bank in Boulder City"]
	];

	_attachPoints =
	[
		[-0.7,0,-0.87],[-0.3,0,-0.87],[0.15,0,-0.87],[0.6,0,-0.87],
		[-0.7,-1.9,-0.87],[-0.3,-1.9,-0.87],[0.15,-1.9,-0.87],[0.6,-1.9,-0.87]
	];

	//shuffle
	_attachpoints = _attachPoints call BIS_fnc_arrayShuffle;
	_locations = _locations call BIS_fnc_arrayShuffle;

	_jobVeh = player getVariable ["jobVehicle",objNull];
	if (isNull _jobVeh) exitwith {["System: Job vehicle not found, please try re-taking your job",Color_Red] call A3PL_Player_Notification;};

	for "_i" from 0 to (3 + (round (random 3))) do
	{
		_package = createVehicle ["A3PL_DeliveryBox", getpos player, [], 0, "CAN_COLLIDE"];
		_package attachTo [_jobVeh,(_attachPoints select (random ((count _attachPoints) - 1)))];
		_package setVariable ["class","mail",true];
		_package setVariable ["owner",getPlayerUID player,true];
		_package setVariable ["label",(_locations select (random ((count _locations) - 1)))];
	};

	["System: The packages have spawned in your mailtruck, check the label to see where they have to go! (hint: you can crawl into the back of the truck by crawling!)",Color_Green] call A3PL_Player_Notification;

}] call Server_Setup_Compile;
