-- Game: rcu-roller
-- Original: ServerScriptService/Services/AuraService.lua
-- Original: ReplicatedStorage/Shared/Util/AuraUtils.lua
-- What it does: Bundle of AuraService (consume a dice item, roll an aura on the server) and AuraUtils (luck redistribution with clamping, aura XP level/progress).
-- ===== Whole file: ServerScriptService/Services/AuraService.lua =====
local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)
local Auras = require(RS.Shared.List.Items.Auras)
local AuraUtils = require(RS.Shared.Util.AuraUtils)
local Values = require(RS.Shared.Values)

local AuraService = Knit.CreateService({
	Name = "AuraService",
	Client = {
		equipAura = Knit.CreateSignal(),
		removeAura = Knit.CreateSignal(),
		existUpdated = Knit.CreateSignal(),
		getExist = Knit.CreateSignal(),
	},
	_ds = nil,
	_inv = nil,
})

function AuraService.Client:roll(player)
	local data = self.Server._ds:GetData(player)
	if not data then return nil end

	local auraDiceId = nil
	if data.inventory and data.inventory.auraDice then
		for id, _ in data.inventory.auraDice do
			auraDiceId = id
			break
		end
	end
	if not auraDiceId then return "noDice" end

	local replica = self.Server._ds:GetReplica(player)
	if not replica then return nil end
	replica:Set({"inventory", "auraDice", auraDiceId}, nil)

	local luckMult = Values.auraLuck(player, data) + 1
	local chances = AuraUtils.getNewChances(data, luckMult)

	local roll = math.random() * 100
	local accumulated = 0
	local wonAura = nil
	for id, auraData in chances do
		accumulated += auraData.chance
		if roll <= accumulated then
			wonAura = id
			break
		end
	end

	if not wonAura then wonAura = 1 end

	replica:Set({"stats", "auraRolls"}, (data.stats.auraRolls or 0) + 1)
	local QuestService = Knit.GetService("QuestService")
	QuestService:IncrementQuest(player, "useAuraDice", 1)

	local xpGain = 1
	replica:Set({"auraXp"}, (data.auraXp or 0) + xpGain)

	return wonAura
end

function AuraService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._inv = Knit.GetService("InventoryService")

	self.Client.equipAura:Connect(function(player, auraId)
		local data = self._ds:GetData(player)
		if not data then return end
		self._ds:Set(player, {"equippedAura"}, auraId or "")
	end)

	self.Client.removeAura:Connect(function(player)
		self._ds:Set(player, {"equippedAura"}, "")
	end)
end

function AuraService:KnitStart()
	print("[AuraService] Started")
end

return AuraService

-- ===== Whole file: ReplicatedStorage/Shared/Util/AuraUtils.lua =====
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
