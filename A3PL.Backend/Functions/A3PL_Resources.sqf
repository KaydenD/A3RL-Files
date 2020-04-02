//Start digging sand
["A3PL_Resources_StartDigging",
{
	private ["_inMarker","_eBucket","_s","_sBucket","_pos","_digProgress","_t"];
	_inMarker = false;
		if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	if(player getVariable "Digging") exitWith{["System: You are already digging!",Color_Red] call A3PL_Player_Notification;};

	//check if we are in a sand area, we use predefined areas
	{
		if ((getpos player) inArea _x) exitwith {_inMarker = true};
	} foreach ["A3PL_Marker_Sand1","A3PL_Marker_Sand2"];

	if (!_inMarker) exitwith {["System: You are not in a sand gathering area",Color_Red] call A3PL_Player_Notification;}; //message if we are not in sand area

	//check if carrying right weapon
	if (currentWeapon player != "A3PL_Shovel") exitwith {["System: You are not carrying a shovel on you",Color_Red] call A3PL_Player_Notification;};
	player setVariable ["Digging",true,true];
	[player,"A3PL_Shovel_Dig"] remoteExec ["A3PL_Lib_SyncAnim", 0]; //start our digging animation, this is a remote call because we want this to happen on all computers in the network
	_digProgress = 0; //variable to check our digging progress in the loop below
	_s = false; //determines if success
	_t = 0; //just a timeout variable to prevent our loop getting stuck
	waituntil {sleep 0.1; _t = _t + 0.1; if (_t >= 2) exitwith {true}; animationState player == "A3PL_Shovel_Dig"}; //wait until our animation starts
	["System: You are now digging sand, stand still!",Color_Green] call A3PL_Player_Notification;
	while {animationState player == "A3PL_Shovel_Dig"} do //while we are in the digging animation
	{
		uiSleep 2; //do nothing for 2 seconds, determines progress time 2*10=20
		_digProgress = _digProgress + 10; //increase a var by 10
		if (_digProgress >= 100) exitwith {_s = true}; //if the progress >=100 we can exit the loop
	};
	[player,""] remoteExec ["A3PL_Lib_SyncAnim", 0]; //make sure animation is cancelled, remote call to stop animation on all computers
	player setVariable ["Digging",false,true];

	if (!_s) exitwith {["System: Sand digging was cancelled!",Color_Red] call A3PL_Player_Notification;}; //determine if it was succesfull or not

	//look for closest empty bucket
	_eBucket = objNull;
	{
		if ((_x getvariable ["class",""]) == "bucket_empty") exitwith {_ebucket = _x;};
	} foreach (nearestObjects [player, ["A3PL_Bucket"], 5]);

	if (isNull _eBucket) exitwith {["System: Couldn't find an empty bucket within a 5m radius",Color_Red] call A3PL_Player_Notification;};

	//delete the bucket
	_pos = getPos _eBucket;
	deleteVehicle _eBucket;

	//create a new one, with the sand in it
	_sBucket = createVehicle ["A3PL_BucketSand",_pos, [], 0, "CAN_COLLIDE"];
	_sBucket setVariable ["class","sand",true];

	["System: Sand digging completed!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Resources_DigOre",
{
	private ["_veh","_dmg"];
	_veh = param [0,objNull];
	_dmg = _veh getHitPointDamage "HitShovel";
	if (currentWeapon player != "A3PL_Shovel") exitwith {["System: You are not carrying a shovel",Color_Red] call A3PL_Player_Notification;};
	if (_dmg < 1) then
	{
		_veh setHitPointDamage ["HitShovel",_dmg + 0.1];
	};

}] call Server_Setup_Compile;
