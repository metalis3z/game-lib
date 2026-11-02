task.wait(3)

local character = script.Parent
local humanoid = character:FindFirstChild("Humanoid")
character:WaitForChild('Head')

local currentGui
humanoid.HealthChanged:Connect(function()
	if humanoid.Health <= 40 then
		if humanoid.Health == 0 and character:FindFirstChild('Head') then
			local clone = script.InjuredGui:Clone()
			clone.Enabled = true
			clone.Parent = character.UpperTorso
			currentGui = clone
			
			character.Head.BillboardGui.Level.TextColor3 = Color3.fromRGB(255, 0, 0)
			character.Head.BillboardGui.TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end)

for _, accessory in character:GetChildren() do
	if accessory:IsA("Accessory") then
		if accessory:FindFirstChild("Handle") then
			accessory.Handle.CanQuery = false
			accessory.Handle.CanTouch = false
		end
	end
end