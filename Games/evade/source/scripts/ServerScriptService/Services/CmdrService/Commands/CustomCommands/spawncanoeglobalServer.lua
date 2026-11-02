local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local MessagingService = game:GetService("MessagingService")
local CollectionService = game:GetService("CollectionService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(game.ServerScriptService.Services.AnimalService)

-- ⛵ Spawn logic
local function spawnAnimalWithCanoe(animalName)
	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal '" .. animalName .. "' not found"
	end

	local spawnedAnimal = AnimalService.spawnAnimalImmediate(animalData)
	if not spawnedAnimal then
		return false, "Failed to spawn animal"
	end

	if spawnedAnimal.PrimaryPart then
		CollectionService:AddTag(spawnedAnimal.PrimaryPart, "IndonesiaCanoe")
	end

	return true, "Animal spawned successfully with Canoe"
end

-- 🌐 GLOBAL MESSAGE LISTENER
MessagingService:SubscribeAsync("GlobalCanoeSpawn", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local animalName = data.AnimalName
	spawnAnimalWithCanoe(animalName)
end)

-- 🌐 COMMAND EXECUTION
return function(context, animalName)
	local ok, msg = spawnAnimalWithCanoe(animalName)
	if not ok then
		return "❌ " .. msg
	end

	-- Broadcast globally
	pcall(function()
		MessagingService:PublishAsync("GlobalCanoeSpawn", {
			AnimalName = animalName,
			FromServer = game.JobId,
			Executor = context.Executor and context.Executor.Name or "Unknown"
		})
	end)

	return "✅ Spawned '" .. animalName .. "' globally with a Canoe!"
end
