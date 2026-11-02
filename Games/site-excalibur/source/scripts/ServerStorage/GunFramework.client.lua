local Framework = {}
local Modules = {}

local function RecursiveGetModules(Directory)
	for _, Module in pairs(Directory:GetChildren()) do
		if Module:IsA("ModuleScript") then
			Modules[Module.Name] = Module
		end
		RecursiveGetModules(Module)
	end
end

function Framework.Require(Name)
	if Modules[Name] then
		return require(Modules[Name])
	else
		warn("Framework | Requested Module " .. Name .. " does not exist")
	end
	return nil
end

shared.Framework = Framework
RecursiveGetModules(script)
Framework.Require("ClientInitializer")