#define RENTMINTIME 1
#define RENTMAXTIME 720
#define RENTCOSTPERMIN 20
#define MinBPriceDefault 0
#define MaxBPriceDefault 900000
#define BMinBPriceDefault 0
#define BMaxBPriceDefault 900000
#define BUSINESSOBJS ["Land_A3PL_Showroom","Land_A3PL_Garage","Land_A3PL_Cinema","Land_A3PL_Gas_Station","land_smallshop_ded_smallshop_02_f","land_smallshop_ded_smallshop_01_f"]
//Buy business
["A3PL_Business_Buy",
{
	disableSerialization;
	private ["_display","_control","_name","_business"];
	_business = param [0,cursorObject];
	if (typeOf _business == "Land_A3PL_BusinessSign") then
	{
		_business = (nearestObjects [_business,BUSINESSOBJS,50]) select 0; //find first business
	};
	if (isNil "_business") exitwith {["System Error: _business isNil in Business_Buy (Unable to determine business object)"] call A3PL_Player_Notification;};
	if (isNull _business) exitwith {["System Error: _business isNull in Business_Buy (Unable to determine business object)"] call A3PL_Player_Notification;};

	[format [localize "STR_A3PL_BUSINESS_INFO",RENTMAXTIME],Color_Green] call A3PL_Player_Notification;

	//setup slider
	createDialog "Dialog_BusinessRent";
	_display = findDisplay 57;
	_display displayAddEventHandler ["KeyUp",{_this call A3PL_Business_BuySlider}]; //keyUp to display
	_control = _display displayCtrl 1900;
	_control sliderSetRange [RENTMINTIME, RENTMAXTIME];
	_control ctrlAddEventHandler ["SliderPosChanged",{_this call A3PL_Business_BuySlider}];

	//setup buttons
	_control = _display displayCtrl 1600;
	_control buttonSetAction "[] call A3PL_Business_Rent";
	_control = _display displayCtrl 1601;
	_control buttonSetAction "closeDialog 0;";
}] call Server_Setup_Compile;

["A3PL_Business_Rent",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam
	private ["_display","_control","_name","_business","_sign","_sControl","_rentTime","_rentCost"];
	_sign = param [0,cursorObject];
	if (typeOf _sign == "Land_A3PL_BusinessSign") then
	{
		_business = (nearestObjects [_sign,BUSINESSOBJS,50]) select 0; //find first business
	};
	if (isNil "_business") exitwith {["System Error: _business isNil in Business_Rent (Unable to determine business object)"] call A3PL_Player_Notification;};
	if (isNull _business) exitwith {["System Error: _business isNull in Business_Rent (Unable to determine business object)"] call A3PL_Player_Notification;};
	_display = findDisplay 57;
	_control = _display displayCtrl 1400;
	_name = ctrlText _control; //business name entered

	//parse business name
	if (count _name < 5) exitwith {[localize "STR_A3PL_BUSINESS_MINNAME"] call A3PL_Player_Notification;};
	if (count _name > 30) exitwith {[localize "STR_A3PL_BUSINESS_MAXNAME"] call A3PL_Player_Notification;};

	//get info that we selected
	_display = findDisplay 57;
	_sControl = _display displayCtrl 1900;
	_rentTime = round (sliderPosition _sControl);
	_rentCost = _rentTime * RENTCOSTPERMIN;

	if (((player getVariable ["player_cash",0]) - _rentcost) < 0) exitwith {[localize "STR_A3PL_BUSINESS_INSUFFICENTF",Color_Red] call A3PL_Player_Notification};
	if (_business getVariable ["bOwner",""] != "") exitwith {[localize "STR_A3PL_BUSINESS_ALREADYO",Color_Red] call A3PL_Player_Notification;};

	[player,_business,_name,_rentTime,_rentCost,_sign] remoteExec ["Server_Business_Buy", 2];
	closeDialog 0;
	[localize "STR_A3PL_BUSINESS_SUCCESS",Color_Yellow] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//what happends if we move the slider on the buy menu
["A3PL_Business_BuySlider",
{
	disableSerialization;
	private ["_display","_control","_sControl"];
	_display = findDisplay 57;
	_sControl = _display displayCtrl 1900; //the slider control
	_control = _display displayCtrl 1400;
	_name = ctrlText _control; //business name entered
	_rentTime = round (sliderPosition _sControl);
	_rentCost = _rentTime * RENTCOSTPERMIN;

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t align='center'>%1<br/>Renting: %2 min<br/>Rent price: $%3</t>",_name,_rentTime,_rentCost];
}] call Server_Setup_Compile;

//stop renting a business, so other can buy
["A3PL_Business_Stop",
{

}] call Server_Setup_Compile;

/*
	END OF BUSINESS OWNERSHIP FUNCTIONS
*/

/*
	START OF ITEM SALE
*/

["A3PL_Business_Sell",
{
	disableSerialization;
	private ["_display","_control","_obj","_min","_max","_owner"];
	_obj = param [0,cursorObject];
	if (isNull _obj) exitwith {["System Error: _business isNull in Business_Buy (Unable to determine business object)"] call A3PL_Player_Notification;};

	_owner = _obj getVariable ["owner",nil];
	if (isNil "_owner") exitwith {["System: This item isn't owned by anyone (missing owner setVar)",Color_Red] call A3PL_Player_Notification; };
	if (typeName _owner == "ARRAY") then
	{
		_owner = _owner select 0;
	};
	if ((getPlayerUID player) != _owner) exitwith {[localize "STR_A3PL_BUSINESS_DONTOWN",Color_Red] call A3PL_Player_Notification;};

	createDialog "Dialog_ItemSale";
	_display = findDisplay 58;
	_display displayAddEventHandler ["KeyUp",{_this call A3PL_Business_SellSlider}]; //keyUp to display
	_display displayAddEventHandler ["Unload",{A3PL_MinBPrice = nil; A3PL_MaxBPrice = nil; A3PL_BMaxBPrice = nil; A3PL_BMinBPrice = nil; }]; //clear the globals we set below, we dont need to keep this in memory

	//setup buttons
	_control = _display displayCtrl 1600;
	_control buttonSetAction format ["['%1'] call A3PL_Business_SellItem;",_obj];
	_control = _display displayCtrl 1601;
	_control buttonSetAction format ["['%1'] call A3PL_Business_SellItemStop;",_obj];

	//check consumer by default
	_control = _display displayCtrl 2801;
	_control cbSetChecked true;

	//set min and max
	_control = _display displayCtrl 1900;
	A3PL_MinBPrice = [typeOf _obj,"min"] call A3PL_Config_GetBusinessItem; //globals, cause we use them in the ctrlAddEventhandler below
	A3PL_MaxBPrice = [typeOf _obj,"max"] call A3PL_Config_GetBusinessItem;
	A3PL_BMinBPrice = [typeOf _obj,"bmin"] call A3PL_Config_GetBusinessItem;
	A3PL_BMaxBPrice = [typeOf _obj,"bmax"] call A3PL_Config_GetBusinessItem;
	if ((typeName A3PL_MinBPrice) == "BOOL") then {A3PL_MinBPrice = MinBPriceDefault; A3PL_MaxBPrice = MaxBPriceDefault; A3PL_BMinBPrice = BMinBPriceDefault; A3PL_BMaxBPrice = BMaxBPriceDefault; }; //apply some default values
	_control sliderSetRange [A3PL_MinBPrice,A3PL_MaxBPrice];
	_control ctrlAddEventHandler ["SliderPosChanged",{_this call A3PL_Business_SellSlider}];

	//checked EH
	_control = _display displayCtrl 2800;
	_control ctrlAddEventHandler ["CheckedChanged",
	{
		disableSerialization;
		private ["_display","_control","_state"];
		_state = param [1,1];
		_display = findDisplay 58;
		if (_state == 1) then
		{
			_control = _display displayCtrl 2801;
			_control cbSetChecked false;//uncheck other
			_control = _display displayCtrl 1900;
			_control sliderSetRange [A3PL_BMinBPrice, A3PL_BMaxBPrice]; //set the slider range to new value
		} else
		{
			_control = _display displayCtrl 2800;
			_control cbSetChecked true;//check itself again
		};
		call A3PL_Business_SellSlider; //update text
	}]; //business
	_control = _display displayCtrl 2801;
	_control ctrlAddEventHandler ["CheckedChanged",
	{
		disableSerialization;
		private ["_display","_control","_state"];
		_state = param [1,1];
		_display = findDisplay 58;
		if (_state == 1) then
		{
			_control = _display displayCtrl 2800;
			_control cbSetChecked false;//uncheck other
			_control = _display displayCtrl 1900;
			_control sliderSetRange [A3PL_MinBPrice, A3PL_MaxBPrice]; //set the slider range to new value
		} else
		{
			_control = _display displayCtrl 2801;
			_control cbSetChecked true;//check itself
		};
		call A3PL_Business_SellSlider; //update text
	}]; //consumer
	call A3PL_Business_SellSlider;
}] call Server_Setup_Compile;

["A3PL_Business_SellSlider",
{
	disableSerialization;
	private ["_display","_control","_sControl","_price"];
	_display = findDisplay 58;
	_sControl = _display displayCtrl 1900; //the slider control
	_control = _display displayCtrl 1400;
	_name = ctrlText _control; //business name entered
	_price = round (sliderPosition _sControl);

	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["<t align='center'>Item desc.: %1<br/>Min price: $%2<br/>Max price: $%3<br/>Selling for: $%4</t>",_name,(sliderRange _sControl) select 0,(sliderRange _sControl) select 1,_price];
}] call Server_Setup_Compile;

["A3PL_Business_SellItem",
{
	disableSerialization;
	private ["_obj","_price","_display","_sControl","_name","_bFound","_bdist","_type","_bchecked"];
	_obj = param [0,objNull];
	if (typeName _obj == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		{
			_check = format ["%1",_x];
			if (_check == _obj) exitwith
			{
				_obj = _x;
			};
		} foreach (nearestObjects [player, [], 20]);
	};
	if (typeName _obj == "STRING") exitwith {["System: Error occured in Business_SellItem, could not retrieve object", Color_Red] call A3PL_Player_Notification;};

	_display = findDisplay 58;
	_control = _display displayCtrl 1400;
	_name = ctrlText _control;
	_sControl = _display displayCtrl 1900;
	_price = round (sliderPosition _sControl);
	if (count _name < 3) exitwith {[localize "STR_A3PL_BUSINESS_MINITEMDESC",Color_Red] call A3PL_Player_Notification;};
	if (count _name > 30) exitwith {[localize "STR_A3PL_BUSINESS_MAXITEMDESC",Color_Red] call A3PL_Player_Notification;};

	//check if we are near a business to sell this item at
	{
		if ((_x getVariable ["bOwner","0"]) == (getPlayerUID player)) exitwith {_bfound = _x};
	} foreach nearestObjects [player,[],40];
	_control = _display displayCtrl 2800;
	_bchecked = cbChecked _control; //whether business is checked or not
	if (isNil "_bfound" && !_bChecked) exitwith {[localize "STR_A3PL_BUSINESS_NOOWN",Color_Red] call A3PL_Player_Notification;};
	if (_bChecked && isNil "_bFound") then //we can still sell this to a business even if we dont own it, so lets see if we can find one
	{
		{
			if ((_x getVariable ["bOwner","0"]) != "0") exitwith {_bFound = _x;};
			if ((typeOf _x) IN ["Land_A3PL_Sheriffpd","Land_A3PL_Clinic","Land_A3PL_Firestation"]) exitwith {_bFound = _x;};
		} foreach nearestObjects [player,[],40];
	};
	if (isNil "_bFound") exitwith {[localize "STR_A3PL_BUSINESS_NOTCLOSE",Color_Red] call A3PL_Player_Notification;};

	switch (typeOf _bfound) do
	{
		case ("Land_A3PL_Showroom"): {_bDist = (player distance _bfound) < 40};
		case ("land_smallshop_ded_smallshop_02_f"): {_bDist = (player distance _bfound) < 10.1};
		case ("land_smallshop_ded_smallshop_01_f"): {_bDist = (player distance _bfound) < 10.1};
		case default {_bDist = (player distance _bfound) < 30};
	};
	if (!_bDist) exitwith {[localize "STR_A3PL_BUSINESS_NOTCLOSE",Color_Red] call A3PL_Player_Notification;};

	_type = [typeOf _obj,"type"] call A3PL_Config_GetBusinessItem;
	[player,_obj,_type,_bchecked,_name,_price] remoteExec ["Server_Business_Sellitem", 2];
	closeDialog 0;
	["System: You are now selling this item",Color_Green] call A3PL_Player_Notification;
	//player,object,object type,business?,item desc,price
}] call Server_Setup_Compile;

["A3PL_Business_SellItemStop",
{
	disableSerialization;
	private ["_obj","_bItem"];
	_obj = param [0,objNull];
	if (typeName _obj == "STRING") then //edited bypass used in ATC so we can send object from setButtonAction
	{
		{
			_check = format ["%1",_x];
			if (_check == _obj) exitwith
			{
				_obj = _x;
			};
		} foreach (nearestObjects [player, [], 20]);
	};
	if (typeName _obj == "STRING") exitwith {["System: Error occured in Business_SellItem, could not retrieve object", Color_Red] call A3PL_Player_Notification;};
	_bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {[localize "STR_A3PL_BUSINESS_NOTSOLD", Color_Red] call A3PL_Player_Notification;};
	if ((getPlayerUID player) != (_bItem select 3)) exitwith {[localize "STR_A3PL_BUSINESS_NOTPFORS", Color_Red] call A3PL_Player_Notification;};

	[_obj] remoteExec ["Server_Business_Sellitemstop", 2];
	closeDialog 0;
	[localize "STR_A3PL_BUSINESS_STOPSELLING",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
/*
	END OF ITEM SALE
*/

["A3PL_Business_BuyItemReceive",
{
	private ["_reply","_msg"];
	_reply = param [0,-1];
	_msg = ["Error: Undefined _reply in _BuyItemReceive",Color_Red];
	switch (_reply) do
	{
		case (0): {_msg = [format [localize "STR_A3PL_BUSINESS_SOLDITEM",(param [1,0])],Color_Green];};
		case (1): {_msg = [localize "STR_A3PL_BUSINESS_BOUGHTITEM",Color_Green];};
	};
	_msg call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Business_BuyItem",
{
	disableSerialization;
	private ["_display","_control","_obj","_bItem"];
	_obj = param [0,cursorobject];
	if (isNull _obj) exitwith {["System: Object is null in _BuyItem (Couldn't find item)",Color_Red] call A3PL_Player_Notification;};
	_bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {["System: This item isn't being sold (missing setVar)", Color_Red] call A3PL_Player_Notification;};
	createDialog "Dialog_ItemBuy";
	_display = findDisplay 59;
	_price = _bItem select 0;
	_name = _bItem select 1;

	_control = _display displayCtrl 1100; //set name and price on the dialog
	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center'>%1</t>",_name];
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["<t font='PuristaSemiBold' align='center'>$%1</t>",([_price, 1, 0, true] call CBA_fnc_formatNumber)];

	_control = _display displayCtrl 1601; //set button actions
	_control ButtonSetAction format ["['%1'] call A3PL_Business_BuyItemBuy",_obj];
	_control = _display displayCtrl 1602; //set button actions
	_control ButtonSetAction format ["['%1',true] call A3PL_Business_BuyItemBuy",_obj];
}] call Server_Setup_Compile;

//clicking the buy button
["A3PL_Business_BuyItemBuy",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_obj","_bItem","_hasMoney","_businessItem","_correctLoc","_factionItem","_finv"];
	_obj = [(param [0,""])] call A3PL_Lib_vehStringToObj;
	_factionBuy = param [1,false];
	if (typeName _obj == "STRING") exitwith {["System: Unable to determine object in _BuyItemBuy (report this)",Color_Red] call A3PL_Player_Notification;};
	_bItem = _obj getVariable ["bitem",nil];
	if (isNil "_bItem") exitwith {["System: This item isn't being sold (missing setVar)", Color_Red] call A3PL_Player_Notification;};
	_price = _bItem select 0;
	_name = _bItem select 1;
	_businessItem = _bItem select 2;
	_itemOwner = _bItem select 3;
	_finv = _obj getVariable ["finv",nil];
	_factionItem = !isNil "_finv";

	_hasMoney = false;

	//DELETE THIS LATER TO ENABLE FACTION BUY
	if (_factionBuy) exitwith {["System: Buying items with faction budget is temporarily disabled",Color_Red] call A3PL_Player_Notification;};
	if (_factionBuy) then
	{
		if (_price <= ([player] call A3PL_Government_MyFactionBalance)) then {_hasMoney = true;};
	} else
	{
		if (_price <= (player getVariable ["player_cash",0])) then {_hasMoney = true;};
	};
	if (!_hasMoney && !_factionBuy) exitwith {[localize "STR_A3PL_BUSINESS_NOMONEY", Color_Red] call A3PL_Player_Notification;};
	if (!_hasMoney && _factionBuy) exitwith {["System: Your faction doesn't have enough balance to purchase this item", Color_Red] call A3PL_Player_Notification;};

	_correctLoc = false;
	if (_factionBuy) then
	{
		switch (player getVariable ["faction","citizen"]) do
		{
			case ("ems"): {if ((count (nearestObjects [player, ["Land_A3PL_Clinic"], 20])) > 0) then {_correctLoc = true;};};
			case ("police"): {if ((count (nearestObjects [player, ["Land_A3PL_Sheriffpd"], 20])) > 0) then {_correctLoc = true;};};
			case ("fifr"): {if ((count (nearestObjects [player, ["Land_A3PL_Firestation"], 20])) > 0) then {_correctLoc = true;};};
		};
	} else
	{
		if (_businessItem) then
		{
			{
				if ((getPlayerUID player) == (_x getVariable ["bOwner","0"])) exitwith {_correctLoc = true};
			} foreach (nearestObjects [player, BUSINESSOBJS, 20]);
		} else
		{
			{
				if (_itemOwner == (_x getVariable ["bOwner","0"])) exitwith {_correctLoc = true};
			} foreach (nearestObjects [player, BUSINESSOBJS, 20]);
		};

	};

	if (!_correctLoc && _factionBuy) exitwith {["System: You are not near any of your faction buildings to buy this item", Color_Red] call A3PL_Player_Notification;};
	if (!_correctLoc && !_factionBuy && _businessItem && !_factionItem) exitwith {[localize "STR_A3PL_BUSINESS_NOTNEARSHOP", Color_Red] call A3PL_Player_Notification;};
	if (!_correctLoc && !_factionBuy && !_businessItem) exitwith {[localize "STR_A3PL_BUSINESS_NOTNEARSHOPB", Color_Red] call A3PL_Player_Notification;};

	[player,_obj,_factionBuy] remoteExec ["Server_Business_BuyItem", 2];
	[localize "STR_A3PL_BUSINESS_SENDREQUESTTOP",Color_Yellow] call A3PL_Player_Notification;
	closeDialog 0;
}] call Server_Setup_Compile;
