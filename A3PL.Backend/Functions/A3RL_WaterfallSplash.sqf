["A3RL_WaterfallSplash",
{
	private ["_casc_baza_1", "_casc_baza_2", "_casc_baza_3", "_casc_baza_4", "_cascad_s", "_part_size", "_baza_casc", "_radi_casc"];

	if (!hasInterface) exitwith {};

	_baza_casc = param[0, objNull];
	_radi_casc = param[1, 5];

	[_baza_casc] spawn {_cascad_s = _this select 0;	while {alive _cascad_s} do {_cascad_s say3d ["cascada",800];sleep 13}};
	_part_size = linearConversion [3.5,15,_radi_casc,5,20,true];

	while {alive _baza_casc} do 
	{
		waitUntil {sleep 10; (player distance _baza_casc) < 2000};
		_casc_baza_1 = "#particlesource" createVehicleLocal (getpos _baza_casc);
		_casc_baza_1 setParticleCircle [_radi_casc,[2,2,3]];
		_casc_baza_1 setParticleRandom [0.1,[0.5,0.5,0.5],[-2,-2,0.5],5,0.5,[0,0,0,0.5],1,0];
		//_casc_baza_1 setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,2,[0,0,0],[0,0,3],5,23,7.9,1,[5,5,3],[[1,1,1,0.5],[1,1,1,0.1],[1,1,1,0]],[1],1,0,"","",_baza_casc];
		_casc_baza_1 setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,2,[0,0,0],[0,0,3],5,23,7.9,1,[_part_size,_part_size,floor (_part_size/1.5)],[[1,1,1,0.5],[1,1,1,0.1],[1,1,1,0]],[1],1,0,"","",_baza_casc];
		_casc_baza_1 setDropInterval 0.05;

		_casc_baza_2 = "#particlesource" createVehicleLocal (getpos _baza_casc);
		_casc_baza_2 setParticleCircle [_radi_casc,[2,2,3]];
		_casc_baza_2 setParticleRandom [0.5,[0.5,0.5,0.5],[-2,-2,0.5],5,0.5,[0,0,0,0.5],1,0];
		_casc_baza_2 setParticleParams [["\A3\data_f\cl_water",1,0,1],"","Billboard",1,1,[0,0,0],[0,0,3],5,23,7.9,1,[_part_size,_part_size,floor (_part_size*0)],[[1,1,1,0],[1,1,1,0.5],[1,1,1,0]],[1],1,0,"","",_baza_casc];
		_casc_baza_2 setDropInterval 1;

		_casc_baza_3 = "#particlesource" createVehicleLocal (getpos _baza_casc);
		_casc_baza_3 setParticleCircle [_radi_casc,[2,2,3]];
		_casc_baza_3 setParticleRandom [0.1,[0.5,0.5,0.5],[-2,-2,0.5],5,0.5,[0,0,0,0.5],1,0];
		_casc_baza_3 setParticleParams [["\A3\data_f\cl_fireD",1,0,1],"","Billboard",1,1,[0,0,0],[0,0,3],5,23,7.9,1,[_part_size,_part_size,floor (_part_size/1.5)],[[1,1,1,0.5],[1,1,1,0.5],[1,1,1,0]],[1],1,0,"","",_baza_casc];
		_casc_baza_3 setDropInterval 0.1;	

		_casc_baza_4 = "#particlesource" createVehicleLocal (getpos _baza_casc);
		_casc_baza_4 setParticleCircle [_radi_casc,[2,2,3]];
		_casc_baza_4 setParticleRandom [0.1,[0.5,0.5,0.5],[-2,-2,0.5],5,0.5,[0,0,0,0.5],1,0];
		_casc_baza_4 setParticleParams [["\A3\data_f\cl_fireD",1,0,1],"","Billboard",1,2,[0,0,0],[0,0,3],5,23,7.9,1,[_part_size,_part_size,floor (_part_size/1.5)],[[1,1,1,0.5],[1,1,1,0.5],[1,1,1,0]],[1],1,0,"","",_baza_casc];
		_casc_baza_4 setDropInterval 0.05;	

		waitUntil {sleep 10; (player distance _baza_casc) > 2000};
		deleteVehicle _casc_baza_1;
		deleteVehicle _casc_baza_2;
		deleteVehicle _casc_baza_3;
		deleteVehicle _casc_baza_4;
	};
}] call Server_Setup_Compile;