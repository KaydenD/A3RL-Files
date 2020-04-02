class Dialog_CarShop {
	idd = 20;
	name= "Dialog_CarShop";
	movingEnable = false;
	enableSimulation = true;
	controls[]=
	{
		background,
		itemNameText,
		amountText,
		amountEdit,
		priceText,
		priceValueText,
		purchaseButton,
		closeButton,
		button_sell,
		stockText,
		stockValueText,
		static_textColour,
		combo_colour
		
	};
	
	class background: RscPicture
	{
		idc = IDC_DIALOG_SHOP_BACKGROUND;
		text = "#(argb,8,8,3)color(0,0,0,0.8)";
		x = 0.325 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.35 * safezoneW;
		h = 0.56 * safezoneH;
	};	

	class itemNameText: RscStructuredText
	{
		idc = IDC_DIALOG_SHOP_ITEMNAMETEXT;
		text = "Water Bottle"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.32 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class amountText: RscText
	{
		idc = IDC_DIALOG_SHOP_AMOUNTTEXT;
		text = "Amount:"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.48 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class amountEdit: RscEdit
	{
		idc = IDC_DIALOG_SHOP_AMOUNTEDIT;
		text = "1"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.48 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class priceText: RscText
	{
		idc = IDC_DIALOG_SHOP_PRICETEXT;
		text = "Price:"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.4 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class priceValueText: RscText
	{
		idc = IDC_DIALOG_SHOP_PRICEVALUETEXT;
		text = "%1"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.4 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class purchaseButton: RscButton
	{
		idc = IDC_DIALOG_SHOP_PURCHASEBUTTON;
		text = "Purchase Vehicle"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.68 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class button_sell: RscButton
	{
		idc = 1602;
		text = "Deliver vehicle"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.7192 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.040926 * safezoneH;
	};	
	
	class closeButton: RscButton
	{
		idc = IDC_DIALOG_SHOP_CLOSEBUTTON;
		text = "Close"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.76 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class stockText: RscText
	{
		idc = IDC_DIALOG_SHOP_STOCKTEXT;
		text = "Stock:"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class stockValueText: RscText
	{
		idc = IDC_DIALOG_SHOP_STOCKVALUETEXT;
		text = "%1"; //--- ToDo: Localize;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.6 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.04 * safezoneH;
	};
	
	class combo_colour: RscCombo
	{
		idc = 2100;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.56 * safezoneH + safezoneY;
		w = 0.15 * safezoneW;
		h = 0.02 * safezoneH;
	};
	
	class static_textColour: RscText
	{
		idc = 1005;
		text = "Colour:"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.56 * safezoneH + safezoneY;
		w = 0.05 * safezoneW;
		h = 0.02 * safezoneH;
	};	
	
};