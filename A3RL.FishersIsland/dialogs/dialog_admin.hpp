
class RscButton_Fixed : RscButton
{
	sizeEx = "0.015 * safezoneH";
};

class RscListbox_Fixed : RscListbox
{
	sizeEx = "0.015 * safezoneH";
};

class Dialog_Admin
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Vygivy)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Select"; //--- ToDo: Localize;
			x = 0.463907 * safezoneW + safezoneX;
			y = 0.643042 * safezoneH + safezoneY;
			w = 0.0721855 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class RscListbox_1500: RscListbox_Fixed
		{
			idc = 1500;
			x = 0.443283 * safezoneW + safezoneX;
			y = 0.356959 * safezoneH + safezoneY;
			w = 0.113434 * safezoneW;
			h = 0.27508 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Executable Functions"; //--- ToDo: Localize;
			x = 0.443283 * safezoneW + safezoneX;
			y = 0.323949 * safezoneH + safezoneY;
			w = 0.113434 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.432971 * safezoneW + safezoneX;
			y = 0.312946 * safezoneH + safezoneY;
			w = 0.134059 * safezoneW;
			h = 0.374109 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class Dialog_AdminGlobalMsg
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Gapuwy)
		////////////////////////////////////////////////////////

		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			x = 0.412346 * safezoneW + safezoneX;
			y = 0.46699 * safezoneH + safezoneY;
			w = 0.175308 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Send"; //--- ToDo: Localize;
			x = 0.489688 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0464049 * safezoneW;
			h = 0.0330096 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.402034 * safezoneW + safezoneX;
			y = 0.444984 * safezoneH + safezoneY;
			w = 0.195932 * safezoneW;
			h = 0.110032 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Send & Exit"; //--- ToDo: Localize;
			x = 0.541249 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0464049 * safezoneW;
			h = 0.0330096 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class RscCombo_2100: RscCombo
		{
			idc = 2100;
			x = 0.412346 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721855 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};


class Dialog_AdminVeh
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Kyvupy)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.402034 * safezoneW + safezoneX;
			y = 0.367962 * safezoneH + safezoneY;
			w = 0.195932 * safezoneW;
			h = 0.209061 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Spawn Vehicle"; //--- ToDo: Localize;
			x = 0.469063 * safezoneW + safezoneX;
			y = 0.588026 * safezoneH + safezoneY;
			w = 0.0618733 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.396878 * safezoneW + safezoneX;
			y = 0.356958 * safezoneH + safezoneY;
			w = 0.206244 * safezoneW;
			h = 0.286083 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

/* #Wutyje
$[
	1.063,
	["kek",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2201,"",[1,"",["0.40203 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.154687 * safezoneW","0.44 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"players",[1,"",["0.407187 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.144375 * safezoneW","0.132 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Assign/Create",["0.407187 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.0670312 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"Add to factory",["0.484531 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.0670312 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"amounttext",[1,"",["0.510312 * safezoneW + safezoneX","0.643 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Amount:",["0.443281 * safezoneW + safezoneX","0.643 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"factoryitems",[1,"",["0.407187 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.144375 * safezoneW","0.132 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"searchtext",[1,"Search:",["0.407187 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1401,"searchbar",[1,"",["0.443281 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"searchbutton",[1,"Search",["0.520625 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"itemcombo",[1,"",["0.407187 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.144375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"playersearchtext",[1,"Search:",["0.407187 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1402,"playersearch",[1,"",["0.443281 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"searchbuttonplayer",[1,"Search",["0.520625 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_AdminFactory
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Gonyba)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListbox_Fixed
		{
			idc = 1500;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Assign/Create"; //--- ToDo: Localize;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class button_add: RscButton
		{
			idc = 1601;
			text = "Add to factory"; //--- ToDo: Localize;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class static_amount: RscText
		{
			idc = 1000;
			text = "Amount:"; //--- ToDo: Localize;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_RIGHT;  // defined constant
		};		

		class edit_amount: RscEdit
		{
			idc = 1400;
			text = "1"; //--- ToDo: Localize;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_RIGHT;  // defined constant
		};		
		class IGUIBack_2202: IGUIBack
		{
			idc = 2202;
			x = 0.40203 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.44 * safezoneH;
		};
		class playerlistbox: RscListbox_Fixed
		{
			idc = 1501;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class RscCombo_2100: RscCombo
		{
			idc = 2100;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class searchtext: RscText
		{
			idc = 1001;
			text = "Search:"; //--- ToDo: Localize;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class searchbar: RscEdit
		{
			idc = 1401;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class searchbutton: RscButton
		{
			idc = 1602;
			text = "Search"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		class playersearchtext: RscText
		{
			idc = 1002;
			text = "Search:"; //--- ToDo: Localize;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class playersearch: RscEdit
		{
			idc = 1402;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class searchbuttonplayer: RscButton
		{
			idc = 1603;
			text = "Search"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.015 * safezoneH";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};

class Dialog_players
{
	idd = 69;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Xykapa)
		////////////////////////////////////////////////////////

		class aaaa: RscListbox_Fixed
		{
			idc = 1500;
			x = 0.38141 * safezoneW + safezoneX;
			y = 0.356958 * safezoneH + safezoneY;
			w = 0.103122 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Money:"; //--- ToDo: Localize;
			x = 0.484532 * safezoneW + safezoneX;
			y = 0.411974 * safezoneH + safezoneY;
			w = 0.123747 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Bank:"; //--- ToDo: Localize;
			x = 0.484532 * safezoneW + safezoneX;
			y = 0.444984 * safezoneH + safezoneY;
			w = 0.123747 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "TP to"; //--- ToDo: Localize;
			x = 0.561873 * safezoneW + safezoneX;
			y = 0.610032 * safezoneH + safezoneY;
			w = 0.051561 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "TP to me"; //--- ToDo: Localize;
			x = 0.494844 * safezoneW + safezoneX;
			y = 0.610032 * safezoneH + safezoneY;
			w = 0.051561 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class RscListbox_1501: RscListbox_Fixed
		{
			idc = 1501;
			x = 0.494844 * safezoneW + safezoneX;
			y = 0.477994 * safezoneH + safezoneY;
			w = 0.11859 * safezoneW;
			h = 0.121035 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Name"; //--- ToDo: Localize;
			x = 0.484532 * safezoneW + safezoneX;
			y = 0.356958 * safezoneH + safezoneY;
			w = 0.123747 * safezoneW;
			h = 0.0330096 * safezoneH;
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.376253 * safezoneW + safezoneX;
			y = 0.334952 * safezoneH + safezoneY;
			w = 0.247493 * safezoneW;
			h = 0.330096 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class Dialog_HUD_AdminCursor
{
	idd = 44875;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""Dialog_HUD_AdminCursor"", _this select 0]";
	class Controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Xyxyle)
		////////////////////////////////////////////////////////

		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.297086 * safezoneH;
		};
		class RscText_1000: RscText
		{
			idc = 1000;
			text = "Cursortarget: None"; //--- ToDo: Localize;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.22492 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.268933 * safezoneH + safezoneY;
			w = 0.144371 * safezoneW;
			h = 0.187054 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.835147 * safezoneW + safezoneX;
			y = 0.46699 * safezoneH + safezoneY;
			w = 0.154683 * safezoneW;
			h = 0.0440128 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.290939 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.312946 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 1004;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.334952 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1005: RscText
		{
			idc = 1005;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.356958 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 1006;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.378965 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1007: RscText
		{
			idc = 1007;
			text = "NUMPAD1: Attach Cursor"; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.400971 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
		};
		class RscText_1008: RscText
		{
			idc = 1008;
			text = "Press F1 to cancel."; //--- ToDo: Localize;
			x = 0.840303 * safezoneW + safezoneX;
			y = 0.522006 * safezoneH + safezoneY;
			w = 0.139215 * safezoneW;
			h = 0.0220064 * safezoneH;
			style = ST_CENTER;  // defined constant

		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};