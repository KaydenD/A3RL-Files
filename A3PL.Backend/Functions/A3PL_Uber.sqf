['A3PL_Uber_addDriver',
{
	[player] remoteExec ["Server_Uber_addDriver", 2];
	["System: Request to become an uber driver has been send",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;



['A3PL_Uber_removeDriver', {

	player setVariable ["job","unemployed",true];
	["System: Request to leave as uber driver has been send",Color_Green] call A3PL_Player_Notification;

	if (A3PL_Uber_JobActive) then
	{
		[] call A3PL_Uber_EndJob;
	};
}] call Server_Setup_Compile;



["A3PL_Uber_Open", {

	disableSerialization;

	closeDialog 0;
	createDialog "Dialog_Phone_UberMenu";

	if(player getVariable ["job","unemployed"] == "uber") then
	{

		ctrlSetText [1609, "Quit"];
		buttonSetAction [1609, "[] call A3PL_Uber_removeDriver"];

		//Check if in active job
		if(A3PL_Uber_JobActive) then {

			ctrlSetText [1613, "End Job"];
			buttonSetAction [1613, "[] call A3PL_Uber_EndJob;"];

		} else {
			ctrlSetText [1613, ""];
			ctrlEnable [1613, false];
		};

	} else
	{
		buttonSetAction [1613, "[] call A3PL_Uber_requestDriver;"];
		buttonSetAction [1609, "[] call A3PL_Uber_addDriver;"];
	};


}] call Server_Setup_Compile;



["A3PL_Uber_requestDriver",{

	disableSerialization;

	[player] remoteExec ["Server_Uber_requestDriver",2];
	["System: Uber request send",Color_Red] call A3PL_Player_Notification;
}] call Server_Setup_Compile;



["A3PL_Uber_EndJob",
{

	A3PL_Uber_JobActive = false;
	deleteMarkerLocal "uber_job";
	A3PL_Uber_CurrentJobPlayer = nil;

	["System: Your current uber job has been cancelled",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;



["A3PL_Uber_RecieveRequest",{

	if(A3PL_Uber_JobActive) exitWith {};

	params[["_customer",objNull,[objNull]]];

	A3PL_Uber_ActiveRequest = _customer;

	closeDialog 0;
	createDialog "Dialog_UberAccept";

}] call Server_Setup_Compile;



["A3PL_Uber_AcceptRequest",
{
	private ["_job","_marker"];

	closeDialog 0;
	A3PL_Uber_JobActive = true;
	A3PL_Uber_CurrentJobPlayer = A3PL_Uber_ActiveRequest;

	deleteMarkerLocal "uber_job";

	_marker = createMarkerLocal ["uber_job", A3PL_Uber_CurrentJobPlayer];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_warning";
	_marker setMarkerTextLocal format ["Current uber request - %1",(A3PL_Uber_CurrentJobPlayer getVariable ["name","Unknown name"])];
	_marker setMarkerColorLocal "ColorBlack";

	["System: Uber request accepted and marker added to your map with the location, to cancel the job use the uber application",Color_Green] call A3PL_Player_Notification;
	["System: You are required to 'quit' the job using the uber application once the request is fulfilled or you wont receive further requests",Color_Green] call A3PL_Player_Notification;

	//send message to player
	["System: An uber driver has accepted your request and is on its way to you", Color_Green] remoteExec ["A3PL_Player_Notification",A3PL_Uber_CurrentJobPlayer];
}] call Server_Setup_Compile;
