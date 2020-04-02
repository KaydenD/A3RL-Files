["A3PL_Police_GPS",
{
	private ["_job"];
	_job = player getVariable ["job","unemployed"];
	if (!(_job IN ["uscg","police","fifr","faa","doc","doj","usms"])) exitwith {};
	if (!isNil "A3PL_Police_GPSEnabled") exitwith {};

	//vars

	//get identifier and vehicles
	A3PL_Police_GPSEnabled = true;
	[_job] spawn
	{
		private ["_vehicles","_identifier","_markercolor"];
		_job = param [0,"unemployed"];
		while {(player getVariable ["job","unemployed"]) == _job} do
		{
			sleep 0.5;
			if (visibleMap) then
			{
				_vehicles = [];
				switch (_job) do
				{
					case ("uscg"):
					{
						_identifier = "USCG UNIT #";
						_markercolor = "ColorBlue";
						{
							if (((typeOf _x) find "_RBM") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_Jayhawk") != -1) then
							{
								_vehicles pushback _x;
							};
						} foreach vehicles;
					};
					case ("police"):
					{
						_identifier = "SQUAD CAR #";
						_markercolor = "ColorBlue";
						{
							if (((typeOf _x) find "_PD") != -1) then
							{
								_vehicles pushback _x;
							};
						} foreach vehicles;
					};
					case ("usms"):
					{
						_identifier = "SQUAD CAR #";
						_markercolor = "ColorBlue";
						{
							if (((typeOf _x) find "_PD") != -1) then
							{
								_vehicles pushback _x;
							};
						} foreach vehicles;
					};
					case ("fifr"):
					{
						_identifier = "FIFR UNIT #";
						_markercolor = "ColorRed";
						{
							if (((typeOf _x) find "_Pierce") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_Ambulance") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_E350") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_FD") != -1) then
							{
								_vehicles pushback _x;
							};
						} foreach vehicles;
					};
					case ("faa"):
					{
						_identifier = "Aircraft #";
						_markercolor = "ColorYellow";
						{
							if (((typeOf _x) find "_Jayhawk") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_Goose") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_Cessna172") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "Heli_Medium01") != -1) then
							{
								_vehicles pushback _x;
							};
							if (((typeOf _x) find "_Heli_Light") != -1) then
							{
								_vehicles pushback _x;
							};
						} foreach vehicles;
					};
				};

				//vehicle markers
				if (!isNil "A3PL_Police_GPSmarkers") then
				{
					{
						 deleteMarkerLocal _x;
					} foreach A3PL_Police_GPSmarkers;
				};
				A3PL_Police_GPSmarkers = [];
				{
					_marker = createMarkerLocal [format["unit_%1",round (random 1000)],visiblePosition _x];
					_marker setMarkerColorLocal _markerColor;
					_marker setMarkerTypeLocal "Mil_dot";
					_marker setMarkerAlphaLocal 0.5;
					_marker setMarkerTextLocal format["%1%2",_identifier, _forEachIndex];
					A3PL_Police_GPSmarkers pushback _marker;
				} foreach _vehicles;

				//prisoner markers
				if ((player getVariable ["job","unemployed"]) IN ["doj","usms"]) then
				{
					if (!isNil "A3PL_Police_PrisonerMarkers") then
					{
						{
							deleteMarkerLocal _x;
						} foreach A3PL_Police_PrisonerMarkers;
					};
					A3PL_Police_PrisonerMarkers = [];
					{
						if ((_x getVariable ["jailtime",0]) > 0) then
						{
							_marker = createMarkerLocal [format["Prisoner_%1",round (random 1000)],visiblePosition _x];
							_marker setMarkerColorLocal "ColorYellow";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerAlphaLocal 0.5;
							_marker setMarkerTextLocal format["PRISONER_%1 (timeleft: %2min)",(_x getVariable ["name","UNKNOWN"]), (_x getVariable ["jailtime",0])];
							A3PL_Police_PrisonerMarkers pushback _marker;
						};
					} foreach allPlayers;
				};
			};
		};
		A3PL_Police_GPSEnabled = nil;
		{deleteMarkerLocal _x} foreach A3PL_Police_GPSmarkers;
		A3PL_Police_GPSmarkers = nil;
	};
}] call Server_Setup_Compile;

["A3PL_Police_PatDown",
{
	disableSerialization;
	private ["_target","_display","_control","_items","_weps","_mags","_targetPos"];
	_target = param [0,objNull];

	/* //if we are a member of the faa
	if (((player getVariable ["faction","citizen"]) == "faa") && ((player distance2d npc_faastart) > 300)) exitwith
	{
		["System: As an FAA member, you can only perform a pat down near the airfield"] call A3PL_Player_Notification;
	}; */

	//already action
	if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};

	//already patdown
	if (_target getVariable ["patdown",false]) exitwith {["System: This player is already being searched!",Color_Red] call A3PL_Player_Notification;};
	_target setVariable ["patdown",true,true];

	//send message to target
	[format["System: Someone is attempting to perform a pat down on you, you can move away to abort the pat down!"], Color_Green] remoteExec ["A3PL_Player_Notification",_target];

	//start timer
	Player_ActionCompleted = false;
	_targetPos = getpos _target;
	["Attempting pat down...",3+random 2] spawn A3PL_Lib_LoadAction;
	while {sleep 1; !Player_ActionCompleted } do
	{
		if ((_targetPos distance (getpos _target)) > 0.5) exitwith {player playMove ""; true;};
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};
	if ((_targetPos distance (getpos _target)) > 0.5) exitwith
	{
		["System: Pat down cancelled, target moved during pat down",Color_Red] call A3PL_Player_Notification;
		["System: You moved away, pat down has been cancelled", Color_Green] remoteExec ["A3PL_Player_Notification",_target];
		_target setVariable ["patdown",nil,true];
	};

	//get items,mags,and weps
	_items = (items _target) + (assignedItems _target);
	_weps = weapons _target;
	_mags = magazines _target;
	if (currentMagazine _target != "") then
	{
		_mags pushback (currentMagazine _target);
	};

	createDialog "Dialog_PatDown";
	_display = findDisplay 93;
	_control = _display displayCtrl 1500;

	//fill items
	{
		_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
		_control lbSetData [_index,_x];
	} foreach _items;

	//fill weps
	_control = _display displayCtrl 1501;
	{
		_index = _control lbAdd format ["%1",getText (configFile >> "CfgWeapons" >> _x >> "displayName")];
		_control lbSetData [_index,_x];
	} foreach _weps;

	//fill mags
	_control = _display displayCtrl 1502;
	{
		_index = _control lbAdd format ["%1",getText (configFile >> "CfgMagazines" >> _x >> "displayName")];
		_control lbSetData [_index,_x];
	} foreach _mags;

	//EventHandlers
	_control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["buttonDown",{["item"] call A3PL_Police_PatDownTake}];
	_control = _display displayCtrl 1601;
	_control ctrlAddEventHandler ["buttonDown",{["wep"] call A3PL_Police_PatDownTake}];
	_control = _display displayCtrl 1602;
	_control ctrlAddEventHandler ["buttonDown",{["mag"] call A3PL_Police_PatDownTake}];

	A3PL_Police_Target = _target;
	_display displayAddEventHandler ["unload",{A3PL_Police_Target setVariable ["patdown",nil,true]; A3PL_Police_Target = nil; A3PL_Police_WeaponHolder = nil;}];

}] call Server_Setup_Compile;

["A3PL_Police_PatDownTake",
{
	disableSerialization;
	private ["_type","_class","_target","_weaponHolder","_display","_control","_itemName"];
	_type = param [0,""];
	_display = findDisplay 93;
	if (isNil "A3PL_Police_Target") exitwith {["System: Error in Police_PatDownTake :: _target is undefined"] call A3PL_Player_Notification;};
	_target = A3PL_Police_Target;
	if (isNil "A3PL_Police_WeaponHolder") then
	{
		A3PL_Police_WeaponHolder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
	} else
	{
		if (isNull A3PL_Police_WeaponHolder) then
		{
			A3PL_Police_WeaponHolder = createVehicle ["GroundWeaponHolder", getposATL player, [], 0, "CAN_COLLIDE"];
		};
	};
	_weaponHolder = A3PL_Police_WeaponHolder;

	//remove from target
	switch (_type) do
	{
		case ("item"):
		{
			_control = _display displayCtrl 1500;
			_class = _control lbData (lbCurSel _control);
			_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
			if (_class IN (assignedItems _target)) then
			{
				_target unAssignItem _class;
			};
			_target removeItem _class;
			_weaponHolder addItemCargoGlobal [_class,1];
		};
		case ("wep"):
		{
			_control = _display displayCtrl 1501;
			_class = _control lbData (lbCurSel _control);
			_itemName = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
			_target removeWeaponGlobal _class;
			_weaponHolder addWeaponCargoGlobal [_class,1];
		};
		case ("mag"):
		{
			_control = _display displayCtrl 1502;
			_class = _control lbData (lbCurSel _control);
			_itemName = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
			_target removeMagazineGlobal _class;
			_weaponHolder addMagazineCargoGlobal [_class,1];
		};
	};

	//remove from dialog
	_control lbDelete (lbCurSel _control);

	//send message to target
	[format ["System: You took 1x %1 from %2",_itemName,_target getVariable ["name",(name _target)]],Color_Green] call A3PL_Player_Notification;
	[format ["System: %2 took 1x %1 from you during his pat down",_itemName,player getVariable ["name",(name player)]],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

['A3PL_Police_Cuff', {
	private ['_obj'];
	_obj = _this select 0;

	//1 No hands up
	//2 Hands up
	//3 Kneeled hands up
	//4 Kneeled
	//5 Prone
	//5 unconscious
	_Cuffed = _obj getVariable ["Cuffed",true];
	if (animationState _obj IN ["amovpercmstpsnonwnondnon","amovpercmstpsraswrfldnon","amovpercmstpsraswpstdnon","amovpercmstpsraswlnrdnon"]) exitwith
	{
		[[player,_obj,1],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

	if (animationState _obj == "a3pl_idletohandsup") exitwith
	{
		[[player,_obj,2],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

	if (animationState _obj == "a3pl_handsuptokneel") exitwith
	{
		[[player,_obj,3],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

	if (animationState _obj IN ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswpstdnon","amovpknlmstpsraswrfldnon","amovpknlmstpsraswlnrdnon"]) exitwith
	{
		[[player,_obj,4],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

	if (animationState _obj IN ["amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemstpsraswpstdnon"]) exitwith
	{
		[[player,_obj,5],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

	if (animationState _obj == "unconscious") exitwith
	{
		[[player,_obj,5],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		[false] call A3PL_Inventory_PutBack;
		["handcuffs", 1] call A3PL_Inventory_Remove;
		_obj setVariable ["Cuffed",Nil,true];
	};

}] call Server_Setup_Compile;

['A3PL_Police_Uncuff', {
	private ['_obj'];
	_obj = _this select 0;

	//7 Uncuff
	_Cuffed = _obj getVariable ["Cuffed",true];
	if ((animationState _obj IN ["a3pl_handsuptokneel"])&&(_Cuffed)) exitwith
	{
		["handcuffs",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Cuffed",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelkicked")&&(_Cuffed)) exitwith
	{
		["handcuffs",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Cuffed",false,true];
	};

	if ((animationState _obj == "a3pl_handsupkneelcuffed")&&(_Cuffed)) exitwith
	{
		["handcuffs",1] call A3PL_Inventory_Add;
		[[player,_obj,7],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
		_obj setVariable ["Cuffed",false,true];
	};

}] call Server_Setup_Compile;

['A3PL_Police_CuffKick', {
	private ['_obj'];
	_obj = _this select 0;

	//6 Kick down

	if (animationState _obj IN ["a3pl_handsupkneelcuffed"]) exitwith
	{
		[[player,_obj,6],"A3PL_Police_HandleAnim",true,false] call BIS_fnc_MP;
	};

}] call Server_Setup_Compile;

['A3PL_Police_HandleAnim', {
	private ['_cop','_civ','_number'];
	_cop = _this select 0;
	_civ = _this select 1;
	_number = _this select 2;

	switch (_number) do
	{
		case 1:
		{
			//setDir of civ
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};

			[_cop,_civ] spawn
			{
				private ["_cop","_civ"];
				_cop = _this select 0;
				_civ = _this select 1;

				_civ switchmove "A3PL_HandsupToKneel";
				sleep 5;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then
				{
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then
				{
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 2:
		{
			[_cop,_civ] spawn
			{
				private ["_cop","_civ"];
				_cop = _this select 0;
				_civ = _this select 1;

				_civ switchmove "A3PL_HandsupToKneel";
				sleep 5;
				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then
				{
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then
				{
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 3:
		{
			[_cop,_civ] spawn
			{
				private ["_cop","_civ"];
				_cop = _this select 0;
				_civ = _this select 1;

				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then
				{
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then
				{
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 4:
		{
			//setDir of civ
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};

			[_cop,_civ] spawn
			{
				private ["_cop","_civ"];
				_cop = _this select 0;
				_civ = _this select 1;

				_civ switchmove "A3PL_HandsupKneelGetCuffed";
				_cop switchmove "A3PL_Cuff";
				if (local _cop) then
				{
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 4;
				if (local _cop) then
				{
					detach _cop;
				};
				_civ switchmove "A3PL_HandsupKneelCuffed";
				_cop switchmove "";
			};
		};
		case 5:
		{
			//setDir of civ
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			_civ switchmove "A3PL_HandsupKneelKicked";
		};

		case 6:
		{
			[_cop,_civ] spawn
			{
				private ["_cop","_civ"];
				_cop = _this select 0;
				_civ = _this select 1;

				_cop switchmove "A3PL_CuffKickDown";
				if (local _cop) then
				{
					_cop attachTo [_civ,[0,0,0]];
				};
				sleep 1;
				_civ switchmove "A3PL_HandsupKneelKicked";
				sleep 3;
				_cop switchmove "";
				if (local _cop) then
				{
					detach _cop;
				};

				if (local _civ) then
				{
					if (!isPlayer _civ) exitwith
					{
						_civ setdir ((getDir _civ) - 50);
					};
					player setdir ((getDir player) - 50);
				};

			};
		};

		case 7:
		{
			_civ spawn
			{
				private ["_cop","_civ"];
				if (local _this) then
				{
					_this setdir ((getDir _this) - 50);
				};

				if (animationState _this == "a3pl_handsupkneelcuffed") then
				{
					_this switchmove "amovpknlmstpsnonwnondnon";
				} else
				{
					_this switchmove "amovppnemstpsnonwnondnon";
				};
			};
		};

	};
}] call Server_Setup_Compile;

['A3PL_Police_Surrender', {
	private ['_obj'];
	_obj = _this select 0;
	_upDown = _this select 1;

	//1 No hands up -> Hands up
	//2 Hands up -> Normal
	//3 Hands up -> kneeled hands up
	//4 Kneeled hands up -> hands up
	//5 Kneeled -> Kneeled hands up
	//6 Prone -> Kneeled hands up

	if (animationState _obj == "amovpercmstpsnonwnondnon") exitwith
	{
		[[player,1],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

	if ((animationState _obj IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (_upDown)) exitwith
	{
		[[player,2],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

	if ((animationState _obj IN ["a3pl_idletohandsup","a3pl_kneeltohandsup"]) && (!_upDown)) exitwith
	{
		[[player,3],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

	if ((animationState _obj == "a3pl_handsuptokneel") && (_upDown)) exitwith
	{
		[[player,4],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

	if (animationState _obj == "amovpknlmstpsnonwnondnon") exitwith
	{
		[[player,5],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

	if (animationState _obj == "amovppnemstpsnonwnondnon") exitwith
	{
		[[player,6],"A3PL_Police_SurrenderAnim",true,false] call BIS_fnc_MP;
	};

}] call Server_Setup_Compile;

['A3PL_Police_SurrenderAnim', {
	private ['_civ','_number'];
	_civ = _this select 0;
	_number = _this select 1;

	switch (_number) do
	{
		case 1:
		{
			//setDir of civ
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) + 50);
				};
				player setdir ((getDir player) + 50);
			};
			_civ switchmove "A3PL_IdleToHandsup";
		};

		case 2:
		{
			//setDir of civ
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "";
		};

		case 3:
		{
			_civ switchmove "A3PL_HandsupToKneel";
		};

		case 4:
		{
			_civ switchmove "A3PL_KneelToHandsup";
		};

		case 5:
		{
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "A3PL_HandsupKneel";
		};

		case 6:
		{
			if (local _civ) then
			{
				if (!isPlayer _civ) exitwith
				{
					_civ setdir ((getDir _civ) - 50);
				};
				player setdir ((getDir player) - 50);
			};
			_civ switchmove "A3PL_HandsupKneel";
		};

	};

}] call Server_Setup_Compile;

['A3PL_Police_DeploySpikes', {
	private ['_obj','_pos','_veh','_dir'];
	_obj = _this select 0;

	//Deploy
	if (typeOf _obj == "A3PL_Spikes_Closed") exitwith
	{
		_pos = getpos _obj;
		_dir = getDir _obj;
		deletevehicle _obj;
		_veh = createVehicle ["A3PL_Spikes_Open", _pos, [], 0, "CAN_COLLIDE"];
		_veh setDir _dir;
		_pos = _veh modelToWorld [1.27,0,0.5];
		_veh setposATL _pos;
	};

	//Pack
	if (typeOf _obj == "A3PL_Spikes_Open") exitwith
	{
		_pos = getpos _obj;
		_dir = getDir _obj;
		deletevehicle _obj;
		_veh = createVehicle ["A3PL_Spikes_Closed", _pos, [], 0, "CAN_COLLIDE"];
		_veh setDir _dir;
		_pos = _veh modelToWorld [-1.27,0,0.5];
		_veh setposATL _pos;
	};
}] call Server_Setup_Compile;

['A3PL_Police_SpikeHit', {
	private ["_wheel","_veh"];
	_veh = vehicle player;
	_wheel = _this;
	[_veh,_wheel] spawn
	{
		private ["_wheel","_veh"];
		_veh = _this select 0;
		_wheel = _this select 1;
		while {(_veh getHit _wheel) < 1} do
		{
			waitUntil {(speed (vehicle player)) > 1};
			_speed = (speed (vehicle player));
			If (_speed < 30) then {_speed = _speed/5;};
			_multiplier = _speed/5000;
			//hintSilent format ["multiplier = %1 speed = %2",_multiplier,_speed];
			_veh setHit [_wheel,((_veh getHit _wheel) + _multiplier)];
			sleep 0.2;
		};
	};
}] call Server_Setup_Compile;

['A3PL_Police_Drag',
{
	private ['_civ',"_dragged"];
	_civ = _this select 0;

	_dragged = _civ getVariable ["dragged",false];
	//stop dragging here
	if (_dragged) exitwith
	{
		_civ setVariable ["dragged",Nil,true];
	};

	if ((animationState _civ IN ["a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked"]) || (surfaceIsWater position player)) then
	{
		[[player],"A3PL_Police_DragReceive",_civ,false] call BIS_FNC_MP; //do not run this in debug it teleports all players to you
	} else
	{
		["System: This player is not handcuffed", Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

['A3PL_Police_DragReceive',
{
	private ["_dragState","_cop"];
	_cop = param [0,objNull];

	["You are now being dragged, please follow the officer", Color_Red] call A3PL_Player_Notification;
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
		["The officer has stopped dragging you", Color_Red] call A3PL_Player_Notification;
		player forceWalk false;
		["gesture_stop"] call A3PL_Lib_Gesture;
		[[player,"a3pl_handsupkneelcuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;
	};
}] call Server_Setup_Compile;

["A3PL_Police_Detain",
{
	private ["_car","_near"];
	_car = param [0,objNull];

	_near = nearestObjects [player,["C_man_1"],5];
	_near = _near - [player];
	if (count _near < 1) exitwith {["There is no player nearby", Color_Red] call A3PL_Player_Notification;};
	_near = _near select 0;
	if (_near getVariable ["dragged",false]) exitwith
	{
		[[_near,""],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;
		[[_car],"A3PL_Lib_MoveInPass",_near,false] call BIS_fnc_MP;
	};
	if (animationState _near IN ["a3pl_handsupkneelcuffed","a3pl_handsupkneelkicked","A3PL_HandsupKneelGetCuffed"]) exitwith
	{
		[[_near,""],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;
		[[_car],"A3PL_Lib_MoveInPass",_near,false] call BIS_fnc_MP;
	};

	["System: Nearest player is not handcuffed or being dragged", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_Impound",
{
	private ["_veh"];
	_veh = player_objIntersect;
	if (isnull _veh) then {_veh = cursorObject};
	if (isNull _veh) exitwith {["System: Couldn't find a vehicle to impound, are you looking at it?", Color_Red] call A3PL_Player_Notification;};
	if(_veh distance player > 7) exitWith {["System: You are too far away from the vehicle to impound it", Color_Red] call A3PL_Player_Notification;};

	if ((_veh isKindOf "Car") && (!((typeOf _veh) IN A3PL_Jobroadworker_MarkBypass))) exitwith {[_veh] call A3PL_JobRoadWorker_ToggleMark;};

	[[_veh],"Server_Police_Impound",false] call BIS_FNC_MP;
	["Server: Attempting to despawn and reset vehicle into storage, it will remove if succeed", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_ImpoundMsg",
{
	["Server: One of your vehicles was impounded and you will have to pay $2000 to get it back.", Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_unDetain",
{
	private ['_car','_pass'];
	_car = _this select 0;
	_pass = crew _car;
	if(player distance _car >= 3) exitWith {};
	if(speed _car >= 4) exitWith {};
	{
		_x action ["getOut", _car];
		[_x,_car]spawn {_pass = _this select 0;_car = _this select 1;if (_pass getVariable ["Cuffed",true]) then {sleep 1.5;_pass setVelocityModelSpace [0,3,1];[[_pass,"a3pl_handsupkneelcuffed"],"A3PL_Lib_SyncAnim",true,false] call BIS_FNC_MP;};};
	} foreach _pass;
	["System: All passengers were ejected", Color_Red] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

['A3PL_Police_DatabaseArgu',{
	params[["_edit","",[""]],["_index",0,[0]]];
	_array = _edit splitString " ";
	_return = _array select _index;
	_return
}] call Server_Setup_Compile;

['A3PL_Police_DatabaseRequireLogin',
[
	"warrantinfo","lookuplicense","lookup"//,"tickethistory"
]
] call Server_Setup_Compile;

['A3PL_Police_DatabaseEnterReceive',
{
	disableSerialization;

	private ["_newstruct","_display","_control"];
	params["_name","_command",["_return",""]];

	_output = "";
	//what command did we use?
	switch (_command) do {

		case "lookup":
		{
			//_return = gender,DOB,warrantAmount,arrestAmount,ticketAmount,warningAmount,reportAmount,pasportDate
			//debug ["male","1/1/1990",1,2,3,4,5]

			if (count _return > 0) then
			{
				_warrantCount = "No";
				if ((_return select 2) > 0) then
				{
					_warrantCount = "<t color='#ff0000'>Yes</t>";
				};

				_output = format ["<t align='center'>Name: %1</t><br /><t align='center'>Gender: %2</t><br /><t align='center'>DOB: %3</t><br /><t align='center'>Pasport issue date: %9</t><br /><t align='center'>Active warrant: %4</t><br /><t align='center'>Warning History Count: %5</t><br /><t align='center'>Ticket History Count: %6</t><br /><t align='center'>Arrest History Count: %7</t><br /><t align='center'>Report History Count: %8</t><br /><t align='center'>Licenses: %10</t><br />",
				_name, // %1
				(_return select 0), // %2
				(_return select 1), // %3
				_warrantCount, // %4
				(_return select 5), // %5
				(_return select 4), // %6
				(_return select 3), // %7
				(_return select 6), // %8
				(_return select 7), // %9
				(_return select 8) // %10
				];
			} else
			{
				_output = format ["Unable to find %1 in the criminal database. (Clean Record)",_name];
			};
		};

		case "lookupvehicles":
		{
			//_return will be in format
			//title,time,issuedby
			if (count _return > 0) then
			{

				{

					_vehName = getText(configFile >>  "CfgVehicles" >>  _x select 1 >> "displayName");

					_stolen = "No";
					if ((_x select 2) == 1) then
					{
						_stolen = "<t color='#ff0000'>Yes</t>";
					};

					_output = _output + (format ["<t align='center'>%1. Plate: %2 - Model: %3 - Stolen: %4</t><br />",_forEachIndex+1,_x select 0,_vehName,_stolen]);
				} foreach _return;
				_output = (_output + "<t align='center'>End Vehicles List</t>");
			} else
			{
				_output = format ["<t align='center'>No Vehicles Found!/t>"];
			};
		};

		case "lookuplicense":
		{
			if(count _return > 1) then {
				_plate = _return select 3;
				_name = _return select 0;
				_class = _return select 2;

				_vehName = getText(configFile >>  "CfgVehicles" >>  _class >> "displayName");

				_stolen = "No";
				if ((_return select 1) > 0) then
				{
					_stolen = "<t color='#ff0000'>Yes</t>";
				};

				_output = format["
				<t align='center'>License plate: %1</t><br />
				<t align='center'>Type: %3</t><br />
				<t align='center'>Owner: %2</t><br />
				<t align='center'>Reported stolen: %4</t><br />",_plate,_name,_vehName,_stolen];
			} else {
				_output = format ["No info available for license plate %1",_license];
			};
		};

		case "lookupaddress":
		{
			if(count _return > 0) then {
				_house = _return select 0;

				_x = _house select 0;

				_array = parseSimpleArray _x;

				_first = _array select 0;
				_second = _array select 1;

				//_x = (_house select 0) select 0;

				//hint str(_first + _second);


				/* _marker = createMarkerLocal ["Queried_House", [_first,_second]];
				_marker setMarkerTypeLocal "Mil_dot";
				_marker setMarkerAlphaLocal 0.5;
				_marker setMarkerColorLocal "Color_Blue";
				_marker setMarkerTextLocal "Queried House!"; */

				_marker = createMarkerLocal [format ["Marked_House_%1",random 4000], [_first,_second]];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "mil_warning";


				_marker setMarkerTextLocal "Queried house!";
				_marker setMarkerColorLocal "ColorRed";


				_output = format["
				<t align='center'>House Marked on map!</t><br />"];
			} else {
				_output = "No known address for that citizen!"
			};
		};

		case "markstolen":
		{
			_output = _return;
		};

		case "markfound":
		{
			_output = _return;
		};

		case "warrantlist":
		{
			//_return will be in format
			//title,time,issuedby
			if (count _return > 0) then
			{

				{
					_output = _output + (format ["<t align='center'>%1. %2 - Issued: %3 - Issued by: %4</t><br />",_forEachIndex+1,_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = (_output + "Use warrantinfo for detailed warrant info<br />");
			} else
			{
				_output = format ["Can't find active warrants for %1",_name];
			};
		};

		case "warrantinfo":
		{
			if (count _return > 0) then
			{
				_output = format ["<t align='center'>Warrant: %1</t><br /><t align='center'>Date issued: %2</t><br /><t align='center'>Issued by: %3</t><br /><t align='center'>Info:</t><br /><t align='center'>%4</t><br />",_name,_return select 0,_return select 1,_return select 2];
			} else
			{
				_output = format ["This warrant does not excist",_name];
			};
		};

		case "removewarrant":
		{
			_output = _return;
		};


		case "ticketlist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 - Issued by: %3</t><br />",_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No ticket history available for %1",_name];
			};
		};

		case "arrestlist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 - Entered by: %3</t><br />",_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No arrest history available for %1",_name];
			};
		};

		case "warninglist":
		{
			if (count _return > 0) then
			{
				{
					_output = _output + (format ["<t align='center'>%1 - %2 - Entered by: %3</t><br />",_x select 0,_x select 1,_x select 2]);
				} foreach _return;
				_output = _output;
			} else
			{
				_output = format ["No warning history available for %1",_name];
			};
		};

		case "insertwarrant":
		{
			_output = _return;
		};

		case "insertticket":
		{
			_output = _return;
		};

		case "insertwarning":
		{
			_output = _return;
		};

		case "insertreport":
		{
			_output = _return;
		};

		case "insertarrest":
		{
			_output = _return;
		};

		default {_output = "Unknown Error - Contact F.I.S.D Developer"};
	};

	//Okay lets send output to struct
	_newstruct = format["%1<br />%2",(player getVariable "PoliceDatabaseStruc"),_output];
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];
	[_newstruct] call A3PL_Police_UpdateComputer;

}] call Server_Setup_Compile;

['A3PL_Police_UpdateComputer',
{
	params[["_input","",[""]],["_new",false,[false]]];

	_display = findDisplay 211;
	_control = _display displayCtrl 1100;

	//Max 21 Lines
	_array = [_input, "<br />"] call CBA_fnc_split;

	if(count _array > 21) then {
		_remove = (count _array) - 21;

		for "_i" from 0 to _remove-1 do {
			_array deleteAt 0;
		};
	};

	//Rebuild out text
	_text = [_array, "<br />"] call CBA_fnc_join;

	player setVariable ["PoliceDatabaseStruc",_text,false];

	//Update our control
	_control ctrlSetStructuredText parseText _text;
}] call Server_Setup_Compile;

['A3PL_Police_DatabaseEnter',
{
	private ["_display","_control","_edit","_edit0","_newstruct"];
	disableSerialization;
	_display = findDisplay 211;

	_control = _display displayCtrl 1401;
	_edit = ctrlText _control;

	//First enter the entered command into the computer
	_newstruct = format["%1<br />%2",(player Getvariable "PoliceDatabaseStruc"),"> "+_edit];
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_Police_UpdateComputer;

	//Okay now we need to clear the rscedit
	_control = _display displayCtrl 1401;
	_control ctrlSetText "";

	//Okay now lets do some magic
	_edit0 = [_edit,0] call A3PL_Police_DatabaseArgu;
	if ((_edit0 IN A3PL_Police_DatabaseRequireLogin) && (!(player getVariable "PoliceDatabaseLogin"))) exitwith
	{
		_newstruct = format["%1<br />%2",(player Getvariable "PoliceDatabaseStruc"),"Error: You do not have permission to use this command"];
		player setVariable ["PoliceDatabaseStruc",_newstruct,false];

		[_newstruct] call A3PL_Police_UpdateComputer;
	};
	_output = "";
	switch (_edit0) do {
		case "help":
		{
			_output = "
			<t align='center'>help - display all commands</t><br />
			<t align='center'>clear - Clear the screen</t><br />
			<t align='center'>login [password] - Login to use commands</t><br />
			<t align='center'>lookup [firstname] [lastname] - Show information about person</t><br />
			<t align='center'>lookupvehicles [firstname] [lastname] - List all the vehicles registered to a person</t><br />
			<t align='center'>lookupaddress [firstname] [lastname] - List the address registered to a person</t><br />
			<t align='center'>lookuplicense [licenseplate] - Show information about license plate</t><br />
			<t align='center'>markstolen [licenseplate] - Mark a vehicle as stolen</t><br />
			<t align='center'>markfound [licenseplate] - Mark a vehicle as found</t><br />
			<t align='center'>warrantlist [firstname] [lastname] - List warrants for person</t><br />
			<t align='center'>warrantinfo [firstname] [lastname] [warrantnumber] - Warrant info</t><br />
			<t align='center'>removewarrant [firstname] [lastname] [warrantnumber] - Remove Warrant</t><br />
			<t align='center'>ticketlist [firstname] [lastname] - Display ticket history</t><br />
			<t align='center'>warninglist [firstname] [lastname] - Display warning history</t><br />
			<t align='center'>arrestlist [firstname] [lastname] - Display arrest history</t><br />
			<t align='center'>insertwarrant [firstname] [lastname] [title] [description] - Insert Warrant</t><br />
			<t align='center'>insertticket [firstname] [lastname] [amount] [description] - Insert Ticket</t><br />
			<t align='center'>insertwarning [firstname] [lastname] [title] [description] - Insert Warning</t><br />
			<t align='center'>insertarrest [firstname] [lastname] [time] [description] - Insert Arrest</t><br />
			";
			//<t align='center'>insertreport [firstname] [lastname] [title] [description] - Insert Report</t><br />
		};
		case "clear": {_output = "<t align='center'>F.I.S.D. Police Computer</t><br /><t align='center'>Enter 'help' for all available commands</t>";};
		case "login":
		{
			private ["_pass"];
			_pass = [_edit,1] call A3PL_Police_DatabaseArgu;
			if (_pass == "fistftw") then
			{
				player setVariable ["PoliceDatabaseLogin",true,false];
				_output = "You are now logged in";
			} else
			{
				_output = "Error: Invalid login";
			};
		};
		case "lookup":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			//Lets ask the server to search in the FIST database
			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			//Output
			_output = format ["Searching for Citizen in F.I.S.D Database...",_name];
		};

		case "lookupvehicles":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			//Lets ask the server to search in the FIST database
			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			//Output
			_output = format ["Searching for Citizens vehicles in F.I.S.D Database...",_name];
		};

		case "lookuplicense":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[[player,_license,_edit0],"Server_Police_Database",false,false] call BIS_Fnc_MP;
			_ouput = format["Searching for License Plate %1...",_edit];
		};

		case "lookupaddress":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			//Lets ask the server to search in the FIST database
			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			//Output
			_output = format ["Searching for Addresses in F.I.S.D Database...",_name];
		};

		case "markstolen":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[[player,_license,_edit0],"Server_Police_Database",false,false] call BIS_Fnc_MP;
			_ouput = format["Marking vehicle as stolen: %1...",_edit];
		};

		case "markfound":
		{
			private ["_license"];
			_license = [_edit,1] call A3PL_Police_DatabaseArgu;

			[[player,_license,_edit0],"Server_Police_Database",false,false] call BIS_Fnc_MP;
			_ouput = format["Marking vehicle as recovered: %1...",_edit];
		};

		case "warrantlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for active warrants..",_name];
		};

		case "warrantinfo":
		{
			private ["_name","_offset"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_offset = (parseNumber ([_edit,3] call A3PL_Police_DatabaseArgu)) - 1;

			if (_offset < 0) exitwith
			{
				_output = format ["Incorrect Syntax, refer to F.I.S.D operation manual",_name];
			};

			[[player,_name,_edit0,_offset],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for this warrant number...",_name];
		};

		case "removewarrant":
		{
			private ["_name","_offset"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_offset = (parseNumber ([_edit,3] call A3PL_Police_DatabaseArgu)) - 1;

			if (_offset < 0) exitwith
			{
				_output = format ["Incorrect Syntax, refer to F.I.S.D operation manual",_name];
			};

			[[player,_name,_edit0,_offset],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for this warrant number...",_name];
		};

		case "ticketlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for ticket history...",_name];
		};

		case "arrestlist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for arrest history...",_name];
		};

		case "warninglist":
		{
			private ["_name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);

			[[player,_name,_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			_output = format ["Searching F.I.S.D database for warning history...",_name];
		};

		case "insertwarrant":
		{
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_title,_info,_issuedBy],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;
			_output = format ["Inserting warrant into F.I.S.D database..."];
		};

		case "insertticket":
		{
			//insertticket [firstname] [lastname] [amount] [description]
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_amount = parseNumber ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_amount,_info,_issuedBy],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;
			_output = format ["Inserting ticket into F.I.S.D database..."];
		};

		case "insertwarning":
		{
			//insertwarning [firstname] [lastname] [title] [description] - Insert Warning
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_title,_info,_issuedBy],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;
			_output = format ["Inserting warning into F.I.S.D database..."];
		};

		case "insertreport":
		{
			//insertreport [firstname] [lastname] [title] [description] - Insert Report
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_title = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_title,_info,_issuedBy],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;
			_output = format ["Inserting report into F.I.S.D database..."];
		};

		case "insertarrest":
		{
			//insertarrest [firstname] [lastname] [time] [description] - Insert Arrest
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_time = ([_edit,3] call A3PL_Police_DatabaseArgu);

			_array = _edit splitString " ";
			for "_i" from 1 to 4 do {
				_array deleteAt 0;
			};

			_info = [_array," "] call CBA_fnc_join;
			_issuedBy = player getVariable ["name",name player];

			[[player,[_name,_time,_info,_issuedBy],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;
			_output = format ["Inserting arrest into F.I.S.D database..."];
		};

		case "revokelicense":
		{
			private ["_license, _name"];
			_name = ([_edit,1] call A3PL_Police_DatabaseArgu) + " " + ([_edit,2] call A3PL_Police_DatabaseArgu);
			_license = [_edit,3] call A3PL_Police_DatabaseArgu;

			["System: Debug", Color_Yellow] call A3PL_Player_Notification;
			[[player,[_name,_license,_info],_edit0],"Server_Police_Database",false,false] call BIS_FNC_MP;

			[[player,_name,_license,_edit0],"Server_Police_Database",false,false] call BIS_Fnc_MP;
			_ouput = format["Revoking License..."];
		};

		default {_output = "Error: Unknown Command"};
	};

	//Okay lets send output to struct
	_control = _display displayCtrl 1100;
	if (_edit0 == "clear") then
	{
		_newstruct = _output;
	} else
	{
		_newstruct = format["%1<br />%2",(player getVariable "PoliceDatabaseStruc"),_output];
	};
	player setVariable ["PoliceDatabaseStruc",_newstruct,false];

	[_newstruct] call A3PL_Police_UpdateComputer;

}] call Server_Setup_Compile;

["A3PL_Police_DatabaseOpen",
{
	private ["_display","_text"];

	if(!(player getVariable ["job","unemployed"] in ["police","dispatch","uscg","usms"])) exitWith {["System: You are not on-duty as a Sheriff/USCG/Dispatch/USMS and cannot use this",Color_Red] call A3PL_Player_Notification;};

	_text = "<t align='center'>F.I.S.D. Police Computer</t><br /><t align='center'>Enter 'help' for all available commands</t><br />> please login";
	player setVariable ["PoliceDatabaseStruc",_text,false];
	player setVariable ["PoliceDatabaseLogin",false,false];
	disableSerialization;
	createDialog "Dialog_PoliceDatabase";
	_display = findDisplay 211;
	_display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 28) then {[] call A3PL_Police_DatabaseEnter;}"];

	[_text] call A3PL_Police_UpdateComputer;
}] call Server_Setup_Compile;

["A3PL_Police_OpenTicketMenu",
{
	disableSerialization;
	Player_TicketAmount = Nil;
	createDialog "Dialog_CreateTicket";
	buttonSetAction [1600,"[] call A3PL_Police_CreateTicket;"];
}] call Server_Setup_Compile;

["A3PL_Police_CreateTicket",
{
	private ["_display","_control","_ticketAmount"];
	disableSerialization;
	_display = findDisplay 38;
	_control = _display displayCtrl 1400;
	_ticketAmount = parseNumber (ctrlText _control);
	closeDialog 0;
	if (_ticketAmount < 1) exitwith
	{
		["System: Please enter a valid ticket amount", Color_Red] call A3PL_Player_Notification;
	};

	Player_Item = "A3PL_Ticket" createVehicle (getPos player);
	Player_Item attachTo [player, [0,0,0], "RightHand"];
	Player_ItemClass = "ticket";
	Player_TicketAmount = _ticketAmount;
	["System: You created a ticket, now look at a player to give it to him", Color_Green] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

["A3PL_Police_GiveTicket",
{
	_player = param [0,objNull];
	if (!isPlayer _player) exitwith {["System: You are not looking at a player", Color_Red] call A3PL_Player_Notification;};
	if (isNil "Player_TicketAmount") exitwith {["System: Unable to give ticket, ticket amount is not defined", Color_Red] call A3PL_Player_Notification;};
	[Player_Item] call A3PL_Inventory_Clear;

	[format ["System: You gave a ticket to %1",(_player getVariable ["name",name _player])], Color_Green] call A3PL_Player_Notification;

	[[Player_TicketAmount,player],"A3PL_Police_ReceiveTicket",_player,false] call bis_fnc_mp;

	player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';

	Player_TicketAmount = Nil;
}] call Server_Setup_Compile;

["A3PL_Police_GiveTicketResponse",
{
	_r = param [0,1];

	_text = ["System: An error occured in ticket response",Color_Red];
	switch (_r) do
	{
		case 1: {_text = ["System: Citizen refused to pay your ticket",Color_Red];};
		case 2: {_text = ["System: Citizen has paid your ticket",Color_Green];};
		case 3: {_text = ["System: Citizen does not have enough money to pay this ticket",Color_Red];};
	};

	_text call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_ReceiveTicket",
{
	disableSerialization;
	private ["_ticketAmount"];
	Player_TicketCop = Nil;
	Player_TicketAmount = Nil;
	closeDialog 0;

	Player_TicketAmount = param [0,1];
	Player_TicketCop = param [1,objNull];
	createDialog "Dialog_ReceiveTicket";
	(findDisplay 37) displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

	ctrlSetText [1000,format ["Ticket amount $%1",Player_TicketAmount]];

	buttonSetAction [1600,"[] call A3PL_Police_PayTicket;"];
	buttonSetAction [1601,"[] call A3PL_Police_RefuseTicket;"];
}] call Server_Setup_Compile;

["A3PL_Police_RefuseTicket",
{
	closeDialog 0;
	[[1],"A3PL_Police_GiveTicketResponse",Player_TicketCop,false] call bis_fnc_mp;
	Player_TicketCop = Nil;
	Player_TicketAmount = Nil;
	["Error: You refused to pay the ticket",Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_PayTicket",
{
	closeDialog 0;

	if (isNil "Player_TicketAmount") exitwith
	{
		["Error: TicketAmount not declared in PayTicket",Color_Red] call A3PL_Player_Notification;
	};

	_cash = player getVariable ["player_cash",0];
	_bank = player getVariable ["player_bank",0];
	if (Player_TicketAmount > _cash && Player_TicketAmount > _bank) exitwith
	{
		[[3],"A3PL_Police_GiveTicketResponse",Player_TicketCop,false] call bis_fnc_mp;
		["System: You don't have enough money to pay this ticket",Color_Red] call A3PL_Player_Notification;
	};

	[[Player_TicketAmount,player,Player_TicketCop],"Server_Police_PayTicket",false,false] call bis_fnc_mp;
	[[2],"A3PL_Police_GiveTicketResponse",Player_TicketCop,false] call bis_fnc_mp;

	[format["System: You paid a ticket of $%1",Player_TicketAmount],Color_Green] call A3PL_Player_Notification;

	Player_TicketAmount = Nil;
	Player_TicketCop = Nil;
}] call Server_Setup_Compile;

["A3PL_Police_SearchPlayer",
{

	params[["_target",objNull,[objNull]]];

	_items = _target getVariable ["player_inventory",[]];

	{
		_class = _x select 0;
		_amount = _x select 1;

		if(_class in Player_illegalItems) then {

			//Reverse the amount
			_amount = 0 - _amount;

			//Remove this item
			[_target,_class,_amount] remoteExec ["Server_Inventory_Add",2];

			//tell the cop
			_name = [_class, 'name'] call A3PL_Config_GetItem;
			[format["System: You found %1 %2(s)",_amount,_name],Color_Red] call A3PL_Player_Notification;
		};
	} forEach _items;
}] call Server_Setup_Compile;




["A3PL_Police_StartJailPlayer",
{
	params[["_target",objNull,[objNull]]];

	_pd = nearestObjects [player, ["land_a3pl_sheriffpd","Land_A3PL_Prison"], 50];

	if(count _pd < 1) exitWith {
		[format["System: You must be at a police station or prison to jail this player"],Color_Red] call A3PL_Player_Notification;
	};

	createDialog "Dialog_JailPlayer";
	A3PL_JailPlayer_Target = _target;
}] call Server_Setup_Compile;



["A3PL_Police_JailPlayer",
{
	_time = parseNumber (ctrlText 1400);

	closeDialog 0;

	if((isNull cursorTarget) || (!isPlayer cursorTarget)) exitWith {[format["System: Look at the player you're jailing!"],Color_Red] call A3PL_Player_Notification;};
	if(typeName _time != "SCALAR") exitWith {[format["System: Invalid Number Entered!"],Color_Red] call A3PL_Player_Notification;};
	if(_time <= 0) exitWith {[format["System: Invalid Time!"],Color_Red] call A3PL_Player_Notification;};
	if(_time > 60 * 24) exitWith {[format["System: Unable to Jail for more than 24 hours!"],Color_Red] call A3PL_Player_Notification;};

	[_time, A3PL_JailPlayer_Target] remoteExec ["Server_Police_JailPlayer",2];
}] call Server_Setup_Compile;

["A3PL_Police_ReleasePlayer",
{
	player setVariable ["jailed",false,true];

	player setPosATL [4772.96,6274.2,0];
	player setDir 7;
	removeUniform player;

	[format["System: Completed Jail Sentence!"],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Police_AcceptDispatch",
{
	params[["_target",objNull,[objNull]]];
	A3PL_Phone_Caller = _target;

	closeDialog 0;
	createDialog "Dialog_Dispatch";
}] call Server_Setup_Compile;

["A3PL_Police_StartDispatch",
{
	player setVariable ["busy",true,true];
	player setvariable ["A3PL_Call_Status",[A3PL_Phone_Caller,3,format ["911 call FROM: %1 (%2)",A3PL_Phone_Caller getVariable ["phone_number","ERROR!"],A3PL_Phone_Caller getVariable ["name",(name player)]]],true];
	[A3PL_Phone_Caller] remoteExec ["Server_Police_AcceptDispatch",2];

	[] call A3PL_Phone_AnswerCall;
	[[0]] spawn A3PL_Phone_HUD;
}] call Server_Setup_Compile;

["A3PL_Police_RadarLoop",
{
	private ["_Beam","_Beam2","_radardir","_veh"];
	_veh = param [0,objNull];
	[_veh] spawn A3PL_Police_RadarLoopSync; //seperate loop to handle sync
	_Beam = "Land_HelipadEmpty_F" createVehicleLocal getpos _veh;
	_Beam attachTo [ _veh, [ 0.0, 50.0, 0.75 ] ];
	_Beam2 = "Land_HelipadEmpty_F" createVehicleLocal getpos _veh;
	_Beam2 attachTo [ _veh, [ 0.0, 150.0, 0.75 ] ];
	_radardir = "Front";
	while {player IN _veh} do
	{
		if (_veh animationPhase "Radar_Master" > 0.5) then
		{
			//set target speed
			private ["_inter","_target","_speed","_forward","_dist"];
			_forward = _veh getVariable ["forward",true]; //defaults to true
			//if (_forward) then {_dist = 200} else {_dist = -200}; //-200 backwards, 200 forwards
			//_inter = lineIntersectsObjs [AGLtoASL(_veh modelToWorldVisual [0,0,-0.5]), AGLtoASL(_veh modelToWorldVisual [0,_dist,-0.5]), objNull, _veh, true, 16]; //16 means first contact
			if (_veh animationPhase "Radar_Front" >= 0.5) then
			{
				_Beam attachTo [ _veh, [ 0.0, 50.0, 0.75 ] ];
				_Beam2 attachTo [ _veh, [ 0.0, 150.0, 0.75 ] ];
				_radardir = "Front";
			}else
			{
				_Beam attachTo [ _veh, [ 0.0, -60.0, 0.75 ] ];
				_Beam2 attachTo [ _veh, [ 0.0, -150.0, 0.75 ] ];
				_radardir = "Rear";
			};
			//hintSilent format ["%1 %2 %3",_radardir,_Beam,_Beam2];
			_tag2 = nearestObject [_Beam2, "LandVehicle"];
			_tag = nearestObject [_Beam, "LandVehicle"];
			if(isNull _tag) then {_tag = _tag2};
			if(isNull _tag2) then {_tag2 = _tag};
			if (!(isNull _tag)) then
			{
				private ["_target","_speed"];
				_target = _tag;
				//if (!(_target isKindOf "Car")) exitwith {};
				_speed = (speed _target) * 0.621371; //get mph
				[_veh,"target",_speed] call A3PL_Police_RadarSet; //set target speed
				if ((_speed > (_veh getVariable ["lockfast",-1000])) && (_veh getVariable ["locktarget",_target] == _target)) then //set new lockfast if higher than previous
				{
					[_veh,"lockfast",_speed] call A3PL_Police_RadarSet;
					_veh setvariable ["lockfast",_speed,false];
					_veh setvariable ["locktarget",_target,false];
				};
			};

			//set patrol(own) speed
			_speed = (speed _veh) * 0.621371;
			[_veh,"patrol",_speed] call A3PL_Police_RadarSet;
		};
		uiSleep 0.1;
	};
	deleteVehicle _Beam;
	deleteVehicle _Beam2;
}] call Server_Setup_Compile;

//seperate loop to handle MP sync of variables
["A3PL_Police_RadarLoopSync",
{
	private ["_veh","_tempVar"];
	_veh = param [0,objNull];
	_tempVar = _veh getVariable ["radar_prev",["","","","","","","","",""]];
	if (!isNil "RadarLoopSyncRunning") exitwith {["Debug: RadarLoopSync not started, already running",Color_Red] call A3PL_Player_Notification;};
	RadarLoopSyncRunning = true;
	while {player IN _veh} do
	{
		if (_veh animationPhase "Radar_Master" > 0.5) then
		{
			private ["_tex"];
			_tex = getObjectTextures _veh;
			for "_i" from 8 to 16 do
			{
				private ["_newTex"];
				_newTex = _tex select _i;
				if ((_tempVar select (_i-8)) != _newTex) then //if the texture is different from the one we synced last time
				{
					_veh setObjectTextureGlobal [_i,_newTex]; //sync the texture globally
					_tempVar set [_i,_newTex];
				};
			};
			_veh setVariable ["radar_prev",_tempVar,false];
		};
		uiSleep 1.5; //sync every 1.5sec, change this to quicker/slower
	};
	RadarLoopSyncRunning = nil;
}] call Server_Setup_Compile;

//set a number to radar
["A3PL_Police_RadarSet",
{
	private ["_selStart"];
	_veh = param [0,objNull];
	_type = param [1,"target"];
	_number = param [2,0];
	_global = param [3,false];

	switch (_type) do
	{
		case ("target"): {_selStart = 8};
		case ("lockfast"): {_selStart = 11};
		case ("patrol"): {_selStart = 14};
		case default {_selStart = 8};
	};

	_number = [_number, 3] call CBA_fnc_formatNumber; //format number to string of 3 chars
	if (count _number > 3) then //remove minus from negative numbers
	{
		_number = toArray _number;
		_number deleteAt 0;
		_number = toString _number;
	};

	for "_i" from _selStart to (_selStart + 2) do //set texture
	{
		if (_global) then
		{
			_veh setObjectTextureGlobal [_i,format ["\a3pl_cars\common\textures\numbers\%1.paa",(_number select [(_i - _selStart),1])]];
		} else
		{
			_veh setObjectTexture [_i,format ["\a3pl_cars\common\textures\numbers\%1.paa",(_number select [(_i - _selStart),1])]];
		};
	};

}] call Server_Setup_Compile;

["A3PL_Police_Panic", 
{
	private ["_faction","_panicCooldown","_factionMembers"];
	_faction = player getVariable ["faction",""];
	_panicCooldown = player getVariable ["panicCooldown",false];
	_factionMembers = [_faction] call A3PL_Lib_FactionPlayers;
	
	//check if we are on cooldown
	if (_panicCooldown) exitWith {["System: You recently used your panic button! - There is a 30sec cooldown!", Color_Red] call A3PL_Player_Notification;};
	
	//execute panic button
	["System: You used your panic button!", Color_Green] call A3PL_Player_Notification;
	[player] remoteExec ["A3PL_Police_PanicMarker", _factionMembers];
	player setVariable ["panicCooldown",true,false];
	
	//play gesture (this only works if you have the gesture anims from the german community)
	player playActionNow "a3pl_Radio03";
	uiSleep 0.5;
	player playActionNow "GestureNod";
	
	// cooldown
	uiSleep 29.5;
	player setVariable ["panicCooldown",false,false];
}] call Server_Setup_Compile;

["A3PL_Police_PanicMarker",
{
	private ["_player","_marker"];
	_player = param [0,objNull];
	
	//play sound & display notification
	playSound "A3PL_Panic";
	["System: ONE OF YOUR FACTION MEMBERS ACTIVATED HIS/HER PANIC BUTTON -- CHECK YOUR MAP FOR LOCATION!!!",Color_Red] call A3PL_Player_Notification;
	
	//create marker
	_marker = createMarkerLocal [format ["panic_btn_%1",(floor (random 1000))],_player];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal "Panic Button Triggered!";
	_marker setMarkerColorLocal "ColorBlack";
	
	//delete marker after 30 seconds
	uiSleep 30;
	deleteMarkerLocal _marker;
}] call Server_Setup_Compile;