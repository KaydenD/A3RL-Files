["A3PL_Hunting_Skin",
{
	private ["_animal","_type","_meatItem","_animalType"];
	_animal = param [0,objNull];
	if (isNull _animal) exitwith {};
	_type = typeOf _animal;
	
	if (_animal getVariable ["skinning",false]) exitwith {["System: This animal is has already been skinned"] call A3PL_Player_Notification;};
	_animal setVariable ["skinning",true,true];
	
	if (!Player_ActionCompleted) exitwith {["System: You are already performing an action",Color_Red] call A3PL_Player_Notification;};
	Player_ActionCompleted = false;
	["Skinning animal...",11] spawn A3PL_Lib_LoadAction;
	while {sleep 1.5; !Player_ActionCompleted } do
	{
		player playMove 'AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown';
	};	
	
	_meatItem = "meat_sheep";
	_animalType = "Unknown";
	switch (true) do
	{
		case (_type IN ["Goat","Goat02","Goat03"]): { _meatItem = "meat_goat"; _animalType = "Goat"; };
		case (_type IN ["WildBoar"]): { _meatItem = "meat_boar"; _animalType = "Boar"; };
		case (_type IN ["Sheep","Sheep02","Sheep03"]): { _meatItem = "meat_sheep"; _animalType = "Sheep";};
	};
	
	[_meatItem,1] call A3PL_Inventory_Add;
	[format ["System: You succesfully skinned a %1 and obtained 1 %2",_animalType,[_meatItem,"name"] call A3PL_Config_GetItem],Color_Green] call A3PL_Player_Notification;
	
	deleteVehicle _animal;
}] call Server_Setup_Compile;

["A3PL_Hunting_Tag",
{
	private ["_meat","_newClass","_tagClass","_class"];
	_meat = param [0,objNull];
	_class = _meat getVariable ["class","unknown"];
	switch (_class) do
	{
		case ("meat_goat"): {_newClass = "meat_goat_tag"; _tagClass = "tag_meat";};
		case ("meat_sheep"): {_newClass = "meat_sheep_tag"; _tagClass = "tag_meat";};
		case ("meat_boar"): {_newClass = "meat_boar_tag"; _tagClass = "tag_meat";};	
		
		case ("mullet"): {_newClass = "mullet_tag"; _tagClass = "tag_fish";};
		case ("shark_2lb"): {_newClass = "shark_2lb_tag"; _tagClass = "tag_shark";};
		case ("shark_4lb"): {_newClass = "shark_4lb_tag"; _tagClass = "tag_shark";};
		case ("shark_5lb"): {_newClass = "shark_5lb_tag"; _tagClass = "tag_shark";};
		case ("shark_7lb"): {_newClass = "shark_7lb_tag"; _tagClass = "tag_shark";};
		case ("shark_10lb"): {_newClass = "shark_10lb_tag"; _tagClass = "tag_shark";};
	};
	if (isNil "_tagClass") exitwith {["System: You don't have a tag for this type of meat",Color_Red] call A3PL_Player_Notification};
	if (!([_tagClass,1] call A3PL_Inventory_Has)) exitwith {["System: You don't have a tag for this type of meat",Color_Red] call A3PL_Player_Notification};
	if (isNil "_newClass") exitwith {["System: This meat is already tagged"] call A3PL_Player_Notification;};
	if ((_meat getVariable ["amount",1]) > 1) exitwith {["System: You can only tag one meat at a time, please drop them one by one",Color_Red] call A3PL_Player_Notification;};
	_meat setVariable ["class",_newClass,true];
	[_tagClass,-1] call A3PL_Inventory_Add; 
	["System: This meat has been succesfully tagged, you can now sell it at the shop",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;