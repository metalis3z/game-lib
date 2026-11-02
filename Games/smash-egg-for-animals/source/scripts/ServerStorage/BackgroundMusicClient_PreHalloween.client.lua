-- Background music that plays automatically when the game starts
-- Plays the "Days" sound on loop for every player

local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

-- Find the existing Days sound in Workspace.Sound
local existingSound = Workspace:FindFirstChild("Sound") and Workspace.Sound:FindFirstChild("Days")

if existingSound then
	-- Create a local 2D sound for background music (not positional)
	local bgSound = Instance.new("Sound")
	bgSound.Name = "Days"
	bgSound.SoundId = existingSound.SoundId
	bgSound.Volume = 0.5
	bgSound.Looped = true
	bgSound.Parent = SoundService
	
	-- Play the background music
	bgSound:Play()
end