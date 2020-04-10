// Run upon player spawn, request A3 inventory and display loading screen
['A3PL_Loading_Start', {
	[] spawn {
		private ['_display', '_format', '_control'];
		disableSerialization;

		if (!isServer) then
		{
			["A3PL_Common\ogv\logo_animated.ogv"] call BIS_fnc_titlecard;
			//["A3PL_Common\ogv\logo_animated.ogv"] spawn BIS_fnc_playVideo;

			sleep 8;
		};

		player setVariable ["tf_voiceVolume", 0, true];
		cutText["","BLACK"];

		['Dialog_Loading'] call A3PL_Lib_CreateDialog;

		_display = findDisplay 15;

		//changelog text
		_control = (_display displayCtrl 69);
		_format = "<t size='3' font='PuristaSemiBold' align='center' color='#B8B8B8'>VERSION 1.0.6.9</t>"
		+ "<br/><br/>"
		+ "<t size='1' align='left' color='#00ff00'> Added: </t><t size='1' align='left'>Huge bug fixes</t>"
		+ "<br/>"	
		+ "<t size='1' align='left' color='#00ff00'> Fixed: </t><t size='1' align='left'>New textures for factions</t>"
		+ "<br/>"
		//+ "<t size='1' align='left' color='#00ff00'> Deleted: </t><t size='1' align='left'>Made all ^ up</t>"
		//+ "<br/><br/>"
		+ "<t size='0.8' align='center'>For full changelog and more info visit the forum @ arma3realitylife.com/forums</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10360);
		_format = "<t size='1' align='center' color='#B8B8B8'>0%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = "<t size='1' align='center' color='#B8B8B8'>Retrieving client functions...</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.5;

		// Player cannot press ESC to close dialog
		noEscape = _display displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then {true}"];

		[] call A3PL_Loading_Request;
	};
}] call Server_Setup_Compile;

//COMPILE BLOCK FUNCTION, COPY INTO fn_preInit.sqf!!!
["A3PL_Loading_Request", {

	[] spawn {
		private ["_waiting","_display","_control", '_format',"_pos"];
		disableSerialization;

		_display = findDisplay 15;

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_SERVFUNCREC")]; //Server functions received
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.3;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>30%</t>";
		_control ctrlSetStructuredText (parseText _format);

		// Do not start doing any of this until we are in the game
		waitUntil {sleep 0.5; player == player};
		_pos = getpos player;
		sleep 1;

		//Whitelisting Check
		[[player],"Server_Whitelisting_Check",false,false,false] call BIS_FNC_MP;
		
		//Send request to server to load player gear
		[[player],"Server_Gear_Load",false,false,false] call BIS_FNC_MP;

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_RECPLAYGEAR")]; //Receiving player gear
		_control ctrlSetStructuredText (parseText _format);

		_waiting = 0;
		while {isNil "A3PL_RetrievedInventory"} do
		{
			sleep 2;
			_waiting = _waiting + 2;
			if (_waiting > 10) then
			{
				// send request again after 10sec of no reply
				[[player],"Server_Gear_Load",false,false,false] call BIS_FNC_MP;
				_waiting = 0;
			};
		};

		// Enable drugs system
		// Types of drugs in array,If passed out or not
		player setvariable ["drugs_array",[[["alcohol",0],["cocaine",0],["shrooms",0]],false],true];
		player setVariable ["Zipped",false,true];
		player setVariable ["DoubleTapped",false,true];

		// use this sleep instead of this while in editor
		if (isServer) then {
			sleep 2;
		} else
		{
			//If position is changed by the server we have loaded the gear
			while {_pos isEqualTo (getpos player)} do
			{
				sleep 0.4;
				_format = format ["<t size='1' align='center' color='#B8B8B8'>%1.</t>",(localize "STR_LOADING_RECPLAYGEAR")]; //Receiving player gear
				_control ctrlSetStructuredText (parseText _format);
				sleep 0.4;
				_format = format ["<t size='1' align='center' color='#B8B8B8'>%1..</t>",(localize "STR_LOADING_RECPLAYGEAR")]; //Receiving player gear
				_control ctrlSetStructuredText (parseText _format);
				sleep 0.4;
				_format = format ["<t size='1' align='center' color='#B8B8B8'>%1...</t>",(localize "STR_LOADING_RECPLAYGEAR")]; //Receiving player gear
				_control ctrlSetStructuredText (parseText _format);
			};
		};

		//okay, we are out of the loop, lets set the markers for houses
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.4;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>40%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_ASSHOUSEAPP")]; //Assigning house/appartment...
		_control ctrlSetStructuredText (parseText _format);


		// Stats retrieved succesfully
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.5;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>50%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_PLAYERGEARL")]; //Player gear loaded
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_INITCURVEH")]; //Initializing current vehicles...
		_control ctrlSetStructuredText (parseText _format);


		//Comment next line to disable all client vehicle inits from config (might help in debugging lag etc)
		A3PL_Vehicle_HandleInitU = toArray (format ["%1",A3PL_Vehicle_HandleInitU]);
		A3PL_Vehicle_HandleInitU deleteAt 0;
		A3PL_Vehicle_HandleInitU deleteAt ((count A3PL_Vehicle_HandleInitU) - 1);
		A3PL_Vehicle_HandleInitU = toString A3PL_Vehicle_HandleInitU;
		A3PL_HandleVehicleInit = compileFinal A3PL_Vehicle_HandleInitU;


		sleep 2;

		// Vehicles loaded
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 0.9;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>70%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_VEHINITSUCC")]; //Vehicles initialized succesfully
		_control ctrlSetStructuredText (parseText _format);

		sleep 2;

		[] call A3PL_Medical_Init;
		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>80%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",(localize "STR_LOADING_MEDSYSINIT")]; //Medical system initialized
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		//Once done loading everything lets closeDialog
		_control = (_display displayCtrl 11059);
		_control progressSetPosition 1;

		_control = (_display displayCtrl 10360);
		_format = "<t size='2' align='center' color='#B8B8B8'>100%</t>";
		_control ctrlSetStructuredText (parseText _format);

		_control = (_display displayCtrl 10359);
		_format = format ["<t size='1' align='center' color='#B8B8B8'>%1</t>",localize "STR_LOADING_PLAYINITSUC"]; //Player initialized succesfully
		_control ctrlSetStructuredText (parseText _format);

		sleep 1;

		showChat false;

		//load the admins
		[] call A3PL_Admin_Check;

		_display displayRemoveEventHandler ["KeyDown", noEscape];

		[0] call A3PL_Lib_CloseDialog;

		player setVariable ["tf_voiceVolume", 1, true];
		cutText["","BLACK IN"];

		player enableSimulation true;
		player setvariable ["FinishedLoading",true,true];

	};
},false,true] call Server_Setup_Compile;