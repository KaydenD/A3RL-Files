/* #Zomiqi
$[
	1.063,
	["Tickets",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"",[1,"",["0.407187 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.195937 * safezoneW","0.165 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Yes",["0.427812 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"No",["0.520625 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"You have been given a ticket of $%1",["0.438125 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.144375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Would you like to pay this ticket?",["0.443281 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.12375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_ReceiveTicket
{
	idd = 37;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Kane, v1.063, #Zomiqi)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0.407187 * safezoneW + safezoneX;
		y = 0.434 * safezoneH + safezoneY;
		w = 0.195937 * safezoneW;
		h = 0.165 * safezoneH;
	};
	class button_Yes: RscButton
	{
		idc = 1600;
		text = "Yes"; //--- ToDo: Localize;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.544 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class button_No: RscButton
	{
		idc = 1601;
		text = "No"; //--- ToDo: Localize;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.544 * safezoneH + safezoneY;
		w = 0.0567187 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class text_amount: RscText
	{
		idc = 1000;
		text = "You have been given a ticket of $%1"; //--- ToDo: Localize;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.185625 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class static_payticket: RscText
	{
		idc = 1001;
		text = "Would you like to pay this ticket?"; //--- ToDo: Localize;
		x = 0.4175 * safezoneW + safezoneX;
		y = 0.489 * safezoneH + safezoneY;
		w = 0.180469 * safezoneW;
		h = 0.033 * safezoneH;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////
	
	};
};