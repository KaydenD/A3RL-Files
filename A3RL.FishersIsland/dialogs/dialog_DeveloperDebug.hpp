/* #Boqite
$[
	1.063,
	["Arma3ProjectLife_Debug",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"BG_Debug",[1,"",["0.298909 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.402187 * safezoneW","0.495 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"B_DebugLocalExecute",[1,"Local Execute",["0.505156 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.12375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[1400,"F_Debug",[1,"",["0.304062 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.391875 * safezoneW","0.473 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[2100,"DL_DebugExecutables",[1,"",["0.371094 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.12375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]]
]
*/


class Dialog_DeveloperDebug
{
	idd = 155;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Jon VanderZee, v1.063, #Boqite)
		////////////////////////////////////////////////////////

		class BG_Debug: IGUIBack
		{
			idc = 2200;
			x = 0.298909 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class B_DebugLocalExecute: RscButton
		{
			idc = 1600;
			text = "Local Execute"; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
		};
		class F_Debug: RscEdit
		{
			idc = 1400;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.473 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			style = "16";
			autocomplete = "scripting";
		};
		class DL_DebugExecutables: RscCombo
		{
			idc = 2100;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};