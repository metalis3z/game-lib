-- Game: rcu-roller
-- Original: ReplicatedStorage/Shared/Util/PetUtils.lua
-- What it does: getNewChances: multiplies the chance of 'luck-affected' pets and subtracts the same total from the common pets so the egg still sums to 100%. Also pet descriptor / rarity helpers.

local RS = game:GetService("ReplicatedStorage")
local Rarities = require(RS.Shared.List.Pets.Rarities)
local Eggs = require(RS.Shared.List.Pets.Eggs)
local Items = require(RS.Shared.Items)
local Functions = require(RS.Shared.Functions)
local Values = require(RS.Shared.Values)
local PetsConfig = require(RS.Shared.List.Pets.Pets)
local Tiers = require(RS.Shared.List.Pets.Tiers)

local module = {}

function module.getNewChances(player, data, eggName, extraLuck)
	local luckMult = Values.luck(player, data) + (extraLuck or 0)
	local petsTable = {}
	local nonLuckCount = 0

	for petName, chance in Eggs[eggName].pets do
		local petCfg = PetsConfig[petName]
		petsTable[petName] = {
			chance = chance,
			luck = petCfg and petCfg.luck,
			rarity = petCfg and petCfg.rarity,
			multiplier = petCfg and petCfg.multiplier,
		}
	end

	local copied = Functions.deepCopy(petsTable)
	local luckBonus = 0

	for _, pet in pairs(copied) do
		if pet.luck then
			luckBonus += pet.chance * (luckMult - 1)
			pet.chance *= luckMult
		else
			nonLuckCount += 1
		end
	end

	if nonLuckCount > 0 then
		for _, pet in pairs(copied) do
			if not pet.luck then
				pet.chance -= luckBonus / nonLuckCount
			end
		end
	end

	return copied
end

function module.getPetChance(player, data, petName, extraLuck)
	local eggName = module.getEggFromPetName(petName)
	if not eggName then return 0 end
	local chances = module.getNewChances(player, data, eggName, extraLuck)
	if chances[petName] then
		return chances[petName].chance
	end
	return 0
end

function module.getEggFromPetName(petName)
	for eggName, eggData in pairs(Eggs) do
		for name, _ in pairs(eggData.pets) do
			if name == petName then
				return eggName, eggData
			end
		end
	end
end

function module.isSame(pet1, pet2)
	local ignoreKeys = {am = true, lk = true}
	local function deepCompare(a, b)
		for key, val in a do
			if ignoreKeys[key] then continue end
			local bVal = b[key]
			if bVal == nil then return false end
			if type(val) == "table" and type(bVal) == "table" then
				if not deepCompare(val, bVal) then return false end
			elseif val ~= bVal then
				return false
			end
		end
		return true
	end
	return deepCompare(pet1, pet2) and deepCompare(pet2, pet1)
end

function module.getPetsSorted(data)
	local result = {}
	for id, petData in Functions.deepCopy(data.inventory and data.inventory.pet or {}) do
		result[#result + 1] = {
			itemId = id,
			item = Items.pet(petData.nm):setData(petData),
		}
	end
	table.sort(result, function(a, b)
		return a.item:getMultiplier(data) > b.item:getMultiplier(data)
	end)
	return result
end

function module.getExistingArchivedPet(data, pet)
	for id, petData in pairs(data.archivedPets or {}) do
		if module.isSame(petData, pet) then
			return Items.pet(petData.nm):setData(petData), id
		end
	end
end

function module.getRarityId(rarityName)
	for i, v in Rarities do
		if v.name == rarityName then return i end
	end
	return 1
end

function module.getRarityData(rarityId)
	return Rarities[rarityId]
end

function module.getTierData(tierName)
	return Tiers[tierName]
end

function module.getPetDescriptor(pet)
	local formatted = pet:getName():gsub(" ", ""):lower() .. ":" .. tostring(pet:getTier())
	if pet:isShiny() then
		formatted = formatted .. ":s"
	end
	return formatted
end

return module
