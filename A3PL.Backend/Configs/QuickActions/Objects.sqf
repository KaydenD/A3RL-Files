//moonshine
[
	"A3PL_Distillery",
	"Install hose",
	{
		[player_objIntersect] call A3PL_Moonshine_InstallHose;
	}
],

[
	"",
	"Fill Bottle",
	{
		[] call A3PL_Items_FillBottle;
	}
],

[
	"A3PL_Distillery_Hose",
	"Connect jug to hose",
	{
		[player_objIntersect] call A3PL_Moonshine_InstallJug;
	}
],

[
	"A3PL_Distillery",
	"Start distillery",
	{
		[player_objIntersect] spawn A3PL_Moonshine_Start;
	}
],

[
	"A3PL_Distillery",
	"Check distillery status",
	{
		[player_objIntersect] call A3PL_Moonshine_CheckStatus;
	}
],

[
	"A3PL_Distillery",
	"Add item to distillery",
	{
		[player_objIntersect] call A3PL_Moonshine_addItem;
	}
],

[
	"A3PL_Mixer",
	"Grind wheat into malt",
	{
		["malt",player_objIntersect] call A3PL_Moonshine_Grind;
	}
],

[
	"A3PL_Mixer",
	"Grind wheat into yeast",
	{
		["yeast",player_objIntersect] call A3PL_Moonshine_Grind;
	}
],

[
	"A3PL_Mixer",
	"Grind corn into cornmeal",
	{
		["cornmeal",player_objIntersect] call A3PL_Moonshine_Grind;
	}
],

//Drugs stuff
[
	"A3PL_Mixer",
	"Grind cannabis",
	{
		[player_objintersect] call A3PL_JobFarming_Grind;
	}
],

[
	"A3PL_Mixer",
	"Collect grinded cannabis",
	{
		[player_objintersect] call A3PL_JobFarming_GrindCollect;
	}
],

[
	"A3PL_Scale",
	"Bag marijuana",
	{
		[player_objintersect] call A3PL_JobFarming_BagOpen;
	}
],

[
	"A3PL_WorkBench",
	"Cure bud",
	{
		if ((player_itemClass == "cannabis_bud") && (typeOf Player_Item == "A3PL_Cannabis_Bud")) then
		{
			[Player_Item] call A3PL_JobFarming_CureLoop;
			[] call A3PL_Placeables_QuickAction;
		} else
		{
			["System: You don't seem to be holding a cannabis bud to cure",Color_Red] call A3PL_Player_notification;
		};
	}
],

[
	"A3PL_Cannabis_Bud",
	"Check cure status",
	{
		[player_objintersect] call A3PL_JobFarming_CheckCured;
	}
],

//merge
[
	"Box_GEN_Equip_F",
	"",
	{
		[player_objintersect] call A3PL_Housing_VirtualOpen;
	}
],

[
	"A3PL_Roadcone",
	localize"STR_INTSECT_STACKCONE", //Stack cone
	{
		[player_objintersect] call A3PL_Placeables_StackCone;
	}
],

[
	"A3PL_RoadCone_x10",
	localize"STR_INTSECT_STACKCONE", //Stack cone
	{
		[player_objintersect] call A3PL_Placeables_StackCone;
	}
],

////////////////////////////////////////////Objects////////////////////////////////////////////////////
[
	"A3PL_carInfo",
	localize"STR_INTSECT_VEHINFO", //Vehicle Info
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_carInfo",
	localize"STR_INTSECT_PAINTAIRC", //Paint Aircraft
	{
		[player_objintersect] spawn A3PL_Garage_Open;
	}
],

[
	"",
	"Buy furniture",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Net",
	localize"STR_INTSECT_BUSENET", //Buy/Sell Net
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Bucket",
	localize"STR_INTSECT_BUSEBUCK", //Buy/Sell Net
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Crate",
	localize"STR_INTSECT_BUSEITEM", //Buy/Sell Item
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Seed_Marijuana",
	"Buy/Sell Marijuana Seeds",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Seed_Lettuce",
	"Buy/Sell Lettuce Seeds",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_MarijuanaBag",
	"Buy/Sell Weed Bag",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Seed_Wheat",
	"Buy/Sell Wheat Seeds",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"A3PL_Seed_Corn",
	"Buy/Sell Corn Seeds",
	{
		[(format ["%1",player_objIntersect])] call A3PL_Shop_Open;
	}
],

[
	"",
	localize"STR_INTSECT_PLACEBURGER", //Place Burger
	{
		private ["_attached","_playerItem"];

		if (isNull player_item) exitwith {["You have nothing in your hand to place here", Color_Red] call a3pl_player_notification;};

		_class = player_itemclass;
		if (!(_class IN ["burger_raw","burger_burnt","burger_cooked","fish_raw","fish_cooked","fish_burned"])) exitwith {["You can only Place Burgers/fish on the grill", Color_Red] call a3pl_player_notification;};

		if (!isNull Player_Item) exitwith
		{
			_playeritem = Player_Item;
			[] call A3PL_Placeables_QuickAction;

			//if attachment was onto a grill
			if (isNull (attachedTo _playeritem)) exitwith {};
			if ((typeOf(attachedTo _playeritem)) IN ["A3PL_Mcfisher_Grill"]) exitwith
			{
				[_playeritem] call A3PL_JobMcfisher_CookBurger;
			};
		};
	}
],

[
	"RoadCone_F",
	"",
	{
		private ["_name"];
		_name = Player_NameIntersect;
		if (_name != "") exitwith {};
		[] call A3PL_Placeables_QuickAction;

	}
],

[
	"",
	localize"STR_INTSECT_GRABFURN", //Grab Furniture
	{
		private ["_name"];
		if (!isNull player_item) exitwith
		{
			["You can't pickup/drop this item because you have something in your hand", Color_Red] call a3pl_player_notification;
		};
		_name = Player_NameIntersect;
		[] call A3PL_Placeables_QuickAction;
	}
],


[
	"C_man_1",
	"",
	{
		_attachedObjects = [] call A3PL_Lib_Attached;
		if ((count _attachedObjects) == 0) exitwith {};
		_attachedObject = _attachedObjects select 0;

		if (((typeOf _attachedObject) IN Config_Placeables) OR (_attachedObject isKindOf "A3PL_Furniture_Base")) then
		{
			if(_attachedObject isKindOf "A3PL_Furniture_Base") then {
				if(isOnRoad player) then {
					["You can't place furniture on the road!", Color_Red] call a3pl_player_notification;
				} else {
					[] call A3PL_Placeables_QuickAction;
				};
			} else {
				[] call A3PL_Placeables_QuickAction;
			};
		};
	}
],

[
	"",
	localize"STR_INTSECT_PLACEITEM",//Place Item
	{
		private ["_veh","_name","_attached"];

		if (!isNull Player_Item) exitwith
		{
			[] call A3PL_Placeables_QuickAction;
		};

		_attached = [] call A3PL_Lib_Attached;
		if (count _attached == 0) exitwith {};

		if ((typeOf (_attached select 0)) IN Config_Placeables) then
		{
			[] call A3PL_Placeables_QuickAction;
		};
	}
],

[
	"GroundWeaponHolder",
	"",
	{
		private ["_veh","_name"];
		_veh = call A3PL_Intersect_Cursortarget;
		_name = Player_NameIntersect;
		if (_name != "") exitwith {};
		[] call A3PL_Placeables_QuickAction;
	}
],

[
	"A3PL_PileCash",
	"Steal Vault Money", //Steal Vault Money
	{
		[player_objintersect] spawn A3PL_BHeist_PickCash;
	}
],

[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_INSTDRLBIT", //"Install Drill Bit
	{
		[player_objintersect] call A3PL_BHeist_InstallBit;
	}
],

[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_DISSDRILL", //Dissemble Drill
	{
		[player_objintersect] call A3PL_BHeist_PickupDrill;
	}
],

[
	"A3PL_Drill_Bank",
	localize"STR_INTSECT_STARTVDRILL", //Start Vault Drill
	{
		[player_objintersect] spawn A3PL_BHeist_StartDrill;
	}
],

[
	"",
	localize"STR_INTSECT_OPENMEDICALMEN", //Open Medical Menu
	{
		[player_objintersect] spawn A3PL_Medical_Open;
	}
],

[
	"",
	"Resuscitate", //Open Medical Menu
	{[player_objintersect] spawn A3PL_Medical_ChestCompressions;}
],

[
	"",
	"Pickup Delivery Box",
	{
		[player_objintersect] call A3PL_Delivery_Pickup;
	}
],

[
	"",
	localize"STR_INTSECT_PICKUPITEM", //Pickup Item
	{
		[player_objintersect] call A3PL_Inventory_Pickup;
	}
],

[
	"",
	localize"STR_INTSECT_CHECKITEM", //Check Item
	{
		[player_objintersect] call A3PL_Factory_CrateCheck;
	}
],

[
	"",
	localize"STR_INTSECT_COLLECTITEM", //Collect Item
	{
		[player_objintersect] call A3PL_Factory_CrateCollect;
	}
],

[
	"",
	localize"STR_INTSECT_BUYITEM", //Buy Item
	{
		[player_objintersect] call A3PL_Business_BuyItem;
	}
],

[
	"",
	localize"STR_INTSECT_SELLITEM", //Sell Item
	{
		[player_objintersect] call A3PL_Business_Sell;
	}
],

[
	"A3PL_OilBarrel",
	localize"STR_INTSECT_LOADPINTOTANK", //Load Petrol Into Tanker
	{
		[player_objintersect] call A3PL_Hydrogen_LoadPetrol;
	}
],

[
	"A3PL_Kerosene",
	"Load Kerosene Into Truck", //Load Petrol Into Tanker
	{
		[player_objintersect] call A3PL_Hydrogen_LoadKerosene;
	}
],

[
	"",
	localize"STR_INTSECT_PICKITEMTOHAND", //Pickup Item To Hand
	{
		[player_objintersect,true] call A3PL_Inventory_Pickup;
	}
],

[
	"A3PL_DeliveryBox",
	"Collect Delivery Box",
	{
		[player_objintersect] call A3PL_JobMDelivery_Collect;
	}
],

[
	"A3PL_DeliveryBox",
	"Check Delivery Label",
	{
		[player_objintersect] call A3PL_Delivery_Label;
	}
],

[
	"Land_A3PL_Cinema",
	localize"STR_INTSECT_GETPOPC", //Get Popcorn
	{
		[] call A3PL_Items_GrabPopcorn;
	}
],

[
	"",
	localize"STR_INTSECT_HARPLANT", //Harvest Plant
	{
		[player_objintersect] call A3PL_JobFarming_Harvest;
	}
],

[
	"",
	localize"STR_INTSECT_PICKUPKEY", //Pickup Key
	{
		[] call A3PL_Housing_PickupKey;
	}
],

[
	"",
	localize"STR_INTSECT_CREATEFISHB", //Create Fish Burger
	{
		[player_objintersect] call A3PL_JobMcfisher_CombineBurger;
	}
],

[
	"A3PL_TacoShell",
	localize"STR_INTSECT_CREATEFTACO", //Create Fish Taco
	{
		[player_objintersect,"taco"] call A3PL_JobMcfisher_CombineBurger;
	}
],

[
	"A3PL_FishingBuoy",
	localize"STR_INTSECT_COLLNET", //Collect Net
	{
		[player_objintersect] call A3PL_JobFisherman_RetrieveNet;
	}
],

[
	"",
	localize"STR_INTSECT_USEATM", //Use ATM
	{
		[] call A3PL_ATM_Open;
	}
],

[
	"A3PL_FishingBuoy",
	localize"STR_INTSECT_DEPLNET", //Deploy Net
	{
		[] call A3PL_JobFisherman_DeployNet;
	}
],

[
	"A3PL_FishingBuoy",
	"Bait net", //Deploy Net
	{
		[player_objintersect] call A3PL_JobFisherman_Bait;
	}
],

[
	"A3PL_Planter2",
	localize"STR_INTSECT_PLANTFARMSEED", //Plant Farming Seed
	{
		[player_objintersect] call A3PL_JobFarming_PlanterPlant;
	}
],

[
	"Land_A3PL_Greenhouse",
	localize"STR_INTSECT_PLANTFARMSEED", //Plant Farming Seed
	{
		[player_objintersect] call A3PL_JobFarming_GreenHousePlant;
	}
],

[
	"A3PL_GasHose",
	localize"STR_INTSECT_GRABGASHOSE", //Grab Gas Hose
	{
		[player_objintersect] spawn A3PL_Hydrogen_Grab;
	}
],

[
	"Land_A3PL_Gasstation",
	localize"STR_INTSECT_RETGASHOSE", //Return Gas Hose
	{
		[player_objintersect] call A3PL_Hydrogen_Connect;
	}
],

[
	"A3PL_GasHose",
	localize"STR_INTSECT_TOGGLEFUELP",
	{
		[player_objintersect] spawn A3PL_Hydrogen_SwitchFuel;
	}
],

[
	"A3PL_Rocket",
	localize"STR_INTSECT_IGNROCKET", //Ignite Rocket
	{
		[player_objintersect] call A3PL_Items_IgniteRocket;
	}
],

//FD STUFF
//FD INTERACTIONS
//FD STUFF

[
	"",
	"Police Computer", //Access police Database
	{
		if((player getVariable ["job","unemployed"] in ["police","uscg"])) then {
			[] call A3PL_Police_DatabaseOpen;
		} else {
			["You don't have permission to use this computer",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	"FIFR Computer", //Access fire Database
	{
		if((player getVariable ["job","unemployed"] in ["fifr"])) then {
			[] call A3PL_FD_DatabaseOpen;
		} else {
			["You don't have permission to use this computer",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"A3PL_FD_HoseEnd1_Float",
	localize"STR_INTSECT_CONROLHOSE", //Connect Rolled Hose
	{
		[player_objintersect] call A3PL_FD_ConnectHose;
	}
],

[
	"Land_A3PL_FireHydrant",
	localize"STR_INTSECT_CONHOSEADAP", //Connect Hose Adapter
	{
		[player_objintersect] call A3PL_FD_ConnectAdapter;
	}
],

// gas station
[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_CONHOSEADAP", //Connect Hose Adapter
	{
		[player_objintersect] call A3PL_FD_ConnectAdapter;
	}
],

[
	"Land_A3PL_Gas_Station",
	localize"STR_INTSECT_SWITCHGASSTORSW", //Turn Gas Station Red Tanker On
	{
		[player_objintersect] call A3PL_Hydrogen_StorageSwitch
	}
],

[
	"Land_A3PL_FireHydrant",
	localize"STR_INTSECT_CONHYDWRE", //Connect Hydrant Wrench
	{
		[player_objintersect] call A3PL_FD_ConnectWrench;
	}
],

[
	"",
	localize"STR_INTSECT_HOLDHOSEAD", //Hold Hose Adapter
	{
		[player_objintersect] call A3PL_FD_GrabHose;
	}
],

[
	"",
	localize"STR_INTSECT_CONHOSETAD", //Connect Hose To Adapter
	{
		[player_objintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"",
	"Rollup Hose",
	{
		[player_objintersect] call A3PL_FD_RollHose;
	}
],

[
	"A3PL_FD_yAdapter",
	localize"STR_INTSECT_CONHOSETIN", //Connect Hose To Inlet
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"A3PL_FD_yAdapter",
	localize"STR_INTSECT_CONHOSETOUT", //Connect Hose To Outlet
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"A3PL_Tanker_Trailer",
	localize"STR_INTSECT_CONHOSETTANK", //Connect Hose To Tanker
	{
		[player_objintersect,player_nameintersect] call A3PL_FD_ConnectHoseAdapter;
	}
],

[
	"A3PL_FD_HydrantWrench_F",
	localize"STR_INTSECT_OPENHYDR", //Open Hydrant
	{
		[player_objintersect] call A3PL_FD_WrenchRotate;
	}
],

[
	"A3PL_FD_HydrantWrench_F",
	localize"STR_INTSECT_CLOSEHYDR", //Close Hydrant
	{
		[player_objintersect] call A3PL_FD_WrenchRotate;
	}
],

[
	"",
	localize"STR_INTSECT_CUFFUN", //Cuff/Uncuff
	{
		if (player_objintersect getVariable ["Cuffed",true]) then
		{
			[player_objintersect] call A3PL_Police_Uncuff;
		};
		if (Player_ItemClass == "handcuffs") then
		{
			[player_objintersect] call A3PL_Police_Cuff;
		} else
		{
			["You need handcuffs to do this!", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	"Restrain/Unrestrain", //Zip/unzip
	{
		if (player_objintersect getVariable ["Zipped",true]) then
		{
			[player_objintersect] call A3PL_Criminal_Unzip;
		};
		if (Player_ItemClass == "zipties") then
		{
			[player_objintersect] call A3PL_Criminal_Ziptie;
		} else
		{
			["You need zipties to do this!", Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	localize"STR_INTSECT_HANDTICKET", //Hand Ticket
	{
		[player_objintersect] call A3PL_Police_GiveTicket;
	}
],

[
	"",
	localize"STR_INTSECT_KICKDOWN", //Kick Down
	{
		[player_objintersect] call A3PL_Police_CuffKick;
	}
],

[
	"",
	localize"STR_INTSECT_PATDOWN", //Pat down
	{
		[player_objintersect] spawn A3PL_Police_PatDown;
	}
],

[
	"",
	localize"STR_INTSECT_DRAG", //Drag
	{
		[player_objintersect] call A3PL_Police_Drag;
	}
],

[
	"",
	"Grab", //uscg grab
	{
		[player_objintersect] call A3PL_USCG_Drag;
	}
],

[
	"",
	localize"STR_INTSECT_EJALLPASS", //Eject All Passengers
	{
		[player_objintersect] call A3PL_Police_unDetain;
	}
],

[
	"",
	localize"STR_INTSECT_DETAINSUS", //Detain Suspect
	{
		[call A3PL_Intersect_Cursortarget] call A3PL_Police_Detain;
	}
],

[
    "A3PL_Stinger",
    localize"STR_INTSECT_DEPLSTR", //Deploy Stinger
    {
        _veh = player_objintersect;

        if (_veh animationSourcePhase "Deploy_Stinger" < 0.5) then
        {
            _veh animateSource ["Deploy_Stinger",1];

        } else
        {
			["System: Stinger is already deployed",Color_Red] call A3PL_Player_Notification;
		};

    }
],

[
	"A3PL_Stinger",
	localize"STR_INTSECT_RETRACTSTR", //Retract Stinger
	{
        _veh = player_objintersect;

        if (_veh animationSourcePhase "Deploy_Stinger" > 0.5) then
        {
            _veh animateSource ["Deploy_Stinger",0];

        } else
        {
			["System: Stinger is not deployed",Color_Red] call A3PL_Player_Notification;
		};

    }
],

[
    "",
    "Go On EMS Duty",
    {
        _veh = player_objintersect;
		_id = getPlayerUID player;
		_veh setVariable ["keyAccess",_id,true];
		player setVariable ["job","FIFR",true];
		clearBackpackCargoGlobal _veh;clearItemCargoGlobal _veh;clearMagazineCargoGlobal _veh;clearWeaponCargoGlobal _veh;
		//Kane you needs to add loading persistent storage here
		_veh addBackpackCargoGlobal ["A3PL_LR", 1];
		_veh addItemCargoGlobal ["A3PL_FIFR_EMT_Uniform", 1];
		_veh addItemCargoGlobal ["A3PL_FIFR_Firefighter_Uniform", 1];
		_veh addItemCargoGlobal ["A3PL_FIFR_EMT_Saftey_Vest", 1];
		_veh addItemCargoGlobal ["A3PL_FIFR_FireFighter_Saftey_Vest", 1];
    }
],

[
    "",
    "Go Off EMS Duty",
    {
        _veh = player_objintersect;
		_id = getPlayerUID player;
		_veh setVariable ["keyAccess",Nil,true];
		player setVariable ["job","unemployed",true];
		//Kane you needs to add saving persistent storage here
		clearBackpackCargoGlobal _veh;clearItemCargoGlobal _veh;clearMagazineCargoGlobal _veh;clearWeaponCargoGlobal _veh;
    }
],

[
	"",
	"Tag meat",
	{
		[player_objintersect] call A3PL_Hunting_Tag;
	}
],

[
	"A3PL_OilBarrel",
	"Load into fuelstation tank",
	{
		[player_objintersect] call A3PL_Hydrogen_LoadPetrolStation;
	}
],

[
	"",
	"Play Slots",
	{
		[player_objintersect] spawn A3RL_Slots_Roll;
	}
],

[
	"",
	"Set Bet",
	{
		[] spawn A3RL_Slots_OpenSetBet;
	}
],

[
	"",
	"Play Blackjack",
	{
		[player_objintersect] spawn A3RL_Blackjack_Start;
	}
],

[
	"Land_MetalCase_01_large_F",
	"",
	{
		[player_objIntersect] spawn A3RL_HouseRob_Open;
	}
], 

[
	"",
	"Lockpick Handcuffs",
	{
		[player_objintersect] spawn A3RL_PrisonBreak_Handcuffs;
	}
],

[
	"Land_GarbageBarrel_01_F",
	"",
	{
		[] spawn A3RL_PrisonBreak_Search;
	}
]