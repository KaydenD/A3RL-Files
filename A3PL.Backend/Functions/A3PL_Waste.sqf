["A3PL_Waste_StartJob",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (player getVariable ["job","unemployed"] == "waste") exitwith {["System: You stopped working for Fishers Island Waste Management!",Color_Red]; [] call A3PL_NPC_LeaveJob};
	player setVariable ["job","waste"];
	["System: Welcome to Fishers Island Waste Management.",Color_Green] call A3PL_Player_Notification;
	[] spawn A3PL_Player_SetMarkers;
	["System: Go and hunt for trash bins around the island, and empty the trash into your truck!",Color_Green] call A3PL_Player_Notification;
	player adduniform "A3PL_Waste_Manage_Uni_Uniform";
	player addVest "A3PL_Waste_Manage_Vest";
	player addHeadGear "A3PL_Waste_Manage_Cap";

	sleep (random 2 + 2);
	["A3PL_P362_Garbage_Truck",[6059.44,7502.32,0],"waste",1800] spawn A3PL_Lib_JobVehicle_Assign;
}] call Server_Setup_Compile;

//this will check if a bin is near a truck
["A3PL_Waste_CheckNear",
{
	private ["_nearTrucks","_truck","_bin","_bin1pos","_bin2pos","_bin1dist","_bin2dist"];
	_bin = param [0,objNull];
	_nearTrucks = nearestObjects [_bin, ["A3PL_P362_Garbage_Truck"], 10];
	//if (count _nearTrucks == 0) exitwith {["System: There are no truck nearby",Color_Red] call A3PL_Player_Notification;};
	if (count _nearTrucks == 0) exitwith {false;};
	_truck = _nearTrucks select 0;

	_bin1pos = _truck modelToWorld [-0.731541,-4.48728,-1.12253];
	_bin2pos = _truck modelToWorld [0.298429,-4.48728,-1.12253];
	_bin1dist = _bin1pos distance _bin;
	_bin2dist = _bin2pos distance _bin;

	systemChat format ["%1 %2 %3",_bin1dist,_bin2dist,_bin];

	if ((_bin1dist < 0.85) OR (_bin2dist < 0.85)) then
	{
		true;
	} else
	{
		false;
	};
}] call Server_Setup_Compile;

["A3PL_Waste_LoadBin",
{
	private ["_bin","_nearTrucks","_truck"];
	_bin = param [0,objNull];
	_nearTrucks = nearestObjects [_bin, ["A3PL_P362_Garbage_Truck"], 10];
	if (count _nearTrucks == 0) exitwith {["System: There are no truck nearby",Color_Red] call A3PL_Player_Notification;};
	_truck = _nearTrucks select 0;

	_bin1pos = _truck modelToWorld [-0.731541,-4.48728,-1.12253];
	_bin2pos = _truck modelToWorld [0.298429,-4.48728,-1.12253];
	_bin1dist = _bin1pos distance _bin;
	_bin2dist = _bin2pos distance _bin;

	if ((_bin1dist < 0.85) OR (_bin2dist < 0.85)) then
	{
		[_bin] remoteExec ['A3PL_Lib_HideObject', 2];
		["System: Bin has been succesfully loaded on the garbage truck!",Color_Green] call A3PL_Player_Notification;

		if (_bin1dist < _bin2dist) then
		{
			_truck animateSource  ["Bin1", 0.1,true];
			_truck setVariable ["bin1",_bin,true];
		} else
		{
			_truck animateSource  ["Bin2", 0.1,true];
			_truck setVariable ["bin2",_bin,true];
		};
	} else {};
}] call Server_Setup_Compile;

["A3PL_Waste_UnloadBin",
{
	private ["_truck","_name","_bin"];
	_truck = param [0,objNull];
	_name = param [1,""];

	switch (_name) do
	{
		case ("bin1"):
		{
			_bin = _truck getVariable ["bin1",objNull];
			[_bin,false] remoteExec ['A3PL_Lib_HideObject', 2];
			_truck animateSource  ["Bin1", 0,true];
		};
		case ("bin2"):
		{
			_bin = _truck getVariable ["bin2",objNull];
			[_bin,false] remoteExec ['A3PL_Lib_HideObject', 2];
			_truck animateSource  ["Bin2", 0,true];
		};
	};
	
	_truck setVariable [_name,nil,true];
}] call Server_Setup_Compile;

["A3PL_Waste_FlipBin",
{
	private ["_anim","_truck","_binObj"];
	_truck = param [0,objNull];
	_anim = param [1,""];
	_truck animateSource [_anim, 1];
	
	_binObj = _truck getVariable [_anim,Objnull];
	if (isNull _binObj) exitwith {["System: Error getting _binObj variable - is there no bin loaded in this slot?",Color_Red] call A3PL_Player_Notification;};
	
	//check particular bin timer
	if (_binObj getVariable ["A3PL_Waste_ReceivedMoney",false]) exitwith {["System: You recently cleared this bin and didn't receive money! - 3 min cooldown per bin",Color_Red] call A3PL_Player_Notification;};
	_binObj setVariable ["A3PL_Waste_ReceivedMoney",true];	

	//check player timer
	if (player getVariable ["A3PL_Waste_ReceivedMoney",false]) exitwith {["System: You recently cleared a bin and didn't receive money! - 1 min cooldown",Color_Red] call A3PL_Player_Notification;};
	player setVariable ["A3PL_Waste_ReceivedMoney",true];	
	
	[_binObj] spawn
	{
		private ["_binObj"];
		_binObj = param [0,objNull];
		
		sleep 2;
		
		["System: You earned $500 for unloading the trash into the trash bin",Color_Green] call A3PL_Player_Notification;
		player setVariable ["player_cash",(player getVariable ["player_cash",0])+500,true];
		player setVariable ["jobVehicleTimer",(player getVariable ["jobVehicleTimer",0]) + 120,true]; //extend job vehicle time by 2 minutes
		
		uiSleep 60;
		
		player setVariable ["A3PL_Waste_ReceivedMoney",false];
		
		uiSleep 120;
		_binObj setVariable ["A3PL_Waste_ReceivedMoney",false];
	};
}] call Server_Setup_Compile;
