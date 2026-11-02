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