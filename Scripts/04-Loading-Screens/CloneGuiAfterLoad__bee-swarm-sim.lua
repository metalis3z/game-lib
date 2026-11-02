-- Reference copy for study. Game: Bee Swarm Simulator (bee-swarm-sim)
-- Original: ReplicatedFirst/LoadGui.client.lua
-- What it does: Waits for game.Loaded then clones every ScreenGui from ReplicatedStorage.StarterGui into PlayerGui, so the main UI only appears after loading.

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