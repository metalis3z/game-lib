local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Animals = require(ReplicatedStorage.Datas.Animals)

local EventService = require(game:GetService("ServerScriptService").Services.EventService.Events["3 Roads"])
local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)


local function spawnAnimalOnAllRoads(animalName: string)
	local animalData = Animals[animalName]
	if not animalData then
		return false, "Animal '" .. animalName .. "' not found"
	end

	local success, err = pcall(function()
		AnimalService.spawnAnimalCustom(animalData)
		for road = 2, 3 do
			EventService.spawnCustomAnimalOnRoad(animalData, road)
		end
	end)

	if not success then
		return false, "Failed to spawn animal: " .. tostring(err)
	end

	return true, "'" .. animalName .. "' spawned successfully on all 3 roads!"
end

return function(context, animalName)
	if not animalName or animalName == "" then
		return "❌ You must provide an animal name!"
	end

	local ok, result = spawnAnimalOnAllRoads(animalName)
	if not ok then
		return "❌ " .. result
	end

	return result
end
