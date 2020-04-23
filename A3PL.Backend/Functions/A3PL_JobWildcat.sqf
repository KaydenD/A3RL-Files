//distance from center that oil can be found from
#define OILDISTANCE 100
//distance from center where a resource can be found
#define RESDISTANCE 100 

["A3PL_JobWildCat_BuyMap",
{
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; 	
	private ["_mapType","_markers","_oilArray","_resArray","_exactLocation","_pos","_timeLeft"];
	_mapType = param [0,""];
	_markers = [];
	
	//timer
	_timeLeft = missionNameSpace getVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime-2)];
	if (_timeLeft > diag_ticktime) exitwith {[format ["Please wait %1 more seconds before buying another map",round(_timeLeft-diag_ticktime)],Color_Red] call A3PL_Player_Notification;};
		
	switch (true) do
	{
		case (_mapType == "oil"):
		{
			//price
			if ((player getVariable ["player_cash",0]) < 1000) exitwith {["System: You don't have enough money to buy this map",Color_Red] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 1000,true];
			
			_oilArray = missionNameSpace getVariable ["Server_JobWildCat_Oil",[]];
			_exactLocation = (_oilArray select (round (random ((count _oilArray) - 1)))) select 0; 
			_pos = [((_exactLocation select 0) + (-100 + (random 200))),((_exactLocation select 1) + (-100 + (random 200)))]; //offset the real location

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [142,142]; //same as oildistance defined in A3PL_JobWildCat + max of 300
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.7;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTypeLocal "Mil_dot"; 
			_marker setMarkerTextLocal format ["OIL IN THIS VICINITY"];
			_markers pushback _marker;			
		};
		
		case (_mapType IN ["iron","coal","aluminium","sulphur"]):
		{
			//price
			if ((player getVariable ["player_cash",0]) < 500) exitwith {["System: You don't have enough money to buy this map",Color_Red] call A3PL_Player_Notification;};
			player setVariable ["player_cash",(player getVariable ["player_cash",0]) - 500,true];			
			
			_resArray = Server_JobWildCat_Res;
			_newResArray = [];
			{
				if ((_x select 0) == _mapType) then {_newResArray pushback _x};
			} foreach _resArray;
			
			_exactLocation = (_newResArray select (round (random ((count _newResArray) - 1)))) select 1;
			_pos = [((_exactLocation select 0) + (-50 + random 100)),((_exactLocation select 1) + (-50 + random 100))];

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ELLIPSE";
			_marker setMarkerSizeLocal [120,120];
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerAlphaLocal 0.7;
			_markers pushback _marker;

			_marker = createMarkerLocal [format["%1_marker",floor (random 5000)],_pos];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerColorLocal "ColorYellow";
			_marker setMarkerTypeLocal "Mil_dot";
			_marker setMarkerTextLocal format ["%1 IN THIS VICINITY",toUpper _mapType];
			_markers pushback _marker;
		};
	};
			
	if (count _markers == 0) exitwith {};
	missionNameSpace setVariable ["A3PL_JobWildcat_MapTimer",(diag_ticktime + 300)];
	[_markers] spawn
	{
		_markers = param [0,[]];
		uiSleep 900;
		{deleteMarkerLocal _x;} foreach _markers
	};
	
	[format ["System: You bought an %1 map, the location will be marked on your map for 10 minutes",_maptype],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//opens prospect menu
["A3PL_JobWildCat_ProspectOpen",
{
	disableSerialization;
	private ["_display","_control"];
	createDialog "Dialog_Prospect";
	_display = findDisplay 131;
	_control = _display displayCtrl 2100;
	//fill combo
	{
		_control lbAdd (_x select 0);
	} foreach Config_Resources_Ores;
	_control lbAdd "Oil"; //add oil, cause its not in the ores array
	_control lbSetCurSel 0;
	//set buttonaction
	_control = _display displayCtrl 1601;
	_control buttonSetAction 
	"
			[(lbText [2100,(lbCurSel 2100)])] call A3PL_JobWildcat_ProspectInit;
			closeDialog 0;
	";
}] call Server_Setup_Compile;

//prospecting script
["A3PL_JobWildcat_ProspectInit", 
{
	private ["_checkOil","_haveOil","_oilLocation","_oilAmount","_prospectFor"];
	_prospectFor = toLower (param [0,"oil"]);
	
	switch (_prospectFor) do 
	{
		case ("oil"): 
		{
			//first check if we have an oil well
			_checkOil = [getpos player] call A3PL_JobWildcat_CheckForOil;
			_haveOil = _checkOil select 0;
			_oilLocation = _checkOil select 1;
			if (!_haveOil) exitwith {[0] spawn A3PL_JobWildCat_Prospect};
			
			_oilAmount = [_oilLocation] call A3PL_JobWildcat_CheckAmountOil;
			
			//these numbers correspondent with the gallons set up inside the array inside Server_JobWildcat_RandomizeOil
			switch true do 
			{
				case (_oilAmount <= 50): {[1,"oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 100): {[2,"oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 150): {[3,"oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 200): {[4,"oil"] spawn A3PL_JobWildCat_Prospect;};
				case (_oilAmount <= 600): {[5,"oil"] spawn A3PL_JobWildCat_Prospect;};
				default {};
			};				
		};
		
		//ores
		case default
		{
			_checkOres = [getpos player,_prospectFor] call A3PL_JobWildcat_CheckForRes;
			_haveRes = _checkOres select 0;
			_resLocation = _checkOres select 1;	
			if (!_haveRes) exitwith {[0,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
			_resAmount = [_resLocation] call A3PL_JobWildcat_CheckAmountRes;
			switch true do 
			{
				case (_resAmount <= 3): {[1,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				case (_resAmount <= 5): {[2,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				case (_resAmount <= 30): {[3,_prospectFor] spawn A3PL_JobWildCat_Prospect;};
				default {};
			};					
		};
	};
}] call Server_Setup_Compile;

["A3PL_JobWildCat_Prospect",
{
	private ["_signs","_prospectArray","_listOres","_prospectFor","_canProspect"];
	_signs = param [0,0];
	_prospectFor = param [1,"oil"];
	
	if ((animationState player) == "acts_terminalopen") exitwith {["System: You are already prospecting!",Color_Red] call A3PL_Player_Notification;};
	if (!isNil "Player_Prospecting") exitwith {["System: You are already prospecting, or prospecting is timed out due to entering a vehicle",Color_Red] call A3PL_Player_Notification;};
	
	[[player,"Acts_TerminalOpen"],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
	["System: You are now prospecting and can't move during the duration of this, it will take roughly a minute to prospect this area for resources", Color_Red] call A3PL_Player_Notification;
	Player_Prospecting = true;
	
	switch (_prospectFor) do
	{
		case ("oil"):
		{
			switch (_signs) do
			{
				case 0: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there are any oil seeps around this area",Color_Red],
						["Prospecting: I just took a soil sample and it looks like it doesn't contain any petroleum residue",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates there might be oil-bearing rocks",Color_Red],
						["Prospecting: I couldn't find any oil-bearing rocks beneath the surface",Color_Red],
						["Prospecting: I couldn't find any oil-bearing rocks beneath the surface so I'm unable to study the magnetic properties of the rock involved",Color_Red]
					];
				};
				case 1: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there are any oil seeps around this area",Color_Red],
						["Prospecting: I just took a soil sample and it looks like it doesn't contain any petroleum residue",Color_Red],
						["Prospecting: It looks like the sound transmission of the land might indicate oil-bearing rocks beneath the surface!",Color_Green],
						["Prospecting: I couldn't find any oil-bearing rocks beneath the surface",Color_Red],
						["Prospecting: I couldn't find any oil-bearing rocks beneath the surface so I'm unable to study the magnetic properties of the rock involved",Color_Red]				
					];			
				};
				
				case 2: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there are any oil seeps around this area",Color_Red],
						["Prospecting: I just took a soil sample and it looks like it doesn't contain any petroleum residue",Color_Red],
						["Prospecting: It looks like the sound transmission of the land might indicate oil-bearing rocks beneath the surface!",Color_Green],
						["Prospecting: It looks like I found an oil-bearing rock underneath the surface, that might indicate the presence of oil in this area.",Color_Green],
						["Prospecting: It also looks like this oil-bearing rock is magnetic, most rocks that contain oil are non-magnetic",Color_Red]		
					];			
				};
				case 3: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there are any oil seeps around this area",Color_Red],
						["Prospecting: I just took a soil sample and it looks like it doesn't contain any petroleum residue",Color_Red],
						["Prospecting: It looks like the sound transmission of the land might indicate oil-bearing rocks beneath the surface!",Color_Green],
						["Prospecting: It looks like I found an oil-bearing rock underneath the surface, that might indicate the presence of oil in this area.",Color_Green],
						["Prospecting: It also looks like this oil-bearing rock is non-magnetic, most rocks that contain oil are non-magnetic!",Color_Green]				
					];			
				};
				
				case 4: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there are any oil seeps around this area",Color_Red],
						["Prospecting: I just took a soil sample and it looks like it contains petroleum residue, that's a good sign!",Color_Green],
						["Prospecting: It looks like the sound transmission of the land might indicate oil-bearing rocks beneath the surface!",Color_Green],
						["Prospecting: It looks like I found an oil-bearing rock underneath the surface, that might indicate the presence of oil in this area.",Color_Green],
						["Prospecting: It looks like this oil-bearing rock is non-magnetic, most rocks that contain oil are non-magnetic!",Color_Green]				
					];			
				};	
				
				case 5: 
				{
					_prospectArray =
					[
						["Prospecting: There's a few oil seeps around, that is an obvious sign of oil in this area!",Color_Green],
						["Prospecting: I just took a soil sample and it looks like it contains petroleum residue, that's a good sign!",Color_Green],
						["Prospecting: It looks like the sound transmission of the land might indicate oil-bearing rocks beneath the surface!",Color_Green],
						["Prospecting: It looks like I found an oil-bearing rock underneath the surface, that might indicate the presence of oil in this area.",Color_Green],
						["Prospecting: It also looks like this oil-bearing rock is non-magnetic, most rocks that contain oil are non-magnetic!",Color_Green]				
					];			
				};	
			};
		};
		
		case ("iron"):
		{
			switch (_signs) do
			{
				case 0: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like this land is suitable to contain iron ores",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain any mineral content",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates there are iron ores below",Color_Red]
					];
				};
				case 1: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like this land is suitable to contain iron ores",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain any mineral content",Color_Red],
						["Prospecting: It seems like the sound transmission of the land indicates there might be iron ores below",Color_Green]				
					];	
				};
				
				case 2: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like this land is suitable to contain iron ores",Color_Red],
						["Prospecting: I just took a ground sample and it seems to contain mineral content",Color_Green],
						["Prospecting: It seems like the sound transmission of the land indicates there might be iron ores below",Color_Green]	
					];	
				};
				case 3: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like this land might be suitable to contain iron ores",Color_Green],
						["Prospecting: I just took a ground sample and it seems to contain mineral content",Color_Green],
						["Prospecting: It seems like the sound transmission of the land indicates there might be iron ores below",Color_Green]				
					];
				};
			};
		};	

		case ("coal"):
		{
			switch (_signs) do
			{
				case 0: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there is any coal-residue in this area",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain any coal ash",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates coal below the ground",Color_Red]
					];
				};
				case 1: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there is any coal-residue in this area",Color_Red],
						["Prospecting: I just took a ground sample and it seems to contain some coal ash",Color_Green],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates coal below the ground",Color_Red]			
					];			
				};
				
				case 2: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like there is some coal-residue in this area!",Color_Green],
						["Prospecting: I just took a ground sample and it seems to contain some coal ash",Color_Green],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates coal below the ground",Color_Red]		
					];			
				};
				case 3: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like there is some coal-residue in this area!",Color_Green],
						["Prospecting: I just took a ground sample and it seems to contain some coal ash",Color_Green],
						["Prospecting: It looks like the sound transmission of the land indicates coal below the ground!",Color_Green]				
					];			
				};
			};
		};

		case ("titanium"):
		{
			switch (_signs) do
			{
				case 0: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there is any titanium-residue in this area",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain anything that might indicate titanium ores in this area",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates titanium ores below the ground",Color_Red]
					];
				};
				case 1: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there is any titanium-residue in this area",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain anything that might indicate titanium ores in this area",Color_Red],
						["Prospecting: It seems like the sound transmission of the land might indicate titanium ores below the ground!",Color_Green]			
					];			
				};
				
				case 2: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like there is any titanium-residue in this area",Color_Red],
						["Prospecting: I just took a ground sample and it contains somthing that might indicate titanium ores in this area!",Color_Green],
						["Prospecting: It seems like the sound transmission of the land might indicate titanium ores below the ground!",Color_Green]	
					];			
				};
				case 3: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like there is a little bit of titanium-residue in this area!",Color_Green],
						["Prospecting: I just took a ground sample and it contains somthing that might indicate titanium ores in this area!",Color_Green],
						["Prospecting: It seems like the sound transmission of the land might indicate titanium ores below the ground!",Color_Green]					
					];			
				};
			};
		};

		case ("aluminium"):
		{
			switch (_signs) do
			{
				case 0: 
				{
					_prospectArray =
					[
						["Prospecting: It doesn't look like this land is suitable for bauxite ores (didn't find any clay)",Color_Red],
						["Prospecting: I just took a ground sample and it doesn't contain anything that might indicate bauxite ores in this area",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates bauxite ores below the ground",Color_Red]
					];
				};
				case 1: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like this land is suitable for bauxite ores (found some clay!)",Color_Green],
						["Prospecting: I just took a ground sample and it doesn't contain anything that might indicate bauxite ores in this area",Color_Red],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates bauxite ores below the ground",Color_Red]		
					];			
				};
				
				case 2: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like this land is suitable for bauxite ores (found some clay!)",Color_Green],
						["Prospecting: I just took a ground sample and it contains some minerals that might indicate bauxite ores in this area",Color_Green],
						["Prospecting: It doesn't seem like the sound transmission of the land indicates bauxite ores below the ground",Color_Red]		
					];			
				};
				case 3: 
				{
					_prospectArray =
					[
						["Prospecting: It looks like this land is suitable for bauxite ores (found some clay!)",Color_Green],
						["Prospecting: I just took a ground sample and it contains some minerals that might indicate bauxite ores in this area!",Color_Green],
						["Prospecting: It looks like the sound transmission of the land indicates bauxite ores below the ground!",Color_Green]						
					];			
				};
			};
		};	

        case ("sulphur"):
        {
            switch (_signs) do
            {
                case 0:
                {
                    _prospectArray =
                    [
                        ["Prospecting: It doesn't look like there is any sulphur-residue in this area",Color_Red],
                        ["Prospecting: I just took a ground sample and it doesn't contain any sulphur crystals",Color_Red],
                        ["Prospecting: It doesn't seem like the sound transmission of the land indicates sulphur below the ground",Color_Red]
                    ];
                };
                case 1:
                {
                    _prospectArray =
                    [
                        ["Prospecting: It doesn't look like there is any sulphur-residue in this area",Color_Red],
                        ["Prospecting: I just took a ground sample and it seems to contain some sulphur crystals",Color_Green],
                        ["Prospecting: It doesn't seem like the sound transmission of the land indicates sulphur below the ground",Color_Red]          
                    ];         
                };
               
                case 2:
                {
                    _prospectArray =
                    [
                        ["Prospecting: It looks like there is some sulphur-residue in this area!",Color_Green],
                        ["Prospecting: I just took a ground sample and it seems to contain some sulphur crystals",Color_Green],
                        ["Prospecting: It doesn't seem like the sound transmission of the land indicates sulphur below the ground",Color_Red]      
                    ];         
                };
                case 3:
                {
                    _prospectArray =
                    [
                        ["Prospecting: It looks like there is some sulphur-residue in this area!",Color_Green],
                        ["Prospecting: I just took a ground sample and it seems to contain some sulphur crystals",Color_Green],
                        ["Prospecting: It looks like the sound transmission of the land indicates sulphur below the ground!",Color_Green]              
                    ];         
                };
            };
        };		
	};
	
	_canProspect = 0;
	for "_i" from 0 to (count _prospectArray) do
	{
		uiSleep 3.7;
		(_prospectArray select _i) call A3PL_Player_Notification;
		if (!(vehicle player == player)) exitwith {_canProspect = (count _prospectArray) - _i;};
	};
	if (_canProspect > 0) exitwith {_timeOut = _canProspect * 3.7; [format ["System: You entered a vehicle, prospecting is unavailable for %1 seconds",_timeOut],Color_Red] call A3PL_Player_Notification; [_timeOut] spawn {uiSleep (param [0,0]); Player_Prospecting = nil;};};
	Player_Prospecting = nil;
	["Prospecting: I finished prospecting this area",Color_Green] call A3PL_Player_Notification;
	[[player,""],"A3PL_Lib_SyncAnim",true] call BIS_FNC_MP;
	
	_listOres = [];
	{
		_listOres pushback (toLower (_x select 0));
	} foreach Config_Resources_Ores;	
	if ((_signs > 0) && (_prospectFor IN _listOres)) then
	{
		[_prospectFor] call A3PL_JobWildCat_FoundRes;
	};
}] call Server_Setup_Compile;

["A3PL_JobWildCat_FoundRes",
{
	disableSerialization;
	private ["_display","_control","_foundOre"];
	_foundOre = param [0,""];
	createDialog "Dialog_ProspectFound";
	_display = findDisplay 132;
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t size='1' align='center'>You found %1 ore, would you like to mark this location?</t>",_foundOre];
	
	_control = _display displayCtrl 1601;
	_control buttonSetAction format ["closeDialog 0; [player,'%1'] remoteExec ['Server_JobWildCat_SpawnRes', 2];",_foundOre]; //call to server to spawn ore
}] call Server_Setup_Compile;

//this checks if we have oil in the area and returns the location of the middle pointer
["A3PL_JobWildcat_CheckForOil", 
{
	private ["_pos","_oil","_oilLocation"];	
	_pos = param [0,[0,0,0]];
	
	_oil = false;
	//change 50 into lower/higher distance if needed
	{
		 if ((_pos distance (_x select 0)) < OILDISTANCE) exitwith
		 {
			 _oil = true;
			 _oilLocation = _x select 0;
		 };
	} foreach Server_JobWildCat_Oil;
	
	_return = [false,[0,0,0]];
	if (_oil) then
	{
		_return = [true,_oilLocation];
	};
	
	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_CheckForRes", 
{
	private ["_pos","_res","_return","_resType","_resLocation"];	
	_pos = param [0,[0,0,0]];
	_resType = param [1,""];
	
	_res = false;
	//change 50 into lower/higher distance if needed
	{
		 if (((_pos distance (_x select 1)) < RESDISTANCE) && ((_x select 0) == _resType)) exitwith
		 {
			 _res = true;
			 _resLocation = _x select 1;
		 };
	} foreach Server_JobWildCat_Res;
	
	_return = [false,[0,0,0]];
	if (_res) then
	{
		_return = [true,_resLocation];
	};
	
	_return;
}] call Server_Setup_Compile;

//this will return the amount of oil in the specified oil position
["A3PL_JobWildcat_CheckAmountOil", 
{
	private ["_pos","_return"];	
	_pos = param [0,[0,0,0]];
	_return = 0;
	
	{
		 if (((_x select 0) distance2D _pos) < 1) exitwith
		 {
			 _return = _x select 1;
		 };
	} foreach Server_JobWildCat_Oil;
	
	_return;
}] call Server_Setup_Compile;

["A3PL_JobWildcat_CheckAmountRes", 
{
	private ["_pos","_return"];	
	_pos = param [0,[0,0,0]];
	_return = 0;
	
	{
		 if (((_x select 1) distance2D _pos) < 1) exitwith
		 {
			 _return = _x select 2;
		 };
	} foreach Server_JobWildCat_Res;
	
	_return;
}] call Server_Setup_Compile;

//drilling script
["A3PL_JobWildcat_Drill", 
{
	private ["_s","_pump","_drilling","_a"];
	_pump = param [0,objNull];
	
	//check the pin position
	if ((_pump animationPhase "Pin") > 0) exitwith
	{
		["System: You can't use the drill when the vehicle is still hitched, please unhitch it first",Color_Red] call A3PL_Player_Notification;
	};	
	
	//first check the drill_arm_position
	if ((_pump animationSourcePhase "drill_arm_position") != 1) exitwith {["System: It looks like the arm position of the drill is not extended",Color_Red] call A3PL_Player_Notification;};
	
	//check if the drill is already extending
	_a = _pump animationSourcePhase "drill";
	uisleep 0.2;
	if (_a != _pump animationSourcePhase "drill") exitwith {["System: It looks like the drill is already moving, it cannot be started again",Color_Red] call A3PL_Player_Notification;};
	
	//Secondly lets check if the drill is already extended
	if (_pump animationSourcePhase "drill" > 0) exitwith {_pump animateSource ["drill",0]; ["System: It looks like the drill is extended, it's being retracted back to it's original position",Color_Red] call A3PL_Player_Notification;};

	//lets start drilling
	["System: Drilling started, a hole will appear in the ground, someone with the oil recovery job can then place a pump jack on the hole",Color_Green] call A3PL_Player_Notification;
	_drilling = true;
	_pump animateSource ["drill",1];
	_s = false; //succeed
	_pos = getpos _pump;
	while {_drilling} do
	{
		if ((_pos distance (getpos _pump)) > 1) exitwith {_pump animateSource ["drill",0,true]; ["System: Drilling cancelled, the pump jack has been moved, the drill is moved back to its original position",Color_Red] call A3PL_Player_Notification;};	
		if (_pump animationSourcePhase "drill" == 1) exitwith {_s = true};
		if (isNull _pump) exitwith {};
		uiSleep 1;
	};
	
	if (_s) then
	{
		["System: A hole has been succesfully created at this position, someone can now install a pump jack on this position",Color_Green] call A3PL_Player_Notification;
		
		//spawn a drilling hole at specified modelToWorld position
		_hole = createVehicle ["A3PL_Drillhole",_pump modelToWorld [0,-1.8,-1.1], [], 0, "CAN_COLLIDE"]; //[0,-1.1,0]
	} else
	{
		["System: Drilling cancelled, did you move the drill or was the drill impounded?",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;