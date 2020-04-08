["Server_JobFarming_Plant",
{
	private ["_class","_pos","_player","_plant","_plantClass","_plants","_ATLChange"];
	_player = param [0,objNull];
	_class = param [1,""];
	_pos = param [2,[]]; //atl

	if ((isNull _player) or (_class == "")) exitwith {};

	//check if player has this class
	if (!([_class,1,_player] call Server_Inventory_Has)) exitwith {}; //play doesnt have this item

	//take away one of the class items
	[_player,_class,-1] call Server_Inventory_Add;

	//spawn new plant
	_plantClass = "";
	_ATLChange = 0;

	switch (_class) do
	{
		case "seed_wheat": {_plantClass = "A3PL_Wheat";};
		case "seed_corn": {_plantClass = "A3PL_Corn";};
		case "seed_marijuana": {_plantClass = "A3PL_Cannabis";};
		case "seed_lettuce": {_plantClass = "A3PL_Lettuce"; _ATLChange = -0.15;};
		case "seed_coca": {_plantClass = "A3PL_Coco_Plant";};
		case "seed_sugar": {_plantClass = "A3PL_Sugarcane_Plant";};
	};

	if (_plantClass == "") exitwith {};
	_plant = createVehicle [_plantClass,[_pos select 0,_pos select 1, (_pos select 2) + _ATLChange], [], 0, "CAN_COLLIDE"]; //spawn inside the ground
	_plant animateSource ["plant_growth",1];
	_plant allowDamage false;

	if(typeOf _plant == "A3PL_Cannabis") then 
	{
		_plant setVariable ["inField",true,true];
		/* ["System: TEST",Color_Red] call A3PL_Player_Notification; */
		
		if ((random 10) >= 5) then { _plant setVariable ["female",true,true]; };
	}
	else {};
	//get the plants variable
	/*
	_plants = missionNameSpace getVariable ["Server_JobFarming_Plants",[]];
	_plants pushback _plant;
	missionNameSpace setVariable ["Server_JobFarming_Plants",_plants];
	*/

	//send reply
	[[0],"A3PL_JobFarming_PlantReceive",owner _player] call BIS_FNC_MP;
},true] call Server_Setup_Compile;

["Server_JobFarming_Harvest",
{
	private ["_player","_plant","_growstate","_plants","_itemClass","_amount"];
	_player = param [0,objNull];
	_plant = param [1,objNull];
	if ((isNull _player) or (isNull _plant)) exitwith {};
	_growstate = _plant getVariable ["growState",0];

	//if (_growState < 100) exitwith {[[4],"A3PL_JobFarming_PlantReceive",owner _player] call BIS_FNC_MP;};
	if ((_plant animationSourcePhase "plant_growth") < 1) exitwith {[[4],"A3PL_JobFarming_PlantReceive",owner _player] call BIS_FNC_MP;};

	//check if in-use
	if (_plant getVariable ["inuse",false]) exitwith {};
	_plant setVariable ["inuse",true,false];

	//Check inventory
	_itemClass = "";
	_amount = 0;
	switch (typeOf _plant) do
	{
		case "A3PL_Wheat": {_amount = 10; _itemClass = "wheat";};
		case "A3PL_Corn": {_amount = 2; _itemClass = "corn";};
		case "A3PL_Cannabis":
		{
			private ["_lightValue","_plants"];
			_itemClass = "cannabis_bud";
			_lightValue = _plant getVariable ["lightValue",0];
			switch (true) do
			{
				case (!(_plant getVariable ["female",false])): {_amount = 0;};
				case (_plant getVariable ["inField",false]): {_amount = 40;}; // original 40
				case (_lightValue > 80): {_amount = 15;}; // original 30
				case (_lightValue > 50): {_amount = 9;}; // original 18
				case (_lightValue > 20): {_amount = 3;}; // original 6
				case default {_amount = 0;}; // original 1
			};

			//check if male plant is nearby a female, if so add 5 buds
			if (_plant getVariable ["female",false]) then
			{
				_plants = nearestObjects [_plant, ["A3PL_Cannabis"], 5];
				{
					if (!(_x getVariable ["female",false])) exitwith {_amount = _amount + 5;};
				} foreach _plants;
			};
		};
		case "A3PL_Lettuce": {_amount = 4; _itemClass = "lettuce";};
		case "A3PL_Coco_Plant": {_amount = 2; _itemClass = "coca";};
		case "A3PL_Sugarcane_Plant": {_amount = 2; _itemClass = "sugarcane";};
	};

	if (_itemClass == "") exitwith {};

	if (([[[_itemClass,_amount]],_player] call A3PL_Inventory_TotalWeight) > Player_MaxWeight) exitwith {[[6],"A3PL_JobFarming_PlantReceive",owner _player] call BIS_FNC_MP;}; //alternative syntax

	//delete from array
	//missionNameSpace setVariable ["Server_JobFarming_Plants",((missionNameSpace getVariable ["Server_JobFarming_Plants",[]]) - [_plant])];

	//delete the plant
	deleteVehicle _plant;

	[_player,_itemClass,_amount] call Server_Inventory_Add;

	[[5,_itemClass,_amount],"A3PL_JobFarming_PlantReceive",owner _player] call BIS_FNC_MP;

	[getPlayerUID _player,"PickupItem",["Harvested Crop",_plant,_itemClass,_amount], _player getVariable "name"] call Server_Log_New;
},true] call Server_Setup_Compile;

["Server_JobFarming_DrugDealerPos",
{
	private ["_areas","_area","_pos"];
	_objects = [DrugDealerHouse]; //objects to teleport
	_areas = ["Area_DrugDealer","Area_DrugDealer1","Area_DrugDealer2","Area_DrugDealer3","Area_DrugDealer4","Area_DrugDealer5","Area_DrugDealer6","Area_DrugDealer7","Area_DrugDealer8","Area_DrugDealer9","Area_DrugDealer10","Area_DrugDealer11","Area_DrugDealer12","Area_DrugDealer13","Area_DrugDealer14"];

	_area = _areas select (floor (random (count _areas)));


	_pos = [_area] call CBA_fnc_randPosArea;
	_pos = _pos findEmptyPosition [0, 25,(typeOf DrugDealerHouse)];
	if (count _pos == 0) exitwith {[] call Server_JobFarming_DrugDealerPos};

	if ((count (_pos nearRoads 50)) > 0) exitwith {[] call Server_JobFarming_DrugDealerPos};

	{
		_x setDir (floor (random 360));
		_x setpos _pos;
	} foreach _objects;

	npc_drugsdealer setDir (getDir DrugDealerHouse + 90);
	npc_drugsdealer setpos (DrugDealerHouse modelToWorld [-4,-0.2,-0.4]);

	DrugDealerRelative1 setDir (getDir DrugDealerHouse);
	DrugDealerRelative1 setpos (DrugDealerHouse modelToWorld [-3,-0.2,-0.4]);
},true] call Server_Setup_Compile;
