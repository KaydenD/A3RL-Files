["A3PL_Chopshop_Chop",
{
	private ["_car","_cars"];

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	_cars = nearestObjects [player, ["Car"], 10];
	_car = _cars select 0;
	_id = _car getVariable "owner" select 1;

	if (_id IN ["WASTE","DELIVER","EXTERMY","KARTING","DMV","ADMIN"]) exitWith {
		[localize "STR_A3PL_CHOPSHOP_NOJOB", Color_Red] call A3PL_Player_Notification;
	};

	if(count _cars < 1) exitWith {
		[localize "STR_A3PL_CHOPSHOP_NEARBY", Color_Red] call A3PL_Player_Notification;
	};
	if (((_car getVariable "owner") select 0) == (getPlayerUID player)) exitWith
	{
		[localize "STR_A3PL_CHOPSHOP_OWN", Color_Red] call A3PL_Player_Notification;
	};
	if (_car getVariable ["locked",true]) exitWith {
		[localize "STR_A3PL_CHOPSHOP_LOCKED", Color_Red] call A3PL_Player_Notification;
	};
	if (typeOf _car == "A3PL_CVPI_Rusty") exitWith {
		[localize "STR_A3PL_CHOPSHOP_CV", Color_Red] call A3PL_Player_Notification;
	};


	[localize "STR_A3PL_CHOPSHOP_CHOP", Color_Green] call A3PL_Player_Notification;
	[_car,player] remoteExec ["Server_Chopshop_Chop",2];
}] call Server_Setup_Compile;
