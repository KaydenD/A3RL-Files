["A3PL_DMV_Open",
{
	disableSerialization;
	private ["_display","_control","_nearPlayers"];
	createDialog "Dialog_DMV";
	_display = findDisplay 21;
	_control = _display displayCtrl 1500;

	//fill player list
	_nearPlayers = [];
	{
		if ((player distance _x) < 10) then {_nearPlayers pushback _x};
	} foreach allPlayers;
	{
		_index = _control lbAdd (format ["%1",(_x getVariable ["name",(name _x)])]);
		_control lbSetData [_index,(getPlayerUID _x)];
	} foreach _nearPlayers;

	//lb player list changed eh
	_control ctrlAddEventHandler ["LBSelChanged",{_this call A3PL_DMV_LBChanged;}];

	//Button eventhandler
	_control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["ButtonDown",{[true] call A3PL_DMV_Add;}];
	_control = _display displayCtrl 1601;
	_control ctrlAddEventHandler ["ButtonDown",{[false] call A3PL_DMV_Add;}];

	//licenses that can be added
	_control = _display displayCtrl 2100;
	switch (player getVariable ["job","unemployed"]) do
	{
		case ("dmv"):
		{
			_index = _control lbAdd (["driver","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"driver"];
			_index = _control lbAdd (["cdl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"cdl"];
			_index = _control lbAdd (["motorcycle","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"motorcycle"];
		};
		case ("fifr"):
		{
			_index = _control lbAdd (["vfd","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"vfd"];
		};
		case ("doj"):
		{
			_index = _control lbAdd (["ccp","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"ccp"];
			_index = _control lbAdd (["fiba","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"fiba"];
			_index = _control lbAdd (["sfp","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"sfp"];
			_index = _control lbAdd (["figl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"figl"];
			_index = _control lbAdd (["fml","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"fml"];
		};
		case ("uscg"):
		{
			_index = _control lbAdd (["boat","name"] call A3PL_Config_GetLicense);
 			_control lbSetData [_index,"boat"];
 			_index = _control lbAdd (["pfish","name"] call A3PL_Config_GetLicense);
 			_control lbSetData [_index,"pfish"];
 			_index = _control lbAdd (["sfish","name"] call A3PL_Config_GetLicense);
 			_control lbSetData [_index,"sfish"];
 			_index = _control lbAdd (["cfish","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"cfish"];
			_index = _control lbAdd (["fwcpl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"fwcpl"];
			_index = _control lbAdd (["fwppl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"fwppl"];
			_index = _control lbAdd (["rcpl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"rcpl"];
			_index = _control lbAdd (["rppl","name"] call A3PL_Config_GetLicense);
			_control lbSetData [_index,"rppl"];
		};
	};
}] call Server_Setup_Compile;

["A3PL_DMV_LBChanged",
{
	private ["_display","_control","_index"];
	_display = findDisplay 21;
	_control = param [0,ctrlNull];
	_index = param [1,-1];
	_player = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (_index < 0) exitwith {};
	if (isNull _player) exitwith {};

	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		_control lbAdd format ["%1",([_x,"name"] call A3PL_Config_GetLicense)];
	} foreach (_player getVariable ["licenses",[]]);
}] call Server_Setup_Compile;

["A3PL_DMV_Add",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_add","_display","_control","_target","_license","_licenses","_unable","_index"];
	_add = param [0,true]; //issue or revoke
	_display = findDisplay 21;
	_control = _display displayCtrl 1500;

	//figure out the target player
	_index = lbCurSel _control;
	if (_index < 0) exitwith {["System: You don't have a player selected",Color_Red] call A3PL_Player_Notification;};
	_target = [(_control lbData _index)] call A3PL_Lib_UIDToObject;
	if (isNull _target) exitwith {["System: Cannot find this player to issue/revoke license from",Color_Red] call A3PL_Player_Notification;};
	_licenses = _target getVariable ["licenses",[]];

	//figure out the license
	_control = _display displayCtrl 2100;
	if (lbCurSel _control < 0) exitwith {["System: You don't have a license selected to issue/revoke",Color_Red] call A3PL_Player_Notification;};
	_license = _control lbData (lbCurSel _control);

	//check if already has this license
	_unable = false;
	if (_add) then
	{
		if (_license in _licenses) then {_unable = true;};
	} else
	{
		if (!(_license in _licenses)) then {_unable = true;};
	};
	if (_unable) exitwith {["System: Unable to issue/revoke the license because the target already/does not have this license",Color_Red] call A3PL_Player_Notification;};

	//license to add/revoke
	[_target,_license,_add] remoteExec ["Server_DMV_Add",2];
	if (_add) then
	{
		[format ["System: You issued %1 a %2",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],Color_Green] call A3PL_Player_Notification;
	} else
	{
		[format ["System: You revoked %1 his %2",_target getVariable ["name",(name _target)],[_license,"name"] call A3PL_Config_GetLicense],Color_Green] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_DMV_Check",
{
	private ["_player","_license","_return"];
	_license = param [0,"driver"];
	_player = param [1,player];
	_return = false;

	if (_license IN (_player getVariable ["licenses",[]])) then
	{
		_return = true;
	};
	_return;
}] call Server_Setup_Compile;

["A3PL_DMV_Speed",
{
	private ["_vehicle","_actualSpeed"];

	_vehicle = vehicle player;
	_actualSpeed = [(speed _vehicle), 0] call BIS_fnc_cutDecimals;

	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	[format ["Current Speed: %1",_actualSpeed],Color_Green] call A3PL_Player_Notification;

}] call Server_Setup_Compile;

["A3PL_DMV_Truck",
{
	["A3PL_P362_TowTruck",[2757.38,5465.27,0],"DMV",1800] spawn A3PL_Lib_JobVehicle_Assign;
	["System: Truck spawned, only use this for DMV training!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
