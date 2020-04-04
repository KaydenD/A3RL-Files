class DefaultEventhandlers;
class CfgPatches {

	class A3PLS {

		author[]= {

			"Muse"
		};
		fileName="A3PLS.pbo";
		units[]={};
		weapons[]={};
		requiredAddons[]= {

			"A3PL_Cars"
		};
	};
};
class cfgFunctions {

	class bootstrap {

		class main {

			file="\A3PLS";
			class preinit {

				preinit=1;
			};
		};
	};
};
class CfgRemoteExec {

	class Commands {

		mode=2;
	};
	class Functions {

		mode=2;
		jip=0;
		class A3PL_Player_SetMarkers{allowedTargets=0;};
		class BIS_fnc_effectKilledAirDestruction {
		};
		class BIS_fnc_effectKilledSecondaries {
		};
		class BIS_fnc_objectVar {
		};
		class Server_Core_Restart{allowedTargets=2;};
		class A3PL_Medical_DeadMarker{allowedTargets=0;};
		class server_uber_adddriver {
			allowedTargets=2;
		};
		class server_uber_requestdriver {
			allowedTargets=2;
		};
		class a3pl_debug_executecompiled {
			allowedTargets=2;
		};
		class Server_Inventory_Add {
			allowedTargets=2;
		};
		class Server_Vehicle_Trailer_Hitch {
			allowedTargets=2;
		};
		class Server_Bowling_LocalityRequest {
			allowedTargets=2;
		};
		class Server_Fire_VehicleExplode {
			allowedTargets=2;
		};
		class Server_Vehicle_Spawn {
			allowedTargets=2;
		};
		class Server_Player_BLVariablesSetup {
			allowedTargets=2;
		};
		class Server_Gear_NewReceive {
			allowedTargets=2;
		};
		class Server_Core_ChangeVar {
			allowedTargets=2;
		};
		class A3PL_Lib_SyncAnim {
			allowedTargets=0;
		};
		class A3PL_Lib_Gesture {
			allowedTargets=0;
		};
		class A3PL_Vehicle_GiveKeys {
			allowedTargets=0;
		};
		class A3PL_Lib_Skiptime {
			allowedTargets=2;
		};
		class Server_Housing_dropKey {
			allowedTargets=2;
		};
		class A3PL_Police_Panic_Marker {
			allowedTargets=0;
		};
		class Server_Inventory_Drop {
			allowedTargets=2;
		};
		class Server_Housing_PickupKey {
			allowedTargets=2;
		};
		class Server_Inventory_Pickup {
			allowedTargets=2;
		};
		class A3PL_Items_ThrowPopcorn {
			allowedTargets=0;
		};
		class Server_NPC_RequestJob {
			allowedTargets=2;
		};
		class Server_Shop_Sell {
			allowedTargets=2;
		};
		class Server_Shop_Buy {
			allowedTargets=2;
		};
		class A3PL_Police_HandleAnim {
			allowedTargets=0;
		};
		class A3PL_Police_SurrenderAnim {
			allowedTargets=0;
		};
		class A3PL_USCG_DragReceive {
			allowedTargets=0;
		};
		class A3PL_Police_DragReceive {
			allowedTargets=0;
		};
		class A3PL_Lib_MoveInPass {
			allowedTargets=0;
		};
		class Server_Police_Impound {
			allowedTargets=2;
		};
		class Server_Chopshop_Storecar {
			allowedTargets=2;
		};
		class Server_Storage_SaveLargeVehicles {
			allowedTargets=2;
		};
		class Server_Police_Database {
			allowedTargets=2;
		};
		class A3PL_Police_ReceiveTicket {
			allowedTargets=0;
		};
		class A3PL_Police_GiveTicketResponse {
			allowedTargets=0;
		};
		class Server_Police_PayTicket {
			allowedTargets=2;
		};
		class Server_Storage_RetrieveVehicle {
			allowedTargets=2;
		};
		class Server_Storage_StoreVehicle {
			allowedTargets=2;
		};
		class Server_Storage_RetrieveObject {
			allowedTargets=2;
		};
		class Server_Storage_ReturnObjects {
			allowedTargets=2;
		};
		class Server_Storage_ReturnVehicles {
			allowedTargets=2;
		};
		class Server_JobMcfisher_combine {
			allowedTargets=2;
		};
		class Server_JobMcfisher_cookthres {
			allowedTargets=2;
		};
		class Server_Housing_BuyTickets {
			allowedTargets=2;
		};
		class Server_Inventory_RemoveAll {
			allowedTargets=2;
		};
	 	class Server_Dogs_BuyRequest {
			allowedTargets=2;
		};
		class Server_Dogs_HandleLocality {
			allowedTargets=2;
		};
		class Server_JobFisherman_DeployNet {
			allowedTargets=2;
		};
		class Server_JobFisherman_GrabNet {
			allowedTargets=2;
		};
		class Server_Gear_Load {
			allowedTargets=2;
		};
		class A3PL_Bowling_BReg {
			allowedTargets=0;
		};
		class A3PL_Bowling_BUnReg {
			allowedTargets=0;
		};
		class Server_Bowling_LocalPins {
			allowedTargets=2;
		};
		class Server_JobFarming_Plant {
			allowedTargets=2;
		};
		class Server_JobFarming_Harvest {
			allowedTargets=2;
		};
		class Server_Vehicle_EnableSimulation {
			allowedTargets=2;
		};
		class Server_Vehicle_AtegoHandle {
			allowedTargets=2;
		};
		class Server_Factory_Finalise {
			allowedTargets=2;
		};
		class Server_Factory_Collect {
			allowedTargets=2;
		};
		class Server_Factory_Add {
			allowedTargets=2;
		};
		class Server_Government_StartVote {
			allowedTargets=2;
		};
		class Server_Factory_Create {
			allowedTargets=2;
		};
		class A3PL_Player_Notification {
			allowedTargets=0;
		};
		class Server_Log_New {
			allowedTargets=2;
		};
		class Server_AdminLoginsert {
			allowedTargets=2;
		};
		class A3PL_Lib_ChangeLocality {
			allowedTargets=2;
		};
		class Server_JobOil_PumpStart {
			allowedTargets=2;
		};
		class Server_Government_AddBalance {
			allowedTargets=2;
		};
		class Server_Government_SetTax {
			allowedTargets=2;
		};
		class Server_Government_ChangeLaw {
			allowedTargets=2;
		};
		class Server_Government_AddVote {
			allowedTargets=2;
		};
		class Server_Government_AddCandidate {
			allowedTargets=2;
		};
		class Server_Government_FactionSetupInfo {
			allowedTargets=2;
		};
		class Server_Government_SetRank {
			allowedTargets=2;
		};
		class Server_Government_AddRank {
			allowedTargets=2;
		};
		class Server_Government_RemoveRank {
			allowedTargets=2;
		};
		class Server_Government_SetPay {
			allowedTargets=2;
		};
		class Server_Twitter_HandleMsg {
			allowedTargets=2;
		};
		class Server_Police_JailPlayer {
			allowedTargets=2;
		};
		class Server_Police_AcceptDispatch {
			allowedTargets=2;
		};
		class Server_Fire_StartFire {
			allowedTargets=2;
		};
		class Server_Fuel_Load {
			allowedTargets=2;
		};
		class Server_Fuel_Save {
			allowedTargets=2;
		};
		class Server_Fire_RemoveFires {
			allowedTargets=2;
		};
		class Server_JobRoadWorker_UnMark {
			allowedTargets=2;
		};
		class Server_JobRoadWorker_Mark {
			allowedTargets=2;
		};
		class Server_JobRoadWorker_Impound {
			allowedTargets=2;
		};
		class Server_Chopshop_Chop {
			allowedTargets=2;
		};
		class Server_Youtube_StartVideo {
			allowedTargets=2;
		};
		class Server_JobWildCat_SpawnRes {
			allowedTargets=2;
		};
		class A3PL_Phone_RecieveMessage {
			allowedTargets=0;
		};
		class Server_Police_CallDispatch {
			allowedTargets=2;
		};
		class A3PL_Phone_IncomingCall {
			allowedTargets=0;
		};
		class A3PL_Phone_CallAccepted {
			allowedTargets=0;
		};
		class A3PL_Phone_CallEnded {
			allowedTargets=0;
		};
		class Server_Police_EndDispatch {
			allowedTargets=2;
		};
		class Server_Player_TransferBank {
			allowedTargets=2;
		};
		class Server_Business_Buy {
			allowedTargets=2;
		};
		class Server_Business_Sellitem {
			allowedTargets=2;
		};
		class Server_Business_Sellitemstop {
			allowedTargets=2;
		};
		class Server_Business_BuyItem {
			allowedTargets=2;
		};
		class A3PL_JobMcfisher_CookBurger {
			allowedTargets=0;
		};
		class A3PL_Police_ImpoundMsg {
			allowedTargets=0;
		};
		class A3PL_NPC_TakeJobResponse {
			allowedTargets=0;
		};
		class A3PL_Police_DatabaseEnterReceive {
			allowedTargets=0;
		};
		class A3PL_Inventory_Clear {
			allowedTargets=0;
		};
		class A3PL_Shop_BuyReceive {
			allowedTargets=0;
		};
		class A3PL_Storage_ObjectsReceive {
			allowedTargets=0;
		};
		class A3PL_Storage_ObjectRetrieveResponse {
			allowedTargets=0;
		};
		class A3PL_Storage_CarRetrieveResponse {
			allowedTargets=0;
		};
		class A3PL_Storage_CarStoreResponse {
			allowedTargets=0;
		};
		class A3PL_Storage_VehicleReceive {
			allowedTargets=0;
		};
		class A3PL_Vehicle_DestroyedMsg {
			allowedTargets=0;
		};
		class A3PL_Dogs_BuyReceive {
			allowedTargets=0;
		};
		class A3PL_Player_NewPlayer {
			allowedTargets=0;
		};
		class A3PL_Housing_AptAssignedMsg {
			allowedTargets=0;
		};
		class Server_Housing_AssignHouse {
			allowedTargets=2;
		};
		class Server_Housing_LoadBox {
			allowedTargets=2;
		};
		class Server_Housing_SaveBox {
			allowedTargets=2;
		};
		class A3PL_JobFarming_PlantReceive {
			allowedTargets=0;
		};
		class A3PL_JobFisherman_DeployNetResponse {
			allowedTargets=0;
		};
		class A3PL_JobFisherman_DeployNetSuccess {
			allowedTargets=0;
		};
		class A3PL_JobOil_PumpReceive {
			allowedTargets=0;
		};
		class A3PL_JobRoadWorker_MarkResponse {
			allowedTargets=0;
		};
		class A3PL_Police_GetJailed {
			allowedTargets=0;
		};
		class A3PL_Police_ReleasePlayer {
			allowedTargets=0;
		};
		class A3PL_Police_AcceptDispatch {
			allowedTargets=0;
		};
		class A3PL_Twitter_NewMsg {
			allowedTargets=0;
		};
		class A3PL_Vehicle_AtegoTowResponse {
			allowedTargets=0;
		};
		class A3PL_Youtube_StartVideoFinal {
			allowedTargets=0;
		};
		class A3PL_Youtube_StartDownload {
			allowedTargets=0;
		};
		class A3PL_Business_BuyItemReceive {
			allowedTargets=0;
		};
		class A3PL_Government_NewTax {
			allowedTargets=0;
		};
		class A3PL_Government_NewLaw {
			allowedTargets=0;
		};
		class A3PL_Government_NewVote {
			allowedTargets=0;
		};
		class A3PL_Government_NewMayor {
			allowedTargets=0;
		};
		class A3PL_Government_FactionSetupReceive {
			allowedTargets=0;
		};
		class A3PL_Hud_IDCard {
			allowedTargets=0;
		};
		class A3PL_Items_RemoteRocket {
			allowedTargets=0;
		};
		class A3PL_Medical_Revive {
			allowedTargets=0;
		};
		class Server_Vehicle_TrailerDetach {
			allowedTargets=2;
		};
		class A3PL_Lib_HideObject {
			allowedTargets=0;
		};
		class A3PL_Medical_Die {
			allowedTargets=0;
		};
		class Server_DMV_Add {
			allowedTargets=2;
		};
		class Server_IE_ShipImport {
			allowedTargets=2;
		};
		class A3PL_IE_ShipLost {
			allowedTargets=0;
		};
		class A3PL_IE_ShipArrived {
			allowedTargets=0;
		};
		class A3PL_IE_ShipLeft {
			allowedTargets=0;
		};
		class Server_Housing_CreateKey {
			allowedTargets=2;
		};
		class A3PL_Housing_Loaditems {
			allowedTargets=0;
		};
		class Server_Housing_LoadItemsSimulation {
			allowedTargets=2;
		};
		class Server_Vehicle_InitLPChange {
			allowedTargets=2;
		};
		class A3PL_Garage_SetLicensePlateResponse {
			allowedTargets=0;
		};
		class A3PL_Store_Robbery_Alert {
			allowedTargets=0;
		};
		class A3PL_Police_PanicMarker {
			allowedTargets=0;
		};
		class Server_Garage_UpdateAddons {
			allowedTargets=2;
		};
		class A3PL_BHeist_Alert {
			allowedTargets=2;
		};

		class Server_Locker_Save {
			allowedTargets=2;
		};

		class Server_Locker_Insert {
			allowedTargets=2;
		};

		// Fire Related //

		class Server_Fire_PauseFire {
			allowedTargets=2;
		};
		class Server_Fire_PauseCheck {
			allowedTargets=2;
		};

		// Vehicle Storage //

		class Server_Storage_ChangeVehicleName {
			allowedTargets=2;
		};

		// iPhone X //
		class A3PL_iPhoneX_Contacts {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_Conversations {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_PhoneNumberPrimary {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_PhoneNumberSecondary {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_PhoneNumberEnterprise {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_PhoneNumberActive {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SMS {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_ReceiveSMS {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_AppContact {
			allowedTargets=0;
		};

		class A3PL_iPhoneX_GetPhoneNumberSubscription
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_GetPhoneNumberIsUsed
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_EndCall
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_StartCall
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_ReceiveCall
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_Switchboard
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SwitchboardSend
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SwitchboardReceive
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_EndCallSwitchboard
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_Events
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SMSEnterprise
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SetSettings
		{
			allowedTargets=0;
		};

		class A3PL_iPhoneX_SendSMS
		{
			allowedTargets=0;
		};

		class Server_iPhoneX_DeleteContact
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_AddPhoneNumber
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_CheckPhoneNumberIsUsed
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_CheckPhoneNumberSubscription
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetContacts
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetConversations
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetPhoneNumberActive
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetSMS
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SetSwitchboardFD
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SetSwitchboardSD
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetSwitchboardSD
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_getSwitchboardFD
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveSound
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveSilent
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveWallpaper
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetPhoneNumber
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetSettings
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveContact
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_UpdatePhoneNumberActive
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveConversation
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SavePhoneNumberActive
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SendSMS
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveLastSMS
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetListNumber
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetSMSEnterprise
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_GetEvents
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_CallSwitchboard
		{
			allowedTargets=2;
		};

		class Server_iPhoneX_SaveEvent
		{
			allowedTargets=2;
		};

		class Server_FD_Database
		{
			allowedTargets=2;
		};
		
		class A3PL_FD_DatabaseEnterReceive {
			allowedTargets=0;
		};
	};
};
