local LeprechaunLuckyBlock = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local AnimalData = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Spawn = Net:RemoteEvent("EventService/Leprechaun Lucky Block/Spawn")

function LeprechaunLuckyBlock.OnStart()
end

function LeprechaunLuckyBlock.OnStop()
end

Spawn.OnServerEvent:Connect(function(player)

	local PlayerData = Synchronizer:Get(player)
	if not PlayerData then return end

	local CurrentCoins = PlayerData:Get("StPatricksEvent.GoldCoins") or 0
	local Requirement = 50

	if CurrentCoins < Requirement then
		NotificationService.Error(player, "Not enough Gold Coins!")
		return
	end

	PlayerData:Increase("StPatricksEvent.GoldCoins", -Requirement)

	AnimalService.SpawnForcedAnimal(
		AnimalData["Leprechaun Lucky Block"]
	)

	NotificationService.Success(player, "Leprechaun Lucky Block Spawned!")

end)

return LeprechaunLuckyBlock