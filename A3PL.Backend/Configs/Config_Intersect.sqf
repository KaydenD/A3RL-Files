//Replaces memory point/interaction text and sets the correct icon,uses default icon and memory point name if not defined!
//NameOfSelection,Name to display,Icon to use
//Does not support icons located in mission folder
private ["_dir"];
_dir = "\a3\ui_f\data\";

//Mainly for placeables or objects with no proper bones in fire geometry
Config_Intersect_NoName =
[
	["RoadCone_F","Cone","\a3\ui_f\data\gui\Rsc\RscDisplayArcadeMap\icon_toolbox_triggers_ca.paa"],
	["Box_GEN_Equip_F",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa"] //temp || Access virtual storage
];
publicVariable "Config_Intersect_NoName";

//Mainly for groundWeaponHolder which has no fire geometry and no intersection but a cursortarget
Config_Intersect_NoNameNoFire =
[
	["GroundWeaponHolder","Gear","\a3\ui_f\data\gui\cfg\Hints\gear_ca.paa"]
];
publicVariable "Config_Intersect_NoNameNoFire";

//Our defined variable for using the alternative intersect function, which has support for moving vehicles
Config_Intersect_Cockpits =
[
	/*
	"A3PL_Goose_Base",
	"A3PL_Goose_USCG",
	"A3PL_Cessna172",
	"A3PL_C_Heli_Light_01_civil_F",
	"A3PL_C_Plane_Civil_01_F",
	"Heli_Medium01_H",
	"Heli_Medium01_Coastguard_H",
	"Heli_Medium01_Sheriff_H",
	"Heli_Medium01_Luxury_H",
	"Heli_Medium01_Medic_H",
	"Heli_Medium01_Military_H",
	"Heli_Medium01_Veteran_H"
	*/
];
publicVariable "Config_Intersect_Cockpits";

//here we define the names we want to show using our alternative intersect function
Config_Intersect_CockpitActions =
[
	//Goose, last value indicates the vectorDotProduct between the vehicle and getCameraViewDirection
	//get the vector using (getCameraViewDirection player) vectorDotProduct (vectorDirVisual (vehicle player))
	/*
	["goose_floats",localize"STR_INTSECT_TOGGLEFLOATS",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.649795], //Toggle Floats
	["goose_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.781192], //Toggle Fuelpump
	["goose_gear",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.548871], //Toggle Gear
	["goose_bat",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.444827], //Toggle Battery
	["goose_flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.521573], //Adjust Flaps Upward
	["goose_flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.521573], //Adjust Flaps Downward
	["goose_gen",localize"STR_INTSECT_SWITCHGEN",_dir+"IGUI\Cfg\Actions\repair_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.883998], //Switch Generator
	["goose_ign","Switch Ignition/Starter Left",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.644358],
	["goose_ign",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.644358], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.421354], //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"},0.434918],//Toggle Collision Lights
	["C172_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.806984], //Toggle Fuelpump
	["C172_batteries",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Cessna172"},0.811012], //Toggle Battery
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.756685], //Adjust Flaps Upward
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.756685], //Adjust Flaps Downward
	["C172_Ignition",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.8006], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.811762],  //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.814891],//Toggle Collision Lights
	["switch_radio_atc",localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"},0.893477], //Toggle ATC Radio
	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.470752], //Toggle Starter (Engine 1)
	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.470752], //Toggle Starter (Engine 2)
	["switch_throttle", format [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.384614], //Throttle Closed (Engine 1)
	["switch_throttle2", format [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.279831], //Throttle Closed (Engine 2)
	["switch_radio_atc", localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.0614795], //Toggle ATC Radio
	["switch_radio_music", "Toggle Music",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_music_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.00826693],
	["action_screen1", "",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\arrow_down_gs.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.189574],
	["switch_batteries", localize"STR_INTSECT_TOGBATT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_batt_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.0110944], //Toggle Batteries
	["Interior_Lights", localize"STR_INTSECT_COCKLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.00783748], //Cockpit Lights
	["Searchlight_Switch", localize"STR_INTSECT_TOGGLESL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.00221944], //Toggle Searchlight
	["switch_lightsac", localize"STR_INTSECT_TOGCOLLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.104278], //Toggle Collision Lights
	["switch_lightsldg", localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.0762112] //Toggle Head Lights
	["switch_rotor_brake", localize"STR_INTSECT_TOGROTBR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_brk_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},-0.257675], //Toggle Rotor Brake
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.466195], //Toggle Starter (Engine 1)
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.466195], //Toggle Starter (Engine 2)
	["switch_throttle_2", [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.377781], //Throttle Closed (Engine 1)
	["switch_throttle2_2", [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"},0.303717] //Throttle Closed (Engine 2)
	*/
];
publicVariable "Config_Intersect_CockpitActions";

Config_IntersectArray =
[
	//moonshine
	["distillery_end","Install hose",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((count (nearestObjects [player_objintersect, ["A3PL_Distillery_Hose"], 2])) > 0) && ((count ([player_objintersect] call A3PL_Lib_AttachedAll)) < 1) }],
	["distillery_main","Start distillery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{true}],
	["distillery_main","Check distillery status",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect getVariable ["running",false])}],
	["distillery_main","Add item to distillery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{true}],
	["item_Pickup","Connect jug to hose","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Distillery_Hose") && ((count ([player_objIntersect] call A3PL_Lib_AttachedAll)) < 1)}],
	["item_Pickup","Grind wheat into yeast","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup","Grind wheat into malt","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup","Grind corn into cornmeal","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["scooter_driver", "Use jerrycan", "\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa", {player_itemClass == "jerrycan" && (typeOf player_objintersect == "C_Quadbike_01_F")}],

	//hunting
	["spine2","Skin animal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar"]) && !alive player_objintersect}],
	["hips","Skin animal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar"]) && !alive player_objintersect}],
	["spine","Skin animal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar"]) && !alive player_objintersect}],
	["head","Skin animal",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{((typeOf player_objintersect) IN ["Sheep","Sheep02","Sheep03","Goat","Goat02","Goat03","WildBoar"]) && !alive player_objintersect}],
	["item_pickup","Tag meat",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{(player_objintersect getVariable ["class","unknown"]) IN ["meat_sheep","meat_goat","meat_boar","mullet","shark_2lb","shark_4lb","shark_5lb","shark_7lb","shark_10lb"]}],

	//drugs
	["trunkinside","Cure bud","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_WorkBench") && (player_itemClass == "cannabis_bud")}],
	["item_pickup","Check cure status","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Cannabis_Bud")}],
	["item_Pickup","Grind cannabis","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup","Collect grinded cannabis","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Mixer")}],
	["item_Pickup","Bag marijuana","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((typeOf player_objintersect) == "A3PL_Scale")}],

	["Toggle_Ramp","Lower/Raise Car Ramp",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect isKindOf "A3PL_Car_Trailer"}], //Lower/Raise Ramp

	//Garbage Truck/Job
	["Bin_Controller1","Flip Left Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin1" == 0.1)}],
	["Bin_Controller1","Lower Left Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin1" > 0.5)}],
	["Bin_Controller1","Flip Right Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin2" == 0.1)}],
	["Bin_Controller1","Lower Right Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin2" > 0.5)}],
	["Bin_Controller2","Flip Left Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin1" == 0.1)}],
	["Bin_Controller2","Lower Left Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin1" > 0.5)}],
	["Bin_Controller2","Flip Right Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin2" == 0.1)}],
	["Bin_Controller2","Lower Right Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& (player_objintersect animationSourcePhase "Bin2" > 0.5)}],
	["Lid","Open Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Lid" < 0.5)}],
	["Lid","Load bin onto truck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{[player_objintersect] call A3PL_Waste_CheckNear}],
	["bin1","Unload bin from truck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_P362_Garbage_Truck") && (player_objintersect animationSourcePhase "Bin1" == 0.1)}],
	["bin2","Unload bin from truck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_P362_Garbage_Truck") && (player_objintersect animationSourcePhase "Bin2" == 0.1)}],
	["Lid","Pickup bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_WheelieBin"}],
	["Lid","Close Bin",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Lid" > 0.5)}],


	["goose_floats",localize"STR_INTSECT_TOGGLEFLOATS",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Floats
	["goose_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Fuelpump
	["goose_gear",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\Cfg\Actions\autohover_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Gear
	["goose_bat",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Battery
	["goose_flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Adjust Flaps Upward
	["goose_flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Adjust Flaps Downward
	["goose_gen",localize"STR_INTSECT_SWITCHGEN",_dir+"IGUI\Cfg\Actions\repair_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Switch Generator
	["goose_ign",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}], //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Goose_Base"}],//Toggle Collision Lights

	["C172_fuelpump",localize"STR_INTSECT_TOGGLEFP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle Fuelpump
	["C172_batteries",localize"STR_INTSECT_TOGGLEBAT",_dir+"IGUI\Cfg\Actions\ico_cpt_batt_on_ca",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle Battery
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLUP",_dir+"IGUI\Cfg\Actions\flapsretract_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Adjust Flaps Upward
	["Switch_C172_Flaps",localize"STR_INTSECT_ADJFLDWN",_dir+"IGUI\Cfg\Actions\flapsextend_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Adjust Flaps Downward
	["C172_Ignition",localize"STR_INTSECT_SWITCHIGN2",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Switch Ignition/Starter
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}],  //Toggle Head Lights
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}],//Toggle Collision Lights
	["switch_radio_atc",localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "A3PL_Cessna172"}], //Toggle ATC Radio

	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 1)
	["switch_starter", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 2)
	["switch_throttle", format [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 1)
	["switch_throttle2", format [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 2)
	["switch_radio_atc", localize"STR_INTSECT_TOGATCR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_ATC_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle ATC Radio
	["switch_batteries", localize"STR_INTSECT_TOGBATT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_batt_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Batteries
	["Interior_Lights", localize"STR_INTSECT_COCKLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Cockpit Lights
	["Searchlight_Switch", localize"STR_INTSECT_TOGGLESL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Searchlight
	["switch_lightsac", localize"STR_INTSECT_TOGCOLLIGHT",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Collision Lights
	["switch_lightsldg", localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_land_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Head Lights
	["switch_rotor_brake", localize"STR_INTSECT_TOGROTBR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_brk_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Rotor Brake
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 1)
	["switch_starter_2", format [localize"STR_INTSECT_TOGSTARENG",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_start_ON_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Toggle Starter (Engine 2)
	["switch_throttle_2", format [localize"STR_INTSECT_THROTCL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 1)
	["switch_throttle2_2", format [localize"STR_INTSECT_THROTCL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_thtl_OFF_ca.paa",{(vehicle player) isKindOf "Heli_Medium01_Base_H"}], //Throttle Closed (Engine 2)


	//MERGE LATER
	["item_pickup",localize"STR_INTSECT_STACKCONE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_RoadCone","A3PL_RoadCone_x10"])}], //Stack cone
	["Pilot_Door",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
    ["Pilot_Door",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Pilot_Door",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Pilot_Door",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"]) && ((speed player_objIntersect) < 5)}], //Eject All Passengers
	["Pilot_Door",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable ["job","unemployed"]) IN ["police","uscg","usms"])}], //Detain Suspect
	["Pilot_Door",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open\Close Door
	["Pilot_Door",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["CoPilot_Door",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player) && !(player_objIntersect getVariable ["locked",true])}],	//Enter as Co-Pilot
	["CoPilot_Door",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["CoPilot_Door",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["CoPilot_Door",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"]) && ((speed player_objIntersect) < 5)}], //Eject All Passengers
	["CoPilot_Door",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["CoPilot_Door",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open\Close Door
	["CoPilot_Door",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	//Heli_Medium01
	["inspect_hitengine1",format [localize"STR_INTSECT_INSPENG",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!("inspect_hitengine1" IN (player_objIntersect getVariable "Inspection")))&&(player_objintersect animationSourcePhase "Inspect_Panel1_1" > 0.5)}], //Inspect Engine #%1
	["inspect_hitengine2",format [localize"STR_INTSECT_INSPENG",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!("inspect_hitengine2" IN (player_objIntersect getVariable "Inspection")))&&(player_objintersect animationSourcePhase "Inspect_Panel2_1" > 0.5)}], //Inspect Engine #%2
	["inspect_hithrotor1",format [localize"STR_INTSECT_INSPMAINROT",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #1
	["inspect_hithrotor2",format [localize"STR_INTSECT_INSPMAINROT",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #2
	["inspect_hithrotor3",format [localize"STR_INTSECT_INSPMAINROT",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #3
	["inspect_hithrotor4",format [localize"STR_INTSECT_INSPMAINROT",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithrotor4" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Main Rotor #4
	["inspect_hitvrotor1",format [localize"STR_INTSECT_INSPTAILROT","#1"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor #1
	["inspect_hitvrotor2",format [localize"STR_INTSECT_INSPTAILROT","#2"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor #2
	["inspect_hitvrotor3",format [localize"STR_INTSECT_INSPTAILROT","Hub"],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvrotor3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Tail Rotor Hub
	["inspect_hittransmission1",localize"STR_INTSECT_INSPTRANS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hittransmission1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Transmission
	["inspect_hitfuel1",localize"STR_INTSECT_INSPFUEL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitfuel1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Fuel
	["inspect_hitgear1",format [localize"STR_INTSECT_INSPGEAR",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #1
	["inspect_hitgear2",format [localize"STR_INTSECT_INSPGEAR",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #2
	["inspect_hitgear3",format [localize"STR_INTSECT_INSPGEAR",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear3" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Gear #3
	["inspect_hitgear4",format [localize"STR_INTSECT_INSPGEAR",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitgear4" IN (player_objIntersect getVariable "Inspection"))}],//Inspect Gear #4
	["inspect_hithstabilizerl11",format [localize"STR_INTSECT_INSPHORSTAB",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithstabilizerl11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Horizontal stabilizer #1
	["inspect_hithstabilizerr11",format [localize"STR_INTSECT_INSPHORSTAB",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hithstabilizerr11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Horizontal stabilizer #2
	["inspect_hitlight1",localize "STR_INTSECT_INSPLL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitlight1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Landing Light
	["inspect_hitpitottube1",format [localize"STR_INTSECT_INSPPTUB",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitpitottube1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Pitot Tube #1
	["inspect_hitpitottube2",format [localize"STR_INTSECT_INSPPTUB",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitpitottube2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Pitot Tube #2
	["inspect_hitstaticport1",format [localize"STR_INTSECT_INSPSTP",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitstaticport1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Static Port #1
	["inspect_hitstaticport2",format [localize"STR_INTSECT_INSPSTP",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitstaticport2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Static Port #2
	["inspect_hitvstabilizer11",localize"STR_INTSECT_INSPVERSTAB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_hitvstabilizer11" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Vertical Stabilizer
	["inspect_intake1",format [localize"STR_INTSECT_INSPINT",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_intake1" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Intake #1
	["inspect_intake2",format [localize"STR_INTSECT_INSPINT",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{!("inspect_intake2" IN (player_objIntersect getVariable "Inspection"))}], //Inspect Intake #2

	["hatchl","Toggle Left Engine Hatch",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(player_objIntersect getVariable ["locked",true]))}], //Open Left Engine Hatch
	["hatchr","Toggle Right Engine Hatch",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(player_objIntersect getVariable ["locked",true]))}], //Open Right Engine Hatch

	//bargate
	["button_bargate2",localize"STR_INTSECT_OPCLBARG",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Bargate
	["button_bargate1",localize"STR_INTSECT_OPCLBARG",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Bargate

	["Virtual_Storage",localize"STR_INTSECT_ACCVIRSTOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Access virtual storage

	// Common
	["Body",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Repair",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["collision_lights",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{true}], //Toggle Collision Lights
	["ignition",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "AllVehicles"}], //Ignition
	["lightswitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Head Lights
	["collision_lights2",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{true}], //Toggle Collision Lights
	["ignition2",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "AllVehicles"}], //Ignition
	["lightswitch2",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Head Lights
	["collision_lights3",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{true}], //Toggle Collision Lights
	["ignition3",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "AllVehicles"}], //Ignition
	["lightswitch3",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Head Lights
	["collision_lights4",localize"STR_INTSECT_TOGCOLLIGHT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_col_ON_ca.paa",{true}], //Toggle Collision Lights
	["ignition4",localize"STR_INTSECT_IGNITION",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{(vehicle player) isKindOf "AllVehicles"}], //Ignition
	["lightswitch4",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Head Lights
	["Door_RF",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["Door_LF",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])}], //Enter as Co-Pilot
	//boats
	["ship_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],	//Enter as Driver
	["ship_driver",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["ship_passenger",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],	//Enter as Passenger	//Enter as Passenger
	["ship_passenger",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors

	//drill trailer
	["lever_drillarm",localize"STR_INTSECT_REDRARM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Retract/Extend Drill Arm
	["lever_drill",localize"STR_INTSECT_REDRARMD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Retract/Extend Drill

	//pumpjack start
	["pumpjack_connect",localize"STR_INTSECT_STARTJPUMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Start Jack Pump

	//Ski
	["ski",localize"STR_INTSECT_ATTDETROPE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_Ski_Base"}], //Attach/Detach Rope
	["ski",localize"STR_INTSECT_PUSKI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeOf player_objintersect == "A3PL_Ski_Base"}], //pickup ski

	//police things
	["spine3",localize"STR_INTSECT_HANDTICKET","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{(player_ItemClass == "ticket") && (isPlayer player_objintersect)}], //Hand Ticket

	//NPC
	["spine3","Police Computer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [pc_fisd_1,pc_fisd_2,pc_fisd_3,pc_fisd_4]}],
	["spine3","FIFR Computer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [pc_fifr_1,pc_fifr_2,pc_fifr_3,pc_fifr_4]}],

	["spine3","Talk to McFishers Employee",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mcfisher,npc_mcfisher_1]}],
	["spine3","Switch to McFishers uniform",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mcfisher,npc_mcfisher_1]}],
	["spine3","Talk to Fisherman",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_fisher}],
	["spine3","Talk to Sheriff",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_police,npc_police_1,npc_police_2]}],
	["spine3","Talk to Dispatch",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_dispatch}],
	["spine3","Talk to Medic",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_emt,npc_emt_1,npc_emt_2,NPC_emt_3]}],
	["spine3","Talk to Bank Employee",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_bank,npc_bank_1,npc_bank_2,npc_bank_3,npc_bank_4]}],
	["spine3","Talk to USCG Officer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_uscg}],
	["spine3","Talk to Roadside Service Worker",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect  IN [npc_roadworker,npc_roadworker_1,npc_roadworker_2,npc_roadworker_3]}],
	["spine3","Talk to Farmer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_farmer,npc_farmer_1]}],
	["spine3","Open Prisoner Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_farmer_1]}],
	["spine3","SFP Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_sfp_sign]}],
	["spine3","Talk to Oil Recoverer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_oilrecovery}],
	["spine3","Verizon",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_verizonstart}],
	["spine3","Talk to FAA 1",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_faastart}],
	["spine3","Talk to FAA 2",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_faastop}],
	["spine3","Talk to Taco Hell Employee",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_tacohell,npc_tacohell_1,npc_tacohell_2]}],
	["spine3","Switch to Taco Hell uniform",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_tacohell,npc_tacohell_1,npc_tacohell_2]}],
	["spine3","Talk to Drugs Dealer",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_drugsdealer}],
	["spine3","Talk to Black Market",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_blackmarket}],
	["spine3","Talk to Guns NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_guns}],
	["spine3","Talk to Legal BP NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_guns}],
	["spine3","Talk to Vehicles NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_vehicles}],
	["spine3","Talk to Supermarket NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_supermarket_1]}],
	["spine3","Talk to Perks NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkshop]}],
	["spine3","Talk to Government NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_government,npc_government_1]}],
	["spine3","Talk to DOJ NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_doj_supplier}],
	["spine3","Talk to DOC NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_doc}],
	["spine3","Talk to DMV NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_dmv}],
	["spine3","Access DMV Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_dmv}],
	["spine3","Spawn DMV Tow Truck",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_dmv}],
	["spine3","Talk to Hunting NPC",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_hunting}],
	["spine3","Fishers Island Security Services",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_sfp_sign}],
	["spine3",localize"STR_INTSECT_OPIMEXMENU",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_import}], //Open Import/Export Menu
	["spine3",localize"STR_INTSECT_CONVSTOLMONEY",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_moneylaunderer}], //Convert stolen money
	["spine3","Open Silverton CCTV",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_1}], //CCTV
	["spine3","Open Elk City CCTV",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_2}], //CCTV
	["spine3","Open Central CCTV",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Cameras_3}], //CCTV
	["spine3","Start working as the Mafia",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_mafia}], //Mafia sign on
	["spine3","Access Mafia Supplies",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_mafia}], //Mafia supplies
	["spine3","Chop Nearest Vehicle",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_chopshop}], //Chop Vehicle


	//factories
	["spine3","Access Chemical Plant",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_chemicalplant}],
	["spine3","Access Steel Mill",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_steelmill}],
	["spine3","Access Oil Refinery",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_oilrefinery}],
	["spine3","Access Weapon Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_weaponfactory}],
	["spine3","Access Legal Weapon Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_weaponfactory}],
	["spine3","Access Food Processing Plant",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_foodprocessing}],
	["spine3","Access Goods Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_goodsfactory}],
	["spine3","Access Clothing Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_clothingfactory}],
	["spine3","Access Vehicle Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_vehiclefactory}],
	["spine3","Access Marine Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_marinefactory}],
	["spine3","Access Aircraft Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_aircraftfactory}],
	["spine3","Access Car Parts Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_carpartfactory}],
	["spine3","Access Weapon Parts Factory",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Big_Weapon_Dealer}],
	["spine3","Access Weapon Attachments Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Big_Weapon_Dealer}],
	["spine3","Remove Ankle Tag",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_Big_Weapon_Dealer}],

	//shops
	["spine3","Access Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_furniture2,npc_furniture_4,npc_furniture_6]}],
	["spine3","Access Furniture Shop 2",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_furniture,npc_furniture_3,npc_furniture_5]}],
	["spine3","Access Gamer Perk Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture]}],
	["spine3","Access Garden Perk Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture]}],
	["spine3","Access Mancave Perk Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture]}],
	["spine3","Access WallDecor Perk Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture]}],
	["spine3","Access Winchester Perk Furniture Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_perkfurniture]}],
	["spine3","Access General Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_medical_supplies,NPC_general_2,NPC_general_3]}],
	["spine3","Access Pinhead Larry's shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_pinhead]}],
	["spine3","Access Buckeye Buck's shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Buckeye]}],
	["spine3","Access Moonshine Willy's shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MoonshineWilly]}],
	["spine3","Access Hemlock Huck's shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Hemlock]}],
	["spine3","Access Waste Management shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_WasteManagement]}],
	["spine3","Start/Stop working for Waste Management!",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_WasteManagement]}],
	["spine3","Start/Stop working for Fishers Island Postal Service!",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_mailman]}],
	["spine3","Start/Stop working for the Great Ratsby!",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Exterminator]}],
	["spine3","Start/Stop renting a go-kart!",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Karts]}],

	//Mining mike
	["spine3","Access Mining Mike's shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],
	["spine3","Buy a Iron mining map ($500)",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],
	["spine3","Buy a Coal mining map ($500)",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],
	["spine3","Buy a Aluminium mining map ($500)",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],
	["spine3","Buy a Sulphur mining map ($500)",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],
	["spine3","Buy a Oil mining map ($1000)",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_MiningMike,NPC_MiningMike_1]}],

	["spine3","Access Hardware Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_hardware_1,NPC_hardware_2]}],
	["spine3","Access Seeds Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_Seed_Store,NPC_Seed_Store_1]}],
	["spine3","Access Gem Stone Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_gemshop]}],
	["spine3","Buy/Sell halloween items with Candy",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [npc_candy]}],
	["spine3","Access FIFR Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_fifr_supplier,NPC_fifr_supplier_1,NPC_fifr_supplier_4]}],
	["spine3","Access FIFR Firefighting Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_fifr_supplier2}],
	["spine3","Access FIFR Vehicle Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_fifr_vehicles}],
	["spine3","Access SD Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect IN [NPC_sd_supplier,NPC_sd_supplier_1]}],
	["spine3","Access SD Vehicle Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_sd_vehicles}],
	["spine3","Access FAA Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == npc_faa_supplier}],
	["spine3","Access FAA Vehicle Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_faa_vehicles}],
	["spine3","Access DOJ Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_doj_supplier}],
	["spine3","Access DOC Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_doc}],
	["spine3","Access USCG Equipment Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_uscg_supplier}],
	["spine3","Access USCG Car Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_uscg_vehicles}],
	["spine3","Access USCG Boat Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_uscg_boats}],
	["spine3","Access USCG Aircraft Shop",_dir+"IGUI\Cfg\Actions\talk_ca.paa",{player_objintersect == NPC_uscg_aircraft}],

	//bank drill
	["pilecash",localize"STR_INTSECT_STVAULTMON",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Steal Vault Money
	["Door_bankvault",localize"STR_INTSECT_CONVAULTDRI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{backpack player == "A3PL_Backpack_Drill"}], //Connect Vault Drill
	["Door_bankvault",localize"STR_INTSECT_SECVAULTD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player getVariable ["job","unemployed"]) == "police"}], //Secure Vault Door
	["drill_bit_install",localize"STR_INTSECT_INSTDRLBIT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "drill_bit"}], //Install Drill Bit
	["drill_handle",localize"STR_INTSECT_STARTVDRILL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Start Vault Drill
	["drill_handle",localize"STR_INTSECT_DISSDRILL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Dissemble Drill
	["deposit_1",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_2",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_3",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_4",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_5",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_6",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_7",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_8",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_9",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_10",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_11",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_12",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_13",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_14",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_15",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_16",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_17",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_18",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_19",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box
	["deposit_20",localize"STR_INTSECT_OPDEPBOX",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Deposit Box

	//ATM
	["ATM",localize"STR_INTSECT_USEATM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Use ATM

	//Dog cage
	["dogcage",localize"STR_INTSECT_OPK9MEN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player getVariable ["job","unemployed"] IN ["police","uscg","usms"]}], //Open K-9 Menu
	//Dog orders
	["dog",localize"STR_INTER_DOGSIT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && !(cursorobject getVariable["doFollow",true]) && ((cursorobject getVariable["owner",""]) isEqualTo getPlayerUID player)}],
	["dog",localize"STR_INTER_DOGFOLLOW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && !(cursorobject getVariable["doFollow",true]) && ((cursorobject getVariable["owner",""]) isEqualTo getPlayerUID player)}],
	["dog",localize"STR_INTER_DOGSTOPFOLLOW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf cursorobject IN ["Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"]) && (cursorobject getVariable["doFollow",true]) && ((cursorobject getVariable["owner",""]) isEqualTo getPlayerUID player)}],

	//mcfishers "","",
	["mcfishergrill",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["mcfishergrill",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["mcfishergrill",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["mcfishergrill",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["mcfishertable",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcFishersTable1",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcFishersTable2",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["mcfishergrill",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger
	["mcFishersGrill1",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger
	["mcFishersGrill2",localize"STR_INTSECT_PLACEBURGER","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Burger


	//fisherman
	["net",localize"STR_INTSECT_BUSENET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Net
	["buoy",localize"STR_INTSECT_COLLNET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["fishstate",-1]) == -1)}], //Collect Net
	["buoy",localize"STR_INTSECT_DEPLNET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(simulationEnabled player_objIntersect) && ((player_objintersect getVariable ["fishstate",-1]) == -1)}], //Deploy Net
	["buoy","Bait net",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(simulationEnabled player_objIntersect) && ((player_objintersect getVariable ["fishstate",-1]) > -1)}], //Bait Net
	["bucket",localize"STR_INTSECT_BUSEBUCK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Bucket

	//harvest
	["farmingplant",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Harvest Plant
	["plant_cannabis",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Harvest Plant
	["lettuce",localize"STR_INTSECT_HARPLANT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect getVariable ["growState",-1] != -1}], //Harvest Plant

	//Buying tickets for lottery system
	["EstateSign",localize"STR_INTSECT_BUYHOUSE",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{true}], //Buy House

	//signs
	["greenhousesign",localize"STR_INTSECT_RENTGH",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{true}], //Rent Greenhouse
	["sign_business",localize"STR_INTSECT_RENTBUSI",_dir+"IGUI\Cfg\Actions\settimer_ca.paa",{true}], //Rent Business

	//FD interactions
	//interactions on adapter ends
	["fd_hoseend",localize"STR_INTSECT_CONROLHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_hose") && (typeOf player_objintersect == "A3PL_FD_HoseEnd1_Float")}], //Connect Rolled Hose
	["fd_hoseend",localize"STR_INTSECT_CONHOSETAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_FD_HoseEnd1_Float")}], //hose to hydrant adapter || Connect Hose To Adapter
	["fd_hoseend",localize"STR_INTSECT_CONHOSETAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect IN ["A3PL_FD_HoseEnd1"])}], //hose adapter to hose adapter ||Connect Hose To Adapter
	["fd_hoseend",localize"STR_INTSECT_HOLDHOSEAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Hold Hose Adapter
	["fd_hoseend","Rollup Hose",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}],

	//Y-adapter
	["fd_yadapter_in",localize"STR_INTSECT_CONHOSETIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && ((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Inlet
	["fd_yadapter_out1",localize"STR_INTSECT_CONHOSETIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && ((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Inlet
	["fd_yadapter_out2",localize"STR_INTSECT_CONHOSETOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_yAdapter") && ((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Outlet

	//tanker,gas station
	["outlet_4",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_Tanker_Trailer")}], //Connect Hose To Tanker
	["outlet_3",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_Tanker_Trailer")}], //Connect Hose To Tanker
	["outlet_2",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_Tanker_Trailer")}], //Connect Hose To Tanker
	["outlet_1",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_Tanker_Trailer")}], //Connect Hose To Tanker
	["outlet_1",localize"STR_INTSECT_CONHOSETTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]) && (typeOf player_objintersect == "A3PL_Fuel_Van")}], //Connect Hose To Tanker
	["gas_hoseconnect",localize"STR_INTSECT_CONHOSEADAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_adapter") && (typeOf player_objintersect == "Land_A3PL_Gas_Station")}], //Connect Hose Adapter
	["gas_hoseswitch",localize"STR_INTSECT_SWITCHGASSTORSW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //localize"STR_INTSECT_SWITCHGASSTORSW"

	//fire hydrant
	["hydrant_connect",localize"STR_INTSECT_CONHOSEADAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_adapter") && (typeOf player_objintersect == "Land_A3PL_FireHydrant")}], //Connect Hose Adapter
	["hydrant_wrench",localize"STR_INTSECT_CONHYDWRE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_ItemClass == "FD_hydrantwrench") && (typeOf player_objintersect == "Land_A3PL_FireHydrant")}], //Connect Hydrant Wrench

	//wrench itself
	["hydrantwrench",localize"STR_INTSECT_OPENHYDR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_HydrantWrench_F") && (player_objintersect animationSourcePhase "WrenchRotation" < 0.5)}], //Open Hydrant
	["hydrantwrench",localize"STR_INTSECT_CLOSEHYDR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(typeOf player_objintersect == "A3PL_FD_HydrantWrench_F") && (player_objintersect animationSourcePhase "WrenchRotation" > 0.5)}], //Close Hydrant

	//ladder truck
	["inlet_r", localize"STR_INTSECT_CONHOSETOLADIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Ladder Inlet

	//engine truck
	["inlet_ds", localize"STR_INTSECT_CONHOSETOENGIN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Inlet
	["ft_lever_11",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_10",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_8",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_7",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["ft_lever_1",localize"STR_INTSECT_OPCLDISCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Discharge
	["outlet_ps",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //discharges ||Connect Hose To Engine Discharge
	["outlet_ds",localize"STR_INTSECT_CONHOSETOENGDIS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeof (call A3PL_Lib_AttachedFirst)) IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"])}], //Connect Hose To Engine Discharge

	["burger",localize"STR_INTSECT_CREATEFISHB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Burger_Bun"], 1]; (count _burgers) > 0}], //Create Fish Burger
	["tacoshell",localize"STR_INTSECT_CREATEFTACO",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Fish_Raw","A3PL_Fish_Cooked","A3PL_Fish_Burned"], 1]; _salads= nearestObjects [player_objIntersect, ["A3PL_Salad"], 1]; ((count _burgers) > 0) && ((count _salads) > 0)}], //Create Fish Taco
	["burgerbread",localize"STR_INTSECT_CREATEFISHB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_burgers = nearestObjects [player_objIntersect, ["A3PL_Burger_Raw","A3PL_Burger_Cooked","A3PL_Burger_Burnt"], 1]; (count _burgers) > 0}], //Create Fish Burger
	["clothes",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(isNil {player_objIntersect getVariable "stock"}))}], //Buy/Sell Item
	["handcuffs",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["handcuffs",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["handcuffs",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["handcuffs",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	["wrench",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!(isNil {player_objIntersect getVariable "stock"}))}], //Buy/Sell Item
	["housekey",localize"STR_INTSECT_PICKUPKEY",_dir+"IGUI\Cfg\Actions\take_ca.paa",{isNull (attachedTo player_objintersect)}], //Pickup Key

	//retrievals
	["carInfo",localize"STR_INTSECT_VEHSTOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!isNil {player_objIntersect getVariable "positionSpawn"}}], //Vehicle Storage
	["carInfo",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!isNil {player_objIntersect getVariable "positionSpawn"}}], //Store Vehicle

	//aircraft paint
	["carInfo",localize"STR_INTSECT_PAINTAIRC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect == AircraftPaint}], //Paint Aircraft
	["carInfo",localize"STR_INTSECT_STOREAIRC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect == AircraftStore}], //Store Aircraft

	//city hall
	["Door_8_button1",localize"STR_INTSECT_OPCLDEFROOM",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}], //Open/Close Defendant Room
	["Door_8_button2",localize"STR_INTSECT_OPCLDEFROOM",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}], //Open/Close Defendant Room
	["treasurysettings",localize"STR_INTSECT_OPTREASINF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Treasury Info

	//Sheriff DP

	/*
	["garageDoor_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}],
	["garageDoor_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}],
	["Door_3_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_3_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_5_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_5_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_7_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_7_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_9_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_9_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_11_button","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	["Door_11_button2","Use SD Button",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["dispatch","police"]}],
	*/
	["jailDoor_1",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}], //Open/Close Jail Door
	["jailDoor_2",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}], //Open/Close Jail Door
	["jailDoor_3",localize"STR_INTSECT_OPCLJAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" == "police"}], //Open/Close Jail Door

	//prison/PD
	["Door_1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_1_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_2_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_3_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_3_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_4_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_4_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_5_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_5_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_6_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_6_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_7_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_7_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_8_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_8_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_9_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_9_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_10_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_10_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_11_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_11_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_12_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_12_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_13_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_13_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_14_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_14_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_15_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_15_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_16_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_16_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_22_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_22_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}],	 //Use Door Button
	["Door_23_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_23_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_24_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_25_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["Door_26_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{player getVariable "job" in ["police","uscg","usms","dispatch"]}], //Use Door Button
	["garageDoor_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_button2",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_1_source",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor_2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor1_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button
	["garageDoor2_button",localize"STR_INTSECT_USEDOORB",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",false])}], //Use Door Button

	["garageDoor_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor_button2",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor_1_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor_1_source",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor_2_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor1_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage
	["garageDoor2_button",localize"STR_INTSECT_SPVHINGAR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Spawn vehicle in garage

	["garageDoor_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor_button2",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor_1_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor_1_source",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor_2_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor1_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle
	["garageDoor2_button",localize"STR_INTSECT_STOREVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(!(player_objIntersect getVariable ["locked",false])) && (player_objintersect isKindOf "House_f")}], //Store Vehicle

	["console_cell1",format [localize"STR_INTSECT_OPENCELL",1],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell2",format [localize"STR_INTSECT_OPENCELL",2],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell3",format [localize"STR_INTSECT_OPENCELL",3],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell4",format [localize"STR_INTSECT_OPENCELL",4],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell5",format [localize"STR_INTSECT_OPENCELL",5],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell6",format [localize"STR_INTSECT_OPENCELL",6],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell7",format [localize"STR_INTSECT_OPENCELL",7],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell8",format [localize"STR_INTSECT_OPENCELL",8],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell9",format [localize"STR_INTSECT_OPENCELL",9],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell10",format [localize"STR_INTSECT_OPENCELL",10],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell11",format [localize"STR_INTSECT_OPENCELL",11],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell12",format [localize"STR_INTSECT_OPENCELL",12],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell13",format [localize"STR_INTSECT_OPENCELL",13],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_cell14",format [localize"STR_INTSECT_OPENCELL",14],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Cell %1
	["console_maincell1",format [localize"STR_INTSECT_OPENMCELL",1],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Main cell %1
	["console_maincell2",format [localize"STR_INTSECT_OPENMCELL",2],_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Main cell %1
	["console_maincell3",localize"STR_INTSECT_OPENKCELL",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //open Kitchen Cell
	["console_garage",localize"STR_INTSECT_OPENGARAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open Garage
	["console_lockdown",localize"STR_INTSECT_LOCKDOWN",_dir+"IGUI\Cfg\Actions\ico_cpt_col_ON_ca.paa",{true}], //LOCKDOWN!

	//Storage
	["StorageDoor1",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor2",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor3",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["StorageDoor1",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["StorageDoor2",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["StorageDoor3",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle

	["StorageDoor1",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	["StorageDoor2",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	["StorageDoor3",localize"STR_INTSECT_OBJSTOR","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Object Storage
	["StorageDoor1",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object
	["StorageDoor2",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object
	["StorageDoor3",localize"STR_INTSECT_STOREOBJ","A3\ui_f\data\map\Markers\Military\box_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Object

	//sheriff garage
	["SDStorageDoor3",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["SDStorageDoor6",localize"STR_INTSECT_VEHSTOR","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Vehicle Storage
	["SDStorageDoor3",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle
	["SDStorageDoor6",localize"STR_INTSECT_STOREVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{player_objIntersect animationSourcePhase "StorageDoor" < 0.1}], //Store Vehicle

	//apt building main doors
	["door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Door
	["door0_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Door

	//apt building appartment front doors
	["apt1_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_1_locked",false])}], //Door
	["apt2_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_2_locked",false])}], //Door
	["apt3_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_3_locked",false])}], //Door
	["apt4_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_4_locked",false])}], //Door
	["apt5_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_5_locked",false])}], //Door
	["apt6_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_6_locked",false])}], //Door
	["apt7_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_7_locked",false])}], //Door
	["apt8_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_8_locked",false])}], //Door
	["apt9_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_9_locked",false])}], //Door
	["apt10_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_10_locked",false])}], //Door
	["apt11_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_11_locked",false])}], //Door
	["apt12_door0",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_12_locked",false])}], //Door

	//gas station
	["gas_openmenu","Pay For Fuel",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], // Pay for fuel
	["gas_openmenu",localize"STR_INTSECT_OPENGASMENU",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open Gasstation Menu

	//showroom Garage Doors
	["garage1_open",localize"STR_INTSECT_OPENSHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Open Showroom Doors
	["garage1_close",localize"STR_INTSECT_CLOSESHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Close Showroom Doors
	["garage2_open",localize"STR_INTSECT_OPENSHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}], //Open Showroom Doors
	["garage2_close",localize"STR_INTSECT_CLOSESHOWDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_A3PL_Showroom"}],	 //Close Showroom Doors

	//trucker job
	["Door_1",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_2",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_3",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_4",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_5",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_6",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_7",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_8",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_9",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_10",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_11",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_12",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_13",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle
	["Door_14",localize"STR_INTSECT_DELIVERYVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "trucker"}], //Deliver Vehicle

	//mailman deliver
	["Door_1",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_2",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_3",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_4",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_5",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_6",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_7",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_8",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_9",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_10",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_11",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_12",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_13",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package
	["Door_14",localize"STR_INTSECT_DELPACKAGE",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(player getVariable ["job","unemployed"]) == "mailman"}], //Deliver Package

	//Casino
	["buildingcasino2_door01",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door02",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door03",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door04",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door05",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door06",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door07",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door08",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door09",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door10",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door11",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door12",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door13",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door14",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door15",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door16",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door17",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door18",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door19",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door20",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door21",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door22",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door23",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door24",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door25",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["buildingcasino2_door26",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["vaultdoor",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door
	["garagedoor",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(typeOf player_objintersect) == "Land_buildingsCasino2"}], //Door

	//new doors
	["Door_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_1_locked",false]) && !(typeOf player_objintersect in ["A3PL_EMS_Locker"])}], //Door
	//["Door_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_1_locked",false])}], //Door
	["Door_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_2_locked",false])}], //Door
	["Door_3",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_3_locked",false])}], //Door
	["Door_4",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_4_locked",false])}], //Door
	["Door_5",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_5_locked",false])}], //Door
	["Door_6",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_6_locked",false])}], //Door
	["Door_7",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_7_locked",false])}], //Door
	["Door_8",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_8_locked",false])}], //Door
	["Door_9",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_9_locked",false])}], //Door
	["Door_10",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_10_locked",false])}], //Door
	["Door_11",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_11_locked",false])}], //Door
	["Door_12",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_12_locked",false])}], //Door
	["Door_13",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_13_locked",false])}], //Door
	["Door_14",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_14_locked",false])}], //Door
	["Door_15",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_15_locked",false])}], //Door
	["Door_16",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_16_locked",false])}],	 //Door
	["Door_17",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_17_locked",false])}], //Door
	["Door_18",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_18_locked",false])}], //Door
	["Door_19",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_19_locked",false])}], //Door
	["Door_20",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_20_locked",false])}], //Door
	["Door_21",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_21_locked",false])}], //Door
	["Door_22",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_22_locked",false])}], //Door
	["Door_23",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_22_locked",false])}], //Door
	["Door_24",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_24_locked",false])}],	 //Door
	["Door_25",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_25_locked",false])}], //Door
	["Door_26",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_26_locked",false])}], //Door

	["Door_27",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_27_locked",false])}], //Door
	["Door_28",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_28_locked",false])}], //Door
	["Door_29",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_29_locked",false])}], //Door
	["Door_30",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_30_locked",false])}], //Door
	["Door_31",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_31_locked",false])}], //Door
	["Door_32",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_32_locked",false])}], //Door
	["Door_33",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_33_locked",false])}], //Door
	["Door_34",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_34_locked",false])}], //Door
	["Door_35",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_35_locked",false])}], //Door
	["Door_36",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_36_locked",false])}], //Door
	["Door_37",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_37_locked",false])}], //Door
	["Door_38",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_38_locked",false])}], //Door
	["Door_39",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_39_locked",false])}], //Door
	["Door_40",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_40_locked",false])}], //Door
	["Door_41",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_41_locked",false])}], //Door
	["Door_42",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_42_locked",false])}], //Door
	["Door_43",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_43_locked",false])}], //Door
	["Door_44",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_44_locked",false])}], //Door
	["Door_45",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_45_locked",false])}], //Door
	["Door_46",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_46_locked",false])}], //Door
	["Door_47",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_47_locked",false])}], //Door
	["Door_48",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_48_locked",false])}], //Door
	["Door_49",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_49_locked",false])}], //Door
	["Door_50",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["Door_50_locked",false])}], //Door

	["Door_1",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_Mansion01","Land_A3PL_Greenhouse","Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Motel","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4"]}], //todo: replace true with some code to check if we own the key to the house || Lock/Unlock Door
	["Door_2",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Ranch3","Land_A3PL_Ranch2","Land_A3PL_Ranch1","Land_A3PL_Greenhouse", "Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Motel","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4"]}], //Lock/Unlock Door
	["Door_3",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_Home1g_DED_Home1g_01_F","Land_Home2b_DED_Home2b_01_F","Land_Home3r_DED_Home3r_01_F","Land_Home4w_DED_Home4w_01_F","Land_Home5y_DED_Home5y_01_F","Land_Home6b_DED_Home6b_01_F","Land_A3PL_Motel","Land_A3PL_BostonHouse","Land_A3PL_ModernHouse1","Land_A3PL_ModernHouse2","Land_A3PL_ModernHouse3","Land_A3PL_Shed2","Land_A3PL_Shed3","Land_A3PL_Shed4"]}], //Lock/Unlock Door
	["Door_4",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}], //Lock/Unlock Door
	["Door_5",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}], //Lock/Unlock Door
	["Door_6",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}], //Lock/Unlock Door
	["Door_7",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel"]}], //Lock/Unlock Door
	["Door_8",localize"STR_INTSECT_LOUNDOOR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf ([] call A3PL_Intersect_cursortarget)) IN ["Land_A3PL_Motel","Land_Mansion01"]}], //Lock/Unlock Door

	//new knock doors
	["Door_1",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(typeOf player_objintersect in ["A3PL_EMS_Locker"])}], //Knock On Door
	["Door_2",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_3",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_4",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_5",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_6",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_7",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_8",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_9",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],  //Knock On Door
	["Door_10",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_11",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_12",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_13",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_14",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_15",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_16",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_17",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_18",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_19",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_20",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_21",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_22",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_23",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_24",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_25",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_26",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_26",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_27",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_28",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_29",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_30",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_31",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_32",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_33",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_34",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_35",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_36",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_37",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_38",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_39",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_40",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_41",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_42",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_43",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_44",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_45",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_46",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_47",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_48",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_49",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door
	["Door_50",localize"STR_INTSECT_KNOCKONDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Knock On Door

	["garageButton",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Garage Door

	//jayhawk
	["Door_RB",localize"STR_INTSECT_BOARDHELISSIDE",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(typeOf player_objintersect == "A3PL_Jayhawk") && (vehicle player == player) && !(player_objIntersect getVariable ["locked",true])}], //Board Helicopter (Side)
	["ignition_Switch",localize"STR_INTSECT_SWITCHIGN",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\igui_wlight_eng_ca.paa",{typeOf (vehicle player) IN ["A3PL_Jayhawk"]}], //Switch Ignition
	["battery",localize"STR_INTSECT_SWITCHBAT",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{true}], //Switch Battery
	["gen1",localize"STR_INTSECT_APUGEN",_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{true}], //APU Generator
	["gen2",format [localize"STR_INTSECT_ENGGEN",1],_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{true}], //ENG Generator NO.%1
	["gen3",format [localize"STR_INTSECT_ENGGEN",2],_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{true}], //ENG Generator NO.%1
	["apucontrol",localize"STR_INTSECT_APUCONT",_dir+"IGUI\Cfg\Actions\repair_ca.paa",{true}], //APU Control
	["ecs",localize"STR_INTSECT_ECSSTART",_dir+"gui\Rsc\RscDisplayArcadeMap\editor_wind_min_ca.paa",{true}], //ECS/Start
	["fuelpump",localize"STR_INTSECT_FUELPUMP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{true}], //Fuel Pump
	["windshield",localize"STR_INTSECT_WINDSHIELD",_dir+"gui\Rsc\RscDisplayArcadeMap\rainy_ca.paa",{true}], //Windshield
	["fold",localize"STR_INTSECT_UNFOJAYHWK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Unfold/Fold Jayhawk
	["Fold_switch",localize"STR_INTSECT_UNFOJAYHWK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Unfold/Fold Jayhawk
	["Interior_Lights",localize"STR_INTSECT_COCKLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Cockpit Lights
	["Searchlight_Switch",localize"STR_INTSECT_TOGGLESL",_dir+"IGUI\Cfg\Actions\engine_on_ca.paa",{true}], //Toggle Searchlight


	["PatrolLadder",localize"STR_INTSECT_USELADDER",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Ladder
	["boatdoor",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{true}], //Open/Close Door
	["driver",localize"STR_INTSECT_DRIVESHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Drive Ship
	["cargo1",localize"STR_INTSECT_CARGOSHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{true}], //Cargo Ship
	["cargo2",localize"STR_INTSECT_CARGOSHIP",_dir+"IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{true}], //Cargo Ship
	["extinguisher",localize"STR_INTSECT_CONTREXTING",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_fire_put_down_ca.paa",{true}], //Control Extinguisher
	["extPump",localize"STR_INTSECT_TOGGLEPUMP",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{true}], //Toggle Pump
	["extPressure",localize"STR_INTSECT_TOGGLEPRESS",_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}], //Toggle Pressure

	//police stuff
	["Spine1",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["Spine3",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["RightHand",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["LeftHand",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["LeftForeArm",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["RightForeArm",localize"STR_INTSECT_CUFFUN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_Itemclass == "handcuffs") && (isPlayer player_objintersect)or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]&& (isPlayer player_objintersect)}], //Cuff/Uncuff
	["Spine3",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect)&& ((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_objintersect getVariable ["Cuffed",true])}], //Drag
	["Spine1",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect)&& ((player getVariable "job") IN ["police","uscg","faa","usms"]) && (player_objintersect getVariable ["Cuffed",true])}], //Drag
	["Spine3","Grab","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && ((player getVariable "job") IN ["police","uscg","usms"]) && ((surfaceIsWater position player) || player_objintersect getVariable ["dragged",false])}], //Drag
	["Spine1","Grab","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && ((player getVariable "job") IN ["police","uscg","usms"]) && ((surfaceIsWater position player) || player_objintersect getVariable ["dragged",false])}], //Drag
	["spine3",localize"STR_INTSECT_KICKDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player_objintersect == "a3pl_handsupkneelcuffed"}], //Kick Down
	["Spine3",localize"STR_INTSECT_PATDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player getVariable "job") IN ["police","uscg","faa","usms"]) && (isPlayer player_objintersect)&& (animationState player_objintersect IN ["a3pl_idletohandsup","a3pl_handsuptokneel"])or ((player getVariable "job") IN ["police","uscg","faa","usms"]) && player_objintersect getVariable ["Cuffed",true]}], //Pat down

	//crim stuff
	["Spine1","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["Spine3","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["RightHand","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["LeftHand","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["LeftForeArm","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["RightForeArm","Restrain/Unrestrain","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{((player_Itemclass == "zipties") && (isPlayer player_objintersect)) || ((player_objintersect getVariable ["Zipped",true])&& (isPlayer player_objintersect))}], //zip/unzip
	["Spine3",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect)&& (player_objintersect getVariable ["Zipped",true])}], //Drag
	["Spine1",localize"STR_INTSECT_DRAG","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect)&& (player_objintersect getVariable ["Zipped",true])}], //Drag
	["Spine3",localize"STR_INTSECT_PATDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_insp_hand_1_ca.paa",{(isPlayer player_objintersect) && (player_objintersect getVariable ["Zipped",true])}], //Pat down

	["Retract_Stinger",localize"STR_INTSECT_RETRACTSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["police","uscg","usms"])&&({player_objintersect animationSourcePhase "Deploy_Stinger" > 0.5})}], //Retract Stinger
	["Deploy_Stinger",localize"STR_INTSECT_RETRACTSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["police","uscg","usms"])&&({player_objintersect animationSourcePhase "Deploy_Stinger" > 0.1})}], //Retract Stinger
	["Deploy_Stinger",localize"STR_INTSECT_DEPLSTR","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player getVariable "job") IN ["police","uscg","usms"])&&({player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5})}], //Deploy Stinger
	["Deploy_Stinger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})&&({player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5})}], //Pickup Item
	["Deploy_Stinger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})&&({player_objintersect animationSourcePhase "Deploy_Stinger" < 0.5})}], //Pickup Item To Hand
	["Deploy_Stinger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["Deploy_Stinger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	//ski
	["ski",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["ski",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],	 //Exit Vehicle
	["ski",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}],	 //Lock/Unlock Vehicle Doors

	//planes co-pilot

	//other vehicles
	//Cars, including Mustang


	//police special co-driver (spotlight)
	["Door_RF",localize"STR_INTSECT_ENTCODR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((typeOf player_objintersect) IN ["A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_CVPI_PD","A3PL_CVPI_PD_Slicktop","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop"]) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Co-Driver

	//fire truck

	["scooter_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["scooter_driver",localize"STR_INTSECT_EXITVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{!((vehicle player) == player)}], //Exit Vehicle
	["scooter_driver",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["scooter_driver",localize"STR_INTSECT_RESSCOOT",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{true}], //Reset Scooter
	["scooter_passenger",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect)}], //Enter as Passenger
	["scooter_passenger",localize"STR_INTSECT_EXITVEH","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{!((vehicle player) == player)}],	 //Exit Vehicle

	//Shop action on doors in dealership
	["carinfo",localize"STR_INTSECT_VEHINFO","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(!isNil {player_objIntersect getVariable "stock"})}], //Vehicle Info
	["sirenSwitch",localize"STR_INTSECT_TOGLIGHTB",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Lightbar
	["sirenSwitch",localize"STR_INTSECT_TOGSIR",_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Siren
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",1],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",2],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["sirenSwitch",format [localize"STR_INTSECT_TOGMANUAL",3],_dir+"IGUI\RscIngameUI\RscUnitInfoAirRTDFull\ico_cpt_sound_on_ca.paa",{(vehicle player != player)}], //Toggle Manual %1
	["carpanel",localize"STR_INTSECT_OPCLTRUNK",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk
	["carpanel",localize"STR_INTSECT_TOGWARNL",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{(vehicle player != player)}], //Toggle Warning Lights
	["policeradio",localize"STR_INTSECT_USEPOLRAD",_dir+"IGUI\RscIngameUI\RscDisplayVoiceChat\microphone_ca.paa",{(vehicle player != player)}], //Use Police Radio

	//Trailers
	["hitchTrailer",localize"STR_INTSECT_HITCHTRLER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect animationSourcePhase "Hitched" <= 1.5}], //Hitch Trailer
	["hitchTrailer",localize"STR_INTSECT_UNHITCHTRL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objIntersect animationSourcePhase "Hitched" > 1.5}], //Unhitch Trailer
	["door",localize"STR_INTSECT_OPCLTRAILD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(vehicle player) == player}], //Open/Close Trailer Door
	["door",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(vehicle player) == player}], //Lower/Raise Trailer Ramp
	["Cargo_Door_1",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect isKindOf "A3PL_Trailer_Base") && (getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Trailer Doors
	["Cargo_Door_2",localize"STR_INTSECT_LRTRAILERR",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(player_objintersect isKindOf "A3PL_Trailer_Base") && (getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Trailer Doors
	["hitchTrailer",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	//ramp on lowloader
	["ramp",localize"STR_INTSECT_LRRAMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect isKindOf "car"}], //Lower/Raise Ramp

	["Hitch_Fold","Toggle Hitch",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect animationSourcePhase "Hitched" <= 1.5) && (typeOf player_objintersect == "A3PL_Lowboy")}],
	["hitchTrailer","Toggle Gooseneck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objIntersect animationSourcePhase "Hitched" <= 1.5) && (typeOf player_objintersect == "A3PL_Lowboy")}],
	//Charger specific
	["trunkSwitch",localize"STR_INTSECT_OPCLTRUNK",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk

	//Student Driver Car
	["Front_LPlate",localize"STR_INTSECT_SPINSIGN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Spin Sign
	["Rear_LPlate",localize"STR_INTSECT_SPINSIGN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Spin Sign

	//Bowling alley
	["register",localize"STR_INTSECT_LANEREGISTER","",{true}], //Lane Registration
	["score1",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["score2",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["score3",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["score4",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["score5",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["score6",localize"STR_INTSECT_SHOWSCORE","",{true}], //Show Scoring
	["bowlingBall",localize"STR_INTSECT_PICKBALL","",{true}], //Pickup Ball

	//computers
	["sd_computer",localize"STR_INTSECT_ACCTVSYS",_dir+"map\MapControl\bunker_ca.paa",{(player getVariable ["job","unemployed"]) == "police"}], //Access CCTV System
	["PC_youtube",localize"STR_INTSECT_ACCYTCOMP",_dir+"map\MapControl\bunker_ca.paa",{true}], //Access Youtube Computer
	["PC_youtube2",localize"STR_INTSECT_ACCYTCOMP",_dir+"map\MapControl\bunker_ca.paa",{true}], //Access Youtube Computer

	["PC_youtube",localize"STR_INTSECT_CHECKOUT",_dir+"map\MapControl\bunker_ca.paa",{(player getVariable ["Youtube_Lobby",false])}], //Check Out
	["PC_youtube2",localize"STR_INTSECT_CHECKOUT",_dir+"map\MapControl\bunker_ca.paa",{(player getVariable ["Youtube_Lobby",false])}], //Check Out

	["cinemaSeat1_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat1_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat1_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat1_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down

	["cinemaSeat2_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],  //Sit Down
	["cinemaSeat2_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat2_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down

	["cinemaSeat3_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["cinemaSeat3_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}],	 //Sit Down
	["cinemaSeat3_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	// Seats
	["Seat_1",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_2",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_3",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_4",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_5",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_6",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_7",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_8",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_9",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_10",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_11",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_12",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_13",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_14",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_15",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_16",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_17",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_18",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_19",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_20",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_21",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_22",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_23",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_24",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_25",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_26",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_27",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_28",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_29",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_30",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_31",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_32",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_33",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_34",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_35",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_36",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_37",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_38",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_39",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_40",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_41",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_42",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_43",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_44",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_45",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_46",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_47",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_48",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_49",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_50",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_51",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_52",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_53",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_54",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_55",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_56",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_57",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_58",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_59",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_60",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_61",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_62",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_63",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_64",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_65",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_66",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_67",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_68",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_69",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_70",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_71",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_72",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_73",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_74",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_75",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_76",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_77",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_78",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_79",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_80",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_81",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_82",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_83",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_84",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_85",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_86",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_87",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_88",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_89",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_90",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_91",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_92",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_93",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_94",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_95",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_96",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_97",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_98",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_99",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	["Seat_100",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Sit Down
	//beds
	["bed_1",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_2",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_3",localize"STR_INTSECT_LAYDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{true}], //Lay down
	["bed_1","Get Up","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["bed_2","Get Up","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["bed_3","Get Up","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{animationState player == "a3pl_bed"}], //Get Up
	["GetIn_Driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["GetIn_Driver2",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["GetIn_Driver3",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["GetIn_Driver4",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["GetIn_Driver5",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["GetIn_CoPilot",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Co-Pilot
	["GetIn_Gunner0",format [localize"STR_INTSECT_ENTASGUN",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner1",format [localize"STR_INTSECT_ENTASGUN",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner2",format [localize"STR_INTSECT_ENTASGUN",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner3",format [localize"STR_INTSECT_ENTASGUN",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner4",format [localize"STR_INTSECT_ENTASGUN",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner5",format [localize"STR_INTSECT_ENTASGUN",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner6",format [localize"STR_INTSECT_ENTASGUN",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner7",format [localize"STR_INTSECT_ENTASGUN",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner8",format [localize"STR_INTSECT_ENTASGUN",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner9",format [localize"STR_INTSECT_ENTASGUN",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner10",format [localize"STR_INTSECT_ENTASGUN",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner11",format [localize"STR_INTSECT_ENTASGUN",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner12",format [localize"STR_INTSECT_ENTASGUN",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner13",format [localize"STR_INTSECT_ENTASGUN",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner14",format [localize"STR_INTSECT_ENTASGUN",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner15",format [localize"STR_INTSECT_ENTASGUN",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner16",format [localize"STR_INTSECT_ENTASGUN",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner17",format [localize"STR_INTSECT_ENTASGUN",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner18",format [localize"STR_INTSECT_ENTASGUN",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Gunner19",format [localize"STR_INTSECT_ENTASGUN",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Gunner %1
	["GetIn_Cargo1",format [localize"STR_INTSECT_SITINSEAT",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo2",format [localize"STR_INTSECT_SITINSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo3",format [localize"STR_INTSECT_SITINSEAT",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo4",format [localize"STR_INTSECT_SITINSEAT",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo5",format [localize"STR_INTSECT_SITINSEAT",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo6",format [localize"STR_INTSECT_SITINSEAT",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo7",format [localize"STR_INTSECT_SITINSEAT",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo8",format [localize"STR_INTSECT_SITINSEAT",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo9",format [localize"STR_INTSECT_SITINSEAT",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo10",format [localize"STR_INTSECT_SITINSEAT",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo11",format [localize"STR_INTSECT_SITINSEAT",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo12",format [localize"STR_INTSECT_SITINSEAT",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo13",format [localize"STR_INTSECT_SITINSEAT",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo14",format [localize"STR_INTSECT_SITINSEAT",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo15",format [localize"STR_INTSECT_SITINSEAT",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo16",format [localize"STR_INTSECT_SITINSEAT",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo17",format [localize"STR_INTSECT_SITINSEAT",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo18",format [localize"STR_INTSECT_SITINSEAT",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo19",format [localize"STR_INTSECT_SITINSEAT",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo20",format [localize"STR_INTSECT_SITINSEAT",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo21",format [localize"STR_INTSECT_SITINSEAT",21],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo22",format [localize"STR_INTSECT_SITINSEAT",22],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo23",format [localize"STR_INTSECT_SITINSEAT",23],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo24",format [localize"STR_INTSECT_SITINSEAT",24],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo25",format [localize"STR_INTSECT_SITINSEAT",25],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo26",format [localize"STR_INTSECT_SITINSEAT",26],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo27",format [localize"STR_INTSECT_SITINSEAT",27],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo28",format [localize"STR_INTSECT_SITINSEAT",28],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo29",format [localize"STR_INTSECT_SITINSEAT",29],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo30",format [localize"STR_INTSECT_SITINSEAT",30],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo31",format [localize"STR_INTSECT_SITINSEAT",31],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo32",format [localize"STR_INTSECT_SITINSEAT",32],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo33",format [localize"STR_INTSECT_SITINSEAT",33],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo34",format [localize"STR_INTSECT_SITINSEAT",34],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo35",format [localize"STR_INTSECT_SITINSEAT",35],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo36",format [localize"STR_INTSECT_SITINSEAT",36],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo37",format [localize"STR_INTSECT_SITINSEAT",37],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo38",format [localize"STR_INTSECT_SITINSEAT",38],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo39",format [localize"STR_INTSECT_SITINSEAT",39],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo40",format [localize"STR_INTSECT_SITINSEAT",40],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo41",format [localize"STR_INTSECT_SITINSEAT",41],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo42",format [localize"STR_INTSECT_SITINSEAT",42],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo43",format [localize"STR_INTSECT_SITINSEAT",43],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo44",format [localize"STR_INTSECT_SITINSEAT",44],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo45",format [localize"STR_INTSECT_SITINSEAT",45],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo46",format [localize"STR_INTSECT_SITINSEAT",46],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo47",format [localize"STR_INTSECT_SITINSEAT",47],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo48",format [localize"STR_INTSECT_SITINSEAT",48],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo49",format [localize"STR_INTSECT_SITINSEAT",49],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Cargo50",format [localize"STR_INTSECT_SITINSEAT",50],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["GetIn_Driver",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Driver
	["GetIn_Driver2",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Driver
	["GetIn_Driver3",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Driver
	["GetIn_Driver4",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Driver
	["GetIn_Driver5",localize"STR_INTSECT_MOVETODRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Driver
	["GetIn_CoPilot",localize"STR_INTSECT_MOVETOCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Co-Pilot
	["GetIn_Gunner0",format [localize"STR_INTSECT_MOVTOGUNNR",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner1",format [localize"STR_INTSECT_MOVTOGUNNR",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner2",format [localize"STR_INTSECT_MOVTOGUNNR",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner3",format [localize"STR_INTSECT_MOVTOGUNNR",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner4",format [localize"STR_INTSECT_MOVTOGUNNR",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner5",format [localize"STR_INTSECT_MOVTOGUNNR",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner6",format [localize"STR_INTSECT_MOVTOGUNNR",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner7",format [localize"STR_INTSECT_MOVTOGUNNR",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner8",format [localize"STR_INTSECT_MOVTOGUNNR",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner9",format [localize"STR_INTSECT_MOVTOGUNNR",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner10",format [localize"STR_INTSECT_MOVTOGUNNR",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner11",format [localize"STR_INTSECT_MOVTOGUNNR",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner12",format [localize"STR_INTSECT_MOVTOGUNNR",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner13",format [localize"STR_INTSECT_MOVTOGUNNR",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner14",format [localize"STR_INTSECT_MOVTOGUNNR",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner15",format [localize"STR_INTSECT_MOVTOGUNNR",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner16",format [localize"STR_INTSECT_MOVTOGUNNR",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner17",format [localize"STR_INTSECT_MOVTOGUNNR",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner18",format [localize"STR_INTSECT_MOVTOGUNNR",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Gunner19",format [localize"STR_INTSECT_MOVTOGUNNR",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Gunner %1
	["GetIn_Cargo1",format [localize"STR_INTSECT_MOVETOSEAT",1],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo2",format [localize"STR_INTSECT_MOVETOSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo3",format [localize"STR_INTSECT_MOVETOSEAT",3],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo4",format [localize"STR_INTSECT_MOVETOSEAT",4],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo5",format [localize"STR_INTSECT_MOVETOSEAT",5],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo6",format [localize"STR_INTSECT_MOVETOSEAT",6],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo7",format [localize"STR_INTSECT_MOVETOSEAT",7],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo8",format [localize"STR_INTSECT_MOVETOSEAT",8],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo9",format [localize"STR_INTSECT_MOVETOSEAT",9],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo10",format [localize"STR_INTSECT_MOVETOSEAT",10],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo11",format [localize"STR_INTSECT_MOVETOSEAT",11],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo12",format [localize"STR_INTSECT_MOVETOSEAT",12],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo13",format [localize"STR_INTSECT_MOVETOSEAT",13],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo14",format [localize"STR_INTSECT_MOVETOSEAT",14],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo15",format [localize"STR_INTSECT_MOVETOSEAT",15],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo16",format [localize"STR_INTSECT_MOVETOSEAT",16],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo17",format [localize"STR_INTSECT_MOVETOSEAT",17],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo18",format [localize"STR_INTSECT_MOVETOSEAT",18],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo19",format [localize"STR_INTSECT_MOVETOSEAT",19],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo20",format [localize"STR_INTSECT_MOVETOSEAT",20],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo21",format [localize"STR_INTSECT_MOVETOSEAT",21],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo22",format [localize"STR_INTSECT_MOVETOSEAT",22],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo23",format [localize"STR_INTSECT_MOVETOSEAT",23],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo24",format [localize"STR_INTSECT_MOVETOSEAT",24],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo25",format [localize"STR_INTSECT_MOVETOSEAT",25],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo26",format [localize"STR_INTSECT_MOVETOSEAT",26],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo27",format [localize"STR_INTSECT_MOVETOSEAT",27],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo28",format [localize"STR_INTSECT_MOVETOSEAT",28],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo29",format [localize"STR_INTSECT_MOVETOSEAT",29],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo30",format [localize"STR_INTSECT_MOVETOSEAT",30],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo31",format [localize"STR_INTSECT_MOVETOSEAT",31],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo32",format [localize"STR_INTSECT_MOVETOSEAT",32],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo33",format [localize"STR_INTSECT_MOVETOSEAT",33],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo34",format [localize"STR_INTSECT_MOVETOSEAT",34],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo35",format [localize"STR_INTSECT_MOVETOSEAT",35],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo36",format [localize"STR_INTSECT_MOVETOSEAT",36],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo37",format [localize"STR_INTSECT_MOVETOSEAT",37],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo38",format [localize"STR_INTSECT_MOVETOSEAT",38],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo39",format [localize"STR_INTSECT_MOVETOSEAT",39],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo40",format [localize"STR_INTSECT_MOVETOSEAT",40],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo41",format [localize"STR_INTSECT_MOVETOSEAT",41],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo42",format [localize"STR_INTSECT_MOVETOSEAT",42],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo43",format [localize"STR_INTSECT_MOVETOSEAT",43],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo44",format [localize"STR_INTSECT_MOVETOSEAT",44],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo45",format [localize"STR_INTSECT_MOVETOSEAT",45],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo46",format [localize"STR_INTSECT_MOVETOSEAT",46],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo47",format [localize"STR_INTSECT_MOVETOSEAT",47],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo48",format [localize"STR_INTSECT_MOVETOSEAT",48],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo49",format [localize"STR_INTSECT_MOVETOSEAT",49],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1
	["GetIn_Cargo50",format [localize"STR_INTSECT_MOVETOSEAT",50],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1

	//interactions for yacht
	["yacht_ladder1",localize"STR_INTSECT_USEYACHTL",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Yacht Ladder
	["yacht_ladder2",localize"STR_INTSECT_USEYACHTL",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Yacht Ladder
	["yacht_driver",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter as Driver

	["Mooring_1","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_2","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_3","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line
	["Mooring_4","Toggle Mooring Line",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Mooring Line

	//interactions for USCG cutter
	["cutterDriver",localize"STR_INTSECT_ENTUSCGCUT","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //replace true condition for USCG faction here later ||Enter USCG Cutter
	["cutterCargo1",localize"STR_INTSECT_ENTUSCGCUTC","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter USCG Cutter (Cargo)
	["cutterGunner",localize"STR_INTSECT_ENTUSCGCUTG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{true}], //Enter USCG Cutter (Gunner)

	["cutterladder1_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder1_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder2_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder2_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder3_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder3_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder4_bottom",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder
	["cutterladder4_top",localize"STR_INTSECT_USECUTLAD",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{true}], //Use Cutter Ladder

	//yacht
	["climbYacht",localize"STR_INTSECT_CLIMBINTYA",_dir+ "IGUI\Cfg\Actions\Obsolete\ui_action_ladderonup_ca.paa",{(vehicle player == player)}], //Climb Onto Yacht

	//farming
	["farmingground",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground1",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground2",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground3",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground4",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed
	["farmingground5",localize"STR_INTSECT_PLANTFARMSEED",_dir+"IGUI\Cfg\Actions\take_ca.paa",{Player_ItemClass IN ["seed_wheat","seed_marijuana","seed_corn","seed_lettuce","seed_coca"]}], //Plant Farming Seed

	//gas station
	["gasHose",localize"STR_INTSECT_GRABGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Gas Hose
	["gasHose",localize"STR_INTSECT_TOGGLEFUELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Fuel Pump
	["gasTurn",localize"STR_INTSECT_TOGGLEFUELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Fuel Pump
	["hoseback1",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback2",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback3",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["hoseback4",localize"STR_INTSECT_RETGASHOSE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Return Gas Hose
	["gastank",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"]}], //Connect Gas Hose
	["gastank",localize"STR_INTSECT_USEJERRYC",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{player_itemClass == "jerrycan"}], //Use jerrycan
	["inspect_hitfuel1",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"]}], //Connect Gas Hose
	["Repair",localize"STR_INTSECT_CONGASHOSE",_dir+"IGUI\RscIngameUI\RscUnitInfo\fuelwarning_ca.paa",{(typeOf Player_Item IN ["A3PL_Gas_Hose","A3PL_GasHose"])&& (typeOf player_objintersect == "A3PL_RHIB")}],

	//Cinema popcorn
	["popcornmachine1",localize"STR_INTSECT_GETPOPC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Get Popcorn
	["popcornmachine2",localize"STR_INTSECT_GETPOPC",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Get Popcorn

	["popcornBucket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["popcornBucket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	//Pickup Item To Hand
	["popcornBucket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}],
	["popcornBucket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	//new garage
	["garage_2_button",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Garage Door
	["garage_1_button",localize"STR_INTSECT_GARAGEDOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Garage Door
	["car_lift_button", localize"STR_INTSECT_USECARLIFT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Use Car Lift
	["car_upgrade",localize"STR_INTSECT_UPGRVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Upgrade Vehicle

	["mailtruck_trunk",localize"STR_INTSECT_OPCLMAILTD",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Mailtruck Door
	["mailtruck_trunk",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["deliverybox","Pickup Delivery Box",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	//["deliverybox","Collect Delivery Box",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],
	["deliverybox","Check Delivery Label",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],

	//rockets
	["fireworkIgnite",localize"STR_INTSECT_IGNROCKET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player_objintersect getVariable ["stock",-1]) == -1) && (simulationEnabled player_objIntersect)}], //Ignite Rocket
	["fireworkrocket",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["stock",-1] == -1)}], //Buy/Sell Item

	["atego_tow",localize"STR_INTSECT_LoadVehicle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& ((player getVariable ["job","unemployed"]) == "Roadside_Service")}],// && !(player_objIntersect getVariable ["Towing",true])
	["atego_tow",localize"STR_INTSECT_UnloadVehicle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])&& ((player getVariable ["job","unemployed"]) == "Roadside_Service")}],//&& (player_objIntersect getVariable ["Towing",true])
	["Ramp_Switch",localize"STR_INTSECT_TOGGRAMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],

	["Spotlight_Switch",localize"STR_INTSECT_TOGREARSPOTL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Rear Spotlight

	["carinfo",localize"STR_INTSECT_IMPNEARVEH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{vehicleVarName player_objintersect IN ["Shop_Impound","Shop_Impound_1","Shop_Impound_2","Shop_Impound_3"]}], //Impound Nearest Vehicle


	//impound lot
	["impound_Door_button",localize"STR_INTSECT_OPCLIMPGATE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Impound Gate
	["impound_Door_button_2",localize"STR_INTSECT_OPCLIMPGATE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Impound Gate

	//Fire station
	["big_Door_1_1_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_1_2_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["big_Door_2_1_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_2_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],	 //Door

	["bay_Door_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["Room_All_switch_1",localize"STR_INTSECT_TURNONALLL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On All Lights
	["Room_1_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_1_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_2_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_3_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_4_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_5_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_6_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_7_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_8_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_9_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_1",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_2",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_3",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_4",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_5",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_6",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_7",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_8",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_9",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights
	["Room_10_switch_10",localize"STR_INTSECT_TURNONLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On Lights

	["bay_Door_1_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_1_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_2_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_3_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_4_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_5_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_6_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_7_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["bay_Door_8_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door

	["big_Door_1_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_1_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_switch_1",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Door
	["big_Door_2_switch_2",localize"STR_INTSECT_DOOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],	 //Door

	//FD Ladder


	//Fire truck
	["Ladder_action",localize"STR_INTSECT_TAKELADDER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_objintersect animationPhase "ladder" < 0.5}], //Take Ladder
	["Ladder_action",localize"STR_INTSECT_PUTBACKLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{_ladders = nearestObjects [player, ["A3PL_Ladder"], 2]; (count _ladders) > 0}], //Put Back Ladder

	["Hose_1_action",format [localize"STR_INTSECT_PUTBACKHOSE",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_2_action",format [localize"STR_INTSECT_PUTBACKHOSE",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_3_action",format [localize"STR_INTSECT_PUTBACKHOSE",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_4_action",format [localize"STR_INTSECT_PUTBACKHOSE",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1
	["Hose_5_action",format [localize"STR_INTSECT_PUTBACKHOSE",5],_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "FD_Hose"}], //Put Back Hose %1

	["Hose_1_action",format [localize"STR_INTSECT_TAKEHOSE",1],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_1") < 1}], //Take Hose %1
	["Hose_2_action",format [localize"STR_INTSECT_TAKEHOSE",2],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_2") < 1}], //Take Hose %1
	["Hose_3_action",format [localize"STR_INTSECT_TAKEHOSE",3],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_3") < 1}], //Take Hose %1
	["Hose_4_action",format [localize"STR_INTSECT_TAKEHOSE",4],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_4") < 1}], //Take Hose %1
	["Hose_5_action",format [localize"STR_INTSECT_TAKEHOSE",5],_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect animationPhase "Hose_5") < 1}],	 //Take Hose %1

	//fire truck
	["controller_cover",localize"STR_INTSECT_TOGCONTCOV",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Controller Cover
	["FT_Switch_1",localize"STR_INTSECT_TOGDSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle DS Front Outrigger
	["FT_Switch_2",localize"STR_INTSECT_TOGDROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle DS Rear Outrigger
	["FT_Switch_3",localize"STR_INTSECT_TOGPSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle PS Front Outrigger
	["FT_Switch_4",localize"STR_INTSECT_TOGPSROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle PS Rear Outrigger
	["FT_Switch_5",localize"STR_INTSECT_TORADSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle/Raise DS Outriggers
	["FT_Switch_6",localize"STR_INTSECT_TORAPSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle/Raise PS Outriggers
	["FT_Switch_8",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //DS Floodlights
	["FT_Switch_9",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //PS Floodlights
	["FT_Switch_10",localize"STR_INTSECT_PERILIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Perimeter Lights
	["FT_Switch_11",localize"STR_INTSECT_LADDERFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Ladder Floodlight
	["FT_Switch_12",localize"STR_INTSECT_LADDERCAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Ladder Cam

	["FT_Switch_13",localize"STR_INTSECT_TOGDSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle DS Front Outrigger
	["FT_Switch_14",localize"STR_INTSECT_TOGDROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle DS Rear Outrigger
	["FT_Switch_15",localize"STR_INTSECT_TOGPSFOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle PS Front Outrigger
	["FT_Switch_16",localize"STR_INTSECT_TOGPSROUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle PS Rear Outrigger
	["FT_Switch_17",localize"STR_INTSECT_TORADSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle/Raise DS Outriggers
	["FT_Switch_18",localize"STR_INTSECT_TORAPSOUT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle/Raise PS Outriggers
	["FT_Switch_20",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //DS Floodlights
	["FT_Switch_21",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //PS Floodlights
	["FT_Switch_22",localize"STR_INTSECT_PERILIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Perimeter Lights
	["FT_Switch_23",localize"STR_INTSECT_LADDERFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Ladder Floodlight
	["FT_Switch_24",localize"STR_INTSECT_LADDERCAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Ladder Cam

	["Ladder_Controls",localize"STR_INTSECT_ENTASLADOP","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Ladder Operator
	["Ladder_Controls",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}], //Exit Vehicle




	["Ladder_Holder",localize"STR_INTSECT_LORALADRACK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Lower/Raise Ladder Rack
	["FT_Pump_Switch",localize"STR_INTSECT_TONOFFPUMP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On\Off Pump

	//FIFM
	["Room_1_switch_1","Check Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false]) && (player_objintersect getVariable ["FireAlarmCanBroke",true]) && ((player getVariable ["job","unemployed"]) == "fifr")}],
	["Room_1_switch_1","Trigger Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["Room_1_switch_1","Re-Enable Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["Room_1_switch_1","Repair Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false])  && (player_objintersect getVariable ["FireAlarmBroke",false])}],

	["door_4","Check Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false]) && (player_objintersect getVariable ["FireAlarmCanBroke",true]) && ((player getVariable ["job","unemployed"]) == "fifr")}],
	["door_4","Trigger Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objintersect getVariable ["FireAlarm",false])  && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["door_4","Re-Enable Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false]) && !(player_objintersect getVariable ["FireAlarmBroke",false])}],
	["door_4","Repair Fire Alarm",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") && (player_objintersect getVariable ["FireAlarm",false])  && (player_objintersect getVariable ["FireAlarmBroke",false])}],

	// Ambo
	["Ambo_Switch_7",localize"STR_INTSECT_REARFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Rear Floodlights
	["Ambo_Switch_8",localize"STR_INTSECT_DSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],//DS Floodlights
	["Ambo_Switch_9",localize"STR_INTSECT_PSFLOODL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //PS Floodlights
	["Ambo_Switch_10",localize"STR_INTSECT_INTLIGHTS",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Interior Lights
	["Ambo_Switch_11",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //High Beam
	["Stretcher_Action",localize"STR_INTSECT_USESTRETCH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true]) && ((player getVariable ["job","unemployed"]) == "fifr")}], //Use Stretcher
	["Stretcher_Action",format [localize"STR_INTSECT_SITINSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Sit In Seat %1
	["Stretcher_Action",format [localize"STR_INTSECT_MOVETOSEAT",2],"A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) != player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Move to Seat %1

	//Common Action
	["Switch_Fair_Available",localize"STR_INTSECT_TGLFAIRAVAIL",_dir+"IGUI\Cfg\Actions\lightsiconon_ca.paa",{player == driver player_objintersect}], //Toggle Fair Available
	["Switch_Pause_Fair",localize"STR_INTSECT_PAUSEFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Pause Fair
	["Switch_Reset_Fair",localize"STR_INTSECT_RESETFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Reset Fair
	["Switch_Start_Fair",localize"STR_INTSECT_STARTFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Start Fair
	["Switch_Stop_Fair",localize"STR_INTSECT_STOPFAIR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player == driver player_objintersect}], //Stop Fair
	["ASC_Switch",localize"STR_INTSECT_AIRSUSCONT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Air Suspension Control
	["PD_lightSwitch",localize"STR_INTSECT_TOGHEADL",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Head Lights
	["PD_Switch_8",localize"STR_INTSECT_TOGSPOTLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Spotlight
	["PD_Switch_9",localize"STR_INTSECT_LEFTALLLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Left Alley Light
	["PD_Switch_10",localize"STR_INTSECT_RIGHTALLLIGHT",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Right Alley Light
	["High_Beam_Switch",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //High Beam
	["lightSwitch",localize"STR_INTSECT_HIGHBEAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //High Beam
	["Reverse_Cam_Button",localize"STR_INTSECT_REVERSECAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Reverse Cam
	["FT_Switch_33",localize"STR_INTSECT_AIRHORN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Airhorn
	["FT_Switch_34",localize"STR_INTSECT_ELECHORN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Electric Horn
	["FT_Switch_35",localize"STR_INTSECT_ELECAIRH",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Electric Airhorn
	["FT_Switch_36",localize"STR_INTSECT_RUMBLERMAN",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Rumbler Manual
	["FT_Switch_37",localize"STR_INTSECT_T3YELP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //T3 Yelp
	["FT_Switch_38",localize"STR_INTSECT_MASTERON",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Master On
	["Directional_Switch",localize"STR_INTSECT_DIRECTMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Directional Master
	["powerswitch_1",localize"STR_INTSECT_DIRECTMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Directional Master
	["Directional_Control_Noob",localize"STR_INTSECT_DIRECTCONTR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Directional Control
	["sirenswitch_1",localize"STR_INTSECT_SIRENMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], 
	["Siren_Control_Switch",localize"STR_INTSECT_SIRENMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Siren Master
	["Siren_Control_Noob",localize"STR_INTSECT_SIRENCONTR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Siren Control
	["Laptop_Top",localize"STR_INTSECT_TURNONOFFLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On/Off Laptop
	["Laptop_Top",localize"STR_INTSECT_ACCPOLDB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Access Police Database
	["Laptop",localize"STR_INTSECT_SWIVELLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Swivel Laptop
	["Switch_Radar_Master",localize"STR_INTSECT_RADARMASTER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Radar Master
	["Switch_Radar_Rear",localize"STR_INTSECT_REARRADAR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Rear Radar
	["Switch_Radar_Front",localize"STR_INTSECT_FRONTRADAR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Front Radar
	["Switch_Radar_Master",localize"STR_INTSECT_RESETLOCKFAST",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Reset Lock/Fast
	["Lightbar_Switch",localize"STR_INTSECT_TOGLIGHTB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Lightbar
	//Red interaction
	["rotate_1",localize"STR_INTSECT_TURNONOFFLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Turn On/Off Laptop
	["rotate_2",localize"STR_INTSECT_ACCPOLDB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Access Police Database
	["rotate_2",localize"STR_INTSECT_SWIVELLAP",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}],  //Swivel Laptop

	//Mini Excavator
	["groundShov_Switch",localize"STR_INTSECT_TOGDOZBLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Toggle Dozer Blade
	["Attachment_Switch",localize"STR_INTSECT_DETATTACHM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Detach Attachment
	//["Attachment_Switch",localize"STR_INTSECT_OPERATMODE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player)}], //Operations Mode
	//["Attachment_Switch",localize"STR_INTSECT_DRIVEMODE",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(vehicle player != player)}], //Drive Mode
	["Attachment",localize"STR_INTSECT_CONNBUCKET",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Bucket"}], //Connect Bucket
	["Attachment",localize"STR_INTSECT_CONNJACKHAM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Jackhammer"}], //Connect Jackhammer
	["Attachment",localize"STR_INTSECT_CONNECTCLAW",_dir+"IGUI\Cfg\Actions\take_ca.paa",{player_ItemClass == "ME_Claw"}], //Connect Claw

	//FD Shops
	["hydrantwrench",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_hoseend",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_yadapter",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_hoserolled",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_axe",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_oxygen",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_mask",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item
	["fd_helmet",localize"STR_INTSECT_BUSEITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!((player_objintersect getVariable ["stock",-1]) == -1)}], //Buy/Sell Item

	//Mail box
	["Door_mailbox",localize"STR_INTSECT_OPCLMAILB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Open/Close Mailbox

	//city hall
	["vote1",localize"STR_INTSECT_ELECTMAYOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Elect Mayor
	["vote1",localize"STR_INTSECT_MAKEMYCANI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Make Myself Candidate
	["vote2",localize"STR_INTSECT_ELECTMAYOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Elect Mayor
	["vote2",localize"STR_INTSECT_MAKEMYCANI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Make Myself Candidate
	["vote3",localize"STR_INTSECT_ELECTMAYOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Elect Mayor
	["vote3",localize"STR_INTSECT_MAKEMYCANI",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Make Myself Candidate

	//Item pickup
	["furniture",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["furniture",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["furniture",localize"STR_INTSECT_LOADPINTOTANK",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["class",""]) == "Petrol"}],	//Load Petrol Into Tanker
	["item_pickup","Load Kerosene Into Truck",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["class",""]) == "Kerosene"}],	//Load Petrol Into Tanker
	["furniture",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["furniture",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["furniture",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
  ["furniture","Fill Bottle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeOf player_objintersect) in ["A3PL_SinkSingleCabinet","A3PL_SinkBigCounter","A3PL_ModularKitchen4"]) && (Player_ItemClass == "waterbottlempty")}],
	["item_pickup","Fill Bottle",_dir+"IGUI\Cfg\Actions\take_ca.paa",{((typeOf player_objintersect) in ["A3PL_SinkSingleCabinet","A3PL_SinkBigCounter"]) && (Player_ItemClass == "waterbottlempty")}],

	["furniture",localize"STR_INTSECT_SITDOWN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{((typeOf player_objintersect) in ["A3PL_Chair1","A3PL_Chair2","A3PL_Chair3","A3PL_Chair4","A3PL_KitchenChair1","A3PL_KitchenChair2","A3PL_Pouf","A3PL_DiningChair","A3PL_Sofa1","A3PL_Sofa2","A3PL_Sofa3","A3PL_Sofa4"])}],
	//Items
	//["deliverybox",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	//["deliverybox",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item To Hand
	["burger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["burger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item To Hand
	["burger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["burger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["burgerbread",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["burgerbread",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["burgerbread",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["burgerbread",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fishburger",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["fishburger",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fishburger",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fishburger",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["taco",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["taco",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["taco",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["taco",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["wrench",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["wrench",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["wrench",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["wrench",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["cash",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["cash",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["cash",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["bucket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["bucket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["bucket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["bucket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["buoy",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["buoy",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["buoy",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["buoy",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fireworkrocket",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["fireworkrocket",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fireworkrocket",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fireworkrocket",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	//picking up seeds
	["seedbox",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["seedbox",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["seedbox",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["seedbox",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item

	//pickup corn and marijuana
	["cornCob",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["cornCob",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["cornCob",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["cornCob",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["weedbag",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["weedbag",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["weedbag",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["weedbag",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["lettuce",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["lettuce",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["lettuce",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["lettuce",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["salad",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["salad",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["salad",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["salad",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["tacoshell",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["tacoshell",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["tacoshell",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["tacoshell",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	["fish",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fish",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fish",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fish",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item

	["fd_yadapter",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (simulationEnabled player_objIntersect)}],	 //Pickup Item
	["fd_yadapter",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (simulationEnabled player_objIntersect)}], //Pickup Item To Hand
	["fd_yadapter",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_yadapter",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fd_hoseend",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (!(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))}],	 //Pickup Item
	["fd_hoseend",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]}) && (simulationEnabled player_objIntersect) && (typeOf player_objintersect != "A3PL_FD_HoseEnd1_Float") && (!(typeOf player_objintersect IN ["A3PL_FD_HoseEnd1","A3PL_FD_HoseEnd2"]))}],	 //Pickup Item To Hand
	["fd_hoseend",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_hoseend",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["fd_hoserolled",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fd_hoserolled",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fd_hoserolled",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_hoserolled",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["fd_mask",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["fd_mask",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["fd_mask",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["fd_mask",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item
	["hydrantwrench",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["hydrantwrench",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item To Hand
	["hydrantwrench",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["hydrantwrench",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],	 //Sell Item
	["ore",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}],	 //Pickup Item
	["ore",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand
	["ore",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["ore",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}],		 //Sell Item

	["crate",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["crate",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["crate",localize"STR_INTSECT_COLLECTITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Collect Item
	["crate",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["crate",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	["clothing",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["clothing",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["clothing",localize"STR_INTSECT_COLLECTITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Collect Item
	["clothing",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["clothing",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	["Item_Pickup",localize"STR_INTSECT_PICKUPITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item
	["Item_Pickup",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["Item_Pickup",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["Item_Pickup",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item
	["Item_Pickup",localize"STR_INTSECT_PICKITEMTOHAND",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(isNil {player_objintersect getVariable ["bitem",nil]})}], //Pickup Item To Hand

	["deliverybox",localize"STR_INTSECT_CHECKITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Check Item
	["deliverybox",localize"STR_INTSECT_BUYITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(!isNil {player_objintersect getVariable ["bitem",nil]})}], //Buy Item
	["deliverybox",localize"STR_INTSECT_SELLITEM",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["owner","0"]) == (getPlayerUID player)}], //Sell Item

	//medical
	["spine3","Resuscitate","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{(Player_ActionCompleted) && isPlayer player_objIntersect && !(player_objIntersect getVariable ["A3PL_Medical_Alive", true])}], //Chest Compressions
	["spine3",localize"STR_INTSECT_OPENMEDICALMEN","\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\si_prone_down_ca.paa",{((player getVariable ["job","unemployed"]) == "fifr") || ((surfaceIsWater position player) && ((player getVariable ["job","unemployed"]) == "uscg"))}],

	//Ladder Actions
	["Ladder_1",localize"STR_INTSECT_PICKUPLAD",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeof player_objintersect == "A3PL_Ladder"}], //Pickup Ladder
	["Ladder_1",format [localize"STR_INTSECT_CLIMBUPL",1],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}], //Climb Up Ladder %1
	["Ladder_2",format [localize"STR_INTSECT_CLIMBUPL",2],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_3",format [localize"STR_INTSECT_CLIMBUPL",3],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_4",format [localize"STR_INTSECT_CLIMBUPL",4],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_5",format [localize"STR_INTSECT_CLIMBUPL",5],_dir+"IGUI\Cfg\Actions\ladderup_ca.paa",{true}],//Climb Up Ladder %1
	["Ladder_1",format [localize"STR_INTSECT_CLIMBDOWNL",1],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_2",format [localize"STR_INTSECT_CLIMBDOWNL",2],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_3",format [localize"STR_INTSECT_CLIMBDOWNL",3],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_4",format [localize"STR_INTSECT_CLIMBDOWNL",4],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_5",format [localize"STR_INTSECT_CLIMBDOWNL",5],_dir+"IGUI\Cfg\Actions\ladderdown_ca.paa",{true}], //Climb Down Ladder %1
	["Ladder_1",localize"STR_INTSECT_EXRELADDER",_dir+"IGUI\Cfg\Actions\take_ca.paa",{typeof player_objintersect == "A3PL_Ladder"}], //Extend/Retract Ladder

	//RBM
	["Door_1",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_1",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true]) && (player_objintersect isKindOf "A3PL_RBM")}], //Enter as Driver
	["Door_1",localize"STR_INTSECT_ENTERASENG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])&& (player_objintersect isKindOf "A3PL_RBM")}], //Enter as Engineer
	["Door_1",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])&& (player_objintersect isKindOf "A3PL_RBM")}], //Enter as passanger
	["Door_1",localize"STR_INTSECT_ENTASCAP","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])&& (player_objintersect isKindOf "A3PL_RBM")}], //Enter as Captain
	["Door_1",localize"STR_INTSECT_ENTERASGUN","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])&& (player_objintersect isKindOf "A3PL_RBM")}], //Enter as Gunner
	["Bow_Gun",localize"STR_INTSECT_ENTERASBOWG","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])&& (player_objintersect isKindOf "A3PL_RBM")}], //Enter as Bow Gunner

	["Lifebuoy_1_action",localize"STR_INTSECT_GRABLLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Left Lifebuoy
	["Lifebuoy_1_action",localize"STR_INTSECT_PUTBACKLLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Put Back Left Lifebuoy
	["Lifebuoy_2_action",localize"STR_INTSECT_GRABRLB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Grab Right Lifebuoy
	["Lifebuoy_2_action",localize"STR_INTSECT_PBRLIFEB",_dir+"IGUI\Cfg\Actions\take_ca.paa",{true}], //Put Back Right Lifebuoy

	["Item_Pickup",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Enter as Passenger
	["Item_Pickup",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player)&& (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Exit Vehicle
	["Item_Pickup",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&& (typeOf player_objintersect == "A3PL_Lifebuoy")}], //Eject All Passengers

	["Platform_1",localize"STR_INTSECT_TOGLPF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Toggle Left Platform
	["Platform_2",localize"STR_INTSECT_TOGRPF",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Toggle Right Platform

	["Anchor",localize"STR_INTSECT_ANCHOR",_dir+"IGUI\Cfg\Actions\take_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],//Drop/Retrieve Anchor

	// Locker
	["Door_1","Rent locker",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo "") && (typeOf player_objintersect == "A3PL_EMS_Locker") && (player getVariable["job","unemployed"] IN ["police","fifr","uscg","usms","doj","dispatch","faa","dmv"])}],
	["Door_1","Open/Close Locker",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect == "A3PL_EMS_Locker")}],
	["lockerbottom","Store in locker","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect == "A3PL_EMS_Locker")}],
	["lockertop","Store in locker","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{((player_objIntersect getVariable ["owner",""]) isEqualTo getPlayerUID player) && (typeOf player_objintersect == "A3PL_EMS_Locker")}],

	//Common Cars Doors

	["doorL",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["doorL",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["doorL",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["doorL",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["doorL",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}], //Exit Vehicle
	["doorL",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["doorL",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["doorR",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["doorR",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["doorR",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	["doorR",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["doorR",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}], //Exit Vehicle
	["doorR",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["doorR",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers

	//Little bird interactions
	["z_doorl_front",localize"STR_INTSECT_ENTERDRIVER","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["z_doorr_front",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["z_doorr_back",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["z_doorl_back",localize"STR_INTSECT_ENTASPASS","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["z_doorl_front",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["z_doorr_front",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors

	["Door_LF",localize"STR_INTSECT_ENTERDRIVER",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}], //Enter as Driver
	//Goose passenger
	["Door_LF",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true]) && (typeof player_objintersect == "A3PL_Goose_Base")}], //Enter as Passenger
	// Cessna172 passenger
	["Pilot_Door",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true]) && (typeof player_objintersect == "A3PL_Cessna172")}], //Enter as Passenger
	["CoPilot_Door",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true]) && (typeof player_objintersect == "A3PL_Cessna172")}], //Enter as Passenger
	["Door_LF",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LF2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LF3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LF4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LF5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LF6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LF6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LF6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LF6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LF6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LF6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LF6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_LB",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"])}],
	["Door_LB",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_LB6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_LB6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_LB6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_LB6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_LB6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_LB6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_LB6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_RF",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RF6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RF6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RF6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RF6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RF6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RF6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RF6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_RB",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"])}], //Open\Close Door
	["Door_RB",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB2",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk","red_ambulance_14_p_base","red_ambulance_18_p_base","red_e350_14_e_base"])}], //Open\Close Door
	["Door_RB2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB3",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB4",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB4",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB4",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB4",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB4",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB4",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB4",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB5",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB5",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB5",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB5",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB5",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB5",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB5",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle
	["Door_RB6",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],//Enter as Passenger
	["Door_RB6",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && !(player_objIntersect getVariable ["locked",true])}],		 //Exit Vehicle
	["Door_RB6",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))}], //Lock/Unlock Vehicle Doors
	["Door_RB6",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Eject All Passengers
	["Door_RB6",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])}], //Detain Suspect
	["Door_RB6",localize"STR_INTSECT_OPCLDOOR",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["Heli_Medium01_Base_H","Heli_Medium01_H","Heli_Medium01_Coastguard_H","Heli_Medium01_Sheriff_H","Heli_Medium01_Luxury_H","Heli_Medium01_Medic_H","Heli_Medium01_Military_Base_H","Heli_Medium01_Military_H","Heli_Medium01_Veteran_H","A3PL_Charger","A3PL_Charger_PD","A3PL_Charger_PD_Slicktop","A3PL_Tahoe","A3PL_Tahoe_PD","A3PL_Tahoe_PD_Slicktop","A3PL_Tahoe_FD","A3PL_Mustang","A3PL_Mustang_PD","A3PL_Mustang_PD_Slicktop","A3PL_Fuel_Van","A3PL_Transport_Van","A3PL_Silverado","A3PL_Silverado_PD","Jonzie_Ambulance","A3PL_E350","A3PL_Pierce_Ladder","A3PL_Pierce_Heavy_Ladder","A3PL_Pierce_Pumper","A3PL_Jayhawk"])}], //Open\Close Door
	["Door_RB6",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"}], //Repair Vehicle

	["Door_LF",localize"STR_INTSECT_ENTCOPIL","A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",{(player_objintersect isKindOf "Air") && (vehicle player == player)&& !(player_objIntersect getVariable ["locked",true])}], ////Enter as Co-Pilot
	["Cargo_Door_1","Toggle Compartment 1",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_2","Toggle Compartment 2",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_3","Toggle Compartment 3",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_4","Toggle Compartment 4",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_5","Toggle Compartment 5",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_6","Toggle Compartment 6",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_7","Toggle Compartment 7",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_8","Toggle Compartment 8",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_9","Toggle Compartment 9",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_10","Toggle Compartment 10",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_11","Toggle Compartment 11",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_12","Toggle Compartment 12",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_13","Toggle Compartment 13",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_14","Toggle Compartment 14",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_15","Toggle Compartment 15",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_16","Toggle Compartment 16",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_17","Toggle Compartment 17",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_18","Toggle Compartment 18",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_19","Toggle Compartment 19",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],
	["Cargo_Door_20","Toggle Compartment 20",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])}],

	["trunk",localize"STR_INTSECT_OPCLTRUNK","\a3\ui_f\data\gui\cfg\Hints\doors_ca.paa",{!(player_objIntersect getVariable ["locked",true])}], //Open/Close Trunk
	["trunkinside",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside1",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside2",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside3",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside4",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside5",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside6",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside7",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside8",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside9",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside10",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside11",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside12",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside13",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside14",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside15",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside16",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside17",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside18",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside19",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item
	["trunkinside20",localize"STR_INTSECT_PLACEITEM","\a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoput_ca.paa",{true}], //Place Item






	["door1",localize"STR_INTSECT_ENTERDRIVER",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && (!(player_objIntersect getVariable ["locked",true])) && (typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_C_Van_02_transport_F","C_Van_02_vehicle_F","I_G_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}],//Enter as Passenger
	["door1",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && (!(player_objIntersect getVariable ["locked",true]))&&(typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","I_C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}],		 //Exit Vehicle
	["door1",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))&&(typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","I_C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Lock/Unlock Vehicle Doors
	["door1",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Eject All Passengers
	["door1",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Detain Suspect
	["door1",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"&&(typeOf player_objintersect IN ["red_explorer_16_black","C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Repair Vehicle

	["door2",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && (!(player_objIntersect getVariable ["locked",true])) && (typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}],//Enter as Passenger
	["door2",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && (!(player_objIntersect getVariable ["locked",true]))&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}],		 //Exit Vehicle
	["door2",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Lock/Unlock Vehicle Doors
	["door2",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Eject All Passengers
	["door2",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Detain Suspect
	["door2",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","I_G_Van_02_transport_F","C_Van_02_vehicle_F","I_C_Van_02_transport_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F","C_Offroad_02_unarmed_white_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_black_F"])}], //Repair Vehicle

	["door3",localize"STR_INTSECT_ENTASPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && (!(player_objIntersect getVariable ["locked",true])) && (typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}],//Enter as Passenger
	["door3",localize"STR_INTSECT_EXITVEH",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!((vehicle player) == player) && (!(player_objIntersect getVariable ["locked",true]))&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}],		 //Exit Vehicle
	["door3",localize"STR_INTSECT_LUVEHDOORS",_dir+"IGUI\Cfg\Actions\Obsolete\ui_action_open_ca.paa",{(getPlayerUID player in (player_objintersect getVariable ["keyAccess",[]]))&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Lock/Unlock Vehicle Doors
	["door3",localize"STR_INTSECT_EJALLPASS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Eject All Passengers
	["door3",localize"STR_INTSECT_DETAINSUS",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{((vehicle player) == player) && ((player getVariable "job") IN ["police","uscg","usms"])&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Detain Suspect
	["door3",localize"STR_INTSECT_REPVEH",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{player_ItemClass == "repairwrench"&&(typeOf player_objintersect IN ["C_Van_02_medevac_F","C_Van_02_service_F","C_Van_02_transport_F","C_Van_02_vehicle_F","C_IDAP_Van_02_vehicle_F","C_IDAP_Van_02_transport_F"])}], //Repair Vehicle

	["door1","Drivers Door",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}], //Open\Close Door
	["door2","Passengers Door",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}], //Open\Close Door
	["door3","Side Door",_dir+"IGUI\Cfg\Actions\open_Door_ca.paa",{!(player_objIntersect getVariable ["locked",true])&&(typeOf player_objintersect IN ["C_Van_02_transport_F"])}], //Open\Close Door

	//unflip vehicle
	["hitchTrailer","Unflip vehicle",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["Door_LF","Unflip vehicle",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],
	["Door_RF","Unflip vehicle",_dir+"IGUI\Cfg\VehicleToggles\lightsiconon_ca.paa",{((vehicle player) == player) && (simulationEnabled player_objIntersect) && !(player_objIntersect getVariable ["locked",true])}],

	["furniture","Load into fuelstation tank",_dir+"IGUI\Cfg\Actions\take_ca.paa",{(player_objintersect getVariable ["class",""]) == "Petrol" && ((count (nearestObjects [player_objintersect, ["Land_A3PL_Gas_Station"], 7])) > 0)}]
];
publicVariable "Config_IntersectArray";

// If a specific intersection name is in this array it will execute and not check for a specific typeOf aka it ignores that parameter
Config_GenArray =
[
	//merge
	localize"STR_INTSECT_SPVHINGAR",  //Spawn vehicle in garage
	localize"STR_INTSECT_OPIMEXMENU", //Open Import/Export Menu

	"Unflip vehicle",

	"Lower/Raise Car Ramp",
	//Garbage Truck/Job
	"Flip Left Bin",
	"Lower Left Bin",
	"Flip Right Bin",
	"Lower Right Bin",
	"Open Bin",
	"Close Bin",
	"Toggle Hitch",
	"Toggle Gooseneck",

	//Heli_Medium01
	format [localize"STR_INTSECT_TOGSTARENG",1], //Toggle Starter (Engine 1)
	format [localize"STR_INTSECT_TOGSTARENG",2], //Toggle Starter (Engine 2)
	format [localize"STR_INTSECT_THROTCL",1], //Throttle Closed (Engine 1)
	format [localize"STR_INTSECT_THROTCL",2], //Throttle Closed (Engine 2)
	localize"STR_INTSECT_TOGATCR", //Toggle ATC Radio
	localize"STR_INTSECT_TOGBATT", //Toggle Batteries
	localize"STR_INTSECT_TOGHEADL", //Toggle Head Lights
	localize"STR_INTSECT_TOGROTBR", //Toggle Rotor Brake

	format [localize"STR_INTSECT_INSPENG",1], //Inspect Engine #%1
	format [localize"STR_INTSECT_INSPENG",2], //Inspect Engine #%2
	format [localize"STR_INTSECT_INSPMAINROT",1], //Inspect Main Rotor #1
	format [localize"STR_INTSECT_INSPMAINROT",2], //Inspect Main Rotor #2
	format [localize"STR_INTSECT_INSPMAINROT",3], //Inspect Main Rotor #3
	format [localize"STR_INTSECT_INSPMAINROT",4], //Inspect Main Rotor #4
	format [localize"STR_INTSECT_INSPTAILROT","#1"], //Inspect Main Tail #1
	format [localize"STR_INTSECT_INSPTAILROT","#2"], //Inspect Main Tail #2
	format [localize"STR_INTSECT_INSPTAILROT","Hub"], //Inspect Main Hub
	localize"STR_INTSECT_INSPTRANS", //Inspect Transmission
	localize"STR_INTSECT_INSPFUEL", //Inspect Fuel
	format [localize"STR_INTSECT_INSPGEAR",1],//Inspect Gear #1
	format [localize"STR_INTSECT_INSPGEAR",2],//Inspect Gear #2
	format [localize"STR_INTSECT_INSPGEAR",3],//Inspect Gear #3
	format [localize"STR_INTSECT_INSPGEAR",4],//Inspect Gear #4
	format [localize"STR_INTSECT_INSPHORSTAB",1], //Inspect Horizontal stabilizer #1
	format [localize"STR_INTSECT_INSPHORSTAB",2], //Inspect Horizontal stabilizer #2
	localize "STR_INTSECT_INSPLL", //Inspect Landing Light
	format [localize"STR_INTSECT_INSPPTUB",1], //Inspect Pitot Tube #1
	format [localize"STR_INTSECT_INSPPTUB",2], //Inspect Pitot Tube #2
	format [localize"STR_INTSECT_INSPSTP",1], //Inspect Static Port #1
	format [localize"STR_INTSECT_INSPSTP",2], //Inspect Static Port #2
	localize"STR_INTSECT_INSPVERSTAB", //Inspect Vertical Stabilizer
	format [localize"STR_INTSECT_INSPINT",1], //Inspect Intake #
	format [localize"STR_INTSECT_INSPINT",2], //Inspect Intake #

	"Toggle Left Engine Hatch",
	"Toggle Right Engine Hatch",

	localize"STR_INTSECT_SITDOWN", //Sit Down
	localize"STR_INTSECT_LAYDOWN", //Lay down
	"Get Up",
	localize"STR_INTSECT_DOOR", //Door
	localize"STR_INTSECT_USEDOORB", //Use Door Button
	localize"STR_INTSECT_TURNONLIGHTS",  //Turn On Lights
	localize"STR_INTSECT_TURNONALLL", //Turn On All Lights
	localize"STR_INTSECT_TOGCOLLIGHT", //Toggle Collision Lights
	localize"STR_INTSECT_HITCHTRLER", //Hitch Trailer
	localize"STR_INTSECT_UNHITCHTRL", //Unhitch Trailer
	localize"STR_INTSECT_HIGHBEAM", //High Beam
	localize"STR_INTSECT_OPCLTRAILD", //Open/Close Trailer Door
	localize"STR_INTSECT_LRTRAILERR", //Lower/Raise Trailer Ramp
	localize"STR_INTSECT_GARAGEDOOR", //Garage Door
	localize"STR_INTSECT_PATDOWN", //Pat down
	localize"STR_INTSECT_CUFFUN", //Cuff/Uncuff
	"Check Fire Alarm",
	"Trigger Fire Alarm",
	"Re-Enable Fire Alarm",
	"Repair Fire Alarm",
	"Restrain/Unrestrain",
	"Trunk",
	"DoorL",
	"DoorR",
	localize"STR_INTSECT_ENTERDRIVER", //Enter as Driver
	localize"STR_INTSECT_ENTASPASS", //Enter as Passenger
	localize"STR_INTSECT_EXITVEH",
	localize"STR_INTSECT_IGNITION", //Ignition
	localize"STR_INTSECT_TOGLIGHTB", //Toggle Lightbar
	localize"STR_INTSECT_TOGSIR", //Toggle Siren
	format [localize"STR_INTSECT_TOGMANUAL",1], //Toggle Manual %1
	format [localize"STR_INTSECT_TOGMANUAL",2], //Toggle Manual %1
	format [localize"STR_INTSECT_TOGMANUAL",3], //Toggle Manual %1
	localize"STR_INTSECT_TOGHEADL", //Toggle Head Lights
	localize"STR_INTSECT_OPCLTRUNK", //Open/Close Trunk
	localize"STR_INTSECT_SPINSIGN", //Spin Sign
	localize"STR_INTSECT_TOGWARNL", //Toggle Warning Lights
	localize"STR_INTSECT_USEPOLRAD", //Use Police Radio
	localize"STR_INTSECT_PLACEITEM", //Place Item
	localize"STR_INTSECT_TGLFAIRAVAIL", //Toggle Fair Available
	localize"STR_INTSECT_PAUSEFAIR", //Pause Fair
	localize"STR_INTSECT_RESETFAIR", //Reset Fair
	localize"STR_INTSECT_STARTFAIR", //Start Fair
	localize"STR_INTSECT_STOPFAIR", //Stop Fair
	format [localize"STR_INTSECT_CLIMBUPL",1], //Climb Up Ladder %1
	format [localize"STR_INTSECT_CLIMBUPL",2], //Climb Up Ladder %1
	format [localize"STR_INTSECT_CLIMBUPL",3], //Climb Up Ladder %1
	format [localize"STR_INTSECT_CLIMBUPL",4], //Climb Up Ladder %1
	format [localize"STR_INTSECT_CLIMBUPL",5], //Climb Up Ladder %1
	format [localize"STR_INTSECT_CLIMBDOWNL",1], //Climb Down Ladder %1
	format [localize"STR_INTSECT_CLIMBDOWNL",2], //Climb Down Ladder %1
	format [localize"STR_INTSECT_CLIMBDOWNL",3], //Climb Down Ladder %1
	format [localize"STR_INTSECT_CLIMBDOWNL",4], //Climb Down Ladder %1
	format [localize"STR_INTSECT_CLIMBDOWNL",5], //Climb Down Ladder %1
	localize"STR_INTSECT_PICKUPLAD", //Pickup Ladder
	localize"STR_INTSECT_EXRELADDER", //Extend/Retract Ladder
	localize"STR_INTSECT_DETAINSUS", //Detain Suspect
	localize"STR_INTSECT_EJALLPASS", //Eject All Passengers
	localize"STR_INTSECT_GRABFURN", //Grab Furniture
	localize"STR_INTSECT_LOUNDOOR", //Lock/Unlock Door
	localize"STR_INTSECT_VEHSTOR", //Vehicle Storage
	localize"STR_INTSECT_STOREVEH", //Store Vehicle
	"Buy Vehicle",
	localize"STR_INTSECT_OBJSTOR", //Object Storage
	localize"STR_INTSECT_STOREOBJ", //Store Object
	"Talk to McFishers Employee",
	"Switch to McFishers uniform",
	"Talk to Taco Hell Employee",
	"Switch to Taco Hell uniform",
	"Talk to Fisherman",
	"Talk to Sheriff",
	"Talk to Dispatch",
	"Talk to Medic",
	"Talk to Bank Employee",
	"Talk to USCG Officer",
	"Talk to Supermarket Employee",
	"Talk to Supermarket NPC",
	"Talk to Perks NPC",
	"Talk to Roadside Service Worker",
	"Open Silverton CCTV",
	"Open Elk City CCTV",
	"Open Central CCTV",
	"Access Weapon Parts Factory",
	"Remove Ankle Tag",
	"Chop Nearest Vehicle",
	"Fishers Island Security Services",
	"Fill Bottle",


	"Talk to Trucker",
	"Talk to Farmer",
	"Open Prisoner Shop",
	"Talk to Wildcat",
	"Talk to Oil Recoverer",
	"Talk to Oil Trader",
	"Verizon",
	"Talk to FAA 1",
	"Talk to FAA 2",
	"Talk to Mailman",
	"Talk to Drugs Dealer",
	"Talk to Black Market",
	"Talk to Guns NPC",
	"Talk to Government NPC",
	"Talk to DOJ NPC",
	"Talk to DOC NPC",
	"Talk to DMV NPC",
	"Spawn DMV Tow Truck",
	"Talk to Hunting NPC",
	"Access Legal Weapon Factory",
	localize"STR_INTSECT_CONVSTOLMONEY", //Convert stolen money
	"Start working as the Mafia",
	"Access Mafia Supplies",

	"Access Gem Stone Shop",
	"Buy/Sell halloween items with Candy",
	"Access Chemical Plant",
	"Access Steel Mill",
	"Access Oil Refinery",
	"Access Weapon Factory",
	"Access Food Processing Plant",
	"Access Goods Factory",
	"Access Clothing Factory",
	"Access Vehicle Factory",
	"Access Car Parts Factory",
	"Access Faction Vehicle Factory",
	"Access Marine Factory",
	"Access Aircraft Factory",

	//shops
	"Access Furniture Shop",
	"Access Furniture Shop 2",
	"Access Gamer Perk Furniture Shop",
	"Access Garden Perk Furniture Shop",
	"Access Mancave Perk Furniture Shop",
	"Access WallDecor Perk Furniture Shop",
	"Access Winchester Perk Furniture Shop",
	"Access FIFR Equipment Shop",
	"Access FIFR Firefighting Shop",
	"Access DMV Shop",
	"Access Hardware Shop",
	"Access General Shop",
	"Access Pinhead Larry's shop",
	"Access Buckeye Buck's shop",
	"Access Moonshine Willy's shop",
	"Access Hemlock Huck's shop",
	"Access Mining Mike's shop",
	"Access Waste Management shop",
	"Start/Stop working for Waste Management!",
	"Start/Stop working for Fishers Island Postal Service!",
	"Start/Stop working for the Great Ratsby!",
	"Start/Stop renting a go-kart!",
	"Talk to Legal BP NPC",
	"Access Weapon Attachments Shop",

	"Buy a Iron mining map ($500)",
	"Buy a Coal mining map ($500)",
	"Buy a Aluminium mining map ($500)",
	"Buy a Sulphur mining map ($500)",
	"Buy a Oil mining map ($1000)",

	"Access Seeds Shop",
	"Access FIFR Vehicle Shop",
	"Access SD Equipment Shop",
	"Access SD Vehicle Shop",
	"Access Vehicle Shop",
	"Access FAA Equipment Shop",
	"Access FAA Vehicle Shop",
	"Access DOJ Equipment Shop",
	"Access DOC Equipment Shop",
	"Access USCG Equipment Shop",
	"Access USCG Car Shop",
	"Access USCG Boat Shop",
	"Access USCG Aircraft Shop",


	localize"STR_INTSECT_TOGDOZBLAD", //Toggle Dozer Blade
	localize"STR_INTSECT_DETATTACHM", //Detach Attachment
	"Attachment_Switch",
	localize"STR_INTSECT_CONNBUCKET", //Connect Bucket
	localize"STR_INTSECT_CONNJACKHAM", //Connect Jackhammer
	localize"STR_INTSECT_CONNECTCLAW", //Connect Claw
	localize"STR_INTSECT_OPERATMODE", //Operations Mode
	localize"STR_INTSECT_DRIVEMODE", //Drive Mode

	localize"STR_INTSECT_PICKUPITEM", //Pickup Item
	"Pickup Delivery Box", //Create Fish Burger
	localize"STR_INTSECT_PICKITEMTOHAND", //Pickup Item To Hand
	localize"STR_INTSECT_CREATEFISHB",
	localize"STR_INTSECT_OPCLJAILD", //Open/Close Jail Door
	localize"STR_INTSECT_USEATM", //Use ATM
	localize"STR_INTSECT_BUSEITEM", //Buy/Sell Item
	localize"STR_INTSECT_DRAG", //Drag
	"Grab",
	localize"STR_INTSECT_KICKDOWN", //Kick Down
	localize"STR_INTSECT_LUVEHDOORS", //Lock/Unlock Vehicle Doors
 	localize"STR_INTSECT_REPVEH", //Repair Vehicle
	"Buy Furniture",
	"climbYacht",
	localize"STR_INTSECT_HANDTICKET", //Hand Ticket
	localize"STR_INTSECT_PICKUPKEY", //Pickup Key
	localize"STR_INTSECT_LRRAMP", //Lower/Raise Ramp
	localize"STR_INTSECT_DELIVERYVEH", //Deliver Vehicle
	localize"STR_INTSECT_KNOCKONDOOR", //Knock On Door
	localize"STR_INTSECT_HARPLANT", //Harvest Plant
	localize"STR_INTSECT_ENTERDRIVER", //Enter as Driver
	localize"STR_INTSECT_ENTERASENG", //Enter as Engineer
	localize"STR_INTSECT_ENTASCAP", //Enter as Captain
	localize"STR_INTSECT_ENTERASGUN", //Enter as Gunner
	localize"STR_INTSECT_ENTERASBOWG", //Enter as Bow Gunner
	localize"STR_INTSECT_LRTRAILERR", //Lock/Unlock Trailer Doors
	localize"STR_INTSECT_TOGREARSPOTL", //Toggle Rear Spotlight

	localize"STR_INTSECT_LoadVehicle", //Load Vehicle
	localize"STR_INTSECT_UnloadVehicle", //Unload Vehicle
	localize"STR_INTSECT_TOGGRAMP", //Toggle Ramp
	localize"STR_INTSECT_TOGLPF", //Toggle Left Platform
	localize"STR_INTSECT_TOGRPF", //Toggle Right Platform
	localize"STR_INTSECT_OPENMEDICALMEN", //Open Medical Menu
	localize"STR_INTSECT_REDRARM", //Retract/Extend Drill Arm
	localize"STR_INTSECT_REDRARMD", //retract/extend drill arm drill
	localize"STR_INTSECT_STARTJPUMP", //Start Jack Pump
	localize"STR_INTSECT_OPK9MEN", //Open K-9 Menu
	localize"STR_INTSECT_PLACEBURGER", //Place Burger
	localize"STR_INTSECT_BUSENET", //Buy/Sell Net
	localize"STR_INTSECT_COLLNET", //Collect Net
	localize"STR_INTSECT_DEPLNET", //Deploy Net
	localize"STR_INTSECT_BUSEBUCK", //Buy/Sell Bucket
	localize"STR_INTSECT_AIRSUSCONT", //Air Suspension Control

	localize"STR_INTSECT_SWITCHIGN", //Switch Ignition
	localize"STR_INTSECT_SWITCHIGN2", //Switch Ignition/Starter
	localize"STR_INTSECT_SWITCHBAT", //Switch Battery
	localize"STR_INTSECT_APUGEN", //APU Generator
	format [localize"STR_INTSECT_ENGGEN",1], //ENG Generator NO.%1
	format [localize"STR_INTSECT_ENGGEN",2], //ENG Generator NO.%1
	localize"STR_INTSECT_APUCONT",  //APU Control
	localize"STR_INTSECT_ECSSTART", //ECS/Start
	localize"STR_INTSECT_FUELPUMP", //Fuel Pump
	localize"STR_INTSECT_WINDSHIELD", //Windshield
	localize"STR_INTSECT_UNFOJAYHWK", //Unfold/Fold Jayhawk
	localize"STR_INTSECT_COCKLIGHT", //Cockpit Lights
	localize"STR_INTSECT_TOGGLESL", //Toggle Searchlight
	localize"STR_INTSECT_CONHOSETTANK",

	//Gas Stuff
	localize"STR_INTSECT_CONGASHOSE", //Connect Gas Hose
	localize"STR_INTSECT_GRABGASHOSE", //Grab Gas Hose
	localize"STR_INTSECT_TOGGLEFUELP", //Toggle Fuel Pump
	localize"STR_INTSECT_RETGASHOSE",	//Return Gas Hose

	//Goose
	localize"STR_INTSECT_TOGGLEFLOATS", //Toggle Floats
	localize"STR_INTSECT_TOGGLEFP", //Toggle Gear
	localize"STR_INTSECT_TOGGLEFP", //Toggle Fuelpump
	localize"STR_INTSECT_TOGGLEBAT", //Toggle Battery
	localize"STR_INTSECT_ADJFLUP", //Adjust Flaps Upward
	localize"STR_INTSECT_ADJFLDWN", //Adjust Flaps Downward
	localize"STR_INTSECT_SWITCHGEN", //Switch Generator
	"Switch Ignition/Starter Left",
	"Switch Ignition/Starter Right",
	localize"STR_INTSECT_ENTCOPIL", ////Enter as Co-Pilot

	//Mailman
	localize"STR_INTSECT_DELPACKAGE", //Deliver Package

	//Atego_Tow
	localize"STR_INTSECT_LOWTOWROPE", //Lower Towing Rope
	localize"STR_INTSECT_RAISETOWROPET", //Raise Towing Rope (Tow)

	//Compartments
	"Toggle Compartment 1",
	"Toggle Compartment 2",
	"Toggle Compartment 3",
	"Toggle Compartment 4",
	"Toggle Compartment 5",
	"Toggle Compartment 6",
	"Toggle Compartment 7",
	"Toggle Compartment 8",
	"Toggle Compartment 9",
	"Toggle Compartment 10",
	"Toggle Compartment 11",
	"Toggle Compartment 12",
	"Toggle Compartment 13",
	"Toggle Compartment 14",
	"Toggle Compartment 15",
	"Toggle Compartment 16",
	"Toggle Compartment 17",
	"Toggle Compartment 18",
	"Toggle Compartment 19",
	"Toggle Compartment 20",

	"Toggle Mooring Line",
	// Vehicles Seats
	format [localize"STR_INTSECT_ENTASGUN",1], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",2], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",3], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",4], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",5], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",6], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",7], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",8], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",9], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",10], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",11], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",12], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",13], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",14], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",15], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",16], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",17], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",18], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",19], //Enter as Gunner %1
	format [localize"STR_INTSECT_ENTASGUN",20], //Enter as Gunner %1
	format [localize"STR_INTSECT_SITINSEAT",1], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",2], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",3], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",4], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",5], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",6], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",7], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",8], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",9], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",10], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",11], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",12], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",13], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",14], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",15], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",16], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",17], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",18], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",19], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",20], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",21], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",22], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",23], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",24], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",25], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",26], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",27], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",28], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",29], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",30], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",31], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",32], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",33], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",34], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",35], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",36], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",37], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",38], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",39], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",40], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",41], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",42], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",43], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",44], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",45], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",46], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",47], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",48], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",49], //Sit In Seat %1
	format [localize"STR_INTSECT_SITINSEAT",50], //Sit In Seat %1
	localize"STR_INTSECT_MOVETODRIVER", //Move to Driver
	localize"STR_INTSECT_MOVETOCOPIL", //Move to Co-Pilot
	format [localize"STR_INTSECT_MOVTOGUNNR",1], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",2], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",3], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",4], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",5], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",6], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",7], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",8], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",9], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",10], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",11], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",12], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",13], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",14], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",15], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",16], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",17], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",18], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",19], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVTOGUNNR",20], //Move to Gunner %1
	format [localize"STR_INTSECT_MOVETOSEAT",1], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",2], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",3], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",4], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",5], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",6], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",7], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",8], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",9], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",10], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",11], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",12], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",13], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",14], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",15], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",16], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",17], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",18], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",19], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",20], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",21], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",22], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",23], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",24], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",25], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",26], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",27], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",28], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",29], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",30], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",31], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",32], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",33], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",34], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",35], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",36], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",37], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",38], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",39], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",40], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",41], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",42], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",43], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",44], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",45], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",46], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",47], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",48], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",49], //Move to Seat %1
	format [localize"STR_INTSECT_MOVETOSEAT",50], //Move to Seat %1

	//Siren Control
	localize"STR_INTSECT_SIRENCONTR", //Siren Control
	localize"STR_INTSECT_MASTERON", //Master On
	localize"STR_INTSECT_SIRENMASTER", //Siren Master
	localize"STR_INTSECT_DIRECTCONTR", //Directional Control
	localize"STR_INTSECT_DIRECTMASTER", //Directional Master
	localize"STR_INTSECT_AIRHORN", //Airhorn
	localize"STR_INTSECT_ELECHORN", //Electric Horn
	localize"STR_INTSECT_ELECAIRH", //Electric Airhorn
	localize"STR_INTSECT_RUMBLERMAN", //Rumbler Manual
	localize"STR_INTSECT_T3YELP", //T3 Yelp
	localize"STR_INTSECT_RADARMASTER", //Radar Master
	localize"STR_INTSECT_REARRADAR", //Rear Radar
	localize"STR_INTSECT_FRONTRADAR", //Front Radar
	localize"STR_INTSECT_RESETLOCKFAST", //Reset Lock/Fast
	localize"STR_INTSECT_TURNONOFFLAP", //Turn On/Off Laptop
	localize"STR_INTSECT_ACCPOLDB", //Access Police Database
	localize"STR_INTSECT_SWIVELLAP", //Swivel Laptop
	localize"STR_INTSECT_RIGHTALLLIGHT", //Right Alley Light
	localize"STR_INTSECT_LEFTALLLIGHT", //Left Alley Light
	localize"STR_INTSECT_TOGSPOTLIGHT", //Toggle Spotlight
	localize"STR_INTSECT_TOGCONTCOV", //Toggle Controller Cover
	localize"STR_INTSECT_TOGDSFOUT", //Toggle DS Front Outrigger
	localize"STR_INTSECT_TOGDROUT", //Toggle DS Rear Outrigger
	localize"STR_INTSECT_TOGPSFOUT", //Toggle PS Front Outrigger
	localize"STR_INTSECT_TOGPSROUT", //Toggle PS Rear Outrigger
	localize"STR_INTSECT_TORADSOUT", //Toggle/Raise DS Outriggers
	localize"STR_INTSECT_TORAPSOUT", //Toggle/Raise PS Outriggers
	localize"STR_INTSECT_DSFLOODL", //DS Floodlights
	localize"STR_INTSECT_PSFLOODL", //PS Floodlights
	localize"STR_INTSECT_PERILIGHT", //Perimeter Lights
	localize"STR_INTSECT_LADDERFLOODL", //Ladder Floodlight
	localize"STR_INTSECT_LADDERCAM", //Ladder Cam
	localize"STR_INTSECT_USESTRETCH", //Use Stretcher
	localize"STR_INTSECT_GRABLLB", //Grab Left Lifebuoy
	localize"STR_INTSECT_PUTBACKLLB", //Put Back Left Lifebuoy
	localize"STR_INTSECT_GRABRLB", //Grab Right Lifebuoy
	localize"STR_INTSECT_PBRLIFEB", //Put Back Right Lifebuoy
	localize"STR_INTSECT_CLIMBINTYA",  //Climb Onto Yacht
	localize"STR_INTSECT_REARFLOODL", //Rear Floodlights
	localize"STR_INTSECT_INTLIGHTS", //Interior Lights
	"Police Computer",
	"FIFR Computer",

	//FD
	localize"STR_INTSECT_ENTASLADOP", //Enter as Ladder Operator
	localize"STR_INTSECT_HOLDHOSEAD", //Hold Hose Adapter
	localize"STR_INTSECT_CONHOSETAD", //Connect Hose To Adapter
	"Rollup Hose",
	localize"STR_INTSECT_OPCLDOOR", //Open\Close Door
	localize"STR_INTSECT_TONOFFPUMP", //Turn On\Off Pump
	localize"STR_INTSECT_REVERSECAM", //Reverse Cam
	localize"STR_INTSECT_ENTCODR", //Enter as Co-Driver
	localize"STR_INTSECT_LORALADRACK", //Lower/Raise Ladder Rack
	localize"STR_INTSECT_TAKELADDER", //Take Ladder
	localize"STR_INTSECT_PUTBACKLAD", //Put Back Ladder
	format [localize"STR_INTSECT_PUTBACKHOSE",1], //Put Back Hose %1
	format [localize"STR_INTSECT_PUTBACKHOSE",2], //Put Back Hose %1
	format [localize"STR_INTSECT_PUTBACKHOSE",3], //Put Back Hose %1
	format [localize"STR_INTSECT_PUTBACKHOSE",4], //Put Back Hose %1
	format [localize"STR_INTSECT_PUTBACKHOSE",5], //Put Back Hose %1
	format [localize"STR_INTSECT_TAKEHOSE",1], //Take Hose %1
	format [localize"STR_INTSECT_TAKEHOSE",2], //Take Hose %1
	format [localize"STR_INTSECT_TAKEHOSE",3], //Take Hose %1
	format [localize"STR_INTSECT_TAKEHOSE",4], //Take Hose %1
	format [localize"STR_INTSECT_TAKEHOSE",5], //Take Hose %1

	//Locker
	localize"STR_INTSECT_GOONFIFRD", //Go On FIFR Duty
	localize"STR_INTSECT_GOOFFFIFRD", //Go Off FIFR Duty
	localize"STR_INTSECT_OPCLDOOR", //Open\Close Door
	//resources
	localize"STR_INTSECT_CHECKITEM", //Check Item
	localize"STR_INTSECT_COLLECTITEM", //Collect Item
	localize"STR_INTSECT_SELLITEM", //Sell Item
	localize"STR_INTSECT_BUYITEM", //Buy Item

	//medic
	localize"STR_INTSECT_OPENMEDICALMEN", //Open Medical Menu
	"Resuscitate",

	localize"STR_INTSECT_USEJERRYC", //Use jerrycan
	"Use jerrycan",

	"Skin animal",
	"Tag meat",

	//Lockers
	"Open/Close Locker",
	"Store in locker",
	"Rent locker",
	"SFP Shop"
];
publicVariable "Config_GenArray";

Config_QuickActions =
[
	["",localize"STR_INTSECT_DOOR",{[] call A3PL_Intersect_HandleDoors;}], //Door
	["",localize"STR_INTSECT_GARAGEDOOR",{[] call A3PL_Intersect_HandleDoors;}], //Garage Door
	["","Trunk",{private ["_obj"]; _obj = (call A3PL_Intersect_Cursortarget); if (_obj animationPhase "trunk" < 0.5) then {_obj animate ["trunk",1];} else {_obj animate ["trunk",0]};}],
	#include "QuickActions\Objects.sqf",
	#include "QuickActions\Vehicles.sqf",
	#include "QuickActions\Buildings.sqf",
	#include "QuickActions\NPC.sqf"
];
publicVariable "Config_QuickActions";
