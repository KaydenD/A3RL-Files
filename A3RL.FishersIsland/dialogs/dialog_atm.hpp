class Dialog_ATM {
	idd = -1;
	name= "Dialog_ATM";
	movingEnable = false;
	enableSimulation = true;
	controls[]=
	{
		background,
		text1,
		text2,
		buttonDeposit,
		buttonWithdraw,
		buttonClose,
		buttonTransfer,
		textBank,
		textCash,
		listBox,
		editBox
	};

	class background: RscPicture
	{
		idc = IDC_DIALOG_ATM_BACKGROUND;
		text = "#(argb,8,8,3)color(0,0,0,0.8)";
		x = 0.2 * safezoneW + safezoneX;
		y = 0.16 * safezoneH + safezoneY;
		w = 0.6 * safezoneW;
		h = 0.44 * safezoneH;
	};
	class text1: RscText
	{
		idc = IDC_DIALOG_ATM_TEXT1;
		text = "Account Balance:"; //--- ToDo: Localize;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class text2: RscText
	{
		idc = IDC_DIALOG_ATM_TEXT2;
		text = "Cash:"; //--- ToDo: Localize;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class buttonDeposit: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONDEPOSIT;
		text = "Deposit"; //--- ToDo: Localize;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class buttonWithdraw: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONWITHDRAW;
		text = "Withdraw"; //--- ToDo: Localize;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class buttonClose: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONCLOSE;
		text = "Close"; //--- ToDo: Localize;
		x = 0.525 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class buttonTransfer: RscButton
	{
		idc = IDC_DIALOG_ATM_BUTTONTRANSFER;
		text = "Transfer"; //--- ToDo: Localize;
		x = 0.525 * safezoneW + safezoneX;
		y = 0.44 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class textBank: RscText
	{
		idc = IDC_DIALOG_ATM_TEXTBANK;
		text = "%1"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class textCash: RscText
	{
		idc = IDC_DIALOG_ATM_TEXTCASH;
		text = "%1"; //--- ToDo: Localize;
		x = 0.35 * safezoneW + safezoneX;
		y = 0.28 * safezoneH + safezoneY;
		w = 0.125 * safezoneW;
		h = 0.04 * safezoneH;
	};
	class listBox: RscListbox
	{
		idc = IDC_DIALOG_ATM_LISTBOX;
		x = 0.525 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.2 * safezoneH;
	};
	class editBox: RscEdit
	{
		idc = IDC_DIALOG_ATM_EDITBOX;
		x = 0.225 * safezoneW + safezoneX;
		y = 0.36 * safezoneH + safezoneY;
		w = 0.25 * safezoneW;
		h = 0.04 * safezoneH;
	};
};












/* #Somehy
$[
	1.063,
	["Dialog_ATM",[["safezoneX","safezoneY","safezoneW","safezoneH"],"safezoneW / 40","safezoneH / 25","GUI_GRID"],0,1,0],
	[1200,"background",[1,"#(argb,8,8,3)color(0,0,0,0.8)",["0.2 * safezoneW + safezoneX","0.16 * safezoneH + safezoneY","0.6 * safezoneW","0.44 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"text1",[1,"Account Balance:",["0.225 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.1125 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"text2",[1,"Cash:",["0.225 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.1125 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"buttonDeposit",[1,"Deposit",["0.225 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.25 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"buttonWithdraw",[1,"Withdraw",["0.225 * safezoneW + safezoneX","0.52 * safezoneH + safezoneY","0.25 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1602,"buttonClose",[1,"Close",["0.525 * safezoneW + safezoneX","0.52 * safezoneH + safezoneY","0.25 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1603,"buttonTransfer",[1,"Transfer",["0.525 * safezoneW + safezoneX","0.44 * safezoneH + safezoneY","0.25 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"textBank",[1,"%1",["0.35 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.125 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"textCash",[1,"%1",["0.35 * safezoneW + safezoneX","0.28 * safezoneH + safezoneY","0.125 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"listBox",[1,"",["0.525 * safezoneW + safezoneX","0.2 * safezoneH + safezoneY","0.25 * safezoneW","0.2 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1400,"editBox",[1,"",["0.225 * safezoneW + safezoneX","0.36 * safezoneH + safezoneY","0.25 * safezoneW","0.04 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
