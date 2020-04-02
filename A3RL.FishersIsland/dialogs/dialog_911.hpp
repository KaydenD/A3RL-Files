class Dialog_911
{
	idd = 911;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class static_guiBack: IGUIBack
		{
			idc = 2200;
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.304219 * safezoneW;
			h = 0.385 * safezoneH;
		};
		class static_header: RscText
		{
			idc = 1000;
			text = "911 - Please state your emergency"; //--- ToDo: Localize;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_crimeCategory: RscText
		{
			idc = 1001;
			text = "Crime Category:"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class combo_Category: RscCombo
		{
			idc = 2100;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;			
		};
		class text_crimeComitted: RscText
		{
			idc = 1002;
			text = "Crime Commited:"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class combo_Crime: RscCombo
		{
			idc = 2101;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_colour: RscText
		{
			idc = 1003;
			text = "Suspect Vehicle Colour:"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class combo_Colour: RscCombo
		{
			idc = 2102;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_type: RscText
		{
			idc = 1004;
			text = "Suspect Vehicle Type:"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class combo_Type: RscCombo
		{
			idc = 2103;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_armed: RscText
		{
			idc = 1005;
			text = "Is the suspect armed?"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class checkbox_Armed: RscTextCheckbox
		{
			idc = 2500;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_heading: RscText
		{
			idc = 1006;
			text = "Suspect Heading:"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class combo_Heading: RscCombo
		{
			idc = 2104;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class button_Report: RscButton
		{
			idc = 1600;
			text = "Report"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class button_cancel: RscButton
		{
			idc = 1601;
			text = "Cancel"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		
		class edit_extraInfo: RscEdit
		{
			idc = 1400;
			x = 0.510312 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.134062 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class text_extraInfo: RscText
		{
			idc = 1007;
			text = "Extra Info (e.g. Suspect Description)"; //--- ToDo: Localize;
			x = 0.350469 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.022 * safezoneH;
		};		
	
	};
	
};

/* #Wobeby
$[
	1.063,
	["Potato",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_guiBack",[1,"",["0.345312 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.304219 * safezoneW","0.385 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_header",[1,"9-1-1 - Please state your emergency",["0.412344 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"text_crimeCategory",[1,"Crime Category:",["0.360781 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"combo_Category",[1,"",["0.469062 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.139219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"text_crimeComitted",[1,"Crime Commited:",["0.360781 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"combo_Crime",[1,"",["0.469062 * safezoneW + safezoneX","0.478 * safezoneH + safezoneY","0.139219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"text_colour",[1,"Suspect Vehicle Colour:",["0.360781 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"combo_Colour",[1,"",["0.469062 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.139219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"text_type",[1,"Suspect Vehicle Type:",["0.360781 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0979687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2103,"combo_Type",[1,"",["0.469062 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.139219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"text_armed",[1,"Is the suspect armed?",["0.360781 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2500,"checkbox_Armed",[1,"",["0.469062 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"text_heading",[1,"Suspect Heading:",["0.360781 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.103125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2104,"combo_Heading",[1,"",["0.469062 * safezoneW + safezoneX","0.577 * safezoneH + safezoneY","0.139219 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_Report",[1,"Report",["0.432969 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.0515625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_cancel",[1,"Cancel",["0.5 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.0515625 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"edit_extraInfo",[1,"",["0.510312 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.134062 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"text_extraInfo",[1,"Extra Info (e.g. Suspect Description)",["0.350469 * safezoneW + safezoneX","0.665 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
