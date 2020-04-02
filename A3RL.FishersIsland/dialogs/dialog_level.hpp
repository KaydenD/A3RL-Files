class Dialog_Level
{
	idd = 25;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	controls[]=
	{
		background,
		experienceText,
		levelText,
		xpBar,
		nextLevelText,
		RscText_1000,
		RscText_1001,
		totalXP,
		forNextLevel,
		closeButton
	};

	class background: RscPicture
	{
		idc = IDC_DIALOG_LEVEL_BACKGROUND;
		text = "#(argb,8,8,3)color(0,0,0,0.8)";
		x = 0.275 * safezoneW + safezoneX;
		y = 0.24 * safezoneH + safezoneY;
		w = 0.450016 * safezoneW;
		h = 0.439902 * safezoneH;
	};
	class experienceText: RscStructuredText
	{
		idc = IDC_DIALOG_LEVEL_EXPERIENCETEXT;
		text = ""; //--- ToDo: Localize;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.399986 * safezoneW;
		h = 0.0400089 * safezoneH;
	};
	class levelText: RscStructuredText
	{
		idc = IDC_DIALOG_LEVEL_LEVELTEXT;
		text = ""; //--- ToDo: Localize;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.025 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class xpBar: RscProgress
	{
		idc = IDC_DIALOG_LEVEL_XPBAR;
		colorFrame[] = {0.72,0.72,0.72,1};
		colorBar[] = {0.99,0.6,0.29,1};
		x = 0.325 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.35 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class nextLevelText: RscStructuredText
	{
		idc = IDC_DIALOG_LEVEL_NEXTLEVELTEXT;
		text = ""; //--- ToDo: Localize;
		x = 0.675 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.025 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class RscText_1000: RscText
	{
		idc = IDC_DIALOG_LEVEL_RSCTEXT_1000;
		text = "Total:"; //--- ToDo: Localize;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class RscText_1001: RscText
	{
		idc = IDC_DIALOG_LEVEL_RSCTEXT_1001;
		text = "For Next Level:"; //--- ToDo: Localize;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class totalXP: RscText
	{
		idc = IDC_DIALOG_LEVEL_TOTALXP;
		text = "x"; //--- ToDo: Localize;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class forNextLevel: RscText
	{
		idc = IDC_DIALOG_LEVEL_FORNEXTLEVEL;
		text = "x"; //--- ToDo: Localize;
		x = 0.45 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class closeButton: RscButton
	{
		idc = IDC_DIALOG_LEVEL_CLOSEBUTTON;
		text = "Close"; //--- ToDo: Localize;
		x = 0.3 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.4 * safezoneW;
		h = 0.04 * safezoneH;
	};
};

/* #Pakohy
$[
	1.063,
	["Dialog_Level",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,0,0],
	[1200,"background",[1,"#(argb,8,8,3)color(0,0,0,0.8)",["0.275 * safezoneW + safezoneX","0.24 * safezoneH + safezoneY","0.450016 * safezoneW","0.439902 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"experienceText",[1,"Experience",["0.3 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.399986 * safezoneW","0.0400089 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"levelText",[1,"1",["0.3 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"xpBar",[1,"",["0.325 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.35 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"nextLevelText",[1,"2",["0.675 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.025 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Total:",["0.3 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"For Next Level:",["0.3 * safezoneW + safezoneX","0.52 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"totalXP",[1,"x",["0.45 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"forNextLevel",[1,"x",["0.45 * safezoneW + safezoneX","0.52 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"closeButton",[1,"Close",["0.3 * safezoneW + safezoneX","0.6 * safezoneH + safezoneY","0.4 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
