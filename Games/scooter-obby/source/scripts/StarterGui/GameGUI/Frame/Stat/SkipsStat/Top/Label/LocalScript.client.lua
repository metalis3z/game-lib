local rs = game:GetService("ReplicatedStorage")
local numerics = require(rs.ModuleScripts.Numerics)
local players = game:GetService("Players")
local player = players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")
wait(0.5)
while true do
	script.Parent.Text = numerics.WithCommas(coins.Value)
	wait(0.1)
end