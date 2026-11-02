-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    RewardIds = table.freeze({
        EggGrowthBoost = "EggGrowthBoost",
        SpeedBoost = "SpeedBoost",
        TreadmillBoost = "TreadmillBoost",
        ExclusiveWeapon = "ExclusiveWeapon",
        MonsterEgg = "MonsterEgg"
    }),
    RetiredRewardIds = table.freeze({
        Cash = "Cash",
        SpeedSmall = "SpeedSmall",
        SpeedLarge = "SpeedLarge"
    })
}
local v2 = t.literal(v1.RewardIds.EggGrowthBoost)
local v3 = t.literal(v1.RewardIds.SpeedBoost)
local v4 = t.literal(v1.RewardIds.TreadmillBoost)
local v5 = t.literal(v1.RewardIds.ExclusiveWeapon)
local v6 = t.literal(v1.RewardIds.MonsterEgg)
local v7 = t.literal(v1.RetiredRewardIds.Cash)
local v8 = t.literal(v1.RetiredRewardIds.SpeedSmall)
local v9 = t.union(v2, v3, v4, v5, v6, v7, v8, t.literal(v1.RetiredRewardIds.SpeedLarge))
local v10 = t.interface({
    Id = v9,
    DisplayName = t.string,
    Amount = t.optional(t.number),
    ItemId = t.optional(t.string),
    Egg = t.optional(t.interface({
        Uid = t.string,
        AssetCategory = t.string,
        Mutation = t.string
    }))
})

v1.PendingRewardSchema = t.interface({
    OpeningId = t.string,
    Reward = v10,
    SerializedEgg = t.optional(Eggs.SchemaValidation.SerializedSavedEgg)
})
v1.StateSchema = t.interface({
    Charge = t.number,
    PendingChests = t.number,
    TotalFeeds = t.number,
    PendingReward = t.optional(v1.PendingRewardSchema),
    EggGrowthBoostExpiresAt = t.optional(t.number),
    SpeedBoostExpiresAt = t.optional(t.number)
})
v1.EventStateSchema = t.interface({
    Active = t.boolean,
    EndsAt = t.number,
    ServerTime = t.number
})
v1.SnapshotSchema = t.interface({
    Event = v1.EventStateSchema,
    State = v1.StateSchema
})
v1.FeedResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string,
    EggUid = t.optional(t.string),
    PreviousCharge = t.optional(t.number),
    Charge = t.optional(t.number),
    PendingChests = t.optional(t.number)
})
v1.ChestResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string,
    OpeningId = t.optional(t.string),
    Reward = t.optional(v10),
    PendingChests = t.optional(t.number)
})
v1.RevealResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string
})
v1.TakeResultSchema = t.interface({
    Success = t.boolean,
    Message = t.string
})
v1.ViewRewardsPromptName = "ViewRewardsPrompt"
v1.ViewRewardsPromptText = "View Rewards"
v1.ChargeDrainAttributeName = "MonsterChargeDrain"
v1.ChargeDrainDuration = 0.5
v1.ChargeGainAttributeName = "MonsterChargeGain"
v1.ChargeGainCueTimeout = 4
v1.BoostKinds = table.freeze({
    EggGrowth = "EggGrowth",
    Speed = "Speed"
})
v1.BoostRewardIds = table.freeze({
    EggGrowth = v1.RewardIds.EggGrowthBoost,
    Speed = v1.RewardIds.SpeedBoost
})

function v1.BoostExpiresAt(v11, v12) -- line 68 | captures: v1
    if v11 ~= nil then
        local v13 = if v12 == v1.BoostKinds.EggGrowth then v11.EggGrowthBoostExpiresAt else v11.SpeedBoostExpiresAt
        if type(v13) == "number" then
            return v13
        end
    end
    return 0
end

function v1.BoostRemainingSeconds(v14, v15, v16) -- line 83 | captures: Workspace, v1
    local v17
    if v16 == nil then
        v17 = Workspace:GetServerTimeNow()
    else
        v17 = v16
    end
    local v18 = v1.BoostExpiresAt(v14, v15) - v17
    return (math.max(v18, 0))
end

function v1.IsBoostActive(v19, v20, v21) -- line 93 | captures: v1
    return v1.BoostRemainingSeconds(v19, v20, v21) > 0
end

function v1.RefreshBoost(v22, v23, v24, v25) -- line 98 | captures: v1
    local function v26(v27, ...)
        return (math.max(v27, ...))
    end

    local v28 = table.clone(v22)
    local v29 = v26(v25 + v24, v1.BoostExpiresAt(v22, v23))
    if v23 == v1.BoostKinds.EggGrowth then
        v28.EggGrowthBoostExpiresAt = v29
    else
        v28.SpeedBoostExpiresAt = v29
    end
    return v28
end

local function DefaultState() -- line 108
    return {
        Charge = 0,
        PendingChests = 0,
        TotalFeeds = 0
    }
end

v1.DefaultState = DefaultState
return table.freeze(v1)
