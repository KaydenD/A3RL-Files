Config_NPC_Text =
[
	//id,text NPC,options,code to execute
	// "Hello there!<br/><br/>Welcome to McFishers, how may I help you?",["1. Hello! I would like to start working at McFishers", "2. Ignore me, I'm just creeping around"]
	["mcfishers_initial",parseText localize"STR_NPC_WELCOMEMCF",[localize "STR_NPC_WELCOMEMCF1",localize "STR_NPC_WELCOMEMCF2"],["if (player getVariable 'job' == 'mcfisher') exitwith {['mcfishers_already'] call A3PL_NPC_Start;}; ['mcfishers_work'] call A3PL_NPC_Start;",""]],
	//"Great! We are always hiring.<br/><br/>Are you sure you would like to work here?<br/>Your contract length will be atleast 1 month (1 hour).",["1. That sounds good, I will get started right away!", "2. I think I changed my mind, thanks for the offer anyway."]
	["mcfishers_work",parseText localize"STR_NPC_MCFWORK",[localize"STR_NPC_MCFWORK1", localize"STR_NPC_MCFWORK2"],["['mcfisher'] call A3PL_NPC_TakeJob;",""]],
	//<Original>You are already working here...  1. I was just joking! *laughs*   2. I would like to stop working here, I hate this place
	["mcfishers_already",parseText localize"STR_NPC_ALREADYWORKING",[localize"STR_NPC_ALREADYWORKING1",localize"STR_NPC_ALREADYWORKING2"],["","[] call A3PL_NPC_LeaveJob;"]],
	//You are now a full-time mcFishers employee.... 1. Yes please.  2. I've done this kind of work before. I'm good!
	["mcfishers_accepted",parseText localize"STR_NPC_MCFACCEPTED",[localize"STR_NPC_MCFACCEPTED1", localize"STR_NPC_MCFACCEPTED2"],["['mcfishers_tutorial'] call A3PL_NPC_Start;",""]],
	//Alright, listen up.... 1. Alright, got it!
	["mcfishers_tutorial",parseText localize"STR_NPC_MCFTUTORIAL",[localize"STR_NPC_MCFTUTORIAL1"],[""]],

	//"Hello there!<br/><br/>Welcome to Taco Hell, how may I help you?",["1. Hello! I would like to start working at Taco Hell", "2. Ignore me, I'm just creeping around"]
	["tacohell_initial",parseText localize"STR_NPC_THINIT",[localize"STR_NPC_THINIT1",localize"STR_NPC_THINIT2"],["if (player getVariable 'job' == 'tacohell') exitwith {['tacohell_already'] call A3PL_NPC_Start;}; ['tacohell_work'] call A3PL_NPC_Start;",""]],
	//"Great! We are always hiring.<br/><br/>Are you sure you would like to work here?<br/>Your contract length will be atleast 1 month (1 hour).",["1. That sounds good, I will get started right away!", "2. I think I changed my mind, thanks for the offer anyway."]
	["tacohell_work",parseText localize"STR_NPC_THWORK",[localize"STR_NPC_THWORK1", localize"STR_NPC_THWORK2"],["['tacohell'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working here...",["1. I was just joking! *laughs*","2. I would like to stop working here, I hate this place."]
	["tacohell_already",parseText localize"STR_NPC_ALREADYWORKING",[localize"STR_NPC_ALREADYWORKING1",localize"STR_NPC_ALREADYWORKING2"],["","[] call A3PL_NPC_LeaveJob;"]],
	//"You are now a full-time Taco Hell employee.<br/><br/>You can find your working clothes on the counter.<br/><br/>Do I need to walk you through the basics?",["1. Yes please.", "2. I've done this kind of work before. I'm good!"]
	["tacohell_accepted",parseText localize"STR_NPC_THACCEPTED",[localize"STR_NPC_THACCEPTED1", localize"STR_NPC_THACCEPTED2"],["['tacohell_tutorial'] call A3PL_NPC_Start;",""]],
	//"Alright, listen up.<br/>1. You can find ingredients in the kitchen.<br/>2. Use the grill to cook the fish.<br/>3. The microphone can be used to talk to customers."
	["tacohell_tutorial",parseText localize"STR_NPC_THTUTORIAL",[localize"STR_NPC_THTUTORIAL1"],[""]],

	//fishing job
	//"Hello there!<br/><br/>How can I help you?",["1. Hello! I would like to become a fisherman!","2. Just looking around, dont mind me.","3. I would like to access the shop"]
	["fisherman_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FISHMANINIT1",localize"STR_NPC_FISHMANINIT2",localize"STR_NPC_FISHMANINIT3"],["if (player getVariable 'job' == 'fisherman') exitwith {['fisherman_already'] call A3PL_NPC_Start;}; ['fisherman_work'] call A3PL_NPC_Start;","","['Shop_Fisherman'] call A3PL_Shop_open"]],
	//"Fishers island is always looking for more fisherman.<br/><br/>McFishers has to keep getting their fish from somewhere *laughs*<br/>Are you sure you want to become a fisherman?",["1. Yes, let me get fishing already!","2. Actually, I dont think I want to become a fisherman."]
	["fisherman_work",parseText localize"STR_NPC_FISHMANWORK",[localize"STR_NPC_FISHMANWORK1",localize"STR_NPC_FISHMANWORK2"],["['fisherman'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working as a fisherman..",["1. I was just joking! *laughs*","2. I would like to stop working here, I dont like fishing"]
	["fisherman_already",parseText localize"STR_NPC_FISHMANALREADY",[localize"STR_NPC_FISHMANALREADY1",localize"STR_NPC_FISHMANALREADY2"],["","[] call A3PL_NPC_LeaveJob;"]],
	//"You are now a fisherman!<br/><br/>Do I need to walk you through the basics?",["1. Yes please.", "2. I've done this kind of work before. I'm good!"]
	["fisherman_accepted",parseText localize"STR_NPC_FISHMANACCEPTED",[localize"STR_NPC_FISHMANACCEPTED1", localize"STR_NPC_FISHMANACCEPTED2"],["['fisherman_tutorial'] call A3PL_NPC_Start;",""]],
	//"Alright, listen carefully<br/>1. Buy a net and bucket from my shop<br/>2. Deploy the net when you are in the water<br/>3. Wait for a while, then retrieve the net",["1. Alright, got it!"]
	["fisherman_tutorial",parseText localize"STR_NPC_FISHMANTUTORIAL",[localize"STR_NPC_FISHMANTUTORIAL1"],[""]],

	//bank
	//"Welcome to the Bank Of Freedom.<br/><br/>How may I help you?",["1. I would like to sign my paycheck","2. I would like to check my bank account"]
	["bank_initial",parseText localize"STR_NPC_BANKINIT",[localize"STR_NPC_BANKINIT1",localize"STR_NPC_BANKINIT2"],["if ((player getVariable ['Player_Paycheck',0]) < 1) then {['bank_paycheckrefuse'] call A3PL_NPC_Start;} else {['bank_paycheckaccepted'] call A3PL_NPC_Start;};","[] call A3PL_ATM_Open;"]],
	//"It doesn't seem there is a check here for you to sign<br/>",["1. That's weird, alright. I'll come back later then."]
	["bank_paycheckrefuse",parseText localize"STR_NPC_BANKPCREF",[localize"STR_NPC_BANKPCREF1"],[""]],
	//"I found your check.<br/>Please sign it and I'll make sure the amount is deposited into your bank account.",["1. *sign paycheck* There you go, have a nice day!","2. I'll sign for my check later"]
	["bank_paycheckaccepted",parseText localize"STR_NPC_BANKPCACC",[localize"STR_NPC_BANKPCACC1",localize"STR_NPC_BANKPCACC2"],["[] call A3PL_Player_PickupPaycheck;",""]],

	//police
	//"Howdy!<br/><br/>How can I help you?",["1. Howdy! how do I become a sheriff?","2. Hello sir, I have a crime to report","3. Howdy Sheriff! I'm here to start my shift."]
	["police_initial",parseText localize"STR_NPC_POLICEINIT",[localize"STR_NPC_POLICEINIT1",localize"STR_NPC_POLICEINIT2",localize"STR_NPC_POLICEINIT3"],["['police_howto'] call A3PL_NPC_Start;","['police_reportcrime'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'police') exitwith {['police_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'police') then { ['police_work'] call A3PL_NPC_Start; } else {['police_workdenied'] call A3PL_NPC_Start;};"]],
	//"You can find more info on our website:<br/>http://www.FISD.com/",["1. Alright, thank you!"]
	["police_howto",parseText localize"STR_NPC_WEBSITEMOREINFO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	//"You can report crimes by calling 911",["1. Alright, thank you."]
	["police_reportcrime",parseText localize"STR_NPC_POLICEREPCRIME",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	//"You don't seem to be working here!<br/>Impersonating a sheriff is a crime!",["1. I'm sorry! I'll leave."]
	["police_workdenied",parseText localize"STR_NPC_POLICEDENIED",[localize"STR_NPC_SORRYILEAVE"],[""]],
	//"Welcome back sheriff<br/>Are you sure you are ready to start your shift?",["1. I'm ready, lets bust some criminals.","2. Let me grab some donuts and I'll be back"]
	["police_work",parseText localize"STR_NPC_WORK",[localize"STR_NPC_WORK1",localize"STR_NPC_WORK2"],["['police'] call A3PL_NPC_TakeJob;",""]],
	//"You are already on-duty, do you want to go off-duty?",["1. Yes please, It's time to go home.","2. Actually, nevermind."]
	["police_already",parseText localize"STR_NPC_ALREADY",[localize"STR_NPC_ALREADY1",localize"STR_NPC_ALREADY2"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now on-duty. Here is your radio.<br/>Make sure to grab your gear<br/>Good luck out there sheriff",["1. Thanks, I'll catch you later."]
	["police_accepted",parseText localize"STR_NPC_ACCEPTED",[localize"STR_NPC_ACCEPTED1"],[""]],

	//dispatch
	//"Howdy!<br/><br/>How can I help you?",["1. Howdy! How do I become a dispatch?","2. Hello sir, I have a crime to report","3. Howdy Sheriff! I'm here to start my dispatching shift."],
	["dispatch_initial",parseText localize"STR_NPC_DISPATCHINIT",[localize"STR_NPC_DISPATCHINIT1",localize"STR_NPC_DISPATCHINIT2",localize"STR_NPC_DISPATCHINIT3"],["['dispatch_howto'] call A3PL_NPC_Start;","['police_reportcrime'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'dispatch') exitwith {['dispatch_already'] call A3PL_NPC_Start;}; if (!((player getVariable ['faction','citizen']) IN ['police','dispatch','fifr','uscg','faa','dmv','doj'])) exitwith {['dispatch_workdenied'] call A3PL_NPC_Start;}; ['dispatch_work'] call A3PL_NPC_Start; "]],
	//"You can find more info on our website:<br/>http://www.FISD.com/",["STR_NPC_ALRIGHTTNX"]
	["dispatch_howto",parseText localize"STR_NPC_WEBSITEMOREINFO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	//"You don't seem to be working here!",["STR_NPC_SORRYILEAVE"]
	["dispatch_workdenied",parseText localize"STR_NPC_DISPATCHDENIED",[localize"STR_NPC_SORRYILEAVE"],[""]],
	//"Welcome back dispatcher<br/>Are you sure you are ready to start your shift?",["1. I'm ready","2. Let me grab some donuts and I'll be back"]
	["dispatch_work",parseText localize"STR_NPC_DISPATCHWORK",[localize"STR_NPC_DISPATCHWORK1",localize"STR_NPC_DISPATCHWORK2"],["['dispatch'] call A3PL_NPC_TakeJob;",""]],
	//"You are already on-duty, do you want to go off-duty?",["1. Yes please, It's time to go home.","2. Actually, nevermind."]
	["dispatch_already",parseText localize"STR_NPC_DISPATCHALREADY",[localize"STR_NPC_DISPATCHALREADY1",localize"STR_NPC_DISPATCHALREADY2"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now on-duty. Prepare for 911 calls.<br/>Make sure you stay calm and collective<br/>Good luck dispatcher!",["1. Thanks, I'll catch you later."]
	["dispatch_accepted",parseText localize"STR_NPC_DISPATCHALDUTY",[localize"STR_NPC_DISPATCHALDUTY1"],[""]],

	//USCG
	//"Hello.<br/><br/>How can I help you?",["1. Hello! I'm here to start my shift."]
	["uscg_initial",parseText localize"STR_NPC_USCGINIT",[localize"STR_NPC_USCGINIT1"],["if (player getVariable 'job' == 'uscg') exitwith {['uscg_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'uscg') then { ['uscg_work'] call A3PL_NPC_Start; } else {['uscg_workdenied'] call A3PL_NPC_Start;};"]],
	//"You don't seem to be working here!<br/>Impersonating a coast guard officer is a crime!",["STR_NPC_SORRYILEAVE"
	["uscg_workdenied",parseText localize"STR_NPC_USCGDENIED",[localize"STR_NPC_SORRYILEAVE"],[""]],
	//"Welcome back!<br/>Are you sure you are ready to start your shift?",["1. I'm ready, lets bust some smugglers.","2. I changed my mind"]
	["uscg_work",parseText localize"STR_NPC_USCGWORK",[localize"STR_NPC_USCGWORK1",localize"STR_NPC_USCGWORK2"],["['uscg'] call A3PL_NPC_TakeJob;",""]],
	//"You are already on-duty, do you want to go off-duty?",["1. Yes please, It's time to go home.","2. Actually, nevermind."]
	["uscg_already",parseText localize"STR_NPC_USCGALREADY",[localize"STR_NPC_USCGALREADY1",localize"STR_NPC_USCGALREADY2"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now on-duty. Here is your radio.<br/>Make sure to grab your gear<br/>Good luck out there.",["1. Thanks, I'll catch you later."]
	["uscg_accepted",parseText localize"STR_NPC_USCGALACCEPTED",[localize"STR_NPC_USCGALACCEPTED1"],[""]],

	//FIFR
	//  "Hello!<br/>How can I help you?",["1. I don't feel well, can you check me out?","2. How do I become part of the FIFR?","3. Hello colleague, I'm here to start my shift."]
	["fifr_initial",parseText localize"STR_NPC_FIFRINIT",[localize"STR_NPC_FIFRINIT1",localize"STR_NPC_FIFRINIT2",localize"STR_NPC_FIFRINIT3"],["if ((str (player getvariable ['A3PL_Wounds',[]]) == '[]') OR ((player getvariable ['A3PL_MedicalVars',[5000]] select 0) == 5000)) exitwith {['fifr_healdenied'] call A3PL_NPC_Start;}; ['fifr_heal'] call A3PL_NPC_Start;","['fifr_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'fifr') exitwith {['fifr_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'fifr') then { ['fifr_work'] call A3PL_NPC_Start; } else {['fifr_workdenied'] call A3PL_NPC_Start;};"]],
	// "You seem fine<br/>You don't need medical attention",["1. Alright then, thanks anyway."]
	["fifr_healdenied",parseText localize"STR_NPC_FIFRHEALD",[localize"STR_NPC_FIFRHEALD1"],[""]],
	//"You can find more info on our website:<br/>http://www.FIFR.com/",["STR_NPC_ALRIGHTTNX"]
	["fifr_howto",parseText localize"STR_NPC_FIFRHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],
	//"You don't seem to be working here!<br/>Impersonating as an FIFR is a crime!",["1. I'm sorry! I'll leave"]
	["fifr_workdenied",parseText localize"STR_NPC_FIFRDEN",[localize"STR_NPC_FIFRDEN1"],[""]],
	//"Welcome back<br/>Are you ready to start your shift today?",["1. I'm ready, time to save some lives.","2. I'm not ready yet."]
	["fifr_work",parseText localize"STR_NPC_FIFRWORK",[localize"STR_NPC_FIFRWORK1",localize"STR_NPC_FIFRWORK2"],["['fifr'] call A3PL_NPC_TakeJob;",""]],
	//"You are already on-duty, do you want to go off-duty?",["1. Yes please, it's time to go home.","2. Actually, nevermind."]
	["fifr_already",parseText localize"STR_NPC_FIFRALREADY",[localize"STR_NPC_FIFRALREADY1",localize"STR_NPC_FIFRALREADY2"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now on-duty. Here is your radio.<br/>Make sure to grab your gear<br/>Good luck out there",["1. Thanks, I'll catch you later."]
	["fifr_accepted",parseText localize"STR_NPC_FIFRACC",[localize"STR_NPC_FIFRACC1"],[""]],
	//"We will take a look at you for $100<br/>Are you sure you want to pay this?",["1. I'm sure, I'm really not feeling well","2. That is too expensive, sorry."]
	["fifr_heal",parseText localize"STR_NPC_FIFRHEAL",[localize"STR_NPC_FIFRHEAL1",localize"STR_NPC_FIFRHEAL2"],["[] call A3PL_Medical_Heal;"]],
	//"I gave you some medicine that'll make you feel better<br/>You can always come back for a check-up.",["1. Alright, thank you sir!"]
	["fifr_healdone",parseText localize"STR_NPC_FIFRDONE",[localize"STR_NPC_FIFRDONE1"],[""]],

	//Roadworker
	//"Hello!<br/>How can I help you?",["1. Hello there, I would like to become an roadworker and maintain the island!","2. Nothing, bye"]
	["roadworker_initial",parseText localize"STR_NPC_ROADWINIT",[localize"STR_NPC_ROADWINIT1",localize"STR_NPC_ROADWINIT2"],["if ((player getVariable ['job','unemployed']) == 'roadworker') exitwith {['roadworker_already'] call A3PL_NPC_Start;}; ['roadworker_work'] call A3PL_NPC_Start;",""]],
	//"Sure, we are always looking for people to help out<br/><br/>Are you sure you would like to become a roadworker?",["Yes, I'm sure!","No, I changed my mind"]
	["roadworker_work", parseText localize"STR_NPC_ROADWWORK",[localize"STR_NPC_ROADWWORK1",localize"STR_NPC_ROADWWORK2"],["['roadworker'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working as a roadworker<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["roadworker_already", parseText localize"STR_NPC_ROADWALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now a roadworker<br/>Do I need to explain the basics of towing vehicles?",["1. Yes please","2. No, I'm good"]
	["roadworker_accepted", parseText localize"STR_NPC_ROADWACC",[localize"STR_NPC_ROADWACC1",localize"STR_NPC_ROADWACC2"],["['roadworker_howto'] call A3PL_NPC_Start;",""]],
	//"Alright, it's really easy<br/><br/>1. You will receive a message when cars are marked for impound, use the map to see where<br/>2. Tow the vehicles back here and earn a reward!",["STR_NPC_ALRIGHTTNX"]
	["roadworker_howto", parseText localize"STR_NPC_ROADWHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	//Farmer
	//"Hello!<br/>How can I help you?",["1. Hello there, I would like to become a farmer and grow crops!","2. Nothing, bye"]
	["farmer_initial",parseText localize"STR_NPC_FARMINIT",[localize"STR_NPC_FARMINIT1",localize"STR_NPC_FARMINIT2"],["if ((player getVariable ['job','unemployed']) == 'farmer') exitwith {['farmer_already'] call A3PL_NPC_Start;}; ['farmer_work'] call A3PL_NPC_Start;",""]],
	//"Sure, we are always looking for people to help out<br/><br/>Are you sure you would like to become a farmer?",["Yes, I'm sure!","No, I changed my mind"]
	["farmer_work", parseText localize"STR_NPC_FARMWORK",[localize"STR_NPC_FARMWORK1",localize"STR_NPC_FARMWORK2"],["['farmer'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working as a farmer<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["farmer_already", parseText localize"STR_NPC_FARMALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now a farmer<br/>Do I need to explain the basics of farming?",["1. Yes please","2. No, I'm good"]
	["farmer_accepted", parseText localize"STR_NPC_FARMACC",[localize"STR_NPC_FARMACC1",localize"STR_NPC_FARMACC2"],["['farmer_howto'] call A3PL_NPC_Start;",""]],
	//"Alright, it's really easy<br/><br/>1. Find seeds in this field<br/>2. Plant the seeds in the field<br/>3. Harvest them when they are done growing and profit",["STR_NPC_ALRIGHTTNX"]
	["farmer_howto", parseText localize"STR_NPC_FARMHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	//Oil recovery job
	//"Hello!<br/>How can I help you?",["1. Hello there, I would like to become an oil recoverer and pump up the oil!","2. Nothing, bye"]
	["oil_initial",parseText localize"STR_NPC_OILRECINIT",[localize"STR_NPC_OILRECINIT1",localize"STR_NPC_OILRECINIT2"],["if ((player getVariable ['job','unemployed']) == 'oil') exitwith {['oil_already'] call A3PL_NPC_Start;}; ['oil_work'] call A3PL_NPC_Start;",""]],
	//"Sure, we are always looking for people to help supply us with crude oil!<br/><br/>Are you sure you would like to become an oil recoverer?",["Yes, I'm sure!","No, I changed my mind"]
	["oil_work", parseText localize"STR_NPC_OILRECWORK",[localize"STR_NPC_OILRECWORK1",localize"STR_NPC_OILRECWORK2"],["['oil'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working as an oil recoverer<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["oil_already", parseText localize"STR_NPC_OILRECALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now an oil recoverer<br/>Do I need to explain the basics of oil recovery?",["1. Yes please","2. No, I'm good"]
	["oil_accepted", parseText localize"STR_NPC_OILRECACC",[localize"STR_NPC_OILRECACC1",localize"STR_NPC_OILRECACC2"],["['oil_howto'] call A3PL_NPC_Start;",""]],
	//"Alright.<br/><br/>1. Find a wildcatter who can find a suitable area for oil extraction<br/>2. Have the wildcatter drill a hole<br/>3. Connect a jack pump and start it up",["STR_NPC_ALRIGHTTNX"]
	["oil_howto", parseText localize"STR_NPC_OILRECHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],

	//oil wildcat job
	//"Hello!<br/>How can I help you?",["1. Hello there, I would like to become an wildcat and find oil!","2. Nothing, bye"]
	["wildcat_initial",parseText localize"STR_NPC_WILDCATINIT",[localize"STR_NPC_WILDCATINIT1",localize"STR_NPC_WILDCATINIT2"],["if ((player getVariable ['job','unemployed']) == 'wildcat') exitwith {['wildcat_already'] call A3PL_NPC_Start;}; ['wildcat_work'] call A3PL_NPC_Start;",""]],
	//"Sure, we are always looking for people to help and find and drill for oil!<br/><br/>Are you sure you would like to become a wildcat?",["Yes, I'm sure!","No, I changed my mind"]
	["wildcat_work", parseText localize"STR_NPC_WILDCATWORK",[localize"STR_NPC_WILDCATWORK1",localize"STR_NPC_WILDCATWORK2"],["['wildcat'] call A3PL_NPC_TakeJob;",""]],
	//"You are already working as a wildcat<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["wildcat_already", parseText localize"STR_NPC_WILDCATALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"You are now an wildcat!<br/>Do I need to explain the basics of wildcatting?",["1. Yes please","2. No, I'm good"]
	["wildcat_accepted", parseText localize"STR_NPC_WILDCATACC",[localize"STR_NPC_WILDCATACC1",localize"STR_NPC_WILDCATACC2"],["['wildcat_howto'] call A3PL_NPC_Start;",""]],
	//"Alright.<br/>1. Create a drill trailer and connect it to your vehicle<br/>2. Prospect the land and look for resources<br/>3. An oil recoverer can now connect a pump jack",["STR_NPC_ALRIGHTTNX"]
	["wildcat_howto", parseText localize"STR_NPC_WILDCATHOWTO",[localize"STR_NPC_ALRIGHTTNX"],[""]],


	//faa
	//"Hello there!<br/><br/>How can I help you?",["1. Hello! How do I work here?","2. Hello there! Am here to check-in as ATC controller"]
	["faastart_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAAINIT1",localize"STR_NPC_FAAINIT2"],["['faastart_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'faa') exitwith {['faastart_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' IN ['faa','uscg']) then { ['faastart_work'] call A3PL_NPC_Start; } else {['faastart_workdenied'] call A3PL_NPC_Start;}"]],
	//"You can find more info on our website:<br/>http://www.FAA.gov/",["1. Alright, thank you!"]
	["faastart_howto",parseText localize"STR_NPC_FAAHOWTO",[localize"STR_NPC_AIGHTTNX"],[localize"STR_NPC_ALRIGHTTNX"]],
	//"You are already working as the FAA<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["faastart_already", parseText localize"STR_NPC_FAAALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"Welcome back FAA member<br/>Are you sure you are ready to start your shift?",["1. I'm ready.","2. I'll be back"]
	["faastart_work",parseText localize"STR_NPC_FAAWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['faa'] call A3PL_NPC_TakeJob;",""]],
	//"You don't seem to be working here!<br/>You are not an FAA employee",["STR_NPC_SORRYILEAVE"]
	["faastart_workdenied",parseText localize"STR_NPC_FAADEN",[localize"STR_NPC_SORRYILEAVE"],[""]],


	//government
	// "Hello there!<br/><br/>How can I help you?",["1. Hello! How do I work here?","2. Hello there! Am here to check-in as a government employee"]
	["government_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_GOVINIT1",localize"STR_NPC_GOVINIT2"],["['government_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'gov') exitwith {['government_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'gov') then { ['government_work'] call A3PL_NPC_Start; } else {['government_workdenied'] call A3PL_NPC_Start;}"]],
	//"You can find more info on our website:<br/>http://www.government.gov/",["1. Alright, thank you!"]
	["government_howto",parseText localize"STR_NPC_GOVHOWTO",[localize"STR_NPC_AIGHTTNX"],[""]],
	//"You are already working as the government<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["government_already", parseText localize"STR_NPC_GOVALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"Welcome back Government member<br/>Are you sure you are ready to start your shift?",["1. I'm ready.","2. I'll be back"]
	["government_work",parseText localize"STR_NPC_GOVWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['gov'] call A3PL_NPC_TakeJob;",""]],
	//"You don't seem to be working here!<br/>You are not a GOV employee",["STR_NPC_SORRYILEAVE"]
	["government_workdenied",parseText localize"STR_NPC_GOVDEN",[localize"STR_NPC_SORRYILEAVE"],[""]],

	//DOJ
	//"Hello there!<br/><br/>How can I help you?",["1. Hello! How do I work here?","2. Hello there! Am here to check-in as DOJ employee"]
	["doj_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAAINIT1",localize"STR_NPC_DOJINIT2"],["['doj_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'doj') exitwith {['doj_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'doj') then { ['doj_work'] call A3PL_NPC_Start; } else {['doj_workdenied'] call A3PL_NPC_Start;}"]],
	//"You can find more info on our website:<br/>http://www.doj.gov/",["1. Alright, thank you!"]
	["doj_howto",parseText localize"STR_NPC_DOJHOWTO",[localize"STR_NPC_AIGHTTNX"],[""]],
	//"You are already working as the doj<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."]
	["doj_already", parseText localize"STR_NPC_DOJALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	//"Welcome back doj member<br/>Are you sure you are ready to start your shift?",["1. I'm ready.","2. I'll be back"]
	["doj_work",parseText localize"STR_NPC_DOJWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['doj'] call A3PL_NPC_TakeJob;",""]],
	//"You don't seem to be working here!<br/>You are not an doj employee",["STR_NPC_SORRYILEAVE"]
	["doj_workdenied",parseText localize"STR_NPC_DOJDEN",[localize"STR_NPC_SORRYILEAVE"],[""]],

	//PDO
	["pdo_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAAINIT1",localize"STR_NPC_PDOINIT2"],["['pdo_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'pdo') exitwith {['pdo_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'pdo') then { ['pdo_work'] call A3PL_NPC_Start; } else {['pdo_workdenied'] call A3PL_NPC_Start;}"]],
	["pdo_howto",parseText localize"STR_NPC_PDOHOWTO",[localize"STR_NPC_AIGHTTNX"],[""]],
	["pdo_already", parseText localize"STR_NPC_PDOALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	["pdo_work",parseText localize"STR_NPC_PDOWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['pdo'] call A3PL_NPC_TakeJob;",""]],
	["pdo_workdenied",parseText localize"STR_NPC_PDODEN",[localize"STR_NPC_SORRYILEAVE"],[""]],

	//DAO
	["dao_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAAINIT1",localize"STR_NPC_DAOINIT2"],["['dao_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'dao') exitwith {['dao_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'dao') then { ['dao_work'] call A3PL_NPC_Start; } else {['dao_workdenied'] call A3PL_NPC_Start;}"]],
	["dao_howto",parseText localize"STR_NPC_DAOHOWTO",[localize"STR_NPC_AIGHTTNX"],[""]],
	["dao_already", parseText localize"STR_NPC_DAOALR",[localize"STR_NPC_STOPWORKINGHER",localize"STR_NPC_LIKEJOBNVM"],["[] call A3PL_NPC_LeaveJob;",""]],
	["dao_work",parseText localize"STR_NPC_DAOWORK",[localize"STR_NPC_IMREADY",localize"STR_NPC_BEBACKLATER"],["['dao'] call A3PL_NPC_TakeJob;",""]],
	["dao_workdenied",parseText localize"STR_NPC_DAODEN",[localize"STR_NPC_SORRYILEAVE"],[""]],

	//DMV
	["dmv_initial",parseText "Hello there!<br/><br/>How can I help you?",["1. Hello! How do I work here?","2. Hello there! Am here to check-in as DMV employee"],["['dmv_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'dmv') exitwith {['dmv_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'dmv') then { ['dmv_work'] call A3PL_NPC_Start; } else {['dmv_workdenied'] call A3PL_NPC_Start;}"]],
	["dmv_howto",parseText "You can find more info on our website:<br/>http://www.DMV.gov/",["1. Alright, thank you!"],[""]],
	["dmv_already", parseText "You are already working as the DMV<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."],["[] call A3PL_NPC_LeaveJob;",""]],
	["dmv_work",parseText "Welcome back DMV member<br/>Are you sure you are ready to start your shift?",["1. I'm ready.","2. I'll be back"],["['dmv'] call A3PL_NPC_TakeJob;",""]],
	["dmv_workdenied",parseText "You don't seem to be working here!<br/>You are not a DMV employee",["1. Sorry, I'll leave"],[""]],

	//Verizon
	["verizon_initial",parseText "Hello!<br/><br/>How can I help you?",["1. Hello! I would like a subscription!"],["['verizon_howto'] call A3PL_NPC_Start;"]],
	["verizon_howto",parseText "You have the choice between different subscriptions!",["1. Primary ($912)","2. Secondary ($8024)","3. Company ($27215)"],["[] spawn A3PL_iPhoneX_addPhoneNumberPrimary;","[] spawn A3PL_iPhoneX_addPhoneNumberSecondary;","[] spawn A3PL_iPhoneX_AddPhoneNumberEnterprise;"]],

	//DOC
	["doc_initial",parseText "Hello there!<br/><br/>How can I help you?",["1. Hello! How do I work here?","2. Hello there! Am here to check-in as USMS employee"],["['doc_howto'] call A3PL_NPC_Start;","if (player getVariable 'job' == 'usms') exitwith {['doc_already'] call A3PL_NPC_Start;}; if (player getVariable 'faction' == 'usms') then { ['doc_work'] call A3PL_NPC_Start; } else {['doc_workdenied'] call A3PL_NPC_Start;}"]],
	["doc_howto",parseText "You can find more info on our website:<br/>http://www.usms.gov/",["1. Alright, thank you!"],[""]],
	["doc_already", parseText "You are already working as the USMS<br/>Would you like to stop working here?",["1. Yes I would like to stop working here","2. Actually, I like this job, nevermind."],["[] call A3PL_NPC_LeaveJob;",""]],
	["doc_work",parseText "Welcome back USMS member<br/>Are you sure you are ready to start your shift?",["1. I'm ready.","2. I'll be back"],["['usms'] call A3PL_NPC_TakeJob;",""]],
	["doc_workdenied",parseText "You don't seem to be working here!<br/>You are not a DOC employee",["1. Sorry, I'll leave"],[""]],

	//faastop
	//"Hello there!<br/><br/>How can I help you?",["1. Hello! I would like to sign off as ATC and go back down"]
	["faastop_initial",parseText localize"STR_NPC_HELLOWHOWHELP",[localize"STR_NPC_FAASTOP1"],["[] call A3PL_ATC_LeaveJob;"]],
	//Roadside service
	["roadside_service_initial",parseText "Would you like to beacome a Roadside Service worker?",["Sure, how much do I get paid?","No, I need some items","No thank you, bye"],["if ((player getVariable ['job','unemployed']) == 'Roadside_Service') exitwith {['roadside_service_already'] call A3PL_NPC_Start;}; ['roadside_service_work'] call A3PL_NPC_Start;","if ((player getVariable ['job','unemployed']) == 'Roadside_Service') exitwith {['roadside_service_supplies'] call A3PL_Shop_Open;};",""]],
	["roadside_service_work", parseText "You get $400 each paycheck and $500 for each car you impound.",["Pay sounds good, when do I start?","No, I changed my mind"],["['Roadside_Service'] call A3PL_NPC_TakeJob;['roadside_service_accepted'] call A3PL_NPC_Start;",""]],
	["roadside_service_already", parseText "You are already work for us.<br/>Would you like to stop working here?",["Yes I would like to stop working here","Actually, I like this job, nevermind."],["[] call A3PL_NPC_LeaveJob;",""]],
	["roadside_service_accepted", parseText "You're now a Roadside Service worker<br/>Do I need to explain the job?",["Nah, I'm good","Yes please"],["","['roadside_service_howto'] call A3PL_NPC_Start;"]],
	["roadside_service_howto", parseText "You have two jobs:<br/>1. Is to provide assistance to people broken down<br/>2. Is to impound marked vehicles...",["Continue","Alright I get it, thank you"],["['roadside_service_howtopt2'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt2", parseText "Providing assistance: You will need Repair Wrenches and Jerry Cans that can be bought at General Store...",["Continue","Alright I get it, thank you"],["['roadside_service_howtopt3'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt3", parseText "If the vehicle is too damaged it will need to be towed to a garage or you can tow vehicle to gas stations for refueling.",["Continue","Alright I get it, thank you"],["['roadside_service_howtopt4'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt4", parseText "Impounding vehicles: You will receive a message when cars are marked for impound, use your map to see where...",["Continue","Alright I get it, thank you"],["['roadside_service_howtopt5'] call A3PL_NPC_Start;",""]],
	["roadside_service_howtopt5", parseText "Once you have retrieved the vehicle tow it back here and impound it to receive your reward.",["Alright, thank you"],[""]]
];

publicVariable "Config_NPC_Text";
