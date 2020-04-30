/* #Rusono
$[
	1.063,
	["Uhaul",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"RscPicture_1200",[2,"\A3PL_Common\GUI\A3RL_Uhaul.paa",["-28.48 * GUI_GRID_W + GUI_GRID_X","-10.23 * GUI_GRID_H + GUI_GRID_Y","96.9697 * GUI_GRID_W","45.4545 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1200;"]],
	[1600,"button_buy: RscButtonEmpty",[2,"",["-22.51 * GUI_GRID_W + GUI_GRID_X","20.75 * GUI_GRID_H + GUI_GRID_Y","14.2727 * GUI_GRID_W","2.25253 * GUI_GRID_H"],[0,0,0,0],[0,0,0,0],[-1,-1,-1,-1],"","-1"],["idc = 1602;"]],
	[1000,"list: RscListBox",[2,"",["-24.46 * GUI_GRID_W + GUI_GRID_X","0.95 * GUI_GRID_H + GUI_GRID_Y","18 * GUI_GRID_W","15.9091 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1500;"]],
	[1100,"buyP",[2,"",["-16.38 * GUI_GRID_W + GUI_GRID_X","18.34 * GUI_GRID_H + GUI_GRID_Y","7 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1100;"]],
	[1900,"slider_dir",[2,"",["10.5 * GUI_GRID_W + GUI_GRID_X","28.41 * GUI_GRID_H + GUI_GRID_Y","19 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 1900;"]]
]
*/


class Dialog_Uhaul
{
	idd = 22;
	name= "Dialog_Uhaul";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Muse Person, v1.063, #Cypyci)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;

			text = "\A3PL_Common\GUI\A3RL_Uhaul.paa";
			x = 4.99852e-005 * safezoneW + safezoneX;
			y = -5.99921e-005 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 0.999999 * safezoneH;
		};
		class button_buy: RscButtonEmpty
		{
			idc = 1602;

			x = 0.0616156 * safezoneW + safezoneX;
			y = 0.6815 * safezoneH + safezoneY;
			w = 0.147187 * safezoneW;
			h = 0.0495557 * safezoneH;
			colorText[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
		};
		class list: RscListBox
		{
			idc = 1500;

			x = 0.0415063 * safezoneW + safezoneX;
			y = 0.2459 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.35 * safezoneH;
		};
		class buyP: RscStructuredText
		{
			idc = 1100;

			x = 0.124831 * safezoneW + safezoneX;
			y = 0.62848 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class slider_dir: RscSlider
		{
			idc = 1900;

			x = 0.402031 * safezoneW + safezoneX;
			y = 0.85002 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};