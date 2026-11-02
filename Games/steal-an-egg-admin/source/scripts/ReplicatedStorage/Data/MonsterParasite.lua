-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Flyswatter = require(ReplicatedStorage.Data.Gears.Configs.Flyswatter)
local MonsterParasiteFlags = require(ReplicatedStorage.Shared.Flags.MonsterParasiteFlags)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local RewardIds = MonsterParasite.RewardIds
local v1 = {
    Snow = 29,
    Volcano = 26
}

v1["Abyss Ocean"] = 18
v1.Prehistoric = 15
v1.Cosmic = 13
v1["Cherry Blossom"] = 11
v1["Titan Temple"] = 9

local v2 = {
    {
        Charge = 0,
        Scale = 1
    },
    {
        Charge = 20,
        Scale = 1.12
    },
    {
        Charge = 40,
        Scale = 1.25
    },
    {
        Charge = 60,
        Scale = 1.45
    },
    {
        Charge = 80,
        Scale = 1.75
    },
    {
        Charge = 100,
        Scale = 2
    }
}
local v3 = {}
local v4 = {
    Weight = 43.5,
    DisplayName = "1.25x Egg Growth",
    DisplayNote = "5 Minutes",
    Rarity = "Common",
    Icon = "rbxassetid://84954605144740",
    Id = RewardIds.EggGrowthBoost,
    Metadata = {
        DurationSeconds = 300,
        Multiplier = 1.25
    }
}
local v5 = {
    Weight = 30,
    DisplayName = "1.25x Speed",
    DisplayNote = "5 Minutes",
    Rarity = "Uncommon",
    Icon = "rbxassetid://99458650446228",
    Id = RewardIds.SpeedBoost,
    Metadata = {
        DurationSeconds = 300,
        Multiplier = 1.25
    }
}
local v6 = {
    Weight = 20,
    DisplayName = "2x Treadmill Speed",
    DisplayNote = "5 Minutes",
    Rarity = "Rare",
    Id = RewardIds.TreadmillBoost,
    Metadata = { DurationSeconds = 300 }
}
local v7 = {
    Weight = 5,
    DisplayName = "Flyswatter",
    Rarity = "Epic",
    Id = RewardIds.ExclusiveWeapon,
    DuplicateRewardId = RewardIds.TreadmillBoost,
    Icon = Flyswatter.Icon,
    Metadata = { GearId = Flyswatter._id }
}
local v8 = {
    Weight = 1.5,
    DisplayName = "Parasite Egg",
    DisplayNote = "Guaranteed Parasite Mutation",
    NoteIsPanelOnly = true,
    Rarity = "BEST REWARD",
    Icon = "rbxassetid://121553987798547",
    Id = RewardIds.MonsterEgg
}
local v9 = { MutationId = "Monstrous" }
local v10 = require(ReplicatedStorage.Data.Areas.Configs["Titan Temple"])
local v11 = {}
for v12, v13 in v10.DropTable do
    local v14 = {
        Id = v13[1],
        Weight = v13[2]
    }
    table.insert(v11, v14)
end
local v15 = #v11 > 0
assert(v15, "Titan Temple has no drop table for the Monstrous Egg")
v9.EggIdsList = v11
v8.Metadata = v9
v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = v7
v3[5] = v8

local v16 = {
    EventName = "MonsterParasite",
    EndsAt = 1788620400,
    MinimumRarityNumber = 5,
    EligibilityGuardId = "Jungle",
    SpawnChanceByArea = v1,
    ChargePerFeed = 20,
    MaxCharge = 100,
    BellyStages = v2,
    Rewards = v3,
    FeedDistance = 14,
    HudDistance = 24,
    RequestCooldown = 0.75,
    PromptHoldDuration = 0.25,
    MonsterOffset = CFrame.new(0, 0, -8),
    MarkerFolderName = "MonsterParasiteMarkers",
    MonsterSpawnMarkerName = "MonsterSpawn",
    ChestSpawnMarkerName = "MonsterChestSpawn",
    ChestSpawnCFrameAttributeName = "MonsterChestSpawnCFrame",
    AssetsFolderName = "MonsterParasite",
    ParasiteModelName = "Parasite",
    ParasiteVisualName = "MonsterParasiteVisual",
    ParasiteIdleAnimationId = 73367604252685,
    ParasiteCrownOffset = Vector2.zero,
    ParasiteScaleMultiplier = 0.45,
    MonsterModelName = "Monster",
    MonsterModelNames = { "Monster1", "Monster2", "Monster3", "Monster4" },
    MonsterModelIndexAttributeName = "MonsterModelIndex",
    MonsterRetiringAttributeName = "MonsterRetiring",
    MonsterRetireSeconds = 0.45,
    MonsterAnimationIdsByIndex = {
        {
            Idle = 76065307456197,
            Yank = 97808764253016
        },
        {
            Idle = 113278373348391,
            Yank = 122043898280856
        },
        {
            Idle = 120485798987195,
            Yank = 91335200477951
        },
        {
            Idle = 71296942212273,
            Yank = 137946515498421,
            Burp = 102943067580756
        }
    },
    ChestModelName = "MonsterChest",
    ChestToolName = "Monster Chest",
    ChestToolItemType = "MonsterChest",
    ChestToolScale = 0.42,
    MonsterAnimationSaveNamesByIndex = {
        {
            Idle = "idle",
            Yank = "idle_1"
        },
        {
            Idle = "idle_1",
            Yank = "catching an egg"
        },
        {
            Idle = "idle",
            Yank = "big boy "
        },
        {
            Idle = "big boy idle",
            Yank = "big boy idle_1",
            Burp = "burping"
        }
    },
    ChestToolGrip = CFrame.new(0, -0.15, -0.35) * CFrame.Angles(0, 1.5707963267948966, 0),
    ChestToolIcon = "rbxassetid://87367374815459",
    ChestPickupDuration = 0.6,
    ParasiteBillboardName = "MonsterParasite",
    ParasiteBillboardScale = 0.5,
    ParasiteHighlightName = "MonsterParasiteHighlight",
    ParasiteHighlightColor = Color3.fromRGB(198, 158, 255),
    ParasiteHighlightTransparency = 0.25,
    ParasiteHighlightFillTransparency = 0.7,
    HudName = "MonsterChargeUI",
    WorldFolderName = "MonsterParasiteMonsters",
    PadName = "Monster",
    MonsterDisplayName = "The Hungry Monster",
    TalkPromptName = "TalkPrompt",
    TalkPromptText = "Who are you?",
    FeedPromptName = "FeedPrompt",
    FeedPromptText = "Feed Parasite",
    ChestPromptName = "ChestPrompt",
    ChestPromptText = "Claim Monster Chest",
    DialogueText = "Parasites make me stronger. Bring me an infested egg, and I will eat the parasite without harming what is inside.",
    RewardTitle = "MONSTER CHEST REWARD",
    BellyPartName = "Belly",
    ParasiteEatTargetPartName = "ParasiteEatTarget",
    TongueTipName = "Tongue3",
    ChestOriginPartName = "ChestOrigin",
    ChestOriginNames = { "ChestOrigin", "MouthCenter1", "Tongue3" },
    GrabMarkerName = "Grab",
    BurpMarkerName = "burp_start",
    ChestOffset = CFrame.new(0, 2, -4)
}

v16.YankDuration = 0.35
v16.BellyTweenDuration = 0.45
v16.FullChargeHoldDuration = 0.8
v16.FullChargeModelHoldDuration = 15
v16.BurpBeatDuration = 0.18
v16.RoarDuration = 0.55
v16.ChestLaunchDelay = 0.06
v16.ChestLaunchDuration = 0.78
v16.ChestBounceDuration = 0.4
v16.ChestLaunchHeight = 5
v16.ChestBounceHeight = 1.4
v16.ChestLaunchStartScale = 0.65
v16.ChestLaunchSpins = 2
v16.ChestLaunchBeatFallback = 2.4
v16.ChestThrowDistanceMin = 12
v16.ChestThrowDistanceMax = 19
v16.ChestThrowSpreadDegrees = 26
v16.ChestThrowStraightJitterDegrees = 5
v16.ChestThrowAttempts = 5
v16.ChestGroundRestDuration = 0.3
v16.ChestPickupRise = 2.5
v16.ChestGroundProbeHeight = 6
v16.ChestGroundProbeDepth = 90
v16.ChestImpactShakeMagnitude = 1.4
v16.ChestImpactShakeRoughness = 9
v16.ChestImpactShakeFadeIn = 0.04
v16.ChestImpactShakeFadeOut = 0.5
v16.ChestImpactShakeRange = 110
v16.SoundFolderName = "MonsterParasite"
v16.YankSoundName = "Yank"
v16.ChompSoundName = "Chomp"
v16.BurpSoundName = "Burp"
v16.RoarSoundName = "Roar"
v16.EnergyBurstSoundName = "EnergyBurst"
v16.ChestLandingSoundName = "ChestLanding"
v16.ChestSoundName = "ChestOpen"
v16.VfxFolderName = "MonsterParasite"
v16.EnergyBurstVfxName = "EnergyBurst"
v16.SwapPoofVfxName = "SwapPoof"
v16.GroundHitParticlesName = "BigHitGroundAttach"
v16.HudRootName = "Root"
v16.HudBarName = "Bar"
v16.HudFillName = "Fill"
v16.HudPercentName = "Percent"
v16.HudStatusName = "Status"
v16.HudTimerName = "Timer"
v16.HudChargingText = "MONSTER CHARGE"
v16.HudReadyText = "MONSTER CHEST READY!"

function v16.GetSpawnChance(v17) -- line 212 | captures: MonsterParasiteFlags, v1
    local v18 = MonsterParasiteFlags.SpawnChanceByArea:Get()[v17]
    if v18 == nil then
        return v1[v17] or 0
    end
    return v18
end

function v16.GetBellyScale(v19) -- line 219 | captures: v2
    local Scale = v2[1].Scale
    for v20, v21 in v2 do
        if v19 < v21.Charge then
            break
        end
        Scale = v21.Scale
    end
    return Scale
end

function v16.GetMonsterModelIndex(v22) -- line 232
    if v22 >= 80 then
        return 4
    end
    if v22 >= 60 then
        return 3
    end
    if v22 >= 40 then
        return 2
    end
    return 1
end

function v16.GetReward(v23) -- line 244 | captures: v3
    for v24, v25 in v3 do
        if v25.Id == v23 then
            return v25
        end
    end
    local v26 = ("Unknown Monster Chest reward %*"):format(v23)
    error(v26, 2)
end

function v16.RewardLabel(v27) -- line 256
    if v27.DisplayNote == nil or v27.NoteIsPanelOnly then
        return v27.DisplayName
    end
    return (("%* (%*)"):format(v27.DisplayName, v27.DisplayNote))
end

function v16.BoostMultiplier(v28) -- line 262 | captures: MonsterParasite, v3
    local v29 = MonsterParasite.BoostRewardIds[v28]
    for v30, v31 in v3 do
        if v31.Id == v29 then
            return v31.Metadata.Multiplier or 1
        end
    end
    local v32 = ("Unknown Monster Chest reward %*"):format(v29)
    error(v32, 2)
    return (nil).Metadata.Multiplier or 1
end

function v16.BoostDurationSeconds(v33) -- line 278 | captures: MonsterParasite, v3
    local v34 = MonsterParasite.BoostRewardIds[v33]
    for v35, v36 in v3 do
        if v36.Id == v34 then
            return v36.Metadata.DurationSeconds or 0
        end
    end
    local v37 = ("Unknown Monster Chest reward %*"):format(v34)
    error(v37, 2)
    return (nil).Metadata.DurationSeconds or 0
end

function v16.GetRewardWeight(v38) -- line 294 | captures: MonsterParasiteFlags, v3
    local v39 = MonsterParasiteFlags.RewardWeights:Get()[v38]
    if v39 == nil then
        for v40, v41 in v3 do
            if v41.Id == v38 then
                return v41.Weight
            end
        end
        local v42 = ("Unknown Monster Chest reward %*"):format(v38)
        error(v42, 2)
        return (nil).Weight
    end
    return v39
end

return table.freeze(v16)
