/* #Xexara
$[
	1.063,
	["UberMenu",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Drive",["0.510312 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1613,"",[1,"Request Uber",["0.432969 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"",[2,"#(argb,8,8,3)color(1,1,1,1)",["13.5 * GUI_GRID_W + GUI_GRID_X","2.5 * GUI_GRID_H + GUI_GRID_Y","13.5 * GUI_GRID_W","17.5 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Phone_UberMenu
{
	idd = 5020;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	
	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};

		class RscButton_1609: RscButton
		{
			idc = 1609;
			text = "Drive"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1613: RscButton
		{
			idc = 1613;
			text = "Request Uber"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
	};
};