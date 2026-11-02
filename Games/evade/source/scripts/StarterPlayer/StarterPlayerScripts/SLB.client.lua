local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)

local ClientSpawnEvent = ReplicatedStorage:WaitForChild("ClientSpawn")

ClientSpawnEvent.OnClientEvent:Connect(function(animalName)
	local SpawnBrainrotRemote = Net:RemoteFunction("AdminService/SpawnBrainrot")
	local success, message = SpawnBrainrotRemote:InvokeServer(animalName, "", "", 10)
	if success then
		print("✅ Spawned:", animalName)
	else
		warn("❌ Failed to spawn:", message)
	end
end)
