/* #Xibute
$[
	1.063,
	["BankContactTransferScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Send Money",["0.432968 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.139219 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"",[1,"",["0.432969 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.139219 * safezoneW","0.286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[1,"",["0.432969 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.139219 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Amount:",["0.432969 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Contact:",["0.432969 * safezoneW + safezoneX","0.368 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class Dialog_Phone_BankTransferContact
{
	idd = 5024;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";

	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};

		class RscButton_1609: RscButton
		{
			idc = 1609;
			text = "Send Money"; //--- ToDo: Localize;
			x = 0.432968 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_Phone_BankSendMoneyContact;";
			sizeEx = "0.015 * safezoneH";
		};

		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.286 * safezoneH;
		};

		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Amount:"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Contact:"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};