/* #Qucixi
$[
	1.063,
	["Slots",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"",[1,"\A3PL_Common\gui\slots\background.paa",["-0.11875 * safezoneW + safezoneX","-0.028 * safezoneH + safezoneY","1.22203 * safezoneW","1.045 * safezoneH"],[1,1,1,1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1201,"",[1,"\A3PL_Common\gui\slots\seven.paa",["0.242187 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.148541 * safezoneW","0.250334 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1202,"",[1,"\A3PL_Common\gui\slots\seven.paa",["0.4175 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.149531 * safezoneW","0.253 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1203,"",[1,"\A3PL_Common\gui\slots\seven.paa",["0.592812 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.149531 * safezoneW","0.253 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1600,"",[1,"",["0.771734 * safezoneW + safezoneX","0.226695 * safezoneH + safezoneY","0.0126041 * safezoneW","0.0253704 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[-1100,"",[1,"Test12345",["0.366927 * safezoneW + safezoneX","0.667963 * safezoneH + safezoneY","0.251094 * safezoneW","0.0457408 * safezoneH"],[1,1,1,1],[0,0,0,1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_SlotMachine
{
	idd = 63;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{ 
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\gui\slots\background.paa";
			x = -0.11875 * safezoneW + safezoneX;
			y = -0.028 * safezoneH + safezoneY;
			w = 1.22203 * safezoneW;
			h = 1.045 * safezoneH;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;
			text = "\A3PL_Common\gui\slots\seven.paa";
			x = 0.242187 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.148541 * safezoneW;
			h = 0.250334 * safezoneH;
		};
		class RscPicture_1202: RscPicture
		{
			idc = 1202;
			text = "\A3PL_Common\gui\slots\seven.paa";
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class RscPicture_1203: RscPicture
		{
			idc = 1203;
			text = "\A3PL_Common\gui\slots\seven.paa";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class RscButton_1600: RscButtonEmpty
		{
			idc = 1600;
			x = 0.771734 * safezoneW + safezoneX;
			y = 0.226695 * safezoneH + safezoneY;
			w = 0.0126041 * safezoneW;
			h = 0.0253704 * safezoneH;
			action = "closeDialog 0;";
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = ""; //--- ToDo: Localize;
			x = 0.366927 * safezoneW + safezoneX;
			y = 0.667963 * safezoneH + safezoneY;
			w = 0.251094 * safezoneW;
			h = 0.0457408 * safezoneH;
		};
	};
};