A3PL_Respawn_Time = 60 * 10;
PublicVariable "A3PL_Respawn_Time";

Config_Medical_Wounds =
[
	//ID, WOUND NAME,CAUSES UNCONSCIOUSNESS,SEVERITY (orange/red),INSTANT BLOOD LOSS, BLOOD LOSS UNTIL TREATED,PAIN LEVEL INCREASE,ITEM TO TREAT, FULLY HEALS, ITEM TO FULLY HEAL
	//Bullet wounds
	["bullet_minor","minor gunshot wound","orange",950,50,5,"med_bandage",false, "med_kit"], // "med_suture"
	["bullet_major","major gunshot wound","red",1800,70,8,"med_bandage",false,"med_kit"], // "med_surgical"
	["bullet_head","major gunshot wound head","red",2500,80,8,"med_bandage",false,"med_kit"],

	["wound_minor","minor wound","orange",600,30,3,"med_bandage",true,""],
	["wound_major","Major wound","red",800,40,5,"med_bandage",false,"med_kit"], //"med_suture"
	["bruise","bruise","orange",0,0,1,"med_icepack",true,""],
	["cut","cut","orange",80,5,1,"med_bandage",true,""],
	["bone_broken","Broken bone","red",600,40,6,"med_splint",false,"med_cast"], //"med_splint" "med_cast"
	["taser","Taser dart","orange",0,0,1,"",true,""],

	//concussion
	["concussion_minor","Minor Concussion","orange",0,0,2,"med_painkillers",true,""],
	["concussion_major","Major Concussion","red",0,0,4,"",false,"med_icepack"],

	//Winston Additions
	["nausea","Nausea","orange",0,0,8,"med_painkillers",true,""],
	["breathing","Respiratory Difficulties","red",0,0,8,"",false,"med_endotracheal"],
	
	//fire damage
	["smoke_minor","Minor smoke inhalation","orange",0,0,1,"med_painkillers",true,"med_oxygenmask"], //dissapears by itself
	["smoke_medium","Medium smoke inhalation","orange",0,0,1,"",false,"med_endotracheal"], //"med_oxygen"
	["smoke_major","Major smoke inhalation","red",0,0,1,"",false,"med_endotracheal"], //causes unconciousness "med_endotracheal"
	
	["burn_first","First-degree burn","orange",0,0,1,"med_icepack",true,""],
	["burn_second","Second-degree burn","orange",0,0,2,"med_icepack",true,""],
	["burn_third","Third-degree burn","red",300,30,3,"med_icepack",false,"med_autograft"],
	["burn_fourth","Fourth-degree burn","red",500,50,3,"med_icepack",false,"med_autograft"],
	["burn_fifth","Fifth-degree burn","red",700,70,3,"",false,"med_bandage"]
];
PublicVariable "Config_Medical_Wounds";