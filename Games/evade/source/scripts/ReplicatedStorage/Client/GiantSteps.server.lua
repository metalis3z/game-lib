local Players = game:GetService("Players")

local GIANT_SOUND_ID = "rbxassetid://72918943937811"
local GIANT_SPEED = 0.5
local GIANT_VOLUME = 3

local function applyGiantSound(sound, character)
	if sound:IsA("Sound") and sound.Name == "Running" then
		if character:GetAttribute("GiantSteps") == true then
			sound.SoundId = GIANT_SOUND_ID
			sound.PlaybackSpeed = GIANT_SPEED
			sound.Volume = GIANT_VOLUME
		end
	end
end

local function setupCharacter(player, character)
	local rootPart = character:WaitForChild("HumanoidRootPart", 10)
	if not rootPart then return end

	rootPart.ChildAdded:Connect(function(child)
		applyGiantSound(child, character)
	end)

	character:GetAttributeChangedSignal("GiantSteps"):Connect(function()
		for _, child in rootPart:GetChildren() do
			applyGiantSound(child, character)
		end
	end)

	for _, child in rootPart:GetChildren() do
		applyGiantSound(child, character)
	end
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		setupCharacter(player, character)
	end)

	if player.Character then
		task.spawn(setupCharacter, player, player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(onPlayerAdded, player)
end