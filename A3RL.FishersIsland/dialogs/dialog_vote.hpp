/* #Fyrijy
$[
	1.063,
	["Vote",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"P:\A3PL_Common\GUI\A3PL_MayorVote.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_currentmayor",[1,"None",["0.478021 * safezoneW + safezoneX","0.360592 * safezoneH + safezoneY","0.134844 * safezoneW","0.0303333 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"lb_candidates",[1,"",["0.377813 * safezoneW + safezoneX","0.458667 * safezoneH + safezoneY","0.234895 * safezoneW","0.145111 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_vote",[1,"",["0.376771 * safezoneW + safezoneX","0.629 * safezoneH + safezoneY","0.100104 * safezoneW","0.0404074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_close",[1,"",["0.513073 * safezoneW + safezoneX","0.626444 * safezoneH + safezoneY","0.100104 * safezoneW","0.0404074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Vote
{
	idd = 110;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Fyrijy)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_MayorVote.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class edit_currentmayor: RscEdit
		{
			idc = 1400;
			text = "None"; //--- ToDo: Localize;
			x = 0.478021 * safezoneW + safezoneX;
			y = 0.360592 * safezoneH + safezoneY;
			w = 0.134844 * safezoneW;
			h = 0.0303333 * safezoneH;
		};
		class lb_candidates: RscListbox
		{
			idc = 1500;
			x = 0.377813 * safezoneW + safezoneX;
			y = 0.458667 * safezoneH + safezoneY;
			w = 0.234895 * safezoneW;
			h = 0.145111 * safezoneH;
		};
		class button_vote: RscButtonEmpty
		{
			idc = 1600;
			x = 0.376771 * safezoneW + safezoneX;
			y = 0.629 * safezoneH + safezoneY;
			w = 0.100104 * safezoneW;
			h = 0.0404074 * safezoneH;
		};
		class button_close: RscButtonEmpty
		{
			idc = 1601;
			x = 0.513073 * safezoneW + safezoneX;
			y = 0.626444 * safezoneH + safezoneY;
			w = 0.100104 * safezoneW;
			h = 0.0404074 * safezoneH;
			action = "closeDialog 0;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};