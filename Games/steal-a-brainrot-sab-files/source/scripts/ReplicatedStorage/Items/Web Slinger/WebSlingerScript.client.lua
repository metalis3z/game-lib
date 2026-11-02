local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local tool = script.Parent
local Net = require(ReplicatedStorage.Packages.Net)

tool.Activated:Connect(function()
	Net:RemoteEvent("UseItem"):FireServer(mouse.Hit.Position, mouse.Target)
end)

tool.Unequipped:Connect(function()
	ReplicatedStorage.ToolUnequipped:FireServer()
end)
