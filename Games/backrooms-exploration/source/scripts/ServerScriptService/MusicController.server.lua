local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local soundsFolder = workspace:WaitForChild("Sounds")
local musicSound = soundsFolder:WaitForChild("Music")

local function playMusic()
	if not musicSound.IsPlaying then
		musicSound.Looped = true
		musicSound:Play()
	end
end

Players.PlayerAdded:Connect(function(player)
	playMusic()
end)

if #Players:GetPlayers() > 0 then
	playMusic()
end