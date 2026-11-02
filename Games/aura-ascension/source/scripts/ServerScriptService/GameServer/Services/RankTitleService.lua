local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Ranked = require(ReplicatedStorage:WaitForChild("Ranked"))
local PacksConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PacksConfig"))
local RankAuraUtil = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RankAuraUtil"))
local TableUtil = require(script.Parent.Parent.Core.TableUtil)

local RankTitleService = {}
RankTitleService.__index = RankTitleService

function RankTitleService.new()
	return setmetatable({}, RankTitleService)
end

function RankTitleService:Init(registry)
	self.Registry = registry
	self.DataService = registry:Get("DataService")
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.RemoteBinder:BindFunction("RankTitleService", "GetRankTitleData", function(player)
		return self:GetRankTitleData(player)
	end)
	self.RemoteBinder:BindFunction("RankTitleService", "EquipRankTitle", function(player, rankIndex)
		return self:EquipRankTitle(player, rankIndex)
	end)
	self.RemoteBinder:BindFunction("RankTitleService", "UnequipRankTitle", function(player)
		return self:UnequipRankTitle(player)
	end)
	self.RemoteBinder:BindFunction("RankTitleService", "EquipPackTitle", function(player, titleId)
		return self:EquipPackTitle(player, titleId)
	end)
	self.RemoteBinder:BindFunction("RankTitleService", "UnequipPackTitle", function(player)
		return self:UnequipPackTitle(player)
	end)
end

function RankTitleService:Start()
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:PushRankTitleData(player)
	end)
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if self.DataService:GetProfile(player) then
			self:PushRankTitleData(player)
		end
	end
end

function RankTitleService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function RankTitleService:_buildRankArray(profile)
	local peakRankIndex = select(1, Ranked.GetRankByAura(profile.Stats.PeakAura or 0))
	local currentRankIndex = select(1, Ranked.GetRankByAura(profile.Stats.Aura or 0))
	local displayRankIndex = profile.Inventory.EquippedRankIndex or 0
	if displayRankIndex <= 0 then
		displayRankIndex = currentRankIndex
	end
	local ranks = {}
	for index = 1, Ranked.GetCount() do
		local rank = Ranked.GetRank(index)
		table.insert(ranks, {
			Index = index,
			Name = rank and rank.Name or ("Rank " .. index),
			Unlocked = index <= peakRankIndex,
			Equipped = (profile.Inventory.EquippedPackTitle or "") == "" and (profile.Inventory.EquippedRankIndex or 0) == index,
			IsDefaultDisplay = index == currentRankIndex,
		})
	end
	return ranks, peakRankIndex, currentRankIndex, displayRankIndex
end

function RankTitleService:_buildCombinedEntries(profile, rankEntries)
	local entries = {}
	for _, rankEntry in ipairs(rankEntries) do
		table.insert(entries, {
			EntryType = "Rank",
			EntryKey = "Rank:" .. tostring(rankEntry.Index),
			RankIndex = rankEntry.Index,
			AuraKey = RankAuraUtil.GetAuraKeyForRank(rankEntry.Index, Ranked.GetCount()),
			Name = rankEntry.Name,
			TemplateName = rankEntry.Name,
			Unlocked = rankEntry.Unlocked,
			Equipped = rankEntry.Equipped,
			IsDefaultDisplay = rankEntry.IsDefaultDisplay,
		})
	end
	for packId in pairs(profile.Inventory.OwnedPacks) do
		local pack = PacksConfig.GetPack(packId)
		if pack and pack.Title and type(pack.Title.Id) == "string" then
			table.insert(entries, {
				EntryType = "PackTitle",
				EntryKey = "PackTitle:" .. pack.Title.Id,
				TitleId = pack.Title.Id,
				Name = pack.Title.DisplayName or pack.Title.Id,
				TemplateName = pack.Title.RankTextTemplate or pack.Title.DisplayName or pack.Title.Id,
				Unlocked = true,
				Equipped = (profile.Inventory.EquippedPackTitle or "") == pack.Title.Id,
				IsDefaultDisplay = false,
			})
		end
	end
	return entries
end

function RankTitleService:GetRankTitleData(player)
	local profile = self:_getProfile(player)
	if not profile then
		return nil
	end
	local rankEntries, peakRankIndex, currentRankIndex, displayRankIndex = self:_buildRankArray(profile)
	return {
		UnlockedRankIndex = peakRankIndex,
		EquippedRankIndex = profile.Inventory.EquippedRankIndex or 0,
		EffectiveRankIndex = currentRankIndex,
		DisplayRankIndex = displayRankIndex,
		EquippedPackTitleId = profile.Inventory.EquippedPackTitle or "",
		Ranks = rankEntries,
		Entries = self:_buildCombinedEntries(profile, rankEntries),
	}
end

function RankTitleService:PushRankTitleData(player)
	self.RemoteBinder:FireClient("RankTitleService", "RankTitleDataUpdated", player, self:GetRankTitleData(player))
end

function RankTitleService:EquipRankTitle(player, rankIndex)
	rankIndex = tonumber(rankIndex)
	local profile = self:_getProfile(player)
	if not profile or not rankIndex then
		return { ok = false, reason = "INVALID_RANK" }
	end
	local peakRankIndex = select(1, Ranked.GetRankByAura(profile.Stats.PeakAura or 0))
	if rankIndex < 1 or rankIndex > peakRankIndex then
		return { ok = false, reason = "RANK_LOCKED" }
	end
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedRankIndex = rankIndex
		data.Inventory.EquippedPackTitle = ""
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushRankTitleData(player)
	self.Registry:Get("PackService"):PushPackData(player)
	return { ok = true, rankIndex = rankIndex }
end

function RankTitleService:UnequipRankTitle(player)
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedRankIndex = 0
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushRankTitleData(player)
	return { ok = true }
end

function RankTitleService:EquipPackTitle(player, titleId)
	local profile = self:_getProfile(player)
	if not profile or type(titleId) ~= "string" then
		return { ok = false, reason = "INVALID_TITLE" }
	end
	if profile.Inventory.OwnedPackTitles[titleId] ~= true then
		return { ok = false, reason = "TITLE_LOCKED" }
	end
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedPackTitle = titleId
		data.Inventory.EquippedRankIndex = 0
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushRankTitleData(player)
	self.Registry:Get("PackService"):PushPackData(player)
	return { ok = true, titleId = titleId }
end

function RankTitleService:UnequipPackTitle(player)
	self.DataService:Mutate(player, function(data)
		data.Inventory.EquippedPackTitle = ""
	end)
	self.Registry:Get("PlayerService"):SyncReplicatedState(player)
	self:PushRankTitleData(player)
	self.Registry:Get("PackService"):PushPackData(player)
	return { ok = true }
end

return RankTitleService
