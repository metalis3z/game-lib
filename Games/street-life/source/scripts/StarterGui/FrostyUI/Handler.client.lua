if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Extra = Player:WaitForChild('Extra')

local Frosty = workspace:WaitForChild('Frosty')

Player.ChildAdded:Connect(function(Child)
	if Child.Name == 'CurrentFrost' then
		script.Parent.Frame:FindFirstChild('You').Visible = true
		script.Parent.Frame:FindFirstChild('You').BackgroundColor3 = Child.Value
	end
end)

Player.ChildRemoved:Connect(function(Child)
	if Child.Name == 'CurrentFrost' then
		script.Parent.Frame:FindFirstChild('You').Visible = false
	end
end)

Frosty:FindFirstChild('NPCArea').ChildAdded:Connect(function(Child)
	if Child.Name == 'NPC ' .. Player.Name then
		script.Sound:Play()
		script.Parent.Frame:FindFirstChild('Customer').Visible = true
		script.Parent.Frame:FindFirstChild('Customer').BackgroundColor3 = Child:WaitForChild('ColorValue').Value
	end
end)

Frosty:FindFirstChild('NPCArea').ChildRemoved:Connect(function(Child)
	if Child.Name == 'NPC ' .. Player.Name then
		script.Parent.Frame:FindFirstChild('Customer').Visible = false
	end
end)