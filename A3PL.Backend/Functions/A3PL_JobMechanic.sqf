["A3PL_JobMechanic_UseLift",
{
	private ["_obj","_veh","_pos","_posZ"];
	_obj = param [0,objNull];
	_veh = (nearestObjects [(_obj modelToWorld [-4,-1,-2]),["Car"],4]) select 0;
	if (!isNil "_veh") then 
	{
		_pos = getPosATL _veh;
		_posZ = _pos select 2;
		_veh setposATL [_pos select 0,_pos select 1,_posZ+0.1];
	}; //setpos the vehicle, it fixes simulation issue between lift and vehicle
	if (_obj animationSourcePhase "car_lift" < 0.75) then
	{
		_obj animateSource ["car_lift",1.5];
		if (!isNil "_posZ") then
		{
			uisleep 1.5;			
			if (((getPosATL _veh) select 2) <= (_posZ + 0.1)) then
			{
				_obj animateSource ["car_lift",0];
				["System: Lift has been reset, car isn't moving with lift. Please try again (this is an arma issue)",Color_Red] call A3PL_Player_Notification;
			};
		};		
	} else
	{
		_obj animateSource ["car_lift",0];
		if (!isNil "_posZ") then
		{
			uisleep 1.5;
			if (((getPosATL _veh) select 2) >= (_posZ - 0.1)) then
			{
				_obj animateSource ["car_lift",1.5];
				["System: Lift has been reset, car isn't moving with lift. Please try again (this is an arma issue)",Color_Red] call A3PL_Player_Notification;
			};
		};
	};				
}] call Server_Setup_Compile;