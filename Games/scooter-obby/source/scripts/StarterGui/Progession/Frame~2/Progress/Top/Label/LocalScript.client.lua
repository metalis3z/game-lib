local rs = game:GetService("ReplicatedStorage")
local numerics = require(rs.ModuleScripts.Numerics)
local players = game:GetService("Players")
local player = players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local coins = leaderstats:WaitForChild("Coins")
wait(0.5)

while true do
	script.Parent.Text = math.floor((player.leaderstats.Stage.Value / 40 )* 100) .. "% COMPLETE"
	script.Parent.Parent.ProgressBar.Size = UDim2.new(player.leaderstats.Stage.Value/40,0,1,0)
	wait(0.1)
end