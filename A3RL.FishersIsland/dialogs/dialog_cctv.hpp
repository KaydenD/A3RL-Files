/* #Bytose
$[
	1.063,
	["CCTV",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"static_bg",[1,"P:\A3PL_Common\GUI\A3PL_CCTV2.paa",["0 * safezoneW + safezoneX","0 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"A3PL_CCTV_3",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.185469 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.257813 * safezoneW","0.308 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"A3PL_CCTV_2",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.561875 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.257813 * safezoneW","0.308 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1204,"A3PL_CCTV_4",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.561875 * safezoneW + safezoneX","0.544 * safezoneH + safezoneY","0.257813 * safezoneW","0.308 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"A3PL_CCTV_1",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.185469 * safezoneW + safezoneX","0.203 * safezoneH + safezoneY","0.257813 * safezoneW","0.308 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"combo_cam1",[1,"",["0.206197 * safezoneW + safezoneX","0.15856 * safezoneH + safezoneY","0.216563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"combo_cam2",[1,"",["0.581881 * safezoneW + safezoneX","0.1579 * safezoneH + safezoneY","0.216563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"combo_cam3",[1,"",["0.206094 * safezoneW + safezoneX","0.874 * safezoneH + safezoneY","0.216563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2103,"combo_cam4",[1,"",["0.581984 * safezoneW + safezoneX","0.874 * safezoneH + safezoneY","0.216563 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2500,"check_normal",[1,"",["0.427812 * safezoneW + safezoneX","0.164556 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2501,"check_night",[1,"Normal",["0.479896 * safezoneW + safezoneX","0.164444 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2502,"check_thermal",[1,"Normal",["0.530937 * safezoneW + safezoneX","0.164444 * safezoneH + safezoneY","0.0464063 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/


class Dialog_CCTV
{
	idd = 27;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "if (!isNull A3PL_NPC_Cam) then {A3PL_NPC_Cam cameraEffect ['TERMINATE', 'BACK']; camDestroy A3PL_NPC_Cam};";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Jezuri)
		////////////////////////////////////////////////////////

		class static_bg: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\A3PL_CCTV2.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class A3PL_CCTV_3: RscPicture
		{
			idc = 1202;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_3_RT,1.0)";
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_2: RscPicture
		{
			idc = 1203;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_2_RT,1.0)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_4: RscPicture
		{
			idc = 1204;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_4_RT,1.0)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class A3PL_CCTV_1: RscPicture
		{
			idc = 1201;
			text = "#(argb,256,256,1)r2t(A3PL_CCTV_1_RT,1.0))";
			x = 0.185469 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.308 * safezoneH;
		};
		class combo_cam1: RscCombo
		{
			idc = 2100;
			x = 0.206197 * safezoneW + safezoneX;
			y = 0.15856 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam2: RscCombo
		{
			idc = 2101;
			x = 0.581881 * safezoneW + safezoneX;
			y = 0.1579 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam3: RscCombo
		{
			idc = 2102;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class combo_cam4: RscCombo
		{
			idc = 2103;
			x = 0.581984 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.033 * safezoneH;
		};		
		
		class check_normal: RscTextCheckbox
		{
			idc = 2500;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.164556 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"NORMAL"
			};
			checked_strings[] = 
			{
				"NORMAL"
			};			
		};
		class check_night: RscTextCheckbox
		{
			idc = 2501;
			text = "Normal"; //--- ToDo: Localize;
			x = 0.479896 * safezoneW + safezoneX;
			y = 0.164444 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"NV"
			};
			checked_strings[] = 
			{
				"NV"
			};				
		};
		class check_thermal: RscTextCheckbox
		{
			idc = 2502;
			text = "Normal"; //--- ToDo: Localize;
			x = 0.530937 * safezoneW + safezoneX;
			y = 0.164444 * safezoneH + safezoneY;
			w = 0.0464063 * safezoneW;
			h = 0.022 * safezoneH;
			strings[] = 
			{
				"THERMAL"
			};
			checked_strings[] = 
			{
				"THERMAL"
			};			
		};		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
				
	};
};