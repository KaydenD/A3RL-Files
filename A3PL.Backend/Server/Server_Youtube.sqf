["Server_Youtube_StopVideo",
{
	_object = param [0,objNull];
	
	_object setvariable ["videoInfo",nil,true];
}] call Server_Setup_Compile;

["Server_Youtube_StartVideo",
{
	_videoTitle = param [0,""];
	_videoDuration = param [1,0];
	_videoUrl = param [2,""];
	_object = param [3,objNull];
	_renderTimeOut = 100;
	
	//already playing something
	if ((_object getVariable ["videoInfo",["stopped"]] select 0) != "stopped") exitwith {};
	
	//set video info
	_object setvariable ["videoInfo",["starting",_videoTitle,_videoDuration,_videoUrl],true];
	_object setVariable ["videoTime",0,true];
	
	_videoPlayers = [[],_object,_videoURL] call Server_Youtube_CheckPlayers;
	if (count _videoPlayers == 0) exitwith {};
	
	//loop until we are ready to play or render time out reaches
	_readyPlayers = [];
	while {_renderTimeOut > 0 && (!(count _readyplayers == count _videoPlayers))} do
	{
		_videoPlayers = [_videoPlayers,_object] call Server_Youtube_ClearPlayers;
		_videoPlayers = [_videoPlayers,_object,_videoURL] call Server_Youtube_CheckPlayers;
		_readyPlayers = [_videoPlayers] call Server_Youtube_CheckReady;
		uiSleep 1;
		_renderTimeOut = _renderTimeOut - 1;
		
		//if no more players
		if (count _videoPlayers == 0) exitwith {};
	};
	
	//if everyone quit then we can just exit and nil the vars
	if (count _readyPlayers == 0) exitwith
	{
		_object setvariable ["videoInfo",nil,true];
		_object setVariable ["videoTime",nil,true];
		_object setVariable ["videoPlayers",nil,true];		
	};
	
	//okay all good, lets send all the ready players a start request
	[] remoteExec ["A3PL_Youtube_StartVideoFinal", _readyPlayers];
	
	//set variable
	_object setvariable ["videoInfo",["running",_videoTitle,_videoDuration,_videoUrl],true];	
	
	//loop on server to set video time and other things
	_time = 0;
	while {_time <= _videoDuration} do
	{
																				 // [p1,p2]
		_videoPlayers = [_videoPlayers,_object] call Server_Youtube_ClearPlayers; //clear the videoplayers that are no longer in the cinema [p1]
		[_videoPlayers,_object,_videoURL] call Server_Youtube_CheckPlayers; //send download requests to those that enter the cinema [p1,p2]
		uiSleep 0.99;
		_time = _time + 1;
		_object setVariable ["videoTime",_time,true];
		
		//if it was stopped
		if (((_object getVariable ["videoInfo",["stopped"]]) select 0) == "stopped") exitwith {};
	};
	
	_object setVariable ["videoTime",nil,true];
	_object setVariable ["videoPlayers",nil,true];
	_object setvariable ["videoInfo",nil,true];
	
},true] call Server_Setup_Compile;

["Server_Youtube_ClearPlayers",
{
	_videoPlayers = param [0,[]];
	_object = param [1,objNull];
	
	switch (typeOf _object) do
	{
		case ("Land_A3PL_Cinema"): 
		{
			{
				if (!((getpos _x) inArea [(getpos _object), 7, 11,(getDir _object), true])) then
				{
					_videoPlayers - [_x];
				}
			} foreach _videoplayers;
		};
	};	
	
	_videoPlayers;
},true] call Server_Setup_Compile;

["Server_Youtube_CheckPlayers",
{
	_oldvideoPlayers = param [0,[]];
	_object = param [1,objNull];
	_videoURL = param [2,""];
	_videoPlayers = [];
	
	switch (typeOf _object) do
	{
		case ("Land_A3PL_Cinema"): 
		{
			{
				if ((getpos _x) inArea [(getpos _object), 7, 11,(getDir _object), true]) then
				{
					_videoPlayers pushback _x;
				}
			} foreach allPlayers;
		};
	};
	
	//send anyone that wasn't in the old video players a download request
	{
		if (!(_x IN _oldvideoPlayers)) then
		{
			[_videoUrl,_object] remoteExec ["A3PL_Youtube_StartDownload", owner _x];
		};
	} foreach _videoPlayers;
	
	_object setVariable ["videoPlayers",_videoPlayers,true];
	
	_videoPlayers;
},true] call Server_Setup_Compile;

["Server_Youtube_CheckReady",
{
	_videoPlayers = param [0,[]];
	_ready = [];
	{
		if ((_x getVariable ["videoStatus","stopped"]) == "Ready") then
		{
			_ready pushback _x;
		};
	} foreach _videoPlayers;
	
	_ready;
},true] call Server_Setup_Compile;