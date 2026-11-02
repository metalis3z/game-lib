-- KeysClick Server Script (slim — just plays the sound server-side)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("PlayKeySound")

local function getRandomSoundName()
	local names = {"KeySound1", "KeySound2", "Silent"}
	return names[math.random(1, #names)]
end

event.OnServerEvent:Connect(function(player, sensor, soundName)
	-- Validate: sensor must exist in workspace and belong to a ModelKey
	if not sensor or not sensor.Parent then return end
	if sensor.Name ~= "Sensor" then return end
	if not sensor.Parent:IsA("Model") or sensor.Parent.Name ~= "ModelKey" then return end
	-- Sound playback or other server logic here if needed
end)