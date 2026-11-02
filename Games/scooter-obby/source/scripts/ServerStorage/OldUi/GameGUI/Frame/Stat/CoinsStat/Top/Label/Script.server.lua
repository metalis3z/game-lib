local rs = game:GetService("ReplicatedStorage")
local numerics = require(rs.ModuleScripts.Numerics)
local players = game:GetService("Players")
local player = players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")

coins.Changed:Connect(function(value)
	script.Parent.Text = numerics.WithCommas(value)
end)

wait(0.5)
script.Parent.Text = numerics.WithCommas(coins.Value)