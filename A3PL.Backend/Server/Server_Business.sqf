/*
	START OF BUSINESS OWNERSHIP FUNCTIONS
*/

/* format
	A3PL_Business_List =
	[
		[_business,_playerUID,_rentTime,_marker],
		[],
	]
*/
["Server_Business_Buy",
{
	private ["_player","_playerUID","_business","_taken","_name","_rentTime","_rentCost","_newMoney","_sign"];
	_player = param [0,objNull];
	_playerUID = getPlayerUID _player;
	_business = param [1,objNull];
	if (isNull _player OR isNull _business) exitwith {};
	_name = param [2,""];
	_rentTime = param [3,1] * 60; //we need it in seconds
	_rentCost = param [4,1];
	_sign = param [5,objNull];
	A3PL_Business_List = missionNameSpace getVariable ["A3PL_Business_List",[]];

	//confirm the business isn't taken, or own more than 1 business
	{
		if (_x select 0 == _business) exitwith {_taken = true};
		if (_x select 1 == _playerUID) exitwith {_taken = true};
	} foreach A3PL_Business_List;
	if (!isNil "_taken") exitwith {}; //business is taken, or already own more than 1 business
	//end of taken check

	//take money
	_newMoney = (_player getVariable ["player_cash",0]) - _rentcost;
	if (_newMoney < 0) exitwith {}; //not enough money
	_player setvariable ["player_cash",_newMoney,true];
	//end of take money

	//create marker on the map
	_marker = createMarker [format ["business%1",floor random 3000], _business]; //last param is position, it accepts objects
	_marker setMarkerShape "ICON";
	_marker setMarkerType "hd_dot";
	_marker setMarkerText _name;

	A3PL_Business_List pushback [_business,_playerUID,diag_tickTime + _rentTime,_marker]; //later on we can check if diag_tickTime > _renttime, remove marker etc
	_business setVariable ["bOwner",_playerUID,true];
	_business setVariable ["bName",_name,true];

	//find business sign and set texture
	if (!isNull _sign) then
	{
		_sign setObjectTextureGlobal [0,"\A3PL_Objects\Street\business_sign\business_rented_co.paa"];
	};

	if ((_player getVariable ["job","unemployed"]) != "business") then
	{
		[_player,"business"] call Server_NPC_RequestJob;
	}; //set job if it isn't the company
},true] call Server_Setup_Compile;

//loop through businesses, delete if expired etc
["Server_Business_Loop",
{
	private ["_delete"];
	_delete = [];
	{
		private ["_business","_uid","_rentTime","_player"];
		_business = _x select 0;
		_uid = _x select 1;
		_player = [_uid] call A3PL_Lib_UIDToObject;
		_rentTime = _x select 2;
		if (isNull _player OR diag_tickTime > _rentTime) then
		{
			_marker = _x select 3;
			deleteMarker _marker;
			_business setVariable ["bOwner",nil,true];
			_business setVariable ["bName",nil,true];
			A3PL_Business_List deleteAt _forEachIndex; //delete from _list
		};
	} foreach (missionNameSpace getVariable ["A3PL_Business_List",[]]);
},true] call Server_Setup_Compile;

/*
	END OF BUSINESS OWNERSHIP FUNCTIONS
*/

/*
	START OF ITEM SALE/BUY FUNCTIONS
*/

["Server_Business_Sellitem",
{
	private ["_player","_obj","_type","_bChecked","_name","_price"];
	_player = param [0,objNull];
	_obj = param [1,objNull];
	_type = param [2,""];
	_bChecked = param [3,false];
	_name = param [4,""];
	_price = param [5,0];
	if (isNull _player OR isNull _obj) exitwith {};

	_obj setVariable ["bItem",[_price,_name,_bChecked,getPlayerUID _player],true]; //price,name,business item,player selling it
},true] call Server_Setup_Compile;

["Server_Business_Sellitemstop",
{
	private ["_obj"];
	_obj = param [0,objNull];
	_obj setVariable ["bItem",nil,true];
},true] call Server_Setup_Compile;

["Server_Business_BuyItem",
{
	private ["_obj","_factionBuy","_query","_owner","_bItem","_price","_businessItem"];
	_buyer = param [0,objNull];
	_obj = param [1,objNull];
	_factionBuy = param [2,false];
	_buyerUID = getPlayerUID _buyer;
	_bItem = _obj getVariable ["bItem",nil];
	if (isNil "_bItem") exitwith {};
	_price = _bItem select 0;
	_businessItem = _bItem select 2;
	_owner = _bItem select 3;

	switch (true) do
	{
		case (_obj isKindOf "car"):
		{
			private ["_query","_id"];
			_id = _obj getVariable ["owner",nil];
			_isCustomPlate = _obj getVariable ["isCustomPlate",0];
			if (isNil "_id") exitwith {};
			_id = _id select 1;

			if(_isCustomPlate == 1) then {

				_newID = [7] call Server_Housing_GenerateID;
				_query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				[_query,1] spawn Server_Database_Async; //set database

				_query2 = format ["UPDATE objects SET id = '%2',numpchange='0',iscustomplate='0' WHERE id = '%1'",_id,_newID];
				[_query2,1] spawn Server_Database_Async;

				_obj setVariable ["owner",[_buyerUID,_newID],true];

				[_newID,_obj] call Server_Vehicle_Init_SetLicensePlate;

			} else {
				_query = format ["UPDATE objects SET uid='%1' WHERE id='%2'",_buyerUID,_id];
				_obj setVariable ["owner",[_buyerUID,_id],true];
				[_query,1] spawn Server_Database_Async; //set database
			};


			_obj setVariable ["keyAccess",[_buyerUID],true];

		};

		case (!isNil {_obj getVariable ["class",nil]}):
		{
			_obj setVariable ["owner",_buyerUID,true];
		};
	};
	[_obj] call Server_Business_Sellitemstop;

	//take money
	if (_factionBuy) then
	{
		private ["_balance"];
		_balance = [_buyer,true] call A3PL_Government_MyFactionBalance;
		[_balance,_price] call Server_Government_AddBalance;
	} else
	{
		private ["_cash"];
		_cash = _buyer getVariable ["player_cash",0];
		_buyer setVariable ["player_cash",(_cash - _price),true];
	};
	//send msg to seller that sold this item
	if (!isNil "_owner") then
	{
		private ["_ownerObj"];
		_ownerObj = [_owner] call A3PL_Lib_UIDToObject;
		if (!isNull _ownerObj) then
		{
			_ownerObj setVariable ["player_cash",((_ownerObj getVariable ["player_cash",0]) + _price),true]; //also add money to seller
			[0,_price] remoteExec ["A3PL_Business_BuyItemReceive",(owner _ownerObj)];
		};
	};

	//send msg to buyer
	[1] remoteExec ["A3PL_Business_BuyItemReceive",(owner _buyer)];

},true] call Server_Setup_Compile;

/*
	END OF ITEM SALE/BUY FUNCTIONS
*/
