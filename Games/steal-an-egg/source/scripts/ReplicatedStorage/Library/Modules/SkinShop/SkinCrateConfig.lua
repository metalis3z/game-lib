-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SkinShopOptions = require(ReplicatedStorage.Directory.SkinShopOptions)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local IS_STUDIO = Constants.IS_STUDIO
local isTEST_PLACE_ID = game.PlaceId == Constants.TEST_PLACE_ID
local v1 = if isTEST_PLACE_ID then 45 else 300
local v9 = if IS_STUDIO then 10 else 165
local t = { SkinShopOptions.Directory["Basic Crate"]._id }
local tbl = {}
local t2 = {
	MinStock = 1,
	TargetFill = 0.75,
	TargetSelloutTime = 300,
	MinCycleMultiplier = 0.85,
	MaxCycleMultiplier = 1.1,
	BetaTopRichestPercent = 0.75,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Uncommon Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Uncommon Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Uncommon Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Uncommon Crate"].Cost
}
local IS_STUDIO2 = Constants.IS_STUDIO

t2.SpawnChance = 1
t2.ScarcityRatio = if Constants.IS_STUDIO then 1 else 0.75
t2.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Uncommon Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Uncommon Crate"]._id] = t2

local t3 = {
	MinStock = 1,
	TargetFill = 0.8,
	TargetSelloutTime = 270,
	MinCycleMultiplier = 0.88,
	MaxCycleMultiplier = 1.1,
	BetaTopRichestPercent = 0.6,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Rare Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Rare Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Rare Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Rare Crate"].Cost
}
local IS_STUDIO3 = Constants.IS_STUDIO

t3.SpawnChance = 1
t3.ScarcityRatio = if Constants.IS_STUDIO then 1 else 0.6
t3.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Rare Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Rare Crate"]._id] = t3

local t4 = {
	MinStock = 1,
	TargetFill = 0.85,
	TargetSelloutTime = 240,
	MinCycleMultiplier = 0.9,
	MaxCycleMultiplier = 1.12,
	BetaTopRichestPercent = 0.4,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Epic Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Epic Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Epic Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Epic Crate"].Cost
}
local IS_STUDIO4 = Constants.IS_STUDIO

t4.SpawnChance = 1
t4.ScarcityRatio = if Constants.IS_STUDIO then 1 else 0.2
t4.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Epic Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Epic Crate"]._id] = t4

local t5 = {
	ScarcityRatio = 0.12,
	MinStock = 1,
	TargetFill = 0.9,
	TargetSelloutTime = 180,
	MinCycleMultiplier = 0.9,
	MaxCycleMultiplier = 1.12,
	BetaTopRichestPercent = 0.25,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Legendary Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Legendary Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Legendary Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Legendary Crate"].Cost
}
local IS_STUDIO5 = Constants.IS_STUDIO

t5.SpawnChance = 1
t5.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Legendary Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Legendary Crate"]._id] = t5

local t6 = {
	ScarcityRatio = 0.07,
	MinStock = 1,
	TargetFill = 0.92,
	TargetSelloutTime = 150,
	MinCycleMultiplier = 0.9,
	MaxCycleMultiplier = 1.12,
	BetaTopRichestPercent = 0.1,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Mythic Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Mythic Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Mythic Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Mythic Crate"].Cost
}
local IS_STUDIO6 = Constants.IS_STUDIO

t6.SpawnChance = 1
t6.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Mythic Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Mythic Crate"]._id] = t6

local t7 = {
	ScarcityRatio = 0.04,
	MinStock = 1,
	TargetFill = 0.95,
	TargetSelloutTime = 120,
	MinCycleMultiplier = 0.92,
	MaxCycleMultiplier = 1.12,
	BetaTopRichestPercent = 0.05,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Cosmic Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Cosmic Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Cosmic Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Cosmic Crate"].Cost
}

t7.SpawnChance = if Constants.IS_STUDIO then 1 else 0.6000000000000001
t7.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Cosmic Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Cosmic Crate"]._id] = t7

local t8 = {
	ScarcityRatio = 0.02,
	MinStock = 1,
	TargetFill = 0.98,
	TargetSelloutTime = 90,
	MinCycleMultiplier = 0.95,
	MaxCycleMultiplier = 1.12,
	BetaTopRichestPercent = 0.02,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Secret Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Secret Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Secret Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Secret Crate"].Cost
}

t8.SpawnChance = if Constants.IS_STUDIO then 1 else 0.30000000000000004
t8.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Secret Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Secret Crate"]._id] = t8

local t9 = {
	ScarcityRatio = 0.01,
	MinStock = 1,
	TargetFill = 1,
	TargetSelloutTime = 60,
	MinCycleMultiplier = 0.97,
	MaxCycleMultiplier = 1.1,
	BetaTopRichestPercent = 0.01,
	BetaPriceMultiplier = 1,
	BetaMaxPrice = (1 / 0),
	OptionName = SkinShopOptions.Directory["Eternal Crate"].DisplayName,
	Rarity = SkinShopOptions.Directory["Eternal Crate"].Rarity._id,
	PackKey = SkinShopOptions.Directory["Eternal Crate"].PackKey,
	SeedBasePrice = SkinShopOptions.Directory["Eternal Crate"].Cost
}

t9.SpawnChance = if Constants.IS_STUDIO then 1 else 0.09
t9.BetaMinPrice = math.max(1, (math.floor(SkinShopOptions.Directory["Eternal Crate"].Cost * 0.75)))
tbl[SkinShopOptions.Directory["Eternal Crate"]._id] = t9

local t10 = {}

for k, v in pairs(tbl) do
	t10[v.Rarity] = k
	assert(SkinShopOptions.Directory[k] ~= nil, (("Missing skin shop option %*"):format(k)))
end

return {
	BackendModeAttribute = "SkinCrateMarketMode",
	StudioFastTesting = IS_STUDIO,
	CompetitiveMarketMode = "PriceOnlyBeta",
	RefreshTime = v1,
	EligibilityRatio = 0.7,
	ReservationTTL = 8,
	ReservationRecordTTL = v1 + 120,
	PurchaseGuardTTL = v1 + 120,
	CompletionRecordTTL = v1 + 120,
	SummaryTTL = if IS_STUDIO then 30 else 90,
	SummaryFreshness = if IS_STUDIO then 10 else 60,
	SummaryHeartbeatMin = if IS_STUDIO then 1 else 20,
	SummaryHeartbeatMax = if IS_STUDIO then 2 else 30,
	BetaSummaryTTL = if IS_STUDIO then 30 else v9 + 60,
	BetaSummaryFreshness = v9,
	BetaSummaryHeartbeatMin = 90,
	BetaSummaryHeartbeatMax = 120,
	BetaPriceRefreshMin = 120,
	BetaPriceRefreshMax = 180,
	BetaPriceStateTTL = 480,
	BetaStartupFallbackWindow = 60,
	BetaMinPlayersForComputedPrice = if isTEST_PLACE_ID then 3 else 2000,
	BindToCloseSummaryTTL = 5,
	CacheRefreshMin = if IS_STUDIO then 1 else 10,
	CacheRefreshMax = if IS_STUDIO then 2 else 20,
	CoordinatorLease = if IS_STUDIO then 5 else 15,
	BetaPriceCoordinatorLease = 210,
	PlanningWaitSeconds = if IS_STUDIO then 1 else 6,
	MinCoverageRatio = if IS_STUDIO then 0 else 0.8,
	EmergencyCoverageRatio = if IS_STUDIO then 0 else 0.2,
	StockPublishWindow = 0.35,
	RecoveryQueueInvisibility = 5,
	RecoveryQueueWaitTimeout = 0,
	RecoveryBatchSize = 10,
	RecoveryJobTTL = v1 + 120,
	GrantRepairGrace = 20,
	ReadOnlyFailureWindow = 10,
	ReadOnlyReasonThreshold = 3,
	ReadOnlyGlobalThreshold = 5,
	ReadOnlyCooldown = 8,
	RecoveryCleanPassesRequired = 2,
	LegacyOptions = t,
	CompetitiveOptions = tbl,
	CompetitiveRarities = { "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Cosmic", "Secret", "Eternal" },
	GetCompetitiveMarketMode = function() --[[ GetCompetitiveMarketMode | Line: 283 ]]
		return "PriceOnlyBeta"
	end,
	IsFullMarket = function() --[[ IsFullMarket | Line: 287 ]]
		return false
	end,
	IsPriceOnlyBeta = function() --[[ IsPriceOnlyBeta | Line: 291 ]]
		return true
	end,
	IsCompetitiveDisabled = function() --[[ IsCompetitiveDisabled | Line: 295 ]]
		return false
	end,
	IsCompetitiveOption = function(p1) --[[ IsCompetitiveOption | Line: 299 | Upvalues: tbl (copy) ]]
		return tbl[p1] ~= nil
	end,
	IsLegacyOption = function(p1) --[[ IsLegacyOption | Line: 303 | Upvalues: t (copy) ]]
		return table.find(t, p1) ~= nil
	end,
	GetCompetitiveConfig = function(p1) --[[ GetCompetitiveConfig | Line: 307 | Upvalues: tbl (copy) ]]
		return tbl[p1]
	end,
	GetCompetitiveConfigByRarity = function(p1) --[[ GetCompetitiveConfigByRarity | Line: 311 | Upvalues: t10 (copy), tbl (copy) ]]
		local v1 = t10[p1]

		if v1 == nil then
			return nil
		end

		return tbl[v1]
	end,
	GetOptionNameFromRarity = function(p1) --[[ GetOptionNameFromRarity | Line: 320 | Upvalues: t10 (copy) ]]
		return t10[p1]
	end,
	GetDefaultPrice = function(p1) --[[ GetDefaultPrice | Line: 324 | Upvalues: tbl (copy), SkinShopOptions (copy) ]]
		local v1 = tbl[p1]

		if v1 ~= nil then
			return v1.SeedBasePrice
		end

		local v2 = SkinShopOptions.Directory[p1]

		assert(v2 ~= nil, (("Unknown skin shop option %*"):format(p1)))

		return v2.Cost
	end
}