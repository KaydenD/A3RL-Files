/* #Tacohi
$[
	1.063,
	["IDcard",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"\A3PL_Common\gui\A3PL_IdCard.paa",["-0.000156274 * safezoneW + safezoneX","-0.00599999 * safezoneH + safezoneY","0.25 * safezoneW","0.5 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Muse",["0.0522917 * safezoneW + safezoneX","0.269185 * safezoneH + safezoneY","0.0657291 * safezoneW","0.0142592 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Person",["0.054167 * safezoneW + safezoneX","0.237037 * safezoneH + safezoneY","0.0777083 * safezoneW","0.0161111 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"female",["0.0334375 * safezoneW + safezoneX","0.30037 * safezoneH + safezoneY","0.0365625 * safezoneW","0.0170371 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"asdh344132456asd",["0.034375 * safezoneW + safezoneX","0.194333 * safezoneH + safezoneY","0.0876042 * safezoneW","0.0281481 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"14/6/2020",["0.162813 * safezoneW + safezoneX","0.213185 * safezoneH + safezoneY","0.0527083 * safezoneW","0.0290741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"69/20/2054",["0.164896 * safezoneW + safezoneX","0.287037 * safezoneH + safezoneY","0.0527083 * safezoneW","0.0290741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_IDCard
{
	idd = 16420;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_HUD_IDCard',_this select 0];";	
	onUnload = "";
	class controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\gui\A3RL_IDCard.paa";
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.5 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "firstname"; //--- ToDo: Localize;
			x = 0.0522917 * safezoneW + safezoneX;
			y = 0.269185 * safezoneH + safezoneY;
			w = 0.0657291 * safezoneW;
			h = 0.0142592 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "lastname"; //--- ToDo: Localize;
			x = 0.054167 * safezoneW + safezoneX;
			y = 0.237037 * safezoneH + safezoneY;
			w = 0.0777083 * safezoneW;
			h = 0.0161111 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "gender"; //--- ToDo: Localize;
			x = 0.0334375 * safezoneW + safezoneX;
			y = 0.30037 * safezoneH + safezoneY;
			w = 0.0365625 * safezoneW;
			h = 0.0170371 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "ref"; //--- ToDo: Localize;
			x = 0.034375 * safezoneW + safezoneX;
			y = 0.194333 * safezoneH + safezoneY;
			w = 0.0876042 * safezoneW;
			h = 0.0281481 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "birth date"; //--- ToDo: Localize;
			x = 0.162813 * safezoneW + safezoneX;
			y = 0.213185 * safezoneH + safezoneY;
			w = 0.0527083 * safezoneW;
			h = 0.0290741 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "join date"; //--- ToDo: Localize;
			x = 0.164896 * safezoneW + safezoneX;
			y = 0.287037 * safezoneH + safezoneY;
			w = 0.0527083 * safezoneW;
			h = 0.0290741 * safezoneH;
		};
	};
};