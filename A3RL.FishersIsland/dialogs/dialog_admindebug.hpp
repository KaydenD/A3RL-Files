/* #Zeteve
$[
	1.063,
	["A3PL_Admin_Debug",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_bg",[1,"",["0.350469 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.299062 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_script",[1,"",["0.355625 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.28875 * safezoneW","0.451 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_execLocal",[1,"Local execute",["0.365937 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_execGlobal",[1,"Global execute",["0.463906 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_execServer",[1,"Server execute",["0.561875 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.0721875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
class Dialog_AdminDebug 
{
	idd = 82;
	name = "Dialog_AdminDebug";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Zeteve)
		////////////////////////////////////////////////////////

		class static_bg: IGUIBack
		{
			idc = 2200;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.299062 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class edit_script: RscEdit
		{
			style = ST_MULTI;
			idc = 1400;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.451 * safezoneH;
		};
		class button_execLocal: RscButton
		{
			idc = 1600;
			text = "Local execute"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_execGlobal: RscButton
		{
			idc = 1601;
			text = "Global execute"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_execServer: RscButton
		{
			idc = 1602;
			text = "Server execute"; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
				
	}
};