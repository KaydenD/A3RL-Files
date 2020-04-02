/* #Hocosu
$[
	1.063,
	["HouseBuy",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"housebuy.paa",["-0.000156274 * safezoneW + safezoneX","-0.00599999 * safezoneH + safezoneY","1 * safezoneW","1 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_yes",[1,"",["0.378802 * safezoneW + safezoneX","0.588926 * safezoneH + safezoneY","0.0980208 * safezoneW","0.0367037 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"button_no",[1,"",["0.514114 * safezoneW + safezoneX","0.586519 * safezoneH + safezoneY","0.0994268 * safezoneW","0.0384444 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"static_currentPrice",[1,"31000$",["0.542239 * safezoneW + safezoneX","0.42937 * safezoneH + safezoneY","0.0928125 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.4"],[]]
]
*/



class Dialog_HouseBuy
{
	idd = 72;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by mvdha, v1.063, #Hocosu)
		////////////////////////////////////////////////////////

		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "housebuy.paa";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
		};
		class button_yes: RscButtonEmpty
		{
			idc = 1600;
			x = 0.378802 * safezoneW + safezoneX;
			y = 0.588926 * safezoneH + safezoneY;
			w = 0.0980208 * safezoneW;
			h = 0.0367037 * safezoneH;
		};
		class button_no: RscButtonEmpty
		{
			idc = 1601;
			x = 0.514114 * safezoneW + safezoneX;
			y = 0.586519 * safezoneH + safezoneY;
			w = 0.0994268 * safezoneW;
			h = 0.0384444 * safezoneH;
		};
		class text_currentPrice: RscText
		{
			idc = 1000;
			text = "31000$"; //--- ToDo: Localize;
			x = 0.542239 * safezoneW + safezoneX;
			y = 0.43337 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = "0.03 * safezoneH";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

		
	};
};