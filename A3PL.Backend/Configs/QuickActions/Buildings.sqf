//merge
[
	"Land_A3PL_BarGate",
	localize"STR_INTSECT_OPCLBARG", //Open/Close Bargate
	{
		private ["_bargate","_anim"];
		_bargate = player_objintersect;
		_anim = (player_nameintersect splitstring "_") select 1;

		//whitelisting
		_canUse = true;
		//faa bargate
		if ((_bargate distance2D [2724.66,5398.11]) < 5) then {if (!(player getVariable ["faction","citizen"] IN ["faa","police","fifr"])) then {_canUse = false;}};
		if ((_bargate distance2D [2626.24,5499.09]) < 5) then {if (!(player getVariable ["faction","citizen"] IN ["police","fifr"])) then {_canUse = false;}};
		if ((_bargate distance2D [6252.59,7698.81,0]) < 5) then {if (!(player getVariable ["faction","citizen"] IN ["police","fifr"])) then {_canUse = false;}};
		if (!_canUse) exitwith {["System: Your current faction does not allow this gate to be operated",Color_Red] call A3PL_Player_Notification;};
		//end of whitelisting

		//animate
		if (_bargate animationSourcePhase _anim < 0.5) then
		{
			_bargate animateSource [_anim,1];
		} else
		{
			_bargate animateSource [_anim,0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_SPVHINGAR", //Spawn vehicle in garage
	{
		[] call A3PL_Storage_OpenCarStorage;
	}
],
//end of merge

[
	"",
	localize"STR_INTSECT_VEHSTOR", //Vehicle Storage
	{
		[] call A3PL_Storage_OpenCarStorage;
	}
],

[
	"",
	localize"STR_INTSECT_STOREVEH", //Store Vehicle
	{
		[] call A3PL_Storage_CarStoreButton;
	}
],

[
	"A3PL_carInfo",
	localize"STR_INTSECT_STOREAIRC", //Store Aircraft
	{
		["plane"] call A3PL_Storage_CarStoreButton;
	}
],

[
	"",
	localize"STR_INTSECT_OBJSTOR", //Object Storage
	{
		[] call A3PL_Storage_OpenObjectStorage;
	}
],

[
	"",
	localize"STR_INTSECT_STOREOBJ", //Store Object
	{
		[] call A3PL_Storage_ObjectStoreButton;
	}
],

[
	"A3PL_carInfo",
	localize"STR_INTSECT_IMPNEARVEH", //Impound Nearest Vehicle
	{
		[] call A3PL_JobRoadWorker_Impound;
	}
],

[
	"land_a3pl_sheriffpd",
	localize"STR_INTSECT_OPCLGARDOOR", //Open/Close Garage Door
	{
		_intersect = player_objintersect;
		_nameintersect = player_nameintersect;
		if (_nameintersect IN ["door_1_1","door_1_2","door_1_3"]) exitwith
		{
			if (_intersect animationSourcePhase "garage1" < 0.1) then
			{
				_intersect animateSource ["garage1",1];
			} else
			{
				_intersect animateSource ["garage1",0];
			};
		};

		if (_nameintersect IN ["door_2_1","door_2_2","door_2_3"]) exitwith
		{
			if (_intersect animationSourcePhase "garage2" < 0.1) then
			{
				_intersect animateSource ["garage2",1];
			} else
			{
				_intersect animateSource ["garage2",0];
			};
		};
	}
],

[
	"land_a3pl_sheriffpd",
	"Use SD Button",
	{
		private ["_name","_anim","_inter"];
		_name = player_nameintersect;
		_inter = player_objintersect;

		switch (_name) do
		{
			case "garageDoor_button": {_anim = "garage"};
			case "garageDoor_button2": {_anim = "garage"};
			case "door3_button": {_anim = ["door3","door4"]};
			case "door3_button2": {_anim = ["door3","door4"]};
			case "door5_button": {_anim = ["door5","door6"]};
			case "door5_button2": {_anim = ["door5","door6"]};
			case "door7_button": {_anim = ["door7","door8"]};
			case "door7_button2": {_anim = ["door7","door8"]};
			case "door9_button": {_anim = ["door9","door10"]};
			case "door9_button2": {_anim = ["door9","door10"]};
			case "door11_button": {_anim = "door11"};
			case "door11_button2": {_anim = "door11"};
		};

		if (typeName _anim == "ARRAY") exitwith
		{
			{
				if (_inter animationPhase _x < 0.1) then
				{
					_inter animate [_x,1];
				} else
				{
					_inter animate [_x,0];
				};
			} foreach _anim;
		};

		if (_inter animationPhase _anim < 0.1) then
		{
			_inter animate [_anim,1];
		} else
		{
			_inter animate [_anim,0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_OPCLJAILD", //Open/Close Jail Door
	{
		private ["_name","_inter"];
		_name = player_nameintersect;
		_inter = player_objintersect;

		if (_inter animationPhase _name < 0.1) then
		{
			_inter animate [_name,1];
		} else
		{
			_inter animate [_name,0];
		};
	}
],

/*
[
	"Land_A3PL_Sheriffpd",
	localize"STR_INTSECT_ACCTVSYS", //Access CCTV System
	{
		[] spawn A3PL_CCTV_Open;
	}
],
*/

[
	"C_man_w_worker_F",
	localize"STR_INTSECT_ACCTVSYS", //Access CCTV System
	{
		[] spawn A3PL_CCTV_Open;
	}
],

[
	"Land_A3PL_Cinema",
	localize"STR_INTSECT_ACCYTCOMP",
	{
		[player_objintersect] call A3PL_Youtube_OpenComputer;
	}
],

[
	"",
	localize"STR_INTSECT_SITDOWN", //Sit Down
	{
		[player_objintersect,player_nameintersect] call A3PL_Lib_Sit;
	}
],

[
	"",
	localize"STR_INTSECT_LAYDOWN", //Lay down
	{
		[player_objintersect,player_nameintersect] call A3PL_Lib_Sit;
	}
],

[
	"",
	"Get Up", //Get Up
	{
		[[player,"amovppnemstpsnonwnondnon"],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
	}
],

[
	"Land_KarmaLanes",
	localize"STR_INTSECT_SHOWSCORE", //Show score
	{
		[] call A3PL_Bowling_BScoreOpen;
	}
],

[
	"Land_KarmaLanes",
	localize"STR_INTSECT_LANEREGISTER", //Lane Registration
	{
		[] call A3PL_Bowling_BOpen;
	}
],

[
	"A3PL_Ball",
	localize"STR_INTSECT_PICKBALL", //Pickup Ball
	{
		[(call A3PL_Intersect_Cursortarget)] call A3PL_Bowling_PickupBall;
	}
],
/*
[
	"C_man_1"
	"",
	{
		[(attachedobjects player) select 0] call A3PL_Throwball;
	}
]
*/
[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_CONVAULTDRI", //connect vault drill
	{
		[player_objintersect] call A3PL_BHeist_SetDrill;
	}
],

[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_OPDEPBOX", //Open Deposit Box
	{
		[player_objintersect,player_nameintersect] spawn A3PL_BHeist_OpenDeposit;
	}
],

[
	"Land_A3PL_Bank",
	localize"STR_INTSECT_SECVAULTD", //Secure Vault Door
	{
		[player_objintersect,player_nameintersect] call A3PL_BHeist_CloseVault;
	}
],

[
	"Land_A3PL_Garage",
	localize"STR_INTSECT_UPGRVEH", //Upgrade Vehicle
	{
		[player_objintersect] spawn A3PL_Garage_Open;
	}
],

[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_OPENGASMENU", //Open Gasstation Menu
	{
		[] call A3PL_Hydrogen_Open;
	}
],

[
	"Land_A3PL_Gas_Station",
	"Pay For Fuel", //Pay For Fuel
	{
		_station = player_objintersect;
		_customer = player;
		_price = (_station getVariable ["pump1",[0,0]]) select 1;
		_price = parseNumber _price;
		_price = round _price;
		_owner = objNull;
		{if ((_station getVariable ["bOwner","0"]) == (getPlayerUID _x)) then {_owner = _x;}} forEach allPlayers;
		if ((isNull _owner)) exitwith
		{
			_cash = _customer getVariable ["player_cash",0];
			_bank = _customer getVariable ["player_bank",0];
			if(_price <= _cash) then
			{
				[[_customer, 'Player_Cash', ((_customer getVariable 'Player_Cash') - _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
				[format ["System: You have paid $%1 for gas",_price],Color_Green] call A3PL_Player_Notification;
			} else {
				[[_customer, 'Player_Bank', ((_customer getVariable 'Player_Bank') - _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
				[format ["System: You have paid $%1 for gas",_price],Color_Green] call A3PL_Player_Notification;
			};
			//hintSilent format ["%1,%2,%3",_station,_customer,_price];
		};
		if ((_owner == _owner)) exitwith {};
		_cash = _customer getVariable ["player_cash",0];
		_bank = _customer getVariable ["player_bank",0];
		if ((_price >= _cash)&&(_price >= _bank)) exitwith {["System: You can't afford the gas bill",Color_Red] call A3PL_Player_Notification;["System: The customer can't afford the gas pill", Color_Red] remoteExec ["A3PL_Player_Notification",_owner];};
		if(_price <= _cash) then
		{
			[[_customer, 'Player_Cash', ((_customer getVariable 'Player_Cash') - _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
			[[_owner, 'Player_Cash', ((_owner getVariable 'Player_Cash') + _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
			[format ["System: You have paid $%1 for gas",_price],Color_Green] call A3PL_Player_Notification;
			[format ["System: The customer has paid $%1 for gas",_price],Color_Green] remoteExec ["A3PL_Player_Notification",_owner];
		} else {
			[[_customer, 'Player_Bank', ((_customer getVariable 'Player_Bank') - _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
			[[_owner, 'Player_Cash', ((_owner getVariable 'Player_Cash') + _price)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
			[format ["System: You have paid $%1 for gas",_price],Color_Green] call A3PL_Player_Notification;
			[format ["System: The customer has paid $%1 for gas",_price],Color_Green] remoteExec ["A3PL_Player_Notification",_owner];
		};
		//[[_station,_customer,_owner,_price],"Server_Hydrogen_PayFuel",false,false] call bis_fnc_mp;
		//hintSilent format ["%1,%2,%3,%4",_station,_customer,_owner,_price];
	}
],

[
	"land_a3pl_ch",
	localize"STR_INTSECT_ELECTMAYOR", //Elect Mayor
	{
		[] call A3PL_Government_OpenVote;
	}
],

[
	"land_a3pl_ch",
	localize"STR_INTSECT_MAKEMYCANI", //Make Myself Candidate
	{
		[] call A3PL_Government_AddCandidate;
	}
],

[
	"Land_A3PL_Mailbox",
	localize"STR_INTSECT_OPCLMAILB", //Open/Close Mailbox
	{
		private ["_obj"];
		_obj = player_objintersect;
		if (_obj animationPhase "door_mailbox" < 0.5) then
		{
			_obj animate ["door_mailbox",1];
		} else
		{
			_obj animate ["door_mailbox",0];
		};
	}
],

[
    "",
    localize"STR_INTSECT_TURNONLIGHTS", //Turn On Lights
    {
		[player_objintersect,player_nameintersect] call A3PL_Lib_SwitchLight
    }
],

[
	"Land_A3PL_Impound",
	localize"STR_INTSECT_OPCLIMPGATE", //Open/Close Impound Gate
	{
		_impound = player_objintersect;
		if (_impound animationSourcePhase "GarageDoor" < 0.5) then
		{
			_impound animateSource ["GarageDoor",1];
		} else
		{
			_impound animateSource ["GarageDoor",0];
		};
	}
],

[
	"",
	localize"STR_INTSECT_USEDOORB", //Use Door Button
	{
		[player_objintersect,player_nameIntersect] call A3PL_Intersect_HandleDoors;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",1],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",2],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",3],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",4],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",5],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",6],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",7],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",8],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",9],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",10],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",11],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],
[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",12],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",13],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENCELL",14],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENMCELL",1],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	format [localize"STR_INTSECT_OPENMCELL",2],
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_OPENKCELL",
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_OPENGARAGE",
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_Prison",
	localize"STR_INTSECT_LOCKDOWN", //lockdown
	{
		[player_objintersect,player_nameIntersect] call A3PL_Prison_HandleDoor;
	}
],

[
	"Land_A3PL_CH",
	localize"STR_INTSECT_OPCLDEFROOM", //Open/Close Defendant Room
	{
		[] call A3PL_Intersect_HandleDoors;
	}
],

[
	"Land_A3PL_CH",
	localize"STR_INTSECT_OPCLDEFROOM", //Open/Close Defendant Room
	{
		[] call A3PL_Intersect_HandleDoors;
	}
],

[
	"Land_A3PL_CH",
	localize"STR_INTSECT_OPTREASINF", //Open Treasury Info
	{
		[] call A3PL_Government_OpenTreasury;
	}
],

[
	"",
	localize"STR_INTSECT_LOUNDOOR", //Lock/Unlock Door
	{
		private ["_keyid","_obj","_locked","_format","_keyCheck","_name","_getVarName"];
		//Dont forget a check if locked

		_obj = ([] call A3PL_Intersect_Cursortarget);
		_name = player_nameintersect;

		if (isNil "Player_Item") exitwith {	_format = format["You dont have a key in your hand to open this with"]; [_format, Color_Red] call A3PL_Player_Notification; };
		if (isNull Player_Item) exitwith { _format = format["You dont have a key in your hand to open this with"]; [_format, Color_Red] call A3PL_Player_Notification; };
		_keyID = Player_Item getVariable "keyID";
		if (isNil "_keyID") exitwith {_format = format["You can't open a door with this..."]; [_format, Color_Red] call A3PL_Player_Notification;};

		_keyCheck = false;
		if (typeOf _obj == "Land_A3PL_Motel") then
		{
			_keyCheck = [_obj,_keyID,_name] call A3PL_Housing_CheckOwn;
		} else
		{
			_keyCheck = [_obj,_keyID] call A3PL_Housing_CheckOwn;
		};

		if (_keycheck) then
		{
			_getVarName = "unlocked";
			if (typeOf _obj == "Land_A3PL_Motel") exitwith
			{
				_getVarName = format ["%1_locked",_name];
				if ((_obj getVariable [_getVarName,true])) then
				{
					_obj setVariable [_getVarName,false,true];
					player playAction "gesture_key";
					_format = format["System: The doors have been unlocked"]; [_format, Color_Green] call A3PL_Player_Notification;
				}else{
					_obj setVariable [_getVarName,true,true];
					player playAction "gesture_key";
					_format = format["System: All doors have been locked"]; [_format, Color_Red] call A3PL_Player_Notification;
				};
			};
			_locked = _obj getVariable [_getVarName,nil];
			if (isNil "_locked") then
			{
				_obj setVariable [_getVarName,true,true];
				_format = format["System: The doors have been unlocked"]; [_format, Color_Green] call A3PL_Player_Notification;
			} else
			{
				//Nil it so we dont have to sync to JIP players
				_obj setVariable [_getVarName,Nil,true];
				_format = format["System: All doors have been locked"]; [_format, Color_Red] call A3PL_Player_Notification;
			};
			player playAction "gesture_key";
		} else
		{
			_format = format["System: This key does not seem to fit this lock"]; [_format, Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"Land_A3PL_EstateSign",
	"Start Auction",
	{
		[[player,player_objintersect],"Server_Housing_InitLottery",false] call BIS_fnc_MP;
	}
],

[
	"Land_A3PL_GreenhouseSign",
	localize"STR_INTSECT_RENTGH", //Rent Greenhouse
	{
		[player_objIntersect] call A3PL_JobFarming_Rent;
	}
],

[
	"Land_A3PL_BusinessSign",
	localize"STR_INTSECT_RENTBUSI", //Rent Business
	{
		[player_objIntersect] call A3PL_Business_Buy;
	}
],

[
	"Land_A3PL_EstateSign",
	localize"STR_INTSECT_BUYHOUSE", //Buy House
	{
		[player_objIntersect] call A3PL_Housing_OpenBuyMenu;
	}
],

[
	"Land_A3PL_Showroom",
	localize"STR_INTSECT_OPENSHOWDOOR", //Open Showroom Doors
	{
		private ["_obj","_name"];

		_obj = player_objintersect;
		_name = player_nameIntersect;
		if ((isNull _obj) or (_name == "")) exitwith {["System: Unable to Open Showroom Doors", Color_Red] call A3PL_Player_Notification;};
		if (!(typeOf _obj == "Land_A3PL_Showroom")) exitwith {["System: You are not looking at a showroom building", Color_Red] call A3PL_Player_Notification;};

		if (_name == "garage1_open") then
		{
			_obj animateSource ["garage2",1];
		} else
		{
			_obj animateSource ["garage1",1];
		};
	}
],

[
	"Land_A3PL_Showroom",
	localize"STR_INTSECT_CLOSESHOWDOOR", //Close Showroom Doors
	{
		private ["_obj","_name"];

		_obj = player_objintersect;
		_name = player_nameIntersect;
		if ((isNull _obj) or (_name == "")) exitwith {["System: Unable to Close Showroom Doors", Color_Red] call A3PL_Player_Notification;};
		if (!(typeOf _obj == "Land_A3PL_Showroom")) exitwith {["System: You are not looking at a showroom building", Color_Red] call A3PL_Player_Notification;};

		if (_name == "garage1_close") then
		{
			_obj animateSource ["garage2",0];
		} else
		{
			_obj animateSource ["garage1",0];
		};
	}
],

[
	"Land_A3PL_Garage",
	localize"STR_INTSECT_USECARLIFT", //Use Car Lift
	{
		[player_objintersect] call A3PL_JobMechanic_UseLift;
	}
],

[
	"",
	localize"STR_INTSECT_DELIVERYVEH", //Deliver Vehicle
	{
		[player_objintersect,player_nameIntersect] call A3PL_JobVDelivery_Deliver;
	}
],

[
	"",
	localize"STR_INTSECT_DELPACKAGE", //Deliver Package
	{
		[player_objintersect,player_nameIntersect] call A3PL_JobMDelivery_Deliver;
	}
],

[
	"",
	localize"STR_INTSECT_KNOCKONDOOR", //Knock On Door
	{
		playSound3D ["A3PL_Common\effects\knockdoor.ogg", player, true, getPosASL player, 2, 1, 10];
	}
],

[
	"",
	"Check Fire Alarm",
	{
		[player_objintersect] spawn A3PL_FD_CheckFireAlarm;
	}
],

[
	"",
	"Trigger Fire Alarm",
	{
		[player_objintersect] spawn A3PL_FD_FireAlarm;
	}
],

[
	"",
	"Re-Enable Fire Alarm",
	{
		[player_objintersect] spawn A3PL_FD_SetFireAlarm;
	}
],


[
	"",
	"Repair Fire Alarm",
	{
		[player_objintersect] spawn A3PL_FD_RepairFireAlarm;
	}
],

[
	"",
	"Lockpick Door", 
	{
		[player_objintersect] spawn A3RL_HouseRobbery_Rob;
	}
]