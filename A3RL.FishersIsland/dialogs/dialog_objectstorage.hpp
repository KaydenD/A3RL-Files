/* #Waduka
$[
	1.063,
	["ObjectStorage",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\GUI\A3RL_RetrieveObject.paa",["0 * safezoneW + safezoneX","-0.45 * safezoneH + safezoneY","1 * safezoneW","1.9 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"",["0.448437 * safezoneW + safezoneX","0.68237 * safezoneH + safezoneY","0.103125 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.425729 * safezoneW + safezoneX","0.344963 * safezoneH + safezoneY","0.148594 * safezoneW","0.312741 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0],[-1,-1,-1,-1],"","0.8"],[]]
]
*/



class Dialog_ObjectStorage
{
	idd = 58;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "A3PL_Storage_ReturnArray = []";
	onUnload = "A3PL_Storage_ReturnArray = Nil";
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Muse Person, v1.063, #Jamese)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3RL_RetrieveObject.paa";
			x = 0 * safezoneW + safezoneX;
			y = -0.45 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1.9 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			x = 0.448437 * safezoneW + safezoneX;
			y = 0.68237 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Storage_ObjectRetrieveButton";
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};

		};
		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.425729 * safezoneW + safezoneX;
			y = 0.344963 * safezoneH + safezoneY;
			w = 0.148594 * safezoneW;
			h = 0.312741 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = 0.8 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};


