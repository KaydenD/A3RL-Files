class Dialog_MapFilter_Interact
{
	idd = 57;
	movingEnable = false;
	enableSimulation = true;
	class controlsBackground 
	{

		class MarkersList: RscListbox 
		{
			idc = 1500;
			onLBSelChanged = "[] call A3PL_Markers_SelectFilter;";
			x = 0.0514062 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.374 * safezoneH;
		};			
	};
	
	class controls
	{		
	};
};