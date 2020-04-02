["A3PL_JobVDelivery_addJob", 
{
	disableSerialization;
	
	private ["_shop","_class","_tax"];
	_shop = param [0,""];
	_class = [_shop, "class"] call A3PL_Config_GetShop;	
	_price = [_shop, "buyPrice"] call A3PL_Config_GetShop;
	
	_tax = round(_price * Tax_Sales_Rate);
	_price = _price + _tax;	
	
	//check player money
	if (_price > (player getVariable ["Player_Cash",0])) exitWith 
	{
		["System: You do not have enough money on you to request this vehicle", Color_Red] call A3PL_Player_Notification;
	};
	
	//dont even know why it did it this way but whatever, it gets the correct colour and gets the proper classname for it
	_control = ((findDisplay 20) displayCtrl 2100);
	if (lbCurSel _control == -1) then
	{
			
	} else
	{
		_class = format ["%1_%2",_class,(_control lbData (lbCurSel _control))];
	};	
	
	[[player,_class,_shop],"Server_JobVDelivery_AddJobRequest",false] call BIS_FNC_MP;
	["System: Send request to server for a vehicle delivery", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobVDelivery_addJobReceive", 
{
	private ["_r","_format"];
	_r = param [0,0];
	
	_format = ["Server: Error",Color_Red];
	switch (_r) do
	{
		case 0: {_format = ["Server: An unknown error occured while trying to perform this action",Color_Red]};
		case 1: {_format = ["Server: You already have a pending delivery request",Color_Red]};
		case 2: {_format = ["Server: You already have a delivery on the way",Color_Red]};
		case 3: {_format = ["Server: You don't have enough money to buy this vehicle",Color_Red]};
		case 4: {_format = ["Server: You bought a new vehicle, it will be delivered to your apartment or house by a trucker. We will let you know once your vehicle is on the way!",Color_Green]};
		case 5: {_format = ["Server: A new vehicle delivery job is available for you at the vehicle factory",Color_Green]};
		case 6: {_format = ["Server: Your vehicle delivery failed, the delivery will be re-scheduled shortly",Color_Red]};
		case 7: {_format = ["Server: You failed to deliver the vehicle, did you take the car too far away from the trailer?",Color_Red]};
		case 8: {_format = ["Server: You are already delivering two vehicles, if you want to abandon a job simply move 30m away from the trailer",Color_Red]};
		case 9: {_format = ["Server: It doesn't seem there is a trailer nearby that belongs to you",Color_Red]};
		case 10: {_format = ["Server: You can't take this job because the person is no longer on the server",Color_Red]};
		case 11: {_format = ["Server: Couldn't find a suitable position to spawn the requested vehicle for delivery, please clear the area around you",Color_Red]};
		case 13: {_format = ["Server: Unable to locate the delivery address, please find another job in the job list",Color_Red]};
		case 14: {_format = ["Server: Server was unable to locate the job inside the job list",Color_Red]};
		case 15: {_format = ["Server: You delivered a vehicle and earned $500",Color_Green]};
		case 16: {_format = ["Server: Your vehicle was succesfully delivered to your motel room/house. Feel free to tip the driver",Color_Green]};
		case 17: {_format = ["Server: You can't deliver a vehicle to yourself, have another trucker do this for you",Color_Red]};
	};
	
	if (_r == 12) exitwith
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
		[format ["Server: The vehicle has spawned, please delivered it to %1",_address],Color_Green] call A3PL_Player_Notification;
		["Server: You have 15 minutes to complete the delivery, please do not drive the vehicle too far away from the trailer or the delivery will fail",Color_Green] call A3PL_Player_Notification;			
	};
	
	_format call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobVDelivery_OpenJobList",
{
	//create the dialog
	createDialog "Dialog_VDeliveryJobList";
	
	//send request for the job list
	[[player],"Server_JobVDelivery_SendJobList",false] call BIS_FNC_MP;
}] call Server_Setup_Compile;

["A3PL_JobVDelivery_ReceiveJobList",
{
	private ["_joblist"];
	A3PL_JobVDelivery_JobList = param [0,[]];
	
	buttonSetAction [1600, "call A3PL_JobVDelivery_TakeJobButton"];
	
	{
		lbadd [1500,format ["Private Delivery: %1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")]];
	} foreach A3PL_JobVDelivery_JobList;
}] call Server_Setup_Compile;

["A3PL_JobVDelivery_TakeJobButton",
{
	_i = lbCurSel 1500;
	if (_i == -1) exitwith {["System: Please select a job from the list",Color_Red] call A3PL_Player_Notification;};
	
	[[player,(A3PL_JobVDelivery_JobList select _i)],"Server_JobVDelivery_TakeJob",false] call BIS_FNC_MP;
	
	["System: Send request to server to accept this job",Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_JobVDelivery_Deliver",
{
	private ["_intersect","_name","_deliveryCar","_correctHouse","_deliveryCarVar","_deliveryCarVarHouse"];
	_intersect = param [0,objNull];
	_name = param [1,""];
	
	_near = nearestObjects [player, ["Car"], 30];
	{
		private ["_var"];
		_var = _x getVariable ["delivery",nil];
		if (!isNil "_var") then
		{
			if ((_var select 1) == (getPlayerUID player)) then
			{
				_deliveryCar = _x;
			};
		};
	} foreach _near; 
	
	if (isNil "_deliveryCar") exitwith
	{
		["System: You don't seem to have a car nearby that has to be delivered",Color_Red] call A3PL_Player_Notification;	
	};
	
	_deliveryCarVar = _deliveryCar getVariable "delivery"; 
	_deliveryCarVarHouse = _deliveryCarVar select 2;
	_correctHouse = false;
	if ((typeName _deliveryCarVarHouse) == "ARRAY") then
	{
		private ["_apt","_aptNumber","_aptNumberInteract"];
		_apt = _deliveryCarVarHouse select 0;
		_aptNumber = _deliveryCarVarHouse select 1;
		
		if (!(_intersect == _apt)) exitwith {[format ["System: You are at the wrong building, this vehicle has to be delivered to %1",(getpos _apt) call A3PL_Housing_RetrieveAddress],Color_Red] call A3PL_Player_Notification;	}; //we are not even interacting with the correct building
		
		//get the apartment number we are interacting with
		_aptNumberInteract = _name splitstring "door";
		if (count _aptNumberInteract < 1) exitwith {};
		_aptNumberInteract = _aptNumberInteract select 0;
		_aptNumberInteract = parseNumber _aptNumberInteract;
		if (!(_aptNumberInteract == _aptNumber)) exitwith {[format ["System: You are at the right building but the wrong door, this vehicle has to be delivered to room %1",_aptNumber],Color_Red] call A3PL_Player_Notification;};
		_correctHouse = true;
	} else
	{
		if (_intersect == _deliveryCarVarHouse) then
		{
			_correctHouse = true;
		} else
		{
			[format ["System: You are at the wrong building, this vehicle has to be delivered to %1",(getpos _deliveryCarVarHouse) call A3PL_Housing_RetrieveAddress],Color_Red] call A3PL_Player_Notification;
		};
	};
	
	if (!_correctHouse) exitwith {};
	
	//send request to server to deliver the vehicle
	[[player,_deliveryCar],"Server_JobVDelivery_Deliver",false] call BIS_FNC_MP;
	["System: Send request to server to deliver a vehicle",Color_Yellow] call A3PL_Player_Notification;	
}] call Server_Setup_Compile;