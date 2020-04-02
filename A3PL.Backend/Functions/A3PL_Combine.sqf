["A3PL_Combine_Open",
{
	disableSerialization;
	private ["_display","_control"];
	createDialog "Dialog_CombineItems";
	_display = findDisplay 9;
	_control = _display displayCtrl 1500;
	_items = param [0,["burger_full_cooked","taco_cooked"]]; //the items we can craft at this location

	//fill the list with itmes we can make here
	{
		private ["_name","_index"];
		_name = [_x,"name"] call A3PL_Config_GetItem;
		_index = _control lbAdd _name;
		_control lbSetData [_index,_x];
	} foreach _items;

	//when we click an item update the required items for this
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_selectedIndex","_class","_required","_output","_control"];
		_selectedIndex = param [1,-1];
		_control = param [0,ctrlNull];
		if (_selectedIndex < 0) exitwith {}; //no index selected
		_class = _control lbData (lbCurSel _control);

		_required = [];
		{
			if ((_x select 0) == _class) exitwith {_required = _x select 1; _output = _x select 2;};
		} foreach Config_CombineItems;
		if (count _required < 1) exitwith {};

		//set some vars so we can check what is required and what we are crafting
		A3PL_Combine_ItemSelected = _class;
		A3PL_Combine_ItemRequired = _required;

		//fill the required listbox with the items required
		_control = (findDisplay 9) displayCtrl 1501;
		lbClear _control;
		{
			private ["_index"];
			_index = _control lbAdd ([_x,"name"] call A3PL_Config_GetItem);
			_control lbSetData [_index,_x];

			if ([_x] call A3PL_Inventory_Has) then
			{
				_control lbSetColor [_index,[0, 1, 0, 1]];
			} else
			{
				_control lbSetColor [_index,[1, 0, 0, 1]];
			};
		} foreach _required;
	}];

	//when we click the combine button
	_control = _display displayCtrl 1600;
	_control ctrlAddEventHandler ["ButtonDown",
	{
		[] call A3PL_Combine_Create;
	}];
}] call Server_Setup_Compile;

["A3PL_Combine_Create",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};

	private ["_creating","_required","_haveItems","_amount","_output"];
	_creating = A3PL_Combine_ItemSelected;
	_required = A3PL_Combine_ItemRequired;

	//get the amount
	_control = ctrlText ((findDisplay 9) displayCtrl 1400);
	_amount = parseNumber _control;
	if (_amount < 1) exitwith {[localize "STR_A3PL_COMBINE_VALIDNUM",Color_Red] call A3PL_Player_Notification;};

	//check if we have everything required
	_haveItems = true;
	{
		if (!([_x,_amount] call A3PL_Inventory_Has)) exitwith {_haveItems = false};
	} foreach _required;
	if (!_haveItems) exitwith {[localize "STR_A3PL_COMBINE_NOITEMS",Color_Red] call A3PL_Player_Notification;};


	//take all the items
	{
		[_x,-(_amount)] call A3PL_Inventory_Add;
	} foreach _required;

	//get the output amount
	_output = 0;
	{
		if ((_x select 0) == _creating) exitwith {_output = _x select 2};
	} foreach Config_CombineItems;
	if (_output < 1) exitwith {["System Error: Unable to set _output in A3PL_Combine_Create"] call A3PL_Player_Notification;};

	//add the item
	[_creating,_amount] call A3PL_Inventory_Add;

	[format [localize "STR_A3PL_COMBINE_SUCCESS",([_creating,"name"] call A3PL_Config_GetItem),_amount],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;
