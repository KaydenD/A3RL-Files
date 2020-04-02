["Server_Dogs_BuyRequest",
{
	private ["_player","_dogprice","_playercash"];

	_player = param [0,objNull];
	_class = param [1,""];

	_dogprice = 10;
	_playercash = _player getvariable ["player_cash",0];

	if (_playercash < _dogprice) exitwith {};
	[_player,"Player_Cash",(_playercash - _dogprice)] call Server_Core_ChangeVar;

	[[_class],"A3PL_Dogs_BuyReceive",(owner _player)] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

//Takes care of deleting the dog if the player disconnects from the server (it checks for locality transfership to the server)
["Server_Dogs_HandleLocality",
{
	_dog = param [0,objNull];
	if (isNull _dog) exitwith {};

	_dog addEventHandler ["Local",
	{
		_dog = _this select 0;
		_local = _this select 1;

		if (_local) then {deleteVehicle _dog};
	}];
},true] call Server_Setup_Compile;
