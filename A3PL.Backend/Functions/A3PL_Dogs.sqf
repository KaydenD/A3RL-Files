#define DOGSMELLDISTANCE 10
#define DOGSMELLDISTANCEINCAR 1
["A3PL_Dogs_OpenMenu",
{
	createDialog "Dialog_Kane9";
	buttonSetAction [1600, "[] call A3PL_Dogs_BuyRequest"];
	_dogs = ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"];

	{
		_i = lbAdd [1500,_x];
		lbSetData [1500,_i,_x];
	} foreach _dogs;
}] call Server_Setup_Compile;

["A3PL_Dogs_BuyRequest",
{
	private ["_class"];
	_class = lbData [1500,(lbCurSel 1500)];
	_dogprice = 100;

	if ((player getvariable ["player_cash",0]) < _dogprice) exitwith {["System: You don't have enough money to buy this dog",Color_Red] call A3PL_Player_Notification;};
	["System: Send request to server to buy this dog",Color_Green] call A3PL_Player_Notification;

	[[player,_class],"Server_Dogs_BuyRequest",false] call BIS_FNC_MP;
	closeDialog 0;

}] call Server_Setup_Compile;

["A3PL_Dogs_BuyReceive",
{
	private ["_class","_dog"];

	_class = param [0,"Alsatian_Sand_F"];

	_dog = createAgent [_class, getPosATL player, [], 1, "CAN_COLLIDE"];
	_dog allowDamage false;
	_dog setposATL (getposATL player);
	_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

	_dog playMove "Dog_Sprint";

	0 = [_dog] spawn
	{
		private ["_set","_setSit","_dog","_notInCar","_attachPoint","_doDrugsCheck"];
		_dog = param [0,objNull];

		_set = false;
		_setSit = true;
		_notInCar = true;
		_doDrugsCheck = 0;

		while {alive _dog} do
		{
			sleep 0.5;

			if (vehicle player != player) then
			{
				//check if dog is not attached
				if (!(attachedTo _dog == (vehicle player))) then
				{
					_attachPoint = [0,-0.2,-0.6];
					_notInCar = false;
					switch (typeOf (vehicle player)) do
					{
						case ("A3PL_Tahoe_FD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Tahoe_PD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Tahoe_PD_Slicktop"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_CVPI_PD"): {_attachPoint = [0,-0.3,-1.1]};
						case ("A3PL_CVPI_PD_Slicktop"): {_attachPoint = [0,-0.3,-1.1]};
						case ("A3PL_Mustang_PD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Mustang_PD_Slicktop"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Charger_PD"): {_attachPoint = [0,0.2,-1.1]};
						case ("A3PL_Charger_PD_Slicktop"): {_attachPoint = [0,0.2,-1.1]};
					};
					_dog attachto [vehicle player,_attachPoint];
					_dog setVariable["doFollow",true,true];
					_dog playMoveNow "Dog_Sit";
				};
			};

			// && _dog getVariable["getOutCar",false]
			if ((vehicle player == player)) then
			{
				//check if dog is in a vehicle and detach
				if (!isNull (attachedTo _dog)) then
				{
					detach _dog;
				};
			};

			//take care of custom AI
			if (((player distance _dog) > 4) && _dog getVariable["doFollow",true]) then
			{
				if (_set) then
				{
					if((player distance _dog) > 15) then {
						_dog playMoveNow "Dog_Sprint";
					} else {
						_dog playMoveNow "Dog_Walk";
					};
					_set = false;
					_setSit = true;
				};
				_dog moveTo (getpos player);
			} else
			{
				if (_setSit) then
				{
					_dog playMoveNow "Dog_Stop";
					_set = true;
					_setSit = false;
				};
			};

			//Do a check to see if drugs are nearby and have the dog bark bark
			if (_notInCar) then {
				_doDrugsCheck = _doDrugsCheck + 0.5;
				if (_doDrugsCheck >= 6) then
				{
					private ["_nearbyPlayers","_foundDrugs"];
					_doDrugsCheck = 0;
					_foundDrugs = false;

					//first check for nearbyplayers
					_nearbyPlayers = [];
					{
						if ((_dog distance2D _x) < DOGSMELLDISTANCE) then
						{
							_nearbyPlayers pushback _x;
						};
					} foreach allPlayers;
					//then check if the player has any drugs
					{
						private ["_player"];
						_player = _x;
						{
							if ([_x,1,_player] call A3PL_Inventory_Has) exitwith {_foundDrugs = true;};
						} foreach Player_DogIllegalItems;
					} foreach _nearbyPlayers;

					//now look for nearestItems
					if ((count (nearestObjects [_dog,["A3PL_Cannabis_Bud","A3PL_MarijuanaBag","A3PL_PowderedMilk","A3PL_TacticalBacon","A3PL_Marijuana","A3PL_Seed_Marijuana"], DOGSMELLDISTANCE])) > 0) then {_foundDrugs = true; };

					if (_foundDrugs) then { playSound3D ["A3PL_Common\effects\dogbark.ogg", _dog, true, _dog, 7, 1, 50]; };
				};
			} else {
				if (speed _dog == 0) then {
					_doDrugsCheck = _doDrugsCheck + 0.5;
					if (_doDrugsCheck >= 6) then
					{
						private ["_nearbyPlayers","_foundDrugs"];
						_doDrugsCheck = 0;
						_foundDrugs = false;

						//first check for nearbyplayers
						_nearbyPlayers = [];
						{
							if ((_dog distance2D _x) < DOGSMELLDISTANCEINCAR) then
							{
								_nearbyPlayers pushback _x;
							};
						} foreach allPlayers;
						//then check if the player has any drugs
						{
							private ["_player"];
							_player = _x;
							{
								if ([_x,1,_player] call A3PL_Inventory_Has) exitwith {_foundDrugs = true;};
							} foreach Player_DogIllegalItems;
						} foreach _nearbyPlayers;

						//now look for nearestItems
						if ((count (nearestObjects [_dog,["A3PL_Cannabis_Bud","A3PL_MarijuanaBag","A3PL_PowderedMilk","A3PL_TacticalBacon","A3PL_Marijuana","A3PL_Seed_Marijuana"], DOGSMELLDISTANCEINCAR])) > 0) then {_foundDrugs = true; };

						if (_foundDrugs) then { playSound3D ["A3PL_Common\effects\dogbark.ogg", _dog, true, _dog, 7, 1, 50]; };
					};
				};
			};
		};
	};

	["System: You succesfully bought a dog, the dog will follow you and barks when he smells any drugs nearby (whether a player, an item, etc.)",Color_Green] call A3PL_Player_Notification;
	[_dog] remoteExec ["Server_Dogs_HandleLocality", 2];

}] call Server_Setup_Compile;
