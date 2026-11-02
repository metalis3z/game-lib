local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("PlayKeySound")

event.OnClientEvent:Connect(function(sensor, soundName)
	if not sensor or not soundName then return end

	if soundName == "Silent" then return end -- skip silent ones

	-- Create a sound right in the script
	local sound = Instance.new("Sound")
	sound.SoundId = (soundName == "KeySound1" and "rbxassetid://96564904860185") or 
		(soundName == "KeySound2" and "rbxassetid://94453991160241")
	sound.Volume = 0.5
	sound.PlayOnRemove = true -- this plays immediately when destroyed
	sound.Parent = script
	sound:Destroy() -- triggers the PlayOnRemove trick
end)
