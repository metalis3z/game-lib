-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain
local settings = main.settings



-- << COMMANDS >>
local module = {
	
	-----------------------------------
	{
	Name = "test101";
	Aliases	= {};
	Prefixes = {settings.Prefix};
	Rank = 1;
	RankLock = false;
	Loopable = false;
	Tags = {};
	Description = "Hello i like pie";
	Contributors = {};
	--ClientCommand = true;
	--ReplicationEffect = true;
	--
	Args = {"Player"};

	Function = function(speaker, args)
		print("HELLLLLLLLLLLLLOOOOOOOOOO")
	end;
	UnFunction = function(speaker, args)
		
	end;--]]
	--
	};
	
	
	
	
	-----------------------------------
	{
	Name = "test2";
	Aliases	= {};
	Prefixes = {settings.Prefix};
	Rank = 1;
	RankLock = false;
	Loopable = false;
	Tags = {};
	Description = "";
	Contributors = {};
	--
	Args = {"Code"};
	--[[
	ClientCommand = true;
	FireAllClients = true;
	BlockWhenPunished = true;
	PreFunction = function(speaker, args)
		
	end;
	Function = function(speaker, args)
		wait(1)
	end;
	--]]
	--
	};
	
	
	
	
	-----------------------------------
	
};



return module
