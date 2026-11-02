local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local buttonAnimation = require(ReplicatedStorage.Library.Modules:WaitForChild("ButtonAnimation"))
local trollButton = script.Parent
local trollGui = playerGui:WaitForChild("AdminPanel")

buttonAnimation.CreateButton(trollButton)
for _, descendant in ipairs(trollGui:GetDescendants()) do
	if descendant:IsA("GuiButton") then
		buttonAnimation.CreateButton(descendant)
	end
end