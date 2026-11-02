-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.Packages.Networking)

local function scope(v1, v3) -- line 4 | captures: Networking
    Networking.namespace({
        env = "all",
        name = v1
    })
    return v3()
end

local v4 = {}
Networking.namespace({
    name = "PenRoster",
    env = "all"
})
v4.PenRoster = {
    AskDoff = Networking.remoteFunction("AskDoff"),
    AskLiveSnapshot = Networking.remoteFunction("AskLiveSnapshot"),
    AskSale = Networking.remoteFunction("AskSale"),
    AskWear = Networking.remoteFunction("AskWear"),
    AskWearLimit = Networking.remoteFunction("AskWearLimit"),
    CoinsGathered = Networking.remoteEvent("CoinsGathered"),
    ConfirmEquipBestBadge = Networking.remoteFunction("ConfirmEquipBestBadge"),
    ConfirmPetsBadge = Networking.remoteFunction("ConfirmPetsBadge"),
    OwnerDropped = Networking.remoteEvent("OwnerDropped"),
    OwnerShifted = Networking.remoteEvent("OwnerShifted")
}
Networking.namespace({
    name = "LiveEvents",
    env = "all"
})
v4.LiveEvents = {
    Began = Networking.remoteEvent("Began"),
    Ended = Networking.remoteEvent("Ended"),
    FetchCatalogue = Networking.remoteFunction("FetchCatalogue"),
    FetchRecurringEta = Networking.remoteFunction("FetchRecurringEta"),
    FetchRunning = Networking.remoteFunction("FetchRunning"),
    FetchScheduled = Networking.remoteFunction("FetchScheduled")
}

local function v2() -- line 35 | captures: Networking
    return { RaiseNotice = Networking.remoteEvent("RaiseNotice") }
end

Networking.namespace({
    name = "Broadcasts",
    env = "all"
})
v4.Broadcasts = { RaiseNotice = Networking.remoteEvent("RaiseNotice") }
Networking.namespace({
    name = "StaffConsole",
    env = "all"
})
v4.StaffConsole = {
    GrantSelfEgg = Networking.remoteEvent("GrantSelfEgg"),
    GrantSelfPet = Networking.remoteEvent("GrantSelfPet"),
    GrantVerdict = Networking.remoteEvent("GrantVerdict"),
    ProbeStaffStatus = Networking.remoteEvent("ProbeStaffStatus"),
    SpeedPowerVerdict = Networking.remoteEvent("SpeedPowerVerdict"),
    StaffVerdict = Networking.remoteEvent("StaffVerdict"),
    WipeSelfProfile = Networking.remoteEvent("WipeSelfProfile"),
    WipeVerdict = Networking.remoteEvent("WipeVerdict"),
    WriteSpeedPower = Networking.remoteEvent("WriteSpeedPower"),
    WriteWalkSpeed = Networking.remoteEvent("WriteWalkSpeed")
}
Networking.namespace({
    name = "Telemetry",
    env = "all"
})
v4.Telemetry = {
    AskIdleHopFlush = Networking.remoteFunction("AskIdleHopFlush"),
    SubmitIdleHop = Networking.remoteFunction("SubmitIdleHop"),
    SubmitIdleState = Networking.remoteEvent("SubmitIdleState")
}
Networking.namespace({
    name = "PetSatchel",
    env = "all"
})
v4.PetSatchel = {
    SaleResult = Networking.remoteEvent("SaleResult"),
    SellEveryPet = Networking.remoteEvent("SellEveryPet"),
    SellPet = Networking.remoteEvent("SellPet"),
    WriteFavourite = Networking.remoteEvent("WriteFavourite")
}

local function v2_2() -- line 63 | captures: Networking
    return { EmitSound = Networking.remoteEvent("EmitSound") }
end

Networking.namespace({
    name = "SoundBus",
    env = "all"
})
v4.SoundBus = { EmitSound = Networking.remoteEvent("EmitSound") }
Networking.namespace({
    name = "Haul",
    env = "all"
})
v4.Haul = {
    FetchAutoSell = Networking.remoteFunction("FetchAutoSell"),
    FetchWearBestStatus = Networking.remoteFunction("FetchWearBestStatus"),
    OfferFullSatchelSale = Networking.remoteFunction("OfferFullSatchelSale"),
    WearBest = Networking.remoteFunction("WearBest"),
    WriteAutoSell = Networking.remoteFunction("WriteAutoSell")
}

local function v2_3() -- line 78 | captures: Networking
    return { Trigger = Networking.remoteEvent("Trigger") }
end

Networking.namespace({
    name = "BatSwing",
    env = "all"
})
v4.BatSwing = { Trigger = Networking.remoteEvent("Trigger") }
Networking.namespace({
    name = "SwapGadget",
    env = "all"
})
v4.SwapGadget = {
    AskSwap = Networking.remoteEvent("AskSwap"),
    EmitFx = Networking.remoteEvent("EmitFx"),
    EmitSfx = Networking.remoteEvent("EmitSfx")
}
Networking.namespace({
    name = "DanceGadget",
    env = "all"
})
v4.DanceGadget = {
    AskDance = Networking.remoteEvent("AskDance"),
    AttachEffect = Networking.remoteEvent("AttachEffect"),
    DetachEffect = Networking.remoteEvent("DetachEffect"),
    EmitSfx = Networking.remoteEvent("EmitSfx")
}
Networking.namespace({
    name = "ChatFeed",
    env = "all"
})
v4.ChatFeed = {
    ShowFromArgs = Networking.remoteEvent("ShowFromArgs"),
    ShowFromRecord = Networking.remoteEvent("ShowFromRecord"),
    ShowPlain = Networking.remoteEvent("ShowPlain")
}
Networking.namespace({
    name = "RigSync",
    env = "all"
})
v4.RigSync = {
    AskRigWipe = Networking.remoteEvent("AskRigWipe"),
    CorrectionBegan = Networking.remoteEvent("CorrectionBegan"),
    Primed = Networking.remoteEvent("Primed"),
    ProbeSatchel = Networking.remoteEvent("ProbeSatchel"),
    Reconcile = Networking.remoteFunction("Reconcile"),
    Refresh = Networking.remoteEvent("Refresh"),
    SeedSatchel = Networking.remoteEvent("SeedSatchel")
}

local function v2_4() -- line 107 | captures: Networking
    return { Line = Networking.remoteEvent("Line") }
end

Networking.namespace({
    name = "Toasts",
    env = "all"
})
v4.Toasts = { Line = Networking.remoteEvent("Line") }

local function v2_5() -- line 112 | captures: Networking
    return { Shower = Networking.remoteEvent("Shower") }
end

Networking.namespace({
    name = "Payouts",
    env = "all"
})
v4.Payouts = { Shower = Networking.remoteEvent("Shower") }
Networking.namespace({
    name = "EggWorld",
    env = "all"
})
v4.EggWorld = {
    AskDoffTool = Networking.remoteFunction("AskDoffTool"),
    AskEggRecord = Networking.remoteFunction("AskEggRecord"),
    AskFieldEggCarry = Networking.remoteFunction("AskFieldEggCarry"),
    AskFieldEggDrop = Networking.remoteFunction("AskFieldEggDrop"),
    AskFieldEggRarityShows = Networking.remoteFunction("AskFieldEggRarityShows"),
    AskFieldEggSnapshot = Networking.remoteFunction("AskFieldEggSnapshot"),
    AskFinishHatch = Networking.remoteFunction("AskFinishHatch"),
    AskHatch = Networking.remoteFunction("AskHatch"),
    AskLiveSnapshot = Networking.remoteFunction("AskLiveSnapshot"),
    AskPlaceEgg = Networking.remoteFunction("AskPlaceEgg"),
    AskSkipGrowth = Networking.remoteFunction("AskSkipGrowth"),
    AskWearTool = Networking.remoteFunction("AskWearTool"),
    FieldEggBatchShifted = Networking.remoteEvent("FieldEggBatchShifted"),
    FieldEggCarry = Networking.remoteEvent("FieldEggCarry"),
    FieldEggCycleCountdown = Networking.remoteEvent("FieldEggCycleCountdown"),
    FieldEggGone = Networking.remoteEvent("FieldEggGone"),
    FieldEggRaritiesShown = Networking.remoteEvent("FieldEggRaritiesShown"),
    FieldEggRedeemVerdict = Networking.remoteEvent("FieldEggRedeemVerdict"),
    FieldEggShifted = Networking.remoteEvent("FieldEggShifted"),
    OwnerDropped = Networking.remoteEvent("OwnerDropped"),
    OwnerShifted = Networking.remoteEvent("OwnerShifted")
}

local function v2_6() -- line 143 | captures: Networking
    return {
        CutsceneBegan = Networking.remoteEvent("CutsceneBegan"),
        StandingsRefreshed = Networking.remoteEvent("StandingsRefreshed")
    }
end

Networking.namespace({
    name = "EggCapture",
    env = "all"
})
v4.EggCapture = {
    CutsceneBegan = Networking.remoteEvent("CutsceneBegan"),
    StandingsRefreshed = Networking.remoteEvent("StandingsRefreshed")
}

local function v2_7() -- line 148 | captures: Networking
    return {
        AskRescueHop = Networking.remoteEvent("AskRescueHop"),
        SubmitIdleFlag = Networking.remoteEvent("SubmitIdleFlag")
    }
end

Networking.namespace({
    name = "IdleRescue",
    env = "all"
})
v4.IdleRescue = {
    AskRescueHop = Networking.remoteEvent("AskRescueHop"),
    SubmitIdleFlag = Networking.remoteEvent("SubmitIdleFlag")
}
Networking.namespace({
    name = "MonsterParasite",
    env = "all"
})
v4.MonsterParasite = {
    AskChestClaim = Networking.remoteFunction("AskChestClaim"),
    AskChestRevealComplete = Networking.remoteFunction("AskChestRevealComplete"),
    AskChestTake = Networking.remoteFunction("AskChestTake"),
    AskFeed = Networking.remoteFunction("AskFeed"),
    AskFullChargeReset = Networking.remoteEvent("AskFullChargeReset"),
    AskGrowthSwap = Networking.remoteEvent("AskGrowthSwap"),
    AskSnapshot = Networking.remoteFunction("AskSnapshot"),
    ChestOpened = Networking.remoteEvent("ChestOpened"),
    EventStateShifted = Networking.remoteEvent("EventStateShifted"),
    FeedSettled = Networking.remoteEvent("FeedSettled"),
    StateShifted = Networking.remoteEvent("StateShifted")
}

local function v2_8() -- line 169 | captures: Networking
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        FlagSeen = Networking.remoteFunction("FlagSeen")
    }
end

Networking.namespace({
    name = "SeasonBanner",
    env = "all"
})
v4.SeasonBanner = {
    FetchState = Networking.remoteFunction("FetchState"),
    FlagSeen = Networking.remoteFunction("FlagSeen")
}

local function v2_9() -- line 174 | captures: Networking
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        FlagSeen = Networking.remoteFunction("FlagSeen")
    }
end

Networking.namespace({
    name = "ShopCta",
    env = "all"
})
v4.ShopCta = {
    FetchState = Networking.remoteFunction("FetchState"),
    FlagSeen = Networking.remoteFunction("FlagSeen")
}

local function v2_10() -- line 179 | captures: Networking
    return {
        Fetch = Networking.remoteFunction("Fetch"),
        Refresh = Networking.remoteEvent("Refresh")
    }
end

Networking.namespace({
    name = "Trials",
    env = "all"
})
v4.Trials = {
    Fetch = Networking.remoteFunction("Fetch"),
    Refresh = Networking.remoteEvent("Refresh")
}
Networking.namespace({
    name = "Fusery",
    env = "all"
})
v4.Fusery = {
    BeginFuse = Networking.remoteFunction("BeginFuse"),
    ConfirmBriefing = Networking.remoteFunction("ConfirmBriefing"),
    EjectPet = Networking.remoteFunction("EjectPet"),
    FinishReveal = Networking.remoteFunction("FinishReveal"),
    LoadPet = Networking.remoteFunction("LoadPet")
}

local function v2_11() -- line 194 | captures: Networking
    return { Awarded = Networking.remoteEvent("Awarded") }
end

Networking.namespace({
    name = "PassGrants",
    env = "all"
})
v4.PassGrants = { Awarded = Networking.remoteEvent("Awarded") }

local function v2_12() -- line 199 | captures: Networking
    return {
        Gained = Networking.remoteEvent("Gained"),
        Lost = Networking.remoteEvent("Lost")
    }
end

Networking.namespace({
    name = "GearSatchel",
    env = "all"
})
v4.GearSatchel = {
    Gained = Networking.remoteEvent("Gained"),
    Lost = Networking.remoteEvent("Lost")
}

local function v2_13() -- line 204 | captures: Networking
    return { RedeemPerk = Networking.remoteFunction("RedeemPerk") }
end

Networking.namespace({
    name = "GroupPerk",
    env = "all"
})
v4.GroupPerk = { RedeemPerk = Networking.remoteFunction("RedeemPerk") }
Networking.namespace({
    name = "GuardOnboarding",
    env = "all"
})
v4.GuardOnboarding = {
    AskLiveState = Networking.remoteFunction("AskLiveState"),
    AskProgressSync = Networking.remoteFunction("AskProgressSync"),
    LiveStateShifted = Networking.remoteEvent("LiveStateShifted")
}
Networking.namespace({
    name = "GuardPatrol",
    env = "all"
})
v4.GuardPatrol = {
    AskEnabled = Networking.remoteFunction("AskEnabled"),
    EnabledShifted = Networking.remoteEvent("EnabledShifted"),
    ForestHandoff = Networking.remoteEvent("ForestHandoff"),
    ForestStrike = Networking.remoteEvent("ForestStrike"),
    HitKnockback = Networking.remoteEvent("HitKnockback"),
    Rouse = Networking.remoteEvent("Rouse"),
    SpeedTollOffer = Networking.remoteEvent("SpeedTollOffer"),
    SpeedTollWarning = Networking.remoteEvent("SpeedTollWarning")
}

local function v2_14() -- line 226 | captures: Networking
    return {
        AskDischarge = Networking.remoteEvent("AskDischarge"),
        DropCaster = Networking.remoteEvent("DropCaster")
    }
end

Networking.namespace({
    name = "GunGadget",
    env = "all"
})
v4.GunGadget = {
    AskDischarge = Networking.remoteEvent("AskDischarge"),
    DropCaster = Networking.remoteEvent("DropCaster")
}
Networking.namespace({
    name = "Codex",
    env = "all"
})
v4.Codex = {
    AskRedeem = Networking.remoteFunction("AskRedeem"),
    AskRedeemAll = Networking.remoteFunction("AskRedeemAll"),
    AskRedeemLimitedEgg = Networking.remoteFunction("AskRedeemLimitedEgg"),
    AskWearFieldBat = Networking.remoteFunction("AskWearFieldBat")
}

local function v2_15() -- line 235 | captures: Networking
    return { InviteLanded = Networking.remoteEvent("InviteLanded") }
end

Networking.namespace({
    name = "Referrals",
    env = "all"
})
v4.Referrals = { InviteLanded = Networking.remoteEvent("InviteLanded") }
Networking.namespace({
    name = "LaserGadget",
    env = "all"
})
v4.LaserGadget = {
    AskDischarge = Networking.remoteEvent("AskDischarge"),
    EmitBeam = Networking.remoteEvent("EmitBeam"),
    EmitSfx = Networking.remoteEvent("EmitSfx")
}
Networking.namespace({
    name = "MagnetGadget",
    env = "all"
})
v4.MagnetGadget = {
    AskTug = Networking.remoteEvent("AskTug"),
    EmitBeam = Networking.remoteEvent("EmitBeam"),
    EmitTargetFx = Networking.remoteEvent("EmitTargetFx"),
    HaltBeam = Networking.remoteEvent("HaltBeam"),
    HaltTargetFx = Networking.remoteEvent("HaltTargetFx")
}
Networking.namespace({
    name = "MegaphoneGadget",
    env = "all"
})
v4.MegaphoneGadget = {
    CloseEffectWindow = Networking.remoteEvent("CloseEffectWindow"),
    EmitFx = Networking.remoteEvent("EmitFx"),
    EmitSfx = Networking.remoteEvent("EmitSfx"),
    OpenEffectWindow = Networking.remoteEvent("OpenEffectWindow"),
    Rouse = Networking.remoteEvent("Rouse")
}

local function v2_16() -- line 264 | captures: Networking
    return { RoundShifted = Networking.remoteEvent("RoundShifted") }
end

Networking.namespace({
    name = "Whodunnit",
    env = "all"
})
v4.Whodunnit = { RoundShifted = Networking.remoteEvent("RoundShifted") }

local function v2_17() -- line 269 | captures: Networking
    return { Raise = Networking.remoteEvent("Raise") }
end

Networking.namespace({
    name = "Alerts",
    env = "all"
})
v4.Alerts = { Raise = Networking.remoteEvent("Raise") }

local function v2_18() -- line 274 | captures: Networking
    return { ShowNotice = Networking.remoteEvent("ShowNotice") }
end

Networking.namespace({
    name = "RollbackRewards",
    env = "all"
})
v4.RollbackRewards = { ShowNotice = Networking.remoteEvent("ShowNotice") }
Networking.namespace({
    name = "AwayEarnings",
    env = "all"
})
v4.AwayEarnings = {
    AskCollect = Networking.remoteFunction("AskCollect"),
    FetchSummary = Networking.remoteFunction("FetchSummary"),
    PendingCheck = Networking.remoteFunction("PendingCheck"),
    Redeemed = Networking.remoteEvent("Redeemed"),
    SummaryRefreshed = Networking.remoteEvent("SummaryRefreshed")
}
Networking.namespace({
    name = "Homestead",
    env = "all"
})
v4.Homestead = {
    AskBaseTierRaise = Networking.remoteEvent("AskBaseTierRaise"),
    AskLobbyHop = Networking.remoteEvent("AskLobbyHop"),
    AskNearbyPurchase = Networking.remoteEvent("AskNearbyPurchase"),
    AskState = Networking.remoteFunction("AskState"),
    BaseTierRaised = Networking.remoteEvent("BaseTierRaised"),
    DimBaseOutline = Networking.remoteEvent("DimBaseOutline"),
    LitBaseOutline = Networking.remoteEvent("LitBaseOutline"),
    StateShifted = Networking.remoteEvent("StateShifted")
}
Networking.namespace({
    name = "Storefront",
    env = "all"
})
v4.Storefront = {
    AllowPurchase = Networking.remoteFunction("AllowPurchase"),
    AskFreeGamepass = Networking.remoteFunction("AskFreeGamepass"),
    AskPurchaseOffer = Networking.remoteFunction("AskPurchaseOffer"),
    AskServerProbe = Networking.remoteFunction("AskServerProbe"),
    Awarded = Networking.remoteEvent("Awarded"),
    PurchaseRejected = Networking.remoteEvent("PurchaseRejected"),
    PurchaseSettled = Networking.remoteEvent("PurchaseSettled"),
    ReceiptCleared = Networking.remoteEvent("ReceiptCleared")
}

local function v2_19() -- line 315 | captures: Networking
    return { WriteLimpness = Networking.remoteEvent("WriteLimpness") }
end

Networking.namespace({
    name = "Limpness",
    env = "all"
})
v4.Limpness = { WriteLimpness = Networking.remoteEvent("WriteLimpness") }

local function v2_20() -- line 320 | captures: Networking
    return {
        FetchProfile = Networking.remoteFunction("FetchProfile"),
        ProfileDelta = Networking.remoteEvent("ProfileDelta")
    }
end

Networking.namespace({
    name = "ProfileMirror",
    env = "all"
})
v4.ProfileMirror = {
    FetchProfile = Networking.remoteFunction("FetchProfile"),
    ProfileDelta = Networking.remoteEvent("ProfileDelta")
}

local function v2_21() -- line 325 | captures: Networking
    return { JoltOnce = Networking.remoteEvent("JoltOnce") }
end

Networking.namespace({
    name = "SharedFx",
    env = "all"
})
v4.SharedFx = { JoltOnce = Networking.remoteEvent("JoltOnce") }
Networking.namespace({
    name = "Bloomery",
    env = "all"
})
v4.Bloomery = {
    AskBriefingConfirm = Networking.remoteFunction("AskBriefingConfirm"),
    AskCraneReturn = Networking.remoteFunction("AskCraneReturn"),
    AskEjectEgg = Networking.remoteFunction("AskEjectEgg"),
    AskGatherPetal = Networking.remoteFunction("AskGatherPetal"),
    AskHandoff = Networking.remoteFunction("AskHandoff"),
    AskLoadEgg = Networking.remoteFunction("AskLoadEgg"),
    AskMutate = Networking.remoteFunction("AskMutate"),
    AskStrikeTree = Networking.remoteEvent("AskStrikeTree"),
    CutsceneOpened = Networking.remoteEvent("CutsceneOpened"),
    PetalsGathered = Networking.remoteEvent("PetalsGathered")
}

local function v2_22() -- line 345 | captures: Networking
    return {
        FetchState = Networking.remoteFunction("FetchState"),
        StateRefreshed = Networking.remoteEvent("StateRefreshed")
    }
end

Networking.namespace({
    name = "LuckWindow",
    env = "all"
})
v4.LuckWindow = {
    FetchState = Networking.remoteFunction("FetchState"),
    StateRefreshed = Networking.remoteEvent("StateRefreshed")
}

local function v2_23() -- line 350 | captures: Networking
    return {
        AskWrite = Networking.remoteFunction("AskWrite"),
        PreferenceShifted = Networking.remoteEvent("PreferenceShifted")
    }
end

Networking.namespace({
    name = "Preferences",
    env = "all"
})
v4.Preferences = {
    AskWrite = Networking.remoteFunction("AskWrite"),
    PreferenceShifted = Networking.remoteEvent("PreferenceShifted")
}
Networking.namespace({
    name = "MineTrap",
    env = "all"
})
v4.MineTrap = {
    AskPlace = Networking.remoteEvent("AskPlace"),
    AttachOutline = Networking.remoteEvent("AttachOutline"),
    TrapSet = Networking.remoteEvent("TrapSet")
}

local function v2_24() -- line 359 | captures: Networking
    return { BeginShutdown = Networking.remoteEvent("BeginShutdown") }
end

Networking.namespace({
    name = "Lifecycle",
    env = "all"
})
v4.Lifecycle = { BeginShutdown = Networking.remoteEvent("BeginShutdown") }

local function v2_25() -- line 364 | captures: Networking
    return { Trigger = Networking.remoteEvent("Trigger") }
end

Networking.namespace({
    name = "ToolTrigger",
    env = "all"
})
v4.ToolTrigger = { Trigger = Networking.remoteEvent("Trigger") }
Networking.namespace({
    name = "Trailwear",
    env = "all"
})
v4.Trailwear = {
    AskChoose = Networking.remoteFunction("AskChoose"),
    AskDoff = Networking.remoteFunction("AskDoff"),
    AskPurchase = Networking.remoteFunction("AskPurchase"),
    AskWornSnapshot = Networking.remoteFunction("AskWornSnapshot"),
    WornTrailShifted = Networking.remoteEvent("WornTrailShifted")
}

local function v2_26() -- line 379 | captures: Networking
    return { AskPlace = Networking.remoteEvent("AskPlace") }
end

Networking.namespace({
    name = "TrapPlacement",
    env = "all"
})
v4.TrapPlacement = { AskPlace = Networking.remoteEvent("AskPlace") }
Networking.namespace({
    name = "Treadmill",
    env = "all"
})
v4.Treadmill = {
    AskClipFavour = Networking.remoteFunction("AskClipFavour"),
    AskDoff = Networking.remoteFunction("AskDoff"),
    AskFavourSnapshot = Networking.remoteFunction("AskFavourSnapshot"),
    AskFriendFavourSnapshot = Networking.remoteFunction("AskFriendFavourSnapshot"),
    AskPostReply = Networking.remoteFunction("AskPostReply"),
    AskRenderSnapshot = Networking.remoteFunction("AskRenderSnapshot"),
    AskReplyCounts = Networking.remoteFunction("AskReplyCounts"),
    AskReplyFavour = Networking.remoteFunction("AskReplyFavour"),
    AskReplyPage = Networking.remoteFunction("AskReplyPage"),
    AskSlowToggle = Networking.remoteFunction("AskSlowToggle"),
    AskSlowToggleSet = Networking.remoteFunction("AskSlowToggleSet"),
    AskTierRaise = Networking.remoteFunction("AskTierRaise"),
    AskWearStill = Networking.remoteFunction("AskWearStill"),
    AssignedBeltShifted = Networking.remoteEvent("AssignedBeltShifted"),
    GaugeClipLength = Networking.remoteFunction("GaugeClipLength"),
    OverlaySnapshot = Networking.remoteEvent("OverlaySnapshot"),
    RefreshClipCursor = Networking.remoteEvent("RefreshClipCursor"),
    RenderStateShifted = Networking.remoteEvent("RenderStateShifted"),
    SpeedGained = Networking.remoteEvent("SpeedGained"),
    SubmitClipView = Networking.remoteEvent("SubmitClipView"),
    ViewStateShifted = Networking.remoteEvent("ViewStateShifted")
}

local function v2_27() -- line 410 | captures: Networking
    return { AnchorForZone = Networking.remoteEvent("AnchorForZone") }
end

Networking.namespace({
    name = "ZoneProbe",
    env = "all"
})
v4.ZoneProbe = { AnchorForZone = Networking.remoteEvent("AnchorForZone") }
Networking.namespace({
    name = "MonsterEvent",
    env = "all"
})
v4.MonsterEvent = {
    GetWins = Networking.remoteFunction("GetWins"),
    WinsUpdated = Networking.remoteEvent("WinsUpdated"),
    GetWinParts = Networking.remoteFunction("GetWinParts"),
    WinPartsUpdated = Networking.remoteEvent("WinPartsUpdated"),
    RequestTeleport = Networking.remoteFunction("RequestTeleport"),
    PlaySFX = Networking.remoteEvent("PlaySFX")
}
Networking.namespace({
    name = "Codes",
    env = "all"
})
v4.Codes = {
    AskRedeem = Networking.remoteEvent("AskRedeem"),
    Verdict = Networking.remoteEvent("Verdict")
}
Networking.close()
return v4
