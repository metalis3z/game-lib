local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)
local IndexRewards = require(RS.Shared.List.IndexRewards)
local IndexUtils = require(RS.Shared.Util.IndexUtils)

local IndexService = Knit.CreateService({
	Name = "IndexService",
	Client = {},
	_ds = nil,
	_inv = nil,
})

function IndexService.Client:claimIndexReward(player, tier)
	if type(tier) ~= "number" then return "invalid" end
	local rewardData = IndexRewards[tier]
	if not rewardData then return "invalidTier" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	if data.claimedIndexRewards and table.find(data.claimedIndexRewards, tier) then
		return "alreadyClaimed"
	end
	local indexCount = IndexUtils.countIndex(data)
	if indexCount < (rewardData.required or 0) then return "notEnough" end
	local replica = self.Server._ds:GetReplica(player)
	if not replica then return "noReplica" end
	replica:TableInsert({"claimedIndexRewards"}, tier)
	if rewardData.rewards then
		for _, reward in rewardData.rewards do
			self.Server._inv:GiveReward(player, reward)
		end
	end
	return "success"
end

function IndexService:KnitInit()
	self._ds = Knit.GetService("DataService")
	self._inv = Knit.GetService("InventoryService")
end

function IndexService:KnitStart()
	print("[IndexService] Started")
end

return IndexService