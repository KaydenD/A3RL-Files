/* #Lonudu
$[
	1.063,
	["YoutubeOverlay",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["-0.000156274 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.134062 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"A3PL Cinema",["0.00499997 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.12375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"",[1,"",["0.00755204 * safezoneW + safezoneX","0.309629 * safezoneH + safezoneY","0.118594 * safezoneW","0.418 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.25],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Dispatch
{
	idd = 80;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "A3PL Cinema"; //--- ToDo: Localize;
			style = 0x02;
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			x = 0.00755204 * safezoneW + safezoneX;
			y = 0.309629 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.418 * safezoneH;
			colorBackground[] = {0,0,0,0.25};
		};
	};
};