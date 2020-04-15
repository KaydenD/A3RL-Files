//Open the car storage menu and request list from server
["A3PL_Storage_OpenCarStorage", {
	private ["_type"];

	if(player_objintersect getVariable ["inUse",false]) exitWith {
		["This storage building is in use!", Color_Red] call A3PL_Player_Notification;
	};

	//createDialog "Dialog_CarStorage";

	createDialog "dialog_PlayerGarage";

	buttonSetAction [1600, "[] call A3PL_Storage_CarRetrieveButton"];
	buttonSetAction [1601, "[] call A3PL_Storage_ChangeVehicleName"];
	
	//get the type that we need to get from the DB
	_type = player_objintersect getVariable ["type","vehicle"];

	//Mark this as in use...
	if (!(player_objintersect IN A3PL_Jobroadworker_Impounds)) then {
		player_objintersect setVariable ["inUse",true,true];
	};

	//Spawn a temporary loop to monitor the menu, wait until it's gone, and then mark the garage as no longer in use.
	[] spawn {
			private ["_garage"];
			_garage = player_objintersect;
			waitUntil {sleep 0.1; isNull findDisplay 145};
			sleep 2;
			_garage setVariable ["inUse",false,true];
		};

		if (player_objintersect IN A3PL_Jobroadworker_Impounds) then {
		[[player,"-1",1],"Server_Storage_ReturnVehicles",false,false] call BIS_FNC_MP;
		};
		if (player_objintersect IN A3PL_Chopshop_Retrivals) then {
		[[player,"-1",2],"Server_Storage_ReturnVehicles",false,false] call BIS_FNC_MP;
		};
		if ((A3PL_Chopshop_Retrivals find player_objintersect == -1) && (A3PL_Jobroadworker_Impounds find player_objintersect == -1)) then {
		[[player,"-1",0,_type],"Server_Storage_ReturnVehicles",false,false] call BIS_FNC_MP;
	};

}] call Server_Setup_Compile;

//Receive storage from server
["A3PL_Storage_VehicleReceive", {
	disableSerialization;
	private ["_returnArray","_display","_control","_i"];
	_returnArray = param [0,[]];

	//hint str _returnarray;
	
	_display = findDisplay 145;

	_control = _display displayCtrl 1500;

	{
		_x pushBack (format ["%1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")]);

		_vehicleGas = format ["%1",(_x select 3)*100] + "%";
		_vehiclePlate = toUpper (_x select 0);

		_vehicleData = format ["%1_%2_%3",_x select 4,_vehiclePlate,_vehicleGas];

		if ((_x select 2) == "noCustomName") then {
			_i = lbAdd [1500, (format ["%1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")])];
			lbSetData [1500,_i,_vehicleData];
		} else {
			_i = _control lbAdd (format ["%1",_x select 2]);
			lbSetData [1500,_i,_vehicleData];
		};
	} foreach _returnArray;

	A3PL_Storage_ReturnArray = _returnArray;

	_control ctrlAddEventHandler ["LBSelChanged","[] call A3PL_Storage_VehicleInfo;"];
}] call Server_Setup_Compile;

["A3PL_Storage_VehicleInfo", {
	_display = findDisplay 145;
	_selectedIndex = lbCurSel 1500; 
	_selectedData = lbData [1500, _selectedIndex];
	_dataSplit = _selectedData splitString "_";
	_vehicleType = _dataSplit select 0;
	_vehiclePlate = _dataSplit select 1;
	_vehicleGas = _dataSplit select 2;
	_control = _display displayCtrl 1501;

	_startingText = ["Type:","Plate:","Gas:"];
	_followingText = [_vehicleType,_vehiclePlate,_vehicleGas];
	
	lbClear 1501;
	{
		lbAdd [1501, format ["%1 %2", _startingText select _forEachIndex,_followingText select _forEachIndex]];
	} forEach _followingText;
}] call Server_Setup_Compile;

//What happends when we press the retrieve button on the car storage dialog
["A3PL_Storage_CarRetrieveButton", {
	disableSerialization;
	private ["_display","_control","_intersect","_spawnPos","_dir"];
	//Control for listbox
	_display = findDisplay 145;
	_control = _display displayCtrl 1500;
	_intersect = player_objintersect;

	if (isNil "player_objintersect") then
	{
		_intersect = cursorObject;
	} else
	{
		_intersect = player_objIntersect;
	};
	//Dont forget area check here
	if (isNull _intersect) exitwith {closeDialog 0; ["System: You are not looking at the storage building", Color_Red] call A3PL_Player_Notification;};
	//if (!((typeOf _intersect) IN ["Land_A3PL_storage","A3PL_CarInfo"])) exitwith {closeDialog 0; ["You are not looking at a storage building", Color_Red] call A3PL_Player_Notification;};
	if (_intersect animationPhase "StorageDoor1" > 0.1) exitwith {closeDialog 0; ["It looks likes this storage building is in use", Color_Red] call A3PL_Player_Notification;};

	//ask the server to spawn this vehicle for us
	_array = (A3PL_Storage_ReturnArray select (lbCurSel _control));
	_id = _array select 0;
	_class = _array select 1;

	//get the spawnpos from the object if available
	_spawnPos = _intersect getVariable ["positionSpawn",nil];
	//get the spawnpos if this object is a house
	if ((_intersect isKindOf "Land_Home1g_DED_Home1g_01_F") OR (typeOf _intersect IN ["Land_A3PL_Ranch1","Land_A3PL_Ranch2","Land_A3PL_Ranch3","Land_A3PL_Sheriffpd"])) then
	{
		_dir = getDir _intersect;
		switch (typeOf _intersect) do
		{
			case ("Land_Home1g_DED_Home1g_01_F"): {_spawnPos = _intersect modelToWorld [4.2,1.5,-3.2];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home2b_DED_Home2b_01_F"): {_spawnPos = _intersect modelToWorld [-4.42236,-1.39868,-3.26778];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home3r_DED_Home3r_01_F"): {_spawnPos = _intersect modelToWorld [-3,-1,-4];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home4w_DED_Home4w_01_F"): {_spawnPos = _intersect modelToWorld [4.3,-1,-3];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home5y_DED_Home5y_01_F"): {_spawnPos = _intersect modelToWorld [4.3,-1,-3];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_Home6b_DED_Home6b_01_F"): {_spawnPos = _intersect modelToWorld [3,-1,-4];_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch1"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch2"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Ranch3"): {_spawnPos = _intersect modelToWorld [1,6.5,-2]; _dir = _dir - 90;_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];};
			case ("Land_A3PL_Sheriffpd"):
			{
				if (player_NameIntersect == "sdstoragedoor3") then {_pos = _intersect selectionPosition "SDStorageDoor_pos";_spawnPos = _intersect modelToWorld _pos;_intersect animateSource ["StorageDoor",1];};
				if (player_NameIntersect == "sdstoragedoor6") then {_pos = _intersect selectionPosition "SDStorageDoor2_pos";_spawnPos = _intersect modelToWorld _pos;_intersect animateSource ["StorageDoor2",1];};
				_spawnPos = ASLToATL _spawnPos;
				_dir = _dir + 90;
				_spawnPos = [_spawnPos select 0,_spawnPos select 1,((_spawnPos select 2)+0),_dir];

			};
			_spawnPos = [_spawnPos select 0,_spawnPos select 1,_spawnPos select 2,_dir];
		};
	};
	if (!isNil "_spawnPos") then
	{
		_type = _intersect getVariable ["type","vehicle"];
		if (_type == "plane") then
		{
      		[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the plane
		};
		if(_type == "impound") then {

			_cash = player getVariable ["player_cash",0];_bank = player getVariable ["player_bank",0];
			if (2000 > _cash) then
			{
				if (2000 > _bank) exitwith{["System: You don't have enough money to pay the $2000 impound fee",Color_Red] call A3PL_Player_Notification;};
				player setVariable ["player_bank",(player getVariable ["player_bank",0])-2000,true];
				["System: You have been charged a $2000 impound fee",Color_Red] call A3PL_Player_Notification;
				[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the car
			}
			else
			{
			player setVariable ["player_cash",(player getVariable ["player_cash",0])-2000,true];
			["System: You have been charged a $2000 impound fee",Color_Red] call A3PL_Player_Notification;
			[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the car
			};

		};
		if(_type == "chopshop") then {

			_cash = player getVariable ["player_cash",0];_bank = player getVariable ["player_bank",0];
			if (8000 > _cash) then {
				if (8000 > _bank) exitwith{["System: You don't have enough money to pay the $8000 fee to get your stolen car back!",Color_Red] call A3PL_Player_Notification;};
				player setVariable ["player_bank",(player getVariable ["player_bank",0])-8000,true];
				["System: You have been charged a $8000 fee to get your car back!",Color_Red] call A3PL_Player_Notification;
				[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the car
			} else {
					player setVariable ["player_cash",(player getVariable ["player_cash",0])-8000,true];
					["System: You have been charged a $8000 fee to get your car back!",Color_Red] call A3PL_Player_Notification;
					[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the car
			};

			};
			if(_type == "vehicle") then {

				[[_class,player,_id,_spawnPos],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP; //spawn the car
			};
	} else {
		[[_class,player,_id,_intersect],"Server_Storage_RetrieveVehicle",false,false] call BIS_FNC_MP;
	};

	closeDialog 0;
	["Send request to server to spawn your vehicle. Please wait.", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Storage_ChangeVehicleName", {

	private ["_validCharacters"];
	_display = findDisplay 145;
	_control = _display displayCtrl 1500;
	_selectedIndex = lbCurSel 1500;
	_selectedData = lbData [1500, _selectedIndex];
	_dataSplit = _selectedData splitString "_";
	_vehiclePlateUpper = _dataSplit select 1;
	_vehiclePlateLower = toLower _vehiclePlateUpper;
	_vehicleNewName = ctrlText 1400;
	_allowedCharacters = [
		" ","0","1","2","3","4","5","6","7","8","9",
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
	];
	_validCharacters = true;

	if ((count _vehicleNewName) < 1) exitWith {
		["System: You need to enter a custome name!",Color_Yellow] call A3PL_Player_Notification;
	};

	if ((count _vehicleNewName) > 35) exitWith {
		["System: Your custom name must be less than 35 characters!",Color_Yellow] call A3PL_Player_Notification;
	};

	for "_i" from 0 to ((count _vehicleNewName) - 1) do 
	{
		private ["_checking"];
		_checking = _vehicleNewName select [_i,1];
		if (!(_checking IN _allowedCharacters)) exitwith {_validCharacters = false;};
	};

	if (!(_validCharacters)) exitWith {
		["System: Your custom name may only contain letters, numbers, and spaces!",Color_Yellow] call A3PL_Player_Notification;
	};

	[_vehiclePlateLower,_vehicleNewName] remoteExec ["Server_Storage_ChangeVehicleName",2];

	closeDialog 0;
}] call Server_Setup_Compile;

["A3PL_Storage_CarStoreButton",
{
	private ["_intersect","_near","_type","_types"];
	_intersect = player_objIntersect;
	_type = param [0,"car"];
	if (isNull _intersect) exitwith {};

	//Look for nearest vehicle
	/* switch (_type) do
	{
		case ("plane"): {_types = ["Plane","Helicopter","Air"]; };
		case ("car"): {_types = ["Car","Ship","Tank","Truck"]; };
	}; */
	_types = ["Car","Ship","Tank","Truck","Plane","Helicopter","Air"];

	_near = nearestObjects [_intersect,_types,15];
	if (count _near == 0) exitwith
	{
		[7] call A3PL_Storage_CarStoreResponse;
	};

	[8] call A3PL_Storage_CarStoreResponse;

	if (typeOf _intersect IN ["Land_A3PL_storage"]) then
	{
		[[player,_intersect],"Server_Storage_StoreVehicle",false,false] call BIS_FNC_MP;
		//hint "Server_Storage_StoreVehicle";
	} else
	{
		//[[player,_intersect],"Server_Storage_StoreVehicle_Position",false,false] call BIS_FNC_MP;
		//hint "Server_Storage_StoreVehicle_Pos";
		_cars = nearestObjects [player, ["Car","Ship","Air","Tank","Truck"], 15];
		_car = _cars select 0;

		if(count _cars < 1) exitWith {
			["System: It doesn't seem like there is a car nearby that you can store", Color_Red] call A3PL_Player_Notification;
		};
		if (((_car getVariable "owner") select 0) != (getPlayerUID player)) exitWith
		{
			["System: You cannot store other players vehicles!", Color_Red] call A3PL_Player_Notification;
		};
			[_car,player] remoteExec ["Server_Storage_SaveLargeVehicles",2];
	};
}] call Server_Setup_Compile;

["A3PL_Storage_CarStoreResponse",
{
	private ["_return","_text"];
	_return = param [0,1];

	_text = "";
	switch (_return) do
	{
		case 1: {_text = ["Server denied store request: Storage in-use",Color_Red]};
		case 2: {_text = ["Server will try to store your vehicle within 2 minutes, please drive the car inside and exit the building",Color_Green]};
		case 3: {_text = ["Storage is closing, your car will be despawned and stored once it's closed",Color_Red]};
		case 4: {_text = ["Vehicle storing failed, time to store the vehicle exceeded maximum",Color_Red]};
		case 5: {_text = ["Vehicle storing failed, has the vehicle already been stored?",Color_Red]};
		case 6: {_text = ["Vehicle storing failed, it doesn't seem that any of the nearby cars belong to you",Color_Red]};
		case 7: {_text = ["Vehicle storing failed, no vehicle nearby",Color_Red]};
		case 8: {_text = ["Send request to server to store your nearest vehicle",Color_Green]};
		case 9: {_text = ["Vehicle stored",Color_Green]};
	};

	_text call A3PL_Player_Notification;


}] call Server_Setup_Compile;

["A3PL_Storage_ObjectStoreButton",
{
	private ["_intersect","_near","_nearOwner","_var","_uid"];
	_intersect = player_objIntersect;
	if (isNull _intersect) exitwith {};
	if (!(typeOf _intersect == "Land_A3PL_storage")) exitwith {};
	
	_storeableObjects = [];
	{ 
  		if!(_x select 8) then { 
   			_storeableObjects pushBack (_x select 3);  
		}; 
	} forEach Config_Items;

	//Look for nearest vehicle
	_near = nearestObjects [_intersect,_storeableObjects,9];
	if (count _near == 0) exitwith
	{
		[1] call A3PL_Storage_ObjectStoreResponse;
	};

	_nearOwner = [];
	_uid = getPlayerUID player;
	{
		_var = _x getVariable ["owner", nil];
		if (!isNil "_var") then
		{
			if(_var == _uid) then {
				_nearOwner pushback _x;
			};
		};
	} foreach _near;

	if (count _nearOwner == 0) exitwith
	{
		[3] call A3PL_Storage_ObjectStoreResponse;
	};

	_nearOwner = _nearOwner select 0;

	[2] call A3PL_Storage_ObjectStoreResponse;
	[[player,_nearOwner],"Server_Storage_StoreObject",false,false] call BIS_FNC_MP;
}] call Server_Setup_Compile;

["A3PL_Storage_ObjectRetrieveButton",
{
	disableSerialization;
	private ["_display","_control","_intersect"];
	//Control for listbox
	_display = findDisplay 58;
	_control = _display displayCtrl 1500;

	_intersect = player_objIntersect;
	//Dont forget area check here
	if (isNull _intersect) exitwith {closeDialog 0; ["You are not looking at the storage building", Color_Red] call A3PL_Player_Notification;};
	if ((typeOf _intersect) != "Land_A3PL_storage") exitwith {closeDialog 0; ["You are not looking at the storage building", Color_Red] call A3PL_Player_Notification;};
	systemChat (format ["%1",A3PL_Storage_ReturnArray]);
	systemChat (format ["%1",lbCurSel _control]);
	//ask the server to spawn this vehicle for us
	_array = (A3PL_Storage_ReturnArray select (lbCurSel _control));
	_id = _array select 0;
	_class = _array select 1;
	systemChat (format ["%1",_id]);
	systemChat (format ["%1",_class]);

	[[_class,player,_id],"Server_Storage_RetrieveObject",false,false] call BIS_FNC_MP;

	closeDialog 0;
	["Send request to server to spawn your object. Please wait.", Color_Green] call A3PL_Player_Notification;
}] call Server_Setup_Compile;

["A3PL_Storage_ObjectRetrieveResponse",
{
	private ["_return","_text"];
	_return = param [0,1];

	_text = "";
	switch (_return) do
	{
		case 1: {_text = ["Server denied retrieval request: Storage in-use",Color_Red]};
		case 2: {_text = ["Server is attempting to spawn your object, it will spawn near you",Color_Green]};
		case 3: {_text = ["Server failed to change locality to you, it has been put back into the storage",Color_Red]};
		case 4: {_text = ["Server didn't store the object, are you near the object?",Color_Red]};
		case 5: {_text = ["Server has succesfully saved your object",Color_Green]};
		case 6: {_text = ["Server has an issue determining the owner, it did not save the object",Color_Red]};
		case 7: {_text = ["Server failed to save the object, does it belong to you?",Color_Red]};
	};

	_text call A3PL_Player_Notification;


}] call Server_Setup_Compile;

["A3PL_Storage_CarRetrieveResponse",
{
	private ["_return","_text"];
	_return = param [0,1];

	_text = "";
	switch (_return) do
	{
		case 1: {_text = ["Server: denied retrieval request: Storage in-use",Color_Red]};
		case 2: {_text = ["Server: attempting to spawn your vehicle, you have 30 sec to retrieve the vehicle",Color_Green]};
		case 3: {_text = ["Server: Your vehicle was not driven out of the storage building, it has been put back in",Color_Red]};
		case 4: {_text = ["Server: Your vehicle has been spawned",Color_Green]};
	};

	_text call A3PL_Player_Notification;


}] call Server_Setup_Compile;

["A3PL_Storage_ObjectStoreResponse",
{
	private ["_return","_text"];
	_return = param [0,1];

	_text = "";
	switch (_return) do
	{
		case 1: {_text = ["Client denied storage request, is there an object nearby?",Color_Red]};
		case 2: {_text = ["Send request to server to store your object, please wait.",Color_Green]};
		case 3: {_text = ["Client denied storage request, is there any object nearby that belongs to you?",Color_Red]};
	};

	_text call A3PL_Player_Notification;


}] call Server_Setup_Compile;

//Open the car storage menu and request list from server
["A3PL_Storage_OpenObjectStorage",{
	if(player_objintersect getVariable ["inUse",false]) exitWith {
		["This storage building is in use!", Color_Red] call A3PL_Player_Notification;
	};

	createDialog "Dialog_ObjectStorage";

	if(typeOf player_objintersect == "Land_A3PL_storage") then {
		//Mark this as in use...
		player_objintersect setVariable ["inUse",true,true];

		//Spawn a temporary loop to monitor the menu, wait until it's gone, and then mark the garage as no longer in use.
		[] spawn {
			_garage = player_objintersect;
			waitUntil {isNull findDisplay 58};
			sleep 2;
			_garage setVariable ["inUse",false,true];
		};

	} else {
		//Error out to the player
		["You are not looking at the storage building", Color_Red] call A3PL_Player_Notification;
	};

	[[player],"Server_Storage_ReturnObjects",false,false] call BIS_FNC_MP;
}] call Server_Setup_Compile;

//Receive storage from server
["A3PL_Storage_ObjectsReceive",{
	disableSerialization;
	private ["_returnArray","_display","_control","_i"];
	_returnArray = param [0,[]];

	//Control for listbox
	_display = findDisplay 58;
	_control = _display displayCtrl 1500;

	{
		_i = _control lbAdd (format ["%1",getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName")]);
	} foreach _returnArray;

	//save a copy of _returnarray, we will use this later in another function
	A3PL_Storage_ReturnArray = _returnArray;
	systemChat (format ["%1", A3PL_Storage_ReturnArray]);
}] call Server_Setup_Compile;


