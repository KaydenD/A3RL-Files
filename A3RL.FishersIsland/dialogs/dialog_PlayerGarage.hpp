/* #Hebemy
$[
	1.063,
	["asdddd",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"P_Background",[1,"dialog_PlayerGarage.paa",["-0.00221875 * safezoneW + safezoneX","-0.444999 * safezoneH + safezoneY","1.00444 * safezoneW","1.89145 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"L_StoredVehicles",[1,"",["0.325 * safezoneW + safezoneX","0.344 * safezoneH + safezoneY","0.15 * safezoneW","0.312 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[1501,"L_VehicleInformation",[1,"",["0.525 * safezoneW + safezoneX","0.344 * safezoneH + safezoneY","0.15 * safezoneW","0.112 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.8"],[]],
	[1400,"TE_NewVehicleName",[1,"",["0.525 * safezoneW + safezoneX","0.624 * safezoneH + safezoneY","0.15 * safezoneW","0.032 * safezoneH"],[-1,-1,-1,-1],[1,1,1,-1],[1,1,1,-1],"","0.8"],[]],
	[1600,"B_RetreiveVehicle",[1,"",["0.3475 * safezoneW + safezoneX","0.68 * safezoneH + safezoneY","0.105 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[1,1,1,-1],[1,1,1,-1],"","0.8"],[]],
	[1601,"B_RenameVehicle",[1,"",["0.5475 * safezoneW + safezoneX","0.68 * safezoneH + safezoneY","0.105 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[1,1,1,-1],[1,1,1,-1],"","0.8"],[]]
]
*/

class Dialog_PlayerGarage
{
	idd = 145;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Jon VanderZee, v1.063, #Hebemy)
		////////////////////////////////////////////////////////

		class P_Background: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\GUI\dialog_PlayerGarage.paa";
			x = -0.00221875 * safezoneW + safezoneX;
			y = -0.444999 * safezoneH + safezoneY;
			w = 1.00444 * safezoneW;
			h = 1.89145 * safezoneH;
		};
		class L_StoredVehicles: RscListbox
		{
			idc = 1500;
			x = 0.325 * safezoneW + safezoneX;
			y = 0.344 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.312 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class L_VehicleInformation: RscListbox
		{
			idc = 1501;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.344 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.112 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class TE_NewVehicleName: RscEdit
		{
			idc = 1400;
			x = 0.525 * safezoneW + safezoneX;
			y = 0.624 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.032 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
		};
		class B_RetreiveVehicle: RscButton
		{
			idc = 1600;
			x = 0.3475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
		};
		class B_RenameVehicle: RscButton
		{
			idc = 1601;
			x = 0.5475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.8 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};