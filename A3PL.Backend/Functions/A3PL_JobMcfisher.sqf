["A3PL_JobMcfisher_CombineBurger",
{
	private ["_intersect","_classIntersect","_burgers"];
	_intersect = param [0,ObjNull];
	_creating = param [1,"burger"];
	_classIntersect = _intersect getVariable "class";
	
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	if (isNull _intersect) exitwith {["System error: _intersect is Null in CombineBurger", Color_Red] call a3pl_player_notification;};
	if (isNil "_classIntersect") exitwith {["System error: _classIntersect is Nil in CombineBurger", Color_Red] call a3pl_player_notification;};
	if (!(_classIntersect IN ["burger_bun","burger_cooked","burger_raw","burger_burnt","tacoshell"])) exitwith {["System error: _classintersect not of correct type in CombineBurger", Color_Red] call a3pl_player_notification;};
	if (!isNull player_item) exitwith {["You are carrying something and cannot perform this action", Color_Red] call a3pl_player_notification;};
	
	//if creating burger
	if (_creating == "taco") exitwith
	{
		_burgers = nearestObjects [_intersect, ["A3PL_Fish_Raw","A3PL_Fish_Cooked","A3PL_Fish_Burned"], 1];
		if (!isNull player_item) then {_burgers = _burgers - [player_item];};
		if (count _burgers == 0) exitwith {["System: There isn't any fish nearby to combine this with", Color_Red] call a3pl_player_notification;};

		_salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
		if (!isNull player_item) then {_salads = _salads - [player_item];};
		if (count _salads == 0) exitwith {["System: There isn't any salad nearby to combine this with", Color_Red] call a3pl_player_notification;};
		
		[[player,_intersect],"Server_JobMcfisher_combine",false,false] call bis_fnc_mp;
	};
	
	//we are doing this seperate, dont know why buy maybe it'll be useful if we ever need to do this client-side
	if (_classIntersect == "burger_bun") exitwith //it's a bread piece that we are interacting with
	{
			_burgers = nearestObjects [_intersect, ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Burger_Burnt"], 1];
			if (!isNull player_item) then {_burgers = _burgers - [player_item];};			
			if (count _burgers == 0) exitwith {["System error: Nothing near item to combine this item with", Color_Red] call a3pl_player_notification;};
			
			_salads = nearestObjects [_intersect, ["A3PL_Salad"], 1];
			if (!isNull player_item) then {_salads = _salads - [player_item];};
			if (count _salads == 0) exitwith {["System: There isn't any salad nearby to combine this with", Color_Red] call a3pl_player_notification;};			
			
			//send request to server to combine
			[[player,_intersect],"Server_JobMcfisher_combine",false,false] call bis_fnc_mp;
	};
	
	_burgers = nearestObjects [_intersect, ["A3PL_Burger_Bun"], 1];	
	if (!isNull player_item) then {_burgers = _burgers - [player_item];};
	if (count _burgers == 0) exitwith {["System error: Nothing near item to combine this item with", Color_Red] call a3pl_player_notification;};
	[[player,_intersect],"Server_JobMcfisher_combine",false,false] call bis_fnc_mp;
	
}] call Server_Setup_Compile;

["A3PL_JobMcfisher_CookBurger",
{
	private ["_burger","_class","_grill"];
	_burger = param [0,objNull];
	_class = typeOf _burger;	
	_grill = attachedTo _burger;

	//player globalChat format ["%1 - %2 - %3",_burger,_class,_grill];
	
	if (isNull _burger) exitwith {["System error: _burger is a null object, report this error", Color_Red] call a3pl_player_notification;};
	if (isNull _grill) exitwith {["System error: _grill is a null object, report this error", Color_Red] call a3pl_player_notification;};
	if (typeOf _grill != "A3PL_Mcfisher_Grill") exitwith {["System error: _grill is not of correct type", Color_Red] call a3pl_player_notification;};
	if (isNil "_class") exitwith {["System error: _burger contains no class, report this error", Color_Red] call a3pl_player_notification;};
	
	//first check if any cook variable already exist, or apply
	_cookstate = _burger getVariable "cookstate";
	if (isNil "_cookstate") then 
	{
		_burger setVariable ["cookstate",0,true];
	};
	
	[_burger,_grill,_class] spawn
	{
		private ["_burger","_cookstate","_burger","_grill","_pos","_veh"];
		_burger = param [0,ObjNull];
		_grill = param [1,ObjNull];
		_class = param [2,""];
		
		if (_class == "") exitwith {};
		
		while {attachedTo _burger == _grill} do
		{
			private ["_cookstate","_newcookstate"];
			_cookstate = _burger getVariable "cookstate";//get current state
			_newcookstate = _cookstate + 10;
			_burger setVariable ["cookstate",_newcookstate,true];
			uiSleep 10; //time between cookstates
			if (_newcookstate > 90) exitwith {};
			if (isNull _burger) exitwith {}; //could be somebody picked it up
		};
		
		_cookstate = _burger getVariable "cookstate"; //get the cookstate again
		if (isNil "_cookstate") exitwith {};
		
		if (_cookstate > 90) then 
		{
			
			if (_class IN ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Fish_Raw","A3PL_Fish_Cooked"]) then
			{
				[[player,_burger],"Server_JobMcfisher_cookthres",false,false] call bis_fnc_mp; // let server know the cookstate on client has reached a threshold, server will now take care of changing the object etc
			};
			
			if (_class IN  ["A3PL_Burger_Burnt","A3PL_Fish_Burned"]) then //must be a burned burger then, we can execute fire scripts here in the future
			{
				_burger setVariable ["cookstate",nil,true];
			};
		};
	};
}
] call Server_Setup_Compile;