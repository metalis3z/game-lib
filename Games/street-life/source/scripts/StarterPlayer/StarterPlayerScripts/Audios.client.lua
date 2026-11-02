if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart', true)

local Zone = require(game:FindService('ReplicatedStorage'):WaitForChild("Zone"))

local PhonkAudios = {
	14145621445,
	14145618923,
	14145627857,
	14145620419,
	14145626111
}

local NightAudios = {
	18160928308,
	17845451570,
	18720900362,
	18361895308,
	18160928308,
	17220113277
}

workspace:WaitForChild('AudioZones'):FindFirstChild('Gym'):FindFirstChildOfClass('Sound').SoundId = 'rbxassetid://' .. PhonkAudios[math.random(1, #PhonkAudios)]
workspace:WaitForChild('AudioZones'):FindFirstChild('Nightclub'):FindFirstChildOfClass('Sound').SoundId = 'rbxassetid://' .. NightAudios[math.random(1, #NightAudios)]

for _,v in next, workspace:WaitForChild('AudioZones'):GetChildren() do
	if v:IsA('Part') and v.Name ~= 'Sugar' then
		local Sound = v:FindFirstChildOfClass('Sound'):Clone()
		Sound.Parent = game:GetService("SoundService")
		local DefaultVolume = Sound.Volume
		Sound.Volume = 0
		Sound.Name = 'ZoneAudio'
		if v.Name == 'Gym' then
			Sound.DidLoop:Connect(function()
				local Current = Sound.SoundId
				repeat task.wait() 
					Sound.SoundId = 'rbxassetid://' .. PhonkAudios[math.random(1, #PhonkAudios)]
				until Current ~= Sound.SoundId
				Sound.TimePosition = 0
			end)
		elseif v.Name == 'Nightclub' then
			Sound.DidLoop:Connect(function()
				local Current = Sound.SoundId
				repeat task.wait() 
					Sound.SoundId = 'rbxassetid://' .. NightAudios[math.random(1, #NightAudios)]
				until Current ~= Sound.SoundId
				Sound.TimePosition = 0
			end)
		end
		local CreateZone = Zone.new(v)
		CreateZone.localPlayerEntered:Connect(function(Player)
			if _G.Music == true then
				if Sound then Sound:Play() end
				game:GetService("TweenService"):Create(Sound, TweenInfo.new(1.5), {Volume = DefaultVolume}):Play()
			end
		end)
		CreateZone.localPlayerExited:Connect(function(Player)
			local Tween = game:GetService("TweenService"):Create(Sound, TweenInfo.new(1.5), {Volume = 0})
			Tween:Play()
			Tween.Completed:Wait()
			if Sound then Sound.TimePosition = 0 Sound:Stop() end
		end)
	end
end

workspace:FindFirstChild('AudioZones'):WaitForChild('Sugar').Touched:Connect(function(Hit)
	if Hit == HumanoidRootPart then
		Player.PlayerGui:FindFirstChild('Harvested').Enabled = true
		Player.PlayerGui:FindFirstChild('Harvested'):FindFirstChild('TextLabel').Visible = false
		Player.PlayerGui:FindFirstChild('Harvested'):FindFirstChild('Sugar').Visible = true
	end
end)

workspace:FindFirstChild('AudioZones'):WaitForChild('Sugar').TouchEnded:Connect(function(Hit)
	if Hit == HumanoidRootPart then
		Player.PlayerGui:FindFirstChild('Harvested').Enabled = false
		Player.PlayerGui:FindFirstChild('Harvested'):FindFirstChild('TextLabel').Visible = false
		Player.PlayerGui:FindFirstChild('Harvested'):FindFirstChild('Sugar').Visible = false
	end
end)