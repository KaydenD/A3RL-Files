["Server_JobMDelivery_Add",
{
	private ["_player","_playerUID","_totalPrice","_type","_class","_amount","_hasPending"];
	_player = param [0,objNull];
	if (isNull _player) exitwith {};
	_playerUID = getPlayerUID _player;
	_totalPrice = param [1,0];
	_tax = param [2,0];
	_type = param [3,"ITEM"];
	_class = param [4,""];
	_amount = param [5,1];
	
	//Check if we already have 3 -currently- pending deliverys
	_hasPending = 0;
	{
		if (_x select 1 == _playerUID) then {_hasPending = _hasPending + 1};
	} foreach Server_JobMDelivery_JobList;
	
	{
		if (_x select 3 == _playerUID) then {_hasPending = _hasPending + 1};
	} foreach Server_JobMDelivery_Deliveries;
	
	if (_hasPending >= 3) exitwith
	{
		[1] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];
	};
	
	//take money
	[_player,"Player_Cash",((_player getVariable ["player_cash",0]) - _totalPrice)] call Server_Core_ChangeVar;
	
	//add taxes
	Tax_Sales_Balance = Tax_Sales_Balance + _tax;	
	
	//add to job list
	Server_JobMDelivery_JobList pushback [floor (random 5000),_playerUID,_type,[_class,_amount]]; // _array below
	
	[19] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];
},true] call Server_Setup_Compile;

//Sends the joblist back to the player requesting it
["Server_JobMDelivery_SendJobList",
{
	private ["_player","_jobList"];
	_player = param [0,objNull];
	if (isNull _player) exitwith {};
	
	//take out the jobs of players that are not on the server
	_joblist = [];
	{ 
		if (!isNull ([(_x select 1)] call A3PL_Lib_UIDToObject)) then
		{
			_jobList pushback [(_x select 0),(_x select 1)];
		};
	} foreach Server_JobMDelivery_JobList;
	
	//[_deliveryID,_playerUID] is what we send back
	[[_joblist],"A3PL_JobMDelivery_ReceiveJobList",(owner _player)] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

//retrieves info from given ID
["Server_JobMDelivery_RetrieveData",
{
	private ["_id","_deliveryUID","_deliveryType","_deliveryClassArray"];
	_id = param [0,0];
	
	{
		if (_x select 0 == _id) exitwith
		{
			_deliveryUID = _x select 1;
			_deliveryType = _x select 2;
			_deliveryClassArray = _x select 3;
		};
	} foreach Server_JobMDelivery_JobList;
	
	if (isNil "_deliveryUID") exitwith
	{
		[];
	};
	
	[_deliveryUID,_deliveryType,_deliveryClassArray];
},true] call Server_Setup_Compile;

//what happends when we take a job
["Server_JobMDelivery_Take",
{
	private ["_player","_playerUID","_array","_deliveryUID","_deliveryType","_deliveryClassArray","_pendingDeliveries","_deliverTo","_apt","_foundMailtruck","_deliveryPlayer"];
	
	_player = param [0,objNull];
	_playerUID = getPlayerUID _player;
	_deliveryID = param [1,[]];
	
	_array = [_deliveryID] call Server_JobMDelivery_RetrieveData;
	if (count _array == 0) exitwith {[7] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	
	_deliveryUID = _array select 0;
	_deliveryPlayer = [_deliveryUID] call A3PL_Lib_UIDToObject;
	if (isNull _deliveryPlayer) exitwith {[20] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	_deliveryType = _array select 1;
	_deliveryClassArray = _array select 2;
	
	//first check if we are delivering to ourselves
	if (_deliveryUID == _playerUID) exitwith {[2] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	
	//check if we have a mailtruck nearby
	_foundMailtruck = objNull;
	{
		if (((_x getVariable ["owner",[""]]) select 0) == _playerUID) exitwith
		{
			_foundMailtruck = _x;
		};
	} foreach (nearestObjects [_player, ["A3PL_MailTruck_base"], 20]);
	
	if (isNull _foundMailtruck) exitwith {[5] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	
	//check if we already have 3 packages to deliver
	_pendingDeliveries = 0;
	{
		if (_x select 4 == _playerUID) then {_pendingDeliveries = _pendingDeliveries + 1}; 
	} foreach Server_JobMDelivery_Deliveries;	
	if (_pendingDeliveries >= 3) exitwith {[3] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	
	//Figure out where to deliver it to
	_apt = _deliveryPlayer getVariable ["apt",nil];
	if (!isNil "_apt") then
	{
		_aptNumber = _deliveryPlayer getVariable ["aptNumber",nil];
		if (isNil "_aptNumber") exitwith {};
		_deliverTo = [_apt,_aptNumber];
	} else
	{
		_house = _deliveryPlayer getVariable ["house",nil];
		if (isNil "_house") exitwith {};
		_deliverTo = _house;
	};
	
	//unable to determine the delivery location
	if (isNil "_deliverTo") exitwith
	{
		[[4],"A3PL_JobMDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};	
	
	//remote out of joblist
	_clearID = -1;
	{
		if (_x select 0 == _deliveryID) then {_clearID = _forEachIndex};
	} foreach Server_JobMDelivery_JobList;
	
	if (_clearID == -1) exitwith {[8] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];};
	Server_JobMDelivery_JobList deleteAt _clearID;	
	
	//spawn package and set variables
	_package = createVehicle ["A3PL_DeliveryBox",_player, [], 0, "CAN_COLLIDE"];
	_package setVariable ["delivery",[_deliveryUID,_playerUID,_deliverTo,_deliveryID,true],true];
	_package setVariable ["packageContents",[_deliveryType,_deliveryClassArray],true];
	
	[_package,_player] spawn
	{
		_package = param [0,objNull];
		_player = param [1,objNull];
		
		uiSleep 1;
		_package setOwner (owner _player);
	};
	
	//add to delivery array
	Server_JobMDelivery_Deliveries pushback [_deliveryID,_package,_foundMailtruck,_deliveryUID,_playerUID,_deliveryType,_deliveryClassArray,(time + 1200)]; //20mins
	
	//send message back
	[17,_deliverTo] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _player)];
	
	//send message to buyer
	[21,(_player getVariable ["phone_number","Unknown"])] remoteExec ["A3PL_JobMDelivery_addJobReceive", (owner _deliveryPlayer)];
},true] call Server_Setup_Compile;

//clears a specific ID from variables
//second argument determines whether to put it back on the joblist or list
["Server_JobMDelivery_Clear",
{
	private ["_deliveryID","_putback","_f"];
	_deliveryID = param [0,0];
	_putback = param [1,true];
	
	{
		if (_x select 0 == _deliveryID) exitwith
		{
			if (_putback) then
			{
				Server_JobMDelivery_JobList pushback [(_x select 0),(_x select 3),(_x select 5),(_x select 6)]; //[floor (random 5000),_playerUID,_type,[_class,_amount]]
			};
			Server_JobMDelivery_Deliveries deleteAt _forEachIndex;
		};
	} foreach Server_JobMDelivery_Deliveries;
	
	
},true] call Server_Setup_Compile;

["Server_JobMDelivery_Loop",
{
	
	{
		private ["_deliveryID","_delivererUID","_delivererUID","_deliveryType","_deliveryClassArray","_package"];
		_deliveryID = _x select 0;
		_package = _x select 1;
		_assignedMailtruck = _x select 2;
		_deliveryUID = _x select 3;
		_delivererUID = _x select 4;
		_deliveryType = _x select 5;
		_deliveryClassArray = _x select 6;
		_timeLeft = (_x select 7) - time;
		
		_delivererPlayer = [_delivererUID] call A3PL_Lib_UIDToObject;
		_deliveryPlayer = [_deliveryUID] call A3PL_Lib_UIDToObject;
		
		_sendMessageFailed = false;
		
		//start performing checks
		if (isNull _delivererPlayer) then
		{
			if (!isNull _deliveryPlayer) then
			{
				[[9],"A3PL_JobMDelivery_addJobReceive",(owner _deliveryPlayer)] call BIS_FNC_MP;
			};
			[_deliveryID,true] call Server_JobMDelivery_Clear;
			deleteVehicle _package;
		};
		
		if (isNull _assignedMailtruck) then
		{
			[[10],"A3PL_JobMDelivery_addJobReceive",(owner _delivererPlayer)] call BIS_FNC_MP;
			_sendMessageFailed = true;
		};
		
		if ((_package distance _assignedMailtruck) > 20) then
		{
			[[11],"A3PL_JobMDelivery_addJobReceive",(owner _delivererPlayer)] call BIS_FNC_MP;
			_sendMessageFailed = true;
		};
		
		if (_timeLeft < 0) then
		{
			[[12],"A3PL_JobMDelivery_addJobReceive",(owner _delivererPlayer)] call BIS_FNC_MP;
			_sendMessageFailed = true;
		};
		
		if (_sendMessageFailed) then
		{
			//check if the person to delivery it to is still on the server
			if (!isNull _deliveryPlayer) then
			{
				[[13],"A3PL_JobMDelivery_addJobReceive",(owner _deliveryPlayer)] call BIS_FNC_MP;
			};
			[_deliveryID,true] call Server_JobMDelivery_Clear;
			deleteVehicle _package;
		};
	} foreach Server_JobMDelivery_Deliveries;
	
},true] call Server_Setup_Compile;

//_package setVariable ["delivery",[_deliveryUID,_playerUID,_deliverTo,_deliveryID],true];
//_package setVariable ["packageContents",[_deliveryType,_deliveryClassArray],false];

["Server_JobMDelivery_Collect",
{
	private ["_package","_contentArray"];
	_player = param [0,objNull];
	_package = param [1,objNull];
	if (isNull _player OR isNull _package) exitwith {};
	
	_packageInfo = _package getVariable ["delivery",[]];
	_deliveryUID = _packageInfo select 0;
	_delivererUID = _packageInfo select 1;
	_deliveryID = _packageInfo select 3;
	
	if (!(_deliveryUID == (getPlayerUID _player))) exitwith
	{
		[[16,_deliveryClassArray],"A3PL_JobMDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	_packageContents = _package getVariable ["packageContents",[]];
	if (count _packageContents == 0) exitwith {[[14],"A3PL_JobMDelivery_addJobReceive",(owner _deliveryPlayer)] call BIS_FNC_MP;};
	
	_deliveryType = _packageContents select 0;
	_deliveryClassArray = _packageContents select 1;
	
	_collecting = _package getVariable ["collecting",false];
	if (_collecting) exitwith {};
	_package setVariable ["collecting",true,false];
	
	if (_deliveryType == "ITEM") then
	{
		[_player] + _deliveryClassArray call Server_Inventory_Add;
		[[15,_deliveryClassArray],"A3PL_JobMDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	};
	
	//delete from delivery array
	{
		if (_x select 0 == _deliveryID) exitwith
		{
			Server_JobMDelivery_Deliveries deleteAt _forEachIndex;
		};
	} foreach Server_JobMDelivery_Deliveries;
	
	//check if it has been delivered
	_canDeliver = _packageInfo select 4;
	if (_canDeliver) then
	{
		_deliverObject = [_delivererUID] call A3PL_Lib_UIDToObject;
		if (!isNull _deliverObject) then
		{	
			//add money to deliver and send him a message
			_award = 200;
			[_deliverObject,"Player_Cash",((_deliverObject getVariable ["player_cash",0]) + _award)] call Server_Core_ChangeVar;
			[[24,_award],"A3PL_JobMDelivery_addJobReceive",(owner _deliverObject)] call BIS_FNC_MP;
		};
	};
	
	//delete package itself
	deleteVehicle _package;
	
},true] call Server_Setup_Compile;

["Server_JobMDelivery_Deliver",
{
	private ["_player","_package","_packageInfo","_deliveryUID","_deliveryID","_award","_deliverTo"];
	_player = param [0,objNull];
	_package = param [1,objNull];
	if (isNull _player OR isNull _package) exitwith {};
	
	_packageInfo = _package getVariable ["delivery",[]];
	_deliveryUID = _packageInfo select 0;
	_deliveryID = _packageInfo select 3;
	_canDeliver = _packageInfo select 4;
	
	//check if can be delivered
	if (!_canDeliver) exitwith {[[23],"A3PL_JobMDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;};
	_packageInfo set [4,false];
	_package setVariable ["delivery",_packageInfo,true];
	
	//delete from delivery array
	{
		if (_x select 0 == _deliveryID) exitwith
		{
			Server_JobMDelivery_Deliveries deleteAt _forEachIndex;
		};
	} foreach Server_JobMDelivery_Deliveries;	
	
	
	//add money to deliver and send him a message
	_award = 200;
	[_player,"Player_Cash",((_player getVariable ["player_cash",0]) + _award)] call Server_Core_ChangeVar;
	[[22,_award],"A3PL_JobMDelivery_addJobReceive",(owner _player)] call BIS_FNC_MP;
	
	//send message to the deliveryTo
	//we convert the UID to a player object because the player object might've changed rejoined the server
	_deliverTo = [_deliveryUID] call A3PL_Lib_UIDToObject;
	if (!isNull _deliverTo) then
	{
		[[18],"A3PL_JobMDelivery_addJobReceive",(owner _deliverTo)] call BIS_FNC_MP;
	};	
},true] call Server_Setup_Compile;