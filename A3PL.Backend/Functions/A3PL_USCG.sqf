['A3PL_USCG_WaterCannon', {
	private ["_veh","_waterCannonEffect"];
	_veh = _this select 0;
	_waterCannonEffect = "#particlesource" createVehicleLocal (getPos _veh);																													//scale
	_waterCannonEffect setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "", "Billboard", 1, 3, (_veh selectionPosition "usti hlavne"), [0, 0, 0], 1, 25, 10, 0.01, [0.5, 2, 6], [ [0.55, 0.65, 1.00, 0.01], [0.55, 0.65, 1.00, 0.05], [0.30, 0.35, 0.40, 0.01], [0.00, 0.00, 0.00, 0.00]  ], [0], 0, 0,"","", _veh, 0, true, 0.03, [[0,0,0,0]] ];
	_waterCannonEffect setParticleRandom [0.5, [0.0, 0.0, 0.0], [0.2, 0.2, 0.2], 0.3, 0.1, [0, 0, 0, 0], 0, 0];
	_waterCannonEffect setParticleCircle [0, [0, 0, 0]];
	_waterCannonEffect setDropInterval 0.001;
	_waterCannonEffect attachTo [_veh, [0,0,0],"usti hlavne"];

	[_waterCannonEffect,_veh] spawn
	{
		private ["_waterCannonEffect","_veh","_z"];
		_waterCannonEffect = _this select 0;
		_veh = _this select 1;
		sleep 0.3;
		while {_veh animationPhase "extPump" > 0.1} do
		{
			sleep 0.1;
			_pressure = 8;
			if (_veh animationPhase "extPressure" > 0.4) then {_pressure = 15; };
			if (_veh animationPhase "extPressure" > 0.6) then {_pressure = 30; };
			_z = (_veh animationPhase "maingun") * 14;
			_vel =
			 [
				(sin (direction (commander _veh)) * _pressure),
				(cos (direction (commander _veh)) * _pressure),
				_z
			];

			if (isNull (commander _veh)) exitwith {if (local _veh) then {_veh animate ["extPump",0]};};

			_waterCannonEffect setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d", 1, 0, 1], "", "Billboard", 1, 3, (_veh selectionPosition "usti hlavne"), _vel, 1, 25, 10, 0.01, [0.5, 2, 6], [ [0.55, 0.65, 1.00, 0.01], [0.55, 0.65, 1.00, 0.05], [0.30, 0.35, 0.40, 0.01], [0.00, 0.00, 0.00, 0.00]  ], [0], 0, 0,"","", _veh, 0, true, 0.03, [[0,0,0,0]] ];
		};
		deleteVehicle _waterCannonEffect;
	};

}] call Server_Setup_Compile;

['A3PL_USCG_Drag',
{
	private ['_civ',"_dragged"];
	_civ = _this select 0;

	hint "test";

	_dragged = _civ getVariable ["dragged",false];
	//stop dragging here
	if (_dragged) exitwith
	{
		_civ setVariable ["dragged",Nil,true];
	};

	[[player],"A3PL_USCG_DragReceive",_civ,false] call BIS_FNC_MP;


}] call Server_Setup_Compile;

['A3PL_USCG_DragReceive',
{
	private ["_dragState","_cop"];
	_cop = param [0,objNull];

	["You have been grabbed, please comply with the LEO", Color_Red] call A3PL_Player_Notification;
	player setVariable ["dragged",true,true];
	[[player,""],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;
	["gesture_restrain"] call A3PL_Lib_Gesture;
	player forceWalk true;
	[_cop] spawn
	{
		private ["_var","_cop"];
		_cop = param [0,objNull];
		if (isNull _cop) exitwith {};
		while {player getVariable ["dragged",false] && vehicle _cop isKindOf "Civilian_F"} do
		{
				uiSleep 2;
				if (isNull _cop) exitwith {};
				if ((player distance _cop) > 4 && vehicle _cop isKindOf "Civilian_F") then
				{
					player setposATL (getposATL _cop);
				};
		};
		["The LEO has released you", Color_Red] call A3PL_Player_Notification;
		player forceWalk false;
		["gesture_stop"] call A3PL_Lib_Gesture;
		[[player,""],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;
	};
}] call Server_Setup_Compile;
