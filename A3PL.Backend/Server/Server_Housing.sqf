//save items near the house in a 20m radius
["Server_Housing_SaveItems",
{
	private ["_player","_uid","_items","_houses","_itemsToSave","_query"];
	_player = param [0,objNull];
	_uid = param [1,""];
	_delete = param [2,true];
	_house = _player getVariable ["house",objNull];
	_items = nearestObjects [_house,[],20];

	//set some variable that the furniture is not loaded anymore
	_house setVariable ["furn_loaded",false,false];

	//get the items we need to save
	_itemsToSave = [];
	{
		if (!isNil {_x getVariable "class"}) then
		{
			if ((_x getVariable "owner") == _uid) then
			{
				_itemsToSave pushback _x;
			};
		};
	} foreach _items;

	//generate the array that we will insert into the db
	_pItems = [];
	{
		_pItems pushback [(typeOf _x),(_x getVariable "class"),(_house worldToModel (getposATL _x)),getDir _x];
		if (_delete) then {deleteVehicle _x;};
	} foreach _itemsToSave;

	_query = format ["UPDATE houses SET pitems='%1' WHERE location ='%2'",_pItems,(getpos _house)];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

/*
	 2:01:25 Error in expression <,"_pos","_dir","_obj"];
	_classname = _x select 0;
	_class = _x select 1;
	_pos = _>
	 2:01:25   Error position: <select 0;
	_class = _x select 1;
	_pos = _>
	 2:01:25   Error Generic error in expression
*/

//load items from the house
//COMPILE BLOCK
["Server_Housing_LoadItems",
{
	private ["_house","_player","_uid","_pitems"];
	_player = param [0,objNull];
	_house = param [1,objNull];
	_uid = param [2,""];

	//set furn loaded to true
	if (_house getVariable ["furn_loaded",false]) exitwith {};
	_house setVariable ["furn_loaded",true,false];

	_pitems = [format ["SELECT pitems FROM houses WHERE location = '%1'",(getpos _house)], 2] call Server_Database_Async;
	_pitems = call compile (_pitems select 0);

	[_house,_pitems] remoteExec ["A3PL_Housing_Loaditems", (owner _player)];
},true] call Server_Setup_Compile;

["Server_Housing_LoadItemsSimulation",
{
	private ["_objects"];
	_objects = param [0,[]];
	{
		_x enableSimulationGlobal false;
	} foreach _objects;
},true] call Server_Setup_Compile;

//Compile block warning
["Server_Housing_LoadBox",
{
	private ["_house","_player","_pos","_items","_box","_weapons","_magazines","_items","_vitems","_cargoItems","_actualitems"];
	_player = param [0,objNull];
	_house = param [1,objNull];
	_pos = getposATL _player;
	if (!isNil {_house getVariable "box_spawned"}) exitwith {};
	//set variable that disables the box to be spawned again
	_house setVariable ["box_spawned",true,false];

	if (isDedicated) then { _items = [format ["SELECT items,vitems FROM houses WHERE location = '%1'",(getpos _house)], 2, true] call Server_Database_Async;} else {_items = [[],[],[]];};
	_box = createVehicle ["Box_GEN_Equip_F",_pos, [], 0, "CAN_COLLIDE"]; //replace with custom ammo box later
	clearItemCargoGlobal _box; //temp until custom ammo box
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackpackCargoGlobal _box;

	//According to how stuff is saved into db
	_cargoItems = call compile ((_items select 0) select 0);
	_vitems = call compile ((_items select 0) select 1);
	_weapons = _cargoItems select 0;
	_magazines = _cargoItems select 1;
	_actualitems = _cargoItems select 2;
	_backpacks = _cargoItems select 3;

	//add items [["srifle_EBR_F"],[],[]]
	{_box addWeaponCargoGlobal [_x,1]} foreach _weapons;
	{_box addMagazineCargoGlobal [_x,1]} foreach _magazines;
	{_box addItemCargoGlobal [_x,1]} foreach _actualitems;
	{_box addBackpackCargoGlobal [_x,1]} foreach _backpacks;
	_box setVariable ["storage",_vitems,true];
	_box setVariable ["house",_house,true];
},true] call Server_Setup_Compile;

["Server_Housing_SaveBox",
{
	private ["_box","_house","_pos","_query","_items"];
	_house = param [0,objNull];
	_box = param [1,objNull];
	_pos = getpos _house;

	//save contents of box into db
	_items = [weaponCargo _box,magazineCargo _box,itemCargo _box,backpackCargo _box];
	_query = format ["UPDATE houses SET items='%1',vitems='%3' WHERE location ='%2'",_items,_pos,(_box getVariable ["storage",[]])];
	[_query,1] spawn Server_Database_Async;

	//delete box
	deleteVehicle _box;

	//set var that makes the box loadable again
	_house setVariable ["box_spawned",nil,false];
},true] call Server_Setup_Compile;

//Initialize houses, assign all doorIDs, on server start
//COMPILE BLOCK WARNING
["Server_Housing_Initialize",
{

	private ["_houses","_query","_return","_uid","_pos","_doorID","_near","_signs"];
	//also make sure to update _obj location if it's changed (just incase we move anything slightly with terrain builder), delete it if it cannot be found nearby
	_houses = ["SELECT uid,location,doorid,roommates FROM houses", 2, true] call Server_Database_Async;
	{
		private ["_pos","_uid","_doorid"];
		_uid = _x select 0;
		_pos = call compile (_x select 1);
		_doorid = _x select 2;
		_roommates = call compile (_x select 3);

		_near = nearestObjects [_pos, ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01","Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_BostonHouse","Land_A3PL_Shed3","Land_A3PL_Shed4","Land_A3PL_Shed2"], 10,true];
		if (count _near == 0) exitwith
		{
			//DELETE from database
			//_query = format ["DELETE FROM houses WHERE location ='%1'",_pos];
			//[_query,1] spawn Server_Database_Async;
			[_uid,"House Deleted",["House deleted from table",_pos,_doorid]] call Server_Log_New;

		};
		_near = _near select 0;
		if (!([_pos,(getpos _near)] call BIS_fnc_areEqual)) then
		{
			//Update position in DB
			_query = format ["UPDATE houses SET location='%1' WHERE location ='%2'",(getpos _near),_pos];
			[_query,1] spawn Server_Database_Async;
		};

		//look for nearest for sale sign and set the texture to sold
		_signs = nearestObjects [_pos, ["Land_A3PL_EstateSign"], 25,true];
		if (count _signs > 0) then
		{
			(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
		};

		//Set variables
		_near setVariable ["doorID",[_uid,_doorid],true];
		_near setVariable ["owner",[_uid],true];
		_near setVariable ["roommates", _roommates, true];
		Server_HouseList pushback _near;
	} foreach _houses;
},true,true] call Server_Setup_Compile;

//This function will change/buy the ownership of a house
["Server_Housing_AssignHouse",
{
	private ["_object","_player","_uid","_keyID","_pos","_insert","_var","_signs","_takeMoney","_price"];
	_object = param [0,objNull];
	_player = param [1,objNull];
	_takeMoney = param [2,true];
	_price = param [3,0];
	_uid = getPlayerUID _player;

	//set owner var on object
	_object setVariable ["owner",[_uid],true];
	_object setVariable ["roommates",[],true];

	//take money
	if (_takeMoney) then
	{
		_player setVariable ["player_bank",((_player getVariable ["player_bank",0]) - _price),true];
	};

	//Generate a new key, it will take care of assigning it to the house aswell
	//It will also take care of saving the player keys into the DB
	_keyID = [_player,_object,"",false] call Server_Housing_CreateKey;
	//Insert into houses list, but only if it doesn't exist already
	if (!(_object IN Server_HouseList)) then
	{
		Server_HouseList pushback _object;
	};

	//Input the new owner, or replace if exist
	//The unique key is the location in this case (BEWARE OF THIS!!!)
	//Also be carefull, _expireTime is in SQL style, not arma (array) style
	_pos = getpos _object;
	_insert = format ["INSERT INTO houses (uid,location,doorid) VALUES ('%1','%2','%3') ON DUPLICATE KEY UPDATE uid='%1',doorID='%3'",_uid,_pos,_keyID];
	[_insert,1] spawn Server_Database_Async;

	_player setVariable ["house",_object,true];
	_var = _player getVariable ["apt",nil];
	if (!isNil "_var") then
	{
		//unassign appartment, just in case
		[_player] call Server_Housing_UnAssignApt;

		//Nil apt variable, just in case
		_player setVariable ["apt",Nil,true];
		_player setVariable ["aptnumber",Nil,true];
	};

	//sign
	_signs = nearestObjects [_object, ["Land_A3PL_EstateSign"], 20];
	if (count _signs > 0) then
	{
		(_signs select 0) setObjectTextureGlobal [0,"\A3PL_Objects\Street\estate_sign\house_rented_co.paa"];
	};

	[_uid,"House Purchased",["House Purchased from table",_pos,_keyID,_price], _player getVariable "name"] call Server_Log_New;

},true] call Server_Setup_Compile;

//This will set the position of the player to their appartment
["Server_Housing_SetPosApt",
{
	private ["_player","_apt","_aptNumber","_posApts"];
	_player = param [0,objNull];

	_apt = _player getVariable "apt";
	_aptNumber = _player getVariable "aptNumber";

	if ((isNil "_apt") OR (isNil "_aptnumber")) exitwith {diag_log "Error setting player to assigned appartment"};

	//list of appartment spawn positions
	_posApts = [[0.0732422,8.21582],[0.723145,2.35547],[0.729004,-2.39551],[1.8501,-8.38477],[1.23389,8.32764],[1.61963,2.26953],[1.50342,-2.50537],[1.67139,-8.31201]]; //Z doesnt seem to work properly, we will use custom ATL instead
	_posAptsATL = [0.231,0.231,0.231,0.231,3.00974,3.00974,3.00974,3.00974]; //Custom height here, workaround
	_posAptATL = _apt modelToWorld (_posApts select (_aptNumber - 1));

	_player setposATL [(_posAptATL select 0),(_posAptATL select 1),(_posAptsATL select (_aptNumber - 1))];
},true] call Server_Setup_Compile;

["Server_Housing_AssignApt",
{
	private ["_player","_objToAssign","_var","_cannotAssign","_AptToAssign","_doorName"];
	_player = param [0,objNull];
	//First find an appartment building with less than 8 assigned appartments
	{
		private ["_assigned"];
		_assigned = _x getVariable "Server_AptAssigned";
		if (count _assigned < 8) exitwith
		{
			_objToAssign = _x;
		};
	} foreach Server_AptList;


	//if we cannot find any then exit
	if (isNil "_objToAssign") exitwith {diag_log "Error assigning apartment to player: None available"};

	//Now lets figure out which one we cannot assign
	_var = _objToAssign getVariable "Server_AptAssigned";
	_cannotAssign = [];

	{
		_cannotAssign pushback (_x select 0);
	} foreach _var;

	//lets find out which one we CAN assign
	_AptToAssign = 1;
	while {_AptToAssign IN _cannotAssign} do
	{
		_AptToAssign = _AptToAssign + 1;
	};

	//once this loop ends we should end up with _AptToAssign that is available, so lets assign it
	_var pushBack [_AptToAssign,_player];
	_objToAssign setVariable ["Server_AptAssigned",_var,false];

	//Lets figure out the door that should be openable now that the player owns that appartment
	_doorName = format ["door_%1",_AptToAssign];

	//Lets generate a key for that appartment
	[_player,_objToAssign,_doorName,false] call Server_Housing_CreateKey;

	//set a variable to indicate the player owns an apartment
	_player setVariable ["apt",_objToAssign,true];
	_player setVariable ["aptnumber",_AptToAssign,true];
	[[_objToAssign,_AptToAssign],"A3PL_Housing_AptAssignedMsg",_player,false] call BIS_fnc_MP;
	//lock whatever door belongs to that apartment
	_objToAssign setVariable [(format ["Door_%1_locked",_AptToAssign]),true,true];
},true] call Server_Setup_Compile;

["Server_Housing_UnAssignApt",
{
	private ["_player","_var","_obj","_var1"];
	_player = param [0,objNull];

	//Loop through all appartments, find the correct one and delete it
	/*
	_f = false;
	{
		if (_f) exitwith {};
		_obj = _x;
		_var = _x getVariable "Server_AptAssigned";
		{
			if ((_x select 1) == player) exitwith
			{
				_var deleteAt _forEachIndex;
				_obj setVariable ["Server_AptAssigned",_var,false];
				_f = true;
			};
		} foreach _var;
	} foreach Server_AptList;
	*/

	//could potentially also use aptNumber
	_var1 = _player getVariable "apt";
	_var = _var1 getVariable "Server_AptAssigned";
	{
		if ((_x select 1) == _player) exitwith
		{
			_var deleteAt _forEachIndex;
			_var1 setVariable ["Server_AptAssigned",_var,false];
		};
	} foreach _var;

},true] call Server_Setup_Compile;


["Server_Housing_BuyTickets",
{
	private ["_amount","_tax","_ownshouse","_maxAmount","_player","_obj","_getVar","_ticketsSold","_playerNumbers","_playerIndex","_ticketsAdded","_ticketsSoldPlayer","_auctioneer","_moneyauctioneer","_ticketPrice","_getVar"];

	//_maxAmount is max tickets player can have
	_maxAmount = 5;
	//_ticketprice is ticket price
	_ticketPrice = 500;

	_player = param [0,objNull];
	_amount = param [1,1];
	if (_amount < 1) exitwith {};
	_obj = param [2,objNull]; //house for sale sign

	_getVar = _obj getVariable ["tickets",nil];
	if (isNil "_getVar") exitwith
	{
	};

	//Check if the buyer is the auctioneer
	_auctioneer = _obj getVariable "Auctioneer";
	if (_player == _auctioneer) exitwith
	{
		//return message to player
		[[3],"A3PL_Housing_LotteryReturn",(owner _auctioneer),false] call BIS_fnc_MP;
	};

	//check if the player already owns a house
	_ownsHouse = _player getVariable ["house",nil];
	if (!isNil "_ownsHouse") exitwith
	{
		//return message to player
		[[10],"A3PL_Housing_LotteryReturn",_player,false] call BIS_fnc_MP;
	};

	//first retrieve all tickets that have already been sold
	_ticketsSold = [];
	if (count _getVar > 0) then
	{
		{
			{
				_ticketsSold pushback _x;
			} foreach (_x select 1);
		} foreach _getVar;
	};

	//Check how many tickets this player already has
	_ticketsSoldPlayer = 0;
	{
		if ((_x select 0) == _player) then
		{
			_ticketsSoldPlayer = count (_x select 1);
		};
	} foreach _getVar;

	//if the amount of tickets the player want to buy exceeds _maxamount
	if ((_amount + _ticketsSoldPlayer) > _maxAmount) exitwith
	{
		//return message to player
		[[2],"A3PL_Housing_LotteryReturn",_player,false] call BIS_fnc_MP;
	};

	//Check the money here
	_tax = round (_ticketprice * Tax_Property_Rate);
	_ticketMoney = (_ticketprice * _amount) + _tax;

	if ((_player getVariable "Player_Cash") < _ticketmoney) exitWith
	{
		[[6],"A3PL_Housing_LotteryReturn",_player,false] call BIS_fnc_MP;
	};


	_numbersToSell = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99];
	_ticketsAdded = 0;
	for "i" from 0 to _amount do
	{
		{
			if (_ticketsAdded >= _amount) exitwith {};
			if (!(_x IN _ticketsSold)) then
			{
				//Save the number we need to add into a temp variable
				_n = _x;

				//first get numbers the player already has
				_playerNumbers = [];
				_playerIndex = -1;

				// if there is already stuff in the setvariable
				if (count _getVar > 0) then
				{
					{
						//Look for the player and exit
						if (_x select 0 == _player) exitwith
						{
							_playerNumbers = _x select 1;
							_playerIndex = _forEachIndex;
						};
					} foreach _getVar;
				};

				_playerNumbers pushBack _n;
				_ticketsSold pushBack _n;

				if (_playerIndex == -1) then
				{
					//Now we simply add because there is no index
					_getVar pushback [_player,_playerNumbers];
				} else
				{
					//Okay we have an index lets add it to the array that already exists
					_getVar set [_playerIndex,[_player,_playerNumbers]];
				};
				_ticketsAdded = _ticketsAdded + 1;
			};
		} foreach _numbersToSell;
	};

	//If for whatever reason we couldn't add the required amount we exit the script, and we dont setVariable
	if (_ticketsAdded < _amount) exitwith
	{
		[[5],"A3PL_Housing_LotteryReturn",_player,false] call BIS_fnc_MP;
	};

	//set money here
	[_player, 'Player_Cash', ((_player getVariable 'Player_Cash') - _ticketmoney)] call Server_Core_ChangeVar;

	//add money to mayor
	Tax_Property_Balance = Tax_Property_Balance + _tax;

	//setvariable
	_obj setvariable ["Tickets",_getVar];

	//add money to auctioneer here and send him a message
	_moneyAuctioneer = _ticketmoney * 0.05; // 5 percent currently
	[_auctioneer, 'Player_Cash', ((_auctioneer getVariable 'Player_Cash') + _moneyAuctioneer)] call Server_Core_ChangeVar;
	[[4,_player,_amount,_moneyAuctioneer],"A3PL_Housing_LotteryReturn",(owner _auctioneer),false] call BIS_fnc_MP;

	//Send message to player
	[[1,_amount,_ticketMoney,_playerNumbers],"A3PL_Housing_LotteryReturn",_player,false] call BIS_fnc_MP;
},true] call Server_Setup_Compile;

//[player,player_objIntersect] call Server_Housing_InitLottery
["Server_Housing_InitLottery",
{
	private ["_player","_n","_getVar","_c","_owner","_isSelling"];
	_player = param [0,objNull];
	_obj = param [1,objNull];

	_getVar = _obj getVariable "Tickets";

	if (!isNil "_getVar") exitwith {};
	if (!(_obj isKindOf "Land_A3PL_EstateSign")) exitwith {};

	//first we check in the nearest area to find the house that we are going to 'sell'
	_n = nearestObjects [_player, ["Land_Home1g_DED_Home1g_01_F","Land_Mansion01"], 20];
	if (count _n < 1) exitwith {};
	_n = _n select 0;

	//here we need to check if the house already have an owner
	_owner = _n getVariable ["owner",nil];
	if (!isNil "_owner") exitwith
	{
		[[7],"A3PL_Housing_LotteryReturn",_player,false] call bis_fnc_mp;
	};

	if (!isNil "A3PL_Housing_IsSelling") exitwith
	{
		[[9],"A3PL_Housing_LotteryReturn",_player,false] call bis_fnc_mp;
	};

	A3PL_Housing_IsSelling = true;

	_obj setVariable ["House",_n,false];
	_obj setVariable ["Tickets",[],false];
	_obj setVariable ["Auctioneer",_player,false];
	_c = 300;  //Change _countdown if the lottery needs to start quicker or later
	_obj setVariable ["countdown",_c,true];

	[_obj,_c,_player] spawn
	{
		private ["_countdown","_obj"];
		_countdown = param [1,300];
		_obj = param [0,objNull];
		_player = param [2,objNull];

		while {_countdown > 0} do
		{
			uiSleep 5;
			_countdown = _countdown - 5;
			_obj setVariable ["countdown",_countdown,true];
		};

		A3PL_Housing_IsSelling = Nil;
		[_obj] call Server_Housing_StartLottery;
	};

	[[8,_n,_c],"A3PL_Housing_LotteryReturn",true,false] call bis_fnc_mp;

},true] call Server_Setup_Compile;

["Server_Housing_StartLottery",
{
	private ["_auctioneer","_r","_h","_getVar","_w","_a"];
	_obj = param [0,objNull];
	//get auctioneer selling the house
	_auctioneer = _obj getVariable "auctioneer";
	//First figure out the highest number drawn
	_getVar = _obj getVariable "Tickets";
	_h = -1;
	{
		{
			if (_x > _h) then
			{
				_h = _x;
			};
		} foreach (_x select 1);
	} foreach _getVar;

	//_h = -1 means nobody bought anything
	if (_h == -1) exitwith
	{
		_obj setVariable ["House",nil,false];
		_obj setVariable ["Tickets",nil,false];
		_obj setVariable ["Auctioneer",nil,false];
		_obj setVariable ["countdown",nil,true];
	};

	//Generate two numbers
	_r = floor (random (_h+1));

	//Figure out the winner
	_w = Nil;
	{
		_a = _x select 0;
		{
			if (_x == _r) exitwith
			{
				_w = _a;
			};
		} foreach (_x select 1);
	} foreach _getVar;

	//if somehow there is an error we exit and nil the variables
	if (isNil "_w") exitwith
	{
		_obj setVariable ["House",nil,false];
		_obj setVariable ["Tickets",nil,false];
		_obj setVariable ["Auctioneer",nil,false];
		_obj setVariable ["countdown",nil,true];
	};
	if (!(isPlayer _w)) exitwith
	{
		_obj setVariable ["House",nil,false];
		_obj setVariable ["Tickets",nil,false];
		_obj setVariable ["Auctioneer",nil,false];
		_obj setVariable ["countdown",nil,true];
	};

	//Now we assign the house to the player
	_house = _obj getVariable "House";
	[_house,_w] call Server_Housing_AssignHouse;

	//Find the targets to send bis_fnc_mp
	_targets = [];
	{
		if (isPlayer (_x select 0)) then
		{
			_targets pushBack (_x select 0);
		};
	} foreach _getVar;

	//add the auctioneer to the targets array
	_targets pushback _auctioneer;

	//Bis_fnc_mp the results
	[[_house,_auctioneer,_getVar,_r,_w],"A3PL_Housing_LotteryStart",_targets,false] call BIS_FNC_MP;

	//Nil the variables
	_obj setVariable ["House",nil,false];
	_obj setVariable ["Tickets",nil,false];
	_obj setVariable ["Auctioneer",nil,false];
	_obj setVariable ["countdown",nil,true];

},true] call Server_Setup_Compile;


//Function that will run when a player picks up a key
["Server_Housing_PickupKey",
{
	private ["_object","_keyID","_keys"];
	_object = _this select 0;
	if (isNull _object) exitwith {};
	_player = _this select 1;

	if (_object getVariable ["inuse",false]) exitwith {};
	_object setVariable ["inuse",true,false];
	deleteVehicle _object;

	_keyID = _object getVariable "keyID";
	if (isNil "_keyID") exitwith {};
	_keys = _player getVariable "keys";

	_keys pushBack _keyID;
	_player setvariable ["keys",_keys,true];
},true] call Server_Setup_Compile;

//Function that will run when a player drops a key
["Server_Housing_dropKey",
{
	private ["_object","_keyID","_keys"];
	_object = _this select 0;
	if (isNull _object) exitwith {};
	_player = _this select 1;
	_keys = _player getVariable "keys";
	_keyID = _object getVariable "keyID";
	{
		if (_x == _keyID) exitwith
		{
			_keys deleteAt _forEachIndex;
		};
	} foreach _keys;
	_player setVariable ["keys",_keys,true];
},true
] call Server_Setup_Compile;

//This function will create and assign key
//arguments:
["Server_Housing_CreateKey",
{
	private ["_obj","_keys","_player","_id","_name"];
	_player = param [0,objNull];
	_uid = getPlayerUID _player;
	_obj = param [1,objNull];
	_door = param [2,objNull];
	_id = "";
	_name = "";

	//do we want this function to update the database?
	_saveKey = param [3,true];

	if (!(_obj isKindOf "house")) exitwith {};

	if (typeOf _obj == "Land_A3PL_Motel") then
	{
		private ["_var"];
		_name = _this select 2;
		_var = _obj getVariable "doorID";
		if (isNil "_var") then
		{
			_var = [];
		};

		//Delete the uniqueID for that key if already exist
		{
			if ((_x select 2) == _name) exitwith
			{
				_var deleteAt _forEachIndex;
			};
		} foreach _var;
		_id = _door;
		_var pushback [_uid,_door,_name];

		_obj setVariable ["doorID",_var,true];
		_player setVariable ["keys",nil,true];

	} else
	{
		_id = [5] call Server_Housing_GenerateID;
		_obj setVariable ["doorID",[_uid,_id],true];
	};

	//Assign new keys
	_keys = _player getVariable ["keys",[]];
	_keys pushback _id;
	_player setVariable ["keys",_keys,true];


	//Save the doorID into the database (but only when its a house)
	if (_name == "") then
	{
		if (_saveKey) then
		{
			_query = format ["UPDATE houses SET doorid='%1' WHERE location ='%2'",_id,(getpos _obj)];
			[_query,1] spawn Server_Database_Async;
		};

		//Save player keys
		[_player] call Server_Housing_SaveKeys;
	};

	//Return key
	_id;

},true] call Server_Setup_Compile;


//not used anymore
["Server_Housing_ClearKeys",
{
	private ["_keys","_keysToRemove","_listAllHouseID"];

	_keys = param [0,[]];
	if (count _keys == 0) exitwith {_keys};
	_keysToRemove = [];
	_ListAllHouseID = [];

	{
		_ListAllHouseID pushback ((_x getVariable ["doorID",[]]) select 1);
	} foreach Server_HouseList;

	{
		if (count _x == 4) then //remove all motel/apt keys
		{
			_keysToRemove pushback _x;
		} else
		{
			if (!(_x IN _ListAllHouseID)) then //doorid is not in _ListAllHouseID
			{
				_keysToRemove pushback _x;
			};
		};
	} foreach _keys;

	{
		_keys = _keys - [_x];
	} foreach _keysToRemove;

	_keys
},true] call Server_Setup_Compile;

//This will save all the keys of a specific player
['Server_Housing_SaveKeys',
{
	private ["_uid","_player","_keys"];
	_player = param [0,objNull];
	_uid = param [1,getPlayerUID _player];
	_keys = _player getVariable "keys";

	if (isNil "_keys") exitwith {};
	_query = format ["UPDATE players SET userkey='%1' WHERE uid ='%2'",([_keys] call Server_Database_Array),_uid];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;


["Server_Housing_GenerateID",
{
	private ['_r','_return','_digits'];
	_digits = _this select 0;

	//,0,1,2,3,4,5,6,7,8,9
	_r = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	_return = [];
	for "_i" from 1 to _digits do
	{
		_return pushback (_r select (floor (random (count _r - 1))));
	};
	_return = _return joinString "";
	_return;
},true] call Server_Setup_Compile;
