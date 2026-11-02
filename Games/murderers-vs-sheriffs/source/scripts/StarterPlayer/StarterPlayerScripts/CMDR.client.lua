local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local CmdrGui = PlayerGui:FindFirstChild("Cmdr")

if not (CmdrGui and CmdrGui:FindFirstChild("Frame") and CmdrGui.Frame:FindFirstChild("Line")) then
	if CmdrGui then
		CmdrGui:Destroy()
	end

	local StarterCmdrGui = StarterGui:WaitForChild("Cmdr")
	CmdrGui = StarterCmdrGui:Clone()
	CmdrGui.Parent = PlayerGui
end

local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))
Cmdr:SetActivationKeys({ Enum.KeyCode.F2 })