/* #Qyhoky
$[
	1.063,
	["Cinema_Debug",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"",[1,"",["0.726875 * safezoneW + safezoneX","0.39 * safezoneH + safezoneY","0.268125 * safezoneW","0.429 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Hud_Cinema
{
	idd = 1299;
	fadeout = 0;
	fadein = 0;
	duration = 1e+1000;
	onLoad = "disableSerialization; uiNamespace setVariable ['Dialog_Hud_Cinema',_this select 0];";
	onUnload = "disableSerialization; uiNamespace setVariable ['Dialog_Hud_Cinema',nil];";
	
	class controlsBackground 
	{

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Kane, v1.063, #Jirumy)
		////////////////////////////////////////////////////////

		class struc_system: RscStructuredText
		{
			idc = 1100;
			x = 0.726875 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.429 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
