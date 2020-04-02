/* #Fuzece
$[
	1.063,
	["BankTransferNumberScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"255-2392",["0.438125 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.12375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"",[1,"3",["0.530937 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"2",["0.484531 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"1",["0.438125 * safezoneW + safezoneX","0.357 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"",[1,"4",["0.438125 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1604,"",[1,"5",["0.484531 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1605,"",[1,"6",["0.530937 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1606,"",[1,"7",["0.438125 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1607,"",[1,"8",["0.484531 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1608,"",[1,"9",["0.530937 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1610,"",[1,"#",["0.438125 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1611,"",[1,"0",["0.484531 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1612,"",[1,"<",["0.530937 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0360937 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"",[2,"",["14 * GUI_GRID_W + GUI_GRID_X","3 * GUI_GRID_H + GUI_GRID_Y","13 * GUI_GRID_W","1.5 * GUI_GRID_H"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Amount:",["0.438125 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.12375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Send Money",["0.438125 * safezoneW + safezoneX","0.698 * safezoneH + safezoneY","0.128906 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class Dialog_Phone_BankTransferNumber
{
	idd = 5001;
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
		class RscText_1001: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
			sizeEx = "0.015 * safezoneH";
			style = 0x02;
		};
		class RscButton_1611: RscButton
		{
			idc = 1611;
			text = "0";
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[0] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "1"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[1] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "2"; //--- ToDo: Localize;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[2] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "3"; //--- ToDo: Localize;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.357 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[3] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "4"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[4] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "5"; //--- ToDo: Localize;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[5] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "6"; //--- ToDo: Localize;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[6] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1606: RscButton
		{
			idc = 1606;
			text = "7"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[7] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1607: RscButton
		{
			idc = 1607;
			text = "8"; //--- ToDo: Localize;
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[8] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1608: RscButton
		{
			idc = 1608;
			text = "9"; //--- ToDo: Localize;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[9] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1610: RscButton
		{
			idc = 1610;
			text = "#"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[-1] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscButton_1612: RscButton
		{
			idc = 1612;
			text = "<";
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[-1] call A3PL_Phone_AddNumber;";
			sizeEx = "0.015 * safezoneH";
		};
		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Amount:"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class RscButton_1609: RscButton
		{
			idc = 1609;
			text = "Send Money"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Phone_BankSendMoneyNumber;";
			sizeEx = "0.015 * safezoneH";
		};
	};
};