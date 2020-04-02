//objects where we can play videos on
/* DISABLED DUE TO COMPILE BLOCKS, DISABLED DUE TO COMPILE BLOCKS, DISABLED DUE TO COMPILE BLOCKS, DISABLED DUE TO COMPILE BLOCKS, DISABLED DUE TO COMPILE BLOCKS
#define VIDEO_OBJECTS ["Land_A3PL_Cinema"]

["A3PL_Youtube_OpenComputer",
{
	private ["_cinema"];
	_cinema = param [0,objNull];
	if ((_cinema getVariable ["bOwner",""]) != (getPlayerUID player)) exitwith {["System: You do not own the cinema",Color_Red] call A3PL_Player_Notification;};
	createDialog "Dialog_YoutubeMain";
}] call Server_Setup_Compile;

["A3PL_Youtube_StartButton",
{
	disableSerialization;
	private ["_display","_control","_url"];
	_display = findDisplay 3005;
	_control = _display displayCtrl 1400;
	_url = ctrlText _control;
	[_url,player_objIntersect] spawn A3PL_Youtube_StartVideo;
	closeDialog 0;
	["System: You initiated a video",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Youtube_StartVideo",
{
	//First grab all the required data
	_url = param [0,""];
	_object = param [1,objNull];
	if (!(typeOf _object IN VIDEO_OBJECTS)) exitwith {["System: Unable to determine valid video object",Color_Red] call A3PL_Player_Notification;};

	["System Youtube: Sending API call to google to get video data, your game might freeze for a few seconds", Color_Red] call A3PL_Player_Notification;
	uiSleep 0.5;
	_videoInfo = call compile ("Arma2Net.Unmanaged" callExtension format ["Cinema ['Cinema_GrabInfo','%1']",_url]);

	if (isNil "_videoInfo") exitwith {["System youtube error: There was a problem retrieving the video info",Color_Red] call A3PL_Player_Notification;};

	//delimit string
	_splitted = _videoInfo splitstring ":*:";

	//check errors
	if (count _splitted < 2) exitwith {[format ["System Youtube Error: In Cinema_GrabInfo (details: %1)",_videoinfo], Color_Red] call A3PL_Player_Notification;};

	//get details
	_videoTitle = "";
	{
		if (_forEachIndex != (count _splitted - 1)) then
		{
			_videoTitle = format ["%1%2",_videoTitle,_x];
		};
	} foreach _splitted;

	_videoDuration = parseNumber (_splitted select (count _splitted - 1));

	//check if duration < 900
	if (_videoDuration > 900) exitwith {["System Youtube Error: Video is longer than 15 minutes", Color_Red] call A3PL_Player_Notification;};
	if (_videoDuration < 10) exitwith {["System Youtube Error: Video is shorter than 10 seconds", Color_Red] call A3PL_Player_Notification;};

	//check if already playing
	if ((_object getVariable ["videoInfo",["stopped"]] select 0) != "stopped") exitwith {["System Youtube Error: It looks like a video is already playing, you can use vote skip to stop it if you wish", Color_Red] call A3PL_Player_Notification;};

	//send a request to server
	[_videoTitle,_videoDuration,_url,_object] remoteExec ["Server_Youtube_StartVideo", 2];

}] call Server_Setup_Compile;

["A3PL_Youtube_DebugStart",
{
	_object = param [0,objNull];

	A3PL_Youtube_RunDebug = true;

	[_object] spawn
	{
		_object = param [0,objNull];

		while {A3PL_Youtube_RunDebug} do
		{
			systemchat "Refreshed Cinema Debug Monitor";
			[_object] call A3PL_Youtube_DebugLoop;
			sleep 0.5;
		};
	};
}] call Server_Setup_Compile;

["A3PL_Youtube_DebugStop",
{
	disableSerialization;

	A3PL_Youtube_RunDebug = false;

	_display = uiNamespace getVariable ["Dialog_Hud_Cinema",displayNull];
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText "";

}] call Server_Setup_Compile;


["A3PL_Youtube_DebugLoop",
{
	_object = param [0,objNull];
	disableSerialization;

	//display
	_display = uiNamespace getVariable "Dialog_Hud_Cinema";
	_control = _display displayCtrl 1100;

	//_object setvariable ["videoInfo",["starting",_videoTitle,_videoDuration,_videoUrl],true];
    _videoInfo = _object getVariable ["videoInfo",["Undefined","n/a",0,"n/a"]];
	_videoTime = _object getVariable ["videoTime",0];
	_videoState = _videoInfo select 0;
	_videoTitle = _videoInfo select 1;
	_videoDuration = _videoInfo select 2;

	//draw
	_text1 = format ["<t align='center' font='RobotoCondensed' size='1.2'>Cinema Debug Monitor (State: %1)</t><br />",_videoState];
	_text2 = format ["<t align='center' font='RobotoCondensed' size='1'>Video Title: %1</t><br />",_videoTitle];
	_text3 = format ["<t align='center' font='RobotoCondensed' size='1'>Video Time (server): %1/%2</t><br />",[(_videoTime), "MM:SS"] call BIS_fnc_secondsToString,[(_videoDuration), "MM:SS"] call BIS_fnc_secondsToString];
	_text4 = "<t align='center' font='RobotoCondensed' size='1'>Players(and realtime theora render status):</t><br />";
	_text5 = "";

	{
		_text5 = format ["%1<t align='center' font='RobotoCondensed' size='1'>%2 - %3</t><br />",_text5,(_x getVariable ["name",(name _x)]),_x getVariable ["videostatus","Uknown"]];
	} foreach (_object getVariable ["videoPlayers",[player]]);

	_control ctrlSetStructuredText parseText (_text1 + _text2 + _text3 + _text4 + _text5);
}] call Server_Setup_Compile;

["A3PL_Youtube_StartVideoFinal",
{
	["System Youtube: All players ready - starting video now", Color_Green] call A3PL_Player_Notification;

	if (isNil "A3PL_Youtube_FileNameFinal") exitwith {["System Youtube Error: Unable to retrieve filename from downloaded video", Color_Red] call A3PL_Player_Notification;};
	_filename = A3PL_Youtube_FileNameFinal;
	if (isNil "A3PL_Youtube_Object") exitwith {["System Youtube Error: Unable to retrieve object to play video on", Color_Red] call A3PL_Player_Notification;};
	_object = A3PL_Youtube_Object;

	A3PL_Youtube_FileNameFinal = Nil;

    _videoInfo = _object getVariable ["videoInfo",["error"]];
	if (count _videoInfo == 1) exitwith {["System Youtube Error: There was an error retrieving the video info", Color_Red] call A3PL_Player_Notification;};

	_videoTime = _object getVariable ["videoTime",0];
	_videoDuration = _videoInfo select 2;
	_renderParts = ceil ((_videoDuration - _videoTime) / 5);

	//set playing variable
	_renderProgress = parseNumber call compile ("Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_ProgressConvert']");
	player setVariable ["videoStatus",format ["Playing (Render %1/%2)",_renderprogress,_renderParts],true];

	_renderPart = 0;

	A3PL_Youtube_ExitPlaying = false;

	while {(_renderPart <= _renderParts) && ((_object getVariable ["videoInfo",["stopped"]] select 0) == "running") && (! A3PL_Youtube_ExitPlaying)} do
	{
		[_object,format ["C:\A3PL_Temp\%1_%2.ogv",_filename,_renderPart]] spawn A3PL_Youtube_ScreenPlay;

		playSound3D [format ["C:\A3PL_Temp\%1_%2.ogg",_filename,_renderPart],[0,0,0], false, _object modelToWorld [6,-4,0], 2, 1, 0];
		playSound3D [format ["C:\A3PL_Temp\%1_%2.ogg",_filename,_renderPart],[0,0,0], false, _object modelToWorld [-6,-4,0], 2, 1, 0];

		sleep 1;
		if (A3PL_Youtube_ExitPlaying) exitwith {};
		if (!((_object getVariable ["videoInfo",["stopped"]] select 0) == "running")) exitwith {};
		sleep 1;
		if (A3PL_Youtube_ExitPlaying) exitwith {};
		if (!((_object getVariable ["videoInfo",["stopped"]] select 0) == "running")) exitwith {};
		sleep 1;
		if (A3PL_Youtube_ExitPlaying) exitwith {};
		if (!((_object getVariable ["videoInfo",["stopped"]] select 0) == "running")) exitwith {};
		sleep 1;
		if (A3PL_Youtube_ExitPlaying) exitwith {};
		if (!((_object getVariable ["videoInfo",["stopped"]] select 0) == "running")) exitwith {};
		sleep 0.95;
		if (A3PL_Youtube_ExitPlaying) exitwith {};

		//check if we are no longer in the cinema
		if (!(player IN (_object getVariable ["videoPlayers",[]]))) exitwith {};

		_renderProgress = parseNumber call compile ("Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_ProgressConvert']");
		player setVariable ["videoStatus",format ["Playing (Render %1/%2)",_renderprogress,_renderParts],true];
		_renderPart = _renderPart + 1;
	};

	player setVariable ["videoStatus","Video Finished",true];
	[] call A3PL_Youtube_DebugStop;
	"Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_Stop']";

}] call Server_Setup_Compile;

["A3PL_Youtube_StartDownload",
{
	_url = param [0,""];
	_object = param [1,objNull];

	//stop any videos
	"Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_Stop']";
	A3PL_Youtube_ExitPlaying = true;

	if (!isNil "A3PL_Youtube_IsDownloading") exitwith {["System Youtube Error: Your system is already downloading a video, if it's bugged a game restart will be required", Color_Red] call A3PL_Player_Notification;};
	A3PL_Youtube_IsDownloading = true;

	//start download
	["System Youtube: Starting download of video", Color_Green] call A3PL_Player_Notification;
	_filename = call compile ("Arma2Net.Unmanaged" callExtension format ["Cinema ['Cinema_StartDownload','%1']",_url]);

	//start debug monitor, leave a 1.05 sleep so other loop ends before (debug)
	sleep 1.05;
	[_object] call A3PL_Youtube_DebugStart;

	//set my status to downloading
	_progress = 0;
	while {_progress < 100} do
	{
		sleep 1;
		_progress = round (parseNumber call compile ("Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_ProgressDownload']"));
		player setVariable ["videoStatus",format ["Downloading (%1%2)",_progress,"%"],true];
	};

	//_object setvariable ["videoInfo",["starting",_videoTitle,_videoDuration,_videoUrl],true];
	//grab video status
    _videoInfo = _object getVariable ["videoInfo",["error"]];
	_t = 0;
	waitUntil {_videoInfo = _object getVariable ["videoInfo",["error"]]; _t = _t + 0.1; if (_t > 5) exitwith {}; sleep 0.1; (count _videoInfo != 1)}; // waituntil we have the vars assigned to the cinema
	if (count _videoInfo == 1) exitwith {["System Youtube Error: There was an error retrieving the video info", Color_Red] call A3PL_Player_Notification; A3PL_Youtube_IsDownloading = nil;};

	_videoTime = _object getVariable ["videoTime",0];
	_videoTitle = _videoInfo select 1;
	_videoDuration = _videoInfo select 2;

	_renderParts = ceil ((_videoDuration - _videoTime) / 5);

	//add 7 seconds to compensate for delay
	if ((_object getVariable ["videoTime",0]) > 0) then
	{
		_videoTime = _videoTime + 7;
		if (_videoTime > _videoDuration) then
		{
			_videoTime = _videoDuration;
		};
	};

	//check if duration
	if (_videoTime == _videoDuration) exitwith
	{
		player setVariable ["videoStatus","Cancelled video, video is ending",true];
		A3PL_Youtube_IsDownloading = nil;
	};

	//start the render
	["System Youtube: Starting Initial Video Render", Color_Green] call A3PL_Player_Notification;
	player setVariable ["videoStatus",format ["Initial Render (0/%1)",_renderParts],true];
	_renderReturn = "Arma2Net.Unmanaged" callExtension (format ["Cinema ['Cinema_StartConvert','%1:%2:%3:%4:%5']",_filename,_videoDuration,(profileNameSpace getVariable ["A3PL_Youtube_Vscale",7]),(profileNameSpace getVariable ["A3PL_Youtube_Ascale",6]),_videoTime]);
	if (_renderReturn == "Input Invalid") exitwith {["System Youtube Error: Render Start Failure (Input Invalid)", Color_Red] call A3PL_Player_Notification; A3PL_Youtube_IsDownloading = nil;};

	player globalchat (format ["Cinema ['Cinema_StartConvert','%1:%2:%3:%4:%5']",_filename,_videoDuration,10,10,_videoTime]);

	_renderProgress = 0;
	while {_renderProgress < 2} do
	{
		_renderProgress = parseNumber call compile ("Arma2Net.Unmanaged" callExtension "Cinema ['Cinema_ProgressConvert']");
		player setVariable ["videoStatus",format ["Initial Render (%1/%2)",_renderprogress,_renderParts],true];
		sleep 2;
	};

	A3PL_Youtube_IsDownloading = nil;

	//now we are ready
	["System Youtube: Initial Render (buffer) Complete - Waiting for other players", Color_Green] call A3PL_Player_Notification;
	player setVariable ["videoStatus","Ready",true];

	//Save the filename in a temp var
	A3PL_Youtube_FileNameFinal = _filename;
	A3PL_Youtube_Object = _object;

	//if the server already started this video, very unlikely they both run the same function in the same frame
	if ((_object getVariable ["videoTime",0]) > 0) then {[] call A3PL_Youtube_StartVideoFinal};
}] call Server_Setup_Compile;

["A3PL_Youtube_ScreenPlay",
{
	disableSerialization;

	_object = param [0,objNull];
	_file = param [1,""];

	(uiNamespace getVariable ["BIS_RscMissionScreen",displayNull]) closeDisplay 1;

	with uiNamespace do
	{

		1100 cutRsc ["RscMissionScreen","PLAIN"];
		_scr = BIS_RscMissionScreen displayCtrl 1100;
		_scr ctrlSetText _file;

		_scr ctrlSetPosition [-10,-10,0,0];
		_scr ctrlCommit 0;
		_scr ctrlAddEventHandler ["VideoStopped",
		{
			(uiNamespace getVariable "BIS_RscMissionScreen") closeDisplay 1;
		}];

		sleep 0.05; //small delay to reduce white/black flicker

		if (((getObjectTextures _object) select 0) != "") then
		{
			_object setObjectTexture [0,""];
			_object setObjectTexture [1,_file];
		} else
		{
			_object setObjectTexture [1,""];
			_object setObjectTexture [0,_file];
		};

	};
}] call Server_Setup_Compile;
