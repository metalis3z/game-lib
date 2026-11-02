if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Stored = Player:WaitForChild('stored')
local Jailed = Stored:WaitForChild('Jailed')
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

script.Parent.Enabled = false
if Jailed.Value > 0 then
	script.Parent.Enabled = true
	script.Parent.TextLabel.Text = Jailed.Value .. ' SECONDS LEFT'
else
	script.Parent.Enabled = false
end

Jailed.Changed:Connect(function()
	if Jailed.Value > 0 then
		script.Parent.Enabled = true
		script.Parent.TextLabel.Text = Jailed.Value .. ' SECONDS LEFT'
	else
		script.Parent.Enabled = false
	end
end)

Character.ChildAdded:Connect(function(Child)
	if Child.Name == 'COMBATLOG' then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	end
end)

Character.ChildRemoved:Connect(function(Child)
	if Child.Name == 'COMBATLOG' then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end
end)