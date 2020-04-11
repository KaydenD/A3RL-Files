/* #Cinepa
$[
	1.063,
	["AddRoommates",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\GUI\A3RL_AddRoommate.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.423177 * safezoneW + safezoneX","0.297481 * safezoneH + safezoneY","0.153751 * safezoneW","0.40063 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"",["0.423125 * safezoneW + safezoneX","0.710852 * safezoneH + safezoneY","0.155313 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"",["0.572187 * safezoneW + safezoneX","0.24237 * safezoneH + safezoneY","0.0185417 * safezoneW","0.0302222 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
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
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.423177 * safezoneW + safezoneX;
			y = 0.297481 * safezoneH + safezoneY;
			w = 0.153751 * safezoneW;
			h = 0.40063 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			x = 0.423125 * safezoneW + safezoneX;
			y = 0.710852 * safezoneH + safezoneY;
			w = 0.155313 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.24237 * safezoneH + safezoneY;
			w = 0.0185417 * safezoneW;
			h = 0.0302222 * safezoneH;
			action = "closeDialog 0;";
		};
	};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

