["A3RL_Gang_Create", {
	_groupName = param [0,""];
	[player, _groupName] remoteExec ["Server_Gang_Create", 2];
}] call Server_Setup_Compile;

["A3RL_Gang_AddMember", {
	_addUID = param [0,""];
	_group = param [1,grpNull];
	_gang = _group getVariable ["gang_data",nil];

	if(isNil "_gang") exitWith {};
	_members = _gang select 3;
	_members pushBack(_addUID);
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];
}] call Server_Setup_Compile;

["A3RL_Gang_Invite", {
	_invited = param [0,""];

	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil "_gang") exitWith {};
	_members = _gang select 3;
	_maxMembers = _gang select 5;
	if((count _members) > _maxMembers) exitWith {[format ["You can not add another member to your group, limit of %1 members reached",_maxMembers],Color_Red] call A3PL_Player_Notification;};
	{
		if(_invited isEqualTo (getPlayerUID _x)) exitWith {
			_hasGang = (group _x) getVariable["gang_data",nil];
			if(isNil "_hasGang") then {
				[_group, player] remoteExec ["A3RL_Gang_InviteReceived",_x];
				["Gang invitation sent",Color_Green] call A3PL_Player_Notification;
			} else {
				["This person is already in a gang.",Color_Red] call A3PL_Player_Notification;
			};
		};
	} forEach AllPlayers;
}] call Server_Setup_Compile;

["A3RL_Gang_SetLead", {
	_newUID = param [0,""];
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};


	if((getPlayerUID player != _gang select 1)) exitWith {
		[format ["Only the leader can appoint a new leader"],Color_Red] call A3PL_Player_Notification;
	};

	if((getPlayerUID player == _newUID)) exitWith {
		[format ["You're already the gang's leader"],Color_Red] call A3PL_Player_Notification;
	};

	_gang set [1,_newUID];
	_group setVariable["gang_data",_gang,true];

	[_group] remoteExec ["Server_Gang_SetLead",2];
	[format ["You've appointed a new leader for your gang"],Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Gang_AddBank", {
	_group = param [0,grpNull];
	_amount = param [1,0];

	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};

	_currentBank = _gang select 4;

	_gang set[4,_currentBank + (_amount)];
	_group setVariable["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveBank",2];
}] call Server_Setup_Compile;

["A3RL_Gang_Capture", {
	_obj = param [0,objNull];
	_win = 10000;
	_group = group player;

	if((player getVariable ["job","unemployed"]) IN ["fifr","uscg","fisd","doj","dmv"]) exitWith {};
	if ((currentWeapon player) == "") exitwith {["Your not brandishing a weapon",Color_Red] call A3PL_Player_Notification;};
	if ((currentWeapon player) IN ["A3PL_FireAxe","A3PL_Shovel","A3PL_Pickaxe","A3PL_Golf_Club","A3PL_Jaws","A3PL_High_Pressure","A3PL_Medium_Pressure","A3PL_Low_Pressure","A3PL_Taser","A3PL_FireExtinguisher","A3PL_Paintball_Marker","A3PL_Paintball_Marker_Camo","A3PL_Paintball_Marker_PinkCamo","A3PL_Paintball_Marker_DigitalBlue","A3PL_Paintball_Marker_Green","A3PL_Paintball_Marker_Purple","A3PL_Paintball_Marker_Red","A3PL_Paintball_Marker_Yellow","A3PL_Predator"]) exitwith {["Ha! You call that a weapon. Dumbass",Color_Red] call A3PL_Player_Notification;};

	_capturedTime = _obj getVariable["CapturedTime",serverTime-1800];
	if(_capturedTime > (serverTime-1800)) exitWith {["This hideout has been captured recently",Color_Red] call A3PL_Player_Notification;};

	_gang = _group getVariable["gang_data",nil];
	if(isNil "_gang") exitWith {["You're not in a gang",Color_Red] call A3PL_Player_Notification;};
	_gangID = _gang select 0;
	if((_obj getVariable["captured",-1]) isEqualTo _gangID) exitWith {["Your gang already controls this hideout",Color_Red] call A3PL_Player_Notification;};

	if (Player_ActionDoing) exitwith {["You're already performing an action",Color_Red] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Capture...",20] spawn A3PL_Lib_LoadAction;
	waitUntil{Player_ActionDoing};
	[_obj, _gang select 6] spawn {[_this select 0, 0] call BIS_fnc_animateFlag; waitUntil {(flagAnimationPhase (_this select 0)) == 0}; [_this select 0, _this select 1] remoteExec ["setFlagTexture", format["%1", _this select 0]]; [_this select 0, 1] call BIS_fnc_animateFlag;};
	_success = true;
	_animTime = diag_tickTime;
	while {Player_ActionDoing} do {
		if(_animTime >= diag_tickTime-5) then {
			player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
			_animTime = diag_tickTime;
		};
		if (!(player getVariable["A3PL_Medical_Alive",true])) exitWith {_success = false;};
		if (!(vehicle player == player)) exitwith {_success = false;};
		if (player getVariable ["Incapacitated",false]) exitwith {_success = false;};
	};
	if(!_success) exitWith {["Action canceled",Color_Red] call A3PL_Player_Notification;};

	_obj setVariable["captured",_gangID,true];
	_obj setVariable["CapturedTime",serverTime,true];

	_gangName = _gang select 2;
	[format["%1 gang has captured a hideout!",_gangName], Color_Yellow] remoteExec ["A3PL_Player_Notification",-2];

	["Your gang earned $10,000 for capturing this hideout",Color_Green] call A3PL_Player_Notification;
	[_group,_win] call A3RL_Gang_AddBank;
}] call Server_Setup_Compile;

["A3RL_Gang_CapturedPaycheck", {
	_objects = [hideout_obj_1,hideout_obj_2,hideout_obj_3];
	_win = 0;
	_group = group player;

	_gang = _group getVariable["gang_data",nil];
	if(isNil "_gang") exitWith {};
	_gangID = _gang select 0;

	{
	if((_x getVariable["captured",-1]) isEqualTo _gangID) then {_win = _win + 1000;};
	} forEach _objects;

	if(_win isEqualTo 0) exitWith {};

	[format["Your gang earned $%1 for holding gangs hideouts",_win],Color_Green] call A3PL_Player_Notification;
	[_group,_win] call A3RL_Gang_AddBank;
}] call Server_Setup_Compile;

["A3RL_Gang_Created", {
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil "_gang") exitWith {};
	_groupName = _gang select 2;
	[format ["You've created the gang ""%1"" ",_groupName],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Gang_Delete", {
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};

	if(((getPlayerUID player) != (_gang select 1))) exitWith {
		["Only the Leader can disband the gang",Color_Red] call A3PL_Player_Notification;
	};

	[_group] remoteExec ["Server_Gang_DeleteGang",2];
}] call Server_Setup_Compile;

["A3RL_Gang_Init", {
	if (count A3RL_Gang_Data isEqualTo 0) exitWith {};
	{
		_groupData = _x getVariable ["gang_data",nil];
		if (!isNil "_groupData") then {
			_groupID = _x getVariable ["gang_id",nil];
			if (isNil "_groupID") exitWith {};
			if ((A3RL_Gang_Data select 0) isEqualTo _groupID) exitWith {
				_group = _x;
			};
		};
	} forEach allGroups;

	if (!isNil "_group") then {
		[player] joinSilent _group;
		if ((A3RL_Gang_Data select 1) isEqualTo getPlayerUID player) then {
			_group selectLeader player;
		};
	} else {
		_group = group player;
		_group setVariable ["gang_data",A3RL_Gang_Data,true];
	};
}] call Server_Setup_Compile;

["A3RL_Gang_InviteReceived", {
	if (count A3RL_Gang_Data isEqualTo 0) exitWith {};
	{
		_groupData = _x getVariable ["gang_data",nil];
		if (!isNil "_groupData") then {
			_groupID = _x getVariable ["gang_id",nil];
			if (isNil "_groupID") exitWith {};
			if ((A3RL_Gang_Data select 0) isEqualTo _groupID) exitWith {
				_group = _x;
			};
		};
	} forEach allGroups;

	if (!isNil "_group") then {
		[player] joinSilent _group;
		if ((A3RL_Gang_Data select 1) isEqualTo getPlayerUID player) then {
			_group selectLeader player;
		};
	} else {
		_group = group player;
		_group setVariable ["gang_data",A3RL_Gang_Data,true];
	};
}] call Server_Setup_Compile;

["A3RL_Gang_Kicked", {
	A3RL_Gang_Data = nil;
	[player] joinSilent (createGroup civilian);
	[format ["You've been removed from your gang"],Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Gang_Leave", {
	_group = group player;
	_gang = _group getVariable ["gang_data",nil];
	if(isNil "_gang") exitWith {};


	if(((getPlayerUID player) == (_gang select 1))) exitWith {
		[format ["The leader of a gang can't leave"],Color_Red] call A3PL_Player_Notification;
	};

	[getPlayerUID player] call A3RL_Gang_RemoveMember;
	[player] joinSilent (createGroup civilian);
	A3RL_Gang_Data = nil;

	["You've left your gang",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3RL_Gang_RemoveMember", {
	_removeUID = param [0,""];
	_kicked = param [1,false];

	_group = group player;
	_gang = _group getVariable ["gang_data",nil];

	if(isNil "_gang") exitWith {};
	_members = _gang select 3;
	_members = _members - [_removeUID];
	_gang set[3,_members];
	_group setVariable ["gang_data",_gang,true];
	[_group] remoteExec ["Server_Gang_SaveMembers",2];

	if(_kicked) then {
		{
			if((getPlayerUID _x) isEqualTo _removeUID) exitWith {
				[] remoteExec ["A3RL_Gang_Kicked",_x];
			};
		} forEach AllPlayers;
	};
}] call Server_Setup_Compile;

["A3RL_Gang_SetData", {
	A3RL_Gang_Data = (_this select 0);
	[] call A3RL_Gang_Init;
}] call Server_Setup_Compile;
