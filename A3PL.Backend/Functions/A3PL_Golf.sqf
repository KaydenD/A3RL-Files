LOCALUIDCHECK = "666";
A3PL_Player_Golfing = false;

GOLFAI = "FlagPole_F" createvehicle (getpos player);
GOLFAI setvariable ["Lobbyleaders",[],true];
player setvariable ["PB_Lobbyleader",["0",player],true];
player setvariable ["inlobby",[],true];


A3PL_Golf_OpenLobby = {
	createdialog "A3PL_Open_PBLobby";
	_lobbyleaders = GOLFAI getvariable "Lobbyleaders";
	_ownerofgroup = false;
	
	//Old lobby leader left?
	if (isNull ((player getvariable "PB_Lobbyleader") select 1)) then {PB_Lobbyleader = [0,player];}; 
	
	//Show all the groups
	{
		_selected = _x;
		{
			if (LOCALUIDCHECK == _selected) then { //make this getplayeruid _x
				lbAdd [1501,format ["[%3/4] %1 (%2)",name _x,_selected,count (_x getvariable "inlobby")]];
				if (LOCALUIDCHECK == _selected) then {_ownerofgroup = true;}; //make this getplayeruid player
			};
		} foreach allplayers;
	} foreach _lobbyleaders;
	
	ctrlShow[1605,false]; //create group button
	ctrlShow[1601,false]; //Start game button
	ctrlShow[1602,false]; //Kick Player button
	ctrlShow[1603,false]; //Ban player button
	ctrlShow[1604,false]; //Join/Leave group button
	ctrlShow[1600,false]; //Disband group
	
	
	//player is not the lobby owner
	if (!_ownerofgroup) then {
		
		//Player is not in a group
		if ((player getvariable "PB_Lobbyleader") select 0 == "0") then {
			lbAdd [1500,"Not in a group..."];
			ctrlShow[1604,true]; //Join group button
			ctrlShow[1605,true]; //create group button
			((findDisplay 321738) displayCtrl 1604) ctrlSetText "JOIN GROUP";
			((findDisplay 321738) displayCtrl 1604) buttonsetAction "[0] spawn A3PL_Golf_LobbyExec;"; //Join Group
			((findDisplay 321738) displayCtrl 1605) buttonsetAction "[1] spawn A3PL_Golf_LobbyExec;"; //Create Group
		} else {
			{
				lbAdd [1500,name _x];
			}foreach (((player getvariable "PB_Lobbyleader") select 1) getvariable "inlobby");
			((findDisplay 321738) displayCtrl 1001) ctrlSetText format ["%1/4",count (((player getvariable "PB_Lobbyleader") select 1) getvariable "inlobby")];
			ctrlShow[1604,true]; //Leave group button
			((findDisplay 321738) displayCtrl 1604) ctrlSetText "LEAVE GROUP";
			((findDisplay 321738) displayCtrl 1604) buttonsetAction "[2] spawn A3PL_Golf_LobbyExec;"; //Leave Group
		};
	} else {
		{
			lbAdd [1500,name _x];
		}foreach (player getvariable "inlobby");
		((findDisplay 321738) displayCtrl 1001) ctrlSetText format ["%1/4",count (player getvariable "inlobby")];
		ctrlShow[1601,true]; //Start game button
		ctrlShow[1602,true]; //Kick Player button
		//ctrlShow[1603,true]; //Ban player button
		ctrlShow[1600,true]; //Disband group
		((findDisplay 321738) displayCtrl 1601) buttonsetAction "[3] spawn A3PL_Golf_LobbyExec;"; //Start game
		((findDisplay 321738) displayCtrl 1602) buttonsetAction "[4] spawn A3PL_Golf_LobbyExec;"; //Kick player
		//((findDisplay 321738) displayCtrl 1603) buttonsetAction "[5] spawn A3PL_Golf_LobbyExec;"; //Ban player
		((findDisplay 321738) displayCtrl 1600) buttonsetAction "[6] spawn A3PL_Golf_LobbyExec;";  //Disband group
	};
};

[] spawn A3PL_Golf_OpenLobby;

A3PL_Golf_LobbyExec = {
	_execute = _this select 0;
	//Join the group
	if (_execute == 0) exitwith {	};
	
	//Create Group
	if (_execute == 1) exitwith {
		closedialog 0;
		_Leaders = GOLFAI getvariable "lobbyleaders";
		if ((_leaders find LOCALUIDCHECK) != -1) exitwith { ["Already leader...",Color_Red] call A3PL_Player_Notification; };  //make this getplayeruid player
		player setvariable ["PB_Lobbyleader",[LOCALUIDCHECK,player],true];  //make this getplayeruid player
		_Leaders = _Leaders + [LOCALUIDCHECK]; //make this getplayeruid player
		GOLFAI setvariable ["lobbyleaders",_Leaders,true];
		player setvariable ["inlobby",[player],true];
		[] spawn A3PL_Golf_OpenLobby;
	};
	//Leave Group
	if (_execute == 2) exitwith {
		closedialog 0;
		_inlobby = ((player getvariable "PB_Lobbyleader") select 1) getvariable "inlobby";
		if ((_inlobby find player) == -1) exitwith {["Not in group...",Color_Red] call A3PL_Player_Notification;}; //
		_inlobby deleteat (_inlobby find player);
		((player getvariable "PB_Lobbyleader") select 1) setvariable ["inlobby",_inlobby,true];
		player setvariable ["inlobby",[],true];
		player setvariable ["PB_Lobbyleader",["0",player],true];
		createdialog "A3PL_Open_PBLobby";
	};
	//Start game
	if (_execute == 3) exitwith {
		closedialog 0;
		["Server starting...",Color_Green] call A3PL_Player_Notification;
		//sleep 5;
		_colorscheme = [["#1abc1d","0.1,0.73,0.11,1"],["#c11d1d","0.75,0.11,0.11,1"],["#191eb7","0.09,0.11,0.71,1"],["#ad187e","0.67,0.09,0.49,1"]];
		_scoreboard = [];
		GOLFFLAG = "FlagPole_F" createvehicle [0,0,0];
		player setpos [3989.02,6978.01,0.00143051];
		{
			if (!(isNull _x)) then {
				//_namecolor = _x getvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5"]] select 1;
				_namecolor = (_colorscheme select _foreachindex) select 0;
				_namepicture = _x getvariable ["twitterprofile",["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5"]] select 0;
				_ball = "A3PL_Ball" createvehicle [0,0,0];
				_ball setObjectTexture [0, format ["#(rgb,8,8,3)color(%1)",(_colorscheme select _foreachindex) select 1]];
				_scoreboard = _scoreboard + [[_x,(name _x),_namepicture,_namecolor,0,0,0,0,0,0,0,0,0,0,0,_ball]]; //need to change to getvariable
				_loc = (player getPos [(5*_foreachindex),180]);
				// Add teleportation to location
				[player,_ball] remoteExec ["A3PL_Golf_LocalInit", _x]; 
			};
		} foreach (player getvariable "inlobby");
		GOLFFLAG setvariable ["Scoreboard",_scoreboard,true];
		GOLFFLAG setvariable ["owner",player,true];
		GOLFFLAG setvariable ["game",-1,true];
	};
	//Kick player
	if (_execute == 4) exitwith {
		_inlobby = player getvariable "inlobby";
		_selplayer = _inlobby select (lbCurSel 1500);
		if (_selplayer == player) exitwith { ["Can't kick yourself...",Color_Red] call A3PL_Player_Notification; };
		_selplayer setvariable ["PB_Lobbyleader",["0",player],true];
		_inlobby deleteat (lbCurSel 1500);
		player setvariable ["inlobby",_inlobby,true];
		lbClear 1500;
		{
			lbAdd [1500,name _x];
		} foreach (player getvariable "inlobby");
		((findDisplay 321738) displayCtrl 1001) ctrlSetText format ["%1/4",count (((player getvariable "PB_Lobbyleader") select 1) getvariable "inlobby")];
	};
	//Ban player NOT ADDED
	if (_execute == 5) exitwith {	};
	//Disband Group
	if (_execute == 6) exitwith {
		closedialog 0;
		_Leaders = GOLFAI getvariable "lobbyleaders";
		if ((_leaders find LOCALUIDCHECK) == -1) exitwith {["Not a leader...",Color_Red] call A3PL_Player_Notification;};  //make this getplayeruid player
		player setvariable ["inlobby",[],true];
		player setvariable ["PB_Lobbyleader",["0",player],true];
		
		_Leaders = _Leaders - [LOCALUIDCHECK]; //make this getplayeruid player
		GOLFAI setvariable ["lobbyleaders",_Leaders,true];
		[] spawn A3PL_Golf_OpenLobby;
	};
};


//Variable Scoreboard = [[_x,(name _x),_namepicture,_namecolor,0,0,0,0,0,0,0,0,0,0,0]]

A3PL_Golf_LocalInit = {
	Golf_Ball = _this select 1;
	Golf_Ball_Loc = (player getPos [5,270]);
	Golf_Ball setpos Golf_Ball_Loc;
	
	754211 cutRsc ["Dialog_HUD_Golf", "PLAIN"];
	// Icon/Name/score 1 to 10
	[0] spawn A3PL_Golf_Refresh;
	((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 12009) ctrlShow false;
	((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10009) ctrlShow false;
	((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlShow false;
	((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10029) ctrlShow false;
	((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10039) ctrlShow false;

	
	Golf_Club = "A3PL_Golf_Driver_Object" createvehicle getpos player;
	Golf_Club attachto [player,[0.05,0.2,-0.08],"RightHand"];  
	player playActionNow "gesture_golf";
	A3PL_Player_Golfing = true;
	A3PL_Hitmode = 0;
	
	timer = time + 60;
};
 //
 
 // 0 = PLAYER HUD refresh
 // 1 = HOST next flagspot
A3PL_Golf_Refresh = {
	_mode = _this select 0;
	//update the HUD
	if (_mode == 0) then {
		_menudigits = [	[1200,1000,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109],
							[1201,1001,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119],
							[1202,1002,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129],
							[1203,1003,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139]
						];
		{
			((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl ((_menudigits select _foreachindex) select 1)) ctrlSetStructuredText parsetext format["<t size='0.5'><img image='%3' /> </t><t size='0.9' color='%1'>%2</t>",(_x select 3),(_x select 1),(_x select 2)];
			for "_i" from 2 to 11 do {
				((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl ((_menudigits select _foreachindex) select _i)) ctrlSetText format ["%1",_x select (_i + 2)];
			};
		} foreach (GOLFFLAG getvariable "Scoreboard");
		_pastscore = (GOLFFLAG getvariable "Scoreboard");
		waituntil {
			sleep 1;
			((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10049) ctrlSetText format ["Time left: %1",round (timer - time)];
			((!A3PL_Player_Golfing) OR (str _pastscore != str (GOLFFLAG getvariable "Scoreboard")))
		};
		if (!A3PL_Player_Golfing) exitwith {};
		[0] spawn A3PL_Golf_Refresh;
	};
	//Switch to different location
	if (_mode == 1) then {
	
	
	};
};

A3PL_Golf_Backspace = {
	if (a3pl_hitmode >= 1) then {
		a3pl_hitmode = 0;
	} else {
		Golf_Ball setpos Golf_Ball_Loc;
	};
};

A3PL_Golf_Hitmode = {
	if (!A3PL_Player_Golfing) exitwith {};
	a3pl_hitmode = a3pl_hitmode + 1;
	if (a3pl_hitmode == 1) then {
		_cameraloc = player getPos [10,30];
		golfcamera = "camera" camCreate [_cameraloc select 0, _cameraloc select 1, 8];
		golfcamera camSetTarget Golf_Ball;
		golfcamera cameraEffect ["internal", "BACK"];
		golfcamera camCommit 0;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 12009) ctrlShow true;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10009) ctrlShow true;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlShow true;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10029) ctrlShow true;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10039) ctrlShow true;
		a3pl_hitmode = 1;
		_speed = 0;
		_height = 0;
		_miss = false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10009) ctrlSetText "Spacebar to continue, Backspace to cancel";
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlSetText "Select Speed";
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10029) ctrlSetText "Speed: NOT SET";
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10039) ctrlSetText "Height: NOT SET";
		
		//If the player is not at the correct position, it misses
		if (((Golf_Ball distance player) > 1) OR ((Golf_Ball distance player) < 0.8)) then {_miss = true;};
		
		while {a3pl_hitmode == 1} do {
			if (_speed > 1) then {_speed = 0;};
			_speed = _speed + 0.03;
			sleep 0.01;
			((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 12009) progressSetPosition _speed;
		};
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10029) ctrlSetText format ["Speed: %1",(_speed*100)];
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlSetText "Select Height";
		while {a3pl_hitmode == 2} do {
			if (_height > 1) then {_height = 0;};
			_height = _height + 0.03;
			sleep 0.01;
			((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 12009) progressSetPosition _height;
		};
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10039) ctrlSetText format ["Height: %1",(_height*100)];
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10009) ctrlShow false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlShow false;
		if (a3pl_hitmode == 3) then {
			_speed = 30 * _speed;
			_height = 15 * _height;
			if ((_height + _speed) < 20) then {
				player playActionNow "gesture_golf";
				player switchMove "A3PL_Golf_Drive";
			} else {
				player playActionNow "gesture_stop"; 
				player switchMove "A3PL_Golf_Drive";
			};
			sleep 0.9;
			if (_miss) then {_speed = 0; _height = 0;};
			_vel = velocity player;
			_dir = (direction player) - 90;
			
			Golf_Ball setVelocity [
				(_vel select 0) + (sin _dir * _speed), 
				(_vel select 1) + (cos _dir * _speed), 
				(_vel select 2) + _height
			];
			sleep 3;
			_cameraloc = Golf_Ball getPos [5,30];
			golfcamera camSetPos [_cameraloc select 0, _cameraloc select 1, 3];
			golfcamera camCommit 3;
			sleep 2;
			a3pl_hitmode = 0;
			player playActionNow "gesture_golf";
			player switchMove "";
		};
		
		//if it's canceled
		waituntil {sleep 1; a3pl_hitmode == 0};
		
		golfcamera cameraEffect ["terminate", "back"];
		camDestroy golfcamera;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 12009) ctrlShow false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10009) ctrlShow false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10019) ctrlShow false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10029) ctrlShow false;
		((uiNamespace getVariable ["Dialog_HUD_Golf", displayNull]) displayCtrl 10039) ctrlShow false;
	};
};

fag = {




_club = club;
_club attachto [player,[0.05,0.4,-0.2],"RightHand"];
 
_club = club;
_club attachto [player,[0.05,0.4,-0.2],"RightHand"];
 
_club = club;
_club attachto [player,[0.05,0.2,-0.08],"RightHand"];  
_club = club;
_club setVectorDirAndUp ([player,"LeftHand","RightHand"] call A3PL_Lib_VectorDirUpMem);
 
 
//Create
club = "A3PL_Golf_Driver_Object" createvehicle getpos player;
club attachto [player,[0.05,0.2,-0.08],"RightHand"];  
player playActionNow "gesture_golf";
 
deleteVehicle club;
player playActionNow "gesture_stop";
player addWeapon "A3PL_Golf_Driver";
player switchMove "A3PL_Golf_Drive";
 
[] spawn
{
    sleep 8;
    player removeWeapon "A3PL_Golf_Driver";
    player switchMove "";
    Golf_Club = "A3PL_Golf_Driver_Object" createvehicle getpos player;
    Golf_Club attachto [player,[0.05,0.2,-0.08],"RightHand"];
    player playActionNow "gesture_golf";   
};
 
[] spawn
{
    player playAction "gesture_stop";
    player switchMove "A3PL_Golf_Drive";
    Golf_Club attachto [player,[-0.01,0.16,0.4],"RightHand"];
    while {(animationState player) == "A3PL_Golf_Drive"} do
    {
        sleep 0.01;
        Golf_Club setVectorDirAndUp ([player,"LeftHand","RightHand"] call A3PL_Lib_VectorDirUpMem);     
    };
    Golf_Club attachto [player,[0.05,0.2,-0.08],"RightHand"];
    player playAction "gesture_golf";
};

};


754211 cutFadeOut 1;







