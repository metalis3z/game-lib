local player = game.Players.LocalPlayer
player:WaitForChild("leaderstats")
local lastProgress = player.leaderstats.Stage.Value
local firstReset = false

local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad)

while true do
	if player.leaderstats.Stage.Value or not firstReset then
		firstReset = true
		lastProgress = player.leaderstats.Stage.Value
		ts:Create(script.Parent.Bar, ti, {Size = UDim2.new(player.leaderstats.Stage.Value / 100,0,1,0)}):Play()
	end
	script.Parent.Status.Text = "Stage " .. player.leaderstats.Stage.Value .. " - [" .. player.leaderstats.Stage.Value .. "%]"
	wait(0.2)
end