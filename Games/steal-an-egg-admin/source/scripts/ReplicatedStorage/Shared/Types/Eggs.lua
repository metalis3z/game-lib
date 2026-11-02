-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
require(ReplicatedStorage.Data.Assets)
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    MAX_INVENTORY = 115,
    HATCH_RESULT_MECHA_UPGRADED = "MechaUpgraded"
}
local v2 = t.interface({
    LocalCFrame = t.CFrame,
    PlacedAt = t.number,
    GrowthDuration = t.optional(t.number),
    GrowthCreditSeconds = t.optional(t.number),
    NightGrowthPeriodIndex = t.optional(t.number),
    NightGrowthCreditSeconds = t.optional(t.number),
    ReadyAt = t.optional(t.number)
})
local v3 = t.interface({
    LocalCFrame = t.array(t.number),
    PlacedAt = t.number,
    GrowthDuration = t.optional(t.number),
    GrowthCreditSeconds = t.optional(t.number),
    NightGrowthPeriodIndex = t.optional(t.number),
    NightGrowthCreditSeconds = t.optional(t.number),
    ReadyAt = t.optional(t.number)
})
local v4 = {
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string)
}
local Male = t.literal("Male")

v4.AssetGender = t.optional(t.union(Male, t.literal("Female")))
v4.AssetPersonality = t.optional(t.string)
v4.IsStolenDNA = t.optional(t.boolean)
v4.HasParasite = t.optional(t.boolean)
v4.ParasiteRemovedForHatch = t.optional(t.boolean)
v4.MechaRerollDone = t.optional(t.boolean)
v4.Placement = t.optional(v2)

local v5 = t.interface(v4)
local v6 = {
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string)
}
local Male_2 = t.literal("Male")

v6.AssetGender = t.optional(t.union(Male_2, t.literal("Female")))
v6.AssetPersonality = t.optional(t.string)
v6.IsStolenDNA = t.optional(t.boolean)
v6.HasParasite = t.optional(t.boolean)
v6.ParasiteRemovedForHatch = t.optional(t.boolean)
v6.MechaRerollDone = t.optional(t.boolean)
v6.Placement = t.optional(v3)

local v7 = t.interface(v6)
local v8 = {
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.optional(t.array(t.string)),
    BaseMutation = t.optional(t.string)
}
local Male_3 = t.literal("Male")

v8.AssetGender = t.optional(t.union(Male_3, t.literal("Female")))
v8.AssetPersonality = t.optional(t.string)
v8.IsStolenDNA = t.optional(t.boolean)
v8.HasParasite = t.optional(t.boolean)
v8.ParasiteRemovedForHatch = t.optional(t.boolean)
v8.MechaRerollDone = t.optional(t.boolean)
v8.Placement = t.optional(v2)
v8.GrowthSpeedMultiplier = t.number

local v9 = t.interface(v8)

v1.SchemaValidation = {
    EggPlacement = v2,
    EggInventory = t.map(t.string, v7),
    PlaceEggRequest = t.interface({
        Uid = t.string,
        LocalCFrame = t.CFrame
    }),
    RuntimeEggOwnerClear = t.interface({ OwnerUserId = t.number }),
    RuntimeEggOwnerUpdate = t.interface({
        OwnerUserId = t.number,
        Records = t.map(t.string, v9)
    }),
    RuntimeEggSnapshot = t.array(t.interface({
        OwnerUserId = t.number,
        Records = t.map(t.string, v9)
    })),
    RuntimeEggRecord = v9,
    SavedEgg = v5,
    SerializedEggPlacement = v3,
    SerializedSavedEgg = v7
}
return v1
