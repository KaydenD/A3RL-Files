class Dialog_HUD_Cellphone
{
	idd = -1;
	duration = 1e+012;
	onLoad = "uiNamespace setVariable [""Dialog_Cellphone_HUD"", _this select 0]";
	class Controls
	{
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\A3PL_Common\phone\base\blackphone.paa";
			x = 0.850625 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;
			text = "";
			x = 0.850625 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.165 * safezoneW;
			h = 0.264 * safezoneH;
		};
		class chat: RscStructuredText
		{
			idc = 1100;
			x = 0.902187 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.176 * safezoneH;
		};
	};
};