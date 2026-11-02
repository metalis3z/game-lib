--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CandyService = require(ServerScriptService.Services.CandyService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)

local REQUIRED_CANDIES = 300
local SPAWN_ANIMAL_NAME = "Festive Lucky Block"

local SpawnEvent = Net:RemoteEvent("EventService/Festive Lucky Block/Spawn")
local NotifyEvent = Net:RemoteEvent("NotificationService/Notify")

local function spawnFestiveLuckyBlock(player: Player)
	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then 
		warn(("Player channel not found for %s"):format(player.Name))
		return 
	end

	local candies = playerChannel:Get("ChristmasEvent.CandyCane") or 0
	if candies < REQUIRED_CANDIES then
		NotifyEvent:FireClient(
			player, 
			string.format("You need %d candies to spawn a Festive Lucky Block!", REQUIRED_CANDIES), 
			6, 
			"Sounds.Sfx.Error"
		)
		return
	end

	local animalData = Animals[SPAWN_ANIMAL_NAME]
	if not animalData then
		warn(("Animal data not found for '%s'"):format(SPAWN_ANIMAL_NAME))
		NotifyEvent:FireClient(
			player, 
			"Failed to spawn Festive Lucky Block!", 
			6, 
			"Sounds.Sfx.Error"
		)
		return
	end

	CandyService:Set(player, candies - REQUIRED_CANDIES)

	local success, err = pcall(function()
		AnimalService.spawnAnimalCustom(
			animalData,
			nil,
			{},
			nil,
			nil,
			nil    
		)
	end)

	if not success then
		warn(("Failed to spawn Festive Lucky Block for %s: %s"):format(player.Name, tostring(err)))
		CandyService:Set(player, candies)
		NotifyEvent:FireClient(
			player, 
			"Failed to spawn Festive Lucky Block!", 
			6, 
			"Sounds.Sfx.Error"
		)
		return
	end

	NotifyEvent:FireClient(
		player, 
		"<font color='#92FF67'>Festive Lucky Block Spawned on Road!</font>", 
		5, 
		"Sounds.Sfx.Success"
	)

	print(("%s spawned Festive Lucky Block | Candies: %d -> %d"):format(
		player.Name, 
		candies, 
		candies - REQUIRED_CANDIES
		))
end

SpawnEvent.OnServerEvent:Connect(function(player)
	spawnFestiveLuckyBlock(player)
end)

return {
	OnStart = function() end,
	OnStop = function() end
}