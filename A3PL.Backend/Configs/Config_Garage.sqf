/*
	[classname,camerapos
		[upgradeid,upgradetype,upgradeclass,title,desc,cam target,offset from cam target,installprice,required]
	]
*/

Config_Garage_Upgrade = 
[
	["A3PL_BMW_X5",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Camaro",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_CVPI",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_CVPI_Taxi",
		["Taxi_Sign","addon","Taxi_Sign",localize "STR_CGAR_TSIGN1",localize "STR_CGAR_TSIGN1D",[0,0,0.7],[0,2,0],0,["Steel",1]], //taxi sign 1, Taxi Sign for the roof
		["Taxi_Sign_Ad","addon","Taxi_Sign_Ad",localize "STR_CGAR_TSIGN2",localize "STR_CGAR_TSIGN2D",[0,0,0.7],[0,2,0],0,["Steel",1]], //taxi sign 2, Taxi Sign with advertisement for the roof
		["Driver_Guard","addon","Driver_Guard",localize "STR_CGAR_DRIVER_GUARD",localize "STR_CGAR_DRIVER_GUARDD",[0,0,0.7],[0,2,0],0,["Steel",1]], //Driver Guard, Partition between front and rear seats
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_CVPI_PD",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]],  //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_CVPI_PD_Slicktop",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]],  //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_F150",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_F150_Marker",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Gallardo",
		["Spoiler1","addon","Spoiler1",format [localize "STR_CGAR_WINGTYPE",1],format [localize "STR_CGAR_AFTERMEWING",1],[0,-2,0],[2,0.2,1],0,["Steel",1]], //"Racing Wing","Only cosmetic"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Ram",
		["Roof_Rack","addon","Roof_Rack",localize "STR_CGAR_RR",localize "STR_CGAR_RRD","trunkInside2",[0,0,0],0,["Steel",1]],//[0,0,0.7],[0,2,0] || "Roof Rack","Cargo rack for the roof"
		["Roll_Bar","addon","Roll_Bar",localize "STR_CGAR_RB",localize "STR_CGAR_RCD","trunkInside2",[0,0,0],0,["Steel",1]], //"Roll Bar","Protect occupants when the vehicle rolls over"
		["Roof_Lights","addon","Roof_Lights",localize "STR_CGAR_RL",localize "STR_CGAR_RLD",[0,0,0.7],[0,2,0],0,[["Steel",1]]], //"Roof Lights","Lights above your roof"
		["Lightbar","addon","Lightbar",localize "STR_CGAR_LB",localize "STR_CGAR_LBD",[0,0,0.7],[0,2,0],0,[["Steel",1]]], //"Lightbar","Bar of lights mounted on the roof"
		["Spair_Tire","addon","Spair_Tire",localize "STR_CGAR_ST",localize "STR_CGAR_STD",[0,-2,0],[2,0.2,1],0,["Steel",1]], //"Spare Tire","Only cosmetic"
		["Bull_Bar","addon","Bull_Bar",localize "STR_CGAR_BB",localize "STR_CGAR_BBD",[0,3,0],[0,1,0],0,["Steel",1]], //"Bull Bar","Protect front from collisions"
		["Driving_Lights","addon","Driving_Lights",localize "STR_CGAR_DL",localize "STR_CGAR_DLD",[0,3,0],[0,1,0],0,["Steel",1]],//"Driving Lights","Driving Lights mounted on Bull Bar"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Rover",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]], //Add towbar, Allows you to hitch trailers
		["Roof_Rack","addon","Roof_Rack",localize "STR_CGAR_RR",localize "STR_CGAR_RRD",[0,0,1.5],[0,2,1],0,[["Steel",1]]], //,"Roof Rack","Carry more stuff!",
		["Camping_Equipment","addon","Camping_Equipment",localize "STR_CGAR_ROOCE",localize "STR_CGAR_ROOCED",[0,0,1.5],[0,2,1],0,[["Steel",1]]], //,"Camping Equipment","Camping Equipment for roof rack",
		["Roof_Lights","addon","Roof_Lights",localize "STR_CGAR_RL",localize "STR_CGAR_ROORLD",[0,0,1.5],[0,2,1],0,[["Steel",1]]], //,"Roof Lights","Driving Lights mounted on roof rack",
		["Ladder","addon","Ladder",localize "STR_CGAR_L",localize "STR_CGAR_LD",[0,-2,1],[2,0.2,1.5],0,["Steel",1]],//,"Ladder","Ladder mounted on the back of the vehicle",
		["Snorkel","addon","Snorkel",localize "STR_CGAR_S",localize "STR_CGAR_STD",[0,0,1.1],[0,2,1],0,[["Steel",1]]], //"Snorkel","Only cosmetic"
		["Winch","addon","Winch",localize "STR_CGAR_W",localize "STR_CGAR_STD",[0,3,1.5],[0,1,1],0,["Steel",1]], //,"Winch","Only cosmetic",
		["Bull_Bar","addon","Bull_Bar",localize "STR_CGAR_BB",localize "STR_CGAR_BBD",[0,3,1.5],[0,1,1],0,["Steel",1]], //"Bull Bar","Protect front from collisions"
		["Lightbar","addon","Lightbar",localize "STR_CGAR_LB",localize "STR_CGAR_LBD",[0,0,1.1],[0,2,1],0,[["Steel",1]]], //Lightbar","Bar of lights mounted on the roof"
		["Bumper_Guard","addon","Bumper_Guard",localize "STR_CGAR_BG",localize "STR_CGAR_BGD","Towbar_Cam",[1,0,0],0,["Steel",1]], //Bumper Guard, Protects rear bumper from damage 
		["Brakelight_Guards","addon","Brakelight_Guards",localize "STR_CGAR_LIGHTP",localize "STR_CGAR_LIGHTPD",[0,-2,1],[2,0.2,1.5],0,["Steel",1]] //"Tail light protectors","Protects your tail lights from those bumper cars"
	],
	["A3PL_VetteZR1",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Wrangler",
		["Bull_Bar","addon","Bull_Bar",localize "STR_CGAR_BB",localize "STR_CGAR_BBD",[0,2.5,0],[0,1,0],0,[["Steel",1]]], //"Bull Bar","Protect front from collisions"
		["Winch","addon","Winch",localize "STR_CGAR_W",localize "STR_CGAR_STD",[0,2.5,0],[0,1,0],0,[["Steel",1]]], //,"Winch","Only cosmetic",
		["Driving_Lights","addon","Driving_Lights",localize "STR_CGAR_DL",localize "STR_CGAR_DLD",[0,2.5,0],[0,1,0],0,[["Steel",1]]], //"Driving Lights","Driving Lights mounted on Bull Bar"
		["Roof_Rack","addon","Roof_Rack",localize "STR_CGAR_RR",localize "STR_CGAR_RRD",[0,0,1.5],[0,2,1],0,["Steel",1]], // "Roof Rack","Cargo rack for the roof"
		["Lightbar","addon","Lightbar",localize "STR_CGAR_LB",localize "STR_CGAR_LBRD",[0,0,1.5],[0,2,1],0,["Steel",1]], // "Lightbar","Bar of lights mounted on the roll bar"
		["Roll_Bar","addon","Roll_Bar",localize "STR_CGAR_RC",localize "STR_CGAR_RCD",[0,0,1.5],[0,2,1],0,["Steel",1]], //Roll Cage","Protect occupants when the vehicle rolls over"
		["Spair_Tire","addon","Spair_Tire",localize "STR_CGAR_ST",localize "STR_CGAR_STD",[0,-2,0],[2,0.2,1],0,["Steel",1]], //Spare Tire","Only cosmetic"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Charger",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Charger_PD",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]], //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Charger_PD_Slicktop",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]],  //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Tahoe",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Tahoe_FD",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Tahoe_PD",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]],  //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Tahoe_PD_Slicktop",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]], //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_BMW_M3",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Mustang",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Mustang_Tahoe_PD",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]], //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Mustang_PD_Slicktop",
		["Spotlight_Addon","addon","Spotlight_Addon",localize "STR_CGAR_SL",localize "STR_CGAR_SLD","Spotlight1",[0.89,1.5,-0.50],0,["Glass",1]], //"Spotlight","Shines light onto criminals"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,3,-1],[0,1,0],0,["Steel",1]], //,"Front pushbar","Protect front from collisions",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_911GT2",
		["Stock_Bonnet","addon","Stock_Bonnet",localize "STR_CGAR_SB",localize "STR_CGAR_SBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Hood","Original Hood"
		["Stock_Front_Bumper","addon","Stock_Front_Bumper",localize "STR_CGAR_SFB",localize "STR_CGAR_SFBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Front Bumper","Original Front Bumper"
		["Stock_Rear_Bumper","addon","Stock_Rear_Bumper",localize "STR_CGAR_SRB",localize "STR_CGAR_SRBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Rear Bumper","Original Rear Bumper"
		["Stock_Exhaust","addon","Stock_Exhaust",localize "STR_CGAR_SE",localize "STR_CGAR_SED",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Exhaust","Original Exhaust"
		["Stock_Spoiler","addon","Stock_Spoiler",localize "STR_CGAR_SW",localize "STR_CGAR_SWD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Spoiler","Original Rear Wing"
		["Roll_Cage","addon","Roll_Cage",localize "STR_CGAR_RC",localize "STR_CGAR_RCD",[0,0,1.5],[0,2,1],0,["Steel",1]], //Roll Cage","Protect occupants when the vehicle rolls over"
		["Front_Bumper1","addon","Front_Bumper1",format [localize "STR_CGAR_FBARTYPE",1],format [localize "STR_CGAR_AFTERMFBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 1","Aftermarket Front Bumper 1"
		["Front_Bumper2","addon","Front_Bumper2",format [localize "STR_CGAR_FBARTYPE",2],format [localize "STR_CGAR_AFTERMFBAR",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 2","Aftermarket Front Bumper 2"
		["Rear_Bumper1","addon","Rear_Bumper1",format [localize "STR_CGAR_RBARTYPE",1],format [localize "STR_CGAR_AFTERMRBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Rear Bumper Type 1","Aftermarket Rear Bumper 1"
		["Spoiler1","addon","Spoiler1",format [localize "STR_CGAR_WINGTYPE",1],format [localize "STR_CGAR_AFTERMEWING",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 1","Aftermarket Rear Wing 1"
		["Spoiler2","addon","Spoiler2",format [localize "STR_CGAR_WINGTYPE",2],format [localize "STR_CGAR_AFTERMEWING",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 2","Aftermarket Rear Wing 2"
		["Spoiler3","addon","Spoiler3",format [localize "STR_CGAR_WINGTYPE",3],format [localize "STR_CGAR_AFTERMEWING",3],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 3","Aftermarket Rear Wing 3"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Charger69",
		["Stock_Bonnet","addon","Stock_Bonnet",localize "STR_CGAR_SB",localize "STR_CGAR_SBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Hood","Original Hood"
		["Stock_Front_Bumper","addon","Stock_Front_Bumper",localize "STR_CGAR_SFB",localize "STR_CGAR_SFBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Front Bumper","Original Front Bumper"
		["Stock_Rear_Bumper","addon","Stock_Rear_Bumper",localize "STR_CGAR_SRB",localize "STR_CGAR_SRBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Rear Bumper","Original Rear Bumper"
		["Stock_Exhaust","addon","Stock_Exhaust",localize "STR_CGAR_SE",localize "STR_CGAR_SED",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Exhaust","Original Exhaust"
		["Roll_Cage","addon","Roll_Cage",localize "STR_CGAR_RC",localize "STR_CGAR_RCD",[0,0,1.5],[0,2,1],0,["Steel",1]], //Roll Cage","Protect occupants when the vehicle rolls over"
		["Bonnet1","addon","Bonnet1",localize "STR_CGAR_RCS",format [localize "STR_CGAR_AFTERMHOOD",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Reverse Cowl Scoops","Aftermarket Hood 1"
		["Bonnet2","addon","Bonnet2",localize "STR_CGAR_BS",format [localize "STR_CGAR_AFTERMHOOD",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Bonnet Scoop","Aftermarket Hood 2"
		["Front_Bumper1","addon","Front_Bumper1",format [localize "STR_CGAR_FBARTYPE",1],format [localize "STR_CGAR_AFTERMFBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 1","Aftermarket Front Bumper 1"
		["Spoiler1","addon","Spoiler1",format [localize "STR_CGAR_WINGTYPE",1],format [localize "STR_CGAR_AFTERMEWING",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 1","Aftermarket Rear Wing 1"
		["General_Lee","addon","General_Lee",localize "STR_CGAR_GL",localize "STR_CGAR_GLD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"General Lee","Outfit with Pushbar, Antenna and Roll Cage"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_CRX",
		["Stock_Bonnet","addon","Stock_Bonnet",localize "STR_CGAR_SB",localize "STR_CGAR_SBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Hood","Original Hood"
		["Stock_Front_Bumper","addon","Stock_Front_Bumper",localize "STR_CGAR_SFB",localize "STR_CGAR_SFBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Front Bumper","Original Front Bumper"
		["Stock_Rear_Bumper","addon","Stock_Rear_Bumper",localize "STR_CGAR_SRB",localize "STR_CGAR_SRBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Rear Bumper","Original Rear Bumper"
		["Stock_Exhaust","addon","Stock_Exhaust",localize "STR_CGAR_SE",localize "STR_CGAR_SED",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Exhaust","Original Exhaust"
		["Stock_Side_Skirt","addon","Stock_Side_Skirt",localize "STR_CGAR_SSS",localize "STR_CGAR_SSSD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Side Skirt","Original Side Skirt"
		["Stock_Spoiler","addon","Stock_Spoiler",localize "STR_CGAR_SW",localize "STR_CGAR_SWD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Spoiler","Original Rear Wing"
		["Roll_Cage","addon","Roll_Cage",localize "STR_CGAR_RC",localize "STR_CGAR_RCD",[0,0,1.5],[0,2,1],0,["Steel",1]], //Roll Cage","Protect occupants when the vehicle rolls over"
		["Student_Driver","addon","Student_Driver",localize "STR_CGAR_DS",localize "STR_CGAR_DSD",[0,0,1.5],[0,2,1],0,["Steel",1]], //"Driving School","DMV Driving School"
		["Front_Bumper1","addon","Front_Bumper1",format [localize "STR_CGAR_FBARTYPE",1],format [localize "STR_CGAR_AFTERMFBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 1","Aftermarket Front Bumper 1"
		["Front_Bumper2","addon","Front_Bumper2",format [localize "STR_CGAR_FBARTYPE",2],format [localize "STR_CGAR_AFTERMFBAR",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 2","Aftermarket Front Bumper 2"
		["Front_Bumper3","addon","Front_Bumper3",format [localize "STR_CGAR_FBARTYPE",3],format [localize "STR_CGAR_AFTERMFBAR",3],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 3","Aftermarket Front Bumper 3"
		["Front_Bumper4","addon","Front_Bumper4",format [localize "STR_CGAR_FBARTYPE",4],format [localize "STR_CGAR_AFTERMFBAR",4],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 4","Aftermarket Front Bumper 4"
		["Front_Bumper5","addon","Front_Bumper5",format [localize "STR_CGAR_FBARTYPE",5],format [localize "STR_CGAR_AFTERMFBAR",5],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 5","Aftermarket Front Bumper 5"
		["Side_Skirt1","addon","Side_Skirt1",format [localize "STR_CGAR_SSKIRTTYPE",1],format [localize "STR_CGAR_AFTERMSSKIRT",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Side Skirt Type 1","Aftermarket Side Skirt 1"
		["Side_Skirt2","addon","Side_Skirt2",format [localize "STR_CGAR_SSKIRTTYPE",2],format [localize "STR_CGAR_AFTERMSSKIRT",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Side Skirt Type 2","Aftermarket Side Skirt 2"
		["Side_Skirt3","addon","Side_Skirt3",format [localize "STR_CGAR_SSKIRTTYPE",3],format [localize "STR_CGAR_AFTERMSSKIRT",3],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Side Skirt Type 3","Aftermarket Side Skirt 3"
		["Rear_Bumper1","addon","Rear_Bumper1",format [localize "STR_CGAR_RBARTYPE",1],format [localize "STR_CGAR_AFTERMRBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Rear Bumper Type 1","Aftermarket Rear Bumper 1"
		["Spoiler1","addon","Spoiler1",format [localize "STR_CGAR_WINGTYPE",1],format [localize "STR_CGAR_AFTERMEWING",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 1","Aftermarket Rear Wing 1"
		["Spoiler2","addon","Spoiler2",format [localize "STR_CGAR_WINGTYPE",2],format [localize "STR_CGAR_AFTERMEWING",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 2","Aftermarket Rear Wing 2"
		["Spoiler3","addon","Spoiler3",format [localize "STR_CGAR_WINGTYPE",3],format [localize "STR_CGAR_AFTERMEWING",3],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 3","Aftermarket Rear Wing 3"
		["Spoiler4","addon","Spoiler4",format [localize "STR_CGAR_WINGTYPE",4],format [localize "STR_CGAR_AFTERMEWING",4],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 4","Aftermarket Rear Wing 4"
		["Exhaust1","addon","Exhaust1",format [localize "STR_CGAR_EXHTYPE",1],format [localize "STR_CGAR_AFTERMEXH",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Exhaust Type 1","Aftermarket Exhaust 1"
		["Exhaust2","addon","Exhaust2",format [localize "STR_CGAR_EXHTYPE",2],format [localize "STR_CGAR_AFTERMEXH",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Exhaust Type 2","Aftermarket Exhaust 2"
		["Exhaust3","addon","Exhaust3",format [localize "STR_CGAR_EXHTYPE",3],format [localize "STR_CGAR_AFTERMEXH",3],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Exhaust Type 3","Aftermarket Exhaust 3"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Silverado",
		["Bed_Cover","addon","Bed_Cover",localize "STR_CGAR_BC",localize "STR_CGAR_BCD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Bed Cover","Protect cargo in the bed"
		["Toolbox","addon","Toolbox",localize "STR_CGAR_TB",localize "STR_CGAR_TBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Toolbox","Two tool boxes in bed (Only cosmetic)"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Silverado_PD",
		["Bed_Cover","addon","Bed_Cover",localize "STR_CGAR_BC",localize "STR_CGAR_BCD",[0,0,0],[0,0,0],0,[["Steel",1]]],//"Bed Cover","Protect cargo in the bed"
		["Toolbox","addon","Toolbox",localize "STR_CGAR_TB",localize "STR_CGAR_TBD",[0,0,0],[0,0,0],0,[["Steel",1]]],//"Toolbox","Two tool boxes in bed (Only cosmetic)"
		["Pushbar_Addon","addon","Pushbar_Addon",localize "STR_CGAR_FRONTPUSH",localize "STR_CGAR_FRONTPUSHDESC",[0,0,0],[0,0,0],0,["Steel",1]], //,"Front pushbar","Protect front from collisions",
		["Antenna","addon","Antenna",localize "STR_CGAR_ANTENNA",localize "STR_CGAR_ANTENNADESC",[0,0,0],[0,0,0],0,["Steel",1]], //,"Antenna","Antennas for radio",
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	],
	["A3PL_Challenger_Hellcat",
		["Stock_Bonnet","addon","Stock_Bonnet",localize "STR_CGAR_SB",localize "STR_CGAR_SBD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Hood","Original Hood"
		["Stock_Exhaust","addon","Stock_Exhaust",localize "STR_CGAR_SE",localize "STR_CGAR_SED",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Exhaust","Original Exhaust"
		["Stock_Spoiler","addon","Stock_Spoiler",localize "STR_CGAR_SW",localize "STR_CGAR_SWD",[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Stock Spoiler","Original Rear Wing"
		["Roll_Cage","addon","Roll_Cage",localize "STR_CGAR_RC",localize "STR_CGAR_RCD",[0,0,1.5],[0,2,1],0,["Steel",1]], //Roll Cage","Protect occupants when the vehicle rolls over"
		["Front_Bumper1","addon","Front_Bumper1",format [localize "STR_CGAR_FBARTYPE",1],format [localize "STR_CGAR_AFTERMFBAR",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Front Bumper Type 1","Aftermarket Front Bumper 1"
		["Spoiler1","addon","Spoiler1",format [localize "STR_CGAR_WINGTYPE",1],format [localize "STR_CGAR_AFTERMEWING",1],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 1","Aftermarket Rear Wing 1"
		["Spoiler2","addon","Spoiler2",format [localize "STR_CGAR_WINGTYPE",2],format [localize "STR_CGAR_AFTERMEWING",2],[0.3,5.2,0.9],[0,1,0],0,[["Steel",1]]],//"Wing Type 2","Aftermarket Rear Wing 2"
		["Towbar_Addon","addon","Towbar_Addon",localize "STR_CGAR_ADDTOWBAR",localize "STR_CGAR_ADDTOWBARDESC","Towbar_Cam",[1,0,0],0,["Steel",1]] //Add towbar, Allows you to hitch trailers
	]
];
publicVariable "Config_Garage_Upgrade";

//only available to "motorhead perk"
Config_Garage_Materials =
[
	["A3PL_Cars\Common\rvmats\Chrome_new.rvmat","Chrome"],
	["A3PL_Cars\Common\rvmats\Black_Plastic.rvmat","Glossy"],
	["A3PL_Cars\Common\rvmats\Metallic.rvmat","Metallic"],
	["A3PL_Cars\common\rvmats\car_paint.rvmat","Default"]
];
publicVariable "Config_Garage_Materials";

/*
	["hitclass (eg. engine)",title]
*/
Config_Garage_Repair =
[
	["engine","Engine"],
	["body","Body damage"],
	["wheel_1_1_steering","Front-Left Wheel"],
	["wheel_1_2_steering","Back-Left Wheel"],
	["wheel_2_1_steering","Front-Right Wheel"],
	["wheel_2_2_steering","Back-Right Wheel"],
	["glass1","Front window"],
	["glass2","Front-Left window"],
	["glass3","Back-Left window"],
	["glass4","Front-right window"],
	["glass5","Back-right window"],
	["glass6","Rear window"],
	["l svetlo","Left headlight"],
	["p svetlo","Right headlight"],
	["spotlight_hit","Spotlight"]
];
publicVariable "Config_Garage_Repair";