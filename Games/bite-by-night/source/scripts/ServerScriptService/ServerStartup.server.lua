--[[
    Written by: Nextix (ne_tix)
    Date: 3/29/2026
    
    Warning:
    Deleting this result result in the whole server-side not loading. So do not delete it or break it.
]]

-- <- Services -> --
local ServerStorage = game:GetService('ServerStorage');

-- <- Types -> --
-- // No need to export the types cause they're only used here. (NORMALLY.)
type Module = {
	ModuleInstance: Instance,
	ModuleReturn: { -- // Those could be wrong btw, its just to make auto complete work.
		Init: () -> (),
		Start: () -> (),
		Test: () -> ()
	}
}

type FunctionThingy = {
	Init: () -> (),
}

-- <- Modules -> --
local EventManager = require('@game/ServerStorage/Modules/Managers/EventManager');
local Cmdr = require('./Cmdr');

-- <- Private Variables -> --
local RegisteredModules: {Module} = {}
local StartFunctions = {
	'Start',
	'Init',
	'Test'
}

local ServiceFunctions = {
	{
		Connection,
		Service = 'Players',
		Function = 'PlayerAdded',
		FunctionNames = {
			'__PlayerAdded'
		},
	},
	{
		Connection,
		Service = 'Players',
		Function = 'PlayerRemoving',
		FunctionNames = {
			'__PlayerLeft',
			'__PlayerRemoving'
		},
	},
}

-- <- Private Functions -> --

-- // This function is used to safely require a module without having any errors problems.
local function SafeRequire(Module: ModuleScript): (boolean, any)
	if not Module:IsA("ModuleScript") then
		return false, "Not a module."
	end

	return pcall(require, Module);
end

-- // This function is a check for the table ServiceFunctions, checking if the Service and the Function asked exists and setting up a connection for it.
local function ServiceStart(): ()
	for _, ServiceInformation in ServiceFunctions do 
		local Service = game:GetService(ServiceInformation.Service);
		if not Service then
			continue
		end

		local FunctionConnect = Service[ServiceInformation.Function]
		if not FunctionConnect then
			continue
		end

		if typeof(FunctionConnect) ~= 'RBXScriptSignal' then
			continue
		end
		
		ServiceInformation.Connection = FunctionConnect
	end
end

-- // This function connect the service connection to call the function in a module if it exists.
local function ConnectServices(Module: FunctionThingy): ()
	local function FindServiceInModule(FunctionNames): (boolean, string, (...any) -> () | nil)
		for _, Name in FunctionNames do 
			local MaybeFoundFunction = Module[Name]
			if MaybeFoundFunction and typeof(MaybeFoundFunction == 'function') then				
				return true, Name, Module[Name]
			elseif MaybeFoundFunction and typeof(MaybeFoundFunction ~= 'function') then
				warn(`Found {Name} but {Name} isn't a function. Maybe try switching it?`);
			end
		end
		
		return false, 'None', nil -- // Just means nothing was found.
	end
	
	for _, ServiceInformation in ServiceFunctions do 
		if not ServiceInformation.Connection then
			continue
		end
		
		local Found, FoundName, FunctionCallBack = FindServiceInModule(ServiceInformation.FunctionNames);
		if not Found then
			continue
		end
		
		ServiceInformation.Connection:Connect(FunctionCallBack);
	end
end

-- // This function try to run a startup function on each server modules.
local function StartModules(): ()
	local function SafeStart(Module: Module): ()
		local ModuleTable : FunctionThingy = Module.ModuleReturn
		
		local function NormalStart(): ()
			for FunctionName, FunctionCallBack in ModuleTable do 
				local FoundFunction = table.find(StartFunctions, FunctionName);
				if FoundFunction then
					if typeof(FunctionCallBack) ~= 'function' then
						continue
					end

					FunctionCallBack();
				end
			end
		end
		
		NormalStart();
		ConnectServices(ModuleTable);
	end
	
	for _, Module : Module in RegisteredModules do 
		if not Module.ModuleInstance then
			continue
		end
		
		if not Module.ModuleReturn then
			continue
		end
		
		if typeof(Module.ModuleReturn) ~= 'table' then
			continue
		end
		
		SafeStart(Module);
	end
	
	warn(`Starting done !`);
end

-- // This function register each server modules into a table to store them.
local function RegisterModules(): ()
	for _, Module in ServerStorage.Modules:GetDescendants() do 
		if Module:IsA('ModuleScript') then
			local Success, Information = SafeRequire(Module);
			if not Success then
				warn(`Coudn't require module {Module}, Error: {Information}`);
				
				continue
			end
			
			table.insert(RegisteredModules, {
				ModuleInstance = Module,
				ModuleReturn = Information,
			});
		end
	end
	
	StartModules();
end

-- <- External -> --
ServiceStart();
RegisterModules();

warn(EventManager)

EventManager.StartLoggingEvents(RegisteredModules);
Cmdr:RegisterCommandsIn(script.Parent.CmdrCommands);