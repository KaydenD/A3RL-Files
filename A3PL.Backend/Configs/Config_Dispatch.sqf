private ['_timeCrime','_timeDir','_timeA',"_timeVeh","_timeColour"];
// Default sleep after the crime part
_timeCrime = 2;
_timeDir = 1.5;
_timeA = 0.5;
_timeVeh = 1;
_timeColour = 0.7;

//Custom code for INS(instruction) dispath
Config_Dispatch_INS = [
	{
		player say2d "THIS_IS_CONTROL"; 
		player say2d "UNITS_PLEASE_BE_ADVISED"; 
		player say2d "Weve_got";	
	},
	{
		player say2d "ATTENTION_ALL_UNITS_WE_HAVE";
	},
	{
		player say2d "UNITS_PLEASE_BE_ADVISED";
		player say2d "Weve_got";
	},
	{
		player say2d "THIS_IS_CONTROL";
		player say2d "AVAILABLE_UNITS_RESPOND_TO";
	},
	{
		player say2d "AVAILABLE_UNITS_RESPOND_TO";
	},
	{
		player say2d "UNITS_PLEASE_BE_ADVISED";
		player say2d "I_NEED_A_UNIT_FOR";
	},
	{
		player say2d "THIS_IS_CONTROL";
		player say2d "UNITS_PLEASE_BE_ADVISED";
		player say2d "I_NEED_A_UNIT_FOR";
	},
	{
		player say2d "THIS_IS_CONTROL";
		player say2d "I_NEED_A_UNIT_FOR";
	}

];

Config_911System = [
	//Category (should match those defined in A3PL_911System_Open),Text displayed in combo and other texts, CfgSounds Classname,Time to wait (in S) before next part 
	['Fire Related','Burned victim','BURNED_VICTIM',_timeCrime],
	['Fire Related','Burning building','BURNING_BUILDING',_timeCrime],	
	['Fire Related','Burning apartment','BURNING_APARTMENT',_timeCrime],	
	['Fire Related','House fire','HOUSE_FIRE',_timeCrime],
	['Fire Related','Fire','FIRE',_timeCrime],
	['Fire Related','Explosion','EXPLOSION',_timeCrime],
	['Fire Related','Vehicle Explosion','VEHICLE_EXPLOSION',_timeCrime],
	['Fire Related','Vehicle fire','VEHICLE_FIRE',_timeCrime],
	['Fire Related','Arson Attack','ARSON_ATTACK',_timeCrime],
	
	['Traffic Related','Vehicle Accident','VEHICLE_ACCIDENT',_timeCrime],
	['Traffic Related','Running a red light','RED_LIGHT',_timeCrime],
	['Traffic Related','Not wearing a helmet','NO_HELMET',_timeCrime],
	['Traffic Related','Reckless Driving','RECKLESS_DRIVING',_timeCrime],
	['Traffic Related','Traffic Violation','TRAFFIC_VIOLATION',_timeCrime],
	['Traffic Related','Speeding','SPEEDING',_timeCrime],
	['Traffic Related','Moving Violation','MOVING_VIOLATION',_timeCrime],
	
	['Vehicular Related','Grand Theft Auto','GTA',_timeCrime],
	['Vehicular Related','Pedestrian Struck','PEDESTRIAN_STRUCK',_timeCrime],	
	['Vehicular Related','Officer Struck','COP_STRUCK',_timeCrime],
	['Vehicular Related','Attack on a vehicle','ATTACK_VEHICLE',_timeCrime],
	['Vehicular Related','Stolen Vehicle','STOLEN_VEHICLE',_timeCrime],	
	['Vehicular Related','Hit and Run','HIT_AND_RUN',_timeCrime],
	['Vehicular Related','Vessel in distress','VESSEL_DISTRESS',_timeCrime],
	['Vehicular Related','Helicopter Down','HELI_DOWN',_timeCrime],
	
	['Medical Related','Medical Emergency','MEDICAL_EMERGENCY',_timeCrime],
	['Medical Related','Civilian Fatality','CIV_FATALITY',_timeCrime],
	['Medical Related','Officer Down','COP_DOWN',_timeCrime],
	['Medical Related','Civilian Unconcious','CIV_UNCONCIOUS',_timeCrime],
	['Medical Related','Civilian Injured','CIV_INJURED',_timeCrime],
	['Medical Related','Officer Injured','COP_INJURED',_timeCrime],
	['Medical Related','Case of Anthrax','ANTHRAX',_timeCrime],
	['Medical Related','Case of Tuburculosis','TUBURCULOSIS',_timeCrime],	

	['Gun Related','Firearm Discharge','FIREARM_DISCHARGE',_timeCrime],
	['Gun Related','Shooting','SHOOTING',_timeCrime],
	['Gun Related','Shoot out','SHOOT_OUT',_timeCrime],		
	['Gun Related','Illegal Firearm Possession','FIREARM_POSSESSION',_timeCrime],
	['Gun Related','Person aiming at an officer','TAKING_AIM_OFFICER',_timeCrime],
	['Gun Related','Firearm attack on an officer','FIREARM_ATTACK_OFFICER',_timeCrime],
	
	['General','Assault on a civilian','CIV_ASSAULT',_timeCrime],
	['General','Assault on an officer','COP_ASSAULT',_timeCrime],
	['General','Mugging in progress','MUGGING',_timeCrime],
	['General','Domestic Disturbance','DOMESTIC_DISTURBANCE',_timeCrime],
	['General','Attempted Prisonbreak','ATTEMPTED_PRISONBREAK',_timeCrime],
	['General','Drugs deal','DRUG_DEAL',_timeCrime],
	['General','Knifing','KNIFING',_timeCrime],
	['General','Knife assault on an officer','COP_KNIFE_ASSAULT',_timeCrime],		

	['Gang Related','Gang Disturbance','GANG_DISTURBANCE',_timeCrime],
	['Gang Related','Gang Trouble','GANG_TROUBLE',_timeCrime],
	['Gang Related','Gang Related Violence','GANG_RELATED_VIOLENCE',_timeCrime],	

	['dir','Suspect is Northbound','NORTHBOUND',_timeDir],
	['dir','Suspect is Eastbound','EASTBOUND',_timeDir],
	['dir','Suspect is Southbound','SOUTHBOUND',_timeDir],	
	['dir','Suspect is Westbound','WESTBOUND',_timeDir],
	
	['a','A','A_1',_timeA],
	['a','A','A_2',_timeA],
	['a','A','A_3',_timeA],
	['a','A','A_4',_timeA],
	['a','A','A_5',_timeA],
	['a','A','A_6',_timeA],
	['a','A','A_7',_timeA],

	['veh','Suspect last seen in','SUSPECT_LAST_SEEN_IN',_timeVeh+0.5],
	
	['ins','Suspect','SUSPECT',_timeCrime],
	['ins','On foot','ON_FOOT',_timeCrime],
	['ins','Attention all units we have','ATTENTION_ALL_UNITS_WE_HAVE',_timeCrime],
	['ins','I need assistance for','I_NEED_ASSISTANCE_FOR',_timeCrime],
	['ins','This is control','THIS_IS_CONTROL',_timeCrime],
	['ins','I need a unit for','I_NEED_A_UNIT_FOR',_timeCrime],
	['ins','Available units respond to','AVAILABLE_UNITS_RESPOND_TO',_timeCrime],
	['ins','Dispatch an ambulance','DISPATCH_AN_AMBULANCE',_timeCrime],
	['ins','Available Firefighters respond to','AVAILABLE_FIREFIGHTERS_RESPOND_TO',_timeCrime],
	['ins','Weve got','WEVE_GOT',_timeCrime],
	['ins','Please investigate','PLEASE_INVESTIGATE',_timeCrime],
	['ins','Armed and dangerous','ARMED_AND_DANGEROUS',_timeCrime],
	['ins','Units please be advised','UNITS_PLEASE_BE_ADVISED',_timeCrime],
	['ins','Units please respond','UNITS_PLEASE_RESPOND',_timeCrime],
	['ins','All units please respond','ALLUNITS_PLEASE_RESPOND',_timeCrime],
	['ins','Immidiate Response Necesarry','IMMIDIATE_RESPONSE_NECESARRY',_timeCrime],
	['ins','Use Caution','USE_CAUTION',_timeCrime],	
	
	['Type','Sports Car','SPORTS_CAR',_timeVeh],
	['Type','Motorcycle','MOTORCYCLE',_timeVeh],
	['Type','Truck','TRUCK',_timeVeh],
	['Type','Four Door','FOUR_DOOR',_timeVeh],
	['Type','Two Door','TWO_DOOR',_timeVeh],
	['Type','Hatchback','HATCHBACK',_timeVeh],
	['Type','Sedan','SEDAN',_timeVeh],
	['Type','Convertible','CONVERTIBLE',_timeVeh],
	['Type','Coupe','COUPE',_timeVeh],
	['Type','Helicopter','HELICOPTER',_timeVeh],
	['Type','Speedboat','SPEEDBOAT',_timeVeh],
	['Type','Yacht','YACHT',_timeVeh],

	['Colour','Black','BLACK',_timeVeh],
	['Colour','Blue','BLUE',_timeVeh],
	['Colour','Green','GREEN',_timeVeh],
	['Colour','Red','RED',_timeVeh],
	['Colour','Brown','BROWN',_timeVeh],
	['Colour','Gold','GOLD',_timeVeh],
	['Colour','Grey','GREY',_timeVeh],
	['Colour','Orange','ORANGE',_timeVeh],
	['Colour','Pink','PINK',_timeVeh]
	
];

publicVariable "Config_Dispatch_INS";
publicVariable "Config_911System";