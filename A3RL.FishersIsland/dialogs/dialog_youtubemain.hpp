/* #Dojutu
$[
	1.063,
	["CinemaMain",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\GUI\Cinema_MainScreen.paa",["0.159687 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.685781 * safezoneW","0.88 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_appCinema",[1,"",["0.2525 * safezoneW + safezoneX","0.196407 * safezoneH + safezoneY","0.0191146 * safezoneW","0.0505926 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_YoutubeMain
{
	idd = 3006;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Dojutu)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\Cinema_MainScreen.paa";
			x = 0.159687 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.685781 * safezoneW;
			h = 0.88 * safezoneH;
		};
		class button_appCinema: RscButtonEmpty
		{
			idc = 1600;
			x = 0.2525 * safezoneW + safezoneX;
			y = 0.196407 * safezoneH + safezoneY;
			w = 0.0191146 * safezoneW;
			h = 0.0505926 * safezoneH;
			action = "closeDialog 0; createDialog 'Dialog_YoutubeAdmin'";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};