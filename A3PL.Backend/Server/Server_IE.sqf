#define SHIPSPAWNPOS [4166.04,8137.21,5]
#define SHIPTARGETPOS [3763,7715,0]
#define SHIPTIMEINDOCK 600
#define SHIPARRIVETIMEOUT 300
//Old ship spawn pos = [6057,9484,9]
["Server_IE_Init",
{
	if (isDedicated) then
	{
		Server_IE_Prices = ["SELECT * FROM import_export", 2, true] call Server_Database_Async;
	} else
	{
		Server_IE_Prices = 
		[
			["Crude_Oil",2925,488,10],
			["Gunpowder",544,91,5],
			["Synthetic_Fibre",74,12,2],
			["Glass_Fibre",8,4,2],
			["Fibreglass",270,45,20],
			["Plastic",214,36,20],
			["Glass",135,23,15],
			["Polyester",81,14,7],
			["Aramid",177,30,10],
			//["Iron_Ingot_Pellet",115425,19237,1000],
			//["Coal_Ingot_Pellet",115425,19237,1000],
			//["Aluminium_Ingot_Pellet",2308500,384750,20000],
			//["Titanium_Ingot_Pellet",4809375,801562,35000],
			//["Steel_Pellet",3510,585,300],
			//["Aluminium_Pellet",6583,1097,250],
			//["Titanium_Pellet",9560,1593,600],
			["Rubber",461,77,20],
			["Petrol",993,165,85],
			["LPG",604,100,35],
			["Kerosene",14718,2453,700],
			["CanisterOil",165,27,12]
		];		
	};
	
	publicVariable "Server_IE_Prices";
},true] call Server_Setup_Compile;

//changes the prices based on the containerArray supplied by IE_ShipImport and IE_ShipExport
["Server_IE_PriceChange",
{
	private ["_cArray","_import","_itemArray","_newPrice"];
	_cArray = param [0,[]];
	_import = param [1,true]; //whether we are importing or exporting
	_itemArray = []; //the final array which we will use the calculate the new prices
	{
		_itemArray = [_itemArray, (_x select 1), (_x select 2),false] call BIS_fnc_addToPairs;
	} foreach _cArray;
	
	{
		private ["_item","_amount","_itemIndex","_ieArray","_currentBuyPrice","_currentSellPrice","_query"];
		_item = _x select 0;
		_amount = _x select 1;
		
		//get the item index
		{
			if ((_x select 0) == _item) exitwith 
			{
				_ieArray = _x;
				_itemIndex = _forEachIndex;
			};
		} foreach Server_IE_Prices;
		if (isNil "_itemIndex") exitwith {};
		
		//change the price
		_currentBuyPrice = _ieArray select 1;
		_currentSellPrice = _ieArray select 2;		
		/*
			if (_import) then //if we are importing goods
			{
				_newPrice = round(_currentBuyPrice + (_currentBuyPrice * 0.01));
				_ieArray set [1,_newPrice]; //increase the buy price by 1% * the amount
				_newPrice = round(_currentSellPrice + (_currentSellPrice * 0.01));
				_ieArray set [2,_newPrice]; //increase the sell price by 1% * the amount		
			} else //if we are exporting goods
			{
				_newPrice = round(_currentBuyPrice - (_currentBuyPrice * 0.01));
				_ieArray set [1,_newPrice]; //decrease the buy price by 1% * the amount
				_newPrice = round(_currentSellPrice - (_currentSellPrice * 0.01));
				_ieArray set [2,_newPrice]; //decrease the sell price by 1% * the amount			
			};
		*/
		//update local array
		Server_IE_Prices set [_itemIndex,_ieArray];
		
		//update database
		_query = format ["UPDATE import_export SET import='%1',export='%2' WHERE item='%3'",(_ieArray select 1),(_ieArray select 2),(_ieArray select 0)];
		[_query,1] spawn Server_Database_Async;		
	} foreach _itemArray;
	publicVariable "Server_IE_Prices";
},true] call Server_Setup_Compile;

["Server_IE_ShipImport",
{
	private ["_ship","_driver","_targetPos","_timeOut","_timeOutLimit","_container","_cArray"];
	//set vars
	if (!isNil "Server_IE_Running") exitwith {}; //dont run the import script if its already running
	Server_IE_Running = true;
	//create ship
	_ship = createVehicle ["A3PL_Container_Ship", SHIPSPAWNPOS, [], 100, "CAN_COLLIDE"];	
	_ship allowDamage false; //disable damage for now
	_targetPos = SHIPTARGETPOS;
	_ship setDir (_ship getRelDir _targetPos);
	_driver = (createGroup civilian) createUnit ["C_man_p_beggar_F",SHIPSPAWNPOS, [], 0, ""];
	_driver moveInDriver _ship;
	_driver allowDamage false;
	_ship move _targetPos;	
	_ship setBehaviour "CARELESS";
	_container = 0;
	_cArray = [];
	
	//add containers
	{
		private ["_playerUID"];
		_playerUID = getPlayerUID _x;
		{
			if (!(_x select 2)) then //if it isnt available for collection yet
			{			
				_container = _container + 1;
				if (_container > 72) exitwith {};
				_cAnim = format ["c%1",_container];//container number
				_ship animateSource [_cAnim,1];
				_cArray pushback [_playerUID,(_x select 0),(_x select 1)];
			};
		} foreach (_x getVariable ["player_importing",[]]);
		if (_container > 72) exitwith {};
	} foreach allPlayers;
	_ship setVariable ["containerItems",_cArray,true];
	//change the prices
	[_cArray] call Server_IE_PriceChange;
	
	//set timeout limits
	_timeOut = 0;
	_timeOutLimit = SHIPARRIVETIMEOUT; //10mins
	//send message
	["Server: The container ship has entered the waters of Fishers Island, it will arrive into the Stoney Creek port soon", '#17ED00'] remoteExec ["A3PL_Player_Notification",-2]; //change to -2
	//set vars
	Server_IE_ShipImbound = true;
	publicVariable "Server_IE_ShipImbound";
	while {(_ship distance2D [3689.27,7647.33]) > 50} do {uiSleep 3; _timeOut = _timeOut + 3; if (_timeOut > _timeOutLimit) exitwith {true;}};
	if (_timeOut > _timeOutLimit) then //ship didnt arrive within the _timeOutLimit defined
	{
		_ship deleteVehicleCrew (driver _ship);
		deleteVehicle _ship;
		[] remoteExec ["A3PL_IE_ShipLost",-2];
		Server_IE_Running = nil; //not running anymore
	} else //ship reached the port
	{
		_ship setVelocity [0,0,0];
		_ship setDir 233.276;
		_ship setPosASL [3691.86,7648.34,-1.91811];
		//_ship enableSimulation false;
		[] remoteExec ["A3PL_IE_ShipArrived",-2];
		
		//spawn the mobile cranes, right dock first
		/*
		_crane1 = createVehicle ["A3PL_MobileCrane",[3673.65,7609.55,43], [], 0, "CAN_COLLIDE"];
		_crane1 allowdamage false;
		_crane1 setDir 53.0977;
		_crane1 setposATL [3673.65,7609.55,43];
		_crane2 = createVehicle ["A3PL_MobileCrane",[3614.14,7646.33,26], [], 0, "CAN_COLLIDE"];
		_crane2 allowdamage false;
		_crane2 setDir 233.149;		
		_crane2 setposATL [3614.14,7646.33,26];
		*/
		_crane1 = objNull;
		_crane2 = objNull;
		
		[_ship,_crane1,_crane2] spawn
		{
			private ["_ship","_crane1","_crane2","_wait"];
			_ship = param [0,objNull];
			_crane1 = param [1,objNull];
			_crane2 = param [2,objNull];
			
			_wait = 0;
			while {uiSleep 2; _wait < SHIPTIMEINDOCK} do { _wait = _wait + 2; if ((_ship distance2D [3691.86,7648.34]) > 5) then {_ship setDir 233.276; _ship setPosASL [3691.86,7648.34,-1.91811]}; _ship setVelocity [0,0,0]; };
			
			//run export function
			[_ship] spawn Server_IE_ShipExport;
			
			//clear ropes,container hooks etc
			{
				deleteVehicle _x;
			} foreach (nearestObjects [_crane1, ["A3PL_Container_Hook","A3PL_FD_HoseEnd1"], 20]);
			{
				deleteVehicle _x;
			} foreach (nearestObjects [_crane2, ["A3PL_Container_Hook","A3PL_FD_HoseEnd1"], 20]);
			
			//delete cranes
			deleteVehicle _crane1;
			deleteVehicle _crane2;
		};
	};
	Server_IE_ShipImbound = nil;
	publicVariable "Server_IE_ShipImbound";	
},true] call Server_Setup_Compile;

["Server_IE_ShipExport",
{
	private ["_ship","_timeOut","_timeOutLimit","_container","_cArray"];
	_ship = param [0,objNull];
	_ship setDir (getDir _ship + 180);
	_ship move SHIPSPAWNPOS;
	
	//reset all the containers
	for "_i" from 1 to 72 do
	{
		_cAnim = format ["c%1",_i];
		if ((_ship animationSourcePhase _cAnim) > 0.1) then
		{
			_ship animateSource [_cAnim,0];
		};
	};
	
	//set new containers according to export arrays
	_container = 0;
	_cArray = [];
	{
		private ["_playerUID"];
		_playerUID = getPlayerUID _x;
		{
			_container = _container + 1;
			if (_container > 72) exitwith {};
			_cAnim = format ["c%1",_container];//container number
			_ship animateSource [_cAnim,1];
			_cArray pushback [_playerUID,(_x select 0),(_x select 1)];
		} foreach (_x getVariable ["player_exporting",[]]);
		if (_container > 72) exitwith {};
	} foreach allPlayers;	
	_ship setVariable ["containerItems",_cArray];
	//change the prices
	[_cArray,false] call Server_IE_PriceChange;	
	
	//send message
	Server_IE_ShipOutbound = true;
	publicVariable "Server_IE_ShipOutbound";		
	["Server: The container ship is leaving the port of Stoney Creek", Color_Green] remoteExec ["A3PL_Player_Notification",-2];
	
	_timeOut = 0;
	_timeOutLimit = 600; //10mins	
	while {(_ship distance2D SHIPSPAWNPOS) > 35} do {uiSleep 2; _timeOut = _timeOut + 2; if (_timeOut > _timeOutLimit) exitwith {true;}};
	[] remoteExec ["A3PL_IE_ShipLeft",-2];
	_ship deleteVehicleCrew (driver _ship);
	deleteVehicle _ship;	
	Server_IE_ShipOutbound = nil;
	publicVariable "Server_IE_ShipOutbound";
	Server_IE_Running = nil; //not running anymore
},true] call Server_Setup_Compile;

["Server_IE_ImportItem",
{
	_item = param [0,""];
	_amount = param [1,1];
	_player = param [2, objNull];
	_id = param [3,0];
	_uid = getPlayerUID _player;
	
	_query = format ["INSERT INTO import_export_items (id, uid, type, item, amount, received) VALUES ('%4', '%1', 'import', '%2', %3, 0)",_uid,_item,_amount,_id];
	[_query,1] spawn Server_Database_Async;

},true] call Server_Setup_Compile;

["Server_IE_ExportItem",
{
	_item = param [0,""];
	_amount = param [1,1];
	_price = param [2,0];
	_player = param [3, objNull];
	_id = param [4,0];
	_uid = getPlayerUID _player;
	
	_query = format ["INSERT INTO import_export_items (id, uid, type, item, amount, price) VALUES ('%5', '%1', 'export', '%2', %3, %4)",_uid,_item,_amount,_price,_id];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_IE_CollectImport",
{
	_player = param [0, objNull];
	_id = param [1,""];
	_qty = param [2, -1];
	_uid = getPlayerUID _player;
	
	if(_qty == -1) then {
		_query = format ["DELETE FROM import_export_items WHERE type='import' AND uid='%1' AND id = '%2'",_uid,_id];
		[_query,1] spawn Server_Database_Async;
	} else {
		_query = format ["UPDATE import_export_items SET amount=%3 WHERE type='import' AND uid='%1' AND id = '%2'",_uid,_id,_qty];
		[_query,1] spawn Server_Database_Async;
	};
},true] call Server_Setup_Compile;

["Server_IE_RecieveImports",
{
	_player = param [0, objNull];
	_uid = getPlayerUID _player;

	_query = format ["UPDATE import_export_items SET received=1 WHERE type='import' AND uid='%1'",_uid,_id];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_IE_ExportExports",
{
	_player = param [0, objNull];
	_uid = getPlayerUID _player;
	
	_query = format ["DELETE FROM import_export_items WHERE type='export' AND uid='%1'",_uid,_id];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_IE_LoadPlayerIE",
{
	_player = param [0, objNull];
	_uid = getPlayerUID _player;

	_query = format ["SELECT id,uid,type,amount,price,received,item FROM import_export_items WHERE uid='%1'",_uid];
	_result = [_query,2] spawn Server_Database_Async;

	_imports = [];
	_exports = [];
	{
		_id = _x select 0;
		_type = _x select 2;
		_amount = parseNumber (_x select 3);
		_price = parseNumber (_x select 4);
		_received = if((parseNumber (_x select 5)) == 1) then {true} else {false};
		_item = _x select 6;
		if(_type == "import") then {
			_imports pushBack [_item, _amount, _received, _id];
		} else {
			_exports pushBack [_item, _amount, false, _price, _id];
		};
	} forEach _result; 
	player setVariable ["player_importing", _imports, true];
	player setVariable ["player_exporting", _exports, true];
},true] call Server_Setup_Compile;