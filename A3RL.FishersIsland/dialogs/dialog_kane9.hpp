/* #Tediza
$[
	1.063,
	["Dog",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.438125 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.128906 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.443281 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.118594 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Buy",["0.479375 * safezoneW + safezoneX","0.566 * safezoneH + safezoneY","0.0464063 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Dog price: $1000",["0.469062 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_Kane9
{
	idd = 93;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.154 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Buy"; //--- ToDo: Localize;
			x = 0.479375 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Dog price: $1000"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
	};
};