local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)
local Prestiges = require(RS.Shared.List.Prestige.Prestiges)

local PrestigeService = Knit.CreateService({
	Name = "PrestigeService",
	Client = {},
	_ds = nil,
	_inv = nil,
})

function PrestigeService.Client:claim(player, tier)
	if type(tier) ~= "number" then return "invalid" end
	local prestigeData = Prestiges[tier]
	if not prestigeData then return "invalidTier" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	if (data.prestige or 0) >= tier then return "alreadyClaimed" end
	if tier > 1 and (data.prestige or 0) < tier - 1 then return "previousNotClaimed" end
	-- Check XP requirement
	if (data.prestigeXp or 0) < prestigeData.required then
		return "requirementsNotMet"
	end
	self.Server._ds:Set(player, {"prestige"}, tier)
	if prestigeData.rewards then
		for _, reward in prestigeData.rewards do
			if self.Server._inv and self.Server._inv.GiveReward then
				self.Server._inv:GiveReward(player, reward)
			end
		end
	end
	return "success"
end

function PrestigeService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._inv = Knit.GetService("InventoryService")
end

function PrestigeService:KnitStart()
	print("[PrestigeService] Started")
end

return PrestigeService