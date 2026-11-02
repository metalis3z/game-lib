local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local remotes     = ReplicatedStorage:WaitForChild("Remotes")
local isCmdrAuthorized = remotes:WaitForChild("IsCmdrAuthorized")

-- Only authorized users can open Cmdr with F4
local authorized = false
local success, result = pcall(function()
	return isCmdrAuthorized:InvokeServer()
end)
if success then
	authorized = result
end

if not authorized then return end

local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))
Cmdr:SetActivationKeys({ Enum.KeyCode.F4 })