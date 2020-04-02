/* #Bipezo
$[
	1.063,
	["ID",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.0204713 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.257813 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.75],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Name:",["0.0204687 * safezoneW + safezoneX","0.115 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"DOB:",["0.0204687 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"ID:",["0.0204687 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[1,"Gender:",["0.0204687 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1009,"",[1,"Issued:",["0.0204687 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1011,"",[1,"Faction:",["0.0204687 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"FIRST & LAST NAME",["0.066875 * safezoneW + safezoneX","0.115 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"DATE OF BIRTH",["0.066875 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[1,"DATABASE ID",["0.066875 * safezoneW + safezoneX","0.181 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"",[1,"Male",["0.066875 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1010,"",[1,"DATE ISSUED",["0.066875 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1012,"",[1,"FACTION HERE",["0.066875 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1013,"",[1,"Licenses:",["0.0204687 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1014,"text_licenses",[1,"LICENSES HERE",["0.066875 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.226875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_HUD_IDCard
{
	idd = 12345;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_IDCard',_this select 0];";
	onUnload = "";
	
	class controlsBackground 
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.0204713 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.242 * safezoneH;
			colorBackground[] = {0,0,0,0.75};
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Name:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "DOB:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "ID:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "Gender:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1009: RscText
		{
			idc = 1009;
			text = "Issued:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1011: RscText
		{
			idc = 1011;
			text = "Faction:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "Licenses:"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.04425 * safezoneW;
			h = 0.022 * safezoneH;
		};		
	};
	
	class controls
	{
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "FIRST & LAST NAME"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "DATE OF BIRTH"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "DATABASE ID"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = "Male"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1010: RscText
		{
			idc = 1010;
			text = "DATE ISSUED"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscText_1012: RscText
		{
			idc = 1012;
			text = "FACTION HERE"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class text_licenses: RscText
		{
			idc = 1014;
			text = "LICENSES HERE"; //--- ToDo: Localize;
			x = 0.066875 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.226875 * safezoneW;
			h = 0.022 * safezoneH;
		};		
	};
};