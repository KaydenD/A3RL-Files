["Server_Inventory_Verify", {
	private ["_player", "_index", "_forEachIndex","_change"];

	_player = param [0,objNull];
	_change = false;

	{
		if ((_x select 1) < 1) then {
			_index = _forEachIndex;
			(_player getVariable "Player_Inventory") set [_index, "REMOVE"];
			_change = true;
		};
	} forEach (_player getVariable "Player_Inventory");

	if (_change) then
	{
		_player setVariable ["Player_Inventory", ((_player getVariable "Player_Inventory") - ["REMOVE"]), true];
	};
}, true] call Server_Setup_Compile;

["Server_Inventory_Add", {
	private ['_player', '_class', '_amount', '_newArray'];

	_player = param [0,objNull];
	_class = param [1,""];
	_amount = param [2,0];

	if (_class == "cash") exitwith
	{
		private ["_playerMoney"];
		_playerMoney = _player getVariable "Player_Cash";
		if (isNil "_playerMoney") exitwith {};
		[_player,"Player_Cash",(_playerMoney + _amount)] call Server_Core_ChangeVar;
	};

	if (isNull _player) exitWith {};

	_newArray = [(_player getVariable 'Player_Inventory'), _class, _amount] call BIS_fnc_addToPairs;

	_player setVariable ['Player_Inventory', _newArray, true];

	[_player] call Server_Inventory_Verify;
}, true] call Server_Setup_Compile;

["Server_Inventory_Pickup", {
	private ['_player', '_class', '_amount', '_obj'];

	_player = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
	_obj = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
	_amount = [_this, 2, 0, [0]] call BIS_fnc_param;

	if (isNull _player) exitWith {diag_log "ERROR: _player null in Server_Inventory_Pickup";};
	if (isNull _obj) exitwith {diag_log format ["ERROR: _obj null in Server_Inventory_Pickup - Player: %1",name _player];};

	_class = _obj getVariable ["class",nil];
	if (isNil "_class") exitwith {diag_log format ["ERROR: _class nil in Server_Inventory_Pickup - Player: %1",name _player];};

	if (_obj getVariable ["used",false]) exitwith {};
	_obj setVariable ["used",true,false];
	deleteVehicle _obj; //important

	if (_class == "cash") then
	{
		_amount = _obj getVariable "cash";
	};
	[_player,_class,_amount] call Server_Inventory_Add;

	[getPlayerUID _player,"PickupItem",[_class,_amount], _player getVariable "name"] call Server_Log_New;
}, true] call Server_Setup_Compile;

["Server_Inventory_Drop", {
	private ["_player","_obj","_class","_amount"];

	_player = param [0,objNull];
	_obj = param [1,objNull];
	_class = param [2,""];
	_amount = param [3,1]; //used for cash atm


	if (isNull(_player)) exitWith {diag_log "ERROR: _player in Server_Inventory_Drop is null"};
	//if (isNull(_obj)) then {diag_log "ERROR: _obj in Server_Inventory_Drop is null"}; commented out for now

	[_obj,"class",_class] call Server_Core_ChangeVar;
	if (_amount != 1) then {[_obj,"amount",_amount] call Server_Core_ChangeVar;};
	[_obj,"owner",(getPlayerUID _player)] call Server_Core_ChangeVar;
	if (_class IN ["doorkey","housekey"]) exitwith {}; // we cannot remove keys from the inventory, those are stored in a seperate variable

	//special things to run, we need to assign extra variable to dropped cash
	switch (_class) do
	{
		case "cash": {[_obj,"cash",_amount] call Server_Core_ChangeVar;};
	};
	[_player, _class, -(_amount)] call Server_Inventory_Add; // remove the item from the player inventory

	[getPlayerUID _player,"DropItem",[_class,_amount], _player getVariable "name"] call Server_Log_New;
}, true] call Server_Setup_Compile;

["Server_Inventory_Return", {
	private ['_class', '_amount',"_player"];

	_class = [_this, 0, '', ['']] call BIS_fnc_param;
	_player = param [1,objNull];
	_amount = [(_player getVariable 'Player_Inventory'), _class, 0] call BIS_fnc_getFromPairs;

	_amount;
},true] call Server_Setup_Compile;

["Server_Inventory_Has", {
	private ['_class', '_amount', '_inventoryAmount',"_player"];

	_class = param [0,""];
	_amount = param [1,1];
	_player = param [2,objNull];

	if (_class == "cash") exitwith {if (_player getVariable ["player_cash",0] >= _amount) then {true;} else {false;};}; //return whether we have enough money or not instead

	_inventoryAmount = [_class,_player] call Server_Inventory_Return;

	if (_inventoryAmount < _amount) exitWith {false};

	true
},true] call Server_Setup_Compile;

["Server_Inventory_RemoveAll",
{
	_player = param [0,objNull];
	_player setVariable ["player_inventory",[],true];
	_player setVariable ["player_cash",0,true];

	[_player,getPlayerUID _player,false] call Server_Gear_Save;
},true] call Server_Setup_Compile;
