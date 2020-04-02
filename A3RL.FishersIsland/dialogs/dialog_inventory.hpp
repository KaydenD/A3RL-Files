class Dialog_Inventory 
{
	idd = 1001;
	name = "Dialog_Inventory";
	movingEnable = false;
	enableSimulation = true;
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Wakiku)
		////////////////////////////////////////////////////////

		class static_background: RscPicture
		{
			idc = IDC_DIALOG_INVENTORY_BACKGROUND;
			text = "\A3PL_Common\GUI\A3PL_Inventory.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class itemList: RscListbox
		{
			idc = IDC_DIALOG_INVENTORY_ITEMLIST;
			x = 0.277604 * safezoneW + safezoneX;
			y = 0.238148 * safezoneH + safezoneY;
			w = 0.248958 * safezoneW;
			h = 0.532963 * safezoneH;
		};
		class playerList: RscListbox
		{
			idc = IDC_DIALOG_INVENTORY_PLAYERLIST;
			x = 0.555729 * safezoneW + safezoneX;
			y = 0.495555 * safezoneH + safezoneY;
			w = 0.160944 * safezoneW;
			h = 0.200881 * safezoneH;
		};
		class amount: RscEdit
		{
			idc = IDC_DIALOG_INVENTORY_AMOUNT;
			x = 0.601041 * safezoneW + safezoneX;
			y = 0.24463 * safezoneH + safezoneY;
			w = 0.11823 * safezoneW;
			h = 0.0233334 * safezoneH;
		};
		class UseButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_USEBUTTON;
			x = 0.553125 * safezoneW + safezoneX;
			y = 0.317222 * safezoneH + safezoneY;
			w = 0.166146 * safezoneW;
			h = 0.0381481 * safezoneH;
		};
		class dropButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_DROPBUTTON;
			x = 0.553646 * safezoneW + safezoneX;
			y = 0.399074 * safezoneH + safezoneY;
			w = 0.165625 * safezoneW;
			h = 0.0372222 * safezoneH;
		};
		class giveButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_GIVEBUTTON;
			x = 0.552604 * safezoneW + safezoneX;
			y = 0.738148 * safezoneH + safezoneY;
			w = 0.166667 * safezoneW;
			h = 0.0381481 * safezoneH;
		};
		class weightText: RscText
		{
			idc = IDC_DIALOG_INVENTORY_WEIGHTTEXT;
			text = "Weight: %1/%2"; //--- ToDo: Localize;
			x = 0.275 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class closeButton: RscButtonEmpty
		{
			idc = IDC_DIALOG_INVENTORY_CLOSEBUTTON;
			x = 0.575 * safezoneW + safezoneX;
			y = 0.14 * safezoneH + safezoneY;
			w = 0.175 * safezoneW;
			h = 0.04 * safezoneH;
		};
		class listbox_keys: RscListbox
		{
			idc = 1900;
			x = 0.797917 * safezoneW + safezoneX;
			y = 0.243333 * safezoneH + safezoneY;
			w = 0.161979 * safezoneW;
			h = 0.202037 * safezoneH;
		};
		class button_usekey: RscButtonEmpty
		{
			idc = 1604;
			x = 0.796354 * safezoneW + safezoneX;
			y = 0.45537 * safezoneH + safezoneY;
			w = 0.165625 * safezoneW;
			h = 0.039074 * safezoneH;
			action = "[] call A3PL_Housing_Grabkey";
		};		
		class list_licenses: RscListbox
		{
			idc = 1503;
			x = 0.798958 * safezoneW + safezoneX;
			y = 0.538333 * safezoneH + safezoneY;
			w = 0.160521 * safezoneW;
			h = 0.0846297 * safezoneH;
		};		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};


/* #Wiryna
$[
	1.063,
	["Inventory",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,0,0],
	[1200,"background",[1,"#(argb,8,8,3)color(0,0,0,0.8)",["0.25 * safezoneW + safezoneX","0.16 * safezoneH + safezoneY","0.5 * safezoneW","0.68 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"itemList",[1,"",["0.275 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.25 * safezoneW","0.52 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"playerList",[1,"",["0.55 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.175006 * safezoneW","0.199955 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"amount",[1,"",["0.55 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"UseButton",[1,"Use",["0.55 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"dropButton",[1,"Drop",["0.55 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"giveButton",[1,"Give",["0.55 * safezoneW + safezoneX","0.68 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.25 * safezoneW + safezoneX","0.1 * safezoneH + safezoneY","0.5 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"title",[1,"Inventory",["0.2625 * safezoneW + safezoneX","0.1 * safezoneH + safezoneY","0.4875 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"weightText",[1,"Weight: %1/%2",["0.275 * safezoneW + safezoneX","0.76 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"closeButton",[1,"Close",["0.55 * safezoneW + safezoneX","0.76 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
//With keys
/* #Labate
$[
	1.063,
	["Inventory",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,0,0],
	[1200,"background",[1,"#(argb,8,8,3)color(0,0,0,0.8)",["0.25 * safezoneW + safezoneX","0.16 * safezoneH + safezoneY","0.5 * safezoneW","0.68 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"itemList",[1,"",["0.275 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.25 * safezoneW","0.52 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"playerList",[1,"",["0.55 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.175006 * safezoneW","0.199955 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"amount",[1,"",["0.55 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"UseButton",[1,"Use",["0.55 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"dropButton",[1,"Drop",["0.55 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"giveButton",[1,"Give",["0.55 * safezoneW + safezoneX","0.68 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.25 * safezoneW + safezoneX","0.1 * safezoneH + safezoneY","0.5 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"title",[1,"Inventory",["0.2625 * safezoneW + safezoneX","0.1 * safezoneH + safezoneY","0.4875 * safezoneW","0.06 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"weightText",[1,"Weight: %1/%2",["0.275 * safezoneW + safezoneX","0.76 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"closeButton",[1,"Close",["0.55 * safezoneW + safezoneX","0.76 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"listbox_keys",[1,"",["0.775 * safezoneW + safezoneX","0.16 * safezoneH + safezoneY","0.15 * safezoneW","0.24 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"button_usekey",[1,"Use",["0.82025 * safezoneW + safezoneX","0.4052 * safezoneH + safezoneY","0.0625 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

//new dialog

/* #Dulyse
$[
	1.063,
	["Inventory",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,0,0],
	[1202,"static_background",[1,"\A3PL_Common\GUI\A3PL_Inventory.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"itemList",[1,"",["0.277604 * safezoneW + safezoneX","0.238148 * safezoneH + safezoneY","0.248958 * safezoneW","0.532963 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1501,"playerList",[1,"",["0.555729 * safezoneW + safezoneX","0.495555 * safezoneH + safezoneY","0.160944 * safezoneW","0.200881 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"amount",[1,"",["0.601041 * safezoneW + safezoneX","0.24463 * safezoneH + safezoneY","0.11823 * safezoneW","0.0233334 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"UseButton",[1,"",["0.553125 * safezoneW + safezoneX","0.317222 * safezoneH + safezoneY","0.166146 * safezoneW","0.0381481 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"dropButton",[1,"",["0.553646 * safezoneW + safezoneX","0.399074 * safezoneH + safezoneY","0.165625 * safezoneW","0.0372222 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"giveButton",[1,"",["0.552604 * safezoneW + safezoneX","0.738148 * safezoneH + safezoneY","0.166667 * safezoneW","0.0381481 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"weightText",[1,"Weight: %1/%2",["0.275 * safezoneW + safezoneX","0.78 * safezoneH + safezoneY","0.15 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"closeButton",[1,"",["0.575 * safezoneW + safezoneX","0.14 * safezoneH + safezoneY","0.175 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1502,"listbox_keys",[1,"",["0.797917 * safezoneW + safezoneX","0.243333 * safezoneH + safezoneY","0.161979 * safezoneW","0.202037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"button_usekey",[1,"",["0.796354 * safezoneW + safezoneX","0.45537 * safezoneH + safezoneY","0.165625 * safezoneW","0.039074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1503,"list_licenses",[1,"",["0.798958 * safezoneW + safezoneX","0.538333 * safezoneH + safezoneY","0.160521 * safezoneW","0.0846297 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
