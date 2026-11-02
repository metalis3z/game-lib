if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Harvested, CHarvested = Player:WaitForChild('Harvested'), Player:WaitForChild('CHarvested')

script.Parent.TextLabel.Text = Harvested.Value .. ' Plants Harvested'
Harvested:GetPropertyChangedSignal('Value'):Connect(function()
	script.Parent.Enabled = true
	script.Parent.TextLabel.Visible = true
	script.Parent.TextLabel.Text = Harvested.Value .. ' Plants Harvested'
end)

script.Parent.Sugar.Text = CHarvested.Value .. ' Sugar Harvested'
CHarvested:GetPropertyChangedSignal('Value'):Connect(function()
	script.Parent.Enabled = true
	script.Parent.Sugar.Visible = true
	script.Parent.Sugar.Text = CHarvested.Value .. ' Sugar Harvested'
end)

script.Parent.Enabled = false