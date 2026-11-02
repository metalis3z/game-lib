--//BalenciagaJamie made it
local char = nil
local hum = nil
local track = nil
local plr = nil
local track2 = nil
script.Parent.Equipped:Connect(function()
	if script.Parent.Parent:FindFirstChild('Humanoid') then
		char = script.Parent.Parent
		plr = game.Players:FindFirstChild(char.Name)
		hum = char.Humanoid
		if script.Parent:FindFirstChild('HoldAnimation') and script.Parent:FindFirstChild('PuffAnim') then
			track = hum:LoadAnimation(script.Parent.HoldAnimation)
			track2 = hum:LoadAnimation(script.Parent.PuffAnim)
			track:Play()
		end
	end
end)

script.Parent.Unequipped:Connect(function()
	if char and hum and plr and track and plr ~= nil and track ~= nil and char ~= nil and hum ~= nil and script.Parent:FindFirstChild('HoldAnimation') then
		track:Stop()
	end
end)

script.Parent.Activated:Connect(function()
	if script.Parent.Name == 'Stick' then
		if script.Parent.LitUp.Value == false and char and hum and plr and track and plr ~= nil and track ~= nil and char ~= nil and hum ~= nil and script.Parent:FindFirstChild('HoldAnimation') then
			script.Parent.LitUp.Value = true
			track2:Play()
			local Lit = script.Parent.Flame
			wait(0.1)
			Lit.Transparency =  0.25
			wait(0.3)
			Lit.Transparency =  0.23
			wait(0.3)
			Lit.Transparency =  0.21
			wait(0.3)
			Lit.Transparency =  0.18
			wait(1)
			Lit.Transparency =  0.4
			wait(0.3)
			Lit.Transparency =  0.6
			wait(0.3)
			Lit.Transparency =  0.8
			wait(0.3)
			Lit.Transparency =  1
			wait(2)
			--//Smoke
			local dog = script.Parent.Flame.Smoke:Clone()
			local mouthpeace = Instance.new("Attachment")
			mouthpeace.Parent = script.Parent.Parent.Head
			mouthpeace.Position = Vector3.new(0,-0.3,-0.57)
			dog.Parent = mouthpeace
			dog.Enabled=true
			dog.EmissionDirection = "Front"
			wait(1)
			script.Parent.Parent.Head.Attachment.Smoke.Transparency = NumberSequence.new(0.85)
			wait(0.8)
			script.Parent.Parent.Head.Attachment.Smoke.Transparency = NumberSequence.new(0.9)
			wait(0.8)
			script.Parent.Parent.Head.Attachment.Smoke.Transparency =  NumberSequence.new(0.95)
			wait(0.8)
			script.Parent.Parent.Head.Attachment.Smoke.Transparency =  NumberSequence.new(1)
			wait(0.8)
			mouthpeace:Destroy()
			script.Parent.LitUp.Value = false
		end
	end
end)