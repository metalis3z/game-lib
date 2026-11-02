local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local CollectionService = game:GetService("CollectionService")

local Animals = require(ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Animals"))
local AnimalService = require(game.ServerScriptService:WaitForChild("Services"):WaitForChild("AnimalService"))

local function spawnAnimalWithCanoe(animalName)
	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal '" .. tostring(animalName) .. "' not found"
	end

	local spawnedAnimal = AnimalService.spawnAnimalImmediate(animalData)
	if not spawnedAnimal then
		return false, "Failed to spawn animal instance"
	end

	if spawnedAnimal:IsA("Model") and spawnedAnimal.PrimaryPart then
		CollectionService:AddTag(spawnedAnimal.PrimaryPart, "IndonesiaCanoe")
	else
		CollectionService:AddTag(spawnedAnimal, "IndonesiaCanoe")
	end

	return true, spawnedAnimal
end

return function(context, animalName)
	if not animalName then
		return "❌ Error: No animal name provided"
	end

	local ok, result = spawnAnimalWithCanoe(animalName)
	if not ok then
		return "❌ " .. result
	end

	local publishSuccess, publishError = pcall(function()
		MessagingService:PublishAsync("GlobalCanoeSpawn", {
			AnimalName = animalName,
			FromServer = game.JobId,
			Executor = (context and context.Executor) and context.Executor.Name or "System"
		})
	end)

	if not publishSuccess then
		return "✅ '" .. animalName .. "' spawned locally (Global broadcast failed)"
	end

	return "✅ '" .. animalName .. "' spawned globally with Canoe!"
end