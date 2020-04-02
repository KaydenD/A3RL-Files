//Initiate a conversation with NPC
["A3PL_NPC_Start",
{
	disableSerialization;
	private ["_idNPC","_npcText","_npcOptions","_npcActions","_display","_ctrl","_xCoor","_yCoor","_wCoor","_hCoor"];
	_idNPC = param [0,""];

	{
		if ((_x select 0) == _idNPC) exitwith
		{
			_npcText = _x select 1;
			_npcOptions = _x select 2;
			_npcActions = _x select 3;
		};
	} foreach Config_NPC_Text;


	//couldn't find _idNPC in Config_NPC_Text
	if (isNil "_npcText") exitwith {};

	createDialog "Dialog_NPC";
	_display = findDisplay 27;

	//create our camera here, we delete this inside the unload script
	A3PL_NPC_Cam = "camera" camCreate (getpos player);
	A3PL_NPC_Cam attachto [player,[0,0.37,1.6]];
	A3PL_NPC_Cam CamSetTarget (ASLToAGL (eyePos player));
	A3PL_NPC_Cam cameraEffect ["INTERNAL", "BACK", "A3PL_NPC_RT"];
	A3PL_NPC_Cam camCommit 0;

	//Set NPC text
	_ctrl = _display displayCtrl 1100;
	_ctrl ctrlSetStructuredText _npcText;

	_xCoor = 0.453594 * safezoneW + safezoneX;
	_yCoor = 0.566;
	_wCoor = 0.221719 * safezoneW;
	_hCoor = 0.022 * safezoneH;
	{
		_ctrl = _display ctrlCreate ["RscButton",-1];
		_ctrl ctrlSetPosition [_xCoor,(_yCoor * safezoneH + safezoneY),_wCoor,_hCoor];
		_ctrl ctrlSetText _x;
		_ctrl buttonSetAction format ["[] spawn {%1}",("closeDialog 0; sleep 0.01;" + (_npcActions select _forEachIndex))];
		_ctrl ctrlCommit 0;
		_yCoor = _yCoor + 0.022;
	} foreach _npcOptions;

}] call Server_Setup_Compile;

["A3PL_NPC_TakeJob",
{
	//we will request a job change here
	private ["_job"];

	_job = param [0,""];
	if (_job == "") exitwith {["System Error: No job specified in TakeJob, report this error", Color_Red] call A3PL_Player_Notification;}; //no job specified, means im an idiot

	//Send a request to server
	[[player,_job],"Server_NPC_RequestJob",false,false] call BIS_fnc_MP;


	[format ["System: Send request to server for a job change to %1",_job], Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_NPC_ReqJobUniform",
{
	_job = player getVariable ["job","unemployed"];
	if ((missionnamespace getvariable ["JobUniformTimer",time]) > time) exitwith {[format ["Don't spam, try again in %1 seconds",round (JobUniformTimer - time)], Color_Yellow] call A3PL_Player_Notification;};
	if ((_this select 0) == _job) then {
		switch (_job) do {
			case "mcfisher": { player adduniform "A3PL_mcFishers_Uniform_uniform"; player addheadgear "A3PL_mcFishers_cap"; };
			case "tacohell": { player adduniform "A3PL_TacoHell_Uniform_Uniform"; player addheadgear "A3PL_TacoHell_cap"; };
			default { };
		};
		JobUniformTimer = time + 300;
	} else {
		[format ["You do not work here..."], Color_Yellow] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;



["A3PL_NPC_LeaveJob",
{
	_job = player getVariable ["job","unemployed"];
	[[player,"unemployed"],"Server_NPC_RequestJob",false,false] call BIS_fnc_MP;
	[format ["System: Send request to server for a job change to %1","unemployed"], Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_NPC_TakeJobResponse",
{
	private ["_job","_text"];
	_response = param [0,-1];
	if (_response == -1) exitwith {["System Error: No response specified in TakeJobResponse, report this error", Color_Red] call A3PL_Player_Notification;}; //no job specified, means im an idiot

	switch (_response) do
	{
		case 1: {_text = [format ["System: Server has changed your job into: %1",param [1,""]],Color_Green];};
		default {_text = "Unspecified response in TakeJobResponse, report this error"};
	};

	if (isNil "_text") exitwith {[format ["System: Error in _text inside TakeJobResponse, report this error"], Color_Red] call A3PL_Player_Notification;};

	_text call A3PL_Player_Notification;

	//considering it should be succesfull
	_job = param [1,""];
	if (_job == "") exitwith {};
	switch (_job) do
	{
		case "unemployed": {A3PL_phoneNumberEnterprise = nil;};
		case "mcfisher": {["mcfishers_accepted"] call A3PL_NPC_Start;};
		case "fisherman": {["fisherman_accepted"] call A3PL_NPC_Start;};
		case "police": {["police_accepted"] call A3PL_NPC_Start;};
		case "fifr": {["fifr_accepted"] call A3PL_NPC_Start;};
		case "uscg": {["uscg_accepted"] call A3PL_NPC_Start;};
		case "auctioneer": {["auct_accepted"] call A3PL_NPC_Start;};
		case "trucker": {["trucker_accepted"] call A3PL_NPC_Start;};
		case "farmer": {["farmer_accepted"] call A3PL_NPC_Start;};
		case "dispatch": {["dispatch_accepted"] call A3PL_NPC_Start;A3PL_phoneNumberEnterprise = "911";};
		case "roadworker": {["roadworker_accepted"] call A3PL_NPC_Start;};
		case "wildcat": {["wildcat_accepted"] call A3PL_NPC_Start;};
		case "tacohell": {["tacohell_accepted"] call A3PL_NPC_Start;};
		case "oil": {["oil_accepted"] call A3PL_NPC_Start;};
		case "mailman": {["mailman_accepted"] call A3PL_NPC_Start;};
		default {};
	};
}] call Server_Setup_Compile;