["A3RL_Mushroom_Gather",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if (Player_ActionDoing) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	if (([["shrooms",1]] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {[format ["System: You can't pick this item up because it would exceed the %1 lbs limit you can carry on you!",Player_MaxWeight],Color_Red] call A3PL_Player_Notification;};
	if (vehicle player != player) exitWith {};
	Player_ActionCompleted = false;
	
	["Gathering Mushrooms....",30] spawn A3PL_Lib_LoadAction;
	while {!Player_ActionCompleted} do
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
		uiSleep 1.0;
	};

	_ammout = round(random 4);
	[format ["You have picked up %1 mushroom(s)", _ammout],color_green] call A3PL_Player_Notification;
	["shrooms",_ammout] call A3PL_Inventory_Add;
}] call Server_Setup_Compile;
