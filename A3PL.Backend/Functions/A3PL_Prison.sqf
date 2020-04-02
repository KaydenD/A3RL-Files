["A3PL_Prison_HandleDoor",
{
	private ["_obj","_name"];
	_obj = param [0,objNull];
	_name = param [1,""];

	if (_name IN ["door_20","door_21"]) exitwith { [_obj,_name,false] call A3PL_Lib_ToggleAnimation; };
	if (_name IN
	[
		"door_1_button","door_1_button2","door_2_button","door_2_button2","door_3_button","door_3_button2",
		"door_4_button","door_4_button2","door_5_button","door_5_button2","door_6_button","door_6_button2",
		"door_7_button","door_7_button2","door_8_button","door_8_button2","door_9_button","door_9_button2",
		"door_10_button","door_10_button2","door_11_button","door_11_button2","door_12_button","door_12_button2",
		"door_13_button","door_13_button2","door_14_button","door_14_button2","door_15_button","door_15_button2",
		"door_16_button","door_16_button2","door_23_button","door_23_button2","door_24_button","door_25_button","door_26_button"
	]) exitwith { _name = _name select [0,(_name find "_button")]; [_obj,_name,false] call A3PL_Lib_ToggleAnimation; };

	if (_name IN
	[
		"console_cell1","console_cell2","console_cell3","console_cell4","console_cell5","console_cell6","console_cell7","console_cell8","console_cell9","console_cell10","console_cell11","console_cell12","console_cell13","console_cell14",
		"console_maincell1","console_maincell2","console_maincell3",
		"console_garage"
	]) exitwith
	{
		private ["_anim","_hSel"];
		_anim = "";
		_hSel = -1;
		switch (_name) do
		{
			case ("console_cell1"): {_anim = "cell_door_1"; _hSel = 0;};
			case ("console_cell2"): {_anim = "cell_door_2"; _hSel = 1;};
			case ("console_cell3"): {_anim = "cell_door_3"; _hSel = 2;};
			case ("console_cell4"): {_anim = "cell_door_4"; _hSel = 3;};
			case ("console_cell5"): {_anim = "cell_door_5"; _hSel = 4;};
			case ("console_cell6"): {_anim = "cell_door_6"; _hSel = 5;};
			case ("console_cell7"): {_anim = "cell_door_7"; _hSel = 6;};
			case ("console_cell8"): {_anim = "cell_door_8"; _hSel = 7;};
			case ("console_cell9"): {_anim = "cell_door_9"; _hSel = 8;};
			case ("console_cell10"): {_anim = "cell_door_10"; _hSel = 9;};
			case ("console_cell11"): {_anim = "cell_door_11"; _hSel = 10;};
			case ("console_cell12"): {_anim = "cell_door_12"; _hSel = 11;};
			case ("console_cell13"): {_anim = "cell_door_13"; _hSel = 12;};
			case ("console_cell14"): {_anim = "cell_door_14"; _hSel = 13;};
			case ("console_maincell1"): {_anim = "door_19"; _hSel = 15;};
			case ("console_maincell2"): {_anim = "door_18"; _hSel = 16;};
			case ("console_maincell3"): {_anim = "door_17"; _hSel = 17;};
			case ("console_garage"): {_anim = "door_23"; _hSel = 14;};
		};

		if (_obj animationPhase _anim < 0.5) then //check if we are turning on or off
		{
			_obj setObjectTextureGlobal [_hSel,"#(argb,8,8,3)color(0,1,0,1.0,co)"];
			[_obj,_anim,false,1] call A3PL_Lib_ToggleAnimation;
			if (_name == "console_maincell1") then
			{
				[_obj,"door_22",false,1] call A3PL_Lib_ToggleAnimation;
			};
		} else
		{
			_obj setObjectTextureGlobal [_hSel,"#(argb,8,8,3)color(1,0,0,1.0,co)"];
			[_obj,_anim,false,0] call A3PL_Lib_ToggleAnimation;
			if (_name == "console_maincell1") then
			{
				[_obj,"door_22",false,0] call A3PL_Lib_ToggleAnimation;
			};
		};
	};

	//PEOPLE are breaking out, LOCK THE FUCK DOWN
	if (_name == "console_lockdown") exitwith
	{
		{
			if (_x != "#(argb,8,8,3)color(1,0,0,1.0,co)") then
			{
				_obj setObjectTextureGlobal [_forEachIndex,"#(argb,8,8,3)color(1,0,0,1.0,co)"];
			};
		} foreach (getObjectTextures _obj); //set all textures to red

		{
			if (_obj animationPhase _x > 0.1) then { [_obj,_x,false,0] call A3PL_Lib_ToggleAnimation; };
		} foreach
		[
			"cell_door_1","cell_door_2","cell_door_3","cell_door_4","cell_door_5","cell_door_6","cell_door_7","cell_door_8","cell_door_9","cell_door_10",
			"cell_door_11","cell_door_12","cell_door_13","cell_door_14","door_19","door_18","door_17","door_23"
		];
		playSound3D ["A3PL_Common\effects\lockdown.ogg", _obj];
	};

}] call Server_Setup_Compile;
