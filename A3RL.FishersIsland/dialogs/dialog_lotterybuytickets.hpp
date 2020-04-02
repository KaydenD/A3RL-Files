/* #Cecida
$[
	1.063,
	["buytickets",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.396875 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.201094 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_howmany",[1,"Enter amount:",["0.396875 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_purchase",[1,"Purchase",["0.469062 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"text_address",[1,"Address: ",["0.422656 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_amount",[1,"",["0.453594 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0979687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"static_price",[1,"Ticket price: ",["0.422656 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"static_max",[1,"Maximum tickets you can buy (total):",["0.422656 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.134062 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"text_max",[1,"10",["0.561875 * safezoneW + safezoneX","0.456 * safezoneH + safezoneY","0.0257812 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"",[1,"100",["0.561875 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.0309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"static_expire",[1,"Lottery start (expire): ",["0.4175 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"text_expire",[1,"500 seconds",["0.505156 * safezoneW + safezoneX","0.588 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_LotteryBuyTickets
{
	idd = 25;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Cecida)
		////////////////////////////////////////////////////////

		class IGUIBack_2200: IGUIBack
		{
			idc = 2200;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class static_howmany: RscText
		{
			idc = 1000;
			text = "Amount:"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_purchase: RscButton
		{
			idc = 1600;
			text = "Purchase"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call A3PL_Housing_BuyTickets";
		};
		class text_address: RscText
		{
			idc = 1001;
			text = "Address: "; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class edit_amount: RscEdit
		{
			idc = 1400;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_price: RscText
		{
			idc = 1002;
			text = "Ticket price: "; //--- ToDo: Localize;
			x = 0.422656  * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.065625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_max: RscText
		{
			idc = 1003;
			text = "Maximum tickets purchasable:"; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.164062 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_max: RscText
		{
			idc = 1004;
			text = "5"; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_price: RscText
		{
			idc = 1005;
			text = "100"; //--- ToDo: Localize;
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_expire: RscText
		{
			idc = 1006;
			text = "Lottery ends in: "; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_expire: RscText
		{
			idc = 1007;
			text = "500 seconds"; //--- ToDo: Localize;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0504063 * safezoneW;
			h = 0.022 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};
