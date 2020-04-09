["A3RL_Waterfall",
{
	if (!hasInterface) exitwith {};

	private ["_casc1","_casc2","_casc3","_part_def", "_flow", "_al_pressure", "_w_obj", "_start_size", "_end_size"];

	_al_pressure	= param[0, 12];
	_w_obj			= param[1, objNull];
	_start_size		= param[2, 1];
	_end_size		= param[3, 10];

	_flow = (getposasl _w_obj vectorFromTo (_w_obj getRelPos [10,0])) vectorMultiply _al_pressure;
	_part_def = [[0,[0,0,0]],[0.5,[0.1,0.1,0.1],[0,0,0],5,0.1,[0,0,0,0],0.01,0,0]];

	while {alive _w_obj} do 
	{
		waitUntil {sleep 10; (player distance _w_obj) < 2000};
		_casc1 = "#particlesource" createVehicleLocal (getpos _w_obj);
		_casc1 setParticleCircle _part_def # 0;
		_casc1 setParticleRandom _part_def # 1;
		_casc1 setParticleParams [["\A3\data_f\cl_water",1,0,1],"","Billboard",1,3,[0,0,0],[_flow select 0,_flow select 1,-7],15,1050,7.9,0,[_start_size,_end_size],[[0.80,0.90,1,0.5],[0.80,0.90,1,0.5]],[1],0,0,"","",_w_obj];
		_casc1 setDropInterval 0.02;

		_casc2 = "#particlesource" createVehicleLocal (getpos _w_obj);
		_casc2 setParticleCircle _part_def # 0;
		_casc2 setParticleRandom _part_def # 1;
		_casc2 setParticleParams [["\A3\data_f\cl_fireD",1,0,1],"","Billboard",1,3,[0,0,0],[_flow select 0,_flow select 1,-7],15,1050,7.9,0,[_start_size,_end_size],[[1,1,1,0.5],[1,1,1,0.1]],[1],0,0,"","",_w_obj];
		_casc2 setDropInterval 0.05;

		_casc3 = "#particlesource" createVehicleLocal (getpos _w_obj);
		_casc3 setParticleCircle _part_def # 0;
		_casc3 setParticleRandom _part_def # 1;
		_casc3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\smoke.p3d",1,0,1],"","Billboard",1,3,[0,0,0],[_flow select 0,_flow select 1,-7],15,1050,7.9,0,[_start_size,_end_size],[[0.85,0.95,1,0.5],[1,1,1,0.1]],[1],0,0,"","",_w_obj];
		_casc3 setDropInterval 0.05;	

		waitUntil {sleep 10; (player distance _w_obj) > 2000};
		deleteVehicle _casc1;
		deleteVehicle _casc2;
		deleteVehicle _casc3;
	};
}] call Server_Setup_Compile;
