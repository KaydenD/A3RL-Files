//This is just here so we have the DB variables on the client when testing
if (hasInterface && isServer) then
{
	/*
	[
		["tax",rate]
	]
	*/
	Config_Government_Taxes =
	[
		["Property tax",0.1],
		["Income tax",0.1],
		["Sales tax",0.1]
	];	
	/*
	[
		["Tax balance",amount]
	]
	*/
	Config_Government_Balances =
	[
		["Property tax balance",50],
		["Income tax balance",50],
		["Sales tax balance",50],
		["Sheriff Department",500],
		["fifr",1500]
	];	
	
	/*
		"law",
		"law2"
	*/
	Config_Government_Laws =
	[
		"The KKK is a legal faction",
		"Every citizen is forced to be a member of the KKK",
		"Racism on Fishers Island is allowed in any shape or form"
	];
};