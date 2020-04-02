/* #Kywero
$[
	1.063,
	["ActiveCallScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"255-2392",["0.438125 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.12375 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Bluetooth",["0.515469 * safezoneW + safezoneX","0.632 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1613,"",[1,"End Call",["0.432969 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.139219 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Status...",["0.438125 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.12375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Phone_Active
{
	idd = 5002;
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
		class RscText_1001: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Status..."; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscButton_1613: RscButton
		{
			idc = 1613;
			text = "End Call"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[] call A3PL_Phone_EndCall;";
			sizeEx = "0.015 * safezoneH";
		};
	};
	
};