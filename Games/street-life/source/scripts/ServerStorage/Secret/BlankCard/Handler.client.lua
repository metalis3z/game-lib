if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild('Humanoid', true)
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart', true)

local Animation = Instance.new('Animation')
Animation.AnimationId = 'http://www.roblox.com/Asset?ID=16682065898'
Animation.Parent = script
local track

ChangeProximity = function(Arg)
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA('ProximityPrompt') and v.Name == 'ATM' then
			v.Enabled = not Arg
			v.Parent:FindFirstChild('Blank').Enabled = Arg
			v.Triggered:Connect(function()
				if track then track:Stop() end
			end)
		end
	end
end

script.Parent.Activated:Connect(function()
	if not Player.PlayerGui:FindFirstChild('Circle') and script.Parent.Name == 'BlankCard' then
		local Clone = script:FindFirstChild('Circle'):Clone()
		Clone:FindFirstChild('Handler').Enabled = true
		Clone.Enabled = true
		Clone.Parent = Player.PlayerGui
	end
end)

script.Parent.Equipped:Connect(function()
	track = Humanoid:LoadAnimation(Animation)
	track.Looped = true
	track:Play()
	if script.Parent.Name == 'ActiveCard' then ChangeProximity(true) end
end)

Animation.Destroying:Connect(function()
	if track then track:Stop() end
end)

script.Parent.Unequipped:Connect(function() if track then track:Stop() end if script.Parent.Name == 'ActiveCard' then ChangeProximity(false) end end)
script.Parent.Destroying:Connect(function() if track then track:Stop() end end)