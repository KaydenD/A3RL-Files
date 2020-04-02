/* #Somogo
$[
	1.063,
	["BankScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Transfer To Number",["0.432968 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.139219 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1613,"",[1,"Transfer To Contact",["0.432969 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.139219 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Cash:",["0.432969 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Bank:",["0.432969 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.04125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"CASH BALANCE",["0.469062 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"BANK BALANCE",["0.469062 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class Dialog_Phone_Bank
{
	idd = 5023;
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
			text = "Transfer To Number"; //--- ToDo: Localize;
			x = 0.432968 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_Phone_BankTransferNumber;";
			sizeEx = "0.015 * safezoneH";
		};

		class RscButton_1613: RscButton
		{
			idc = 1613;
			text = "Transfer To Contact"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_Phone_BankTransferContact;";
			sizeEx = "0.015 * safezoneH";
		};

		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Cash:"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Bank:"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class RscText_1003: RscText
		{
			idc = 1003;
			text = "CASH BALANCE"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class RscText_1004: RscText
		{
			idc = 1004;
			text = "BANK BALANCE"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};