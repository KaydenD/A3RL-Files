["Server_Hunting_SpawnLoop",
{
	/*	
		example:
		["goat",[8703.66,8172.92,0],["Goat","Goat02","Goat03"],200,10] spawn Server_Hunting_SpawnLoop;	
		["wildboar",[6601.76,7517.37,0],["WildBoar"],230,10] spawn Server_Hunting_SpawnLoop;
		["sheep",[6934.04,7442.04,0],["Sheep","Sheep02","Sheep03"],200,10] spawn Server_Hunting_SpawnLoop;
	*/
	
	//setup variables
	_siteVar = format ["A3PL_Animals_%1",(param [0,"def"])];
	_sitePos = param [1,[]];
	_animalList = param [2,[]];
	_genDist = param [3,5];		//creation distance
	_animalCount = param [4,5]; //number of animals
	_radius = param [5,_genDist]; //radius of animals
	_dist = 10000;
	_siteAnimals = missionNameSpace getVariable [_siteVar,[]];
	
	//take care of deleting killed animals from _siteAnimals
	_deleteAnimals = [];
	{
		if (isNull _x) then
		{
			_deleteAnimals = _deleteAnimals + [_x];
		};
	} foreach _siteAnimals;	
	{
		_siteAnimals = _siteAnimals - [_x];
	} foreach _deleteAnimals;
	
	
	
	//Continue
	{
		_checkDist = (_x distance2D _sitePos);
		if (_checkDist < _dist) then {_dist = _checkDist};
	} forEach allPlayers;

	if (_dist < _genDist) then 
	{
		_i = count _siteAnimals;
		while {_i < _animalCount} do 
		{
			_animal = _animalList select (round ((random ((count _animalList) - 0.01)) - 0.499));
			_pos = [((_sitePos select 0) - _radius + random (_radius * 2)), ((_sitePos select 1) - _radius + random (_radius * 2)), 0];
			_unit = createAgent [_animal,_pos,[],0,"NONE"];
			//_unit setVariable ["inSite",_site];
			_unit setDir (random 360);
			_siteAnimals = _siteAnimals + [_unit];
			_i = _i + 1;
			sleep 0.05;
		};
		missionNameSpace setVariable [_siteVar,_siteAnimals];
	} else 
	{
		{deleteVehicle _x} forEach _siteAnimals;
		missionNameSpace setVariable [_siteVar,[]];
	};
}] call Server_Setup_Compile;