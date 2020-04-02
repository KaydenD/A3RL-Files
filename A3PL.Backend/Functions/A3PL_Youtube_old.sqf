

['A3PL_Youtube_Start',
{
	
}] call Server_Setup_Compile;


// Okay to use this
// ["https://www.youtube.com/watch?v=2sqn3f0BHdY",nearestObject [player, "Land_A3PL_Cinema"]] spawn A3PL_Youtube_Init;

['A3PL_Youtube_StartFinal',
{
	//Set our variable to Nil
	player setVariable ["A3PL_Youtube_Rendered",Nil,true];
	
	//Set WaitRenderTime to 0
	A3PL_Youtube_WaitRenderTime = 0;
			
	//Okay first 300 frames are rendered, lets start the video
	"ArmA2Net.Unmanaged" callExtension "A3PLMain ['StartAudio','']";
			
	A3PL_Youtube_RunSepLoop = false;
	[A3PL_Youtube_Filename,A3PL_Youtube_Object] spawn A3PL_Youtube_Start;	

	//Now lets run an additional while loop, that is able to know when the video has ended
	[] spawn
	{
		sleep 3;
				
		A3PL_Youtube_AudioTime = "0";
		A3PL_Youtube_RunSepLoop = true;
		while {A3PL_Youtube_RunSepLoop} do
		{
			_prevAudioTime = format ["%1",A3PL_Youtube_AudioTime];
			A3PL_Youtube_AudioTime = "ArmA2Net.Unmanaged" callExtension "A3PLMain ['AudioPosition','']";
					
			//Okay video is over, lets run our stopping commands
			if (A3PL_Youtube_AudioTime == _prevAudioTime) exitwith
			{
				["A3PL_Deltatime", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
				"ArmA2Net.Unmanaged" callExtension "A3PLMain ['StopAudio','']";
				A3PL_Frame = 1;
			};
					
			sleep 5;
		};
	};	
}
] call Server_Setup_Compile;