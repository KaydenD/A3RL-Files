class iPhone_X
{
	idd = 97000;
	movingEnable = true;
	enableSimulation = true;
	onLoad = "[] spawn A3PL_iPhoneX_Settings;";

	class ControlsBackground
	{
		class iPhone_X_background: Life_RscPicture
		{
			idc = 97002;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
		};
		class iPhone_X_bottom: Life_RscPicture
		{
			idc = 97004;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21501389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
			show = false;
		};
		class iPhone_X_shadow: Life_RscPicture
		{
			idc = 97114;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
			colorText[] = {0,0,0,1};
			show = false;
		};
		class iPhone_X_shadow_home: Life_RscPicture
		{
			idc = 97115;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
			colorText[] = {0,0,0,0.5};
			show = false;
		};
	};

	class Controls
	{

		class iPhone_X_icon_appPhone: Life_RscPicture
		{
			idc = 97006;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_phone.paa";
			show = false;
		};

		class iPhone_X_icon_appContact: Life_RscPicture
		{
			idc = 97007;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_contact.paa";
			show = false;
		};

		class iPhone_X_icon_appSMS: Life_RscPicture
		{
			idc = 97008;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_sms.paa";
			show = false;
		};

		class iPhone_X_icon_appSettings: Life_RscPicture
		{
			idc = 97009;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_settings.paa";
			show = false;
		};
		class iPhone_X_icon_appCamera: Life_RscPicture
		{
			idc = 97012;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_camera.paa";
			show = false;
		};
		class iPhone_X_icon_appUber: Life_RscPicture
		{
			idc = 97011;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_uber.paa";
			show = false;
		};
		class iPhone_X_button_appUber: Life_RscButtonMenu
		{
			idc = 97111;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppUber;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};
		class iPhone_X_icon_appSwitchboard: Life_RscPicture
		{
			idc = 97014;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_emergency.paa";
			show = false;
		};

		/*class iPhone_X_icon_appTaxe: Life_RscPicture
		{
			idc = 97014;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_taxe.paa";
			show = false;
		};
		class iPhone_X_button_appTaxe: Life_RscButtonMenu
		{
			idc = 97015;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppTaxe";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};*/


		class iPhone_X_button_appPhone: Life_RscButtonMenu
		{
			idc = 97106;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppPhone;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_button_appContactsList: Life_RscButtonMenu
		{
			idc = 97107;
			x = safeZoneX + safeZoneW * 0.740625002;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppContactsList;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_button_appSMSList: Life_RscButtonMenu
		{
			idc = 97108;
			x = safeZoneX + safeZoneW * 0.773046878;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppSMSList;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_button_appSettings: Life_RscButtonMenu
		{
			idc = 97109;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.79708056;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] call A3PL_iPhoneX_AppSettings;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_button_appCamera: Life_RscButtonMenu
		{
			idc = 97112;
			x = safeZoneX + safeZoneW * 0.708203126;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] spawn A3PL_iPhoneX_appCamera";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_button_appSwitchboard: Life_RscButtonMenu
		{
			idc = 97015;
			x = safeZoneX + safeZoneW * 0.805468754;
			y = safeZoneY + safeZoneH * 0.34541667;
			w = safeZoneW * 0.02246094;
			h = safeZoneH * 0.03993056;
			action = "[] spawn A3PL_iPhoneX_AppSwitchboard";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_Icon_appBank: Life_RscPicture
		{
			idc = 97013;
			x = 0.773046878 * safezoneW + safezoneX;
			y = 0.34541667 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			text = "A3PL_Common\GUI\phone\iPhone_X_icon_bank.paa";
			show = false;
		};
		class iPhone_Button_appBank: Life_RscButtonMenu
		{
			idc = 97113;
			x = 0.773046878 * safezoneW + safezoneX;
			y = 0.34541667 * safezoneH + safezoneY;
			w = 0.0224609 * safezoneW;
			h = 0.0399306 * safezoneH;
			action = "[] spawn A3RL_iPhoneX_appBank;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};

		class iPhone_X_clock_home: Life_RscText
		{
			idc = 97500;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.70448282;
			y = safeZoneY + safeZoneH * 0.31725;
			w = safeZoneW * 0.02872032;
			h = safeZoneH * 0.01081667;
			text = "";
			sizeEx = 0.012 * safezoneW;
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			show = false;
		};

		class iPhone_X_clock: Life_RscText
		{
			idc = 97501;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.72088282;
			y = safeZoneY + safeZoneH * 0.37;
			w = safeZoneW * 0.09532032;
			h = safeZoneH * 0.04541667;
			text = "";
			sizeEx = 0.05 * safezoneW;
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			show = false;
		};

		class iPhone_X_phoneNumberActive: Life_RscText
		{
			idc = 97800;
			style = ST_CENTER;
			x = safeZoneX + safeZoneW * 0.72088282;
			y = safeZoneY + safeZoneH * 0.42;
			w = safeZoneW * 0.09532032;
			h = safeZoneH * 0.04541667;
			text = "No SIM";
			sizeEx = 0.02 * safezoneW;
			colorBackground[] = {0,0,0,0};
			shadow = 0;
			show = false;
		};

		class iPhone_X_faceIDGroup: Life_RscControlsGroup
		{
			idc = 97116;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_X_faceID: Life_RscPicture
				{
					idc = 97216;
					x = safeZoneX + safeZoneW * 0.69854219;
					y = safeZoneY + safeZoneH * 0.30690278;
					w = safeZoneW * 0.13914844;
					h = safeZoneH * 0.49570834;
					text = "";
				};

				class iPhone_X_text_faceID: Life_RscStructuredText
				{
					idc = 97217;
					x = safeZoneX + safeZoneW * 0.69854219;
					y = safeZoneY + safeZoneH * 0.81302796;
					w = safeZoneW * 0.13914844;
					h = safeZoneH * 0.03688316;
					text = "";
					colorBackground[] = {0,0,0,0};
				};

				class iPhone_X_separator_faceID: Life_RscText
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.69854219;
					y = safeZoneY + safeZoneH * 0.80258056;
					w = safeZoneW * 0.13914844;
					h = safeZoneH * 0.0025;
					colorBackground[] = {1,1,1,1};
				};

				class iPhone_X_base_faceID: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.5625;
					y = safeZoneY + safeZoneH * 0.21701389;
					w = safeZoneW * 0.41210938;
					h = safeZoneH * 0.72743056;
					text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
				};
			};
		};

		class iPhone_X_appCameraGroup: Life_RscControlsGroup
		{
			idc = 97502;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_X_appCamera: Life_RscPicture
				{
					idc = 97602;
					x = safeZoneX + safeZoneW * 0.61524219;
					y = safeZoneY + safeZoneH * 0.4569278;
					w = safeZoneW * 0.30720834;
					h = safeZoneH * 0.24834844;
					text = "";
				};

				class iPhone_X_icon_reverseCamera: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.63090625;
					y = safeZoneY + safeZoneH * 0.56302778;
					w = safeZoneW * 0.01632032;
					h = safeZoneH * 0.03661112;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_reverseCamera.paa";
				};

				class iPhone_X_button_reverseCamera: Life_RscButtonMenu
				{
					idc = 97603;
					x = safeZoneX + safeZoneW * 0.63090625;
					y = safeZoneY + safeZoneH * 0.56302778;
					w = safeZoneW * 0.01632032;
					h = safeZoneH * 0.03661112;
					action = "[] spawn A3PL_iPhoneX_appFrontCamera;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_base_appCamera: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.5625;
					y = safeZoneY + safeZoneH * 0.21701389;
					w = safeZoneW * 0.41210938;
					h = safeZoneH * 0.72743056;
					text = "A3PL_Common\GUI\phone\iPhone_X_base.paa";
					angle = -90;
				};

				class iPhone_X_icon_home_appCamera: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.61590625;
					y = safeZoneY + safeZoneH * 0.48002778;
					w = safeZoneW * 0.015;
					h = safeZoneH * 0.025;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
					angle = -90;
				};

				class iPhone_X_button_home_appCamera: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.61590625;
					y = safeZoneY + safeZoneH * 0.48002778;
					w = safeZoneW * 0.015;
					h = safeZoneH * 0.025;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appPhoneGroup: Life_RscControlsGroup
		{
			idc = 97503;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_X_phoneNumber: Life_RscEdit
                {
                    idc = 97613;
                    style = ST_CENTER;
                    x = safeZoneX + safeZoneW * 0.71898438;
                    y = safeZoneY + safeZoneH * 0.37263889;
                    w = safeZoneW * 0.10114063;
                    h = safeZoneH * 0.03;
                    text = "Number";
                    colorText[] = {0,0,0,1};
                    colorBackground[] = {0,0,0,0};
                    shadow = 0;
                    maxChars = 10;
                    sizeEx = 0.015 * safezoneW;
                    onMouseButtonClick = "_text = ctrlText 97613; if (_text isEqualTo ""Number"") then {ctrlSetText [97613,""""]};";
                };

				class iPhone_X_button_back: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.8225;
					y = safeZoneY + safeZoneH * 0.37563889;
					w = safeZoneW * 0.01;
					h = safeZoneH * 0.02;
					action = "ctrlSetText [97613,''];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appAddContactAppPhone: Life_RscButtonMenu
				{
					idc = 97656;
					x = safeZoneX + safeZoneW * 0.7065;
					y = safeZoneY + safeZoneH * 0.37563889;
					w = safeZoneW * 0.01;
					h = safeZoneH * 0.02;
					action = "[] spawn A3PL_iPhoneX_appAddContact";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_01: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.46141667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = ((ctrlText _display) + '1'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_02: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.46141667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '2'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_03: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.46141667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '3'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_04: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '4'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_05: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '5'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_06: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '6'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_07: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.59241667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '7'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_08: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.59241667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '8'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_09: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.59241667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '9'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_00: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.65861667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '0'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_star: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.65861667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '*'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_number_diese: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.65861667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_display = ((findDisplay 97000) displayCtrl 97613); if ((ctrlText _display) == 'Number') then {ctrlSetText [97613,''];}; _num = (ctrlText _display + '#'); _display ctrlSetText format['%1',_num];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_phoneCall: Life_RscButtonMenu
				{
					idc = 97660;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_phoneNumberContact = ctrlText 97613; [_phoneNumberContact] spawn A3PL_iPhoneX_sendCall;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appContactsListAppPhone: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.748625002;
					y = safeZoneY + safeZoneH * 0.81451667;
					w = safeZoneW * 0.0125;
					h = safeZoneH * 0.0225;
					action = "[] call A3PL_iPhoneX_appContactsList;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appPhone: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appPhone: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appContactsListGroup: Life_RscControlsGroup
		{
			idc = 97504;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_button_addContact: Life_RscButtonMenu
				{
					idc = 97654;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.33841667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] call A3PL_iPhoneX_appAddContact;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appContactsList: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appContactsList: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};

				class iPhone_X_appContactsListGroup_2: Life_RscControlsGroup
				{
					idc = 97514;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.4795;
					show = false;

					class VScrollbar
					{
						width = 0.004 * safezoneW;
						height = 0;
						autoScrollSpeed = -1;
						autoScrollDelay = 5;
						autoScrollRewind = 0;
						shadow = 0;
						scrollSpeed = 0.1;
						color[] = {1,0,0,0.6};
						colorActive[] = {0.5,0.5,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
						arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
						arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
						border = "#(argb,8,8,3)color(0,0,0,0.1)";
					};

		    		class HScrollbar : HScrollbar
		    		{
		        		height = 0;
		    		};

					class Controls
					{

					};
				};
			};
		};

		class iPhone_X_appAddContactGroup: Life_RscControlsGroup
		{
			idc = 97505;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_nameContact: Life_RscEdit
                {
                    idc = 97605;
                    style = ST_CENTER;
                    x = safeZoneX + safeZoneW * 0.70898438;
                    y = safeZoneY + safeZoneH * 0.43013889;
                    w = safeZoneW * 0.11914063;
                    h = safeZoneH * 0.027;
                    text = "Identity";
                    sizeEx = 0.015 * safezoneW;
                    colorText[] = {0,0,0,1};
                    colorBackground[] = {0,0,0,0};
                    shadow = 0;
                    maxChars = 19;
                    onMouseButtonClick = "_text = ctrlText 97605; if (_text isEqualTo ""Identity"") then {ctrlSetText [97605,""""]};";
                };

				class iPhone_X_phoneNumberContact: Life_RscEdit
				{
					idc = 97606;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.55113889;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Number";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 10;
					onMouseButtonClick = "_text = ctrlText 97606; if (_text isEqualTo ""Number"") then {ctrlSetText [97606,""""]};";
				};

				class iPhone_X_noteContact: Life_RscEdit
				{
					idc = 97658;
					style = ST_LEFT + ST_MULTI;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.58;
					w = safeZoneW * 0.131;
					h = safeZoneH * 0.066;
					text = "Note";
					sizeEx = 0.015 * safezoneW;
					lineSpacing = 1;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 65;
					onMouseButtonClick = "_text = ctrlText 97658; if (_text isEqualTo ""Note"") then {ctrlSetText [97658,""""]};";
				};

				class iPhone_X_button_okContact: Life_RscButtonMenu
				{
					idc = 97627;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_addContact";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appContactsListAppAddContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.70305002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.05824219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appContactsList";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appPhoneAppAddContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.776625002;
					y = safeZoneY + safeZoneH * 0.81451667;
					w = safeZoneW * 0.0125;
					h = safeZoneH * 0.0225;
					action = "[] spawn A3PL_iPhoneX_appPhone;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appAddContact: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appAddContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSMSListGroup: Life_RscControlsGroup
		{
			idc = 97506;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_button_addConversation: Life_RscButtonMenu
				{
					idc = 97655;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.33841667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appAddConversation;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appSMSList: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSMSList: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};

				class iPhone_X_appSMSListGroup_2: Life_RscControlsGroup
				{
					idc = 97516;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.4795;
					show = false;

					class VScrollbar
					{
						width = 0.004 * safezoneW;
						height = 0;
						autoScrollSpeed = -1;
						autoScrollDelay = 5;
						autoScrollRewind = 0;
						shadow = 0;
						scrollSpeed = 0.1;
						color[] = {1,0,0,0.6};
						colorActive[] = {0.5,0.5,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
						arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
						arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
						border = "#(argb,8,8,3)color(0,0,0,0.1)";
					};

		    		class HScrollbar : HScrollbar
		    		{
		        		height = 0;
		    		};

					class Controls
					{

					};
				};
			};
		};

		class iPhone_X_appAddConversationGroup: Life_RscControlsGroup
		{
			idc = 97507;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_nameConversation: Life_RscEdit
                {
                    idc = 97607;
                    style = ST_CENTER;
                    x = safeZoneX + safeZoneW * 0.70898438;
                    y = safeZoneY + safeZoneH * 0.43013889;
                    w = safeZoneW * 0.11914063;
                    h = safeZoneH * 0.027;
                    text = "Identity";
                    sizeEx = 0.015 * safezoneW;
                    colorText[] = {0,0,0,1};
                    colorBackground[] = {0,0,0,0};
                    shadow = 0;
                    maxChars = 19;
                    onMouseButtonClick = "_text = ctrlText 97607; if (_text isEqualTo ""Identity"") then {ctrlSetText [97607,""""]};";
                };

				class iPhone_X_phoneNumberConversation: Life_RscEdit
				{
					idc = 97608;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.55113889;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Number";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 10;
					onMouseButtonClick = "_text = ctrlText 97608; if (_text isEqualTo ""Number"") then {ctrlSetText [97608,""""]};";
				};

				class iPhone_X_button_okConversation: Life_RscButtonMenu
				{
					idc = 97629;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_addConversation";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appSMSListAppAddConversation: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.70305002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.05724219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appSMSList";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appAddConversation: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appAddConversation: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] spawn A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSettingsGroup: Life_RscControlsGroup
		{
			idc = 97508;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_button_wallpaper: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_AppWallpaper";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_sounds: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.40763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_AppSound";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_SIM: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.44263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_appSIM";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_GENERAL: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.47763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_appGeneral";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_grass_slider: Rsc_Slider
				{
					idc = 1900;
					x = safeZoneX + safeZoneW * 0.710375;
					y = safeZoneY + safeZoneH * 0.65488;
					w = safeZoneW * 0.117187;
					h = safeZoneH * 0.018185;
				};

				class iPhone_X_icon_home_appSettings: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSettings: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_Home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appContactGroup: Life_RscControlsGroup
		{
			idc = 97509;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_nameContactAppContact: Life_RscText
                {
                    idc = 97609;
                    style = ST_CENTER;
                    x = safeZoneX + safeZoneW * 0.70898438;
                    y = safeZoneY + safeZoneH * 0.43013889;
                    w = safeZoneW * 0.11914063;
                    h = safeZoneH * 0.027;
                    text = "";
                    sizeEx = 0.015 * safezoneW;
                    colorText[] = {0,0,0,1};
                    colorBackground[] = {0,0,0,0};
                    shadow = 0;
                };

				class iPhone_X_phoneNumberContactAppContact: Life_RscText
				{
					idc = 97610;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.55113889;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_noteContactAppContact: Life_RscText
				{
					idc = 97659;
					style = ST_LEFT + ST_MULTI + ST_NO_RECT;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.58;
					w = safeZoneW * 0.131;
					h = safeZoneH * 0.066;
					text = "";
					sizeEx = 0.015 * safezoneW;
					lineSpacing = 1;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_SMSAppContact: Life_RscButtonMenu
				{
					idc = 97657;
					x = safeZoneX + safeZoneW * 0.745;
					y = safeZoneY + safeZoneH * 0.47141667;
					w = safeZoneW * 0.02;
					h = safeZoneH * 0.03;
					action = "_nameContact = ctrlText 97609; _phoneNumberContact = ctrlText 97610; [_nameContact, _phoneNumberContact] spawn A3PL_iPhoneX_AppSMSFromContact";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_callAppContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7775;
					y = safeZoneY + safeZoneH * 0.47141667;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.03;
					action = "_phoneNumberContact = ctrlText 97610; [_phoneNumberContact] spawn A3PL_iPhoneX_SendCall;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_editContactAppContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] call A3PL_iPhoneX_DeleteContact;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appContactsListAppContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.70305002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.03824219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appContactsList";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appPhoneAppContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.776625002;
					y = safeZoneY + safeZoneH * 0.81451667;
					w = safeZoneW * 0.0125;
					h = safeZoneH * 0.0225;
					action = "[] spawn A3PL_iPhoneX_appPhone;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appContact: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appContact: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_Home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSMSGroup: Life_RscControlsGroup
		{
			idc = 97510;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_nameContactAppSMS: Life_RscText
                {
                    idc = 97620;
                    style = ST_CENTER;
                    x = safeZoneX + safeZoneW * 0.70898438;
                    y = safeZoneY + safeZoneH * 0.33741667;
                    w = safeZoneW * 0.11914063;
                    h = safeZoneH * 0.027;
                    text = "";
                    sizeEx = 0.015 * safezoneW;
                    colorText[] = {0,0,0,1};
                    colorBackground[] = {0,0,0,0};
                    shadow = 0;
                };

				class iPhone_X_SMS: Life_RscEdit
				{
					idc = 97621;
					style = ST_LEFT;
					x = safeZoneX + safeZoneW * 0.73;
					y = safeZoneY + safeZoneH * 0.8175;
					w = safeZoneW * 0.084;
					h = safeZoneH * 0.02;
					text = "Message...";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 1500;
					onMouseButtonClick = "_text = ctrlText 97621; if (_text isEqualTo ""Message..."") then {ctrlSetText [97621,""""]};";
				};

				class iPhone_X_button_sendSMS: Life_RscButtonMenu
				{
					idc = 97622;
					x = safeZoneX + safeZoneW * 0.8178;
					y = safeZoneY + safeZoneH * 0.8155;
					w = safeZoneW * 0.0115;
					h = safeZoneH * 0.0235;
					action = "_message = ctrlText 97621; [_message] spawn A3PL_iPhoneX_sendSMS; _sms = ((findDisplay 97000) displayCtrl 97621); _sms ctrlSetText ""Message...""";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_smiley: Life_RscButtonMenu
				{
					idc = 97623;
					x = safeZoneX + safeZoneW * 0.708;
					y = safeZoneY + safeZoneH * 0.8145;
					w = safeZoneW * 0.018;
					h = safeZoneH * 0.027;
					action = "";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_appSMSListAppSMS: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.70305002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.01024219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appSMSList";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appSMS: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSMS: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};

				class iPhone_X_appSMSGroup_2: Life_RscControlsGroup
				{
					idc = 97511;
					x = safeZoneX + safeZoneW * 0.703;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.134;
					h = safeZoneH * 0.435;
					show = false;

					class VScrollbar
					{
						width = 0.004 * safezoneW;
						height = 0;
						autoScrollSpeed = -1;
						autoScrollDelay = 5;
						autoScrollRewind = 0;
						shadow = 0;
						scrollSpeed = 0.1;
						color[] = {1,0,0,0.6};
						colorActive[] = {0.5,0.5,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
						arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
						arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
						border = "#(argb,8,8,3)color(0,0,0,0.1)";
					};

		    		class HScrollbar : HScrollbar
		    		{
		        		height = 0;
		    		};

					class Controls
					{

					};
				};
			};
		};

		class iPhone_X_appWallpaperGroup: Life_RscControlsGroup
		{
			idc = 97512;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_picture_wallpaper_01: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.664;
					y = safeZoneY + safeZoneH * 0.35063889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_1.paa";
				};

				class iPhone_X_picture_wallpaper_02: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7075;
					y = safeZoneY + safeZoneH * 0.35063889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_2.paa";
				};

				class iPhone_X_picture_wallpaper_03: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.751;
					y = safeZoneY + safeZoneH * 0.35063889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_3.paa";
				};

				class iPhone_X_picture_wallpaper_04: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.664;
					y = safeZoneY + safeZoneH * 0.502;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_4.paa";
				};

				class iPhone_X_picture_wallpaper_05: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7075;
					y = safeZoneY + safeZoneH * 0.502;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_5.paa";
				};

				class iPhone_X_picture_wallpaper_06: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.751;
					y = safeZoneY + safeZoneH * 0.502;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_6.paa";
				};

				class iPhone_X_picture_wallpaper_07: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.664;
					y = safeZoneY + safeZoneH * 0.65813889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_7.paa";
				};

				class iPhone_X_picture_wallpaper_08: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7075;
					y = safeZoneY + safeZoneH * 0.65813889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_8.paa";
				};

				class iPhone_X_picture_wallpaper_09: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.751;
					y = safeZoneY + safeZoneH * 0.65813889;
					w = safeZoneW * 0.1225;
					h = safeZoneH * 0.197;
					text = "A3PL_Common\GUI\phone\iPhone_X_background_9.paa";
				};

				class iPhone_X_button_wallpaper_01: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.705;
					y = safeZoneY + safeZoneH * 0.375;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [1]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_02: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.74825;
					y = safeZoneY + safeZoneH * 0.375;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [2]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_03: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7915;
					y = safeZoneY + safeZoneH * 0.375;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [3]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_04: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.705;
					y = safeZoneY + safeZoneH * 0.5275;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [4]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_05: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.74825;
					y = safeZoneY + safeZoneH * 0.5275;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [5]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_06: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7915;
					y = safeZoneY + safeZoneH * 0.5275;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [6]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_07: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.705;
					y = safeZoneY + safeZoneH * 0.68;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [7]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_08: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.74825;
					y = safeZoneY + safeZoneH * 0.68;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [8]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_wallpaper_09: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.7915;
					y = safeZoneY + safeZoneH * 0.68;
					w = safeZoneW * 0.041;
					h = safeZoneH * 0.148;
					action = "[player, [9]] remoteExec [""Server_iPhoneX_saveWallpaper"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appWallpaper: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appWallpaper: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSoundGroup: Life_RscControlsGroup
		{
			idc = 97513;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_text_sound_1: Life_RscText
				{
					idc = 97714;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.40163889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Song 1";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_sound_2: Life_RscText
				{
					idc = 97715;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.43663889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Song 2";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_sound_3: Life_RscText
				{
					idc = 97716;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.4716;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Song 3";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_sound_1: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.40163889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[player, [1]] remoteExec [""Server_iPhoneX_saveSound"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_sound_2: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.43663889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[player, [2]] remoteExec [""Server_iPhoneX_saveSound"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_sound_3: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.4716;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[player, [3]] remoteExec [""Server_iPhoneX_saveSound"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_silent: Life_RscPicture
				{
					idc = 97717;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.5086;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.025;
					text = "";
				};

				class iPhone_X_text_silent: Life_RscText
				{
					idc = 97718;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.5066;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Silent";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_silent: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.5066;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_silent";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appSound: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSound: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appGeneralGroup: Life_RscControlsGroup
		{
			idc = 97519;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_text_general_1: Life_RscText
				{
					idc = 99714;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.40163889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "HUD";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_general_2: Life_RscText
				{
					idc = 99715;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.43663889;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Twitter";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_general_3: Life_RscText
				{
					idc = 99716;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.4716;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "IDs";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_silent: Life_RscText
				{
					idc = 97720;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.5066;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					text = "Notifications";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_icon_hud: Life_RscPicture
				{
					idc = 99719;
					x = safeZoneX + safeZoneW * 0.808496;
					y = safeZoneY + safeZoneH * 0.396611;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.025;
					text = "";
				};

				class iPhone_X_button_hud: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.715948;
					y = safeZoneY + safeZoneH * 0.396611;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_hud";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_twitter: Life_RscPicture
				{
					idc = 99718;
					x = safeZoneX + safeZoneW * 0.808496;
					y = safeZoneY + safeZoneH * 0.434207;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.025;
					text = "";
				};

				class iPhone_X_button_twitter: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.715948;
					y = safeZoneY + safeZoneH * 0.434207;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_twitter";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_idplayer: Life_RscPicture
				{
					idc = 99721;
					x = safeZoneX + safeZoneW * 0.808496;
					y = safeZoneY + safeZoneH * 0.471803;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.025;
					text = "";
				};

				class iPhone_X_button_idplayer: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.715948;
					y = safeZoneY + safeZoneH * 0.471803;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_idplayer";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_notification: Life_RscPicture
				{
					idc = 99722;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.5086;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.025;
					text = "";
				};

				class iPhone_X_button_silent: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.719;
					y = safeZoneY + safeZoneH * 0.5066;
					w = safeZoneW * 0.118;
					h = safeZoneH * 0.03;
					action = "[] spawn A3PL_iPhoneX_notification";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appGeneral: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appGeneral: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSIMGroup: Life_RscControlsGroup
		{
			idc = 97515;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_text_SIM_1: Life_RscText
				{
					idc = 97616;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "PRIMARY : No SIM";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_SIM_2: Life_RscText
				{
					idc = 97617;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.40763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "SECONDARY : No SIM";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_SIM_3: Life_RscText
				{
					idc = 97618;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.44263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "COMPANY : No SIM";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_SIM_1: Life_RscButtonMenu
				{
					idc = 97719;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[player, A3PL_phoneNumberPrimary] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_SIM_2: Life_RscButtonMenu
				{
					idc = 97720;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.40763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[player, A3PL_phoneNumberSecondary] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_SIM_3: Life_RscButtonMenu
				{
					idc = 97721;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.44263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[player, A3PL_phoneNumberEnterprise] remoteExec [""Server_iPhoneX_UpdatePhoneNumberActive"",2];";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appSIM: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSIM: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appUberGroup: Life_RscControlsGroup
		{
			idc = 10515;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_text_Uber_1: Life_RscText
				{
					idc = 10616;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "Call uber";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_Uber_2: Life_RscText
				{
					idc = 10617;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.40763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "Become uber";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_text_Uber_3: Life_RscText
				{
					idc = 10618;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.44263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					text = "Leave work";
					sizeEx = 0.0175 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_Uber_1: Life_RscButtonMenu
				{
					idc = 10719;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] call A3PL_Uber_requestDriver;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_Uber_2: Life_RscButtonMenu
				{
					idc = 10720;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.40763889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] call A3PL_Uber_addDriver;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_button_Uber_3: Life_RscButtonMenu
				{
					idc = 10721;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.44263889;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.03;
					action = "[] call A3PL_Uber_removeDriver;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appUBER: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appUBER: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appNotificationsGroup: Life_RscControlsGroup
		{
			idc = 97801;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_background_notifications: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.5625;
					y = safeZoneY + safeZoneH * -0.05;
					w = safeZoneW * 0.41210938;
					h = safeZoneH * 0.72743056;
					text = "A3PL_Common\GUI\phone\iPhone_X_bottom.paa";
				};

				class iPhone_X_nameContact_notifications: Life_RscText
				{
					idc = 97802;
					style = ST_LEFT;
					x = safeZoneX + safeZoneW * 0.72088282;
					y = safeZoneY + safeZoneH * 0.515;
					w = safeZoneW * 0.09532032;
					h = safeZoneH * 0.04541667;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0.98,0.027,0.027,1};
					shadow = 0;
				};

				class iPhone_X_SMS_notifications: Life_RscText
                {
                    idc = 97803;
                    style = ST_LEFT;
                    x = safeZoneX + safeZoneW * 0.72088282;
                    y = safeZoneY + safeZoneH * 0.53;
                    w = safeZoneW * 0.09532032;
                    h = safeZoneH * 0.04541667;
                    text = "";
                    sizeEx = 0.015 * safezoneW;
                    colorText[] = {1,1,1,1};
                    shadow = 0;
                };

				class iPhone_X_time_notifications: Life_RscText
				{
					idc = 97804;
					style = ST_LEFT;
					x = safeZoneX + safeZoneW * 0.72088282;
					y = safeZoneY + safeZoneH * 0.545;
					w = safeZoneW * 0.09532032;
					h = safeZoneH * 0.04541667;
					text = "";
					sizeEx = 0.0135 * safezoneW;
					colorText[] = {1,1,1,1};
					shadow = 0;
				};

				class iPhone_X_icon_SMS: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.707046878;
					y = safeZoneY + safeZoneH * 0.5384;
					w = safeZoneW * 0.01446094;
					h = safeZoneH * 0.02693056;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_sms.paa";
				};
			};
		};

		class iPhone_X_appCallGroup: Life_RscControlsGroup
		{
			idc = 97517;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_phoneNumberAppCall: Life_RscText
				{
					idc = 97661;
					style = ST_CENTER;
					x = safeZoneX + safeZoneW * 0.72088282;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.09532032;
					h = safeZoneH * 0.04541667;
					text = "";
					sizeEx = 0.025 * safezoneW;
					colorText[] = {1,1,1,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_informations: Life_RscText
				{
					idc = 97670;
					style = ST_CENTER;
					x = safeZoneX + safeZoneW * 0.71898438;
					y = safeZoneY + safeZoneH * 0.41263889;
					w = safeZoneW * 0.10114063;
					h = safeZoneH * 0.03;
					text = "";
					colorText[] = {1,1,1,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_picture_unhookValidate: Life_RscPicture
				{
					idc = 97675;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_unhook.paa";
				};

				class iPhone_X_button_unhookValidate: Life_RscButtonMenu
				{
					idc = 97676;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_hangup: Life_RscPicture
				{
					idc = 97667;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_hangup.paa";
				};

				class iPhone_X_button_hangup: Life_RscButtonMenu
				{
					idc = 97663;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_hangupValidate: Life_RscPicture
				{
					idc = 97677;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_hangup.paa";
				};

				class iPhone_X_button_hangupValidate: Life_RscButtonMenu
				{
					idc = 97678;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.72471667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_increaseVolume: Life_RscPicture
				{
					idc = 97668;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_increaseVolume.paa";
				};

				class iPhone_X_button_increaseVolume: Life_RscButtonMenu
				{
					idc = 97664;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_radio = call TFAR_fnc_ActiveSWRadio; _volume = _radio call TFAR_fnc_getSwVolume; if (_volume < 10) then {_volume = _volume + 1}; [_radio, _volume] call TFAR_fnc_setSwVolume;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_decreaseVolume: Life_RscPicture
				{
					idc = 97669;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.59241667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_decreaseVolume.paa";
				};

				class iPhone_X_button_decreaseVolume: Life_RscButtonMenu
				{
					idc = 97665;
					x = safeZoneX + safeZoneW * 0.755625002;
					y = safeZoneY + safeZoneH * 0.59241667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_radio = call TFAR_fnc_ActiveSWRadio; _volume = _radio call TFAR_fnc_getSwVolume; if !(_volume isEqualTo 0) then {_volume = _volume - 1}; [_radio, _volume] call TFAR_fnc_setSwVolume;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_speakers: Life_RscPicture
				{
					idc = 97671;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_speakersOFF.paa";
				};

				class iPhone_X_button_speakers: Life_RscButtonMenu
				{
					idc = 97672;
					x = safeZoneX + safeZoneW * 0.797046878;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "_radio = call TFAR_fnc_ActiveSWRadio; [_radio] call TFAR_fnc_setSwSpeakers; _speakers = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers; if (_speakers) then {ctrlSetText [97671,""A3PL_Common\GUI\phone\iPhone_X_icon_speakersON.paa""];} else {ctrlSetText [97671,""A3PL_Common\GUI\phone\iPhone_X_icon_speakersOFF.paa""];};";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_picture_mute: Life_RscPicture
				{
					idc = 97673;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_muteOFF.paa";
				};

				class iPhone_X_button_mute: Life_RscButtonMenu
				{
					idc = 97674;
					x = safeZoneX + safeZoneW * 0.714503126;
					y = safeZoneY + safeZoneH * 0.52641667;
					w = safeZoneW * 0.025;
					h = safeZoneH * 0.045;
					action = "if !(player getVariable [""tf_unable_to_use_radio"", false]) then {player setVariable [""tf_unable_to_use_radio"", true]; ctrlSetText [97673,""A3PL_Common\GUI\phone\iPhone_X_icon_muteON.paa""];} else {player setVariable [""tf_unable_to_use_radio"", false]; ctrlSetText [97673,""A3PL_Common\GUI\phone\iPhone_X_icon_muteOFF.paa""];};";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};
			};
		};

		class iPhone_X_appPMCGroup: Life_RscControlsGroup
		{
			idc = 98133;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class Separator_01: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.389;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};



				class Separator_02: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.409;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};



				class Separator_03: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.429;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};

				class Separator_04: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.449;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};

				class Separator_05: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.469;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};



				class Separator_06: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.489;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};


				class Separator_07: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.509;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};


				class Separator_08: Life_RscText
				{
					idc = -1;
					style = ST_HUD_BACKGROUND;
					x = safeZoneX + safeZoneW * 0.70215;
					y = safeZoneY + safeZoneH * 0.529;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.001;
					colorBackground[] = {0.8,0.8,0.8,1};
				};

				class iPhone_X_icon_home_appPMC: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appPMC: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appSwitchboardGroup: Life_RscControlsGroup
		{
			idc = 98260;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_icon_home_appSwitchboardList: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appSwitchboardList: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};

				class iPhone_X_appSwitchboardListGroup_2: Life_RscControlsGroup
				{
					idc = 98261;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.4795;
					show = false;

					class VScrollbar
					{
						width = 0.004 * safezoneW;
						height = 0;
						autoScrollSpeed = -1;
						autoScrollDelay = 5;
						autoScrollRewind = 0;
						shadow = 0;
						scrollSpeed = 0.1;
						color[] = {1,0,0,0.6};
						colorActive[] = {0.5,0.5,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
						arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
						arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
						border = "#(argb,8,8,3)color(0,0,0,0.1)";
					};

		    		class HScrollbar : HScrollbar
		    		{
		        		height = 0;
		    		};

					class Controls
					{

					};
				};
			};
		};

		class iPhone_X_appEventGroup: Life_RscControlsGroup
		{
			idc = 98270;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{

				class iPhone_X_button_addEvent: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.33841667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appAddEvent;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appEvent: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appEvent: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};

				class iPhone_X_appEventGroup_2: Life_RscControlsGroup
				{
					idc = 98271;
					x = safeZoneX + safeZoneW * 0.702;
					y = safeZoneY + safeZoneH * 0.37;
					w = safeZoneW * 0.135;
					h = safeZoneH * 0.4795;
					show = false;

					class VScrollbar
					{
						width = 0.004 * safezoneW;
						height = 0;
						autoScrollSpeed = -1;
						autoScrollDelay = 5;
						autoScrollRewind = 0;
						shadow = 0;
						scrollSpeed = 0.1;
						color[] = {1,0,0,0.6};
						colorActive[] = {0.5,0.5,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(0,0,0,0.25)";
						arrowEmpty = "#(argb,8,8,3)color(0,0,0,0.1)";
						arrowFull = "#(argb,8,8,3)color(0,0,0,0.1)";
						border = "#(argb,8,8,3)color(0,0,0,0.1)";
					};

		    		class HScrollbar : HScrollbar
		    		{
		        		height = 0;
		    		};

					class Controls
					{

					};
				};
			};
		};

		class iPhone_X_appEventLoadGroup: Life_RscControlsGroup
		{
			idc = 98280;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_X_nameEvent: Life_RscText
				{
					idc = 98281;
					style = ST_CENTER;
					x = safeZoneX + safeZoneW * 0.70898438;
					y = safeZoneY + safeZoneH * 0.43013889;
					w = safeZoneW * 0.11914063;
					h = safeZoneH * 0.027;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_descriptionEvent: Life_RscText
				{
					idc = 98282;
					style = ST_LEFT + ST_MULTI + ST_NO_RECT;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.58;
					w = safeZoneW * 0.131;
					h = safeZoneH * 0.066;
					text = "";
					sizeEx = 0.015 * safezoneW;
					lineSpacing = 1;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_nameOwnerEvent: Life_RscText
				{
					idc = 98283;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.60;
					w = safeZoneW * 0.131;
					h = safeZoneH * 0.066;
					text = "";
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_dateEvent: Life_RscText
				{
					idc = 98284;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.62;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_timeEvent: Life_RscText
				{
					idc = 98285;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.64;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_priceEvent: Life_RscText
				{
					idc = 98286;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.66;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_positionEvent: Life_RscText
				{
					idc = 98287;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.68;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_phoneNumberAddEvent: Life_RscText
				{
					idc = 98288;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.70;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
				};

				class iPhone_X_button_appEventAppEventLoad: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.70305002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.03824219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_appEvent";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appEventLoad: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appEventLoad: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appBank: Life_RscControlsGroup
		{
			idc = 97580;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_SendAmount: Life_RscEdit
				{
					idc = 99401;
					x = 0.742344 * safezoneW + safezoneX;
					y = 0.643 * safezoneH + safezoneY;
					w = 0.0825 * safezoneW;
					h = 0.022 * safezoneH;
					text = "Amount to send";
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 15;
					onSetFocus = "_text = ctrlText 99401; if (_text isEqualTo ""Amount to send"") then {ctrlSetText [99401,""""]};";
				};
				class iPhone_Button_SendAmount: Life_RscButtonMenu
				{
					idc = -1;
					x = 0.70625 * safezoneW + safezoneX;
					y = 0.632 * safezoneH + safezoneY;
					w = 0.0257812 * safezoneW;
					h = 0.044 * safezoneH;
					action = "[] call A3RL_iPhoneX_bankSend;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};
				class iPhone_BankAmount: Life_RscStructuredText
				{
					idc = 99400;
					x = 0.711406 * safezoneW + safezoneX;
					y = 0.434 * safezoneH + safezoneY;
					w = 0.113437 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class iPhone_BankPlayersList: Life_RscCombo
				{
					idc = 99402;
					x = 0.70625 * safezoneW + safezoneX;
					y = 0.599 * safezoneH + safezoneY;
					w = 0.12375 * safezoneW;
					h = 0.022 * safezoneH;
				};

				class iPhone_X_icon_home_appBank: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appBank: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_appAddEventGroup: Life_RscControlsGroup
		{
			idc = 98290;
			w = 1.5 * safezoneW;
			h = 1.5 * safezoneH;
			show = false;

			class VScrollbar : VScrollbar
			{
       			width = 0;
    		};

    		class HScrollbar : HScrollbar
    		{
        		height = 0;
    		};

			class Controls
			{
				class iPhone_X_nameAddEvent: Life_RscEdit
				{
					idc = 98291;
					style = ST_CENTER;
					x = safeZoneX + safeZoneW * 0.70898438;
					y = safeZoneY + safeZoneH * 0.43013889;
					w = safeZoneW * 0.11914063;
					h = safeZoneH * 0.027;
					text = "Your Event";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 19;
					onSetFocus = "_text = ctrlText 98291; if (_text isEqualTo ""Your Event"") then {ctrlSetText [98291,""""]};";
				};

				class iPhone_X_nameOwnerAddEvent: Life_RscEdit
				{
					idc = 98292;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.62;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Identity";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 19;
					onSetFocus = "_text = ctrlText 98292; if (_text isEqualTo ""Identity"") then {ctrlSetText [98292,""""]};";
				};

				class iPhone_X_dateAddEvent: Life_RscEdit
				{
					idc = 98293;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.64;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "jj/mm/aaaa";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					onSetFocus = "_text = ctrlText 98293; if (_text isEqualTo ""jj/mm/aaaa"") then {ctrlSetText [98293,""""]};";
				};

				class iPhone_X_timeAddEvent: Life_RscEdit
				{
					idc = 98294;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.66;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "hh:mm";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					onSetFocus = "_text = ctrlText 98294; if (_text isEqualTo ""hh:mm"") then {ctrlSetText [98294,""""]};";
				};

				class iPhone_X_priceAddEvent: Life_RscEdit
				{
					idc = 98295;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.70;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Price";
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 10;
					onSetFocus = "_text = ctrlText 98295; if (_text isEqualTo ""Price"") then {ctrlSetText [98295,""""]};";
				};

				class iPhone_X_descriptionAddEvent: Life_RscEdit
				{
					idc = 98296;
					style = ST_LEFT + ST_MULTI;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.50;
					w = safeZoneW * 0.131;
					h = safeZoneH * 0.066;
					text = "Description";
					sizeEx = 0.015 * safezoneW;
					lineSpacing = 1;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					onSetFocus = "_text = ctrlText 98296; if (_text isEqualTo ""Description"") then {ctrlSetText [98296,""""]};";
				};

				class iPhone_X_positionAddEvent: Life_RscEdit
				{
					idc = 98297;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.68;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Position";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					onSetFocus = "_text = ctrlText 98297; if (_text isEqualTo ""Position"") then {ctrlSetText [98297,""""]};";
				};

				class iPhone_X_phoneNumberAddEvent: Life_RscEdit
				{
					idc = 98298;
					x = safeZoneX + safeZoneW * 0.70398438;
					y = safeZoneY + safeZoneH * 0.72;
					w = safeZoneW * 0.059;
					h = safeZoneH * 0.0225;
					text = "Contact";
					sizeEx = 0.015 * safezoneW;
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					shadow = 0;
					maxChars = 10;
					onSetFocus = "_text = ctrlText 98298; if (_text isEqualTo ""Contact"") then {ctrlSetText [98298,""""]};";
				};

				class iPhone_X_button_okEvent: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.82205002;
					y = safeZoneY + safeZoneH * 0.34141667;
					w = safeZoneW * 0.01074219;
					h = safeZoneH * 0.01909723;
					action = "[] spawn A3PL_iPhoneX_addEvent";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};
				};

				class iPhone_X_icon_home_appEventLoad: Life_RscPicture
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					text = "A3PL_Common\GUI\phone\iPhone_X_icon_home.paa";
				};

				class iPhone_X_button_home_appEventLoad: Life_RscButtonMenu
				{
					idc = -1;
					x = safeZoneX + safeZoneW * 0.80948282;
					y = safeZoneY + safeZoneH * 0.31525;
					w = safeZoneW * 0.0175;
					h = safeZoneH * 0.0175;
					action = "[] call A3PL_iPhoneX_home;";
					colorBackground[] = {0,0,0,0};
					colorBackground2[] = {0,0,0,0};
					colorBackgroundFocused[] = {0,0,0,0};

					class Attributes
					{
						align = "center";
					};
				};
			};
		};

		class iPhone_X_base: Life_RscPicture
		{
			idc = 97001;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.21701389;
			w = safeZoneW * 0.41210938;
			h = safeZoneH * 0.72743056;
			text = "";
		};

		class iPhone_X_button_master: Life_RscButtonMenu
		{
			idc = 97005;
			x = safeZoneX + safeZoneW * 0.69894219;
			y = safeZoneY + safeZoneH * 0.30690278;
			w = safeZoneW * 0.13914844;
			h = safeZoneH * 0.54570834;
			action = "if !(A3PL_phoneOn) then {[] spawn A3PL_iPhoneX_start;} else {[] call A3PL_iPhoneX_home;};";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
		};

		class iPhone_X_button_notifications: Life_RscButtonMenu
		{
			idc = 97805;
			x = safeZoneX + safeZoneW * 0.69894219;
			y = safeZoneY + safeZoneH * 0.52490278;
			w = safeZoneW * 0.13914844;
			h = safeZoneH * 0.055;
			action = "_nameContact = ctrlText 97802; _lastSMS = player getVariable [""iPhone_X_lastSMS"", []]; _phoneNumberContact = _lastSMS select 3; [_nameContact, _phoneNumberContact] spawn A3PL_iPhoneX_appSMSFromNotification;";
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {0,0,0,0};
			colorBackgroundFocused[] = {0,0,0,0};
			show = false;
		};
	};
};

class iPhone_X_contacts: Life_RscControlsGroup
{
	idc = 98000;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.052;

	class Controls
	{
		class iPhone_X_contactName: Life_RscText
		{
			idc = 98002;
			style = ST_LEFT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.02;
			text = "";
			sizeEx = 0.02 * safezoneW;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};

		class iPhone_X_contactNumber: Life_RscText
		{
			idc = 98003;
			style = ST_LEFT;
			x = 0;
			y = 0.02 * safezoneW;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.018;
			text = "";
			sizeEx = 0.018 * safezoneW;
			colorText[] = {0.62,0.62,0.62,1};
			shadow = 0;
		};

		class Separator: Life_RscText
		{
			idc = 98004;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = (0.02 * safezoneW) + (0.018 * safezoneW);
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.001;
			colorBackground[] = {0.8,0.8,0.8,1};
		};
	};
};

class iPhone_X_conversations: Life_RscControlsGroup
{
    idc = 98100;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.052;

    class Controls
    {
        class iPhone_X_SMSListContactName: Life_RscText
        {
            idc = 98101;
            style = ST_LEFT;
            x = 0;
            y = 0;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.02;
            text = "";
            sizeEx = 0.02 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        };

        class iPhone_X_SMSListLastSMS: Life_RscText
        {
            idc = 98102;
            style = ST_LEFT;
            x = 0;
            y = 0.02 * safezoneW;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.018;
            text = "";
            sizeEx = 0.018 * safezoneW;
            colorText[] = {0.62,0.62,0.62,1};
            shadow = 0;
        };

        class Separator: Life_RscText
        {
            idc = 98103;
            style = ST_HUD_BACKGROUND;
            x = 0;
            y = (0.02 * safezoneW) + (0.018 * safezoneW);
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.001;
            colorBackground[] = {0.8,0.8,0.8,1};
        };
    };
};

class iPhone_X_receiveSMS: Life_RscControlsGroup
{
	idc = 98110;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;

	class Controls
	{
		class iPhone_X_backgroundReceiveSMS: Life_RscText
		{
			idc = 98111;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0965;
			h = safeZoneH * 0.02;
			colorBackground[] = {0.6,0.8,1,0.8};
		};

		class iPhone_X_messageReceiveSMS: Life_RscStructuredText
		{
			idc = 98112;
			style = ST_LEFT + ST_MULTI + ST_NO_RECT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0915;
			h = safeZoneH * 0.02;
			sizeEx = 0.0175 * safezoneW;
			lineSpacing = 0.8;
			text = "";
			colorText[] = {0.1,0.1,0.1,0.8};
			shadow = 0;
		};
	};
};

class iPhone_X_sendSMS: Life_RscControlsGroup
{
    idc = 98120;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.05;

    class Controls
    {
        class iPhone_X_backgroundSendSMS: Life_RscText
        {
            idc = 98111;
            style = ST_HUD_BACKGROUND;
            x = (safeZoneW * 0.135) - (safeZoneW * 0.10225);
            y = 0;
            w = safeZoneW * 0.0965;
            h = safeZoneH * 0.02;
            colorBackground[] = {1,1,0.4,0.8};
        };

        class iPhone_X_messageSendSMS: Life_RscStructuredText
        {
            idc = 98112;
            style = ST_LEFT + ST_MULTI + ST_NO_RECT;
            x = (safeZoneW * 0.135) - (safeZoneW * 0.10225);
            y = 0;
            w = safeZoneW * 0.0915;
            h = safeZoneH * 0.02;
            sizeEx = 0.015 * safezoneW;
            lineSpacing = 0.8;
            text = "";
            colorText[] = {0.1,0.1,0.1,1};
            shadow = 0;
        };
    };
};

class iPhone_X_SMSEnterprise: Life_RscControlsGroup
{
	idc = 98057;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;

	class Controls
	{
		class iPhone_X_backgroundSMSEnterprise: Life_RscText
		{
			idc = 98058;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0965;
			h = safeZoneH * 0.02;
			colorBackground[] = {0.6,0.8,1,0.8};
		};

		class iPhone_X_messageSMSEnterprise: Life_RscStructuredText
		{
			idc = 98059;
			style = ST_LEFT + ST_MULTI + ST_NO_RECT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.0915;
			h = safeZoneH * 0.02;
			sizeEx = 0.0175 * safezoneW;
			lineSpacing = 0.8;
			text = "";
			colorText[] = {0.1,0.1,0.1,0.8};
			shadow = 0;
		};
	};
};

class iPhone_X_switchboard: Life_RscControlsGroup
{
    idc = 98055;
    x = 0;
    y = 0;
    w = safeZoneW * 0.135;
    h = safeZoneH * 0.05;

    class Controls
    {
        class iPhone_X_fromNumberAppSwitchboard: Life_RscText
        {
            idc = 98056;
            style = ST_LEFT;
            x = 0;
            y = 0;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.02;
            text = "";
            sizeEx = 0.02 * safezoneW;
            colorText[] = {0,0,0,1};
            shadow = 0;
        };

        class Separator: Life_RscText
        {
            idc = -1;
            style = ST_HUD_BACKGROUND;
            x = 0;
            y = 0.02 * safezoneW;
            w = safeZoneW * 0.135;
            h = safeZoneH * 0.001;
            colorBackground[] = {0.8,0.8,0.8,1};
        };
    };
};

class iPhone_X_events: Life_RscControlsGroup
{
	idc = 98060;
	x = 0;
	y = 0;
	w = safeZoneW * 0.135;
	h = safeZoneH * 0.05;

	class Controls
	{
		class iPhone_X_nameEvent: Life_RscText
		{
			idc = 98061;
			style = ST_LEFT;
			x = 0;
			y = 0;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.02;
			text = "";
			sizeEx = 0.02 * safezoneW;
			colorText[] = {0,0,0,1};
			shadow = 0;
		};

		class iPhone_X_priceEvent: Life_RscText
		{
			idc = 98062;
			style = ST_LEFT;
			x = 0;
			y = safeZoneY + safeZoneH * 0.2475;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.018;
			text = "";
			sizeEx = 0.018 * safezoneW;
			colorText[] = {0.62,0.62,0.62,1};
			shadow = 0;
		};

		class Separator: Life_RscText
		{
			idc = -1;
			style = ST_HUD_BACKGROUND;
			x = 0;
			y = safeZoneY + safeZoneH * 0.2725;
			w = safeZoneW * 0.135;
			h = safeZoneH * 0.001;
			colorBackground[] = {0.8,0.8,0.8,1};
		};
	};
};