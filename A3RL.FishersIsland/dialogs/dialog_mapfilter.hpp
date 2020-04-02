class Dialog_MapFilter 
{
	idd = -1;
	movingEnable = true;
	enableSimulation = true;
	fadein=0;
	duration=9999999999999;
	fadeout=0;	
	onLoad = "disableSerialization; uiNamespace setVariable ['A3PL_Map_Filter',_this select 0];";
	class controlsBackground 
	{
		class MapFilterPicture: RscPicture 
		{
			idc = -1;
			text = "\A3PL_Common\GUI\A3PL_MapFilter.paa"; ///////////////////////////////////////// PAA HERE
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.017 * safezoneH + safezoneY;
			w = 1.01063 * safezoneW;
			h = 1.023 * safezoneH;
			
			colorText[] = 
			{
				.8,
				.8,
				.8,
				.8
			};			
		};		
	};
};

