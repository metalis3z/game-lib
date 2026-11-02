local PetSystem = require(game.ReplicatedStorage.Engine.Modules.PetSystem)
local DataManager = require(script.Parent)

local dataStoreService = game:GetService("DataStoreService")
local mostRolledStore = dataStoreService:GetOrderedDataStore("mostRolled")
local rarestRollsStore = dataStoreService:GetOrderedDataStore("rarestRoll")

local replicatedStorage = game:GetService("ReplicatedStorage")
local dataModules = replicatedStorage.DataModules
local raritiesMod = require(dataModules.Rarities)
local petsMod = require(dataModules.Pets)
local assistance = require(replicatedStorage.Engine.Modules.Assistance)

local ChangeData = {}

local function getChance(rarity, totalRarity)
	return math.round(1/rarity * totalRarity)
end

local function getAccumulated(weightsTable)
	local totalWeight = 0
	for _, weight in pairs(weightsTable) do
		totalWeight = totalWeight + weight.weight
	end
	return totalWeight
end

local function searchPets(petNames)
	local lowestChance = 0
	for _, petName in pairs(petNames) do
		local pet = assistance.findPetViaName(petName)
		local chance = pet.weight
		local accumulated = getAccumulated(petsMod)
		local finalChance = getChance(chance, accumulated)
		if lowestChance < finalChance then
			lowestChance = finalChance
		end
	end
	return lowestChance
end

ChangeData.ChangeValue = function(player:Player, valueToChange, newValue, optionalPath)
	DataManager.profiles[player].Data[valueToChange] = newValue
	if optionalPath then
		optionalPath.Value = DataManager.profiles[player].Data[valueToChange]
	end
end

ChangeData.ChangeNotDataValue = function(player:Player, valueToChange, newValue)
	valueToChange.Value = newValue
end

ChangeData.AddRoll = function(player:Player, amount:number)
	DataManager.profiles[player].Data["Rolls"] += amount
	player.leaderstats["Roll 🎲"].Value += amount
end

ChangeData.AddPet = function(player:Player, petName)
	table.insert(DataManager.profiles[player].Data["Pets"], petName)
	PetSystem.UpdatePets(player)
end

return ChangeData