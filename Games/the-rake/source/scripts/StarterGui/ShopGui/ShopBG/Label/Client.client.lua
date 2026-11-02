
local plr = game.Players.LocalPlayer
local leaderstats = plr:WaitForChild("leaderstats")
local points = leaderstats.Points

points.Changed:Connect(function()
	script.Parent.Text = points.Value .. " Points"
end)