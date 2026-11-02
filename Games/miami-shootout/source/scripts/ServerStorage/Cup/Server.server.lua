local PBottle = game:GetService('ReplicatedStorage'):WaitForChild('PBottle')
local Pour = script.Parent.Handle.Pour
local Done = false
local Poured = script.Parent:FindFirstChild('Poured').Value

Pour.PromptButtonHoldBegan:Connect(function(Player)
	local Character = Player.Character
	if not Character:FindFirstChild('PBottle') and Done ~= true then
		local ClonedS = PBottle:Clone()
		ClonedS.Parent = Character
		local Motor6D = Instance.new('Motor6D')
		Motor6D.Part0 = Character:FindFirstChild('LeftHand')
		Motor6D.Part1 = Character:FindFirstChild('PBottle')
		Motor6D.Parent = Character:FindFirstChild('LeftHand')
		Motor6D.Name = 'PBottle'
	end
end)

Pour.PromptButtonHoldEnded:Connect(function(Player)
	local Character = Player.Character
	if Character:FindFirstChild('PBottle') then
		Character:FindFirstChild('PBottle'):Destroy()
	end
end)
Pour.Triggered:Connect(function(Player)
	Poured = true
	local Character = Player.Character
	if Character:FindFirstChild('PBottle') then
		Character:FindFirstChild('PBottle'):Destroy()
	end
	Done = true
	Player.Backpack:FindFirstChild('PurpleC'):Destroy()
end)