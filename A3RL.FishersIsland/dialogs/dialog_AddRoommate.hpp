/* #Rekuvy
$[
	1.063,
	["Test",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.41125 * safezoneW + safezoneX","0.257444 * safezoneH + safezoneY","0.18099 * safezoneW","0.489556 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.427812 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.144375 * safezoneW","0.396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"",["0.427812 * safezoneW + safezoneX","0.703889 * safezoneH + safezoneY","0.144375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"",["0.572708 * safezoneW + safezoneX","0.260778 * safezoneH + safezoneY","0.0159375 * safezoneW","0.0255926 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Muse Person, v1.063, #Rekuvy)
////////////////////////////////////////////////////////
class Dialog_AddRoommate
{
	idd = 66;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3RL_AddRoommate.paa";
			x = 0.41125 * safezoneW + safezoneX;
			y = 0.257444 * safezoneH + safezoneY;
			w = 0.18099 * safezoneW;
			h = 0.489556 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.396 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.703889 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			x = 0.572708 * safezoneW + safezoneX;
			y = 0.260778 * safezoneH + safezoneY;
			w = 0.0159375 * safezoneW;
			h = 0.0255926 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

