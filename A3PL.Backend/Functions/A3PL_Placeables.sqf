['A3PL_Placeables_Pickup', {
	private ["_obj","_type","_attachedTo"];
	_obj = param [0,([] call A3PL_Intersect_Cursortarget)];
	
	//If the object is already attached to a player exit the script
	_attachedTo = attachedTo _obj;
	if ((isPlayer _attachedTo) && (!(_attachedTo isKindOf "Car"))) exitwith {["System: Item is being carried by another player", Color_Red] call A3PL_Player_Notification;};	
	
	//If the objects locality is not the player exit
	if ((!local _obj) && (!((typeOf _obj) IN ["A3PL_WheelieBin"]))) exitwith 
	{
		["Locality issue, does this item belong to you?", Color_Red] call A3PL_Player_Notification;
		["If the item you are trying to pickup is a vehicle, please get in to change the locality owner", Color_Red] call A3PL_Player_Notification;
		
		_owner = _obj getVariable ["owner",nil];
		if (!isNil "_owner") then
		{
			if (typeName _owner == "ARRAY") then
			{
				if (getPlayerUID player == (_owner select 0)) then
				{
					[[_obj,player],"Server_Bowling_LocalityRequest",false,false] call BIS_fnc_MP;	
					["System: It does seem like you are the owner of this item, a locality attempt change has been initiated on the server. Please try picking the item up again in a second", Color_Yellow] call A3PL_Player_Notification;
				};
			} else
			{
				if (getPlayerUID player == _owner) then
				{
					[[_obj,player],"Server_Bowling_LocalityRequest",false,false] call BIS_fnc_MP;	
					["System: It does seem like you are the owner of this item, a locality attempt change has been initiated on the server. Please try picking the item up again in a second", Color_Yellow] call A3PL_Player_Notification;
				};				
			};
		};		
		
		if (typeOf _obj == "A3PL_DeliveryBox") then
		{
			_packageOwner = _obj getVariable ["owner",getPlayerUID player];
			if (_packageOwner == (getPlayerUID player)) then 
			{
				[[_obj,player],"Server_Bowling_LocalityRequest",false,false] call BIS_fnc_MP;	
				["System: It does seem like you are the owner of this package, a locality attempt change has been initiated on the server. Please try picking the item up again in a second", Color_Yellow] call A3PL_Player_Notification;
			};
		};
	};
	
	
	_type = typeOf _obj;
	if (_type == "GroundWeaponHolder") then
	{
		_obj attachTo [player, [0,0,0.65], "RightHand"];
	} else
	{
		systemChat "attached";
		_dir = getDir _obj;
		_obj attachTo [player];
		_obj setDir (_dir + (360 - (getDir player))); //Add direction and add (360-direction player)
		//[_obj,player] call A3PL_Lib_attachToRelative; - Obsolute
	};
	
	[_obj] spawn A3PL_Placeable_AttachedLoop;
	
	
}] call Server_Setup_Compile;

["A3PL_Placeable_AttachedLoop",
{
	private ["_obj","_sleep"];
	_obj = param [0,objNull];
	_attach = param [1,[0,0,0]]; //custom attach point
	_type = typeOf _obj;
	_distance = player distance _obj;

	player forceWalk true;
	while {(_obj IN (attachedObjects player)) && (!isNull _obj)} do
	{
		_sleep = 0.5;
		if (!alive player) exitwith {detach _obj; [] call A3PL_Inventory_Drop;}; //needs editing later
		if (!(vehicle player == player)) exitwith
		{
			private ["_isItem"];
			_isItem = false;
			{
				if (_x select 3 == (typeOf _obj)) exitwith
				{
					[true] call A3PL_Inventory_PutBack;
					_isItem = true;
				};
			} foreach Config_Items;
			if (!(_isItem)) then
			{
				detach _obj;
			}
			else
			{
				[] call A3PL_Inventory_Drop;
			};
		};
		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfisherstable1","mcfisherstable2","mcfishergrill"]) then
		{
			private ["_interDist","_dist","_begPosASL","_endPosASL","_posAGL"];
			_interDist = [player_objintersect, "FIRE"] intersect [positionCameraToWorld [0,0,0],positionCameraToWorld [0,0,1000]];
			if (count _interDist < 1) exitwith {};
			_dist = (_interDist select 0) select 1; //get the distance so we can use it in the vectormultiply below
			_begPosASL = AGLToASL positionCameraToWorld [0,0,0];
			_endPosASL = AGLToASL positionCameraToWorld [0,0,1000];
			_posAGL = ASLToAGL (_begPosASL vectorAdd ((_begPosASL vectorFromTo _endPosASL) vectorMultiply _dist));

			switch (typeOf _obj) do
			{
				case ("A3PL_Stinger"):
				{
					_obj attachto [player,
					[
						(player worldToModel (getposATL _obj)) select 0,
						(player worldToModel (getposATL _obj)) select 1,
						((player worldToModelVisual _posAGL) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)
					]];
				};
				case default {_obj attachto [player,[(player worldToModelVisual _posAGL) select 0,(player worldToModelVisual _posAGL) select 1,((player worldToModelVisual _posAGL) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)]];};
			};

			_sleep = 0.1;

			//Okay we are looking at a trunk
			if (_type == "GroundWeaponHolder") exitwith
			{
				detach _obj;
				_obj attachTo [player, [0, 1.5,
				((player WorldToModel (Player_ObjIntersect modelToWorld(Player_ObjIntersect selectionPosition player_nameIntersect))) select 2) + ([_obj,true] call A3PL_Placeable_GetZOffset)] ];
			};
		}
		else
		{
			if (Player_Item == _obj) exitwith
			{

				switch (Player_ItemClass) do
				{
					case ("popcornBucket"):
					{
						if (!isNil "A3PL_EatingPopcorn") exitwith {};
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("beer"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("coke"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("waterbottle"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case ("beer_gold"):
					{
						Player_Item attachTo [player, [0,0,0], 'LeftHand'];
					};
					case default {Player_Item attachTo [player, _attach, 'RightHand'];};
				};
			};

			if (_type == "GroundWeaponHolder") then
			{
				_obj attachTo [player, [0.6,0,0.1], 'RightHand'];
				_obj setVectorUp [1,0,0];
			} else
			{
				_obj setposATL [getposATL _obj select 0,getposATL _obj select 1,(getposATL _obj select 2) -+ ([_obj] call A3PL_Placeable_ObjectZFix)];
				if([_obj,false] call A3PL_Placeable_GetZOffset != 0) then {
					_obj attachto [player,[0,1,[_obj,false] call A3PL_Placeable_GetZOffset]];
				} else {
					_obj attachTo[player];
				};
				
				//exceptions
				switch (typeOf _obj) do
				{
					case ("A3PL_DeliveryBox"): { _obj attachTo [player,[-0.2,0,0],"RightHand"]; };
					case ("A3PL_RoadCone_x10"): { _obj attachTo [player,[0,0,0],"RightHand"]; };
				};
			};
		};
		sleep _sleep;
	};
	player forceWalk false;
}] call Server_Setup_Compile;

["A3PL_Placeable_GetZOffset",
{
	private ["_offset","_item"];
	_item = typeOf (_this select 0);
	_car = (_this select 1);
	_offset = 0;
	{
		if (_x select 0 == _item) exitWith
		{
			if(_car) then {
				_offset = _x select 1;
			} else {
				_offset = _x select 2;
			};
		};
	} foreach Config_Items_ZOffset;
	_offset
}] call Server_Setup_Compile;

['A3PL_Placeable_ObjectZFix',
{
	private ["_obj","_posZ"];
	_obj = _this select 0;
	_posZ = (boundingboxReal _obj) select 0; // Okay now we have a x,y,z model coordinate relative to model center
	_posZ = _obj modelToWorld _posZ; // lets convert this to world coordinates
	_posZ = (_posZ select 2); //Okay we have world coordinates, lets get rid of X and Y, we will now end up with the difference between terrain and object

	_posZ = _posZ - ((getposATL player) select 2); // Okay now we add the Z of the player on top of that
	_posZ;
}] call Server_Setup_Compile;

['A3PL_Placeable_ObjectZFixTrunk',
{
	private ["_obj","_posZ","_offsetTrunk"];
	_obj = _this select 0;

	_offsetTrunk = (Player_ObjIntersect modelToWorld(Player_ObjIntersect selectionPosition player_nameintersect)) select 2;
	_posZ = _offsetTrunk;
	_posZ;
}] call Server_Setup_Compile;

['A3PL_Placeables_QuickAction', {
	private ["_attached"];
	_attached = [] call A3PL_Lib_Attached;
	
	if (count _attached > 0) exitwith
	{
		private ["_obj","_dir","_collision","_except"];
		_obj = _attached select 0;
		_collision = [_obj] call A3PL_Lib_checkCollision;
		{
			if ((_x isKindOf "Car") OR (_x isKindOf "Jonzie_Public_Trailer_Base")) exitwith
			{
				_collision = _collision - [_x];
			};
		} foreach _collision;
		
		//if we are supposedly placing an item in something we will also exclude it
		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfishergrill"]) then
		{
			_collision = _collision - [player_objintersect];
		};
		
		//skip collision check for gear
		if (typeOf _obj == "GroundWeaponHolder") then
		{
			_collision = [];
		};
		
		//todo: Fix problems with modular kitchen elements later
		_except = ["A3PL_Ladder","land_market_ded_market_01_f"];
		if ((count _collision > 0) && !((typeOf _obj) IN _except)) exitwith {["You can't place an item inside another item", Color_Red] call a3pl_player_notification;};
		
		//check to see if player is freelooking
		if (freeLook) exitwith
		{
			["System: You can't place/pickup an item while looking around", Color_Red] call a3pl_player_notification;
		};
		
		if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11","lockerbottom","lockertop","mcfishertable","mcfishergrill"]) exitwith
		{
			if (Player_NameIntersect IN ["lockerbottom","lockertop"]) exitwith
			{
				if (Player_ObjIntersect AnimationPhase "door1" < 0.5) exitwith {};
				detach _obj;
				_obj attachto [(call A3PL_Intersect_Cursortarget)];
				_obj setDir 180;
				_obj setPos getPos _obj;

				if (_obj == Player_Item) then
				{
					[false] call A3PL_Inventory_Drop;			
				};
			};
			
			//mcfisher
			if (Player_NameIntersect IN ["mcfishertable","mcfishergrill"]) exitwith
			{
				detach _obj;
				_obj attachto [player_objintersect];
				if (_obj == Player_Item) then
				{
					[false] call A3PL_Inventory_Drop;						
				};				
			};

			if (Player_NameIntersect IN ["trunkinside","trunkinside1","trunkinside2","trunkinside3","trunkinside4","trunkinside5","trunkinside6","trunkinside7","trunkinside8","trunkinside9","trunkinside10","trunkinside11"]) exitwith
			{
				//disabled for now if (Player_ObjIntersect isKindOf "Car" && {(Player_ObjIntersect AnimationPhase "trunk" < 0.5)} && (!(typeOf Player_ObjIntersect IN ["A3PL_F150_Blue","A3PL_F150_Red","A3PL_F150_CamoGreen","A3PL_F150_Green","A3PL_F150_Orange","A3PL_F150_Yellow","A3PL_F150_Police_Normal","A3PL_MailTruck_Default","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Ladder","Jonzie_Ambulance","A3PL_E350"]))) exitwith {};
				if ([Player_ObjIntersect,_obj] call A3PL_Placeable_CarBlacklist) exitwith {["It doesn't look like this item will fit in this vehicle", Color_Red] call a3pl_player_notification;};
				_dir = getDir _obj;
				detach _obj;
				_obj setvelocity [0,0,0];
				_obj attachto [(call A3PL_Intersect_Cursortarget)];
				_obj setDir (_dir + (360 - (getDir player_objintersect))); //Add direction and add (360-direction player)
				_obj setpos (getpos _obj);

				if (_obj == Player_Item) then
				{	
					[false] call A3PL_Inventory_Drop;					
				};				
			};				

		};
		if (typeOf _obj == "GroundWeaponHolder") exitwith {detach _obj; _obj setpos [(getpos player select 0),(getpos player select 1),(getposATL player select 2)]};
		detach _obj;
		_obj setvelocity [0,0,0];
		_obj setposATL (getposATL _obj);
	};
	if (!(isNull player_item)) exitwith {["You can't pickup/drop this item because you have something in your hand", Color_Red] call a3pl_player_notification};
	[] call A3PL_Placeables_Pickup; 
	
}] call Server_Setup_Compile;

['A3PL_Placeable_CarBlacklist',
{
	private ["_car","_obj","_return"];
	_car = typeOf (_this select 0);
	_obj = (getModelInfo (_this select 1)) select 0;
	_return = false;
	{
		if (_x select 0 == _car) exitwith
		{
			{
				if ((format ["%1.p3d",_x]) == _obj) then
				{
					_return = true;
				};
			} foreach (_x select 1);
		};
	} foreach Config_CarFurnitureBlacklist;
	_return;
}] call Server_Setup_Compile;

//This function is in charge for setting additional text to locker door1 intersection
['A3PL_Placeables_Return', {
	private ["_return"];
	_return = "";
	if ((typeOf (call A3PL_Intersect_Cursortarget)) == "Land_A3PL_Locker") exitwith
	{
		_return = (call A3PL_Intersect_Cursortarget) getVariable "Owner";
		_return
	};
	_return
}] call Server_Setup_Compile;

["A3PL_Placeables_PlaceCone",
{
	private ["_cones","_cone"];
	_cones = ([] call A3PL_Lib_Attached) select 0;
	if (isNil "_cones") then {_cones = objNull;};
	if ((typeOf _cones) != "A3PL_RoadCone_x10") exitwith {["System: You don't have roadcones in your hand to place",Color_Red] call A3PL_Player_Notification;};
	
	//animate the cones
	_sourcePhase = _cones animationSourcePhase "cone_hide";
	if (_sourcePhase >= 9) exitwith {detach _cones;}; //drop the cones if this is the last one we're placing
	_cones animateSource ["cone_hide",_sourcePhase + 1];
	
	//create a cone
	_cone = createVehicle ["A3PL_RoadCone", (getPosATL _cones), [], 0, "CAN_COLLIDE"];	
	_cone setVariable ["class","roadcone",true];
	
	//msg
	["System: You placed a roadcone",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Placeables_StackCone",
{
	private ["_cone","_nearCone","_pos","_animPhase"];
	_cone = param [0,objNull];
	
	_nearCone = nearestObjects [_cone,["A3PL_RoadCone","A3PL_RoadCone_x10"],4];
	_nearCone = _nearCone - [_cone];
	if (count _nearCone <= 0) exitwith {["System: No cone nearby to stack with",Color_Red] call A3PL_Player_Notification;};
	_nearCone = _nearCone select 0;
	
	if ((((_cone animationSourcePhase "cone_hide") <= 0) && (typeOf _cone == "A3PL_RoadCone_x10")) OR (((_nearcone animationSourcePhase "cone_hide") <= 0) && (typeOf _nearcone == "A3PL_RoadCone_x10"))) exitwith {["System: You can stack a maximum of 10 cones",Color_Red] call A3PL_Player_Notification;};
	
	if ((typeOf _nearCone == "A3PL_RoadCone_x10") && (typeOf _cone == "A3PL_RoadCone_x10")) exitwith
	{
		_animPhase = 10 - (_nearCone animationSourcePhase "cone_hide");
		deleteVehicle _nearCone;
		_cone animateSource ["cone_hide",(_cone animationSourcePhase "cone_hide") - _animPhase];
	};
	
	if ((typeOf _nearCone == "A3PL_RoadCone_x10") OR (typeOf _cone == "A3PL_RoadCone_x10")) exitwith
	{
		if (typeOf _nearCone == "A3PL_RoadCone_x10") then
		{
			if (typeOf _cone == "A3PL_RoadCone") then {_animPhase = 1;} else {_animPhase = _cone animationSourcePhase "cone_hide";};
			deleteVehicle _cone;
			 _nearCone animateSource ["cone_hide",((_nearcone animationSourcePhase "cone_hide") - _animPhase)];
		} else
		{
			if (typeOf _nearcone == "A3PL_RoadCone") then {_animPhase = 1;} else {_animPhase = _nearcone animationSourcePhase "cone_hide";};
			deleteVehicle _nearcone;
			 _cone animateSource ["cone_hide",((_cone animationSourcePhase "cone_hide") - _animPhase)];			
		};
	};
	
	_pos = getposATL _cone;
	deleteVehicle _cone;
	deleteVehicle _nearCone;
	_cone = createVehicle ["A3PL_RoadCone_x10", _pos, [], 0, "CAN_COLLIDE"];
	_cone animateSource ["cone_hide",8,true];
	_cone setVariable ["class","roadcones",true];
}] call Server_Setup_Compile;