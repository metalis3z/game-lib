--!strict

--[[

	This wraps internal functions to make HD Admin safe to modify. In a Server script, do:

	```
	local hd = game:GetService("ReplicatedStorage"):WaitForChild("HD Admin")
	local ServerAPI = require(hd.Core.ServerAPI)
	```

	This works because HD Admin moves its shared files into ReplicatedStorage at runtime.
	If you'd like type checking autocompletes, move your HD Admin model into ReplicatedStorage.

--]]


-- SETUP
local loaded = script:WaitForChild("Loaded", 999)
if not loaded then
	error("HD Admin failed to load, so its API cannot be used")
end


-- LOCAL
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local ServerAPI = require(modules.Internal.API.Server)


-- TYPES
export type Target = ServerAPI.Target
export type ActionScope = ServerAPI.ActionScope
export type ActionOptions = ServerAPI.ActionOptions
export type Role = ServerAPI.Role
export type BanOptions = ServerAPI.BanOptions
export type UnbanOptions = ServerAPI.UnbanOptions
export type BanRecord = ServerAPI.BanRecord
export type Emote = ServerAPI.Emote
export type IncompleteEmote = ServerAPI.IncompleteEmote
export type PromptType = ServerAPI.PromptType
export type PromptOptions = ServerAPI.PromptOptions
export type PromptHandle = ServerAPI.PromptHandle
export type Task = ServerAPI.Task


return ServerAPI
