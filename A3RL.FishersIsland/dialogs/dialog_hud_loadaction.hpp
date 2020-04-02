class Dialog_HUD_LoadAction
{
	idd = 39;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['Dialog_HUD_LoadAction',_this select 0];";
	onUnload = "";
	class controlsBackground
	{
		class static_loadingImage: RscPicture
		{
			idc = 394;
			text = "\A3PL_Common\GUI\A3PL_LoadAction.paa";
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.995156 * safezoneW;
			h = 1.001 * safezoneH;
		};
		class Progress_loadingbar: RscProgress
		{
			idc = 350;
			colorFrame[] = {0.72,0.72,0.72,1};
			colorBar[] = {0.641,0.25,0.109,1};	
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.295781 * safezoneW + safezoneX;
			y = 0.758445 * safezoneH + safezoneY;
			w = 0.403542 * safezoneW;
			h = 0.0413333 * safezoneH;
		};
		class Progress_welcomeHeader: RscStructuredText
		{
			idc = 351;
			text = "$STR_HUDLOADACTION_GUIPERFORMINGACTION";
			x = 0.295781 * safezoneW + safezoneX;
			y = 0.768445 * safezoneH + safezoneY;
			w = 0.403542 * safezoneW;
			h = 0.0413333 * safezoneH;
		};		
		class text_percentage: RscStructuredText
		{
			idc = 352; 
			text = "0%"; //--- ToDo: Localize;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.077 * safezoneH;
			sizeEx = 1.6 * GUI_GRID_H;
		};
	};
};

/* #Gokahi
$[
	1.063,
	["Loading",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_loadingImage",[1,"loading.paa",["0.04625 * safezoneW + safezoneX","0.115 * safezoneH + safezoneY","0.912656 * safezoneW","0.759 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"Progress_loadingbar",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.321093 * safezoneW + safezoneX","0.478926 * safezoneH + safezoneY","0.371771 * safezoneW","0.0292962 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"text_welcomeHeader",[1,"Welcome to ArmA 3 Project Life",["0.386562 * safezoneW + safezoneX","0.522 * safezoneH + safezoneY","0.2475 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"text_percentage",[1,"50%",["0.479375 * safezoneW + safezoneX","0.555 * safezoneH + safezoneY","0.0464063 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]]
]
*/

/* #Vojosy
$[
	1.063,
	["Loading",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_loadingImage",[1,"P:\A3PL_Common\GUI\A3PL_Loading_New.paa",["-0.000156274 * safezoneW + safezoneX","0.00500001 * safezoneH + safezoneY","0.995156 * safezoneW","1.001 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"Progress_loadingbar",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.295781 * safezoneW + safezoneX","0.758445 * safezoneH + safezoneY","0.403542 * safezoneW","0.0413333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"text_welcomeHeader",[1,"Welcome to ArmA 3 Project Life",["0.296823 * safezoneW + safezoneX","0.390926 * safezoneH + safezoneY","0.401146 * safezoneW","0.347 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"text_percentage",[1,"50%",["0.474219 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.0464063 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1"],[]]
]
*/


