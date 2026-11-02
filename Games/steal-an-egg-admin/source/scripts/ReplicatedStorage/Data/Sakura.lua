-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = {
    EventName = "GreatBloom",
    CurrencyId = "SakuraCrystals",
    MutationName = "Sakura",
    SpecialMutationName = "GreatBloom",
    TreeTag = "SakuraBloomTree",
    CrystalTag = "SakuraCrystal",
    BatToolAttribute = "IsBat"
}
local v2 = {
    IntervalSeconds = 1800,
    OffsetSeconds = 900,
    DurationSeconds = 285,
    NightPollSeconds = 0.5,
    EndsAtAttribute = "GreatBloomEndsAt",
    MaxActiveTrees = 50,
    SpawnDelayMin = 0.25,
    SpawnDelayMax = 0.75,
    SpawnClearance = 6,
    SpawnAttempts = 40,
    HitCooldownSeconds = 0.6,
    HitHoldSeconds = 0.2,
    EndingWarningSeconds = 30,
    HitRange = 10,
    SpawnShakeRadius = 10,
    CrystalScale = 0.22,
    CrystalPickupRange = 10,
    CrystalLifetimeSeconds = 60,
    CrystalSpreadRadius = 14
}
local v3 = {}
local v4 = {
    Id = "Medium",
    Weight = 30,
    Hits = 2,
    CrystalsPerHit = 0,
    ScatterCrystals = 2,
    ScatterCrystalValue = 5
}
local v5 = {
    Id = "Large",
    Weight = 15,
    Hits = 3,
    CrystalsPerHit = 0,
    ScatterCrystals = 4,
    ScatterCrystalValue = 5
}

v3[1] = {
    Id = "Small",
    Weight = 50,
    Hits = 1,
    CrystalsPerHit = 0,
    ScatterCrystals = 1,
    ScatterCrystalValue = 5
}
v3[2] = v4
v3[3] = v5
v3[4] = {
    Id = "Gigantic",
    Weight = 5,
    Hits = 3,
    CrystalsPerHit = 0,
    ScatterCrystals = 6,
    ScatterCrystalValue = 5
}
v2.Sizes = v3
v1.Bloom = v2

local v6 = {
    Cost = 1000,
    MaxChargePercent = 150,
    SpecialChanceAt100 = 2.5,
    SpecialChanceAtMax = 5,
    LuckBoostMultiplier = 2,
    MaxLuckBoosts = 3
}

v6.LuckBoostProductNames = { "SakuraLuckBoost1", "SakuraLuckBoost2", "SakuraLuckBoost3" }
v1.Incubator = v6
v1.Sounds = {
    TreeSpawn = 96404900659610,
    TreeHit = 80030381163014,
    TreeBreak = 134632360736427,
    CrystalPickup = 139930403759000,
    CrystalsGained = 91066377792964,
    Deposit = 111061591915568,
    Mutate = 135047494141156,
    CraneFlap = 9120779671,
    Bloom = 9116418035,
    Unlocked = 117231025727465,
    TutorialOpen = 86204379714906
}
v1.AreaDisplay = {
    AreaId = "CherryBlossom",
    DisplayName = "Cherry Blossom",
    Emoji = "\240\159\140\184",
    Lighting = "CherryBlossom",
    Rarity = Rarity.Rarities.Divine
}
v1.Quest = { CraneAssetId = "Crane" }

function v1.GetRequiredCrystals() -- line 109 | captures: v1
    return v1.Incubator.Cost
end

function v1.GetChargePercent(v7, v8) -- line 112 | captures: v1
    if v8 <= 0 then
        return 0
    end
    local v9 = v7 / v8 * 100
    local MaxChargePercent = v1.Incubator.MaxChargePercent
    return (math.clamp(v9, 0, MaxChargePercent))
end

function v1.GetLuckMultiplier(v10) -- line 119 | captures: v1
    return v1.Incubator.LuckBoostMultiplier ^ v10
end

function v1.CanBuyLuckBoost(v11, v12) -- line 122 | captures: v1
    if v11.Unlocked then
        if v11.Egg == false then
            return false, "Place an egg inside first"
        end
        if v1.Incubator.MaxLuckBoosts <= v11.LuckBoost then
            return false, "This egg already has max luck"
        end
        if v12 == v11.LuckBoost + 1 then
            return true, nil
        end
        return false, "Wrong luck boost tier for this egg"
    end
    return false, "The Sakura Incubator is still sealed"
end

function v1.GetFreeChargeCap(v13) -- line 137 | captures: v1
    local v14 = v13 * v1.Incubator.MaxChargePercent / 100
    return (math.ceil(v14))
end

local function GetMutationChance(v15) -- line 140
    return (math.clamp(v15, 0, 100))
end

v1.GetMutationChance = GetMutationChance

function v1.GetEffectiveMutationChance(v16, v17) -- line 143 | captures: v1
    return 100 - v1.GetSpecialChance(v16, v17)
end

function v1.GetSpecialChance(v18, v19) -- line 146 | captures: v1
    local Incubator = v1.Incubator
    local v20 = v18 - 100
    local v21 = math.max(v20, 0)
    local v22 = Incubator.MaxChargePercent - 100
    local v23 = v21 / math.max(v22, 1)
    local v24 = (Incubator.SpecialChanceAt100 + (Incubator.SpecialChanceAtMax - Incubator.SpecialChanceAt100) * v23) * v1.GetLuckMultiplier(v19)
    return (math.clamp(v24, 0, 100))
end

function v1.PickTreeSize(v25) -- line 153 | captures: v1
    local Sizes = v1.Bloom.Sizes
    local v26 = 0
    for v27, v28 in Sizes do
        v26 += v28.Weight
    end
    local v29 = 0
    for v30, v31 in Sizes do
        v29 += v31.Weight
        if v25:NextNumber() * v26 <= v29 then
            return v31
        end
    end
    return Sizes[#Sizes]
end

function v1.GetTreeSize(v32) -- line 174 | captures: v1
    for v33, v34 in v1.Bloom.Sizes do
        if v34.Id == v32 then
            return v34
        end
    end
    error((("Unknown Sakura tree size %*"):format(v32)))
end

function v1.HasSakuraMutation(v35) -- line 185 | captures: v1
    if v35 == nil then
        return false
    end
    if table.find(v35, v1.MutationName) == nil then
        return table.find(v35, v1.SpecialMutationName) ~= nil
    end
    return true
end

function v1.IsBatTool(v36) -- line 192 | captures: v1
    return v36:GetAttribute(v1.BatToolAttribute) == true
end

return v1
