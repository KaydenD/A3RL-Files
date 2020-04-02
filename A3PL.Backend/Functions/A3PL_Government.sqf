#define CHARMAXLAWCOUNT 120
#define FACTIONBALANCES ["Sheriff Department","FIFR","USCG"]
#define FACTIONMINPAY 0
#define FACTIONMAXPAY 2000

["A3PL_Government_OpenTreasury",
{
	disableSerialization;
	private ["_display","_control","_totalBalance"];

	if (!(getPlayerUID player IN ["76561198042981718","76561198096687678","_SP_PLAYER_",((missionNameSpace getVariable ["A3PL_Mayor",["0"]]) select 0)])) exitwith {["System: You are not the mayor!",Color_Red] call A3PL_Player_Notification;};

	createDialog "Dialog_Treasury";
	_display = findDisplay 109;
	_totalBalance = 0;

	//set button actions
	_control = _display displayCtrl 1600; //set tax
	_control buttonSetAction "[] call A3PL_Government_SetTax;";
	_control = _display displayCtrl 1603; //add law
	_control buttonSetAction "[] call A3PL_Government_AddLaw;";
	_control = _display displayCtrl 1605; //remove law
	_control buttonSetAction "[] call A3PL_Government_RemoveLaw;";
	_control = _display displayCtrl 1602; //remove law
	_control buttonSetAction "[] call A3PL_Government_SetLaw;";
	_control = _display displayCtrl 1601; //remove law
	_control buttonSetAction "[] call A3PL_Government_AddBalance;";

	//fill balance combos
	_control = _display displayCtrl 2100;
	{
		if (!((_x select 0) IN FACTIONBALANCES)) then
		{
			private ["_balanceName","_balanceAmount"];
			_balanceName = _x select 0;
			_balanceAmount = _x select 1;
			_control lbAdd _balanceName;
			_totalBalance = _totalBalance + _balanceAmount;
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
	_control ctrlAddEventhandler ["LBSelChanged",
	{
		private ["_control","_display","_balance","_balanceAmount"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_balance = _control lbText (lbCurSel _control);
		_balanceAmount = 0;
		{
			if (_x select 0 == _balance) exitwith {_balanceAmount = _x select 1;};
		} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);
		_control = _display displayCtrl 1400;
		_control ctrlSetText (format ["$%1",([_balanceAmount, 1, 0, true] call CBA_fnc_formatNumber)]);
	}];

	//set balance total
	_control = _display displayCtrl 1402;
	_control ctrlSetText format ["$%1",([_totalBalance, 1, 0, true] call CBA_fnc_formatNumber)];

	//fill the taxes
	_control = _display displayCtrl 2101;
	{
		_control lbAdd (_x select 0);
	} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_control","_taxRate","_taxSelected","_display"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_taxSelected = _control lbText (lbCurSel _control);
		_taxRate = 0;
		{
			if (_x select 0 == _taxSelected) exitwith {_taxRate = _x select 1;};
		} foreach (missionNameSpace getVariable ["Config_Government_Taxes",[]]);
		_control = _display displayCtrl 1403;
		_control ctrlSetText format ["%1%2",_taxRate*100,"%"];
	}];

	//fill factions
	_control = _display displayCtrl 2102;
	{
		if ((_x select 0) IN FACTIONBALANCES) then
		{
			private ["_balanceName","_balanceAmount","_index"];
			_balanceName = format ["%1 (balance: $%2)",(_x select 0),([(_x select 1), 1, 0, true] call CBA_fnc_formatNumber)];
			_index = _control lbAdd _balanceName;
			_control lbSetData [_index,_x select 0];
		};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	//fill laws
	_control = _display displayCtrl 2103;
	{
		private ["_lawi"];
		_lawi = _forEachIndex + 1;
		_control lbAdd format ["Law %1",_lawi];
	} foreach (missionNameSpace getVariable ["Config_Government_Laws",[]]);

	_control ctrlAddEventHandler ["LBSelChanged",
	{
		private ["_control","_display"];
		_display = findDisplay 109;
		_control = param [0,ctrlNull];
		_law = Config_Government_Laws select (lbCurSel _control);
		_control = _display displayCtrl 1000; //set text to rscedit and rsctext
		_control ctrlSetText _law;
		_control = _display displayCtrl 1401;
		_control ctrlSetStructuredText parseText _law;
	}];
}] call Server_Setup_Compile;

["A3PL_Government_MyFactionBalance",
{
	private ["_player","_faction","_balanceAmount","_balance","_justName"];
	_player = param [0,player];
	_justName = param [1,false]; //if we dont want the balance, but the name of the balance
	_faction = _player getVariable ["faction","citizen"];

	//set structured texts
	_balance = "";
	switch (_faction) do
	{
		case ("police"): {_balance = "Sheriff Department"};
		case ("fifr"): {_balance = "FIFR"};
		case ("uscg"): {_balance = "USCG"};
	};
	if (_justName) exitwith {_balance;}; //will return "" if not found
	_balanceAmount = 0;
	{
		if ((_x select 0) == _balance) exitwith {_balanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	_balanceAmount;
}] call Server_Setup_Compile;

["A3PL_Government_AddBalance",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_selectedBalance","_selectedBalanceAmount","_transferTo","_amount"];
	if (!(getPlayerUID player IN ["76561198042981718","76561198096687678","_SP_PLAYER_",((missionNameSpace getVariable ["A3PL_Mayor",["0"]]) select 0)])) exitwith {["System: You are not the mayor!",Color_Red] call A3PL_Player_Notification;};

	_display = findDisplay 109;
	_control = _display displayCtrl 2100;

	if (lbCurSel _control < 0) exitwith {["System: You don't have a balance selected to transfer money from",Color_Red] call A3PL_Player_Notification;};
	_selectedBalance = _control lbText (lbCurSel _control); //what balance do we have selected
	_selectedBalanceAmount = 0;
	{
		if ((_x select 0) == _selectedBalance) exitwith {_selectedBalanceAmount = _x select 1;};
	} foreach (missionNameSpace getVariable ["Config_Government_Balances",[]]);

	_control = _display displayCtrl 2102;
	if (lbCurSel _control < 0) exitwith {["System: You don't have a balance selected to transfer money to",Color_Red] call A3PL_Player_Notification;};
	_transferTo = _control lbData (lbCurSel _control); //get the balance we are transfering to

	_control = _display displayCtrl 1404;
	_amount = parseNumber (ctrlText _control); //get the amount
	if (_amount < 1) exitwith {["System: Please enter a valid number to transfer",Color_Red] call A3PL_Player_Notification;};
	if (_amount > _selectedBalanceAmount) exitwith {["System: You can't transfer money more than the current balance amount you have selected",Color_Red] call A3PL_Player_Notification;};

	[_transferTo,_amount,_selectedBalance] remoteExec ["Server_Government_AddBalance", 2];
}] call Server_Setup_Compile;

["A3PL_Government_SetTax",
{
	disableSerialization;
	private ["_fail","_display","_control","_taxChanged","_rate"];
	_display = findDisplay 109;
	_control = _display displayCtrl 1403;
	if (!(getPlayerUID player IN ["76561198042981718","76561198096687678","_SP_PLAYER_",((missionNameSpace getVariable ["A3PL_Mayor",["0"]]) select 0)])) exitwith {["System: You are not the mayor!",Color_Red] call A3PL_Player_Notification;};
	//check input
	_fail = false;
	_rate = (ctrlText _control) splitString "%";
	if (count _rate == 0) then {_f = true};
	_rate = parseNumber (_rate select 0);
	if (isnil "_rate") exitwith {["System: Please enter a valid number in the tax rate field",Color_Red] call A3PL_Player_Notification;};
	if ((_rate > 100) OR (_rate < 0)) then {_fail = true};
	if (_fail) exitwith {["System: Please enter a valid number in the tax rate field between 0% and 100%",Color_Red] call A3PL_Player_Notification;};
	//end of input check

	//get the tax we are changing
	_control = _display displayCtrl 2101;
	if (lbCurSel _control < 0) exitwith {["System: Select the tax rate you would like to change first!",Color_Red] call A3PL_Player_Notification;};
	_taxChanged = _control lbText (lbCurSel _control);

	[_taxChanged,((parseNumber (((ctrlText 1403) splitString "%") select 0))/100)] remoteExec ["Server_Government_SetTax", 2];
	["System: Send request to server to change the taxes, if succesfull a global message will announce the tax rate change.",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewTax",
{
	private ["_msg","_taxChanged","_oldTaxRate","_newTaxRate"];

	_taxChanged = param [0,""];
	_oldTaxRate = (param [1,0])*100;
	_newTaxRate = (param [2,0])*100;

	_msg = format ["DEAR CITIZENS: The mayor has changed the %1 to %2%4, it was %3%4",_taxChanged,_newTaxRate,_oldTaxRate,"%"];
	[_msg,Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewLaw",
{
	private ["_lawIndex"];
	_lawIndex = (param [0,0]) + 1;

	_msg = format ["DEAR CITIZENS: The mayor has changed law number %1, check your phone for the law details",_lawIndex];
	[_msg,Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_SetLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_selectedLaw","_lawText"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103; // get selected laws
	_selectedLaw = lbCurSel _control;
	if (_selectedLaw == -1) exitwith {["System: You haven't selected a law to change",Color_Red] call A3PL_Player_Notification;};

	_lawText = ctrlText (_display displayCtrl 1401);
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["System: Enter a law between 3 and 70 characters!",Color_Red] call A3PL_Player_Notification;};

	[0,_selectedLaw,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_AddLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_lawText"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103; // get selected laws

	_lawText = ctrlText (_display displayCtrl 1401);
	if ((count _lawText < 3) OR (count _lawText > CHARMAXLAWCOUNT)) exitwith {["System: Enter a law between 3 and 70 characters!",Color_Red] call A3PL_Player_Notification;};

	[1,0,_lawText] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

["A3PL_Government_RemoveLaw",
{
	disableSerialization;
	private ["_fail","_display","_control","_selectedLaw"];
	_display = findDisplay 109;
	_control = _display displayCtrl 2103; // get selected laws
	_selectedLaw = lbCurSel _control;
	if (_selectedLaw == -1) exitwith {["System: You haven't selected a law to remove",Color_Red] call A3PL_Player_Notification;};

	[-1,_selectedLaw] remoteExec ["Server_Government_ChangeLaw", 2];
}] call Server_Setup_Compile;

//Voting system
//annouches a new vote through notification
["A3PL_Government_NewVote",
{
	private ["_time"];
	_time = param [0,0];
	[format ["Dear Citizens: The voting booths are now open, you can now vote for a new mayor at the City Hall. The voting will close in %1 minutes. Make sure to bring your ID!",_time],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Government_NewMayor",
{
	private ["_name"];
	_name = param [0,""];
	[format ["Dear Citizens: The vote has been closed! Stay tuned on the goverment website for the new mayor's appointment!",_name],Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//opens voting menu
["A3PL_Government_OpenVote",
{
	disableSerialization;
	private ["_control","_display","_candidates"];
	createDialog "Dialog_Vote";
	_display = findDisplay 110;

	//fill current mayor
	_control = _display displayCtrl 1400;
	_control ctrlSetText ((missionNameSpace getVariable ["A3PL_Mayor",["","None"]]) select 1);

	_candidates = missionNameSpace getVariable ["Server_Government_CCandidates",nil];
	if (isNil "_candidates") exitwith {["System: It doesn't seem like you can vote for a new mayor at this time, check back later!",Color_Red] call A3PL_Player_Notification};
	_candidates sort true; //sort the candidates alphabetically

	_control = _display displayCtrl 1600;
	_control buttonSetAction "[] call A3PL_Government_Vote"; //vote button

	_control = _display displayCtrl 1500;
	{
		private ["_index"];
		_index = _control lbAdd format ["%1 (votes: %2)",(_x select 0),(_x select 2)];
		_control lbSetData [_index,(_x select 1)]; //uid
	} foreach _candidates; //add all candidates to the listbox

}] call Server_Setup_Compile;

["A3PL_Government_Vote",
{
	disableSerialization;
	private ["_control","_display","_voting"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam

	_display = findDisplay 110;
	_control = _display displayCtrl 1500;
	if (lbCurSel _control == -1) exitwith {["System: Please select a mayor to vote for!",Color_Red] call A3PL_Player_Notification;};

	_voting = _control lbData (lbCurSel _control);
	if (isNil "_voting") exitwith {["System: Error in Government_Vote occured, couldn't determine who you are voting for.",Color_Red] call A3PL_Player_Notification;};

	[player,_voting] remoteExec ["Server_Government_AddVote", 2];
	["System: You voted for a new mayor! You can only vote once and this vote cannot be changed again!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

/* ["A3PL_Government_AddCandidate",
{
	private ["_player"];
	if(!([] call A3PL_Player_AntiSpam)) exitWith {}; //anti spam

	[player] remoteExec ["Server_Government_AddCandidate", 2];
	["System: You are now a candidate for the next mayor elections!",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile; */

["A3PL_Government_isFactionLeader",
{
	private ["_faction","_isLeader","_playerUID","_player"];
	_faction = param [0,"citizen"];
	_player = param [1,player];
	_isLeader = false;
	_playerUID = getPlayerUID _player;
	if (_playerUID IN ["76561197986745180","76561197993776619","76561198030894968","_SP_PLAYER_"]) exitwith {_isLeader = true; _isLeader;}; //kane-zann-mexican
	{
		if ((_x select 0) == _faction) exitwith
		{
			if ((_x select 1) == _playerUID) then {_isLeader = true;};
		};
	} foreach (missionNameSpace getVariable ["Config_Government_FactionLead",[]]);
	_isLeader;
}] call Server_Setup_Compile;

//opens the faction setup
["A3PL_Government_FactionSetup",
{
	disableSerialization;
	private ["_control","_display","_faction"];
	_faction = param [0,""];
	if (_faction == "") exitwith {["System: No faction defined in Government_FactionSetup",Color_Red] call A3PL_Player_Notification;};

	A3PL_GOVEDITFACTION = _faction;
	createDialog "Dialog_FactionSetup";
	_display = findDisplay 111;
	_display displayAddEventHandler ["Unload",{A3PL_GOVEDITFACTION = nil; A3PL_GOVRANKS = nil; A3PL_GOVPLIST = nil;}]; //clear temp globals

	[player,_faction] remoteExec ["Server_Government_FactionSetupInfo", 2];

	//what happends when we press the buttons
	_control = _display displayCtrl 1600;
	_control buttonSetAction "[] call A3PL_Government_SetRank;";
	_control = _display displayCtrl 1601;
	_control buttonSetAction "[] call A3PL_Government_AddRank;";
	_control = _display displayCtrl 1602;
	_control buttonSetAction "[] call A3PL_Government_RemoveRank;";
	_control = _display displayCtrl 1603;
	_control buttonSetAction "[] call A3PL_Government_SetPay;";
	_control = _display displayCtrl 1606;
	_control buttonSetAction "[] call A3PL_Government_BPCreate";

	//when press a rank in the rank list
	_control = _display displayCtrl 1502;
	_control ctrlAddEventHandler ["LBSelChanged","[] call A3PL_Government_UpdateRanks;"];

	//set receiving lb
	_control = _display displayCtrl 1501;
	_control lbAdd "Receiving...";
	_control = _display displayCtrl 1502;
	_control lbAdd "Receiving...";

	//add blueprints categories
	_control = _display displayCtrl 2100;
	_control ctrlAddEventHandler ["LBSelChanged","[] call A3PL_Government_BPCatChange;"];
	{
		if ((_x select 0) == _faction) exitwith
		{
			private ["_main"];
			_main = [] + _x;
			_main deleteAt 0; //dont need fname
			{
				_control lbAdd (_x select 0);
			} foreach _main;
		};
	} foreach Config_Blueprints;
}] call Server_Setup_Compile;

["A3PL_Government_BPCatChange",
{
	disableSerialization;
	private ["_control","_display","_cat","_faction"];
	_display = findDisplay 111;
	_control = _display displayCtrl 2100;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (lbCurSel _control < 0) exitwith {};
	_cat = _control lbText (lbCurSel _control);
	_control = _display displayCtrl 1504;
	lbClear _control;
	{
		if ((_x select 0) == _faction) exitwith
		{
			private ["_main"];
			_main = [] + _x;
			_main deleteAt 0; //dont need fname
			{
				if ((_x select 0) == _cat) exitwith
				{
					for "_i" from 1 to ((count _x)-1) do
					{
						private ["_index"];
						systemChat format ["%1",(_x select _i)];
						_index = _control lbAdd ([(_x select _i),"name"] call A3PL_Config_GetItem);
						_control lbSetData [_index,(_x select _i)];
					};
				};
			} foreach _main;
		};
	} foreach Config_Blueprints;
}] call Server_Setup_Compile;

["A3PL_Government_BPCreate",
{
	disableSerialization;
	if(!([] call A3PL_Player_AntiSpam)) exitWith {};
	private ["_display","_control","_bp"];
	_display = findDisplay 111;
	_control = _display displayCtrl 1504;
	if (lbCurSel _control < 0) exitwith {["System: No blueprint selected",Color_Red] call A3PL_Player_Notification;};
	_bp = _control lbData (lbCurSel _control);

	[_bp,1] call A3PL_Inventory_add;
	["System: Blueprint has been added to your inventory",Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

//receives info from server and inputs data into dialog
["A3PL_Government_FactionSetupReceive",
{
	disableSerialization;
	private ["_control","_display","_faction","_ranks","_playerList","_balanceAmount"];
	_display = findDisplay 111;
	_playerList = param [0,[]];
	_playerList sort true; //sort the all whitelist
	_ranks = param [1,[]];
	A3PL_GOVRANKS = [] + _ranks; //yeh dont even ask.. arma does something weird with copying vars
	A3PL_GOVPLIST = [] + _playerList;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction == "") exitwith {["System: Error determining the faction you are editing (_FactionSetupReceive)",Color_Red] call A3PL_Player_Notification;};
	if (isNull _display) exitwith {}; //cannot find displayCtrl

	//fill all whitelisted list
	_control = _display displayCtrl 1501;
	lbClear _control;
	{
		private ["_uid","_name","_index"];
		_name = _x select 0;
		_uid = _x select 1;
		_index = _control lbAdd _name;
		_control lbSetData [_index,_uid];
	} foreach _playerList;

	//fill ranks
	_control = _display displayCtrl 1502;
	lbClear _control;
	{
		private ["_pay","_name","_index"];
		_name = _x select 0;
		_pay = _x select 2;
		_index = _control lbAdd format ["%1 (pay: $%2)",_name,([_pay, 1, 2, true] call CBA_fnc_formatNumber)];
		_control lbSetData [_index,_name];
	} foreach _ranks;

	//set structured texts
	_balanceAmount = [player] call A3PL_Government_MyFactionBalance;
	_control = _display displayCtrl 1100;
	_control ctrlSetStructuredText parseText format ["$%1",([_balanceAmount, 1, 2, true] call CBA_fnc_formatNumber)];
	_control = _display displayCtrl 1101;
	_control ctrlSetStructuredText parseText format ["%1 members",(count _playerList)];
}] call Server_Setup_Compile;

["A3PL_Government_UpdateRanks",
{
	disableSerialization;
	private ["_control","_display","_rank"];
	_display = findDisplay 111;
	_control = _display displayCtrl 1502;
	_rank = _control lbData (lbCurSel _control); //current rank selected
	_control = _display displayCtrl 1500;
	lbClear _control;
	{
		if ((_x select 0) == _rank) then
		{
			{
				//find name
				private ["_uid","_name"];
				_uid = _x;
				_name = format ["Unknown (%1)",_uid];
				{
					if ((_x select 1) == _uid) then
					{
						_name = _x select 0;
					};
				} foreach A3PL_GOVPLIST;

				_control lbAdd _name;
			} foreach (_x select 1);
		};
	} foreach (A3PL_GOVRANKS);
}] call Server_Setup_Compile;

["A3PL_Government_SetRank",
{
	disableSerialization;
	private ["_control","_display","_person","_personName","_rank"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (_faction == "") exitwith {["System: Error determining the faction you are editing",Color_Red] call A3PL_Player_Notification;};
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["System: Only the faction leader can change this",Color_Red] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1501;
	if (lbCurSel _control < 0) exitwith {["System: Error, no player selected in the 'All whitelitsed' list",Color_Red] call A3PL_Player_Notification;};
	_person = _control lbData (lbCurSel _control); //person we are changing rank for
	_personName = _control lbText (lbCurSel _control);
	_control = _display displayCtrl 1502;
	if (lbCurSel _control < 0) exitwith {["System: Error, no rank selected in the 'Ranks' list",Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_person,_rank] remoteExec ["Server_Government_SetRank", 2];
	{
		//remove from other ranks
		private ["_persons","_rankx"];
		_rankx = _x select 0;
		_persons = _x select 1;
		if (_person IN _persons) then
		{
			_persons = _persons - [_person];
			A3PL_GOVRANKS set [_forEachIndex,[(_x select 0),_persons,(_x select 2)]];
		};

		//add to new rank
		if (_rankx == _rank) then
		{
			_persons pushback _person;
		};

	} foreach A3PL_GOVRANKS;
	[] call A3PL_Government_UpdateRanks;
}] call Server_Setup_Compile;

["A3PL_Government_AddRank",
{
	disableSerialization;
	private ["_control","_display","_rank","_faction","_index","_exist"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["System: Only the faction leader can change this",Color_Red] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing",Color_Red] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1400;
	_rank = ctrlText _control;
	_exist = false;

	//check if exist
	{
		if ((_x select 0) == _rank) exitwith {_exist = true;};//check if rank exist already
	} foreach A3PL_GOVRANKS;
	if (_exist) exitwith {["System: This ranks exists already",Color_Red] call A3PL_Player_Notification;};
	if ((count _rank < 3) OR (count _rank > 30)) exitwith {["System: New rank needs to be between 3 and 30 characters long",Color_Red] call A3PL_Player_Notification;};

	[_faction,_rank] remoteExec ["Server_Government_AddRank", 2];

	//add to listbox locally
	_control = _display displayCtrl 1502;
	_index = _control lbAdd format ["%1 (pay: $0.00)",_rank];
	_control lbSetData [_index,_rank];
	A3PL_GOVRANKS pushback [_rank,[],0]; //we use this later to get people
}] call Server_Setup_Compile;

["A3PL_Government_RemoveRank",
{
	disableSerialization;
	private ["_control","_display","_rank","_faction"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["System: Only the faction leader can change this",Color_Red] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing",Color_Red] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1502;

	if (lbCurSel _control < 0) exitwith {["System: Please select a rank first",Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_rank] remoteExec ["Server_Government_RemoveRank", 2];

	//remove from listbox locally
	_control = _display displayCtrl 1502;
	_control lbDelete (lbCurSel _control);
}] call Server_Setup_Compile;

["A3PL_Government_SetPay",
{
	disableSerialization;
	private ["_control","_display","_rank","_pay"];
	_display = findDisplay 111;
	_faction = missionNameSpace getVariable ["A3PL_GOVEDITFACTION",""];
	if (!([_faction] call A3PL_Government_isFactionLeader)) exitwith {["System: Only the faction leader can change this",Color_Red] call A3PL_Player_Notification;};
	if (_faction == "") exitwith {["System: Error determining the faction you are editing",Color_Red] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1401;
	_pay = parseNumber (ctrlText _control);
	if ((_pay < FACTIONMINPAY) OR (_pay > FACTIONMAXPAY)) exitwith {[format ["System: Enter a paycheck between %1 and %2",FACTIONMINPAY,FACTIONMAXPAY],Color_Red] call A3PL_Player_Notification;};
	_control = _display displayCtrl 1502; //rank we are changing
	if (lbCurSel _control < 0) exitwith {["System: You don't have a rank selected",Color_Red] call A3PL_Player_Notification;};
	_rank = _control lbData (lbCurSel _control);

	[_faction,_rank,_pay] remoteExec ["Server_Government_SetPay", 2];

	//set locally
	{
		if ((_x select 0) == _rank) then
		{
			A3PL_GOVRANKS set [_forEachIndex,[_x select 0,_x select 1,_pay]];
		};
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
	lbClear _control;
	{
		private ["_pay","_name","_index"];
		_name = _x select 0;
		_pay = _x select 2;
		_index = _control lbAdd format ["%1 (pay: $%2)",_name,([_pay, 1, 2, true] call CBA_fnc_formatNumber)];
		_control lbSetData [_index,_name];
	} foreach (missionNameSpace getVariable ["A3PL_GOVRANKS",[]]);
}] call Server_Setup_Compile;
