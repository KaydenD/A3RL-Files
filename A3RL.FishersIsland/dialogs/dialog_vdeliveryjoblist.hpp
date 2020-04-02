/* #Nyxuta
$[
	1.063,
	["jobList",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"static_background",[1,"",["0.412344 * safezoneW + safezoneX","0.302 * safezoneH + safezoneY","0.170156 * safezoneW","0.352 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"list_jobs",[1,"",["0.4175 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.159844 * safezoneW","0.286 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_takejob",[1,"Take job",["0.469062 * safezoneW + safezoneX","0.61 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_VDeliveryJobList
{
	idd = 83;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "A3PL_JobVDelivery_JobList = []";
	onUnload = "A3PL_JobVDelivery_JobList = Nil";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Nyxuta)
		////////////////////////////////////////////////////////

		class static_background: IGUIBack
		{
			idc = 2200;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.352 * safezoneH;
		};
		class list_jobs: RscListbox
		{
			idc = 1500;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.286 * safezoneH;
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class button_takejob: RscButton
		{
			idc = 1600;
			text = "Take job"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
