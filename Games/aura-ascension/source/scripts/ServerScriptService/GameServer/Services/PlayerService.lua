local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GameConfig = require(script.Parent.Parent.Config.GameConfig)
local TrainingAreasConfig = require(script.Parent.Parent.Config.TrainingAreasConfig)
local RateLimiter = require(script.Parent.Parent.Core.RateLimiter)
local TableUtil = require(script.Parent.Parent.Core.TableUtil)
local Ranked = require(ReplicatedStorage:WaitForChild("Ranked"))
local RankAuraUtil = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("RankAuraUtil"))
local PacksConfig = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("PacksConfig"))
local MonetizationConfig = require(ReplicatedStorage:WaitForChild("Monetization"))
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))
local CosmeticService = require(ServerStorage:WaitForChild("Modules"):WaitForChild("CosmeticService"))

local LEADERSTAT_AURA_NAME = "🟣 Aura"
local LEADERSTAT_REBIRTHS_NAME = "🔄 Rebirths"

local PlayerService = {}
PlayerService.__index = PlayerService

local function sanitizeWholeNumber(value)
	value = tonumber(value) or 0
	if value ~= value or value == math.huge or value == -math.huge then
		return 0
	end
	return math.max(0, math.floor(value))
end

local function getSafeBigNumberAsNumber(value)
	local asNumber = MathUtility.ToNumber(MathUtility.Floor(value) or value)
	if asNumber ~= nil and asNumber == asNumber and asNumber ~= math.huge and asNumber ~= -math.huge then
		return math.max(0, asNumber)
	end

	local normalized = MathUtility.Normalize(value) or MathUtility.Zero()
	local mantissa = tonumber(normalized.mantissa) or 0
	local exponent = tonumber(normalized.exponent) or 0
	if mantissa <= 0 then
		return 0
	end

	local clampedExponent = math.min(308, math.max(0, exponent))
	local approx = mantissa * (10 ^ clampedExponent)
	if approx ~= approx or approx == math.huge or approx == -math.huge then
		return MAX_ATTRIBUTE_NUMBER
	end
	return math.max(0, approx)
end

local function getRebirthMultiplier(rebirths)
	rebirths = getSafeBigNumberAsNumber(rebirths)
	if rebirths <= 0 then
		return 1
	end

	local scale = tonumber(GameConfig.Rebirth.MultiplierScale) or 1
	local exponent = tonumber(GameConfig.Rebirth.MultiplierExponent) or (1 / 3)
	return math.max(1, scale * (rebirths ^ exponent))
end

local MAX_ATTRIBUTE_NUMBER = 1e308

local function getBigNumberState(value)
	local normalized = MathUtility.Normalize(value) or MathUtility.Zero()
	return normalized, MathUtility.FormatNumber(normalized), MathUtility.FormatScientific(normalized), tonumber(normalized.exponent) or 0
end

local function getAttributeSafeNumber(value)
	local asNumber = MathUtility.ToDisplayInteger(value)
	if asNumber ~= nil then
		return asNumber
	end

	local normalized = MathUtility.Normalize(value) or MathUtility.Zero()
	if (normalized.mantissa or 0) <= 0 then
		return 0
	end

	return MAX_ATTRIBUTE_NUMBER
end

local function setDefaultAttribute(instance, attributeName, value)
	if instance:GetAttribute(attributeName) == nil then
		instance:SetAttribute(attributeName, value)
	end
end

local function getTutorialTargetZone(profile)
	for _, area in ipairs(TrainingAreasConfig.List) do
		local sanitized = TableUtil.SanitizeKey(area.Name)
		if profile.Progression.Tutorial.Zones[sanitized] ~= true then
			return area.Name
		end
	end
	return ""
end

function PlayerService.new()
	return setmetatable({
		RateLimiter = RateLimiter.new(),
		Leaderstats = {},
	}, PlayerService)
end

function PlayerService:Init(registry)
	self.Registry = registry
	self.RemoteBinder = registry:Get("RemoteBinder")
	self.DataService = registry:Get("DataService")

	self.RemoteBinder:BindFunction("PlayerService", "GetProfileStats", function(player)
		return self:GetProfileStats(player)
	end)
	self.RemoteBinder:BindFunction("PlayerService", "RequestRebirth", function(player)
		return self:RequestRebirth(player)
	end)
	self.RemoteBinder:BindFunction("PlayerService", "GetTutorialData", function(player)
		return self:GetTutorialData(player)
	end)
end

function PlayerService:Start()
	self.DataService.ProfileLoaded.Event:Connect(function(player)
		self:_onProfileLoaded(player)
	end)
	self.DataService.ProfileReleased.Event:Connect(function(player)
		self:_destroyLeaderstats(player)
		self.RemoteBinder:FireClient("PlayerService", "ProfileReleased", player)
		self.RateLimiter:Forget(player)
	end)
	Players.PlayerRemoving:Connect(function(player)
		self:_destroyLeaderstats(player)
		self.RateLimiter:Forget(player)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		if self.DataService:GetProfile(player) then
			task.defer(function()
				self:_onProfileLoaded(player)
			end)
		end
	end

	task.spawn(function()
		while true do
			task.wait(GameConfig.TimePlayedStepSeconds)
			for _, player in ipairs(Players:GetPlayers()) do
				if self.DataService:GetProfile(player) then
					self.DataService:Mutate(player, function(data)
						data.Stats.TimePlayed += GameConfig.TimePlayedStepSeconds
					end)
					self:SyncReplicatedState(player)
				end
			end
		end
	end)
end

function PlayerService:_onProfileLoaded(player)
	self:SyncReplicatedState(player)
	self.RemoteBinder:FireClient("PlayerService", "ProfileLoaded", player, self:GetProfileStats(player))
end

function PlayerService:_getProfile(player)
	return self.DataService:GetProfile(player) or self.DataService:WaitForProfile(player, 10)
end

function PlayerService:GetCatchupMultiplier(_)
	return 1
end

function PlayerService:GetRebirthRequirement(_)
	return GameConfig.Rebirth.ChunkSize
end

function PlayerService:GetCurrentRankIndex(player)
	local profile = self:_getProfile(player)
	if not profile then
		return 1
	end
	return select(1, Ranked.GetRankByAura(profile.Stats.Aura or 0))
end

function PlayerService:GetPeakRankIndex(player)
	local profile = self:_getProfile(player)
	if not profile then
		return 1
	end
	return select(1, Ranked.GetRankByAura(profile.Stats.PeakAura or 0))
end

function PlayerService:CanAccessArea(player, areaName)
	local profile = self:_getProfile(player)
	local area = TrainingAreasConfig.ByName[areaName]
	if not profile or not area then
		return false
	end
	if (profile.Stats.Aura or 0) < area.Requirement then
		return false
	end
	if area.RequiresCursedZone then
		local cursedZoneService = self.Registry:Get("CursedZoneService")
		if not cursedZoneService:IsAreaAvailable(areaName) then
			return false
		end
	end
	return true
end

function PlayerService:GetTutorialData(player)
	local profile = self:_getProfile(player)
	if not profile then
		return TableUtil.DeepCopy({
			GotRebirth = false,
			ClaimedFirstChest = false,
			Zones = {},
		})
	end
	return TableUtil.DeepCopy(profile.Progression.Tutorial)
end

function PlayerService:_getDisplayTitleState(profile)
	local equippedPackTitle = profile.Inventory.EquippedPackTitle or ""
	if equippedPackTitle ~= "" then
		local pack = PacksConfig.GetPackByTitleId and PacksConfig.GetPackByTitleId(equippedPackTitle)
		if pack and pack.Title then
			local displayText = pack.Title.DisplayName or equippedPackTitle
			local templateName = pack.Title.RankTextTemplate or displayText
			return displayText, templateName
		end
		return equippedPackTitle, equippedPackTitle
	end

	local equippedRankIndex = tonumber(profile.Inventory.EquippedRankIndex) or 0
	if equippedRankIndex >= 1 then
		local rank = Ranked.GetRank(equippedRankIndex)
		local rankName = rank and rank.Name or "Noob"
		return rankName, rankName
	end

	local _, currentRank = Ranked.GetRankByAura(profile.Stats.Aura or 0)
	local currentRankName = currentRank and currentRank.Name or "Noob"
	return currentRankName, currentRankName
end

function PlayerService:GetProfileStats(player)
	local profile = self:_getProfile(player)
	if not profile then
		return nil
	end

	local currentRankIndex, currentRank = Ranked.GetRankByAura(profile.Stats.Aura or 0)
	local peakRankIndex, peakRank = Ranked.GetRankByAura(profile.Stats.PeakAura or 0)
	local passiveAuraService = self.Registry:Get("PassiveAuraService")
	local trainingAreasService = self.Registry:Get("TrainingAreasService")
	local passiveReward = passiveAuraService:GetRewardForPlayer(player)
	return {
		Rebirths = profile.Stats.Rebirths or 0,
		Aura = profile.Stats.Aura or 0,
		PeakAura = profile.Stats.PeakAura or 0,
		CurrentRankIndex = currentRankIndex,
		CurrentRankName = currentRank and currentRank.Name or "Noob",
		PeakRankIndex = peakRankIndex,
		PeakRankName = peakRank and peakRank.Name or "Noob",
		TimePlayed = profile.Stats.TimePlayed or 0,
		AuraBoost = profile.Monetization.AuraBoost or 1,
		PassiveAuraPerTick = passiveReward,
		CurrentArea = profile.Progression.CurrentArea or "",
		CurrentAreaBoost = trainingAreasService:GetCurrentAreaBoost(player),
		HugeBoostEndsAt = player:GetAttribute("HugeBoostEndsAt") or 0,
	}
end

function PlayerService:MarkTutorialZone(player, areaName)
	local sanitized = TableUtil.SanitizeKey(areaName)
	if sanitized == "" then
		return
	end
	local profile = self:_getProfile(player)
	if not profile or profile.Progression.Tutorial.Zones[sanitized] == true then
		return
	end
	self.DataService:Mutate(player, function(data)
		data.Progression.Tutorial.Zones[sanitized] = true
	end)
	self:SyncReplicatedState(player)
end

function PlayerService:MarkFirstChestClaimed(player)
	local profile = self:_getProfile(player)
	if not profile or profile.Progression.Tutorial.ClaimedFirstChest == true then
		return
	end
	self.DataService:Mutate(player, function(data)
		data.Progression.Tutorial.ClaimedFirstChest = true
	end)
	self:SyncReplicatedState(player)
end

function PlayerService:_ensureLeaderstats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
	end

	local auraValue = leaderstats:FindFirstChild(LEADERSTAT_AURA_NAME)
	if not auraValue then
		auraValue = Instance.new("StringValue")
		auraValue.Name = LEADERSTAT_AURA_NAME
		auraValue.Parent = leaderstats
	end

	local rebirthValue = leaderstats:FindFirstChild(LEADERSTAT_REBIRTHS_NAME)
	if not rebirthValue then
		rebirthValue = Instance.new("StringValue")
		rebirthValue.Name = LEADERSTAT_REBIRTHS_NAME
		rebirthValue.Parent = leaderstats
	end

	self.Leaderstats[player] = leaderstats
	return leaderstats, auraValue, rebirthValue
end

function PlayerService:_destroyLeaderstats(player)
	self.Leaderstats[player] = nil
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		leaderstats:Destroy()
	end
end

function PlayerService:_syncLeaderstats(player, profile)
	local _, auraValue, rebirthValue = self:_ensureLeaderstats(player)
	auraValue.Value = MathUtility.FormatNumber(profile.Stats.Aura or 0)
	rebirthValue.Value = MathUtility.FormatNumber(profile.Stats.Rebirths or 0)
end

function PlayerService:_getEquippedAuraKey(profile)
	local packTitleId = profile.Inventory.EquippedPackTitle or ""
	if packTitleId ~= "" and PacksConfig.GetPackByTitleId then
		local owningPack = PacksConfig.GetPackByTitleId(packTitleId)
		if owningPack and owningPack.Aura and type(owningPack.Aura.AuraKey) == "string" then
			return owningPack.Aura.AuraKey
		end
	end

	local rankIndex = tonumber(profile.Inventory.EquippedRankIndex) or 0
	if rankIndex <= 0 then
		rankIndex = select(1, Ranked.GetRankByAura(profile.Stats.Aura or 0))
	end

	local ok, auraKey = pcall(function()
		return RankAuraUtil.GetAuraKeyForRank(rankIndex, Ranked.GetCount())
	end)
	if ok and type(auraKey) == "string" then
		return auraKey
	end
	return ""
end

function PlayerService:AddAura(player, baseAmount, source, metadata)
	baseAmount = sanitizeWholeNumber(baseAmount)
	if baseAmount <= 0 then
		return 0
	end

	local profile = self:_getProfile(player)
	if not profile then
		return 0
	end

	local oldAura = sanitizeWholeNumber(profile.Stats.Aura)
	local oldRankIndex = select(1, Ranked.GetRankByAura(oldAura))
	local oldAura = sanitizeWholeNumber(profile.Stats.Aura)
	local oldRankIndex = select(1, Ranked.GetRankByAura(oldAura))
	local cursedZoneService = self.Registry:Get("CursedZoneService")
	local monetizationService = self.Registry:Get("MonetizationService")
	local trainingAreasService = self.Registry:Get("TrainingAreasService")
	local rebirthMultiplier = getRebirthMultiplier(profile.Stats.Rebirths or 0)
	local catchupMultiplier = self:GetCatchupMultiplier(player)
	local zoneMultiplier = cursedZoneService and cursedZoneService:GetAuraMultiplier(player) or 1
	local auraBoostMultiplier = monetizationService and monetizationService:GetAuraMultiplier(player) or 1
	local globalAuraEventMultiplier = 1
	local globalAuraEventEndsAtUnix = tonumber(player:GetAttribute("GlobalAuraEventEndsAtUnix")) or 0
	if globalAuraEventEndsAtUnix <= 0 or os.time() <= globalAuraEventEndsAtUnix then
		globalAuraEventMultiplier = math.max(1, tonumber(player:GetAttribute("GlobalAuraEventMultiplier")) or 1)
	end
	local kothMultiplier = 1
	if source == "Passive" or source == "HugeBoost" then
		kothMultiplier = trainingAreasService and trainingAreasService:GetKOTHMultiplier(player) or 1
	end
	local multiplier = math.max(1, rebirthMultiplier * catchupMultiplier * zoneMultiplier * auraBoostMultiplier * globalAuraEventMultiplier * kothMultiplier)
	local awarded = math.max(1, math.floor(baseAmount * multiplier))
	local newAura = oldAura + awarded

	self.DataService:Mutate(player, function(data)
		data.Stats.Aura = newAura
		data.Stats.TotalAuraEarned += awarded
		data.Stats.PeakAura = math.max(data.Stats.PeakAura or 0, newAura)
		if type(source) == "string" and source ~= "" and type(metadata) == "table" and type(metadata.AreaName) == "string" then
			data.Progression.CurrentArea = metadata.AreaName
		end
	end)

	self:SyncReplicatedState(player)

	local newRankIndex, newRank = Ranked.GetRankByAura(newAura)
	if newRankIndex ~= oldRankIndex then
		self.Registry:Get("RankTitleService"):PushRankTitleData(player)
		if newRankIndex > oldRankIndex then
			local legacyBridge = self.Registry:Get("LegacyBridgeService")
			legacyBridge:FireHighlightFX(player.UserId)
			legacyBridge:PushRankUpAnnouncement(player, newRank and newRank.Name or "Noob")
		end
	end

	return awarded
end

function PlayerService:RequestRebirth(player)
	local allowed = self.RateLimiter:Allow(player, "RequestRebirth", GameConfig.RateLimits.RequestRebirth)
	if not allowed then
		return false, {
			ok = false,
			reason = "RATE_LIMITED",
		}
	end

	local profile = self:_getProfile(player)
	if not profile then
		return false, {
			ok = false,
			reason = "PROFILE_NOT_READY",
		}
	end

	local requirement = math.max(1, sanitizeWholeNumber(self:GetRebirthRequirement(player)))
	local aura = sanitizeWholeNumber(profile.Stats.Aura)
	local gain = math.floor(aura / requirement)
	local maxChunks = sanitizeWholeNumber(GameConfig.Rebirth.MaxChunksPerRequest)
	if maxChunks > 0 then
		gain = math.min(gain, maxChunks)
	end
	if gain < 1 then
		return false, {
			ok = false,
			reason = "NOT_ENOUGH_AURA",
			requirement = requirement,
			currentAura = aura,
		}
	end

	local convertedAura = gain * requirement
	local remainingAura = sanitizeWholeNumber(aura - convertedAura)
	if remainingAura >= requirement then
		remainingAura = sanitizeWholeNumber(aura % requirement)
	end

	self.DataService:Mutate(player, function(data)
		data.Stats.Aura = remainingAura
		data.Stats.Rebirths = MathUtility.Add(data.Stats.Rebirths or 0, gain) or (data.Stats.Rebirths or 0)
		data.Progression.Tutorial.GotRebirth = true
		data.Progression.CurrentArea = ""
		data.Inventory.EquippedRankIndex = 0
	end)

	local hugeBoostEndsAt = self.Registry:Get("PassiveAuraService"):TriggerFastTickBoost(player, "Rebirth")
	self:SyncReplicatedState(player)
	self.Registry:Get("TrainingAreasService"):RefreshAllPlayers()
	self.Registry:Get("TrainingAreasService"):RefreshPlayerAreaData(player)
	self.Registry:Get("RankTitleService"):PushRankTitleData(player)

	local refreshedProfile = self:_getProfile(player)
	local payload = {
		Gain = gain,
		NewRebirths = refreshedProfile and refreshedProfile.Stats.Rebirths or (profile.Stats.Rebirths + gain),
		Requirement = requirement,
		RemainingAura = remainingAura,
		HugeBoostEndsAt = hugeBoostEndsAt,
	}
	self.RemoteBinder:FireClient("PlayerService", "RebirthPerformed", player, payload)
	return true, payload
end

function PlayerService:SyncReplicatedState(player)
	local profile = self:_getProfile(player)
	if not profile then
		return
	end

	local currentRankIndex, currentRank = Ranked.GetRankByAura(profile.Stats.Aura or 0)
	local displayRankText, displayRankTemplateName = self:_getDisplayTitleState(profile)
	local passiveAuraService = self.Registry:Get("PassiveAuraService")
	local trainingAreasService = self.Registry:Get("TrainingAreasService")
	local passiveAuraReward = passiveAuraService:GetRewardForPlayer(player)
	local currentAreaName = profile.Progression.CurrentArea or ""
	local currentAreaBoost = trainingAreasService:GetCurrentAreaBoost(player)
	local currentAreaConfig = TrainingAreasConfig.ByName[currentAreaName]
	local currentAreaRequirement = currentAreaConfig and (tonumber(currentAreaConfig.Requirement) or 0) or 0
	local _, auraDisplay, auraSci, auraExponent = getBigNumberState(profile.Stats.Aura or 0)
	local _, rebirthsDisplay, rebirthsSci, rebirthsExponent = getBigNumberState(profile.Stats.Rebirths or 0)
	local _, peakAuraDisplay, peakAuraSci, peakAuraExponent = getBigNumberState(profile.Stats.PeakAura or 0)
	local firstFreeRebirthPackReadyAtPlaytime = (function()
		local readyAt = tonumber(profile.Cooldowns.FirstFreeRebirthPackReadyAtPlaytime) or 0
		local firstPack = MonetizationConfig.Products.RebirthPacks and MonetizationConfig.Products.RebirthPacks[1]
		local buyKey = firstPack and tostring(firstPack.Id) or ""
		local claimedCount = firstPack and (profile.Monetization.RebirthPackBuys[buyKey] or profile.Monetization.RebirthPackBuys[firstPack.Id] or 0) or 0
		if tonumber(claimedCount) <= 0 and readyAt <= 0 then
			readyAt = tonumber(MonetizationConfig.FirstFreeRebirthPackCooldownSeconds) or (45 * 60)
		end
		return readyAt
	end)()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	local isDead = humanoid ~= nil and humanoid.Health <= 0

	player:SetAttribute("Aura", getAttributeSafeNumber(profile.Stats.Aura or 0))
	player:SetAttribute("Aura_Display", auraDisplay)
	player:SetAttribute("Aura_Sci", auraSci)
	player:SetAttribute("Aura_Exponent", auraExponent)
	player:SetAttribute("Rebirths", getAttributeSafeNumber(profile.Stats.Rebirths or 0))
	player:SetAttribute("Rebirths_Display", rebirthsDisplay)
	player:SetAttribute("Rebirths_Sci", rebirthsSci)
	player:SetAttribute("Rebirths_Exponent", rebirthsExponent)
	player:SetAttribute("PeakAura", getAttributeSafeNumber(profile.Stats.PeakAura or 0))
	player:SetAttribute("PeakAura_Display", peakAuraDisplay)
	player:SetAttribute("PeakAura_Sci", peakAuraSci)
	player:SetAttribute("PeakAura_Exponent", peakAuraExponent)
	player:SetAttribute("TimePlayed", profile.Stats.TimePlayed or 0)
	player:SetAttribute("CatchupMult", self:GetCatchupMultiplier(player))
	player:SetAttribute("EquippedPose", profile.Inventory.EquippedPose or "")
	player:SetAttribute("EquippedPackTitle", profile.Inventory.EquippedPackTitle or "")
	player:SetAttribute("EquippedRankIndex", profile.Inventory.EquippedRankIndex or 0)
	player:SetAttribute("EquippedAuraRankIndex", profile.Inventory.EquippedRankIndex or 0)
	player:SetAttribute("RebirthRequirement", self:GetRebirthRequirement(player))
	player:SetAttribute("UnlockedRankIndex", self:GetPeakRankIndex(player))
	player:SetAttribute("CurrentRankIndex", currentRankIndex)
	player:SetAttribute("CurrentRankNumber", currentRankIndex)
	player:SetAttribute("CurrentRankName", currentRank and currentRank.Name or "Noob")
	player:SetAttribute("DisplayRankText", displayRankText)
	player:SetAttribute("DisplayRankTemplateName", displayRankTemplateName)
	player:SetAttribute("PassiveAuraPerTick", passiveAuraReward)
	player:SetAttribute("CurrentArea", currentAreaName)
	player:SetAttribute("CurrentAreaBoost", currentAreaBoost)
	player:SetAttribute("AreaMultiplier", currentAreaBoost)
	player:SetAttribute("AreaRequirement", currentAreaRequirement)
	player:SetAttribute("AuraBoost", math.max(1, tonumber(profile.Monetization.AuraBoost) or 1))
	player:SetAttribute("Chest_FirstClaimReadyAt", profile.Cooldowns.ChestClaimAt or 0)
	player:SetAttribute("Chest_ClaimReadyAt", profile.Cooldowns.ChestClaimAt or 0)
	player:SetAttribute("FirstFreeRebirthPackReadyAtPlaytime", firstFreeRebirthPackReadyAtPlaytime)
	player:SetAttribute("HugeBoostEndsAt", player:GetAttribute("HugeBoostEndsAt") or 0)
	player:SetAttribute("KOTHTotalTime", sanitizeWholeNumber(profile.Stats.KOTHSeconds or 0))
	player:SetAttribute("Dead", isDead)
	player:SetAttribute("Tutorial_TargetZone", getTutorialTargetZone(profile))
	setDefaultAttribute(player, "GlobalAuraEventMultiplier", 20)
	setDefaultAttribute(player, "GlobalAuraEventEndsAtUnix", 1776535200)
	setDefaultAttribute(player, "MusicEnabled", true)
	setDefaultAttribute(player, "HideOtherVFXEnabled", false)
	setDefaultAttribute(player, "HidePopUpsEnabled", false)
	setDefaultAttribute(player, "IsDayEnabled", true)
	setDefaultAttribute(player, "DidInitialSpawn", true)
	setDefaultAttribute(player, "HasLoadedBefore", true)
	setDefaultAttribute(player, "IsAFK", false)
	setDefaultAttribute(player, "AFKSince", 0)

	for _, area in ipairs(TrainingAreasConfig.List) do
		local sanitized = TableUtil.SanitizeKey(area.Name)
		player:SetAttribute("Tutorial_EnteredZone_" .. sanitized, profile.Progression.Tutorial.Zones[sanitized] == true)
	end
	player:SetAttribute("Tutorial_GotRebirth", profile.Progression.Tutorial.GotRebirth == true)
	player:SetAttribute("Tutorial_ClaimedFirstChest", profile.Progression.Tutorial.ClaimedFirstChest == true)

	for _, packProduct in pairs(MonetizationConfig.Products.RebirthPacks or {}) do
		if type(packProduct) == "table" and type(packProduct.Id) == "number" then
			local buyCount = profile.Monetization.RebirthPackBuys[tostring(packProduct.Id)] or profile.Monetization.RebirthPackBuys[packProduct.Id] or 0
			player:SetAttribute("RebirthPackBuys_" .. packProduct.Id, tonumber(buyCount) or 0)
		end
	end

	self:_syncLeaderstats(player, profile)

	local auraKey = self:_getEquippedAuraKey(profile)
	CosmeticService.EnableAura(player, auraKey)
	self.Registry:Get("CharacterReplicaService"):SyncPlayer(player)
end

return PlayerService