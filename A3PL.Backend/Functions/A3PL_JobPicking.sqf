//spawn from A3PL_Inventory_Pickup
["A3PL_JobPicking_Pickup",
{	
	private ["_apple"];
	_apple = param [0,objNull];
	
	if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Picking apple...",1+random 2] spawn A3PL_Lib_LoadAction;
	while {sleep 1.5; !Player_ActionCompleted } do
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};
		
	if (!isNull _apple) then 
	{
		[[player, _apple, 1], "Server_Inventory_Pickup", false,false,true] call BIS_fnc_MP; //would normally run from A3PL_Inventory_Pickup
		["You picked an apple from the tree, it has been placed in your inventory",color_green] call A3PL_Player_Notification;
	};
	
}] call Server_Setup_Compile;