["Server_Garage_UpdateAddons",
{
	private ["_query","_veh"];
	_veh = param [0,objNull];
	_addons = param [1,[]];
	_var = _veh getVariable ["owner",[]];
	if((count _var) isEqualTo 0) exitWith {};
	_id = _var select 1;

	_addons = [_addons] call Server_Database_Array;
	diag_log format["SERVER GARAGE DIAG VAR : %1",_addons];

	_query = format ["UPDATE objects SET tuning = '%2' WHERE id = '%1'",_id,_addons];
	[_query,1] spawn Server_Database_Async;
},true] call Server_Setup_Compile;

["Server_Garage_Update_Data",
{
	private ["_veh","_var","_id","_query"];
	_playerCar = param [0,objNull];
	if (isNull _playerCar) exitwith {};

	_var = _playerCar getVariable ["owner",nil];
	_id = _var select 1;
	_Path = (getObjectTextures _playerCar) select 0;
	_material = (getObjectMaterials _playerCar) select 0;
	_Pathformat = format ["%1",_Path];
	_materialFormat = format ["%1",_material];
	_Texture = [_Pathformat, "\", "\\"] call CBA_fnc_replace;
	_materialLocation = [_materialFormat, "\", "\\"] call CBA_fnc_replace;
	_query = format ["UPDATE objects SET fuel='%2',color='%3',material='%4' WHERE id = '%1'",_id,(fuel _playerCar),_Texture,_materialLocation];
	[_query,1] spawn Server_Database_Async;

},true] call Server_Setup_Compile;
