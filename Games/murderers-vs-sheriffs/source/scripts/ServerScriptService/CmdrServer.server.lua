local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Cmdr = require(ServerScriptService:WaitForChild("Cmdr"))
local CmdrServer = script

local function safeRegister(label, callback)
	local ok, err = pcall(callback)
	if not ok then
		warn("Cmdr setup failed while registering " .. label .. ":", err)
	end
	return ok
end

local function hasVisibleCommandModules(folder)
	if not folder then
		return false
	end

	for _, child in ipairs(folder:GetChildren()) do
		if child:IsA("ModuleScript") and not child.Name:match("Server$") then
			return true
		end
	end

	return false
end

local function registerMovedHooksIfNeeded()
	local hooks = Cmdr.Registry and Cmdr.Registry.Hooks and Cmdr.Registry.Hooks.BeforeRun
	if hooks and #hooks > 0 then
		return
	end

	local replicatedRoot = Cmdr.ReplicatedRoot or ReplicatedStorage:FindFirstChild("CmdrClient")
	local typesFolder = replicatedRoot and replicatedRoot:FindFirstChild("Types")
	local beforeRun = typesFolder and typesFolder:FindFirstChild("BeforeRun")
	if not beforeRun then
		return
	end

	local ok, installer = pcall(require, beforeRun)
	if ok and type(installer) == "function" then
		installer(Cmdr.Registry)
	else
		warn("Cmdr setup failed while registering moved BeforeRun hook:", installer)
	end
end

local function registerMovedCommandsIfNeeded()
	local replicatedRoot = Cmdr.ReplicatedRoot or ReplicatedStorage:FindFirstChild("CmdrClient")
	local replicatedCommands = replicatedRoot and replicatedRoot:FindFirstChild("Commands")
	local serverCommands = CmdrServer:FindFirstChild("Admin")
	if not (replicatedCommands and serverCommands) then
		return
	end

	for _, commandScript in ipairs(replicatedCommands:GetChildren()) do
		if commandScript:IsA("ModuleScript") then
			local serverScript = serverCommands:FindFirstChild(commandScript.Name .. "Server")
			if serverScript and not Cmdr.Registry:GetCommand(commandScript.Name) then
				safeRegister(commandScript.Name .. " fallback", function()
					Cmdr.Registry:RegisterCommand(commandScript, serverScript)
				end)
			end
		end
	end
end

local hooksFolder = CmdrServer:WaitForChild("Hooks")
local adminFolder = CmdrServer:WaitForChild("Admin")

safeRegister("hooks", function()
	if #hooksFolder:GetChildren() > 0 then
		Cmdr:RegisterHooksIn(hooksFolder)
	end
end)
registerMovedHooksIfNeeded()

safeRegister("default commands", function()
	Cmdr:RegisterDefaultCommands()
end)

safeRegister("admin commands", function()
	if hasVisibleCommandModules(adminFolder) then
		Cmdr:RegisterCommandsIn(adminFolder)
	end
end)
registerMovedCommandsIfNeeded()
