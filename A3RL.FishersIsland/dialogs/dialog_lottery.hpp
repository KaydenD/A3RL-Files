/* #Wexywo
$[
	1.063,
	["Lottery",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_background",[1,"A3PL_Common\GUI\A3PL_Lottery.paa",["0.0751562 * safezoneW + safezoneX","0.122296 * safezoneH + safezoneY","0.805885 * safezoneW","0.743482 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"text_address",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.377083 * safezoneW + safezoneX","0.30463 * safezoneH + safezoneY","0.0808332 * safezoneW","0.0147037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"text_auctioneer",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.533854 * safezoneW + safezoneX","0.30463 * safezoneH + safezoneY","0.0870833 * safezoneW","0.0137778 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"text_numberCombined",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.448594 * safezoneW + safezoneX","0.646889 * safezoneH + safezoneY","0.035 * safezoneW","0.0531482 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1204,"text_ticketNumbers",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.635052 * safezoneW + safezoneX","0.325741 * safezoneH + safezoneY","0.0667709 * safezoneW","0.442037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1205,"static_lotteryWheel1",[1,"A3PL_Common\GUI\A3PL_LotteryWheel.paa",["0.282448 * safezoneW + safezoneX","0.348555 * safezoneH + safezoneY","0.198 * safezoneW","0.352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1206,"static_lotteryWheel2",[1,"A3PL_Common\GUI\A3PL_LotteryWheel.paa",["0.44849 * safezoneW + safezoneX","0.348926 * safezoneH + safezoneY","0.198 * safezoneW","0.352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"text_winnerText",[1,"The winner is: Kane Potato",["0.381406 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.175313 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_Lottery
{
	idd = 24;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Putare)
		////////////////////////////////////////////////////////

		class static_background: RscPicture
		{
			idc = 1200;
			text = "A3PL_Common\GUI\A3PL_Lottery.paa";
			x = 0.0751562 * safezoneW + safezoneX;
			y = 0.122296 * safezoneH + safezoneY;
			w = 0.805885 * safezoneW;
			h = 0.743482 * safezoneH;
		};
		
		class static_lotteryWheel1: RscPicture
		{
			idc = 1205;
			text = "A3PL_Common\GUI\A3PL_LotteryWheel.paa";
			x = 0.282448 * safezoneW + safezoneX;
			y = 0.348555 * safezoneH + safezoneY;
			w = 0.198 * safezoneW;
			h = 0.352 * safezoneH;
		};
		class static_lotteryWheel2: RscPicture
		{
			idc = 1206;
			text = "A3PL_Common\GUI\A3PL_LotteryWheel.paa";
			x = 0.44849 * safezoneW + safezoneX;
			y = 0.348926 * safezoneH + safezoneY;
			w = 0.198 * safezoneW;
			h = 0.352 * safezoneH;
		};
		
		class text_address: RscText
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.377083 * safezoneW + safezoneX;
			y = 0.30663 * safezoneH + safezoneY;
			w = 0.0808332 * safezoneW;
			h = 0.0147037 * safezoneH;
			font = "Purista";
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class text_auctioneer: RscText
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.533854 * safezoneW + safezoneX;
			y = 0.30663 * safezoneH + safezoneY;
			w = 0.0870833 * safezoneW;
			h = 0.0137778 * safezoneH;
			font = "Purista";
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class text_numberCombined: RscStructuredText
		{
			idc = 1203;
			text = "";
			x = 0.448594 * safezoneW + safezoneX;
			y = 0.646889 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.0531482 * safezoneH;
		};
		class text_ticketNumbers: RscStructuredText
		{
			idc = 1204;
			text = "";
			x = 0.635052 * safezoneW + safezoneX;
			y = 0.325741 * safezoneH + safezoneY;
			w = 0.0667709 * safezoneW;
			h = 0.442037 * safezoneH;
		};
		
		class text_winnerText: RscStructuredText
		{
			idc = 1000;
			text = ""; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};


