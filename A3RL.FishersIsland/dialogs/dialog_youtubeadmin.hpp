/* #Vycyso
$[
	1.063,
	["CinemaAdmin",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\GUI\Cinema_Administrator.paa",["0.159687 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.685781 * safezoneW","0.88 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_appCinema",[1,"",["0.2525 * safezoneW + safezoneX","0.196407 * safezoneH + safezoneY","0.0191146 * safezoneW","0.0505926 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_start",[1,"",["0.396875 * safezoneW + safezoneX","0.649481 * safezoneH + safezoneY","0.0608854 * safezoneW","0.0302222 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_stop",[1,"",["0.547916 * safezoneW + safezoneX","0.650296 * safezoneH + safezoneY","0.0608855 * safezoneW","0.0283704 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_youtubeURL",[1,"",["0.390156 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.225104 * safezoneW","0.0272223 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"text_status",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.391198 * safezoneW + safezoneX","0.588111 * safezoneH + safezoneY","0.222761 * safezoneW","0.0192223 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_YoutubeAdmin
{
	idd = 3005;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Vycyso)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\Cinema_Administrator.paa";
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
		};
		class button_start: RscButtonEmpty
		{
			idc = 1601;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.649481 * safezoneH + safezoneY;
			w = 0.0608854 * safezoneW;
			h = 0.0302222 * safezoneH;
			action = "[] call A3PL_Youtube_StartButton;";
		};
		class button_stop: RscButtonEmpty
		{
			idc = 1602;
			x = 0.547916 * safezoneW + safezoneX;
			y = 0.650296 * safezoneH + safezoneY;
			w = 0.0608855 * safezoneW;
			h = 0.0283704 * safezoneH;
		};
		class edit_youtubeURL: RscEdit
		{
			idc = 1400;
			x = 0.390156 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.225104 * safezoneW;
			h = 0.0272223 * safezoneH;
		};
		class text_status: RscText
		{
			idc = 1201;
			text = "Status";
			x = 0.391198 * safezoneW + safezoneX;
			y = 0.588111 * safezoneH + safezoneY;
			w = 0.222761 * safezoneW;
			h = 0.0192223 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};