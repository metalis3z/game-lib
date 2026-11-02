-- Bull3tHoles yessir

local Icon = require(game:GetService("ReplicatedStorage").Icon)
local SocialService = game:GetService("SocialService")
local plr = game:GetService("Players").LocalPlayer;
local icon = Icon.new():setLabel("", "deselected")
:setLabel("", "selected")
:setCaption("SETTINGS")
:setImage(4492476121)

icon.selected:Connect(function()
	plr.PlayerGui:FindFirstChild("Settings").Enabled = true
end)

icon.deselected:Connect(function()
	plr.PlayerGui:FindFirstChild("Settings").Enabled = false
end)

local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

hum.Died:Connect(function()
	icon:deselect()
end)

plr.CharacterAdded:Connect(function()
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")

	hum.Died:Connect(function()
		icon:deselect()
	end)
end)