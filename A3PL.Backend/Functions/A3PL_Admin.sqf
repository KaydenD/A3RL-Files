["A3PL_Admin_Check",
{
	_adminLevel = [
		["Executive","findDisplay 2583;", "dialog_ExecutiveMenu"],
		["Chief","", ""],
		["Developer","", ""]
	];

	pVar_AdminMenuGranted = false;
	pVar_AdminTwitter = false;

	player setVariable ["pVar_RedNameOn",false,true];
	pVar_MapTeleportReady = false;
	pVar_MapPlayerMarkersOn = false;
	pVar_FastAnimationOn = false;
	pVar_FiresFrozen = false;

	//In the fn_preinit.sqf file, players are assigned variables, and we can call those variables when needed. Just like below. If we can't find the variable, we get an empty array, from index 1.
	pVar_AdminLevel = player getVariable ["dbVar_AdminLevel",0];
	if (pVar_AdminLevel == 0) exitwith {};
	pVar_CursorTargetEnabled = false;
	pVar_AdminTwitter = true;
	pVar_AdminMenuGranted = true;
	showChat true;

}] call Server_Setup_Compile;

["A3PL_AdminOpen", {

	disableSerialization;

	if(isNull (findDisplay 98)) exitWith {
		createDialog "Dialog_ExecutiveMenu";

		// Pre-Call Server Variables //

		[] remoteExec ["Server_Fire_PauseCheck",2];

		// Player Buttons //

		buttonSetAction [1600, "[] call A3PL_AdminAddToPlayer"];
		buttonSetAction [1601, "[] call A3PL_AdminAddToFactory"];
		buttonSetAction [1602, "[] call A3PL_AdminCreateOnPlayer"];
		buttonSetAction [1603, "[] call A3PL_Admin_RestartSoon"];
		buttonSetAction [1606, "[] call A3PL_AdminHealPlayer"];
		buttonSetAction [1607, "[] call A3PL_AdminTeleportTo"];
		buttonSetAction [1608, "[] call A3PL_AdminTeleportToMe"];
		

		// Messaging Buttons //

		buttonSetAction [1609, "[] call A3PL_AdminGlobalMessage"];
		buttonSetAction [1610, "[] call A3PL_AdminAdminMessage"];
		buttonSetAction [1611, "[] call A3PL_AdminDirectMessage"];

		// Search Buttons //

		buttonSetAction [1612, "[] call A3PL_AdminSearchFactoryList"];
		buttonSetAction [1613, "[] call A3PL_AdminSearchPlayerList"];

		// Lists //

		[] call A3PL_AdminPlayerList;
		[] call A3PL_AdminPlayerInfoList;
		[] call A3PL_AdminFactoryComboList;
		[] call A3PL_Admin_InventoryCombo;
		[] call A3PL_AdminToolsList;
		[] call A3PL_AdminTwitterTagsList;
		[] call A3PL_AdminFactionList;

		// Default Text //

		ctrlSetText [1403, "1"];
		ctrlSetText [1000, format ["%2 %1",player getVariable "name", [player] call A3PL_AdminGetRank]];
		ctrlSetText [1001, "Version: 1.0"];
	};

	if (!IsNull (findDisplay 98)) exitWith {
		(findDisplay 98) closeDisplay 1;
	};
}] call Server_Setup_Compile;

////////////////////
//  LOAD ON OPEN  //
////////////////////

["A3PL_AdminPlayerList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 1500;
	_id = lbCurSel 1500;

	A3PL_Admin_PlayerList = [];
	{
		lbAdd [1500, format ["%1 (%2)",_x getVariable ["name","Undefined"],name _x]];
		if ((_x getVariable ["adminWatch",0]) == 1) then {
			lbSetColor [1500,_forEachIndex,[1,0,0,1]];
		};
		A3PL_Admin_PlayerList pushBack _x;
	} foreach allPlayers;

	_control ctrlAddEventHandler ["LBSelChanged","[] call A3PL_AdminPlayerInfoList;"];
	_control ctrlAddEventHandler ["LBDblClick","[] call A3PL_AdminWatch;"];
	_control lbSetCurSel 0;
}] call Server_Setup_Compile;

["A3PL_AdminPlayerInfoList", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 1500;
	_control = _display displayCtrl 1503;
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);

	_startingText = ["Name:","Cash:","Bank:","Faction:"];
	_followingTextVar = [["name",0],["Player_Cash",1],["Player_Bank",1],["faction",0],["Cuffed",0]];
	_playerInfoArray = [_playerName,_playerCash,_playerBank,_playerFaction];

	lbClear 1503;
	{
		if (((_followingTextVar select _forEachIndex) select 1) == 0) then {
			lbAdd [1503, format ["%1 %2", _startingText select _forEachIndex,_selectedPlayer getVariable [((_followingTextVar select _forEachIndex) select 0),"Undefined"]]];
		} else {
			lbAdd [1503, format ["%1 %2", _startingText select _forEachIndex,(_selectedPlayer getVariable [((_followingTextVar select _forEachIndex) select 0),"Undefined"]) call CBA_fnc_formatNumber]];
		};
	} forEach _playerInfoArray;

	_selectedInventory = _display displayCtrl 2101;
	_selectedInventory ctrlAddEventHandler ["LBSelChanged","[] call A3PL_AdminPlayerInfoList;"];
}] call Server_Setup_Compile;

["A3PL_Admin_PlayerInventoryFill", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 2101;
	_selectedPlayerIndex = lbCurSel 1500;
	_selectedInventory = lbText [2101,lbCurSel 2101];
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedPlayerIndex);
	_playerInventories = _selectedPlayer getVariable "player_fstorage";
	_index = 999;

	if (_selectedInventory == "Player") then {
		lbClear 1502;
		{
			lbAdd [1502,format ["%1 (%2)",_x select 0,str (_x select 1)]];
		} forEach (_selectedPlayer getVariable ["player_inventory",[]]);
	} else {
		{
			_checking = _x select 0;
			if (_checking == _selectedInventory) then {
				_index = _forEachIndex;
			};
		} forEach _playerInventories;

		lbClear 1502;

		if (_index == 999) exitWith {lbAdd [1502,"No Inventory"]};

		_toLoadInventory = (_playerInventories select _index) select 1;
		{
				lbAdd [1502,format ["%1 (%2)",_x select 0,_x select 1]];
		} forEach _toLoadInventory;
	};
}] call Server_Setup_Compile;

["A3PL_AdminFactoryComboList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 2100;

	{
	 	lbAdd [2100,_x select 0];
	} foreach Config_Factories;
	{
		lbAdd [2100,_x];
	} foreach ["Objects", "AdminVehicles"];

	_control ctrlAddEventHandler ["lbSelChanged",{[] call A3PL_AdminFillFactoryList;}];
}] call Server_Setup_Compile;

["A3PL_Admin_InventoryCombo", {
	_display = findDisplay 98;
	_selectedInventory = _display displayCtrl 2101;
	_inventories = ["Player","Chemical Plant","Steel Mill","Oil Refinery","Illegal Weapon Factory","Legal Weapon Factory","Black Market Trader","Food Processing plant","Goods Factory","Clothing Factory","Car Parts Factory","Vehicle Factory","Marine Factory","Aircraft Factory"];

	{
		lbAdd [2101,_x];
	} foreach _inventories;

	_selectedInventory ctrlAddEventHandler ["lbSelChanged","[] call A3PL_Admin_PlayerInventoryFill;"];
}] call Server_Setup_Compile;

["A3PL_Admin_TwitterTag", {
	_display = findDisplay 98;
	_selectedTag = lbText [2102,lbCurSel 2102];

	switch(_selectedTag) do 
	{
		case "Director": 
		{
			player setVariable ["twitterprofile", ["\A3PL_Common\icons\director.paa","#ffff00","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202","Citizen"]],[["#B5B5B5","Default"]]], true];
		};
		case "Sub-Director": 
		{
			player setVariable ["twitterprofile", ["\A3PL_Common\icons\subdirector.paa","#ed8a18","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202","Citizen"]],[["#B5B5B5","Default"]]], true];
		};
		case "Lead Chief": 
		{ 
			player setvariable ["twitterprofile",["\A3PL_Common\icons\leadchief.paa","#2f95c6","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"],["\A3PL_Common\icons\executive.paa","Exec Tag"],["\A3PL_Common\icons\chief.paa","Chief"],["\A3PL_Common\icons\leadchief.paa","Lead Chief"]],[["#ed7202","Citizen"],["#84329F","Executive"],["#2f95c6","Chief"],["#2f7ec6","Lead Chief"]],[["#B5B5B5","Default"]]],true];
		};
		case "Chief": 
		{ 
			player setVariable ["twitterprofile", ["\A3PL_Common\icons\chief.paa","#00bfff","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202`,`Citizen"]],[["#B5B5B5","Default"]]],true];
		};
		case "Developer":
		{
			player setVariable ["twitterprofile", ["\A3PL_Common\icons\creator.paa","#75716c","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202`,`Citizen"]],[["#B5B5B5","Default"]]],true];
		};
		case "Executive Supervisor": 
		{
			player setvariable ["twitterprofile",["\A3PL_Common\icons\exec_supervisor.paa","#77bcff","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"],["\A3PL_Common\icons\exec_supervisor.paa","Exec Sup"]],[["#ed7202","Citizen"],["#77bcff","Exec Sup"]],[["#B5B5B5","Default"]]],true];
		};
		case "Executive": 
		{ 
			player setvariable ["twitterprofile",["\A3PL_Common\icons\executive.paa","#8833a4","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"],["\A3PL_Common\icons\executive.paa","Executive"]],[["#ed7202","Citizen"],["#8833a4","Executive"]],[["#B5B5B5","Default"]]],true];
		};
		case "Citizen": 
		{ 
			player setVariable ["twitterprofile", ["\A3PL_Common\icons\citizen.paa","#ed7202","#B5B5B5",[["\A3PL_Common\icons\citizen.paa","Citizen Tag"]],[["#ed7202","Citizen"]],[["#B5B5B5","Default"]]],true];
		};
	};
}] call Server_Setup_Compile;

["A3PL_AdminTwitterTagsList", {
	_display = findDisplay 98;
	_selectedTag = _display displayCtrl 2102;
	_tags = ["Director", "Sub-Director", "Lead Chief", "Chief", "Developer", "Executive Supervisor", "Executive", "Citizen"];

	{
		lbAdd [2102,_x];
	} foreach _tags;

	_selectedTag ctrlAddEventHandler ["lbSelChanged","[] call A3PL_Admin_TwitterTag;"];
}] call Server_Setup_Compile;

["A3PL_Admin_FactionSetter", {
	if ((player getVariable "dbVar_AdminLevel") >= 3) then {
		_display = findDisplay 98;
		_selectedPlayerIndex = lbCurSel 1500;
		_selectedFaction = lbText [2103,lbCurSel 2103];
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedPlayerIndex);

		switch(_selectedFaction) do
		{
			case "Sheriff Department": 
			{ 
				_selectedPlayer setVariable ["faction","police",true];
				_selectedPlayer setVariable ["job","police",true];
			};
			case "United States Coast Guard": 
			{ 
				_selectedPlayer setVariable ["faction","uscg",true];
				_selectedPlayer setVariable ["job","uscg",true];
			};
			case "Fire and Rescue": 
			{ 
				_selectedPlayer setVariable ["faction","fifr",true];
				_selectedPlayer setVariable ["job","fifr",true];
			};
			case "Department of Justice": 
			{ 
				_selectedPlayer setVariable ["faction","doj",true];
				_selectedPlayer setVariable ["job","doj",true];
			};
			case "Marshal Service": 
			{ 
				_selectedPlayer setVariable ["faction","usms",true];
				_selectedPlayer setVariable ["job","usms",true];
			};
			case "Civilian": 
			{
				_selectedPlayer setVariable ["faction","unemployed",true];
				_selectedPlayer setVariable ["job","unemployed",true];
			};
		};
	} else {
		["You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminFactionList", {
	_display = findDisplay 98;
	_selectedFaction = _display displayCtrl 2103;
	_factions = ["Sheriff Department", "United States Coast Guard", "Fire and Rescue", "Department of Justice", "Marshal Service", "Civilian"];

	{
		lbAdd [2103,_x];
	} foreach _factions;

	_selectedFaction ctrlAddEventHandler ["lbSelChanged","[] call A3PL_Admin_FactionSetter;"];
}] call Server_Setup_Compile;

["A3PL_AdminToolsList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 1504;
	
	dVar_AdminToolsList = [
		["Teleport",pVar_MapTeleportReady,A3PL_AdminMapTeleport],
		["Toggle Twitter",false,A3PL_AdminTwitterToggle],
		["Fix Garage",false,A3PL_Admin_FixGarage],
		["Admin Mode",player getVariable ["pVar_RedNameOn",false],A3PL_AdminRedName],
		["Create Fire",false,A3PL_Admin_CreateFire],
		["Pause Fire",pVar_FiresFrozen,A3PL_Admin_PauseFire],
		["Remove Fire",false,A3PL_Admin_RemoveFire],
		["Fast Animation",pVar_FastAnimationOn,A3PL_AdminFastAnimation],
		["Self Heal",false,A3PL_AdminSelfHeal],
		["Self Feed",false,A3PL_AdminSelfFeed],
		
		["Invisible",false,A3PL_Admin_Invisible],
		["Map Player Markers",pVar_MapPlayerMarkersOn,A3PL_AdminMapMarkers],
		["Map Resource Markers",pVar_MapResourceMarkersOn,A3PL_AdminMapResourceMarkers],
		// LEVEL 3 //
		["Virtual Arsenal",false,A3PL_Admin_VirtualArsenal]
	];

	{
		_toolName = _x select 0;
		_toolColor = _x select 1;
		_skip = ["Freeze Fire"];
		lbAdd [1504,_x select 0];
		if ((_skip find _toolName) == -1) then {
			if (_toolColor) then {
				lbSetColor [1504, _forEachIndex, [1,.8,0,1]];
			};
		};
	} foreach dVar_AdminToolsList;

	if ((player getVariable ["dbVar_AdminLevel",0]) < 3) then {
		lbDelete [1504,11];
	};

	_control ctrlAddEventHandler ["LBDblClick","[] call A3PL_SelectedAdminTool;"];
}] call Server_Setup_Compile;

////////////////////////////
//  NON-BUTTON FUNCTIONS  //
////////////////////////////

["A3PL_SelectedAdminTool", {
	_selectedIndex = lbCurSel 1504;
	_selectedTool = ((dVar_AdminToolsList select _selectedIndex) select 0);

	switch (_selectedTool) do {
		case "Teleport": {[] call A3PL_AdminMapTeleport};
		case "Toggle Twitter": {[] call A3PL_AdminTwitterToggle};
		case "Fix Garage": {[] call A3PL_Admin_FixGarage};
		case "Admin Mode": {[] call A3PL_AdminRedName};
		case "Create Fire": {[] call A3PL_Admin_CreateFire};
		case "Freeze Fire": {[] call A3PL_Admin_PauseFire};
		case "Remove Fire": {[] call A3PL_Admin_RemoveFire};
		case "Fast Animation": {[] call A3PL_AdminFastAnimation};
		case "Self Heal": {[] call A3PL_AdminSelfHeal};
		case "Self Feed": {[] call A3PL_AdminSelfFeed};
		case "Invisible": {[] call A3PL_Admin_Invisible};
		case "Map Player Markers": {[] call A3PL_AdminMapMarkers};
		case "Map Resource Markers": {[] call A3PL_AdminMapResourceMarkers};
		case "Virtual Arsenal": {[] call A3PL_Admin_VirtualArsenal};
	};
}] call Server_Setup_Compile;

["A3PL_Admin_Invisible", {
	if ((player getVariable "dbVar_AdminLevel") >= 3) then {
		if(player getVariable ["admin_invisible",false]) then {
			[player,false] remoteExec ["A3PL_Lib_HideObject", 2];
			player setVariable ["admin_invisible",false,true];
			lbSetColor [1504, 0, [1,1,1,1]];
		} else {
			[player,true] remoteExec ["A3PL_Lib_HideObject", 2];
			player setVariable ["admin_invisible",true,true];
			lbSetColor [1504, 0, [1,.8,0,1]];
		};
	} else {
		["System: You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_RestartSoon", {
	if ((player getVariable "dbVar_AdminLevel") >= 5) then {
		[] remoteExec ["Server_Core_Restart",2];
	} else {
		["System: You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_VirtualArsenal", {
	if ((player getVariable "dbVar_AdminLevel") >= 3) then {
		closeDialog 0;
		["Open",true] spawn BIS_fnc_arsenal;
	} else {
		["System: You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_Admin_FixGarage", {
	if (player_objIntersect getVariable ["inUse",false]) then {
		player_objIntersect setVariable ["inUse",false,true];
	};
}] call Server_Setup_Compile;

["A3PL_AdminWatch", {
	_display = findDisplay 98;
	_selectedIndex = lbCurSel 1500;
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
	_uid = getPlayerUID _selectedPlayer;
	_name = _selectedPlayer getVariable "name";
	_adminWatch = _selectedPlayer getVariable ["adminWatch",0];

	if (_adminWatch == 0) then {
		_selectedPlayer setVariable ["adminWatch",1,true];
		lbSetColor [1500,_selectedIndex,[1,0,0,1]];
		systemChat format ["%1 added to watch list!",_name];
		//[1,_uid] remoteExec ["Server_UpdateAdminWatch",2];
	} else {
		_selectedPlayer setVariable ["adminWatch",0,true];
		lbSetColor [1500,_selectedIndex,[1,1,1,1]];
		systemChat format ["%1 removed from watch list!",_name];
		//[0,_uid] remoteExec ["Server_UpdateAdminWatch",2];
	};
}] call Server_Setup_Compile;

["A3PL_AdminFillFactoryList", {
	_display = findDisplay 98;
	_control = _display displayCtrl 2100;
	_selectedFactory = _control lbText (lbCurSel _control);


	_control = _display displayCtrl 1501;
	lbClear _control;

	if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {

		if (_selectedFactory == "AdminVehicles") exitWith {
			{
				_first_X = _x;
				{
					_class = format ["%1_%2",(_first_X select 0),_x];
					_i = lbAdd [1501,_class];
					lbSetData [1501,_i,_class];
				} foreach (_x select 1);
			} forEach Config_Shops_VehicleColours;
		};

		if (_selectedFactory == "Objects") exitWith {
			{
				_class = _x;
				_i = lbAdd [1501,_class];
				lbSetData [1501,_i,_class];
			} forEach ["Land_A3PL_EstateSign","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F","BlockConcrete_F"];
		};

	} else {
		_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
		{
			_id = _x select 0;
			_name = _x select 2;
			_itemClass = _x select 4;
			_itemType = _x select 5;
			if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
			_i = lbAdd [1501,_name];
			lbSetData [1501,_i,_id];
		} forEach _recipes;
	};

	_control ctrlAddEventHandler ["lbSelChanged",{_selectedAsset = lbData [1501,(lbCurSel 1501)]; hint format ["%1",_selectedAsset]}];
}] call Server_Setup_Compile;

// Cursor Target Menu //

["A3PL_AdminCursorTarget", {

	("Dialog_HUD_AdminCursor" call BIS_fnc_rscLayer) cutRsc ["Dialog_HUD_AdminCursor", "PLAIN"];
	pVar_CursorTargetEnabled = true;
	//[player,"cursortarget",[format ["Start Cursortargeting"]]] remoteExec ["Server_AdminLoginsert", 2];
	((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 2414) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='left' size='0.85'>Numpad 0: Get in Driver cursortarget<br/>Numpad 1: Attach Cursor<br/>Numpad 2: Detach Cursor<br/>Numpad 3: Impound Cursor<br/>Numpad 4: Delete Cursor<br/>Numpad 5: Move in Cursor<br/>Numpad 6: Eject all Cursor<br/>Numpad 7: Heal Cursortarget<br/>Numpad 8: Repair Cursortarget</t>"]);

	while {pVar_CursorTargetEnabled} do {
	((uiNamespace getVariable "Dialog_HUD_AdminCursor") displayCtrl 1000) ctrlSetStructuredText (parseText format["<t font='PuristaSemiBold' align='center' size='1'>Cursor: %1</t>",(name player_objintersect)]);
	};

	("Dialog_HUD_AdminCursor" call BIS_fnc_rscLayer) cutFadeOut 1;
}] call Server_Setup_Compile;

["A3PL_Admin_AttachTo", {
	params[["_veh",objNull,[objNull]]];

	_dir = getDir _veh;
	_veh attachTo [player];
	_veh setDir (_dir + (360 - (getDir player)));

	//if(!isNull _veh) then {
	//		[player,"cursortarget",[format ["Detach: %1",_veh]]] remoteExec ["Server_AdminLoginsert", 2];
	//};
}] call Server_Setup_Compile;

["A3PL_Admin_DetachAll", {
	{
		detach _x;
	} forEach attachedObjects player;
	//[player,"cursortarget",[format ["Detached everything"]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

///////////////////////////////
//  SEARCH BUTTON FUNCTIONS  //
///////////////////////////////

["A3PL_AdminSearchPlayerList", {
	_display = findDisplay 98;
	_text = ctrlText 1400;

	if (_text == "") then {
		lbClear 1500;
		adminPlayerList = [];
		{
			lbAdd [1500, format ["%1 (%2)",_x getVariable ["name","Undefined"],name _x]];
			if ((_x getVariable ["adminWatch",0]) == 1) then {
				lbSetColor [1500,_forEachIndex,[1,0,0,1]];
			};
			adminPlayerList pushback _x;
		} forEach allPlayers;
	} else {
		lbClear 1500;
		adminPlayerList = [];
		{
			_name = format ["%1 (%2)",_x getVariable ["name","Undefined"],name _x];
			if ((_name find _text) != -1) then {
				lbAdd [1500, _name];
				if ((_x getVariable ["adminWatch",0]) == 1) then {
					lbSetColor [1500,_forEachIndex,[1,0,0,1]];
				};
				adminPlayerList pushback _x;
			};
		} forEach allPlayers;
	};
}] call Server_Setup_Compile;

["A3PL_AdminSearchFactoryList", {
	_display = findDisplay 98;
	_text = ctrlText 1401;
	_control = _display displayCtrl 2100;
	_selectedFactory = _control lbText (lbCurSel _control);

	if (_text == "") then {
		_control = _display displayCtrl 1501;
		lbClear _control;

		if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {
			if (_selectedFactory == "Objects") exitWith {
				{
					_class = _x;
					_i = lbAdd [1501,_class];
					lbSetData [1501,_i,_class];
				} foreach ["Land_A3PL_EstateSign","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F","BlockConcrete_F"];
			};

			if (_selectedFactory == "AdminVehicles") exitWith {
				{
					_first_X = _x;
					{
						_class = format ["%1_%2",(_first_X select 0),_x];
						_i = lbAdd [1501,_class];
						lbSetData [1501,_i,_class];
					} foreach (_x select 1);
				} foreach Config_Shops_VehicleColours;
			};
		} else {
			_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
			{
				_id = _x select 0;
				_name = _x select 2;
				_itemClass = _x select 4;
				_itemType = _x select 5;
				if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
				_index = _control lbAdd _name;
				_control lbSetData [_index,_id];
			} foreach _recipes;
		};
	} else {
		_control = _display displayCtrl 1501;
		lbClear _control;

		if (_selectedFactory == "Objects" || _selectedFactory == "AdminVehicles") then {
			if (_selectedFactory == "Objects") exitWith {
				{
					_name = _x;
					if ((_name find _text) != -1) then {
						_class = _x;
						_i = lbAdd [1501,_class];
						lbSetData [1501,_i,_class];
					};
				} foreach ["Land_A3PL_EstateSign","Land_A3PL_FireHydrant","Land_PortableLight_double_F","Land_Device_slingloadable_F","PortableHelipadLight_01_yellow_F","Land_Pipes_large_F","Land_Tribune_F","Land_RampConcrete_F","Land_Crash_barrier_F","Land_GH_Stairs_F","RoadCone_L_F","RoadBarrier_F","RoadBarrier_small_F","Land_Razorwire_F","BlockConcrete_F"];
			};

			if (_selectedFactory == "AdminVehicles") exitWith {
				{
					_first_X = _x;
					{
						_name = _x;
						if ((_name find _text) != -1) then {
							_class = format ["%1_%2",(_first_X select 0),_x];
							_i = lbAdd [1501,_class];
							lbSetData [1501,_i,_class];
						};
					} foreach (_x select 1);
				} foreach Config_Shops_VehicleColours;
			};
		} else {
			_recipes = ["all",_selectedFactory] call A3PL_Config_GetFactory;
			{
				private ["_name","_itemType","_itemClass","_index"];
				_id = _x select 0;
				_name = _x select 2;
				_itemClass = _x select 4;
				_itemType = _x select 5;
				if (_name == "inh") then {_name = [_itemClass,_itemType,"name"] call A3PL_Factory_Inheritance;};
				if ((_name find _text) != -1) then {
					_index = _control lbAdd _name;
					_control lbSetData [_index,_id];
				};
			} foreach _recipes;
		};
	};
}] call Server_Setup_Compile;

["A3PL_AdminGetRank", {
	private ["_return"];
	_player = param[0];
	
	_level = _player getVariable "dbVar_AdminLevel";
	_return = "";
	
	switch(_level) do {
		case 1: { _return = "Executive" };
		case 2: { _return = "Executive Supervisor" };
		case 3: { _return = "Developer" };
		case 4: { _return = "Chief" };
		case 5: { _return = "Lead Chief" };
		case 6: { _return = "Sub-Director" };
		case 7: { _return = "Director" };
	};
	
	_return;
}] call Server_Setup_Compile;

///////////////////////////////
//  PLAYER BUTTON FUNCTIONS  //
///////////////////////////////

["A3PL_AdminCreateOnPlayer", {
	_selectedList = lbCurSel 2100;
	_selectedListText = lbText [2100,_selectedList];

	if (_selectedListText == "Objects") exitWith {
		_selectedIndex = lbCurSel 1500;
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
		_selectedObject = lbCurSel 1501;
		_objectClass = lbData [1501, _selectedObject];
		_playerPos = getPos _selectedPlayer;

		_obj = createvehicle [_objectClass,_playerPos, [], 0, "CAN_COLLIDE"];
		[player,"objects",[format ["Object Spawn: %1 AT %2",_objectClass,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
	};

	if (_selectedListText == "AdminVehicles") exitWith {
		_selectedIndex = lbCurSel 1500;
		_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);
		_selectedObject = lbCurSel 1501;
		_objectClass = lbData [1501, _selectedObject];
		_playerPos = getPos _selectedPlayer;

		[[_objectClass,_playerPos,"ADMIN",player], "Server_Vehicle_Spawn", false, false] call BIS_fnc_MP;
		[player,"vehicles",[format ["VehicleSpawn: %1 AT %2",_objectClass,_playerPos]]] remoteExec ["Server_AdminLoginsert", 2];
	};
}] call Server_Setup_Compile;

["A3PL_AdminAddToFactory", {

	private ["_isFactory","_itemType"];

	_display = findDisplay 98;

	//_control = _display displayCtrl 2101;
	_selectedFactory = lbText [2100,(lbCurSel 2100)];
	if (_selectedFactory == "") exitwith {["System: No factory selected!",Color_Red] call A3PL_Player_Notification;};
	_selectedAsset = lbData [1501,(lbCurSel 1501)];

	if (lbCurSel 1501 < 0) exitwith {["System: No asset selected!",Color_Red] call A3PL_Player_Notification;};
	_selectedPlayer = A3PL_Admin_PlayerList select (lbCurSel 1500);

	_control = _display displayCtrl 1403;
	_amount = parseNumber (ctrlText _control);
	if (_amount < 1) exitwith {["System: Invalid amount!",Color_Red] call A3PL_Player_Notification;};

	_isFactory = _selectedAsset splitString "_";
	if ((_isFactory select 0) == "f") then {_isFactory = true; _itemType = [_selectedAsset,_selectedFactory,"type"] call A3PL_Config_GetFactory;} else {_isFactory = false;};
	if (isNil "_itemType") then {_itemType = ""};
	if (_isFactory && (_itemType == "item")) then {_selectedAsset = [_selectedAsset,_selectedFactory,"class"] call A3PL_Config_GetFactory;};

	[_selectedPlayer,_selectedFactory,[_selectedAsset,_amount],false] remoteExec ["Server_Factory_Add", 2];
	["Added to Factory!",Color_Green] call A3PL_Player_Notification;

	[player,"factories",[format ["AddFactory: %5 %1(s) ADDED TO %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory,_amount]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminAddToPlayer", {
	private ["_display","_control","_type","_player","_recipe"];
	_display = findDisplay 98;

	_selectedFactory = lbText [2100,(lbCurSel 2100)];
	if (_selectedFactory == "") exitwith {["System: No factory selected!",Color_Red] call A3PL_Player_Notification;};
	_selectedAsset = lbData [1501,(lbCurSel 1501)];

	if (lbCurSel 1501 < 0) exitwith {["System: No asset selected!",Color_Red] call A3PL_Player_Notification;};
	_selectedPlayer = A3PL_Admin_PlayerList select (lbCurSel 1500);

	_control = _display displayCtrl 1403;
	_amount = parseNumber (ctrlText _control);
	if (_amount < 1) exitwith {["System: Invalid amount!",Color_Red] call A3PL_Player_Notification;};

	[_selectedPlayer,[_selectedAsset,_amount],_selectedFactory] remoteExec ["Server_Factory_Create", 2];
	[localize "STR_ADMIN_CREATEI",Color_Green] call A3PL_Player_Notification;

	[player,"factories",[format ["RecipeCreated: %1 CREATED FOR %2(%3) (%4)",_selectedAsset,_selectedPlayer getVariable ["name","Undefined"],(getPlayerUID _selectedPlayer),_selectedFactory]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminHealPlayer", {
	_selectedIndex = lbCurSel 1500;
	_target = (A3PL_Admin_PlayerList select _selectedIndex);

	_target setVariable ["A3PL_Medical_Alive",true,true];
	_target setVariable ["A3PL_Wounds",[],true];
	_target setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
}] call Server_Setup_Compile;

["A3PL_AdminFreeze", {
	_selectedIndex = lbCurSel 1500;
	_selectedPlayer = (A3PL_Admin_PlayerList select _selectedIndex);

	_userInputAllowed = [] remoteExec ["A3PL_Admin_UserInputCheck",_selectedPlayer];

	hint _userInputAllowed;
}] call Server_Setup_Compile;

["A3PL_Admin_UserInputCheck", {
	hint "Fuck you";

	_return = userInputDisabled;

	if (userInputDisabled) then {
		disableUserInput true;
	} else {
		disableUserInput false;
	};

	_return;
}] call Server_Setup_Compile;

//////////////////////////////
//  ADMIN BUTTON FUNCTIONS  //
//////////////////////////////

["A3PL_AdminRedName", {
	[] call A3PL_AdminSelfFeed;
	if (player getVariable ["pVar_RedNameOn",false]) then {
		player setVariable ["pVar_RedNameOn",false,true];
		lbSetColor [1504, 0, [1,1,1,1]];
	} else {
		player setVariable ["pVar_RedNameOn",true,true];
		player setVariable ["A3PL_Wounds",[],true];
		player setVariable ["A3PL_MedicalVars",[5000],true];
		lbSetColor [1504, 0, [1,.8,0,1]];
	};
}] call Server_Setup_Compile;

["A3PL_AdminFastAnimation", {
	if (pVar_FastAnimationOn) then {
		player setAnimSpeedCoef 1;
		pVar_FastAnimationOn = false;
		lbSetColor [1504, 3, [1,1,1,1]];
	} else {
		player setAnimSpeedCoef 2.5;
		pVar_FastAnimationOn = true;
		lbSetColor [1504, 3, [1,.8,0,1]];
	};
}] call Server_Setup_Compile;

["A3PL_AdminSelfHeal", {
	player setVariable ["A3PL_Medical_Alive",true,true];
	player setVariable ["A3PL_Wounds",[],true];
	player setVariable ["A3PL_MedicalVars",[5000,"120/80",37],true];
}] call Server_Setup_Compile;

["A3PL_AdminSelfFeed", {
	player_hunger = 100;
	player_thirst = 100;
}] call Server_Setup_Compile;

["A3PL_AdminTwitterToggle", {
	if(pVar_AdminTwitter) then
	{
		pVar_AdminTwitter = false;
		[player,"twitter",[pVar_AdminTwitter]] remoteExec ["Server_AdminLoginsert", 2];
		[localize "STR_ADMIN_TWITTEROFF",Color_Green] call A3PL_Player_Notification;
	} else
	{
		pVar_AdminTwitter = true;
		[player,"twitter",[pVar_AdminTwitter]] remoteExec ["Server_AdminLoginsert", 2];
		[localize "STR_ADMIN_TWITTERON",Color_Green] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

// Teleporting //

["A3PL_AdminTeleportTo", {
	_display = findDisplay 98; if(isNull _display) exitWith {};
	_id = lbCurSel 1500;

	if(_id < 0) exitWith {};
	_target = (A3PL_Admin_PlayerList select _id);
	player setPos (getPos _target);

	[player,"players",[format ["TeleTo:%1(%2) FROM %3 TO %4",_target getVariable ["name","Undefined"],(getPlayerUID _target),(getPos player),(getPos _target)]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminTeleportToMe", {
	_display = findDisplay 98; if(isNull _display) exitWith {};
	_id = lbCurSel 1500;

	if(_id < 0) exitWith {};
	_target = (A3PL_Admin_PlayerList select _id);
	_target setPos (getPos player);

	[player,"players",[format ["TeleToMe:%1(%2) FROM %3 TO %4",_target getVariable ["name","Undefined"],(getPlayerUID _target),(getPos _target),(getPos player)]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminMapTeleport", {
	closeDialog 0;
	openMap true;
	lbSetColor [1504, 1, [1,.8,0,1]];
	pVar_MapTeleportReady = true;
	onMapSingleClick "_currentPos = getPos player;
	(vehicle player) setpos _pos;
	[player,""mapteleporting"",[format [""MapTeleport: FROM %1 TO %2"",_currentPos,_pos]]] remoteExec [""Server_AdminLoginsert"", 2];
	onMapSingleClick """";
	openMap false;
	lbSetColor [1504, 0, [1,1,1,1]];
	pVar_MapTeleportReady = false;";
}] call Server_Setup_Compile;

// Messaging //

["A3PL_AdminGlobalMessage", {
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_thisAdmin = player getVariable ["name",""];

	if(_message == "") exitWith {["System: Enter a message!", Color_Red] call A3PL_Player_Notification;};
	//_colorselected = [Color_Yellow,Color_White,Color_Red,Color_Green,Color_blue] select (lbCurSel 2100);

	[format["Global Message(%1): %2",_thisAdmin,_message],Color_White] remoteExec ["A3PL_Player_Notification", -2];

	//[player,"globalmessage",[format ["GlobalMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminAdminMessage", {
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_sendTo = [];
	_thisAdmin = player getVariable ["name",""];

	{
		if ((_x getVariable ["dbVar_AdminLevel",0]) > 0) then {
			_sendTo pushBack _x;
		};
	} forEach A3PL_Admin_PlayerList;

	if(_message == "") exitWith {["System: Enter a message!", Color_Red] call A3PL_Player_Notification;};
	//_colorselected = [Color_Yellow,Color_White,Color_Red,Color_Green,Color_blue] select (lbCurSel 2100);

	[format["Admin Message(%1): %2",_thisAdmin,_message],Color_White] remoteExec ["A3PL_Player_Notification", _sendTo];

	//[player,"globalmessage",[format ["GlobalMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

["A3PL_AdminDirectMessage", {
	_display = findDisplay 69;
	_message = ctrlText 1402;
	_selectedIndex = lbCurSel 1500;
	_target = (A3PL_Admin_PlayerList select _selectedIndex);
	_thisAdmin = player getVariable ["name",""];

	if(_message == "") exitWith {["System: Enter a message!", Color_Red] call A3PL_Player_Notification;};
	//_colorselected = [Color_Yellow,Color_White,Color_Red,Color_Green,Color_blue] select (lbCurSel 2100);

	[format["Direct Message(%1): %2",_thisAdmin,_message],Color_White] remoteExec ["A3PL_Player_Notification", _target];

	//[player,"globalmessage",[format ["GlobalMessage: %1",_message]]] remoteExec ["Server_AdminLoginsert", 2];
}] call Server_Setup_Compile;

// Map Markers //

["A3PL_AdminMapMarkers", {
	if ((player getVariable "dbVar_AdminLevel") >= 3) then {
		if(pVar_MapPlayerMarkersOn) then
		{
			pVar_MapPlayerMarkersOn = false;
			A3PL_Admin_MapMarkersEnabled = false;

			lbSetColor [1504, 2, [1,1,1,1]];
		} else {
			pVar_MapPlayerMarkersOn = true;
			lbSetColor [1504, 2, [1,.8,0,1]];
			A3PL_Admin_MapMarkersEnabled = true;
			[] spawn
			{
				_markers = [];
				_playerMarkers = [];
				while {A3PL_Admin_MapMarkersEnabled} do
				{
					sleep 0.5;
					if(visibleMap) then
					{
						//player markers
						{
							_marker = createMarkerLocal [format["%1_marker",_x],visiblePosition _x];
							_marker setMarkerColorLocal "ColorYellow";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerAlphaLocal 0.5;
							_marker setMarkerTextLocal format["(%1) %2", _x getVariable["name","ERROR"], name _x];
							_playerMarkers pushBack [_marker,_x];
						} foreach allPlayers;

						/*if ((player getVariable "dbVar_AdminLevel") == 3) then 
						{
							{
								private ["_pos","_amount","_id"];
								_pos = _x select 0;
								_amount = _x select 1;
								_id = floor (random 5000);
								_marker = createMarkerLocal [format["%1_marker",_id],_pos];
								_marker setMarkerShapeLocal "ELLIPSE";
								_marker setMarkerSizeLocal [100,100]; //same as oildistance defined in A3PL_JobWildCat
								_marker setMarkerColorLocal "ColorBlue";
								_marker setMarkerTypeLocal "Mil_dot";
								_marker setMarkerAlphaLocal 0.5;
								_markers pushBack [_marker];

								_id = floor (random 5000);
								_marker = createMarkerLocal [format["%1_marker",_id],_pos];
								_marker setMarkerShapeLocal "ICON";
								_marker setMarkerColorLocal "ColorBlue";
								_marker setMarkerTypeLocal "Mil_dot";
								_marker setMarkerTextLocal format ["OIL: %1 gallons",([_pos] call A3PL_JobWildcat_CheckAmountOil)];
								_markers pushBack [_marker];
							} foreach (missionNameSpace getVariable ["Server_JobWildCat_Oil",[]]);
							
							{
								private ["_pos","_amount","_id","_name"];
								_pos = _x select 1;
								_name = _x select 0;
								_amount = _x select 2;
								_id = floor (random 5000);
								_marker = createMarkerLocal [format["%1_marker",_id],_pos];
								_marker setMarkerShapeLocal "ELLIPSE";
								_marker setMarkerSizeLocal [100,100]; //same as oildistance defined in A3PL_JobWildCat
								_marker setMarkerColorLocal "ColorYellow";
								_marker setMarkerTypeLocal "Mil_dot";
								_marker setMarkerAlphaLocal 0.85;
								_markers pushBack [_marker];

								_id = floor (random 5000);
								_marker = createMarkerLocal [format["%1_marker",_id],_pos];
								_marker setMarkerShapeLocal "ICON";
								_marker setMarkerColorLocal "ColorYellow";
								_marker setMarkerTypeLocal "Mil_dot";
								_marker setMarkerTextLocal format ["Resource: %1 (%2 left)",_name,_amount];
								_markers pushBack [_marker];
							} foreach (missionNameSpace getVariable ["Server_JobWildCat_Res",[]]);
						} else {
							["System: You don't have permission to view ressources markers",Color_Red] call A3PL_Player_Notification;
						};*/

						while {visibleMap} do
						{
							{
								private["_marker","_unit"];
								_marker = _x select 0;
								_unit = _x select 1;
								if(!isNil "_unit") then
								{
									if(!isNull _unit) then
									{
									    _marker setMarkerPosLocal (visiblePosition _unit);
									};
								};
							} foreach _playerMarkers;
							if(!visibleMap) exitWith {};
							sleep 0.02;
						};

						{deleteMarkerLocal (_x select 0);} foreach _playerMarkers;
						{deleteMarkerLocal (_x select 0);} foreach _markers;
						_playerMarkers = [];
						_markers = [];
					};
				};
			};
		};
		[player,"mapmarkers",[A3PL_Admin_MapMarkersEnabled]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		["You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

["A3PL_AdminMapResourceMarkers", {
	if ((player getVariable "dbVar_AdminLevel") >= 6) then {
		if(pVar_MapResourceMarkersOn) then
		{
			pVar_MapResourceMarkersOn = false;
			A3PL_Admin_MapResourceMarkersEnabled = false;

			lbSetColor [1504, 2, [1,1,1,1]];
		} else {
			pVar_MapResourceMarkersOn = true;
			lbSetColor [1504, 2, [1,.8,0,1]];
			A3PL_Admin_MapResourceMarkersEnabled = true;
			[] spawn
			{
				_markers = [];
				while {A3PL_Admin_MapResourceMarkersEnabled} do
				{
					sleep 0.5;
					if(visibleMap) then
					{
						{
							private ["_pos","_amount","_id"];
							_pos = _x select 0;
							_amount = _x select 1;
							_id = floor (random 5000);
							_marker = createMarkerLocal [format["%1_marker",_id],_pos];
							_marker setMarkerShapeLocal "ELLIPSE";
							_marker setMarkerSizeLocal [100,100]; //same as oildistance defined in A3PL_JobWildCat
							_marker setMarkerColorLocal "ColorBlue";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerAlphaLocal 0.5;
							_markers pushBack [_marker];

							_id = floor (random 5000);
							_marker = createMarkerLocal [format["%1_marker",_id],_pos];
							_marker setMarkerShapeLocal "ICON";
							_marker setMarkerColorLocal "ColorBlue";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerTextLocal format ["OIL: %1 gallons",([_pos] call A3PL_JobWildcat_CheckAmountOil)];
							_markers pushBack [_marker];
						} foreach (missionNameSpace getVariable ["Server_JobWildCat_Oil",[]]);
							
						{
							private ["_pos","_amount","_id","_name"];
							_pos = _x select 1;
							_name = _x select 0;
							_amount = _x select 2;
							_id = floor (random 5000);
							_marker = createMarkerLocal [format["%1_marker",_id],_pos];
							_marker setMarkerShapeLocal "ELLIPSE";
							_marker setMarkerSizeLocal [100,100]; //same as oildistance defined in A3PL_JobWildCat
							_marker setMarkerColorLocal "ColorYellow";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerAlphaLocal 0.85;
							_markers pushBack [_marker];

							_id = floor (random 5000);
							_marker = createMarkerLocal [format["%1_marker",_id],_pos];
							_marker setMarkerShapeLocal "ICON";
							_marker setMarkerColorLocal "ColorYellow";
							_marker setMarkerTypeLocal "Mil_dot";
							_marker setMarkerTextLocal format ["Resource: %1 (%2 left)",_name,_amount];
							_markers pushBack [_marker];
						} foreach (missionNameSpace getVariable ["Server_JobWildCat_Res",[]]);
						{deleteMarkerLocal (_x select 0);} foreach _markers;
						_markers = [];
					};
				};
			};
		};
		[player,"mapresourcemarkers",[A3PL_Admin_MapResourceMarkersEnabled]] remoteExec ["Server_AdminLoginsert", 2];
	} else {
		["You don't have permission to execute this command!",Color_Red] call A3PL_Player_Notification;
	};
}] call Server_Setup_Compile;

// Fire //

["A3PL_Admin_PauseCheckReturn", {

	params ["_looping"];

	if (!_looping) then {
		lbSetColor [1504, 8, [1,.8,0,1]];
	} else {
		lbSetColor [1504, 8, [1,1,1,1]];
	};

	pVar_FiresFrozen = _looping;
}] call Server_Setup_Compile;

["A3PL_Admin_CreateFire", {
	[getpos player] call A3PL_Fire_StartFire;
}] call Server_Setup_Compile;

["A3PL_Admin_PauseFire", {
	if (pVar_FiresFrozen) then {
		lbSetColor [1504, 8, [1,.8,0,1]];
		pVar_FiresFrozen = false;
	} else {
		lbSetColor [1504, 8, [1,1,1,1]];
		pVar_FiresFrozen = true;
	};
	[] call A3PL_Fire_PauseFire;
}] call Server_Setup_Compile;

["A3PL_Admin_RemoveFire", {
	[] call A3PL_Fire_RemoveFires;
}] call Server_Setup_Compile;

/////////////////////////////
//  PLANNED FUNCTIONALITY  //
/////////////////////////////

["A3PL_AdminLogging", {
	params ["_adminName","_playerName","_toolUsed","_actionTaken"];
}] call Server_Setup_Compile;

/////////////////////////
//  NEEDS TO BE ADDED  //
/////////////////////////

["A3PL_Admin_Debug", {
	disableSerialization;
	private ["_display","_control"];
	createDialog "Dialog_AdminDebug";
	_display = findDisplay 82;
	_control = _display displayCtrl 1600;

	_control ctrlAddEventHandler ["buttonDown",
	{
		call compile (ctrlText 1400);
	}];
},false,true] call Server_Setup_Compile;

///////////////////
//  ADMIN DEBUG  //
///////////////////

/*************************
Author: Jon VanderZee
Date: 04/22/2019
File: A3PL_Debug.sqf
*************************/

// Opening Debug //

["A3PL_Debug_Open", {

	if ((player getVariable "dbVar_AdminLevel") < 3) exitWith {};

	disableSerialization;

	createDialog "Dialog_DeveloperDebug";

	[] call A3PL_Debug_DropDownList;
	[] call A3PL_Debug_OnLoadVarCheck;
	[] call A3PL_Debug_VarCheckLoop;

	buttonSetAction [1600, "[] call A3PL_Debug_Execute"];

	(findDisplay 155) displayAddEventHandler ["Unload","[] call A3PL_Debug_OnUnloadVarCheck"];
}] call Server_Setup_Compile;

["A3PL_Debug_DropDownList", {

	private ["_display","_dropDownList"];
	_display = findDisplay 155;
	_dropDownList = [
		"Server Execute",
		"Global Execute",
		"Client Execute",
		"Local Execute"
	];

	{
		lbAdd [2100,_x];
	} forEach _dropDownList;
}] call Server_Setup_Compile;

// Var Checking //

["A3PL_Debug_OnLoadVarCheck", {

	private ["_display","_activeNamespaces","_control"];
	_display = findDisplay 155;
	_activeNamespaces = [
		[1400,"A3PL_Debug_Main"]
	];

	{
		ctrlSetText [_x select 0,profileNamespace getVariable [_x select 1,"Nothing Yet!"]];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

["A3PL_Debug_OnUnloadVarCheck", {

	private ["_display","_activeNamespaces","_varCheck"];
	_display = findDisplay 155;
	_activeNamespaces = [
		[1400,"A3PL_Debug_Main"]
	];

	{
		_varCheck = ctrlText (_x select 0);
		profileNamespace setVariable [_x select 1,_varCheck];
	} forEach _activeNamespaces;
}] call Server_Setup_Compile;

// Execute //

["A3PL_Debug_Execute", {

	private ["_display","_debugText","_chosenExecType","_remoteExecType","_compileRdy"];
	_display = findDisplay 155;
	_debugText = ctrlText 1400;
	_chosenExecType = lbText [2100,lbCurSel 2100];
	_remoteExecType = clientOwner;

	switch (_chosenExecType) do {
		case "Server Execute": {_remoteExecType = 2};
		case "Global Execute": {_remoteExecType = 0};
		case "Client Execute": {_remoteExecType = -2};
		case "Local Execute": {_remoteExecType = clientOwner};
		default {_remoteExecType = clientOwner};
	};

	[_debugText] remoteExec ["A3PL_Debug_ExecuteCompiled",_remoteExecType];
},false,true] call Server_Setup_Compile;

["A3PL_Debug_ExecuteCompiled", {

	private ["_debugText"];
	_debugText = param [0,"Nothing"];

	if (_debugText == "Nothing") exitWith {};

	call compile _debugText;
	[player,"Debug",[_debugText]] remoteExec ["Server_AdminLoginsert", 2];
},false,true] call Server_Setup_Compile;
