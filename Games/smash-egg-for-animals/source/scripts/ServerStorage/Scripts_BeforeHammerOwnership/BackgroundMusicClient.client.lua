-- Musique de fond. Un seul son, nommé "Days" dans SoundService : les events (sorcière, concert, cutscenes)
-- le mettent en pause par ce nom. Thème Halloween (Lighting.Theme = "Halloween") : trois musiques qui s'enchaînent.
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local VOLUME = 0.5
local HALLOWEEN = {
	"rbxassetid://111631783838916", -- Spooky cartoon music
	"rbxassetid://132339469996629", -- Halloween skeleton dance
	"rbxassetid://138852308346207", -- Halloween, Pt. 2
}

local playlist
if Lighting:GetAttribute("Theme") == "Halloween" then
	playlist = HALLOWEEN
else
	local days = workspace:FindFirstChild("Sound") and workspace.Sound:FindFirstChild("Days")
	playlist = days and {days.SoundId} or {}
end
if #playlist == 0 then return end

local sound = Instance.new("Sound")
sound.Name = "Days"
sound.Volume = VOLUME
sound.Looped = #playlist == 1
sound.Parent = SoundService

local index = 0
local function nextTrack()
	index = index % #playlist + 1
	sound.SoundId = playlist[index]
	sound.TimePosition = 0
	sound:Play()
end
sound.Ended:Connect(nextTrack) -- (ne se déclenche pas quand un event met la musique en pause)
nextTrack()
