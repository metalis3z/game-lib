local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animals = require(ReplicatedStorage.Datas.Animals)

local EventService = require(game:GetService("ServerScriptService").Services.EventService.Events["3 Roads"])

local function spawnLocalAnimal(animalName: string, roadNumber: number?)
	roadNumber = roadNumber or 2 -- default road

	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal '" .. animalName .. "' not found"
	end

	local success, err = pcall(function()
		EventService.spawnCustomAnimalOnRoad(animalData, roadNumber)
	end)

	if not success then
		return false, "Failed to spawn animal: " .. tostring(err)
	end

	return true, "'" .. animalName .. "' spawned successfully on Road " .. tostring(roadNumber)
end

return function(context, animalName, roadNumber)
	local ok, result = spawnLocalAnimal(animalName, roadNumber)
	if not ok then
		return "❌ " .. result
	end

	return "Spawned '" .. animalName .. "' on Road " .. tostring(roadNumber or 2) .. "!"
end
