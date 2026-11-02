-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Guards = require(ReplicatedStorage.Data.Guards)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Sakura = require(ReplicatedStorage.Shared.Types.Sakura)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
require(script.Parent.Types.Interface)
local v1 = {
    Money = 1000000000,
    SpeedPower = TreadmillUtil.DEFAULT_BASE_SPEED_POWER,
    Inventory = {},
    EquippedAssets = {},
    GuardTutorialProgress = { Completed = false },
    LastLogout = 0,
    PendingOfflineMoney = 0,
    PendingOfflineAnchorLogoutAt = 0,
    EarningsBoostExpiresAt = 0,
    Gamepasses = {},
    Products = {},
    ProductCredits = {},
    ClaimedCodes = {},
    ClaimedLikeMilestoneIds = {},
    StarterPackOfferExpires = 0,
    StarterPackOfferPending = false,
    StarterPackOfferFinished = false,
    Index = {},
    AutoSellRarities = {},
    Settings = {
        SFX = true,
        Music = true,
        AFK = false,
        HideOtherPets = false,
        HideSelfPets = false,
        DisableVideos = false
    },
    LuckyBlockInventory = {},
    LatestTreadmillMediaIndex = 0,
    ClaimedGroupReward = false,
    DismissedGroupRewardPrompt = false,
    FreeGiftsStartedAt = 0,
    FreeGiftsTime = 0,
    FreeGiftsActiveStartedAt = 0,
    FreeGiftsClaimed = {},
    FusionSlots = {},
    FusionLocked = false,
    FusionEndsAt = nil,
    FusionDuration = 0,
    FusionReward = nil,
    VIPFusionSlots = {},
    VIPFusionLocked = false,
    VIPFusionEndsAt = nil,
    VIPFusionDuration = 0,
    VIPFusionReward = nil,
    PrivateFusionSlots = {},
    PrivateFusionLocked = false,
    PrivateFusionEndsAt = nil,
    PrivateFusionDuration = 0,
    PrivateFusionReward = nil,
    VIPOfferExpires = 0,
    VIPOfferStarted = false,
    MonetizationRobuxSpentTotal = 0,
    BaseUpgradeLevel = 0,
    TrailInventory = {},
    EquippedTrail = nil
}
local v2 = {}

v2[Guards.Directory.Forest._id] = true
v1.VisitedGuardAreas = v2
v1.StarterPackOfferPausedSeconds = 0
v1.StarterPackOfferPlaytimeSeconds = 0
v1.TreadmillMediaFeedState = {
    Seed = 0,
    CurrentIndex = 0,
    AlgorithmVersion = 3,
    ReleaseTrackingInitialized = false,
    FullFeedReleaseVersion = 0,
    CompletedReleaseVersion = 0,
    PendingReleaseVersion = 0,
    SeenPendingMediaKeys = {}
}
v1.FreeGiftsLastResetDay = 0
v1.SpeedBoostTierIndex = 0
v1.BestRollDenominator = 0
v1.IndexClaimedCategories = {}
v1.LikedTreadmillMedia = {}
v1.LikedCommentIds = {}
v1.CommentedTreadmillMedia = {}
v1.BestGuardRunDistance = 0
v1.EggInventory = {}
v1.VisitedGears = {}
v1.GearInventory = {}
v1.GearAutoBuys = {}
v1.CurrentAreaEggClaims = {
    PeriodIndex = 0,
    Slots = {}
}
v1.TemporarySpeedBoostRemainingSeconds = 0
v1.TemporarySpeedBoostActiveStartedAt = 0
v1.TreadmillUpgradeLevel = 1
v1.HasRiddenTreadmill = false
v1.HasEquippedPhone = false
v1.HasPlacedFirstEgg = false
v1.GuardSpeedWarningsSeen = {}
v1.PetPenCapacityGuidance = {
    Triggered = false,
    PetsTabAcknowledged = false,
    EquipBestAcknowledged = false
}
v1.FusionEggReward = false
v1.FusionInfoAcknowledged = false
v1.VisitedEvents = {}
v1.MonsterParasite = MonsterParasite.DefaultState()
v1.SakuraCrystals = 0
v1.Sakura = Sakura.Blank()
v1.RollbackRewards = {}
return v1
