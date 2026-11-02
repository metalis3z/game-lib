-- It's essential we wait for 'loaded' otherwise sibling modules could be missing
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local container = ReplicatedStorage:WaitForChild("HD Admin")
local core = container:WaitForChild("Core")
local clientAPI = core:WaitForChild("ClientAPI")
local loaded = clientAPI:WaitForChild("Loaded")
local value = script:FindFirstAncestor("MainModule").Value
local modules = value.Modules
local Framework = require(modules.Framework)
Framework.startClient()