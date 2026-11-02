local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UITweening = require(ReplicatedStorage:WaitForChild("Modules"):FindFirstChild("UITweening"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainGui = playerGui:WaitForChild("MainUI")

local function setupButton(button)
	if not (button:IsA("TextButton") or button:IsA("ImageButton")) then return end
	UITweening.Animate(button, player)
end

local function setupGui(gui)
	if not gui:IsA("ScreenGui") then return end
	for _, desc in gui:GetDescendants() do
		setupButton(desc)
	end
	gui.DescendantAdded:Connect(setupButton)
end

for _, gui in playerGui:GetChildren() do
	setupGui(gui)
end

playerGui.ChildAdded:Connect(setupGui)

--[[
discord.gg/Tsw2b2EkSE is this only server that this admin abuse SHOULD be sold on.
]]--