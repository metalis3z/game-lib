local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ranked = require(ReplicatedStorage:WaitForChild("Ranked"))
local RankAuraUtil = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RankAuraUtil"))

local AuraPreviewService = {}
AuraPreviewService.__index = AuraPreviewService

function AuraPreviewService.new()
	return setmetatable({}, AuraPreviewService)
end

function AuraPreviewService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.RemoteBinder:BindFunction("AuraPreviewService", "GetAuraPreviewData", function(player)
		return self:GetAuraPreviewData(player)
	end)
end

function AuraPreviewService:GetAuraPreviewData(player)
	local profile = self.DataService:GetProfile(player)
	if not profile then
		return nil
	end
	local rankIndex = select(1, Ranked.GetRankByAura(profile.Stats.Aura or 0))
	local auraKey = RankAuraUtil.GetAuraKeyForRank(rankIndex, Ranked.GetCount())
	return {
		RankIndex = rankIndex,
		AuraKey = auraKey,
		EquippedAuraKey = player:GetAttribute("EquippedAuraKey") or auraKey,
	}
end

return AuraPreviewService
