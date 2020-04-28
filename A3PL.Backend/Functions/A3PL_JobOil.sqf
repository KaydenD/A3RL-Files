//Function to start the pump
["A3PL_JobOil_PumpStart", 
{	
	private ["_pump","_pumpjacks","_hole","_holes"];
	_pump = param [0,objNull];
	
	if (!local _pump) exitwith {["System: Only the owner of the pump can start it", Color_Red] call A3PL_Player_Notification;};
	
	_pumpjacks = nearestObjects [_pump, ["A3PL_Pumpjack"], 3];
	_holes = nearestObjects [_pump, ["A3PL_DrillHole"], 3];
	if (count _holes < 1) exitwith {["System: It doesn't look like there is a hole located nearby this pumpjack", Color_Red] call A3PL_Player_Notification;};
	if (count _pumpjacks > 1) exitwith {["System: It looks like a jack pump is already placed near this hole", Color_Red] call A3PL_Player_Notification;};
	_hole = _holes select 0;
	if (((_pump modelToWorld (_pump selectionPosition "holePosition")) distance _hole) > 0.2) exitwith {["System: Please position the pump piece of the pumpjack closer to the hole", Color_Red] call A3PL_Player_Notification;};
	
	//Now check if we can actually start pumping
	//First check if we are in an area where oil is located
	_oil = [getpos _hole] call A3PL_JobWildcat_CheckForOil;
	_containsOil = _oil select 0;
	_oilLocation = _oil select 1;
	if (!_containsOil) exitwith {["System: This area doesn't (or no longer) contains crude oil", Color_Red] call A3PL_Player_Notification;};
	
	_oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;
	if (_oilAmount <= 0) exitwith {["System: This oil well is depleted, you need to find another well", Color_Red] call A3PL_Player_Notification;};

	/*
	_oilBarrels = nearestObjects [_pump, ["A3PL_OilBarrel"], 5];
	if (count _oilBarrels < 1) exitwith {["System: It doesn't seem like there is any oil barrel nearby, please place an oil barrel next to the pump", Color_Red] call A3PL_Player_Notification;};
	*/
	
	if ((_pump animationSourcePhase "drill") != 0) exitwith {["System: It seems like this pump is already running", Color_Red] call A3PL_Player_Notification;};
	
	//send request to server
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	["System: Send request to server to start pumping", Color_Yellow] call A3PL_Player_Notification;
	[player,_pump] remoteExec ["Server_JobOil_PumpStart", 2];
	[_pump] spawn  A3PL_JobOil_Pump_Animation;
}] call Server_Setup_Compile;

["A3PL_JobOil_Pump_Animation", 
{
	private ["_pump"];
	_pump = param [0,objNull];
	sleep  2;
	while {(_pump getVariable ["pumping",false])} do
	{
		//animate
		if (_pump animationSourcePhase "pump" < 0.5) then
		{
			_pump animateSource ["pump",1];
			waitUntil {_pump animationSourcePhase "pump" >= 0.98};
		} else
		{
			_pump animateSource ["pump",0,true];
			waitUntil {_pump animationSourcePhase "pump" < 0.1};
		};
	};
}] call Server_Setup_Compile;

["A3PL_JobOil_PumpReceive", 
{
	private ["_r","_notify"];
	_r = param [0,0];
	_notify = ["Server: One of your pumps stopped due to an unknown server error", Color_Red];
	
	switch (_r) do
	{
		case 1: { _notify = ["Server: One of your pumps stopped because there is no (longer) oil in this area.", Color_Red]; };
		case 2: { _notify = ["Server: One of your pumps stopped because the server couldn't find a hole nearby the pump", Color_Red]; };
		case 3: { _notify = ["Server: One of your pumps stopped because the server detects multiple pumps might be placed on one hole, move one pump further from the hole", Color_Red]; };
		case 4: { _notify = ["Server: One of your pumps stopped because the server detects the pump is not connected to the hole properly", Color_Red]; };
		case 5: { _notify = ["Server: One of your pumps stopped because the server couldn't detect an oil barrel nearby the pump that isn't full", Color_Red]; };
		case 6: { _notify = ["Server: One of your pumps didn't start because the server determined it is already running", Color_Red]; };
		case 7: { _notify = ["Server: This pump is already running", Color_Red]; };
	};
	
	_notify call A3PL_Player_Notification;
}] call Server_Setup_Compile;