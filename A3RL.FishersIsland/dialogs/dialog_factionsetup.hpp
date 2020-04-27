/* #Lahaqo
$[
	1.063,
	["FactionSetup",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"P:\A3PL_Common\GUI\FactionSetup.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"lb_rankmembers",[1,"",["0.273125 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.188646 * safezoneW","0.345741 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"lb_allmembers",[1,"",["0.551562 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.170156 * safezoneW","0.341 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"lb_ranks",[1,"",["0.273125 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.187084 * safezoneW","0.123519 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_addrank",[1,"",["0.546406 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.17724 * safezoneW","0.020963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"edit_setpay",[1,"",["0.551562 * safezoneW + safezoneX","0.764 * safezoneH + safezoneY","0.175313 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_setrank",[1,"",["0.474219 * safezoneW + safezoneX","0.407482 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_addrank",[1,"",["0.474219 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"button_removerank",[1,"",["0.474219 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.060625 * safezoneW","0.0394815 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"button_setpay",[1,"",["0.474219 * safezoneW + safezoneX","0.759482 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"struc_factionbalance",[1,"",["0.365937 * safezoneW + safezoneX","0.808 * safezoneH + safezoneY","0.0657292 * safezoneW","0.0262963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"struc_totalmembers",[1,"",["0.365937 * safezoneW + safezoneX","0.841 * safezoneH + safezoneY","0.0657292 * safezoneW","0.0262963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"button_close1",[1,"",["0.701094 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.04125 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_FactionSetup
{
	idd = 111;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Austin Blackwater, v1.063, #Faduzy)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\FactionSetup.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class lb_rankmembers: RscListbox
		{
			idc = 1500;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.188646 * safezoneW;
			h = 0.345741 * safezoneH;
		};
		class lb_allmembers: RscListbox
		{
			idc = 1501;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.341 * safezoneH;
		};
		class lb_ranks: RscListbox
		{
			idc = 1502;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.187084 * safezoneW;
			h = 0.123519 * safezoneH;
		};
		class edit_addrank: RscEdit
		{
			idc = 1400;
			x = 0.546406 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.17724 * safezoneW;
			h = 0.020963 * safezoneH;
		};
		class edit_setpay: RscEdit
		{
			idc = 1401;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_setrank: RscButtonEmpty
		{
			idc = 1600;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.407482 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_addrank: RscButtonEmpty
		{
			idc = 1601;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class button_removerank: RscButtonEmpty
		{
			idc = 1602;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.060625 * safezoneW;
			h = 0.0394815 * safezoneH;
		};
		class button_setpay: RscButtonEmpty
		{
			idc = 1603;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.759482 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class struc_factionbalance: RscStructuredText
		{
			idc = 1100;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.0657292 * safezoneW;
			h = 0.0262963 * safezoneH;
		};
		class struc_totalmembers: RscStructuredText
		{
			idc = 1101;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0657292 * safezoneW;
			h = 0.0262963 * safezoneH;
		};
		class button_close1: RscButtonEmpty
		{
			idc = 1604;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};