//////////////////////////////////////////////////NPC/////////////////////////////////////////////////
//purge
[
	"",
	"Talk to Purge Weapons Dealers",
	{
		["Shop_Purge_Guns"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Purge Foods Dealer",
	{
		["Shop_Purge_Food"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Chop Nearest Vehicle",
	{
		[] call A3PL_Chopshop_Chop;
	}
],

[
	"",
	"Fishers Island Security Services",
	{
		[] call A3PL_SFP_SignOn;
	}
],

[
	"",
	"SFP Shop",
	{
		if (["sfp",player] call A3PL_DMV_Check) then
		{
			["Shop_SFP"] call A3PL_Shop_Open;
		} else
		{
			["You do not have a SFP license!",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"A3PL_DogCage",
	localize"STR_INTSECT_OPK9MEN", //Open K-9 Menu
	{
		[] call A3PL_Dogs_OpenMenu
	}
],

//Dog Sit
[
	"Alsatian_Sand_F",
	localize"STR_INTER_DOGSIT",
	{
		player_objintersect playMoveNow "Dog_Sit";
	}
],

[
	"Alsatian_Black_F",
	localize"STR_INTER_DOGSIT",
	{
		player_objintersect playMoveNow "Dog_Sit";
	}
],

[
	"Alsatian_Sandblack_F",
	localize"STR_INTER_DOGSIT",
	{
		player_objintersect playMoveNow "Dog_Sit";
	}
],

//Dog Follow
[
	"Alsatian_Sand_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",true,true];
	}
],

[
	"Alsatian_Black_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",true,true];
	}
],

[
	"Alsatian_Sandblack_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",true,true];
	}
],

//Dog Stop Follow
[
	"Alsatian_Sand_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",false,true];
	}
],

[
	"Alsatian_Black_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",false,true];
	}
],

[
	"Alsatian_Sandblack_F",
	localize"STR_INTER_DOGFOLLOW",
	{
		player_objintersect setVariable["doFollow",false,true];
	}
],

[
	"",
	localize"STR_INTSECT_OPIMEXMENU", //Open Import/Export Menu
	{
		[] call A3PL_IE_Open;
	}
],

[
	"",
	localize"STR_INTSECT_CONVSTOLMONEY", //Convert stolen money
	{
		[] call A3PL_BHeist_ConvertCash;
	}
],

[
	"",
	"Access Furniture Shop",
	{
		["Shop_Furniture2"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Gamer Perk Furniture Shop",
	{
		if (["gamer"] call A3PL_Lib_hasPerk) then
		{
			["Shop_Perk_Gamer"] call A3PL_Shop_Open;
		} else
		{
			["You don't have the ""Gamer perk"", you can buy it on the forum (wwww.arma3realitylife.com/forum)",Color_Red] call A3PL_Player_Notification
		};
	}
],

[
	"",
	"Access Garden Perk Furniture Shop",
	{
		if (["garden"] call A3PL_Lib_hasPerk) then
		{
			["Shop_Perk_Garden"] call A3PL_Shop_Open;
		} else
		{
			["You don't have the ""Garden perk"", you can buy it on the forum (wwww.arma3realitylife.com/forum)",Color_Red] call A3PL_Player_Notification
		};
	}
],
[
	"",
	"Access Mancave Perk Furniture Shop",
	{
		if (["mancave"] call A3PL_Lib_hasPerk) then
		{
			["Shop_Perk_Mancave"] call A3PL_Shop_Open;
		} else
		{
			["You don't have the ""Mancave perk"", you can buy it on the forum (wwww.arma3realitylife.com/forum)",Color_Red] call A3PL_Player_Notification
		};
	}
],
[
	"",
	"Access WallDecor Perk Furniture Shop",
	{
		if (["walldecor"] call A3PL_Lib_hasPerk) then
		{
			["Shop_Perk_WallDecor"] call A3PL_Shop_Open;
		} else
		{
			["You don't have the ""WallDecor perk"", you can buy it on the forum (wwww.arma3realitylife.com/forum)",Color_Red] call A3PL_Player_Notification
		};
	}
],
[
	"",
	"Access Winchester Perk Furniture Shop",
	{
		if (["winchester"] call A3PL_Lib_hasPerk) then
		{
			["Shop_Perk_Winchester"] call A3PL_Shop_Open;
		} else
		{
			["You don't have the ""Winchester perk"", you can buy it on the forum (wwww.arma3realitylife.com/forum)",Color_Red] call A3PL_Player_Notification
		};
	}
],

[
	"",
	"Access Pinhead Larry's shop",
	{
		["Shop_Paintball"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Buckeye Buck's shop",
	{
		["Shop_Buckeye"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Moonshine Willy's shop",
	{
		["Shop_Willy"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Hemlock Huck's shop",
	{
		["Shop_Hemlock"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Mining Mike's shop",
	{
		["Shop_Mike"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Weapon Attachments Shop",
	{
		["Shop_Ill_Attachments"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Remove Ankle Tag",
	{
		[] call A3PL_Criminal_RemoveTime;
	}
],

[
	"",
	"Access Waste Management shop",
	{
		["Shop_WasteManagement"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Start/Stop working for Waste Management!",
	{
		[] spawn A3PL_Waste_StartJob;
	}
],

[
	"",
	"Start/Stop working for Fishers Island Postal Service!",
	{
		[] spawn A3PL_Delivery_StartJob;
	}
],

[
	"",
	"Start/Stop working for the Great Ratsby!",
	{
		[] call A3PL_Exterminator_Start;
	}
],

[
	"",
	"Start/Stop renting a go-kart!",
	{
		[] call A3PL_Karts_Rent;
	}
],

[
	"",
	"Buy a Iron mining map ($500)",
	{
		["iron"] call A3PL_JobWildcat_BuyMap;
	}
],
[
	"",
	"Buy a Coal mining map ($500)",
	{
		["coal"] call A3PL_JobWildcat_BuyMap;
	}
],
[
	"",
	"Buy a Aluminium mining map ($500)",
	{
		["aluminium"] call A3PL_JobWildcat_BuyMap;
	}
],
[
	"",
	"Buy a Sulphur mining map ($500)",
	{
		["sulphur"] call A3PL_JobWildcat_BuyMap;
	}
],
[
	"",
	"Buy a Oil mining map ($1000)",
	{
		["oil"] call A3PL_JobWildCat_BuyMap;
	}
],

[
	"",
	"Access Furniture Shop 2",
	{
		["Shop_Furniture"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access General Shop",
	{
		["Shop_General_Supplies"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Hardware Shop",
	{
		["Shop_Hardware"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Seeds Shop",
	{
		["Shop_Seeds"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access FIFR Equipment Shop",
	{
		private ["_whitelist"];
		_whitelist = "fifr";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_FIFR_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access FIFR Firefighting Shop",
	{
		private ["_whitelist"];
		_whitelist = "fifr";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_FIFR_Supplies_Vendor2"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access FIFR Vehicle Shop",
	{
		private ["_whitelist"];
		_whitelist = "fifr";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_FIFR_Vehicle_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access SD Equipment Shop",
	{
		private ["_whitelist"];
		_whitelist = "police";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_SD_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Access SD Vehicle Shop",
	{
		if !((player getVariable ["faction","citizen"]) IN ["police","doc","usms"]) exitwith {[format ["System: Only the SD/DOC/USMS faction can use this shop"],Color_Red] call A3PL_Player_Notification;};
		["Shop_SD_Vehicles_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Open Silverton CCTV",
	{

		if (!((player getVariable ["job","unemployed"]) IN ["police","uscg","usms","dispatch"])) exitwith {["System: Only USCG,FISD,USMS,Dispatch can use the CCTV cameras!",Color_Red] call A3PL_Player_Notification;};
		[2500] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	"Open Elk City CCTV",
	{

		if (!((player getVariable ["job","unemployed"]) IN ["police","uscg","usms","dispatch"])) exitwith {["System: Only USCG,FISD,USMS,Dispatch can use the CCTV cameras!",Color_Red] call A3PL_Player_Notification;};
		[4000] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	"Open Central CCTV",
	{
		if (!((player getVariable ["job","unemployed"]) IN ["police","uscg","usms","dispatch"])) exitwith {["System: Only USCG,FISD,USMS,dispatch can use the CCTV cameras!",Color_Red] call A3PL_Player_Notification;};
		[40000] spawn A3PL_CCTV_Open;
	}
],
[
	"",
	"Open Prisoner Shop",
	{
				if (!((player getVariable ["faction","citizen"]) IN ["citizen","mafia","cartel"])) exitwith {["System: Only citizens can use this shop!",Color_Red] call A3PL_Player_Notification;};
				if(!(player getVariable ["jailed",false])) exitWith {["System: You are not in jail to use this shop!", Color_Red] call A3PL_Player_Notification;};
		["Shop_Prison"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Access Vehicle Shop",
	{
		["Shop_Vehicles_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Access FAA Equipment Shop",
	{
		private ["_whitelist"];
		_whitelist = "faa";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_FAA_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Access FAA Vehicle Shop",
	{
		private ["_whitelist"];
		_whitelist = "faa";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_FAA_Vehicles_Vendor"] call A3PL_Shop_Open;
	}
],
[
	"",
	"Access DOJ Equipment Shop",
	{
		private ["_whitelist"];
		_whitelist = "doj";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_DOJ_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access DOC Equipment Shop",
	{
		if !((player getVariable ["faction","citizen"]) IN ["police","doc","usms"]) exitwith {[format ["System: Only the SD/DOC/USMS faction can use this shop"],Color_Red] call A3PL_Player_Notification;};
		["Shop_DOC_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access USCG Equipment Shop",
	{
		private ["_whitelist"];
		_whitelist = "uscg";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_USCG_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access USCG Car Shop",
	{
		private ["_whitelist"];
		_whitelist = "uscg";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_USCG_Car_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access USCG Boat Shop",
	{
		private ["_whitelist"];
		_whitelist = "uscg";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_USCG_Boat_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access USCG Aircraft Shop",
	{
		private ["_whitelist"];
		_whitelist = "uscg";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_USCG_Plane_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Access Chemical Plant",
	{
		["Chemical Plant"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Faction Equipment Factory",
	{
		["Faction equipment"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Steel Mill",
	{
		["Steel Mill"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Oil Refinery",
	{
		["Oil Refinery"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Weapon Factory",
	{
		["Weapon Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Weapon Parts Factory",
	{
		["Black Market Trader"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Legal Weapon Factory",
	{
		if (["fml",player] call A3PL_DMV_Check) then
		{
			["Legal Weapon Factory"] call A3PL_Factory_Open;
		} else
		{
			["You do not have a weapons manufacturing license!",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	"Access Food Processing Plant",
	{
		["Food Processing Plant"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Goods Factory",
	{
		["Goods Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Vehicle Factory",
	{
		["Vehicle Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Car Parts Factory",
	{
		["Car Parts Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Faction Vehicle Factory",
	{
		["Faction Vehicle Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Marine Factory",
	{
		["Marine Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Aircraft Factory",
	{
		["Aircraft Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Car Parts Factory",
	{
		["Car Parts Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Clothing Factory",
	{
		["Clothing Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Access Faction Clothing Factory",
	{
		["Faction Clothing Factory"] call A3PL_Factory_Open;
	}
],

[
	"",
	"Talk to McFishers Employee",
	{
		["mcfishers_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Switch to McFishers uniform",
	{
		["mcfisher"] call A3PL_NPC_ReqJobUniform;
	}
],

[
	"",
	"Talk to Taco Hell Employee",
	{
		["tacohell_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Switch to Taco Hell uniform",
	{
		["tacohell"] call A3PL_NPC_ReqJobUniform;
	}
],

[
	"",
	"Talk to mailman",
	{
		["mailman_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Roadworker",
	{
		["roadworker_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Fisherman",
	{
		["fisherman_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Sheriff",
	{
		["police_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Dispatch",
	{
		["dispatch_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Medic",
	{
		["fifr_initial"] call A3PL_NPC_Start;
	}
],


[
	"",
	"Talk to Bank Employee",
	{
		["bank_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to USCG Officer",
	{
		["uscg_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to supermarket employee",
	{
		["auct_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Perks NPC",
	{
		if (!(["motorhead"] call A3PL_Lib_hasPerk)) exitwith {["System: You do not have the motorhead perk! Please visit the forum for information on how to purchase it.",Color_Red] call A3PL_Player_Notification;};
		["Shop_Perks"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Trucker",
	{
		["trucker_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Farmer",
	{
		["farmer_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Oil Recoverer",
	{
		["oil_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to Oil Trader",
	{
		["oilbarrel_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to FAA 1",
	{
		["faastart_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to FAA 2",
	{
		["faastop_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Verizon",
	{
		["verizon_initial"] call A3PL_NPC_Start;
	}
],


[
	"",
	"Talk to Drugs Dealer",
	{
		["Shop_DrugsDealer"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Black Market",
	{
		["Shop_BlackMarket"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Guns NPC",
	{
		if (handgunWeapon player != "") exitwith {
			["System: please un-holster your weapon before accessing this shop!"] call A3PL_Player_Notification;
		};
		if (["ccp",player] call A3PL_DMV_Check) then
		{
			["Shop_Guns_Vendor"] call A3PL_Shop_Open;
		} else
		{
			["You do not have a Concealed Carry Permit!",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	"Talk to Legal BP NPC",
	{
		if (["fml",player] call A3PL_DMV_Check) then
		{
			["Shop_BP_Vendor"] call A3PL_Shop_Open;
		} else
		{
			["You do not have a weapons manufacturing license!",Color_Red] call A3PL_Player_Notification;
		};
	}
],

[
	"",
	"Talk to Vehicles NPC",
	{
		["Shop_Guns_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Supermarket NPC",
	{
		["Shop_Supermarket"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Government NPC",
	{
		["government_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to DOJ NPC",
	{
		["doj_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to DOC NPC",
	{
		["doc_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Talk to DMV NPC",
	{
		["dmv_initial"] call A3PL_NPC_Start;
	}
],
[
	"",
	"Access DMV Shop",
	{
		private ["_whitelist"];
		_whitelist = "dmv";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can use this shop",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_DMV_Supplies_Vendor"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Start working as the Mafia",
	{
		private ["_whitelist"];
		_whitelist = "mafia";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can access this!",_whitelist],Color_Red] call A3PL_Player_Notification;};
		[] call A3PL_Criminal_MafiaStart;
	}
],

[
	"",
	"Access Mafia Supplies",
	{
		private ["_whitelist"];
		_whitelist = "mafia";
		if ((player getVariable ["job","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can access this!",_whitelist],Color_Red] call A3PL_Player_Notification;};
		["Shop_Mafia"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Spawn DMV Tow Truck",
	{
		private ["_whitelist"];
		_whitelist = "dmv";
		if ((player getVariable ["faction","citizen"]) != _whitelist) exitwith {[format ["System: Only the %1 faction can rent tow trucks!",_whitelist],Color_Red] call A3PL_Player_Notification;};
		[] call A3PL_DMV_Truck;
	}
],

[
	"",
	"Talk to Hunting NPC",
	{
		["Shop_Hunting_Supplies"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Talk to Roadside Service Worker",
	{
		["roadside_service_initial"] call A3PL_NPC_Start;
	}
],

[
	"",
	"Access Gem Stone Shop",
	{
		["Shop_GemStone"] call A3PL_Shop_Open;
	}
],


[
	"",
	"Buy/Sell halloween items with Candy",
	{
		["Shop_Halloween","candy"] call A3PL_Shop_Open;
	}
],

[
	"",
	"Skin animal",
	{
		[player_objintersect] call A3PL_Hunting_Skin;
	}
]
