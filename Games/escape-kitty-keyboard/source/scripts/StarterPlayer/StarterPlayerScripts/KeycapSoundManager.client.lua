-- KeycapSoundManager
-- sound by devlenny too
-- create by devlenny dont leak it

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

-- Sound configuration
local SOUND_ID = "rbxassetid://96591611478915"
local SOUND_VOLUME = 0.8
local DEBOUNCE_TIME = 0.15
local PITCH_MIN = 0.9
local PITCH_MAX = 1.1

-- Create a single shared Sound instance (NOT parented to any keycap)
local sharedSound = Instance.new("Sound")
sharedSound.Name = "KeycapClickSound"
sharedSound.SoundId = SOUND_ID
sharedSound.Volume = SOUND_VOLUME
sharedSound.PlaybackSpeed = 1.0
sharedSound.Parent = SoundService

-- Debounce per keycap to prevent sound spam
local debounce = {}

local function isKeycap(obj)
	return obj:IsA("BasePart") and string.find(string.lower(obj.Name), "keycap") ~= nil
end

local function playKeycapSound(keycap)
	if not keycap or not keycap.Parent then return end
	if debounce[keycap] then return end
	debounce[keycap] = true

	-- Slightly vary playback speed for a natural feel
	sharedSound.PlaybackSpeed = PITCH_MIN + math.random() * (PITCH_MAX - PITCH_MIN)
	sharedSound:Play()

	task.wait(DEBOUNCE_TIME)
	debounce[keycap] = nil
end

local function setupCharacter(character)
	local function connectPart(part)
		if not part:IsA("BasePart") then return end

		part.Touched:Connect(function(hit)
			if isKeycap(hit) then
				playKeycapSound(hit)
			end
		end)
	end

	for _, part in character:GetChildren() do
		connectPart(part)
	end

	character.ChildAdded:Connect(connectPart)
end

-- Handle current character
if player.Character then
	setupCharacter(player.Character)
end

-- Handle future characters
player.CharacterAdded:Connect(setupCharacter)