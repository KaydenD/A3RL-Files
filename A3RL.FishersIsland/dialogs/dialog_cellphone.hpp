class A3PL_Open_CellPhone
{
idd = 12198;
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "\A3PL_Common\phone\base\100bat.paa";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = "100%"; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.252 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = "0.015 * safezoneH";
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = "0.03 * safezoneH";
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.252 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = "0.015 * safezoneH";
		font = "PuristaSemiBold";
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	//--------------APP 1-------------------
		class apppic1: RscPicture
		{
			idc = 1001;
			text = "";
			x = 0.423687 * safezoneW + safezoneX;
			y = 0.27538 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn1: RscButtonEmpty
		{
			idc = 2001;
			x = 0.423687 * safezoneW + safezoneX;
			y = 0.27538 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext1: RscStructuredText
		{
			idc = 3001;
			text = "";
			x = 0.420104 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 2-------------------
		class apppic2: RscPicture
		{
			idc = 1002;
			text = "";
			x = 0.463597 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn2: RscButtonEmpty
		{
			idc = 2002;
			x = 0.463597 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext2: RscStructuredText
		{
			idc = 3002;
			text = "";
			x = 0.461459 * safezoneW + safezoneX;
			y = 0.324074 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 3-------------------
		class apppic3: RscPicture
		{
			idc = 1003;
			text = "";
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn3: RscButtonEmpty
		{
			idc = 2003;
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext3: RscStructuredText
		{
			idc = 3003;
			text = "";
			x = 0.501563 * safezoneW + safezoneX;
			y = 0.324074 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 4-------------------
		class apppic4: RscPicture
		{
			idc = 1004;
			text = "";
			x = 0.545272 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn4: RscButtonEmpty
		{
			idc = 2004;
			x = 0.545272 * safezoneW + safezoneX;
			y = 0.27516 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext4: RscStructuredText
		{
			idc = 3004;
			text = "";
			x = 0.542188 * safezoneW + safezoneX;
			y = 0.324074 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 5-------------------
		class apppic5: RscPicture
		{
			idc = 1005;
			text = "";
			x = 0.423481 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn5: RscButtonEmpty
		{
			idc = 2005;
			x = 0.423481 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext5: RscStructuredText
		{
			idc = 3005;
			text = "";
			x = 0.419791 * safezoneW + safezoneX;
			y = 0.402778 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 6-------------------
		class apppic6: RscPicture
		{
			idc = 1006;
			text = "";
			x = 0.464112 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn6: RscButtonEmpty
		{
			idc = 2006;
			x = 0.464112 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext6: RscStructuredText
		{
			idc = 3006;
			text = "";
			x = 0.460938 * safezoneW + safezoneX;
			y = 0.401852 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 7-------------------
		class apppic7: RscPicture
		{
			idc = 1007;
			text = "";
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn7: RscButtonEmpty
		{
			idc = 2007;
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext7: RscStructuredText
		{
			idc = 3007;
			text = "";
			x = 0.501562 * safezoneW + safezoneX;
			y = 0.401852 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 8-------------------
		class apppic8: RscPicture
		{
			idc = 1008;
			text = "";
			x = 0.545787 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn8: RscButtonEmpty
		{
			idc = 2008;
			x = 0.545787 * safezoneW + safezoneX;
			y = 0.35282 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext8: RscStructuredText
		{
			idc = 3008;
			text = "";
			x = 0.541666 * safezoneW + safezoneX;
			y = 0.400926 * safezoneH + safezoneY;
			w = 0.0366145 * safezoneW;
			h = 0.0265184 * safezoneH;
		};
	//--------------APP 9-------------------
		class apppic9: RscPicture
		{
			idc = 1009;
			text = "";
			x = 0.423378 * safezoneW + safezoneX;
			y = 0.432332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn9: RscButtonEmpty
		{
			idc = 2009;
			x = 0.423378 * safezoneW + safezoneX;
			y = 0.432332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;

		};

		class apptext9: RscStructuredText
		{
			idc = 3009;
			text = "";
			x = 0.420312 * safezoneW + safezoneX;
			y = 0.480556 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 10-------------------
		class apppic10: RscPicture
		{
			idc = 1010;
			text = "";
			x = 0.464633 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn10: RscButtonEmpty
		{
			idc = 2010;
			x = 0.464633 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};

		class apptext10: RscStructuredText
		{
			idc = 3010;
			text = "";
			x = 0.461459 * safezoneW + safezoneX;
			y = 0.480555 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 11-------------------
		class apppic11: RscPicture
		{
			idc = 1011;
			text = "";
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn11: RscButtonEmpty
		{
			idc = 2011;
			x = 0.504641 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext11: RscStructuredText
		{
			idc = 3011;
			text = "";
			x = 0.501042 * safezoneW + safezoneX;
			y = 0.480556 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 12-------------------
		class apppic12: RscPicture
		{
			idc = 1012;
			text = "";
			x = 0.545375 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0495557 * safezoneH;
		};
		class appbtn12: RscButtonEmpty
		{
			idc = 2012;
			x = 0.545375 * safezoneW + safezoneX;
			y = 0.43158 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0495557 * safezoneH;
		};
		class apptext12: RscStructuredText
		{
			idc = 3012;
			text = "";
			x = 0.541146 * safezoneW + safezoneX;
			y = 0.481482 * safezoneH + safezoneY;
			w = 0.0371354 * safezoneW;
			h = 0.0237407 * safezoneH;
		};
	//--------------APP 13-------------------
		class apppic13: RscPicture
		{
			idc = 1013;
			text = "";
			x = 0.423986 * safezoneW + safezoneX;
			y = 0.509286 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn13: RscButtonEmpty
		{
			idc = 2013;
			x = 0.423986 * safezoneW + safezoneX;
			y = 0.509286 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext13: RscStructuredText
		{
			idc = 3013;
			text = "";
			x = 0.420833 * safezoneW + safezoneX;
			y = 0.55926 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 14-------------------
		class apppic14: RscPicture
		{
			idc = 1014;
			text = "";
			x = 0.464633 * safezoneW + safezoneX;
			y = 0.509332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn14: RscButtonEmpty
		{
			idc = 2014;
			x = 0.464633 * safezoneW + safezoneX;
			y = 0.509332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext14: RscStructuredText
		{
			idc = 3014;
			text = "";
			x = 0.461459 * safezoneW + safezoneX;
			y = 0.559259 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 15-------------------
		class apppic15: RscPicture
		{
			idc = 1015;
			text = "";
			x = 0.505265 * safezoneW + safezoneX;
			y = 0.509332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn15: RscButtonEmpty
		{
			idc = 2015;
			x = 0.505265 * safezoneW + safezoneX;
			y = 0.509332 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext15: RscStructuredText
		{
			idc = 3015;
			text = "";
			x = 0.501563 * safezoneW + safezoneX;
			y = 0.55926 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 16-------------------
		class apppic16: RscPicture
		{
			idc = 1016;
			text = "";
			x = 0.544752 * safezoneW + safezoneX;
			y = 0.509286 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn16: RscButtonEmpty
		{
			idc = 2016;
			x = 0.544752 * safezoneW + safezoneX;
			y = 0.509286 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext16: RscStructuredText
		{
			idc = 3016;
			text = "";
			x = 0.542708 * safezoneW + safezoneX;
			y = 0.55926 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 17-------------------
		class apppic17: RscPicture
		{
			idc = 1017;
			text = "";
			x = 0.424739 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn17: RscButtonEmpty
		{
			idc = 2017;
			x = 0.424739 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext17: RscStructuredText
		{
			idc = 3017;
			text = "";
			x = 0.420312 * safezoneW + safezoneX;
			y = 0.637962 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 18-------------------
		class apppic18: RscPicture
		{
			idc = 1018;
			text = "";
			x = 0.464628 * safezoneW + safezoneX;
			y = 0.588092 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn18: RscButtonEmpty
		{
			idc = 2018;
			x = 0.464628 * safezoneW + safezoneX;
			y = 0.588092 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext18: RscStructuredText
		{
			idc = 3018;
			text = "";
			x = 0.460938 * safezoneW + safezoneX;
			y = 0.637963 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 19-------------------
		class apppic19: RscPicture
		{
			idc = 1019;
			text = "";
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.588752 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn19: RscButtonEmpty
		{
			idc = 2019;
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.588752 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext19: RscStructuredText
		{
			idc = 3019;
			text = "";
			x = 0.501042 * safezoneW + safezoneX;
			y = 0.637963 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//--------------APP 20-------------------
		class apppic20: RscPicture
		{
			idc = 1020;
			text = "";
			x = 0.545272 * safezoneW + safezoneX;
			y = 0.588752 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class appbtn20: RscButtonEmpty
		{
			idc = 2020;
			x = 0.545272 * safezoneW + safezoneX;
			y = 0.588752 * safezoneH + safezoneY;
			w = 0.0289583 * safezoneW;
			h = 0.0486297 * safezoneH;
		};
		class apptext20: RscStructuredText
		{
			idc = 3020;
			text = "";
			x = 0.542292 * safezoneW + safezoneX;
			y = 0.63663 * safezoneH + safezoneY;
			w = 0.0366146 * safezoneW;
			h = 0.0255926 * safezoneH;
		};
	//---------------------------------------
};
};

class callmenu
{
idd = 12194;
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "closedialog 0;";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0;";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = ""; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.254518 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.254778 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};	
	//--------------APPSTUFF------------------
	class RscPicture_1200: RscPicture
	{
		idc = 1200;
		text = "\A3PL_Common\phone\menus\callmenu\frame.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	//--------------Callbutton------------------
	class callpicture: RscPicture
	{
		idc = 6641;
		text = "\A3PL_Common\phone\menus\callmenu\buttons\call.paa";
		x = 0.428595 * safezoneW + safezoneX;
		y = 0.685037 * safezoneH + safezoneY;
		w = 0.140312 * safezoneW;
		h = 0.0364814 * safezoneH;
	};
	class callbutton: RscButton
	{
		idc = 6642;
		text = "";
		x = 0.428595 * safezoneW + safezoneX;
		y = 0.685037 * safezoneH + safezoneY;
		w = 0.140312 * safezoneW;
		h = 0.0364814 * safezoneH;
		action = "";
		onMouseEnter = "ctrlSetText [6641, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\call.paa""];";
		onMouseExit = "CtrlSetText [6641, ""\A3PL_Common\phone\menus\callmenu\buttons\call.paa""];";
	};
	//--------------Button 1------------------
class onepicture: RscPicture
{
	idc = 6643;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\one.paa";
	x = 0.429219 * safezoneW + safezoneX;
	y = 0.413074 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class onebutton: RscButtonEmpty
{
	idc = 6644;
	text = "";
	x = 0.429219 * safezoneW + safezoneX;
	y = 0.413074 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6643, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\one.paa""];";
	onMouseExit = "CtrlSetText [6643, ""\A3PL_Common\phone\menus\callmenu\buttons\one.paa""];";
};
	//--------------Button 2------------------
class twopicture: RscPicture
{
	idc = 6645;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\two.paa";
	x = 0.478125 * safezoneW + safezoneX;
	y = 0.412963 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class twobutton: RscButtonEmpty
{
	idc = 6646;
	text = "";
	x = 0.478125 * safezoneW + safezoneX;
	y = 0.412963 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6645, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\two.paa""];";
	onMouseExit = "CtrlSetText [6645, ""\A3PL_Common\phone\menus\callmenu\buttons\two.paa""];";
};
	//--------------Button 3------------------
class threepicture: RscPicture
{
	idc = 6647;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\three.paa";
	x = 0.527604 * safezoneW + safezoneX;
	y = 0.412963 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class threebutton: RscButtonEmpty
{
	idc = 6648;
	text = "";
	x = 0.527604 * safezoneW + safezoneX;
	y = 0.412963 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6647, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\three.paa""];";
	onMouseExit = "CtrlSetText [6647, ""\A3PL_Common\phone\menus\callmenu\buttons\three.paa""];";
};
	//--------------Button 4------------------
class fourpicture: RscPicture
{
	idc = 6649;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\four.paa";
	x = 0.429323 * safezoneW + safezoneX;
	y = 0.476148 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class fourbutton: RscButtonEmpty
{
	idc = 6650;
	text = "";
	x = 0.429323 * safezoneW + safezoneX;
	y = 0.476148 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6649, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\four.paa""];";
	onMouseExit = "CtrlSetText [6649, ""\A3PL_Common\phone\menus\callmenu\buttons\four.paa""];";
};
	//--------------Button 5------------------
class fivepicture: RscPicture
{
	idc = 6651;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\five.paa";
	x = 0.478281 * safezoneW + safezoneX;
	y = 0.476148 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class fivebutton: RscButtonEmpty
{
	idc = 6652;
	text = "";
	x = 0.478281 * safezoneW + safezoneX;
	y = 0.476148 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6651, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\five.paa""];";
	onMouseExit = "CtrlSetText [6651, ""\A3PL_Common\phone\menus\callmenu\buttons\five.paa""];";
};
	//--------------Button 6------------------
class sixpicture: RscPicture
{
	idc = 6653;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\six.paa";
	x = 0.527604 * safezoneW + safezoneX;
	y = 0.475926 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class sixbutton: RscButtonEmpty
{
	idc = 6654;
	text = "";
	x = 0.527604 * safezoneW + safezoneX;
	y = 0.475926 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6653, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\six.paa""];";
	onMouseExit = "CtrlSetText [6653, ""\A3PL_Common\phone\menus\callmenu\buttons\six.paa""];";
};
	//--------------Button 7------------------
class sevenpicture: RscPicture
{
	idc = 6655;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\seven.paa";
	x = 0.428854 * safezoneW + safezoneX;
	y = 0.538333 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class sevenbutton: RscButtonEmpty
{
	idc = 6656;
	text = "";
	x = 0.428854 * safezoneW + safezoneX;
	y = 0.538333 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6655, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\seven.paa""];";
	onMouseExit = "CtrlSetText [6655, ""\A3PL_Common\phone\menus\callmenu\buttons\seven.paa""];";
};
	//--------------Button 8------------------
class eightpicture: RscPicture
{
	idc = 6657;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\eight.paa";
	x = 0.478333 * safezoneW + safezoneX;
	y = 0.53763 * safezoneH + safezoneY;
	w = 0.0412499 * safezoneW;
	h = 0.0504813 * safezoneH;
};
class eightbutton: RscButtonEmpty
{
	idc = 6658;
	text = "";
	x = 0.478333 * safezoneW + safezoneX;
	y = 0.53763 * safezoneH + safezoneY;
	w = 0.0412499 * safezoneW;
	h = 0.0504813 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6657, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\eight.paa""];";
	onMouseExit = "CtrlSetText [6657, ""\A3PL_Common\phone\menus\callmenu\buttons\eight.paa""];";
};
	//--------------Button 9------------------
class ninepicture: RscPicture
{
	idc = 6659;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\nine.paa";
	x = 0.527082 * safezoneW + safezoneX;
	y = 0.537963 * safezoneH + safezoneY;
	w = 0.0422915 * safezoneW;
	h = 0.0495555 * safezoneH;
};
class ninebutton: RscButtonEmpty
{
	idc = 6661;
	text = "";
	x = 0.527082 * safezoneW + safezoneX;
	y = 0.537963 * safezoneH + safezoneY;
	w = 0.0422915 * safezoneW;
	h = 0.0495555 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6659, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\nine.paa""];";
	onMouseExit = "CtrlSetText [6659, ""\A3PL_Common\phone\menus\callmenu\buttons\nine.paa""];";
};
	//--------------Button 0------------------
class zeropicture: RscPicture
{
	idc = 6662;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\zero.paa";
	x = 0.478126 * safezoneW + safezoneX;
	y = 0.6 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class zerobutton: RscButtonEmpty
{
	idc = 6663;
	text = "";
	x = 0.478126 * safezoneW + safezoneX;
	y = 0.6 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6662, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\zero.paa""];";
	onMouseExit = "CtrlSetText [6662, ""\A3PL_Common\phone\menus\callmenu\buttons\zero.paa""];";
};
	//--------------star------------------
class starpicture: RscPicture
{
	idc = 6664;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\star.paa";
	x = 0.428906 * safezoneW + safezoneX;
	y = 0.599815 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
};
class starbutton: RscButtonEmpty
{
	idc = 6665;
	text = "";
	x = 0.428906 * safezoneW + safezoneX;
	y = 0.599815 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0495554 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6664, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\star.paa""];";
	onMouseExit = "CtrlSetText [6664, ""\A3PL_Common\phone\menus\callmenu\buttons\star.paa""];";
};
	//--------------Hashtag------------------
class hashpicture: RscPicture
{
	idc = 6666;
	text = "\A3PL_Common\phone\menus\callmenu\buttons\hash.paa";
	x = 0.527864 * safezoneW + safezoneX;
	y = 0.599926 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0504814 * safezoneH;
};
class hashbutton: RscButtonEmpty
{
	idc = 6667;
	text = "";
	x = 0.527864 * safezoneW + safezoneX;
	y = 0.599926 * safezoneH + safezoneY;
	w = 0.0417707 * safezoneW;
	h = 0.0504814 * safezoneH;
	action = "";
	onMouseEnter = "ctrlSetText [6666, ""\A3PL_Common\phone\menus\callmenu\buttons\selected\hash.paa""];";
	onMouseExit = "CtrlSetText [6666, ""\A3PL_Common\phone\menus\callmenu\buttons\hash.paa""];";
};

class RscText: RscText
{
	idc = 6668;
	x = 0.430391 * safezoneW + safezoneX;
	y = 0.33764 * safezoneH + safezoneY;
	w = 0.136979 * safezoneW;
	h = 0.0302221 * safezoneH;
	style = 0x02;
	sizeEx = "0.03 * safezoneH";
};
};
};

class contactsmenu
{
idd = 7732;
name= "life_key_chain";
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0]; if ((player getvariable ""A3PL_Call_Status"" select 1) != 0) exitwith {closedialog 0};";
onunload = "closedialog 0;";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0;";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = ""; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.254518 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.254778 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};	
	//--------------APPSTUFF------------------
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Valywo)
////////////////////////////////////////////////////////
class contactstext: RscText
{
	idc = 1000;
	text = "Contacts"; //--- ToDo: Localize;
	x = 0.417499 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.165 * safezoneW;
	h = 0.044 * safezoneH;
	style = ST_CENTER;  // defined constant
	
};
class listbox: RscListbox
{
	idc = 1500;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.346 * safezoneH + safezoneY;
	w = 0.149531 * safezoneW;
	h = 0.132 * safezoneH;
	sizeEx = "0.015 * safezoneH";
	onLbSelChanged = "[] call A3PL_Phone_SelContact";
};
class amountcontacts: RscText
{
	idc = 1001;
	text = "20/50"; //--- ToDo: Localize;
	x = 0.530937 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.0464063 * safezoneW;
	h = 0.011 * safezoneH;
	style = ST_RIGHT;  // defined constant
	sizeEx = "0.012 * safezoneH";
};
class callbtn: RscButton
{
	idc = 1600;
	text = "Call"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.489 * safezoneH + safezoneY;
	w = 0.04125 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.02 * safezoneH";
};
class textbtn: RscButton
{
	idc = 1601;
	text = "Text"; //--- ToDo: Localize;
	x = 0.479375 * safezoneW + safezoneX;
	y = 0.489 * safezoneH + safezoneY;
	w = 0.04125 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.02 * safezoneH";
};
class removebtn: RscButton
{
	idc = 1602;
	text = "remove"; //--- ToDo: Localize;
	x = 0.530937 * safezoneW + safezoneX;
	y = 0.489 * safezoneH + safezoneY;
	w = 0.04125 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.02 * safezoneH";
};
class Nameedit: RscEdit
{
	idc = 1400;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.522 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.022 * safezoneH;
};
class cellphonedit: RscEdit
{
	idc = 1401;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.022 * safezoneH;
};
class notesedit: RscEdit
{
	idc = 1403;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.588 * safezoneH + safezoneY;
	w = 0.144375 * safezoneW;
	h = 0.099 * safezoneH;
	style = 0x10;
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "notes"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.577 * safezoneH + safezoneY;
	w = 0.0567187 * safezoneW;
	h = 0.011 * safezoneH;
};
class RscText_1003: RscText
{
	idc = 1003;
	text = "150/150"; //--- ToDo: Localize;
	x = 0.515469 * safezoneW + safezoneX;
	y = 0.577 * safezoneH + safezoneY;
	w = 0.0567187 * safezoneW;
	h = 0.011 * safezoneH;
	style = ST_RIGHT;  // defined constant
	sizeEx = "0.012 * safezoneH";
};
class RscButton_1603: RscButton
{
	idc = 1603;
	text = "UPDATE"; //--- ToDo: Localize;
	x = 0.438125 * safezoneW + safezoneX;
	y = 0.698 * safezoneH + safezoneY;
	w = 0.04125 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.02 * safezoneH";
};
class RscButton_1604: RscButton
{
	idc = 1604;
	text = "CREATE"; //--- ToDo: Localize;
	x = 0.515469 * safezoneW + safezoneX;
	y = 0.698 * safezoneH + safezoneY;
	w = 0.04125 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.02 * safezoneH";
};
class RscText_1004: RscText
{
	idc = 1004;
	text = "Name"; //--- ToDo: Localize;
	x = 0.510312 * safezoneW + safezoneX;
	y = 0.522 * safezoneH + safezoneY;
	w = 0.0567187 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.015 * safezoneH";
};
class RscText_1005: RscText
{
	idc = 1005;
	text = "Cellphone number"; //--- ToDo: Localize;
	x = 0.510312 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.015 * safezoneH";
};
};
};

class smsmenu
{
idd = 75522;
name= "life_key_chain";
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "closedialog 0;";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0;";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = ""; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.254518 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.254778 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};	
	//--------------APPSTUFF------------------
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Valywo)
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Tiqoru)
////////////////////////////////////////////////////////
class messagestext: RscText
{
	idc = 1145;
	text = "Messages"; //--- ToDo: Localize;
	x = 0.4175 * safezoneW + safezoneX;
	y = 0.28 * safezoneH + safezoneY;
	w = 0.165 * safezoneW;
	h = 0.033 * safezoneH;
	sizeEx = "0.03 * safezoneH";
	style = ST_CENTER;  // defined constant
	
};
class Listbox: RscListbox
{
	idc = 1500;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.324 * safezoneH + safezoneY;
	w = 0.154687 * safezoneW;
	h = 0.341 * safezoneH;
};
class OpenButton: RscButton
{
	idc = 1600;
	text = "Open"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.033 * safezoneH;
};
class DeleteButton: RscButton
{
	idc = 1909;
	text = "Delete"; //--- ToDo: Localize;
	x = 0.510312 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.033 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

};
};

class smsmessagemenu
{
idd = 751282;
name= "life_key_chain";
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "closedialog 0;";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0;";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = ""; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.254518 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.254778 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};	
	//--------------APPSTUFF------------------
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Zannaza, v1.063, #Valywo)
////////////////////////////////////////////////////////
class messagestext: RscText
{
	idc = 1145;
	text = "Messages"; //--- ToDo: Localize;
	x = 0.4175 * safezoneW + safezoneX;
	y = 0.28 * safezoneH + safezoneY;
	w = 0.165 * safezoneW;
	h = 0.033 * safezoneH;
	sizeEx = "0.03 * safezoneH";
	style = ST_CENTER;  // defined constant
};
class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.324 * safezoneH + safezoneY;
	w = 0.154687 * safezoneW;
	h = 0.275 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
	sizeEx = "0.015 * safezoneH";
};
class RscEdit_1400: RscEdit
{
	idc = 1400;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.61 * safezoneH + safezoneY;
	w = 0.144375 * safezoneW;
	h = 0.066 * safezoneH;
	sizeEx = "0.015 * safezoneH";
	style = 0x10;
};
class RscButton_1601: RscButton
{
	idc = 1601;
	text = "Cancel"; //--- ToDo: Localize;
	x = 0.510312 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.033 * safezoneH;
};
class RscButton_1602: RscButton
{
	idc = 1602;
	text = "Send"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.033 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
};
};

class settingsmenu
{
idd = 751991;
name= "life_key_chain";
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "closedialog 0;";
objects[] = { };
class controls {
	class mainframe: RscPicture
	{
		idc = 5520;
		text = "\A3PL_Common\phone\base\blackphone.paa";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class background: RscPicture
	{
		idc = 5521;
		text = "";
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.433125 * safezoneW;
		h = 0.737 * safezoneH;
	};
	class backbutton: RscButtonEmpty
	{
		idc = 5522;
		text = "";
		x = 0.486078 * safezoneW + safezoneX;
		y = 0.75498 * safezoneH + safezoneY;
		w = 0.02625 * safezoneW;
		h = 0.0466666 * safezoneH;
		action = "closedialog 0;";
	};
	//--------------HEADER------------------
	class batterypic: RscPicture
	{
		idc = 5523;
		text = "";
		x = 0.564427 * safezoneW + safezoneX;
		y = 0.252444 * safezoneH + safezoneY;
		w = 0.0144271 * safezoneW;
		h = 0.011 * safezoneH;
	};
	class precentage: RscText
	{
		idc = 5524;
		text = ""; //--- ToDo: Localize;
		x = 0.544427 * safezoneW + safezoneX;
		y = 0.254518 * safezoneH + safezoneY;
		w = 0.0195833 * safezoneW;
		h = 0.011 * safezoneH;
		style = ST_RIGHT;  // defined constant
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class time: RscText
	{
		idc = 5525;
		text = ""; //--- ToDo: Localize;
		x = 0.508229 * safezoneW + safezoneX;
		y = 0.254296 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connection: RscText
	{
		idc = 5526;
		text = "Z-MOBILE 4G"; //--- ToDo: Localize;
		x = 0.445835 * safezoneW + safezoneX;
		y = 0.254778 * safezoneH + safezoneY;
		w = 0.061875 * safezoneW;
		h = 0.011 * safezoneH;
		sizeEx = 0.7 * GUI_GRID_H;
	};
	class connectdot1: RscPicture
	{
		idc = 5527;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.419792 * safezoneW + safezoneX;
		y = 0.255556 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot2: RscPicture
	{
		idc = 5528;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.42552 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot3: RscPicture
	{
		idc = 5529;
		text = "\A3PL_Common\phone\base\connection.paa";
		x = 0.431406 * safezoneW + safezoneX;
		y = 0.255222 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot4: RscPicture
	{
		idc = 5530;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.436979 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};
	class connectdot5: RscPicture
	{
		idc = 5531;
		text = "\A3PL_Common\phone\base\noconnection.paa";
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.255555 * safezoneH + safezoneY;
		w = 0.004125 * safezoneW;
		h = 0.00637039 * safezoneH;
	};	
	//--------------APPSTUFF------------------

/* #Nafebi
$[
	1.063,
	["source",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"Settings",["0.4175 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.165 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","1.5"],[]],
	[1201,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.402031 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.211406 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1202,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.355625 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.061875 * safezoneW","0.517 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1204,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.4175 * safezoneW + safezoneX","0.742 * safezoneH + safezoneY","0.170156 * safezoneW","0.121 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"",[1,"Save",["0.427812 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.0670312 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"",[1,"Close",["0.505156 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.0670312 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"Your cellphone number is: 6969695",["0.417499 * safezoneW + safezoneX","0.335 * safezoneH + safezoneY","0.170156 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Background:",["0.422656 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2100,"",[1,"",["0.489688 * safezoneW + safezoneX","0.379 * safezoneH + safezoneY","0.0825 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2800,"checkbox_twitter",[1,"",["0.546406 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"",[1,"Show Twitter on HUD:",["0.422656 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1004,"",[1,"Grass draw:",["0.422656 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0567187 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1900,"",[1,"",["0.479374 * safezoneW + safezoneX","0.445 * safezoneH + safezoneY","0.0928125 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2801,"checkbox_hud",[1,"",["0.546406 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1005,"static_hudenabled",[1,"HUD enabled:",["0.422656 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1006,"",[1,"Hide hintbox notifications:",["0.422656 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2802,"hintboxnot_checkb",[1,"",["0.546406 * safezoneW + safezoneX","0.467 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.587656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.061875 * safezoneW","0.517 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1007,"",[1,"Twitter text:",["0.422656 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1008,"",[1,"Twitter icon:",["0.422656 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.0670312 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2102,"twittericon",[1,"",["0.489687 * safezoneW + safezoneX","0.512389 * safezoneH + safezoneY","0.0824999 * safezoneW","0.0206111 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2101,"twittertext",[1,"",["0.489687 * safezoneW + safezoneX","0.489 * safezoneH + safezoneY","0.0825 * safezoneW","0.021537 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/



class contactstext: RscText
{
	idc = 1000;
	text = "Settings"; //--- ToDo: Localize;
	x = 0.417499 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.165 * safezoneW;
	h = 0.044 * safezoneH;
	style = ST_CENTER;  // defined constant
};
class RscButton_1600: RscButton
{
	idc = 1600;
	text = "Save"; //--- ToDo: Localize;
	x = 0.427812 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.0670312 * safezoneW;
	h = 0.033 * safezoneH;
};
class RscButton_1601: RscButton
{
	idc = 1601;
	text = "Close"; //--- ToDo: Localize;
	x = 0.505156 * safezoneW + safezoneX;
	y = 0.687 * safezoneH + safezoneY;
	w = 0.0670312 * safezoneW;
	h = 0.033 * safezoneH;
};
class RscText_1001: RscText
{
	idc = 1001;
	text = "Your cellphone number is: 6969695"; //--- ToDo: Localize;
	x = 0.417499 * safezoneW + safezoneX;
	y = 0.335 * safezoneH + safezoneY;
	w = 0.170156 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = 0.0175 * safezoneH;
	style = ST_CENTER;  // defined constant
};
class RscText_1002: RscText
{
	idc = 1002;
	text = "Background:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.379 * safezoneH + safezoneY;
	w = 0.0670312 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscCombo_2100: RscCombo
{
	idc = 2100;
	x = 0.489688 * safezoneW + safezoneX;
	y = 0.379 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.022 * safezoneH;
};
class checkbox_twitter: RscCheckbox
{
	idc = 2800;
	x = 0.546406 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.0154688 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscText_1003: RscText
{
	idc = 1003;
	text = "Show Twitter on HUD:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.118594 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscSlider_1900: RscSlider
{
	idc = 1900;
	x = 0.479374 * safezoneW + safezoneX;
	y = 0.445 * safezoneH + safezoneY;
	w = 0.0928125 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscText_1004: RscText
{
	idc = 1004;
	text = "Grass draw:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.445 * safezoneH + safezoneY;
	w = 0.0567187 * safezoneW;
	h = 0.022 * safezoneH;
};
class checkbox_hud: RscCheckbox
{
	idc = 2801;
	x = 0.546406 * safezoneW + safezoneX;
	y = 0.401 * safezoneH + safezoneY;
	w = 0.0154688 * safezoneW;
	h = 0.022 * safezoneH;
};
class static_hudenabled: RscText
{
	idc = 1005;
	text = "HUD enabled:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.401 * safezoneH + safezoneY;
	w = 0.118594 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscText_1006: RscText
{
	idc = 1006;
	text = "Hide hintbox notifications:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.467 * safezoneH + safezoneY;
	w = 0.118594 * safezoneW;
	h = 0.022 * safezoneH;
};
class hintboxnot_checkb: RscCheckbox
{
	idc = 2802;
	x = 0.546406 * safezoneW + safezoneX;
	y = 0.467 * safezoneH + safezoneY;
	w = 0.0154688 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscText_1007: RscText
{
	idc = 1007;
	text = "Twitter text:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.489 * safezoneH + safezoneY;
	w = 0.0670312 * safezoneW;
	h = 0.022 * safezoneH;
};
class RscText_1008: RscText
{
	idc = 1008;
	text = "Twitter icon:"; //--- ToDo: Localize;
	x = 0.422656 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.0670312 * safezoneW;
	h = 0.022 * safezoneH;
};
class twittericon: RscCombo
{
	idc = 2102;
	x = 0.489687 * safezoneW + safezoneX;
	y = 0.512389 * safezoneH + safezoneY;
	w = 0.0824999 * safezoneW;
	h = 0.0206111 * safezoneH;
};
class twittertext: RscCombo
{
	idc = 2101;
	x = 0.489687 * safezoneW + safezoneX;
	y = 0.489 * safezoneH + safezoneY;
	w = 0.0825 * safezoneW;
	h = 0.021537 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

};
};

/* #Kywero
$[
	1.063,
	["ActiveCallScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"",[1,"",["0.422656 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.159844 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"",[1,"255-2392",["0.438125 * safezoneW + safezoneX","0.291 * safezoneH + safezoneY","0.12375 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1609,"",[1,"Bluetooth",["0.515469 * safezoneW + safezoneX","0.632 * safezoneH + safezoneY","0.0567187 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1613,"",[1,"End Call",["0.432969 * safezoneW + safezoneX","0.676 * safezoneH + safezoneY","0.139219 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"",[1,"Status...",["0.438125 * safezoneW + safezoneX","0.346 * safezoneH + safezoneY","0.12375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class Dialog_Phone_Incoming
{
	idd = 5005;
	movingEnable = 0;
	enableSimulation = 1;
	onLoad = "";
	onUnload = "";
	class controls
	{
		class RscText_1000: RscText
		{
			idc = 1000;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.484 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class RscText_1001: RscText
		{
			idc = 1001;
			text = ""; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscText_1002: RscText
		{
			idc = 1002;
			text = "Incoming Call..."; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscButton_1613: RscButton
		{
			idc = 1613;
			text = "Answer Call"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[] call A3PL_Phone_AnswerCall;";
			sizeEx = "0.015 * safezoneH";
		};
	};
	
};

