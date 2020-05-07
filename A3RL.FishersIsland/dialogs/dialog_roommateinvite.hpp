/* #Kemyni
$[
	1.063,
	["roommateinvite",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"",[1,"\A3PL_Common\gui\A3RL_RoommateInvite.paa",["0 * safezoneW + safezoneX","0.05 * safezoneH + safezoneY","1 * safezoneW","0.85 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"",["0.412239 * safezoneW + safezoneX","0.514259 * safezoneH + safezoneY","0.0729688 * safezoneW","0.0292963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"",["0.509896 * safezoneW + safezoneX","0.513889 * safezoneH + safezoneY","0.0730208 * safezoneW","0.0318519 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"",[1,"",["0.601614 * safezoneW + safezoneX","0.376333 * safezoneH + safezoneY","0.0183333 * safezoneW","0.0327778 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_RoommateInvite
{
	idd = 66;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Muse Person, v1.063, #Kemyni)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\gui\A3RL_RoommateInvite.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0.05 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 0.85 * safezoneH;
		};
		class RscButton_1600: RscButtonEmpty
		{
			idc = 1600;
			x = 0.412239 * safezoneW + safezoneX;
			y = 0.514259 * safezoneH + safezoneY;
			w = 0.0729688 * safezoneW;
			h = 0.0292963 * safezoneH;
		};
		class RscButton_1601: RscButtonEmpty
		{
			idc = 1601;
			x = 0.509896 * safezoneW + safezoneX;
			y = 0.513889 * safezoneH + safezoneY;
			w = 0.0730208 * safezoneW;
			h = 0.0318519 * safezoneH;
		};
		class RscButton_1602: RscButtonEmpty
		{
			idc = 1602;
			x = 0.601614 * safezoneW + safezoneX;
			y = 0.376333 * safezoneH + safezoneY;
			w = 0.0183333 * safezoneW;
			h = 0.0327778 * safezoneH;
			action = "closeDialog 0;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};