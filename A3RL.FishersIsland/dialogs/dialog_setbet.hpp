/* #Pewute
$[
	1.063,
	["SetBet",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"",[1,"\A3PL_Common\gui\slots\A3RL_SetBet.paa",["0.00283438 * safezoneW + safezoneX","0.00500001 * safezoneH + safezoneY","0.994844 * safezoneW","0.994851 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1600,"",[1,"",["0.591781 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.0344791 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1601,"",[1,"",["0.447922 * safezoneW + safezoneX","0.50858 * safezoneH + safezoneY","0.0959375 * safezoneW","0.0392592 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1400,"",[1,"Testasdsadasdasd",["0.464062 * safezoneW + safezoneX","0.467296 * safezoneH + safezoneY","0.0801037 * safezoneW","0.0292963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_SetBet
{
	idd = 64;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{ 
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\gui\slots\A3RL_SetBet.paa";
			x = 0.00283438 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.994844 * safezoneW;
			h = 0.994851 * safezoneH;
		};
		class RscButton_1600: RscButtonEmpty
		{
			idc = 1600;
			x = 0.591781 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0344791 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class RscButton_1601: RscButtonEmpty
		{
			idc = 1601;
			x = 0.447922 * safezoneW + safezoneX;
			y = 0.50858 * safezoneH + safezoneY;
			w = 0.0959375 * safezoneW;
			h = 0.0392592 * safezoneH;
			action = "_this call A3RL_Slots_SetBet; closeDialog 0;";
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			text = ""; //--- ToDo: Localize;
			x = 0.464062 * safezoneW + safezoneX;
			y = 0.467296 * safezoneH + safezoneY;
			w = 0.0801037 * safezoneW;
			h = 0.0292963 * safezoneH;
		};
	};
};