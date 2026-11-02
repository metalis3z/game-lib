local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players           = game:GetService("Players")
local LocalPlayer       = Players.LocalPlayer

local event = ReplicatedStorage:WaitForChild("PlayKeySound")

local function keyboardSoundOff(): boolean
	local settings = _G.PlayerSettings
	return settings ~= nil and settings.KeyboardSoundOff == true
end

event.OnClientEvent:Connect(function(sensor, soundName)
	if not sensor or not soundName then return end
	if soundName == "Silent" then return end
	if keyboardSoundOff() then return end

	local sound = Instance.new("Sound")
	sound.SoundId = (soundName == "KeySound1" and "rbxassetid://140336132302166")
		or (soundName == "KeySound2" and "rbxassetid://140336132302166")
	sound.Volume = 0.5
	sound.PlayOnRemove = true
	sound.Parent = script
	sound:Destroy()
end)