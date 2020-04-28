#define DEFGALLONPRICE 6.2

["A3PL_Hydrogen_SetPrice",
{
	disableSerialization;
	private ["_display","_newPrice","_station","_gp"];
	_display = findDisplay 69;

	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30]; //find nearest station
	if (count _station < 1) exitwith {["System error: Couldn't find a nearby gas station",Color_Red] call A3PL_Player_Notification;};
	_station = _station select 0;

	if ((_station getVariable ["bOwner","0"]) != (getPlayerUID player)) exitwith {["System: Only the owner of this building can set the prices",Color_Red] call A3PL_Player_Notification;};

	//parse price
	_newPrice = parseNumber (ctrlText (_display displayCtrl 1400));
	if (_newPrice < DEFGALLONPRICE) exitwith {[format ["Please enter a number greater than %1",DEFGALLONPRICE],Color_Red] call A3PL_Player_Notification}; //prevent players setting low prices
	if (_newPrice > (DEFGALLONPRICE * 25)) exitwith {[format ["Please enter a number lower than %1",DEFGALLONPRICE*25],Color_Red] call A3PL_Player_Notification}; //prevent players setting ridiculous amounts

	//set new price
	(_display displayCtrl 1400) ctrlSetText format ["%1",_newPrice];
	_station setVariable ["gallonprice",_newPrice,true];
	
	_gp = parseNumber(format["%1",((str(_newPrice) splitstring "") select 0)])*1000;
	
	if (_newPrice >= 10) then {
		_gp = parseNumber(format["%2%1",((str(_newPrice) splitstring "") select 0),((str(_newPrice) splitstring "") select 1)])*100;
	};

	if (_newPrice >= 100) then {
		_gp = parseNumber(format["%1%3%2",((str(_newPrice) splitstring "") select 0),((str(_newPrice) splitstring "") select 1),((str(_newPrice) splitstring "") select 2)])*100;
	};

	[_station,4,([_gp,1,2] call CBA_fnc_formatNumber),([_gp,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;	

	["System: New gas station price set!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_Open",
{
	disableSerialization;
	private ["_display","_station","_gallons","_price"];
	_station = nearestobjects [player,["Land_A3PL_Gas_Station"],30]; //find nearest station
	if (count _station < 1) exitwith {["System error: Couldn't find a nearby gas station",Color_Red] call A3PL_Player_Notification;};
	_station = _station select 0;

	createDialog "Dialog_GasStation";

	_display = findDisplay 69;

	//set button action
	buttonSetAction [1600,"[] call A3PL_Hydrogen_SetPrice"];

	//get current gallon price
	(_display displayCtrl 1400) ctrlSetText format ["%1",_station getVariable ["gallonprice",DEFGALLONPRICE]];

	//pump 1
	_gallons = (_station getVariable ["pump1",[0,0]]) select 0;
	_price = (_station getVariable ["pump1",[0,0]]) select 1;
	(_display displayCtrl 1401) ctrlSetText format ["%1 Gallons",_gallons]; //set gallons used
	(_display displayCtrl 1402) ctrlSetText format ["%1%2","$",_price]; //set total price

	//pump 2
	_gallons = (_station getVariable ["pump2",[0,0]]) select 0;
	_price = (_station getVariable ["pump2",[0,0]]) select 1;
	(_display displayCtrl 1403) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1404) ctrlSetText format ["%1%2","$",_price];

	//pump 3
	_gallons = (_station getVariable ["pump3",[0,0]]) select 0;
	_price = (_station getVariable ["pump3",[0,0]]) select 1;
	(_display displayCtrl 1405) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1406) ctrlSetText format ["%1%2","$",_price];

	//pump 4
	_gallons = (_station getVariable ["pump4",[0,0]]) select 0;
	_price = (_station getVariable ["pump4",[0,0]]) select 1;
	(_display displayCtrl 1407) ctrlSetText format ["%1 Gallons",_gallons];
	(_display displayCtrl 1408) ctrlSetText format ["%1%2","$",_price];

	//set storage gallons
	(_display displayCtrl 1409) ctrlSetText format ["%1 gallons",(_station getVariable ["petrol",0])];

}] call Server_Setup_Compile;

["A3PL_Hydrogen_Grab",
{
	private ["_intersect","_tank"];
	//_intersect = param [0,objNull];
	_intersect = (nearestObjects [player,["A3PL_Gas_Hose","A3PL_GasHose"],2]) select 0;
	//if (!(typeOf _intersect IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {["System: You are not looking at a gas hose", Color_Red] call A3PL_Player_Notification;};
	if ((isPlayer attachedTo _intersect) && (!((attachedTo _intersect) isKindOf "Car"))) exitwith {["System: This gas hose is already attached to a player", Color_Red] call A3PL_Player_Notification;};

	_tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
	if (typeOf _intersect == "A3PL_GasHose") then {_tank = nearestObjects [player, ["A3PL_Fuel_Van"], 30];};
	if (count _tank == 0) exitwith {["System: Cannot find a nearby gas box, are you not near a gas station?", Color_Red] call A3PL_Player_Notification;};
	_tank = _tank select 0;

	_intersect attachto [player, [0,0,0.2], 'RightHand'];
	if (typeOf _intersect == "A3PL_GasHose") then {_intersect setDir 180};
	sleep 1.5;
	[_tank,player] remoteExec ["A3PL_Lib_ChangeLocality", 2];
	[_intersect,player] remoteExec ["A3PL_Lib_ChangeLocality", 2];

	player_Item = _intersect;
	while {attachedTo _intersect == player} do
	{
		if (((typeOf _tank == "A3PL_Gas_Box") && (_intersect distance _tank > 5))or((typeOf _tank == "A3PL_Fuel_Van") && (_intersect distance _tank > 28))) exitwith {detach _intersect;["System: The fuel hose was dropped because you walked too far away from the gas station", Color_Red] call A3PL_Player_Notification;};
		if (!(vehicle player == player)) exitwith {detach _intersect; ["System: You entered a vehicle and the refuel was cancelled", Color_Red] call A3PL_Player_Notification;};
		uisleep 1;
	};
	player_Item = objNull;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_LoadPetrol",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_barrel","_tanker"];
	_barrel = param [0,objNull];
	_tanker = (nearestObjects [player, ["A3PL_Tanker_Trailer"], 10]) select 0;
	if (isNil "_tanker") exitwith {["System: Unable to find a tanker trailer nearby",Color_Red] call A3PL_Player_Notification;};

	deleteVehicle _barrel;
	_tanker setVariable ["petrol",(_tanker getVariable ["petrol",0]) + 42,true];
	[format ["System: You loaded this tanker with petrol (there is %1 gallons in the tank now)",(_tanker getVariable ["petrol",0])],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_LoadKerosene",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_barrel","_tanker"];
	_barrel = param [0,objNull];
	_tanker = (nearestObjects [player, ["A3PL_Fuel_Van"], 10]) select 0;
	if (isNil "_tanker") exitwith {["System: Unable to find a Fuel Truck nearby",Color_Red] call A3PL_Player_Notification;};

	deleteVehicle _barrel;
	_tanker setVariable ["petrol",(_tanker getVariable ["petrol",0]) + 94,true];
	[format ["System: You loaded this Fuel Truck with Kerosene (there is %1 gallons in the tank now)",(_tanker getVariable ["petrol",0])],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_Connect",
{
	private ["_intersect","_attached","_hose","_tank","_dir"];
	_intersect = param [0,objNull];

	//check if we are holding a hose
	_attached = [] call A3PL_Lib_Attached;
	if (count _attached == 0) exitwith {["System: You don't seem to be holding a fuel hose", Color_Red] call A3PL_Player_Notification;};
	_hose = _attached select 0;
	if (!(typeOf _hose IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {["System: You don't seem to be holding a fuel hose", Color_Red] call A3PL_Player_Notification;};
	_tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
	//if (count _tank == 0) exitwith {["System: Cannot find a nearby fuel box, are you not near a fuel station?", Color_Red] call A3PL_Player_Notification;};
	_tank = _tank select 0;

	//if we are connecting it back
	if ((typeOf _intersect == "Land_A3PL_Gas_Station") && (player_nameintersect IN ["hoseback1","hoseback2","hoseback3","hoseback4"])) exitwith
	{
		detach _hose;
		switch (player_nameintersect) do
		{
			case ("hoseback1"): {_hose attachTo [_tank,[-0.012,-0.09,-1.18]];};
			case ("hoseback2"): {_hose attachTo [_tank,[-0.012,-0.09,-1.18]];}; //we'll do these later
			case ("hoseback3"): {_hose attachTo [_tank,[-0.006,-0.13,-1.23]];};
			case ("hoseback4"): {_hose attachTo [_tank,[-0.006,-0.13,-1.23]];};
		};

		player_Item = objNull;
	};

	//attach it to the car
	if (!(_intersect isKindOf "All")) exitwith {["System: You are not interacting with a vehicle", Color_Red] call A3PL_Player_Notification;};
	_classname = typeOf player_objintersect;
	_vector = [[0.320857,-0.0197785,-0.946921],[0.946907,0.0282805,0.320261]];
	_attachTo = [-0.1,0,0];
	_maxlength = 0;
	_setdir = 270;
	systemChat format ["%1",_classname];
	if (typeOf _hose == "A3PL_Gas_Hose") then
	{
		switch (true) do
		{
			case (_classname IN ["A3PL_P362","A3PL_P362_TowTruck","A3PL_P362_Garbage_Truck"]): {_vector = [[-0.584987,0.000326949,-0.811043],[0.811043,-0.000109344,-0.584987]];_attachTo = [-0.08,0,0.05];};
			case (_classname IN ["A3PL_Rover"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [-0.1,0,-0.04];};
			case (_classname IN ["A3PL_BMW_M3"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [-0.04,0,-0.04];};
			case (_classname IN ["A3PL_911GT2"]): {_vector = [[-0.584987,0.000326949,-0.811043],[0.811043,-0.000109344,-0.584987]];_attachTo = [-0.07,0,0.04];};
			case (_classname IN ["A3PL_RBM"]): {_vector = [[-0.213246,-0.0863852,-0.973172],[-0.976888,0.0338489,0.211056]];_attachTo = [0.1,0,0];};
			case (_classname IN ["red_taurus_13_base","red_explorer_16_base","red_camaro_18_base","red_hellcat_15_base"]): {_vector = [[-.5,0,-1],[-1,0,0]];_attachTo = [0.1,0,-0.05];};
			case (_classname IN ["red_huracan_17_base"]): {_vector = [[0.4,0,-1],[-1,0,0]];_attachTo = [0.1,0,0.04];};
			case (_classname IN ["red_hellcat_15_base"]): {_vector = [[0,0,-1],[1,0,0]];_attachTo = [-0.15,0,-0.05];};
			default {_vector = [[0.320857,-0.0197785,-0.946921],[0.946907,0.0282805,0.320261]];_attachTo = [-0.1,0,0];_maxlength = 7;};
		};

		/*Use this, in debug, after setting the cursorObject(while looking at the gas nozzel) to myGasPump

		myGasPump attachTo [nearestObject [player,"red_hellcat_15_base"],[-0.15,0,-0.05],"gastank"]; 
	myGasPump setVectorDirAndUp [[0,0,-1],[1,0,0]];*/

		//hintSilent format ["%1 ==== %2",_vector,_attachTo];
		_hose attachTo [_intersect,_attachTo,"gasTank"];
		uiSleep 0.2;
		_hose setVectorDirAndUp _vector;
		_maxlength = 10;
	};
	if (typeOf _hose == "A3PL_GasHose") then
	{
		switch (true) do
		{
			case (_classname IN ["A3PL_RBM"]): {_setdir = 90;_attachTo = [0.1,0,0];_maxlength = 30;};
			case (_classname IN ["Heli_Medium01_H","Heli_Medium01_Luxury_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Medic_H"]): {_setdir = 90;_attachTo = [0.1,0,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Cessna172","A3PL_Goose_Base","A3PL_Goose_Radar","A3PL_Goose_USCG"]): {_setdir = 90;_attachTo = [0,0,-0.07];_maxlength = 30;_vector = [[0.0389273,-0.110648,-0.993097],[0.0389949,-0.992925,0.112158]];};
			case (_classname IN ["A3PL_RHIB","A3PL_Yacht"]): {_setdir = 180;_attachTo = [0,-0.1,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Jayhawk"]): {_setdir = 90;_attachTo = [0.2,0,0];_maxlength = 30;};
			case (_classname IN ["A3PL_Motorboat"]): {_setdir = 90;_attachTo = [0,0,0.07];_maxlength = 30;_vector = [[0,-0.110648,0.993097],[0,-0.992925,-0.112158]];hint"true";};
			default {_setdir = 270;_attachTo = [-0.1,0,0];_maxlength = 30;};
		};
		_hose attachTo [_intersect,_attachTo,"gasTank"];
		_dir = getDir _hose;
		uiSleep 0.2;
		if (_classname IN ["A3PL_Cessna172","A3PL_Goose_Base","A3PL_Goose_Radar","A3PL_Goose_USCG","A3PL_Motorboat"]) then {_hose setVectorDirAndUp _vector;}else
		{_hose setDir (_dir + (_setdir - (getDir _intersect)));};
		_tank = nearestObject [player, "A3PL_Fuel_Van"];
	};
	["System: You connected the fuel hose to a vehicle", Color_Green] call A3PL_Player_Notification;
	while {attachedTo _hose == _intersect} do
	{
		uiSleep 0.1;
		//hintSilent format ["%1,%2,%3",_hose,_tank,(_hose distance _tank)];
		if ((_hose distance _tank) > _maxlength) exitwith
		{
			detach _hose;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Hydrogen_SetNumbers",
{
	private ["_station","_pumpNumber","_gallons","_price","_gallonAD","_gallonBD","_priceAD","_priceBD"];
	_station = param [0,objNull];
	_pumpNumber = param [1,1];
	_gallons = param [2,"0.00"]; //string!
	_price = param [3,"0.00"];

	//format numbers first
	_gallonBD = (_gallons splitstring ".") select 0;
	_gallonAD = (_gallons splitstring ".") select 1;
	_priceBD = (_price splitstring ".") select 0;
	_priceAD = (_price splitstring ".") select 1;

	//format the gallonBD
	switch (count _gallonBD) do
	{
		case (1): {_gallonBD = format ["0000%1",_gallonBD]};
		case (2): {_gallonBD = format ["000%1",_gallonBD]};
		case (3): {_gallonBD = format ["00%1",_gallonBD]};
		case (4): {_gallonBD = format ["0%1",_gallonBD]};
		case (5): {_gallonBD = format ["%1",_gallonBD]};
	};

	//format the priceBD
	switch (count _priceBD) do
	{
		case (1): {_priceBD = format ["0000%1",_priceBD]};
		case (2): {_priceBD = format ["000%1",_priceBD]};
		case (3): {_priceBD = format ["00%1",_priceBD]};
		case (4): {_priceBD = format ["0%1",_priceBD]};
		case (5): {_priceBD = format ["%1",_priceBD]};
	};


	//figure out from which hiddenSelection to start setting numbers for price
	_startSel = 2 + ((_pumpNumber - 1) * 16);
	for "_i" from 0 to 7 do //8numbers
	{
		if (_i == 5) then {_station setObjectTextureGlobal [_startSel,""]}; //the decimal, we use an empty texture for now
		if (_i < 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_priceBD select [_i,1]]];}; //before decimal
		if (_i > 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_priceAD select [(_i-6),1]]];}; //after decimal
		_startSel = _startSel + 1;
	};


	//do the same for gallons
	_startSel = 10 + ((_pumpNumber - 1) * 16);
	for "_i" from 0 to 7 do //8numbers
	{
		if (_i == 5) then {_station setObjectTextureGlobal [_startSel,""]}; //the decimal, we use an empty texture for now
		if (_i < 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_gallonBD select [_i,1]]] }; //before decimal
		if (_i > 5) then { _station setObjectTextureGlobal [_startSel,format ["\A3PL_Common\HydrogenNumbers\%1.paa",_gallonAD select [(_i-6),1]]] }; //after decimal
		_startSel = _startSel + 1;
	};

}] call Server_Setup_Compile;

["A3PL_Hydrogen_LoadPetrolStation",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_barrel","_station"];
	_barrel = param [0,objNull];
	_station = (nearestObjects [player, ["Land_A3PL_Gas_Station"], 7]) select 0;
	if (isNil "_station") exitwith {["System: Cannot find fuel station!",Color_Red] call A3PL_Player_Notification;};

	deleteVehicle _barrel;
	_station setVariable ["petrol",(_station getVariable ["petrol",0]) + 42,true];
	[format ["System: You have successfully loaded the barrel into the station tank (Current amount: %1 gallons)",(_station getVariable ["petrol",0])],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Hydrogen_SwitchFuel",
{
	private ["_intersect","_tank","_car","_gallonPrice","_myPrice","_station","_gallons","_pumpNumber","_newgas","_totalGallons"];
	_intersect = param [0,objNull];

	if (isNil "CBA_fnc_formatNumber") exitwith {["System: CBA not enabled, you dumb ass!", Color_Red] call A3PL_Player_Notification;}; //just in-case
	if (!(typeOf _intersect IN ["A3PL_Gas_Hose","A3PL_GasHose"])) exitwith {["System: You don't seem to be interacting with a fuel hose", Color_Red] call A3PL_Player_Notification;};
	if (typeOf _intersect == "A3PL_Gas_Hose") then
	{
		_tank = nearestObjects [player, ["A3PL_Gas_Box"], 30];
		if (count _tank == 0) exitwith {["System: Cannot find a nearby fuel box, are you not near a fuel station?", Color_Red] call A3PL_Player_Notification;};
		_tank = _tank select 0;

		if (_intersect animationPhase "gasTurn" > 0) exitwith
		{
			//turn off the fuel pump
			_intersect animate ["gasTurn",0];
			//delete the sound
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {
					deleteVehicle _x;
				};
			} foreach nearestObjects [_tank,[],5];
		};

		_car = attachedTo _intersect;
		if ((isNull _car) or (!(_car isKindOf "Car"))) exitwith {["System: The fuel hose is not connected to a vehicle", Color_Red] call A3PL_Player_Notification;};

		if (!local _car) exitwith {["System: Locality issue, please enter and exit the vehicle you are trying to fill up", Color_Red] call A3PL_Player_Notification;};

		//get the station object
		_station = nearestObjects [_tank,["Land_A3PL_Gas_Station"],10];
		if (count _station < 1) exitwith {["System Error: Couldn't find gas station", Color_Red] call A3PL_Player_Notification;};
		_station = _station select 0;
		if ((_station getVariable ["petrol",0]) <= 0) exitwith {["System: No petrol left in gas station storage",Color_Red] call A3PL_Player_notification;};
		createSoundSource ["A3PL_GasPump",getpos _tank, [], 0];

		_intersect animate ["gasTurn",1];

		//wait until the animate value changes
		_i = 0;
		waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_intersect animationPhase "gasTurn" > 0)};

		_gallonPrice = _station getVariable ["gallonprice",DEFGALLONPRICE];
		_myPrice = 0;
		_totalGallons = 0;
		_pumpNumber = 1; //figure out our pump number
		switch (format ["%1",_tank]) do
		{
			case ("A3PL_GasBox1"): {_pumpNumber = 1;}; //only one pump at the moment per gas station
			case ("A3PL_GasBox2"): {_pumpNumber = 1;};
			case ("A3PL_GasBox3"): {_pumpNumber = 1;};
			case ("A3PL_GasBox4"): {_pumpNumber = 1;};
		};
		while {(_intersect animationPhase "gasTurn" > 0) && (attachedTo _intersect == _car) && ((_station getVariable ["petrol",0]) > 0)} do
		{
			_gallons = 0.25 + random 0.15;
			_totalgallons = _totalGallons + _gallons; //gallons that go into the tank per sec
			_myPrice = _gallonPrice * _totalGallons;

			//set the price/gallons numbers on the pump here
			[_station,_pumpNumber,([_totalGallons,1,2] call CBA_fnc_formatNumber),([_myprice,1,2] call CBA_fnc_formatNumber)] call A3PL_Hydrogen_SetNumbers;

			_car setFuel ((fuel _car) + (_totalGallons / 350));
			//[format ["System: Car fuel tank level: %1%2 | Total cost: $%3",round ((fuel _car)*100),"%",_myprice], Color_Green] call A3PL_Player_Notification; turned off
			if ((fuel _car) >= 1) exitwith {};
			_newgas = (_station getVariable ["petrol",0]) - _gallons;
			if (_newGas < 0) then {_newGas = 0;};
			_station setVariable ["petrol",_newGas,true];
			//hintSilent format ["%1",_myPrice];
			uiSleep 1;
		};
		//take money
		if ((_station getVariable ["petrol",0]) <= 0) then {["System: No petrol left in gas station storage",Color_Red] call A3PL_Player_notification;};
		[format ["System: Car filling finished/interrupted, total cost: $%1",_myprice], Color_Green] call A3PL_Player_Notification;
		//set some variables on the station itself so that we can reference it in the GUI of the gas station operator

		_station setVariable [format ["pump%1",_pumpNumber],[[_totalGallons,1,2] call CBA_fnc_formatNumber,[_myprice,1,2] call CBA_fnc_formatNumber],true]; //we only do this after 100% finished to prevent setvariabling every second, thus the gas station operator will only see the price after reaching 100%

		//animate back
		_intersect animate ["gasTurn",0];
		{
			_type = format["%1",typeOf _x];
			if(_type == "#dynamicsound") then {
				deleteVehicle _x;
			};
		} foreach nearestObjects [_tank,[],5];
	};
	if (typeOf _intersect == "A3PL_GasHose") then
	{
		_tank = nearestObjects [player, ["A3PL_Fuel_Van"], 30];
		if (count _tank == 0) exitwith {["System: Cannot find a nearby fuel truck", Color_Red] call A3PL_Player_Notification;};
		_tank = _tank select 0;
		if (_intersect animationPhase "gasTurn" > 0) exitwith
		{
			//turn off the fuel pump
			_intersect animate ["gasTurn",0];
			//delete the sound
			{
				_type = format["%1",typeOf _x];
				if(_type == "#dynamicsound") then {
					deleteVehicle _x;
				};
			} foreach nearestObjects [_tank,[],5];
		};
		_car = attachedTo _intersect;
		_intersect animate ["gasTurn",1];
		_i = 0;
		waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_intersect animationPhase "gasTurn" > 0)};

		_myPrice = 0;
		_totalGallons = 0;

		if ((isNull _car) or ((_car isKindOf "Land"))) exitwith {["System: The fuel hose is not connected to a vehicle", Color_Red] call A3PL_Player_Notification;};

		if (!local _car) exitwith {["System: Locality issue, please enter and exit the vehicle you are trying to fill up", Color_Red] call A3PL_Player_Notification;};
		createSoundSource ["A3PL_GasPump",getpos _tank, [], 0];
		while {(_intersect animationPhase "gasTurn" > 0) && (attachedTo _intersect == _car) && ((_tank getVariable ["petrol",0]) > 0)&& ({(typeOf _x == "a3pl_fd_hoseend1")} forEach attachedObjects _tank)} do
		{
			_gallons = 1 + random 0.60;
			_totalgallons = _totalGallons + _gallons; //gallons that go into the tank per sec

			//set the price/gallons numbers on the pump here
			_car setFuel ((fuel _car) + (_totalGallons / 1400));
			if ((fuel _car) >= 1) exitwith {};
			_newgas = (_tank getVariable ["petrol",0]) - _gallons;
			if (_newGas < 0) then {_newGas = 0;};
			_tank setVariable ["petrol",_newGas,true];
			//hintSilent format ["%1",_myPrice];
			uiSleep 1;
		};
		_Gas = round (_tank getVariable ["petrol",0]);
		if ((_tank getVariable ["petrol",0]) <= 0) then {["System: No fuel left in truck",Color_Red] call A3PL_Player_notification;};
		[format ["System: Filling finished/interrupted, %1 gallons remaining in truck",_Gas], Color_Green] call A3PL_Player_Notification;
		_intersect animate ["gasTurn",0];
		{
			_type = format["%1",typeOf _x];
			if(_type == "#dynamicsound") then {
				deleteVehicle _x;
			};
		} foreach nearestObjects [_tank,[],5];
	};
}] call Server_Setup_Compile;

//when we press the switch on the petrol storage
["A3PL_Hydrogen_StorageSwitch",
{
	private ["_station","_i","_adapter","_end","_source","_newSource","_newStorage","_amount"];
	_station = param [0,objNull];

	//toggle off IF on
	if (_station animationSourcePhase "hoseSwitch" > 0) exitwith {_station animateSource ["hoseSwitch",0]}; //turn pump off

	//checks
	_adapter = nearestObjects [(_station modelToWorld [-3.76154,3.51953,-2.05121]), ["A3PL_FD_HoseEnd1_Float"], 1];
	_adapter = _adapter select 0;
	if (isNil "_adapter") exitwith {["System: No hose adapter connected to this gas storage",Color_Red] call A3PL_player_notification;};
	_end = attachedObjects _adapter;
	_end = _end select 0;
	if (isNil "_end") exitwith {["System: No hose connected to the hose adapter",Color_Red] call A3PL_player_notification;};
	_source = [_end] call A3PL_FD_FindSource; //source
	if (isNull _source) exitwith {["System: Could not find a valid source to pump petrol from",Color_Red] call A3PL_player_notification;};
	if ((_source getVariable ["petrol",0]) <= 0) exitwith {["System: No petrol could be find inside the source, is it empty?",Color_Red] call A3PL_player_notification;};

	//start pumping
	_station animateSource ["hoseSwitch",1];
	_i = 0;
	waitUntil {sleep 0.1; _i = _i + 0.1; if (_i > 5) exitwith {true}; (_station animationSourcePhase "hoseSwitch" > 0)};
	while {((_source getVariable ["petrol",0]) > 0) && (!isNull _source) && (_station animationSourcePhase "hoseSwitch" > 0)} do
	{
		_amount = 1.5;
		if ((_source getVariable ["petrol",0]) < _amount) then {_amount = _source getVariable ["petrol",0]};
		_newSource = (_source getVariable ["petrol",0]) - _amount; if (_newSource < 0) then {_newSource = 0;};
		_newStorage = (_station getVariable ["petrol",0]) + _amount; if (_newStorage < 0) then {_newStorage = 0;};
		_source setVariable ["petrol",_newSource,true];
		_station setVariable ["petrol",_newStorage,true];
		[format ["Pumping | Source remaining: %1 | Storage: %2",_newSource,_newStorage],Color_Green] call A3PL_player_notification;
		uiSleep 2;
		_source = [_end] call A3PL_FD_FindSource;
	};
	["System: Pumping completed/interrupted",Color_Green] call A3PL_Player_Notification;
	_station animateSource ["hoseSwitch",0];
}] call Server_Setup_Compile;
