--!strict

--[[

	This wraps internal functions to make HD Admin safe to modify. In a Client script, do:
	
	```
	local hd = game:GetService("ReplicatedStorage"):WaitForChild("HD Admin")
	local ClientAPI = require(hd.Core.ClientAPI)
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
local ClientAPI = require(modules.Internal.API.Client)


-- TYPES
export type PromptType = ClientAPI.PromptType
export type PromptOptions = ClientAPI.PromptOptions
export type PromptHandle = ClientAPI.PromptHandle


return ClientAPI
