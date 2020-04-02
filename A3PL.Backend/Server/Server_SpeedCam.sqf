#define FINEAMOUNT 500
#define SPEEDLIMIT 65

//function that will initially set the hitpoint value to 0 thus disables the light_1
["Server_SpeedCam_Init",
{
	_speedCam = param [0,objNull];
	_speedCam setHit ["light_1",1];
},true] call Server_Setup_Compile;

//function that runs when the players enters a speedcamera trigger
["Server_SpeedCam_Triggerd",
{
	private ["_car","_currentBankAmount","_player"];
	//retrieve car and its driver
	_car = param [0,objNull];	
	_player = driver _car;
	if (isNull _player) exitwith {}; //not a valid driver
	
	//exit script is speed is equal or less than SPEEDLIMIT
	if (speed _car <= SPEEDLIMIT) exitwith {};
	
	//if played is on-duty as police, uscg, usms or fifr then exit script
	if ((_player getVariable ["job","unemployed"]) IN ["police","uscg","usms","fifr"]) exitwith {};
	
	//fine player if the player has enough money in his bank account
	_currentBankAmount = _player getVariable ["player_bank",0];
	if (_currentBankAmount >= FINEAMOUNT) then
	{
		_player setVariable ["player_bank",_currentBankAmount - FINEAMOUNT];
	};
	
	//sent message to player
	[format["System: You were fined $%1 for speeding!", FINEAMOUNT],Color_Red] remoteExec ["A3PL_Player_Notification", owner _player];

	//find nearest speedcamera to the player & flash it
	_speedCam = (nearestObjects [_player, ["Land_A3PL_SpeedCamera"], 150]) select 0;
	if (!isNil "_speedCam") then
	{
		_speedCam setHit ["light_1", 0];
		sleep .5;
		_speedCam setHit ["light_1",1];		
	};
},true] call Server_Setup_Compile; 