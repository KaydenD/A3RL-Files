/* #Wubepi
$[
    1.063,
    ["test",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
    [1000,"",[1,"",["0.438125 * safezoneW + safezoneX","0.643 * safezoneH + safezoneY","0.118594 * safezoneW","0.121 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
    [1001,"",[1,"Nearest Medic: 250m",["0.443281 * safezoneW + safezoneX","0.654 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
    [1600,"",[1,"Respawn",["0.443281 * safezoneW + safezoneX","0.72 * safezoneH + safezoneY","0.108281 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
    [1002,"",[1,"Respawn In 60 Seconds",["0.443281 * safezoneW + safezoneX","0.687 * safezoneH + safezoneY","0.108281 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
 
 
class Deathscreen
{
    idd = 1020;
    class controls
    {
        class Background: RscText
        {
            idc = 1000;
            x = 0.438125 * safezoneW + safezoneX;
            y = 0.643 * safezoneH + safezoneY;
            w = 0.118594 * safezoneW;
            h = 0.121 * safezoneH;
            colorBackground[] = {0,0,0,0.5};
        };
 
        class NearestMedic: RscText
        {
            idc = 1001;
            text = ""; //--- ToDo: Localize;
            style = 0x02;
            x = 0.443281 * safezoneW + safezoneX;
            y = 0.654 * safezoneH + safezoneY;
            w = 0.108281 * safezoneW;
            h = 0.022 * safezoneH;
        };
 
        class RespawnTimer: RscText
        {
            idc = 1002;
            text = ""; //--- ToDo: Localize;
            style = 0x02;
            x = 0.443281 * safezoneW + safezoneX;
            y = 0.687 * safezoneH + safezoneY;
            w = 0.108281 * safezoneW;
            h = 0.022 * safezoneH;
        };
       
        class RespawnButton: RscButton
        {
            idc = 1600;
            text = "Respawn"; //--- ToDo: Localize;
            x = 0.443281 * safezoneW + safezoneX;
            y = 0.72 * safezoneH + safezoneY;
            w = 0.108281 * safezoneW;
            h = 0.033 * safezoneH;
            action = "[] call A3PL_Medical_Respawn;";
        };
    };
};