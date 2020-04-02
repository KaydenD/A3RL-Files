class Dialog_ExecutiveMenu
{
	idd = 98;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Austin Blackwater, v1.063, #Fatolo)
		////////////////////////////////////////////////////////

		class Background_PlayerList: IGUIBack
		{
			idc = 2200;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.517 * safezoneH;
		};
		class Background_PlayerInformation: IGUIBack
		{
			idc = 2201;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.28875 * safezoneW;
			h = 0.341 * safezoneH;
		};
		class Background_AdminTools: IGUIBack
		{
			idc = 2202;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class TextField_PlayerListSearch: RscEdit
		{
			idc = 1400;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0928035 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TextField_FactorySearch: RscEdit
		{
			idc = 1401;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0928035 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerList: RscListbox
		{
			idc = 1500;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.462 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_Factory: RscListbox
		{
			idc = 1501;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.253 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TextField_FactoryCount: RscEdit
		{
			idc = 1403;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0515575 * safezoneW;
			h = 0.022002 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerInventory: RscListbox
		{
			idc = 1502;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.154 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class List_PlayerInformation: RscListbox
		{
			idc = 1503;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.121 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Background_Messaging: IGUIBack
		{
			idc = 2203;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class List_AdminTools: RscListbox
		{
			idc = 1504;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.143 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_AddToPlayer: RscButton
		{
			idc = 1600;
			text = "Add to Player"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_AddToFactory: RscButton
		{
			idc = 1601;
			text = "Add to Factory"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_CreateOnPlayer: RscButton
		{
			idc = 1602;
			text = "Create on Player"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_Restart: RscButton
		{
			idc = 1603;
			text = "Restart"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_Ban: RscButton
		{
			idc = 1604;
			text = "Ban"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_Kick: RscButton
		{
			idc = 1605;
			text = "Kick"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_PlayerHeal: RscButton
		{
			idc = 1606;
			text = "Heal"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_TeleportTo: RscButton
		{
			idc = 1607;
			text = "Teleport to"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_TeleportToMe: RscButton
		{
			idc = 1608;
			text = "Teleport to Me"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_GlobalMessage: RscButton
		{
			idc = 1609;
			text = "Global Message"; //--- ToDo: Localize;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_AdminMessage: RscButton
		{
			idc = 1610;
			text = "Admin Message"; //--- ToDo: Localize;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_DirectMessage: RscButton
		{
			idc = 1611;
			text = "Direct Message"; //--- ToDo: Localize;
			x = 0.649531 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class TextField_Messages: RscEdit
		{
			idc = 1402;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_FactorySearch: RscButton
		{
			idc = 1612;
			text = "?"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Button_PlayerSearch: RscButton
		{
			idc = 1613;
			text = "?"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0103125 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class IGUIBack_2204: IGUIBack
		{
			idc = 2204;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class IGUIBack_2205: IGUIBack
		{
			idc = 2205;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class DropDown_Factory: RscCombo
		{
			idc = 2100;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class DropDown_PlayerInventories: RscCombo
		{
			idc = 2101;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Text_AdminName: RscText
		{
			idc = 1000;
			x = 0 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 22.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class Text_PanelName: RscText
		{
			idc = 1001;
			x = 34 * GUI_GRID_W + GUI_GRID_X;
			y = 24 * GUI_GRID_H + GUI_GRID_Y;
			w = 6 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			sizeEx = .8 * GUI_GRID_H;
		};
		class DropDown_ChatTag: RscCombo
		{
			idc = 2102;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		class DropDown_Whitelisting: RscCombo
		{
			idc = 2103;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = .8 * GUI_GRID_H;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

/* #Fatolo
$[
	1.063,
	["A3PL_AdminPanel",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"Background_PlayerList",[1,"",["0.29375 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.118594 * safezoneW","0.517 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2201,"Background_PlayerInformation",[1,"",["0.4175 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.28875 * safezoneW","0.341 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2202,"Background_AdminTools",[1,"",["0.4175 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.108281 * safezoneW","0.165 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"TextField_PlayerListSearch",[1,"",["0.298906 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.0928035 * safezoneW","0.022002 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1401,"TextField_FactorySearch",[1,"",["0.422656 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0928035 * safezoneW","0.022002 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1500,"List_PlayerList",[1,"",["0.298906 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.108281 * safezoneW","0.462 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1501,"List_Factory",[1,"",["0.422656 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.108281 * safezoneW","0.253 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1403,"TextField_FactoryCount",[1,"",["0.536094 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0515575 * safezoneW","0.022002 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1502,"List_PlayerInventory",[1,"",["0.592812 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.108281 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1503,"List_PlayerInformation",[1,"",["0.592812 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.108281 * safezoneW","0.121 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[2203,"Background_Messaging",[1,"",["0.530937 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.175313 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1504,"List_AdminTools",[1,"",["0.422656 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0979687 * safezoneW","0.143 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1600,"Button_AddToPlayer",[1,"Add to Player",["0.536094 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1601,"Button_AddToFactory",[1,"Add to Factory",["0.536094 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1602,"Button_CreateOnPlayer",[1,"Create on Player",["0.536094 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1603,"Button_Restart",[1,"Restart",["0.536094 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1604,"Button_Ban",[1,"Ban",["0.536094 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1605,"Button_Kick",[1,"Kick",["0.536094 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1606,"Button_PlayerHeal",[1,"Heal",["0.536094 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1607,"Button_TeleportTo",[1,"Teleport to",["0.536094 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1608,"Button_TeleportToMe",[1,"Teleport to Me",["0.536094 * safezoneW + safezoneX","0.5 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1609,"Button_GlobalMessage",[1,"Global Message",["0.536094 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1610,"Button_AdminMessage",[1,"Admin Message",["0.592812 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1611,"Button_DirectMessage",[1,"Direct Message",["0.649531 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1402,"TextField_Messages",[1,"",["0.536094 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.165 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1612,"Button_FactorySearch",[1,"?",["0.520625 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1613,"Button_PlayerSearch",[1,"?",["0.396875 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.0103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[2204,"",[1,"",["0.530937 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.175313 * safezoneW","0.077 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2205,"",[1,"",["0.29375 * safezoneW + safezoneX","0.753 * safezoneH + safezoneY","0.4125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"DropDown_Factory",[1,"",["0.422656 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[2101,"DropDown_PlayerInventories",[1,"",["0.592812 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1000,"Text_AdminName",[2,"",["0 * GUI_GRID_W + GUI_GRID_X","24 * GUI_GRID_H + GUI_GRID_Y","22.5 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[1001,"Text_PanelName",[2,"",["34 * GUI_GRID_W + GUI_GRID_X","24 * GUI_GRID_H + GUI_GRID_Y","6 * GUI_GRID_W","1 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[2102,"DropDown_ChatTag",[1,"",["0.536094 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.165 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]],
	[2103,"DropDown_Whitelisting",[1,"",["0.536094 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.165 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"",".8"],[]]
]
*/

