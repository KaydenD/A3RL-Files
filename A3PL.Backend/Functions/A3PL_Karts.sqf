["A3PL_Karts_Rent",
{
	if ((player getVariable ["job","unemployed"]) == "KARTING") exitwith {["System: You stopped renting the go-kart!",Color_Red]; [] call A3PL_NPC_LeaveJob};
	if (!(player inArea "A3PL_Marker_SallySpeedway")) exitwith {["System: You are not in the area to use these go karts!"] call A3PL_Player_Notification;};
	player setVariable ["job","karting"];
	["C_Kart_01_F",[6986.96,6638.26,-0.067071],"KARTING",900,"A3PL_Marker_SallySpeedway"] spawn A3PL_Lib_JobVehicle_Assign;
	["System: You rented a go-kart, please wait for it to spawn! (Use the interaction wheel to unlock)",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
