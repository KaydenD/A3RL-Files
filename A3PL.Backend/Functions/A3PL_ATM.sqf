//handles setup of the atm/bank dialog
['A3PL_ATM_Open', {
	private ['_bankBalance', '_cashBalance', '_index'];

	_bankBalance = player getVariable ['Player_Bank',0];
	_cashBalance = call A3PL_Inventory_GetCash; //should prevent withdrawing and account for factory usage

	['Dialog_ATM'] call A3PL_Lib_CreateDialog;

	//setup text
	ctrlSetText [4974, [_bankBalance, 1, 0, true] call CBA_fnc_formatNumber]; //[_bankBalance] call A3PL_Lib_FormatNumber];
	ctrlSetText [4975, [_cashBalance, 1, 0, true] call CBA_fnc_formatNumber]; //[_cashBalance] call A3PL_Lib_FormatNumber];
	ctrlSetText [5372, '0'];

	//setup buttons
	buttonSetAction [5572, "call A3PL_ATM_Deposit"];
	buttonSetAction [5573, "call A3PL_ATM_Withdraw"];
	buttonSetAction [5575, "call A3PL_ATM_Transfer"];
	buttonSetAction [5574, "[0] call A3PL_Lib_CloseDialog"];

	//creates list of players online - for transfer option
	{
		_index = lbAdd [5472, format["%1 (%2)", name _x, _x]];
		lbSetData [5472, _index, str _x];
	} forEach (allPlayers - [player]);
}] call Server_Setup_Compile;

//deposits money into bank account
['A3PL_ATM_Deposit', {
	private ['_amount', '_format'];

	_amount = round(parseNumber(ctrlText 5372));

	if (((TypeName _amount) != 'SCALAR') || (_amount <= 0)) exitWith {
		['Invalid Amount', Color_Red] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasCash)) exitWith {
		['Invalid Amount', Color_Red] call A3PL_Player_Notification;
	};

	[[player, 'Player_Cash', ((player getVariable 'Player_Cash') - _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
	[[player, 'Player_Bank', ((player getVariable 'Player_Bank') + _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	[0] call A3PL_Lib_CloseDialog;

	_format = format[localize "STR_A3PL_ATM_DEPOSITS", [_amount] call A3PL_Lib_FormatNumber];
	[_format, Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//withdraws money from bank account
['A3PL_ATM_Withdraw', {
	private ['_amount', '_format'];

	_amount = round(parseNumber(ctrlText 5372));

	if (((TypeName _amount) != 'SCALAR') || (_amount <= 0)) exitWith {
		['Invalid Amount', Color_Red] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWith {
		['Invalid Amount', Color_Red] call A3PL_Player_Notification;
	};

	[[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
	[[player, 'Player_Cash', ((player getVariable 'Player_Cash') + _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	[0] call A3PL_Lib_CloseDialog;

	_format = format[localize "STR_A3PL_ATM_WITHDRAWS", [_amount] call A3PL_Lib_FormatNumber];
	[_format, Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//transfers money to another account
//COMPILE BLOCK WARNING, A COPY THIS FUNCTION IS LOCATED ON A3PLS
['A3PL_ATM_Transfer', {
	private ['_amount', '_sendTo', '_sendToCompile', '_format'];

	_amount = round(parseNumber(ctrlText 5372));
	_sendTo = lbData [5472, (lbCurSel 5472)];
	_sendToCompile = call compile _sendTo;

	if (_sendToCompile isEqualTo player) exitWith {
		[localize "STR_A3PL_ATM_SELFT", Color_Red] call A3PL_Player_Notification;
	};

	if (((lbCurSel 5472) == -1) || (_amount <= 0)) exitWith {
		[localize "STR_A3PL_ATM_INVALID", Color_Red] call A3PL_Player_Notification;
	};

	if (!([_amount] call A3PL_Player_HasBank)) exitWIth {
		[localize "STR_A3PL_ATM_INSUFFICENT", Color_Red] call A3PL_Player_Notification;
	};

	//todo transfer notification

	[[player, 'Player_Bank', ((player getVariable 'Player_Bank') - _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;
	[[_sendToCompile, 'Player_Bank', ((_sendToCompile getVariable 'Player_Bank') + _amount)], 'Server_Core_ChangeVar', false] call BIS_fnc_MP;

	//todo send message to reciever

	_format = format[localize "STR_A3PL_ATM_TRANSFERS", [_amount] call A3PL_Lib_FormatNumber, (name _sendTo)];
	[_format, Color_Green] call A3PL_Player_Notification;

	[0] call A3PL_Lib_CloseDialog;
},false,true] call Server_Setup_Compile;
