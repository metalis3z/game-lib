local Auras = require(game.ReplicatedStorage.Shared.List.Items.Auras)
local AuraLevels = require(game.ReplicatedStorage.Shared.List.AuraLevels)
local Functions = require(game.ReplicatedStorage.Shared.Functions)
local Items = require(game.ReplicatedStorage.Shared.Items)

local module = {}

function module.getNewChances(data, luckMultiplier)
	local copied = Functions.deepCopy(Auras)
	local luckBonus = 0
	local commonCount = 0

	for id, aura in pairs(copied) do
		if id ~= 1 then
			luckBonus += aura.chance * (luckMultiplier - 1)
			aura.chance *= luckMultiplier
		else
			commonCount += 1
		end
	end

	if commonCount > 0 then
		for id, aura in pairs(copied) do
			if id == 1 then
				aura.chance -= luckBonus / commonCount
			end
		end
	end

	for _, aura in copied do
		if aura.chance >= 100 or aura.chance < 0 then
			aura.chance = 0
		end
	end

	return copied
end

function module.getLevel(data)
	for i = #AuraLevels, 1, -1 do
		if (data.auraXp or 0) >= AuraLevels[i].required then
			return i
		end
	end
	return 1
end

function module.getLevelProgress(data)
	local level = module.getLevel(data)
	local currentData = AuraLevels[level]
	if AuraLevels[level + 1] then
		local currentReq = currentData and currentData.required or 0
		return ((data.auraXp or 0) - currentReq) / (AuraLevels[level + 1].required - currentReq)
	end
	return 1
end

function module.getAuraDescriptor(aura)
	return aura:getName():gsub(" ", ""):lower()
end

function module.getItemFromDescriptor(descriptor)
	for id, _ in Auras do
		local item = Items.aura(id)
		if module.getAuraDescriptor(item) == descriptor then
			return item
		end
	end
end

return module