["Server_JobPicking_Init",
{
	Server_PickingAreas = [];
	{
		if (((_x splitstring "_") select 0) == "Picking") then
		{
			Server_PickingAreas pushback _x;
		};
	} foreach allMapMarkers;
}] call Server_Setup_Compile;

["Server_JobPicking_Loop",
{
	{
		//_x = marker
		private ["_type","_class","_players","_trees","_radius","_pos","_trees","_itemClass","_attachPoints"];
		_type = (_x splitstring "_") select 1;
		_radius = ((getMarkerSize _x) select 0);
		_pos = getMarkerPos _x;
		_players = count (_pos nearEntities ["Man", _radius]);

		switch (_type) do
		{
			case ("Apple"):
			{
				_class = "A3PL_Apple";
				_itemClass = "apple";
				_attachPoints = ["apple1","apple2","apple3","apple4","apple5","apple6","apple7","apple8","apple9","apple10","apple11","apple12","apple13","apple14","apple15","apple16","apple17","apple18","apple19","apple20","apple21","apple22","apple23","apple24","apple25","apple26","apple27","apple28","apple29","apple30","apple31","apple32","apple33","apple34","apple35","apple36","apple37","apple38","apple39","apple40","apple41","apple42","apple43","apple44","apple45","apple46","apple47","apple48","apple49","apple50","apple51","apple52","apple53","apple54"];
				//{_obj = createvehicle ["A3PL_Apple", cursorobject modelToWorld _x, [], 0, "CAN_COLLIDE"]; _obj enableSimulation false;} foreach [[0.1,0.1,-1.19],[0.4,0.26,-0.88],[0.7,0.42,-0.7],[1.2,0.56,-0.64],[1.6,0.69,-0.56],[1,0.73,-0.56],[1.8,1.57,-0.05]];
			};
		};

		//get all apples
		_objects = nearestObjects [_pos, [_class], _radius];
		_countObjects = count _objects;


		//delete all objects if there are no players and more than 1 objects (save network usage)
		if (_players < 1 && _countObjects > 0) then
		{
			{
				deleteVehicle _x;
			} foreach _objects;
		} else
		{
			if (_players > 0 && _countObjects < 10) then //create apples
			{

				//get trees
				_trees = nearestTerrainObjects [_pos, ["tree"], _radius];

				{
					_amountApples = 2 + (round random 2);
					_attachpoints = _attachpoints call BIS_fnc_arrayShuffle;
					for "_i" from 1 to _amountApples do
					{
						private ["_obj"];
						_applePos = _x selectionPosition (_attachpoints select _i);
						_applePos set [2,(_applePos select 2) - 0.1]; //offset
						_obj = createvehicle [_class,_x modelToWorld _applePos, [], 0, "CAN_COLLIDE"];
						_obj enableSimulationGlobal false;
						_obj setVariable ["class",_itemClass,true];
					};
				} foreach _trees;
			};
		};
	} foreach Server_PickingAreas;
}] call Server_Setup_Compile;
