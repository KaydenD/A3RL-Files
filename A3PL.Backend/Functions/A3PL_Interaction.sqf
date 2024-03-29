/*
["A3PL_Interaction", {
	[
		#include "\x\cba\addons\ui_helper\script_dikCodes.hpp"

		["main", "A3PL Interaction", "rose"],
		[
			[
				"Close", // text on button
				{}, // code to run
				"", // icon
				"", // tooltip
				[], // submenu
				DIK_C, // shortcut key
				(true), // enabled?
				(true) // visible if true
			],   

			[
				"Recompile Files", // text on button
				{if (isServer) then {call A3PL_SetupFiles} else {[[],"A3PL_SetupFiles",false,false,true] call BIS_FNC_MP;}; player globalChat "A3PL Files Recompiled.";}, // code to run
				"", // icon
				"Reload the framework functions", // tooltip
				"", // submenu
				DIK_R, // shortcut key
				(true), // enabled?
				(true) // visible if true TRUE FOR ALL PLAYERS!!!
			],     

			[
				"Inventory", // text on button
				{call A3PL_Inventory_Open;}, // code to run
				"", // icon
				"Open your inventory", // tooltip
				"", // submenu
				DIK_Y, // shortcut keyss
				(alive player), // enabled?
				(true) // visible if true
			],

			#include "InteractionMenus\Items.sqf",
			#include "InteractionMenus\Shops.sqf",		
			#include "InteractionMenus\NPCs.sqf",
			#include "InteractionMenus\JayHawk.sqf",
			#include "InteractionMenus\Cutter.sqf",
			#include "InteractionMenus\Patrol.sqf",
			#include "InteractionMenus\LifeBoat.sqf",
			#include "InteractionMenus\Charger.sqf",
			#include "InteractionMenus\Placeables.sqf",
			#include "InteractionMenus\Police.sqf",
			#include "InteractionMenus\Bowling.sqf"
		]
	]
}] call Server_Setup_Compile;
*/

["A3PL_Interaction_loadInteraction",
{
    disableSerialization;
 
    params[["_target",objNull,[objNull]]];
 
    //MB_Interaction_Target = _target;
    A3PL_Interaction_actionList = [];
    A3PL_Interaction_overflowList = [];
 
    /* Load all our interaction options */
 
    {
       
        if(count A3PL_Interaction_actionList >= 7) then {
       
            _check = _x select 2;

            if((call _check)) then {
                _action = _x select 1;
                _title = _x select 0;
           
                A3PL_Interaction_overflowList pushBack [_title,_action];   
            };
        } else {
       
            _check = _x select 2;

            if((call _check)) then {
                _action = _x select 1;
                _title = _x select 0;
           
                A3PL_Interaction_actionList pushBack [_title,_action]; 
            };
        };
 
    } forEach A3PL_Interaction_Options;
 
    /* Check for More Options */
 
    if(count A3PL_Interaction_overflowList > 0) then {
        if(count A3PL_Interaction_overflowList < 2) then {
            A3PL_Interaction_actionList pushBack [(A3PL_Interaction_overflowList select 0 select 0),(A3PL_Interaction_overflowList select 0 select 1)];
        } else {
            A3PL_Interaction_actionList pushBack ["More Options",{[] call A3PL_Interaction_loadMoreInteractions;}];
        };
    };
 
    //Only load if we've got interactions! Dumbass
 
    if(count A3PL_Interaction_actionList < 1) exitWith {};
 
    //Load our UI
 
    closeDialog 0;
    createDialog "Dialog_Interaction_Menu";

    buttonSetAction [7000, "[0] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7001, "[1] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7002, "[2] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7003, "[3] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7004, "[4] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7005, "[5] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7006, "[6] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7007, "[7] call A3PL_Interaction_interactionButtonPressed;"];
 
    _idd = 1001;
 
    {
        ctrlSetText[_idd,(_x select 0)];
        _idd = _idd + 1;
    } forEach A3PL_Interaction_actionList; 
}] call Server_Setup_Compile;
 
["A3PL_Interaction_loadMoreInteractions",
{
    closeDialog 0;
    createDialog "Dialog_Interaction_Menu";

    buttonSetAction [7000, "[0] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7001, "[1] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7002, "[2] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7003, "[3] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7004, "[4] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7005, "[5] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7006, "[6] call A3PL_Interaction_interactionButtonPressed;"];
    buttonSetAction [7007, "[7] call A3PL_Interaction_interactionButtonPressed;"];
 
    A3PL_Interaction_actionList = [];
 
    _idd = 1001;
 
    {
        ctrlSetText[_idd,(_x select 0)];
        _idd = _idd + 1;
 
        A3PL_Interaction_actionList pushBack _x;
    } forEach A3PL_Interaction_overflowList;   
}] call Server_Setup_Compile;
 
["A3PL_Interaction_interactionButtonPressed",
{
    params[["_value",0,[0]]];
 
    if(_value > ((count A3PL_Interaction_actionList)-1)) exitWith {};
 
    closeDialog 0;
 
    _action = A3PL_Interaction_actionList select _value select 1;
    call _action;  
}] call Server_Setup_Compile;

//Quick actions located in config\QuickActions
//THIS IS NOW BASED ON "Action display name"
['A3PL_Interaction_ActionKey', {
	private ["_action","_isGen","_interName","_interObj","_config"];

	_config = (Player_NameIntersect call A3PL_Intersect_ConditionCalc);
	
	if (count _config == 0) then
	{
		_interName = "";
	} else
	{
		_interName = (_config select Player_selectedIntersect) select 1;
	};
	
	_action = {};
	_interObj = call A3PL_Intersect_Cursortarget;
	
	//Exclusion for attached objects
	_attachedObjects = [] call A3PL_Lib_Attached;
	if ((count ([] call A3PL_Lib_Attached) > 0) && (isNull player_Item)) exitwith
	{
		_interObj = ([] call A3PL_Lib_Attached) select 0;
		if (([_interObj] call A3PL_lib_CheckIfFurniture) && (_interObj IN ([] call A3PL_Lib_Attached))) exitwith
		{
			[] call A3PL_Placeables_QuickAction;
		};
		
		if (typeOf _interObj IN Config_Placeables) then
		{
			[] call A3PL_Placeables_QuickAction;
		};		
	};
	
	if (_interName IN Config_GenArray) then
	{
		{
			if (_intername == (_x select 1)) exitwith
			{
				_action = call (_x select 2);
			};
		} foreach Config_QuickActions;
	} else {
		{
			if ((_intername == (_x select 1)) && (typeOf _interObj == (_x select 0))) exitwith
			{
				_action = call (_x select 2);
			};
		} foreach Config_QuickActions;		
	};
}] call Server_Setup_Compile;


