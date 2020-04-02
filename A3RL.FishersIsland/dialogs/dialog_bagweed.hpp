/* #Xezaqe
$[
	1.063,
	["marijuanabag",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_bg",[1,"",["0.386562 * safezoneW + safezoneX","0.412 * safezoneH + safezoneY","0.2475 * safezoneW","0.165 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"text_info",[1,"Enter a number between 0 and 0 grams and click bag to bag the marijuana!",["0.396875 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.2475 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[1400,"edit_grams",[1,"",["0.463906 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"static_amount",[1,"Amount (in grams):",["0.474219 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0721875 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_bag",[1,"Bag marijuana!",["0.469062 * safezoneW + safezoneX","0.533 * safezoneH + safezoneY","0.0825 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_BagWeed
{
	idd = 74;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "A3PL_JobFarming_Scale = nil;";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Xezaqe)
		////////////////////////////////////////////////////////

		class static_bg: IGUIBack
		{
			idc = 2200;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class text_info: RscText
		{
			idc = 1000;
			text = "Enter a number between 0 and 0 grams and click bag to bag the marijuana!"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.016 * safeZoneH;
		};
		class edit_grams: RscEdit
		{
			idc = 1400;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class static_amount: RscText
		{
			idc = 1001;
			text = "Amount (in grams):"; //--- ToDo: Localize;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
			sizeEx = 0.017 * safeZoneH;
		};
		class button_bag: RscButton
		{
			idc = 1600;
			text = "Bag marijuana!"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
		
	};
};