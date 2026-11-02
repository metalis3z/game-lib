--!strict

--[[

	This wraps internal functions to make HD Admin safe to modify.
	Within a command module (Config -> Commands), do:

	```
	local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
	```

--]]


-- SETUP
local loaded = script:WaitForChild("Loaded", 999)
if not loaded then
	error("HD Admin failed to load, so its API cannot be used")
end


-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local CommandAPI = require(modules.Internal.API.Command)


-- TYPES
export type Commands = CommandAPI.Commands
export type Command = CommandAPI.Command
export type Task = CommandAPI.Task
export type ClientCommand = CommandAPI.ClientCommand
export type ClientCommands = CommandAPI.ClientCommands
export type PromptType = CommandAPI.PromptType
export type PromptOptions = CommandAPI.PromptOptions
export type PromptHandle = CommandAPI.PromptHandle


return CommandAPI
