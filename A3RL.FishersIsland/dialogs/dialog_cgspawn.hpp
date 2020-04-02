/* #Purahe
$[
	1.063,
	["test",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_background",[1,"",["0.396875 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.195937 * safezoneW","0.132 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_text1",[1,"Your faction is set to USCG",["0.443281 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.149531 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"static_text2",[1,"Would you like to teleport to the USCG Cutter?",["0.412344 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.185625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_yes",[1,"Yes",["0.427812 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0515625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_no",[1,"No",["0.515469 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0515625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_CGSpawn
{
	idd = 86;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{	
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Purahe)
		////////////////////////////////////////////////////////

		class static_background: IGUIBack
		{
			idc = 2200;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.132 * safezoneH;
			
		};
		class static_text1: RscText
		{
			idc = 1000;
			text = "Your faction is set to USCG"; //--- ToDo: Localize;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.022 * safezoneH;
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class static_text2: RscText
		{
			idc = 1001;
			text = "Would you like to teleport to the USCG Base?"; //--- ToDo: Localize;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.033 * safezoneH;
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class button_yes: RscButton
		{
			idc = 1600;
			text = "Yes"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class button_no: RscButton
		{
			idc = 1601;
			text = "No"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};