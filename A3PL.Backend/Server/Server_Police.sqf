["Server_Police_Impound",
{
	private ["_veh","_var","_id","_query"];
	_veh = param [0,objNull];
	if (isNull _veh) exitwith {};

	_var = _veh getVariable ["owner",nil];

	if (!isNil "_var") then
	{
		_id = _var select 1;
		_query = format ["UPDATE objects SET plystorage = '1',impounded='1',fuel='%2' WHERE id = '%1'",_id,(fuel _veh)];
		[_query,1] spawn Server_Database_Async;
	};

	[_veh] call Server_Vehicle_Despawn;

	if (!isNil "_id") then
	{
		private ["_player","_cash","_fine"];
		_player = [(_var select 0)] call A3PL_Lib_UIDToObject;

		if (!isNull _player) then
		{
			[[],"A3PL_Police_ImpoundMsg",(owner _player),false] call BIS_FNC_MP;
		};
	};
},true] call Server_Setup_Compile;

//This function will search the database and return those back to the player
['Server_Police_Database',
{
	private ["_output"];
	_player = _this select 0;
	_name = _this select 1;
	_call = _this select 2;

		switch (_call) do {
			case "lookup":
			{
				_query = format ["SELECT
				(SELECT gender FROM players WHERE name = '%1') AS gender,
				(SELECT dob FROM players WHERE name = '%1') AS DOB,
				(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='warrant' AND uid = (SELECT uid FROM players WHERE name='%1')) AS warrantAmount,
				(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='arrest' AND uid = (SELECT uid FROM players WHERE name='%1')) AS arrestAmount,
				(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='ticket' AND uid = (SELECT uid FROM players WHERE name='%1')) AS ticketAmount,
				(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='warning' AND uid = (SELECT uid FROM players WHERE name='%1')) AS warningAmount,
				(SELECT COUNT(Actiontype) FROM policedatabase WHERE Actiontype='report' AND uid = (SELECT uid FROM players WHERE name='%1')) AS reportAmount,
				(SELECT pasportdate FROM players WHERE name = '%1') AS pasportDate,
				(SELECT licenses FROM players WHERE name = '%1') AS licenses
				FROM
				players
				WHERE
				uid = (SELECT uid FROM players WHERE name='%1')
				LIMIT 1
				", _name];

				_return = [_query, 2] call Server_Database_Async;
				//_return will be in format
				//gender,DOB,warrantAmount,arrestAmount,ticketAmount,warningAmount,reportAmount,pasportDate

				//lets send this info back
				//playername,command,databasereturn
				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "lookupvehicles":
			{
				_query = format ["SELECT id,class,stolen FROM objects WHERE (uid = (SELECT uid FROM players WHERE name='%1'))",_name];
				_return = [_query, 2,true] call Server_Database_Async;

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "lookuplicense":
			{
				_query = format ["
				SELECT name,
				(SELECT stolen FROM objects WHERE id='%1') AS stolen,
				(SELECT class FROM objects WHERE id = '%1') AS class
				FROM
				players
				WHERE
				uid = (SELECT uid FROM objects WHERE type='vehicle' AND id='%1')
				",_name];

				_return = [_query, 2] call Server_Database_Async;

				_return pushBack _name;

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "lookupaddress":
			{
				_query = format ["SELECT location FROM houses WHERE (uid = (SELECT uid FROM players WHERE name='%1'))",_name];
				_return = [_query, 2,true] call Server_Database_Async;

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "markstolen":
			{
				_query = format ["SELECT id,stolen FROM objects WHERE id = '%1'",_name];
				_return = [_query, 2] call Server_Database_Async;

				if(_return select 1 != 0) exitWith {

					_output = format["Vehicle %1 is already marked as stolen, try marking it as found using 'markfound [licenseplate]'",_name];
					[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
				if(count _return > 0) exitWith {
					_id = _return select 0;
					_query = format ["UPDATE objects set stolen='1' WHERE ID='%1'",_id];
					_return = [_query, 2] call Server_Database_Async;

					_output = format["Successfully marked vehicle %1 as stolen",_name];
					[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};

				_output = "Invalid License Plate - Please try again!";
				[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "markfound":
			{
				_query = format ["SELECT id,stolen FROM objects WHERE id = '%1'",_name];
				_return = [_query, 2] call Server_Database_Async;

				if(_return select 1 != 1) exitWith {

					_output = format["Vehicle %1 is not marked as stolen, try marking it as stolen using 'markstolen [licenseplate]'",_name];
					[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
				if(count _return > 0) exitWith {
					_id = _return select 0;
					_query = format ["UPDATE objects set stolen='0' WHERE ID='%1'",_id];
					_return = [_query, 2] call Server_Database_Async;

					_output = format["Successfully marked vehicle %1 as found",_name];
					[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};

				_output = "Invalid License Plate - Please try again!";
				[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "warrantlist":
			{
				_query = format ["SELECT title,time,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='warrant')",_name];

				_return = [_query, 2, true] call Server_Database_Async;
				//_return will be in format
				//[title,time,issuedby]

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "warrantinfo":
			{
				_query = format ["SELECT time,issuedby,info FROM policedatabase WHERE uid = (SELECT UID FROM players WHERE name = '%1') AND actiontype='warrant' LIMIT 1 OFFSET %2",_name,(_this select 3)];
				_return = [_query, 2] call Server_Database_Async;
				//_return will be in format
				//time,issuedby,info

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "removewarrant":
			{
				_query = format ["SELECT ID FROM policedatabase WHERE uid = (SELECT UID FROM players WHERE name = '%1') AND actiontype='warrant' LIMIT 1 OFFSET %2",_name,(_this select 3)];
				_return = [_query, 2] call Server_Database_Async;

				if(count _return > 0) exitWith {
					_id = _return select 0;
					_query = format ["DELETE FROM policedatabase WHERE ID='%1'",_id];
					_return = [_query, 2] call Server_Database_Async;

					_output = format["Successfully deleted warrant for %1",_name];
					[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};

				_output = "Invalid Warrant ID - Use warrantlist to get the ID!";
				[[_name,_call,_output],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "ticketlist":
			{
				_query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='ticket')",_name];
				_return = [_query, 2,true] call Server_Database_Async;
				//_return will be in format
				//[time,info,issuedby]

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "arrestlist":
			{
				_query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='arrest')",_name];
				_return = [_query, 2,true] call Server_Database_Async;

				//_return will be in format
				//[time,info,issuedby]

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "warninglist":
			{
				_query = format ["SELECT time,info,issuedby FROM policedatabase WHERE (uid = (SELECT uid FROM players WHERE name='%1')) AND (actiontype='warning')",_name];
				_return = [_query, 2,true] call Server_Database_Async;

				//_return will be in format
				//[time,info,issuedby]

				[[_name,_call,_return],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
			};

			case "insertwarrant":
			{
				_title = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;
				_name = _name select 0;

				_query = format ["SELECT uid FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered - Warrent Not Inserted"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					_uid = (_return select 0) select 0;
					_query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'warrant', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully Inserted Warrant for %1",_name]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
			};

			case "insertticket":
			{
				_amount = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;
				_name = _name select 0;

				_query = format ["SELECT uid FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered - Ticket Not Inserted"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					_uid = (_return select 0) select 0;
					_query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Amount, IssuedBy, Time) VALUES ('%1', 'ticket', '%2', '%3', '%4', NOW())",_uid,_info,_amount,_issuedBy,_name];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully Inserted Ticket for %1",_name]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
			};

			case "insertwarning":
			{
				//insertwarning [firstname] [lastname] [title] [description] - Insert Warning
				_title = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;
				_name = _name select 0;

				_query = format ["SELECT uid FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered - Warning Not Inserted"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					_uid = (_return select 0) select 0;
					_query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'warning', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully Inserted Warning for %1",_name]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
			};

			case "insertreport":
			{
				//insertreport [firstname] [lastname] [title] [description] - Insert Report
				_title = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;
				_name = _name select 0;

				_query = format ["SELECT uid FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered - Report Not Inserted"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					_uid = (_return select 0) select 0;
					_query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Title, IssuedBy, Time) VALUES ('%1', 'report', '%2', '%3', '%4', NOW())",_uid,_info,_title,_issuedBy,_name];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully Inserted Report for %1",_name]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
			};

			case "insertarrest":
			{
				_time = _name select 1;
				_info = _name select 2;
				_issuedBy = _name select 3;
				_name = _name select 0;

				_query = format ["SELECT uid FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered - Arrest Record Not Inserted"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					_uid = (_return select 0) select 0;
					_query = format ["INSERT INTO policedatabase (UID, ActionType, Info, Amount, IssuedBy, Time) VALUES ('%1', 'arrest', '%2', '%3', '%4', NOW())",_uid,_info,_time,_issuedBy,_name];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully Inserted Arrest Record for %1",_name]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};
			};

			/* case "revokelicense":
			{
				_name = _name select 1;
				_license = _name select 2;

				[format["Debug: Name: %1 License: %2", _name,_license],Color_Red] remoteExec ["A3PL_Player_Notification", -2];


				_query = format ["SELECT uid,licenses FROM players WHERE name='%1'",_name];
				_return = [_query, 2, true] call Server_Database_Async;

				if(count _return < 1) then {
					[[_name,_call,"Invalid citizen name entered %1 - cannot revoke license"],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};

				_licenses = _return select 1;

				if (_licenses find _license >= 0) then {

					_licenses deleteAt (_licenses find _license);

					_uid = (_return select 0) select 0;
					_query = format ["UPDATE players set licenses ='%1' WHERE uid='%2'",_licenses,_uid];
					_return = [_query, 2,true] call Server_Database_Async;
					[[_name,_call,format["Successfully revoked %1's %2 license",_name,_license]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				} else {
					[[_name,_call,format["Error - %1 does not hold a %2 license",_name,_license]],"A3PL_Police_DatabaseEnterReceive",(owner _player),false] call BIS_FNC_MP;
				};

			}; */

			default {};
		};
},true] call Server_Setup_Compile;

["Server_Police_PayTicket",
{
	private ["_ticketAmount","_civ","_cop","_cash"];
	_ticketAmount = param [0,1];
	_civ = param [1,objNull];
	_cop = param [2,objNull];
	_copcut = round (0.05 * _ticketAmount);
	if ((isNull _civ) OR (isNull _cop)) exitwith {diag_log "_civ or _cop is null in Server_Police_Payticket"};

	_cash = _civ getVariable ["player_cash",0];
	_bank = _civ getVariable ["player_bank",0];
	_copcash = _cop getVariable ["player_cash",0];
	if (_ticketAmount > _cash && _ticketAmount > _bank) exitwith
	{
		[[3],"A3PL_Police_ReceiveTicket",Player_TicketCop,false] call bis_fnc_mp;
	};

	if(_ticketAmount <= _cash) then {
		[_civ,"Player_Cash",(_cash - _ticketAmount)] call Server_Core_ChangeVar;
		[_cop,"Player_Cash",(_copcash + _copcut)] call Server_Core_ChangeVar;
	} else {
		[_civ,"Player_Bank",(_bank - _ticketAmount )] call Server_Core_ChangeVar;
		[_cop,"Player_Cash",(_copcash + _copcut)] call Server_Core_ChangeVar;
	};
},true] call Server_Setup_Compile;

["Server_Police_JailPlayer",
{
	params[["_time",0,[0]],["_target",objNull,[objNull]]];
	_uid = getPlayerUID _target;
	_exit = false;
	if(_time < 0) exitWith {};

	//overwrite old entry if existing
	{
		if ((_x select 0) == _target) exitwith
		{
			Server_Jailed_Players set [_forEachIndex,[_x select 0,_x select 1,_time]];
			_target setVariable ["jailtime",_time,true];
			_exit = true;
		};
	} foreach Server_Jailed_Players;

	if (_exit) exitwith {};

	Server_Jailed_Players pushBack [_target,getPlayerUID _target,_time];
	_query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",_time,_uid];
	_return = [_query, 2,true] call Server_Database_Async;

	_target setVariable ["jailtime",_time,true];
	_target setVariable ["jailed",true,true];
},true] call Server_Setup_Compile;

["Server_Police_JailLoop",
{
	{
		_target = _x select 0;
		_uid = _x select 1;
		_time = _x select 2;

		if(isNull _target) exitWith {
			_query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",_time,_uid];
			_return = [_query, 2,true] call Server_Database_Async;

			Server_Jailed_Players deleteAt _forEachIndex;
		};

		/* if(isNull _time) exitWith {
			Server_Jailed_Players deleteAt _forEachIndex;
		}; */

		if(_time <= 1) exitWith {
			_target setVariable ["jailtime",0,true];
			_target setVariable ["jailed",false,true];

			[] remoteExec ["A3PL_Police_ReleasePlayer",_target];

			Server_Jailed_Players deleteAt _forEachIndex;

			_query = format ["UPDATE players SET jail=%1 WHERE uid = '%2'",0,_uid];
			_return = [_query, 2,true] call Server_Database_Async;
		};


		_target setVariable ["jailtime",(_time-1),true];
		Server_Jailed_Players set [_forEachIndex, [_target,_uid,(_time-1)]];
	} forEach Server_Jailed_Players;
},true] call Server_Setup_Compile;

["Server_Police_CallDispatch",
{
	params[["_player",objNull,[objNull]]];

	Server_Dispatch_Active pushBack [_player,false];

	//Broadcast the UI to every dispatcher
	{
		if(_x getVariable ["job","unemployed"] == "dispatch" && !(_x getVariable ["busy",false])) then {
			[_player] remoteExec ["A3PL_Police_AcceptDispatch",_x];
		};
	} forEach allPlayers;
},true] call Server_Setup_Compile;

["Server_Police_AcceptDispatch",
{
	params[["_target",objNull,[objNull]]];

	_id = Server_Dispatch_Active find [_target,false];
	if(_id < 0) exitWith {}; //unable to find this entry (taken or removed)

	//Update the call to active...
	Server_Dispatch_Active set [_id,[_target,true]];

	//Connect the caller to the dispatcher
	[] remoteExec ["A3PL_Phone_CallAccepted",_target];
},true] call Server_Setup_Compile;

["Server_Police_EndDispatch",{
	params[["_target",objNull,[objNull]]];

	_id = Server_Dispatch_Active find [_target,false];
	if(_id < 0) exitWith {}; //unable to find this entry (taken or removed)

	Server_Dispatch_Active deleteAt _id;
},true] call Server_Setup_Compile;
