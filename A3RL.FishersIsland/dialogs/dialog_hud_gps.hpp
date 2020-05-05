/* #Mekiko
$[
	1.063,
	["GPS",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[-1200,"GPS_FRAME",[1,"A3PL_Common\GUI\player_hud\gps_day.paa",["-0.0259375 * safezoneW + safezoneX","0.709 * safezoneH + safezoneY","0.252656 * safezoneW","0.396 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 23540;"]],
	[-1000,"GPS_MAP: RscMapControl",[1,"",["-0.500312 * safezoneW + safezoneX","0.632 * safezoneH + safezoneY","0 * safezoneW","0 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 23539;"]],
	[-1100,"GPS_AZIMUT_INFO",[1,"",["0.0377603 * safezoneW + safezoneX","0.826667 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 23542;","style = 2;"]],
	[-1101,"GPS_ALTITUDE_INFO",[1,"",["0.0389584 * safezoneW + safezoneX","0.856815 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 23543;","style = 2;"]],
	[-1102,"GPS_POSITION_INFO",[1,"",["0.038802 * safezoneW + safezoneX","0.886667 * safezoneH + safezoneY","0.0360937 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],["idc = 23544;","style = 2;"]]
]
*/


class Dialog_HUD_GPS {
	idd=-1;
	name="Dialog_HUD_GPS";
	onLoad="uiNamespace setVariable [""Dialog_HUD_GPS"",_this select 0]";
	movingEnable=0;
	fadein=6;
	duration=9999999999999;
	fadeout=0;
	class controlsBackground {
		class GPS_FRAME: RscPicture {
			idc = 23540;
			x = -0.0259375 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.252656 * safezoneW;
			h = 0.396 * safezoneH;
			text = "A3PL_Common\GUI\player_hud\gps_day.paa";
		};
		class GPS_AZIMUT_INFO: RscStructuredText {
			idc = 23542;
			x = 0.0397603 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_ALTITUDE_INFO: RscStructuredText {
			idc = 23543;
			x = 0.0389584 * safezoneW + safezoneX;
			y = 0.859815 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_POSITION_INFO: RscStructuredText {
			idc = 23544;
			x = 0.038802 * safezoneW + safezoneX;
			y = 0.888 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.022 * safezoneH;
			style = ST_CENTER;
		};
		class GPS_MAP: RscMapControl {
			idc = 23539;
			x = 0.0810619 * safezoneW + safezoneX;
			y = 0.828481 * safezoneH + safezoneY;
			w = 0.109 * safezoneW;
			h = 0.138 * safezoneH;
		};
	};
	class controls {};
};