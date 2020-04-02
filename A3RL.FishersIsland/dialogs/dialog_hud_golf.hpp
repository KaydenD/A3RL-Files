
class Dialog_HUD_Golf
{
	idd = -1;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""Dialog_HUD_Golf"", _this select 0]";
	class Controls
	{

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Jorisi)
	////////////////////////////////////////////////////////

	class RscFrame_1800: RscFrame
	{
		idc = 1800;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1801: RscFrame
	{
		idc = 1801;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1802: RscFrame
	{
		idc = 1802;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1803: RscFrame
	{
		idc = 1803;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1804: RscFrame
	{
		idc = 1804;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1805: RscFrame
	{
		idc = 1805;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1806: RscFrame
	{
		idc = 1806;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1807: RscFrame
	{
		idc = 1807;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1808: RscFrame
	{
		idc = 1808;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1809: RscFrame
	{
		idc = 1809;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class RscFrame_1810: RscFrame
	{
		idc = 1810;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.088 * safezoneH;
	};
	class name1: RscStructuredText
	{
		idc = 1000;
		text = ""; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes
			{
				font = "PuristaBold";
				color = "#ffffff";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#333333";
				size = 0.8;
			};
	};
	class name2: RscStructuredText
	{
		idc = 1001;
		text = ""; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes
			{
				font = "PuristaBold";
				color = "#ffffff";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#333333";
				size = 0.8;
			};
	};
	class name3: RscStructuredText
	{
		idc = 1002;
		text = ""; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes
			{
				font = "PuristaBold";
				color = "#ffffff";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#333333";
				size = 1;
			};
	};
	class name4: RscStructuredText
	{
		idc = 1003;
		text = ""; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.022 * safezoneH;
		class Attributes
			{
				font = "PuristaBold";
				color = "#ffffff";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#333333";
				size = 0.8;
			};
	};
	class RscFrame_1811: RscFrame
	{
		idc = 1811;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscFrame_1812: RscFrame
	{
		idc = 1812;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscFrame_1813: RscFrame
	{
		idc = 1813;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscFrame_1814: RscFrame
	{
		idc = 1814;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.154687 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class p1icon: RscPicture
	{
		idc = 1200;
		text = ""; //--- ToDo: Localize;
		x = 0.278281 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class p2icon: RscPicture
	{
		idc = 1201;
		text = ""; //--- ToDo: Localize;
		x = 0.278281 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class p3icon: RscPicture
	{
		idc = 1202;
		text = ""; //--- ToDo: Localize;
		x = 0.278281 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class p4icon: RscPicture
	{
		idc = 1203;
		text = ""; //--- ToDo: Localize;
		x = 0.278281 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class p1score1: RscText
	{
		idc = 1100;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score2: RscText
	{
		idc = 1101;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score3: RscText
	{
		idc = 1102;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score4: RscText
	{
		idc = 1103;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score5: RscText
	{
		idc = 1104;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score6: RscText
	{
		idc = 1105;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score7: RscText
	{
		idc = 1106;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score8: RscText
	{
		idc = 1107;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score9: RscText
	{
		idc = 1108;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p1score10: RscText
	{
		idc = 1109;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score1: RscText
	{
		idc = 1110;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score2: RscText
	{
		idc = 1111;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score3: RscText
	{
		idc = 1112;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score4: RscText
	{
		idc = 1113;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score5: RscText
	{
		idc = 1114;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score6: RscText
	{
		idc = 1115;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score7: RscText
	{
		idc = 1116;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score8: RscText
	{
		idc = 1117;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score9: RscText
	{
		idc = 1118;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p2score10: RscText
	{
		idc = 1119;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score1: RscText
	{
		idc = 1120;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score2: RscText
	{
		idc = 1121;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score3: RscText
	{
		idc = 1122;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score4: RscText
	{
		idc = 1123;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score5: RscText
	{
		idc = 1124;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score6: RscText
	{
		idc = 1125;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score7: RscText
	{
		idc = 1126;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score8: RscText
	{
		idc = 1127;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score9: RscText
	{
		idc = 1128;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p3score10: RscText
	{
		idc = 1129;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score1: RscText
	{
		idc = 1130;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score2: RscText
	{
		idc = 1131;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score3: RscText
	{
		idc = 1132;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score4: RscText
	{
		idc = 1133;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score5: RscText
	{
		idc = 1134;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score6: RscText
	{
		idc = 1135;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score7: RscText
	{
		idc = 1136;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score8: RscText
	{
		idc = 1137;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score9: RscText
	{
		idc = 1138;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class p4score10: RscText
	{
		idc = 1139;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		//text = "0";
		style = ST_CENTER;  // defined constant
	};
	class mainscore1: RscText
	{
		idc = 1140;
		x = 0.567031 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class mainscore2: RscText
	{
		idc = 1141;
		x = 0.567031 * safezoneW + safezoneX;
		y = 0.104 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class mainscore3: RscText
	{
		idc = 1142;
		x = 0.567031 * safezoneW + safezoneX;
		y = 0.126 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class mainscore4: RscText
	{
		idc = 1143;
		x = 0.567031 * safezoneW + safezoneX;
		y = 0.148 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class 1: RscText
	{
		idc = 1144;
		x = 0.412344 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "1";
		style = ST_CENTER;  // defined constant
	};
	class 2: RscText
	{
		idc = 1145;
		x = 0.427812 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "2";
		style = ST_CENTER;  // defined constant
	};
	class 3: RscText
	{
		idc = 1146;
		x = 0.443281 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "3";
		style = ST_CENTER;  // defined constant
	};
	class 4: RscText
	{
		idc = 1147;
		x = 0.45875 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "4";
		style = ST_CENTER;  // defined constant
	};
	class 5: RscText
	{
		idc = 1148;
		x = 0.474219 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "5";
		style = ST_CENTER;  // defined constant
	};
	class 6: RscText
	{
		idc = 1149;
		x = 0.489687 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "6";
		style = ST_CENTER;  // defined constant
	};
	class 7: RscText
	{
		idc = 1150;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "7";
		style = ST_CENTER;  // defined constant
	};
	class 8: RscText
	{
		idc = 1151;
		x = 0.520625 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "8";
		style = ST_CENTER;  // defined constant
	};
	class 9: RscText
	{
		idc = 1152;
		x = 0.536094 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "9";
		style = ST_CENTER;  // defined constant
	};
	class 10: RscText
	{
		idc = 1153;
		x = 0.551562 * safezoneW + safezoneX;
		y = 0.06 * safezoneH + safezoneY;
		w = 0.0154688 * safezoneW;
		h = 0.022 * safezoneH;
		text = "10";
		style = ST_CENTER;  // defined constant
	};
	

	class progressbar: RscProgress
	{
		idc = 12009;
		colorFrame[] = {0.72,0.72,0.72,1};
		colorBar[] = {0.641,0.25,0.109,1};	
		text = "#(argb,8,8,3)color(1,1,1,1)";
		x = 0.345313 * safezoneW + safezoneX;
		y = 0.742 * safezoneH + safezoneY;
		w = 0.309375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class RscText_1000: RscText
	{
		idc = 10009;
		text = ""; //--- ToDo: Localize;
		x = 0.345312 * safezoneW + safezoneX;
		y = 0.786 * safezoneH + safezoneY;
		w = 0.226875 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class RscText_1001: RscText
	{
		idc = 10019;
		text = ""; //--- ToDo: Localize;
		x = 0.345313 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.309375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscText_1002: RscText
	{
		idc = 10029;
		text = ""; //--- ToDo: Localize;
		x = 0.654688 * safezoneW + safezoneX;
		y = 0.742 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscText_1003: RscText
	{
		idc = 10039;
		text = ""; //--- ToDo: Localize;
		x = 0.654688 * safezoneW + safezoneX;
		y = 0.764 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscText_1004: RscText
	{
		idc = 10049;
		//text = "Turn: Zannaza   || 60 seconds"; //--- ToDo: Localize;
		text = ""; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.17 * safezoneH + safezoneY;
		w = 0.273281 * safezoneW;
		h = 0.022 * safezoneH;
	};

	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

	};
};


/* #Luryji
$[
	1.063,
	["a",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1200,"progressbar",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.345313 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.309375 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Spacebar to continue, Backspace to go back",["0.345312 * safezoneW + safezoneX","0.786 * safezoneH + safezoneY","0.226875 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Select speed",["0.345313 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.309375 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Speed: 100%",["0.654688 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Heigh: 100%",["0.654688 * safezoneW + safezoneX","0.764 * safezoneH + safezoneY","0.0773437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"Turn: Zannaza   || 60 seconds",["0.29375 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.273281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



/* #Jorisi
$[
	1.063,
	["a",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1800,"",[1,"",["0.29375 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.118594 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"",[1,"",["0.412344 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"name1",[1,"Folkert Fapperino",["0.29375 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.118594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.427812 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.443281 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1804,"",[1,"",["0.45875 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1805,"",[1,"",["0.474219 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1806,"",[1,"",["0.489687 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1807,"",[1,"",["0.505156 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1808,"",[1,"",["0.520625 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1809,"",[1,"",["0.536094 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1810,"",[1,"",["0.551562 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"name2",[1,"Folkert Fapperino",["0.29375 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.118594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"name3",[1,"Folkert Fapperino",["0.29375 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.118594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"name4",[1,"Folkert Fapperino",["0.29375 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.118594 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1811,"",[1,"",["0.412344 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1812,"",[1,"",["0.412344 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1813,"",[1,"",["0.412344 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1814,"",[1,"",["0.412344 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.154687 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"p1icon",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.278281 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"p2icon",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.278281 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"p3icon",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.278281 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1203,"p4icon",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.278281 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"p1score1",[1,"",["0.412344 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"p1score2",[1,"",["0.427812 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"p1score3",[1,"",["0.443281 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1103,"p1score4",[1,"",["0.45875 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1104,"p1score5",[1,"",["0.474219 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1105,"p1score6",[1,"",["0.489687 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1106,"p1score7",[1,"",["0.505156 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1107,"p1score8",[1,"",["0.520625 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1108,"p1score9",[1,"",["0.536094 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1109,"p1score10",[1,"",["0.551562 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1110,"p2score1",[1,"",["0.412344 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1111,"p2score2",[1,"",["0.427812 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1112,"p2score3",[1,"",["0.443281 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1113,"p2score4",[1,"",["0.45875 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1114,"p2score5",[1,"",["0.474219 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1115,"p2score6",[1,"",["0.489687 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1116,"p2score7",[1,"",["0.505156 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1117,"p2score8",[1,"",["0.520625 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1118,"p2score9",[1,"",["0.536094 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1119,"p2score10",[1,"",["0.551562 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1120,"p3score1",[1,"",["0.412344 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1121,"p3score2",[1,"",["0.427812 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1122,"p3score3",[1,"",["0.443281 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1123,"p3score4",[1,"",["0.45875 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1124,"p3score5",[1,"",["0.474219 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1125,"p3score6",[1,"",["0.489687 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1126,"p3score7",[1,"",["0.505156 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1127,"p3score8",[1,"",["0.520625 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1128,"p3score9",[1,"",["0.536094 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1129,"p3score10",[1,"",["0.551562 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1130,"p4score1",[1,"",["0.412344 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1131,"p4score2",[1,"",["0.427812 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1132,"p4score3",[1,"",["0.443281 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1133,"p4score4",[1,"",["0.45875 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1134,"p4score5",[1,"",["0.474219 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1135,"p4score6",[1,"",["0.489687 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1136,"p4score7",[1,"",["0.505156 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1137,"p4score8",[1,"",["0.520625 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1138,"p4score9",[1,"",["0.536094 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1139,"p4score10",[1,"",["0.551562 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1140,"mainscore1",[1,"",["0.567031 * safezoneW + safezoneX","0.082 * safezoneH + safezoneY","0.020625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1141,"mainscore2",[1,"",["0.567031 * safezoneW + safezoneX","0.104 * safezoneH + safezoneY","0.020625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1142,"mainscore3",[1,"",["0.567031 * safezoneW + safezoneX","0.126 * safezoneH + safezoneY","0.020625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1143,"mainscore4",[1,"",["0.567031 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.020625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1144,"1",[1,"",["0.412344 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1145,"2",[1,"",["0.427812 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1146,"3",[1,"",["0.443281 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1147,"4",[1,"",["0.45875 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1148,"5",[1,"",["0.474219 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1149,"6",[1,"",["0.489687 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1150,"7",[1,"",["0.505156 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1151,"8",[1,"",["0.520625 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1152,"9",[1,"",["0.536094 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1153,"10",[1,"",["0.551562 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



// Paintball HUD
/* #Mugyxe
$[
	1.063,
	["a",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"",[1,"",["0.824844 * safezoneW + safezoneX","0.038 * safezoneH + safezoneY","0.180469 * safezoneW","0.242 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1101,"",[1,"<t font='EtelkaNarrowMediumPro' color='#8efdff' size='2.5' align='center'>Mission begins in: 10</t>",["0.29375 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.4125 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1102,"playerlist",[1,"",["0.840312 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0876563 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"",[1,"",["0.840312 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.139219 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"",[1,"",["0.95375 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0257812 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1803,"",[1,"",["0.927969 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0257812 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"",[1,"Kills",["0.927969 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.0257812 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.7"],[]],
	[1001,"",[1,"Deaths",["0.95375 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.0257812 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.7"],[]],
	[1103,"deathlist",[1,"",["0.95375 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0257812 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1104,"killlist",[1,"",["0.927969 * safezoneW + safezoneX","0.324 * safezoneH + safezoneY","0.0257812 * safezoneW","0.33 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Players",["0.840312 * safezoneW + safezoneX","0.313 * safezoneH + safezoneY","0.0309375 * safezoneW","0.011 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","0.7"],[]]
]
*/

