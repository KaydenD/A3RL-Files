class A3PL_Open_PBLobby
{
idd = 321738;
movingEnable = true;
enableSimulation = true;
duration = 500000;
onLoad = "uiNamespace setVariable [""cellphone"", _this select 0];";
onunload = "";
objects[] = { };
class controls {
	class playerlist: RscListbox
	{
		idc = 1500;
		x = 0.515469 * safezoneW + safezoneX;
		y = 0.379 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.286 * safezoneH;
	};
	class grouplist: RscListbox
	{
		idc = 1501;
		x = 0.345312 * safezoneW + safezoneX;
		y = 0.379 * safezoneH + safezoneY;
		w = 0.159844 * safezoneW;
		h = 0.11 * safezoneH;
	};
	class RscButton_1601: RscButton
	{
		idc = 1601;
		text = "START GAME"; //--- ToDo: Localize;
		x = 0.62375 * safezoneW + safezoneX;
		y = 0.61 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class RscButton_1602: RscButton
	{
		idc = 1602;
		text = "KICK PLAYER"; //--- ToDo: Localize;
		x = 0.62375 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class RscButton_1603: RscButton
	{
		idc = 1603;
		text = "BAN PLAYER"; //--- ToDo: Localize;
		x = 0.62375 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = "Need atleast 4 players to start"; //--- ToDo: Localize;
		x = 0.510312 * safezoneW + safezoneX;
		y = 0.357 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscButton_1600: RscButton
	{
		idc = 1600;
		text = "LEAVE & DISBAND"; //--- ToDo: Localize;
		x = 0.62375 * safezoneW + safezoneX;
		y = 0.39 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class joingroupbtn: RscButton
	{
		idc = 1604;
		text = ""; //--- ToDo: Localize;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class RscText_1001: RscText
	{
		idc = 1001;
		text = ""; //--- ToDo: Localize;
		x = 0.592813 * safezoneW + safezoneX;
		y = 0.665 * safezoneH + safezoneY;
		w = 0.0257812 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class RscButton_1605: RscButton
	{
		idc = 1605;
		text = "CREATE GROUP"; //--- ToDo: Localize;
		x = 0.422656 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.0773437 * safezoneW;
		h = 0.044 * safezoneH;
	};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
};
};
