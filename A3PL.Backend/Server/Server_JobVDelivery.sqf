//request to add delivery job to job list
["Server_JobVDelivery_AddJobRequest",
{
	private ["_player","_class","_shop","_price","_already","_id","_playerUID"];
	_player = param [0,objNull];
	_playerUID = getPlayerUID _player;
	_class = param [1,""];
	_shop = param [2,""];
	_price = [_shop, "buyPrice"] call A3PL_Config_GetShop;
	
	//check if already a pending job
	_already = false;
	{
		if ((_x select 0) == _playerUID) exitwith
		{
			_already = true;
		};
	} foreach Server_JobVDelivery_JobList;
	
	if (_already) exitwith
	{
		[[1],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//check if already has a delivery on the way
	{
		if (_x select 0 == _playerUID) exitwith
		{
			_already = true;
		};
	} foreach Server_JobVDelivery_Deliveries;		
	
	if (_already) exitwith
	{
		[[2],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};	
	
	_tax = round(_price * Tax_Sales_Rate);
	_price = _price + _tax;
	
	//check if the player has enough money
	_playerCash = _player getVariable ["Player_Cash",0];
	if (_price > _playerCash) exitWith 
	{
		[[3],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};	
	
	//add tax to mayors thing
	Tax_Sales_Balance = Tax_Sales_Balance + _tax;
	
	//Charge the player and add the job
	[_player,"Player_Cash",(_playerCash - _price)] call Server_Core_ChangeVar;
	
	//buy vehicle and return id of the vehicle
	_id = [_player,_class,true] call Server_Vehicle_Buy;
	
	//add the job
	//player uid,class,id
	Server_JobVDelivery_JobList pushback [_playerUID,_class,_id];
	
	//Get list of truckers
	_truckers = ["trucker"] call A3PL_Lib_FactionPlayers;
	
	//send message to truckers
	if (count _truckers > 0) then
	{
		[[5],"A3PL_JobVDelivery_addJobReceive",_truckers] call BIS_FNC_MP;
	};
	
	//send message back to buyer
	[[4],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

//Sends the joblist back to the player requesting it
["Server_JobVDelivery_SendJobList",
{
	private ["_player","_jobList"];
	_player = param [0,objNull];
	if (isNull _player) exitwith {};
	
	//take out the jobs of players that are not on the server
	_joblist = [];
	{ 
		if (!isNull ([(_x select 0)] call A3PL_Lib_UIDToObject)) then
		{
			_jobList pushback _x;
		};
	} foreach Server_JobVDelivery_JobList;
	
	[[_joblist],"A3PL_JobVDelivery_ReceiveJobList",(owner _player)] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

//Player that requests a job
["Server_JobVDelivery_TakeJob",
{
	private ["_player","_job","_deliveryFor","_deliveryClass","_deliveryID","_vehicle","_trailer","_already","_deliverTo","_vehicle","_jobToClear"];
	_player = param [0,objNull];
	_job = param [1,[]]; //the array entry of the job
	if ((count _job) == 0) exitwith {};
	 
	_deliveryFor = [_job select 0] call A3PL_Lib_UIDToObject;
	_deliveryClass = _job select 1;
	_deliveryID = _job select 2;
	
	//first check if this player is already doing more than 2 deliveries
	_already = 0;
	{
		 if ((_x select 0) == (getPlayerUID _player)) then {_already = _already + 1};
	} foreach Server_JobVDelivery_Deliveries;
	
	if (_already >= 2) exitwith
	{
		[[8],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//check if the _player is no longer on the server
	if ((!isPlayer _player) or (isNull _player)) exitwith {};
	
	//Check if isNull or !isPlayer for the deliveryFor
	if ((isNull _deliveryFor) OR (!isPlayer _deliveryFor)) exitwith
	{
		[[10],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//check if the _deliveryTo == _player
	if (_player == _deliveryFor) exitwith
	{
		[[17],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//check for nearby trailer
	_trailers = nearestObjects [_player,["A3PL_LowLoader_Default"],30];
	{
		if (((_x getVariable ["owner",[""]]) select 0) == getPlayerUID _player) exitwith
		{
			_trailer = _x;
		};
	} foreach _trailers;
	
	if (isNil "_trailer") exitwith
	{
		[[9],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//Check for a empty position that we can spawn the vehicle at
	_spawnPos = (getpos _player) findEmptyPosition [2,20,_deliveryClass];
	
	//if we cannot find a suitable position
	if (count _spawnPos == 0) exitwith
	{
		[[11],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//Figure out where to deliver it to
	_apt = _deliveryFor getVariable ["apt",nil];
	if (!isNil "_apt") then
	{
		_aptNumber = _deliveryFor getVariable ["aptNumber",nil];
		if (isNil "_aptNumber") exitwith {};
		_deliverTo = [_apt,_aptNumber];
	} else
	{
		_house = _deliveryFor getVariable ["house",nil];
		if (isNil "_house") exitwith {};
		_deliverTo = _house;
	};
	
	//unable to determine the delivery location
	if (isNil "_deliverTo") exitwith
	{
		[[13],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};	
	
	//Check is job is still available
	{
		private ["_id"];
		if (_deliveryID == (_x select 2)) exitwith
		{
			_jobToClear = _forEachIndex; 
		};
	} foreach Server_JobVDelivery_JobList;
	
	//couldn't get the job available
	if (isNil "_jobToClear") exitwith
	{
		[[14],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//clear the job from the joblist
	Server_JobVDelivery_JobList deleteAt _jobToClear;
	
	//Spawn the vehicle
	_vehicle = [_deliveryClass,_spawnPos,_deliveryID,_player] call Server_Vehicle_Spawn;
	_vehicle allowDamage false; //if vehicle changes locality damage will still occur		
	
	//set some variables on the car
	_vehicle setVariable ["delivery",[(getPlayerUID _deliveryFor),(getPlayerUID _player),_deliverTo],true]; //dont forget to nil this when the delivery is completed
	
	//add an entry into the deliveries array
	Server_JobVDelivery_Deliveries pushback [(getPlayerUID _player),(getPlayerUID _deliveryFor),_vehicle,_trailer,_deliveryClass,_deliveryID,time];	
	
	//send the player a message with the address to deliver it to
	[[12,_deliverTo],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

//Loop that checks a bunch of things
["Server_JobVDelivery_Loop",
{
	private ["_JobClear","_deliveryClear"];
	
	//clear deliveries here of players that are no longer in the game or vehicles that are away from their flatbed, and put it back in the joblist
	_deliveryClear = [];
	{
		private ["_player","_deliveryFor","_vehicle","_trailer","_deliveryClass","_deliveryID","_time"];
		
		_player = [(_x select 0)] call A3PL_Lib_UIDToObject;
		_deliveryFor = [(_x select 1)] call A3PL_Lib_UIDToObject;
		_vehicle = _x select 2;
		_trailer = _x select 3;
		_deliveryClass = _x select 4;
		_deliveryID = _x select 5;
		_time = _x select 6;
		
		//900 = 15 minutes
		if (((time - _time) > 900) OR (isNull _player) OR (isNull _deliveryFor) OR (isNull _vehicle) OR (isNull _trailer) OR (_vehicle distance _trailer > 50) OR (_player distance _trailer > 50) OR (_player getvariable ["Incapacitated",false])) then
		{
			_deliveryClear pushback _forEachIndex;
		};
	} foreach Server_JobVDelivery_Deliveries;
	
	{
		//select the corresponding delivery array
		_deliveryArray = Server_JobVDelivery_Deliveries select _x;
		
		//re-add the job
		Server_JobVDelivery_JobList pushBack [(_deliveryArray select 1),(_deliveryArray select 4),(_deliveryArray select 5)];
		
		//make sure the vehicle is deleted
		if (!isNull (_deliveryArray select 2)) then
		{
			deleteVehicle (_deliveryArray select 2);
		};
		
		//send both players a message saying that it was unsuccesfull to deliver the car
		private ["_player","_deliverTo"];
		_player = [(_deliveryArray select 0)] call A3PL_Lib_UIDToObject;
		_deliverTo = [(_deliveryArray select 1)] call A3PL_Lib_UIDToObject;
		
		//check isPlayer because they might not be on the server anymore
		if (isPlayer _player) then
		{
			[[7],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP; //player doing delivery
		};
		
		if (isPlayer _deliverTo) then
		{
			[[6],"A3PL_JobVDelivery_addJobReceive",(owner _deliverTo)] call BIS_FNC_MP; //receiving delivery
		};
		
		//delete it from the delivery array
		Server_JobVDelivery_Deliveries deleteAt _x;		
	} foreach _deliveryClear;	
	
	//we need to clear jobs out of the Vehicle Job list of players that are no longer in the game
	//One limitation: Once the player leaves and comes back his car will not appear in the storage until a server restart
	/*
	_JobClear = [];
	{
		_player = _x select 0;
		if ((isNull _player) OR (!isPlayer _player)) then
		{
			_JobClear pushback _forEachIndex;
		};
	} foreach Server_JobVDelivery_JobList;
	
	{
		Server_JobVDelivery_JobList deleteAt _x;
	} foreach _JobClear;
	*/
	
	["Server_JobVDelivery_JobList"] call Server_Core_SavePersistentVar;
},true] call Server_Setup_Compile;

["Server_JobVDelivery_Deliver",
{
	private ["_car","_player","_deliveryVar","_carID","_ownerUID","_deliverTo"];
	_player = param [0,objNull];
	_car = param [1,objNull];
	if ((isNull _car) or (isNull _player)) exitwith {};
	
	//check if the delivery variable isn't nil, in-case people like to spam....
	_deliveryVar = _car getVariable ["delivery",nil];
	if (isNil "_deliveryVar") exitwith {};
	
	//nil the delivery variable
	_car setVariable ["delivery",nil,true];
	
	//lock the car
	_car setVariable ["locked",true,true];
	
	//change the owner variable of the car to the new owner
	_ownerUID = _deliveryVar select 0;
	_carID = (_car getVariable ["owner",[]]) select 1;
	_car setVariable ["owner",[_ownerUID,_carID],true];	
	
	{
		if((getPlayerUID _x) IN (_car getVariable ["keyAccess",[]])) then {
			[_car, false] remoteExec ["A3RL_Vehicle_AddPlayerVehicles", _x];
		};
	} forEach allPlayers;
	_car setVariable ["keyAccess",[_ownerUID],true];
	[_car] remoteExec ["A3RL_Vehicle_AddPlayerVehicles", _player];

	
	//remove from delivery list
	{
		if ((_x select 5) == _carID) exitwith
		{
			Server_JobVDelivery_Deliveries deleteAt _forEachIndex;
		};
	} foreach Server_JobVDelivery_Deliveries;
	
	//add money to trucker and send him a message
	[_player,"Player_Cash",((_player getVariable ["player_cash",0]) + 500)] call Server_Core_ChangeVar;
	[[15],"A3PL_JobVDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	
	//send message to the deliveryTo
	//we convert the UID to a player object because the player object might've changed rejoined the server
	_deliverTo = [_ownerUID] call A3PL_Lib_UIDToObject;
	if (!isNull _deliverTo) then
	{
		[[16],"A3PL_JobVDelivery_addJobReceive",(owner _deliverTo)] call BIS_FNC_MP;
	};
	
	//save the vehicle in the database
	_query = format ["INSERT INTO objects (id,type,class,uid,plystorage) VALUES ('%1','vehicle','%2','%3','0')",_carID,(typeOf _car),_ownerUID];
	[_query,1] spawn Server_Database_Async;	
},true] call Server_Setup_Compile;