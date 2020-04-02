/* #Bebaki
$[
	1.063,
	["CarStorage",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"",[1,"A3PL_Common\GUI\VehicleShop.paa",["0.324687 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.350625 * safezoneW","0.704 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"button_retrieve",[1,"",["0.45875 * safezoneW + safezoneX","0.621 * safezoneH + safezoneY","0.0773437 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"list_vehicles",[1,"",["0.412344 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.170677 * safezoneW","0.215481 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"",["0.577344 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.020625 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class Dialog_CarStorage
{
	idd = 57;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "A3PL_Storage_ReturnArray = []";
	onUnload = "A3PL_Storage_ReturnArray = Nil";
	
	class controls
	{

		class static_bg: RscPicture
		{
			idc = 2200;
			text = "A3PL_Common\GUI\VehicleShop.paa";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.350625 * safezoneW;
			h = 0.704 * safezoneH;
		};
		
		class button_retrieve: RscButtonEmpty
		{
			idc = 1600;
			text = "";
			x = 0.45875 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call A3PL_Storage_CarRetrieveButton";
		};

		class list_vehicles: RscListbox
		{
			idc = 1500;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.170677 * safezoneW;
			h = 0.215481 * safezoneH;
		};

		class RscButton_1601: RscButtonEmpty
		{
			idc = 1601;
			action = "closeDialog 0;";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};