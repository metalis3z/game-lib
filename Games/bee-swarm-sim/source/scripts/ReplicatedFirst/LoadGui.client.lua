if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = ReplicatedStorage.StarterGui

for _index, Gui in StarterGui:GetChildren() do
	Gui:Clone().Parent = PlayerGui
end