local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Seconds = ReplicatedStorage:WaitForChild("Seconds")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

Seconds.Changed:Connect(function()
	script.Parent.Text = Player.leaderstats.Coins.Value -- Make sure to replace "Cash" with what your currency name is
end)