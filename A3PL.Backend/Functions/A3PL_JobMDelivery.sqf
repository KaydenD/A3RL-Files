["A3PL_JobMDelivery_addJobReceive",
{
	private ["_r","_format"];
	_r = param [0,0];
	
	_format = ["Server: Error",Color_Red];
	switch (_r) do
	{
		case 0: {_format = ["Server: An unknown error occured while trying to perform this action",Color_Red]};
		case 1: {_format = ["Server: You already have 3 pending packages on the job list/on its way",Color_Red]};
		case 2: {_format = ["Server: You can't deliver your own packages",Color_Red]};
		case 3: {_format = ["Server: You are already delivering 3 packages, you can't deliver more at this moment",Color_Red]};
		case 4: {_format = ["Server Error: Unable to determine delivery location",Color_Red]};
		case 5: {_format = ["Server Error: You don't seem to have a mailtruck nearby that you own",Color_Red]};
		case 6: {_format = ["Server Error: Couldn't find a suitable spawn position for the package",Color_Red]};
		case 7: {_format = ["Server Error: Couldn't retrieve package information by ID, report this",Color_Red]};
		case 8: {_format = ["Server Error: Couldn't find the ID to clear from joblist, is this job already taken?",Color_Red]};
		case 9: {_format = ["Server: One of your packages was reset back on the job list because the assigned deliverer left the server",Color_Red]};
		case 10: {_format = ["Server: One of your packages was reset back on the job list because the mailtruck became a null object (impounded/removed?)",Color_Red]};
		case 11: {_format = ["Server: One of your packages was reset back on the job list because the package is too far from the assigned mailtruck",Color_Red]};
		case 12: {_format = ["Server: One of your packages was reset back on the job list because you ran out of time to deliver it! (20min)",Color_Red]};
		case 13: {_format = ["Server: The assigned deliverer for one of your packages failed to deliver it, it was reset back onto the job list",Color_Red]};
		case 14: {_format = ["Server Error: Unable to determine package contents",Color_Red]};
		case 15: 
		{
			_contents = param [1,[]];
			_format = 
			[
				format ["Server: You collected %1 %2 from this package",(_contents select 1),(_contents select 0)],
				Color_Green
			];
		};
		case 16: {_format = ["Server Error: Unable to collect this package, it doesn't seem like it belongs to you",Color_Red]};
		case 18: {_format = ["Server: A package you ordered was delivered to your home",Color_Green]};
		case 19: {_format = ["Server: You bought an item(s), however this item needs to be delivered to you by a mailman to your home, we will let you know when it's on the way!",Color_Green]};
		case 20: {_format = ["Server: It doesn't look like the person that this package belongs to is still on the server",Color_Red]};
		case 21: 
		{
			_number = param [1,""];
			_format = [format ["Server: A mailman has accepted your request and is on his way to your home to deliver your package. His phone number is %1 if you want to get in touch with him",_number],Color_Green];
		};
		case 22: {_format = [format ["Server: You delivered a package and earned $%1",param [1,0]],Color_Green]};	
		case 23: {_format = [format ["Server: This package has already been delivered",param [1,0]],Color_Red]};
		case 24: {_format = [format ["Server: One of your packages was collected and you earned $%1",param [1,0]],Color_Green]};	
	};
	
	if (_r == 17) exitwith
	{
		private ["_deliverTo","_address"];
		_deliverTo = param [1,objNull,[objNull,[]]];
		if (typeName _deliverTo == "ARRAY") then
		{
			_address = (getpos (_deliverTo select 0)) call A3PL_Housing_RetrieveAddress; 
			_address = format ["%1 (Deliver to: Room %2)",_address,_deliverTo select 1];
		} else
		{
			_address = (getpos _deliverTo) call A3PL_Housing_RetrieveAddress; 
		};
		[format ["Server: The package has spawned, please deliver it to %1",_address],Color_Green] call A3PL_Player_Notification;
		["Server: You have 20 minutes to complete the delivery, please do not take the package too far away from the mailtruck or the delivery will fail",Color_Green] call A3PL_Player_Notification;			
	};
	
	_format call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//read package description
["A3PL_JobMDelivery_PackageInfo",
{
	private ["_num","_deliveryVar","_number","_for","_address","_deliverTo","_name"];
	_package = param [0,objNull];
	
	_deliveryVar = _package getVariable ["delivery",[]];
	if (count _deliveryVar == 0) exitwith {["System: Missing delivery variable on package, unable to check info",Color_Red] call A3PL_Player_Notification;};
	_uid = _deliveryVar select 0;
	
	
	_number = _uid select [(count _uid)-7,count _uid];
	_for = [_uid] call A3PL_Lib_UIDToObject;
	_name = _for getVariable ["name","Unknown"];
	
	//get address
	_deliverTo = _deliveryVar select 2;
		if (typeName _deliverTo == "ARRAY") then
		{
			_address = (getpos (_deliverTo select 0)) call A3PL_Housing_RetrieveAddress; 
			_address = format ["%1 (Deliver to: Room %2)",_address,_deliverTo select 1];
		} else
		{
			_address = (getpos _deliverTo) call A3PL_Housing_RetrieveAddress; 
		};
		
	if (isNil "_address") then
	{
		_address = "Unknown";
	};
	
	[format ["Package for: %1",_name],Color_Green] call A3PL_Player_Notification;
	[format ["Phone: %1",_number],Color_Green] call A3PL_Player_Notification;
	[format ["Address: %1",_address],Color_Green] call A3PL_Player_Notification;
	
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_OpenJobList",
{
	//create the dialog
	createDialog "Dialog_VDeliveryJobList";
	
	//send request for the job list
	[[player],"Server_JobMDelivery_SendJobList",false] call BIS_FNC_MP;
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_Pickup",
{
	private ["_package"];
	_package = param [0,objNull];
	_deliveryVar = _package getVariable ["delivery",[]];
	
	if (count _deliveryVar == 0) exitwith {["System: Missing delivery variable on package, unable to pickup",Color_Red] call A3PL_Player_Notification;};
	_packageOwner = _deliveryVar select 1;
	if (!((_packageOwner) == (getPlayerUID player))) exitwith {["System: This package isn't assigned to you for delivery",Color_Red] call A3PL_Player_Notification;};
	
	if ((isPlayer attachedTo _package) && (!((attachedTo _package) isKindOf "Car"))) exitwith {["System: It looks like this package is being carried by another player",Color_Red] call A3PL_Player_Notification;};
	
	player playAction "Gesture_carry_box";
	[] call A3PL_Placeables_QuickAction;
	[_package] spawn
	{
		_package = param [0,objNull];
		while {_package IN (attachedObjects player)} do
		{
			uiSleep 0.5;
			if (isNull _package) exitwith {};
		};
		player playAction "gesture_stop";
	};
	
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_ReceiveJobList",
{
	private ["_joblist"];
	_jobList = param [0,[]];
	
	buttonSetAction [1600, "call A3PL_JobMDelivery_TakeJobButton"];
	
	{
		_i = lbadd [1500,format ["Package Delivery: %1",(([(_x select 1)] call A3PL_Lib_UIDToObject) getVariable ["name","Unknown"])]];
		lbSetData [1500, _i,format ["%1",_x select 0]];
	} foreach _jobList;	
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_TakeJobButton",
{
	_i = lbCurSel 1500;
	if (_i == -1) exitwith {["System: Please select a job from the list",Color_Red] call A3PL_Player_Notification;};
	
	[[player,parseNumber (lbData [1500,_i])],"Server_JobMDelivery_Take",false] call BIS_FNC_MP;
	
	["System: Send request to server to take this package delivery job",Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_Collect",
{
	private ["_package","_contents","_f"];
	_package = param [0,objNull];
	if (isNull _package) exitwith {};
	
	_deliveryVar = _package getVariable ["delivery",[]];
	if (count _deliveryVar == 0) exitwith {["System: Missing delivery variable on package, unable to pickup",Color_Red] call A3PL_Player_Notification;};
	_packageOwner = _deliveryVar select 0;
	if (!((_packageOwner) == (getPlayerUID player))) exitwith {["System: This package isn't yours to collect",Color_Red] call A3PL_Player_Notification;};	
	
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	
	_contents = _package getVariable ["packageContents",[]];
	if (count _contents == 0) exitwith {[14] call A3PL_JobMDelivery_addJobReceive;};
	
	if ((_contents select 0) == "ITEM") then
	{
		_deliveryClassArray = _contents select 1;
		if (([_deliveryClassArray] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith 
		{
			[format ["System: You can't pick this item up because it would exceed the %1 lbs limit you can carry on you!",Player_MaxWeight],Color_Red] call A3PL_Player_Notification;
			_f = true;
		};
	};
	
	if (!isNil "_f") exitwith {};
	
	[[player,_package],"Server_JobMDelivery_Collect",false] call BIS_FNC_MP;
}] call Server_Setup_Compile;

["A3PL_JobMDelivery_Deliver",
{
	private ["_intersect","_name","_deliveryPackage","_correctHouse","_deliveryCarVar","_deliveryCarVarHouse"];
	_intersect = param [0,objNull];
	_name = param [1,""];
	
	_near = nearestObjects [player, ["A3PL_DeliveryBox"], 5];
	{
		private ["_var"];
		_var = _x getVariable ["delivery",nil];
		if (!isNil "_var") then
		{
			if ((_var select 1) == (getPlayerUID player)) then
			{
				_deliveryPackage = _x;
			};
		};
	} foreach _near; 
	
	if (isNil "_deliveryPackage") exitwith
	{
		["System: You don't seem to have a package nearby that has to be delivered",Color_Red] call A3PL_Player_Notification;	
	};
	
	_deliveryCarVar = _deliveryPackage getVariable "delivery"; 
	_deliveryCarVarHouse = _deliveryCarVar select 2;
	_correctHouse = false;
	if ((typeName _deliveryCarVarHouse) == "ARRAY") then
	{
		private ["_apt","_aptNumber","_aptNumberInteract"];
		_apt = _deliveryCarVarHouse select 0;
		_aptNumber = _deliveryCarVarHouse select 1;
		
		if (!(_intersect == _apt)) exitwith {[format ["System: You are at the wrong building, this package has to be delivered to %1",(getpos _apt) call A3PL_Housing_RetrieveAddress],Color_Red] call A3PL_Player_Notification;	}; //we are not even interacting with the correct building
		
		//get the apartment number we are interacting with
		_aptNumberInteract = _name splitstring "door";
		if (count _aptNumberInteract < 1) exitwith {};
		_aptNumberInteract = _aptNumberInteract select 0;
		_aptNumberInteract = parseNumber _aptNumberInteract;
		if (!(_aptNumberInteract == _aptNumber)) exitwith {[format ["System: You are at the right building but the wrong door, this package has to be delivered to room %1",_aptNumber],Color_Red] call A3PL_Player_Notification;};
		_correctHouse = true;
	} else
	{
		if (_intersect == _deliveryCarVarHouse) then
		{
			_correctHouse = true;
		} else
		{
			[format ["System: You are at the wrong building, this package has to be delivered to %1",(getpos _deliveryCarVarHouse) call A3PL_Housing_RetrieveAddress],Color_Red] call A3PL_Player_Notification;
		};
	};
	
	if (!_correctHouse) exitwith {};
	
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	
	//send request to server to deliver the vehicle
	[[player,_deliveryPackage],"Server_JobMDelivery_Deliver",false] call BIS_FNC_MP;
	["System: Send request to server to deliver a package",Color_Yellow] call A3PL_Player_Notification;		
}] call Server_Setup_Compile;
