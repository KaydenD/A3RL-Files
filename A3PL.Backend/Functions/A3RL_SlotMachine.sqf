["A3RL_Slots_Roll", //
{
	_dir = "\A3PL_Common\gui\slots\"
	_icons = ["bell.paa", "cherry.paa", "clover.paa", "crown.paa", "diamond.paa", "horceshoe.paa", "seven.paa", "star.paa", "strawberry.paa", "watermelon.paa"];

	createDialog "Dialog_SlotMachine";
	_display = findDisplay 63;

}] call Server_Setup_Compile;