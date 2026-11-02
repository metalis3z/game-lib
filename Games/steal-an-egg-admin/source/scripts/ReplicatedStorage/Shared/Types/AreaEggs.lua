-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    States = {
        Slot = "Slot",
        Carried = "Carried",
        Dropped = "Dropped",
        GuardCarried = "GuardCarried",
        Claimed = "Claimed"
    },
    DropReasons = {
        PlayerRequest = "PlayerRequest",
        GuardHit = "GuardHit",
        PlayerSlap = "PlayerSlap",
        Rewind = "Rewind",
        CharacterRemoving = "CharacterRemoving",
        HumanoidDied = "HumanoidDied",
        PlayerRemoving = "PlayerRemoving",
        External = "External"
    }
}
local v2 = t.literal(v1.States.Slot)
local v3 = t.literal(v1.States.Carried)
local v4 = t.literal(v1.States.Dropped)
local v5 = t.literal(v1.States.GuardCarried)
local v6 = t.union(v2, v3, v4, v5, t.literal(v1.States.Claimed))
local v7 = t.literal(v1.DropReasons.PlayerRequest)
local v8 = t.literal(v1.DropReasons.GuardHit)
local v9 = t.literal(v1.DropReasons.PlayerSlap)
local v10 = t.literal(v1.DropReasons.Rewind)
local v11 = t.literal(v1.DropReasons.CharacterRemoving)
local v12 = t.literal(v1.DropReasons.HumanoidDied)
local v13 = t.literal(v1.DropReasons.PlayerRemoving)
local v14 = t.union(v7, v8, v9, v10, v11, v12, v13, t.literal(v1.DropReasons.External))
local v15 = t.interface({
    Uid = t.string,
    AreaId = t.string,
    NestId = t.string,
    AssetCategory = t.string,
    AssetScale = t.number,
    AssetEyeColor = t.string,
    AssetColorSeed = t.number,
    AssetColorIndex = t.number,
    Mutations = t.array(t.string),
    BaseMutation = t.optional(t.string),
    HasParasite = t.optional(t.boolean),
    NestScale = t.number,
    BottomCFrame = t.CFrame,
    BoundsCFrame = t.CFrame,
    BoundsSize = t.Vector3,
    State = v6,
    CarrierUserId = t.optional(t.number),
    DroppedAt = t.optional(t.number),
    Version = t.number
})

v1.SchemaValidation = {
    AreaEggState = v6,
    DropReason = v14,
    AreaEggRecord = v15,
    AreaEggSnapshot = t.interface({
        Records = t.array(v15),
        ServerTime = t.number
    }),
    AreaEggBatchUpdate = t.interface({
        UpdatedRecords = t.array(v15),
        RemovedUids = t.array(t.string),
        ServerTime = t.number
    }),
    AreaEggCarryRequest = t.interface({
        Uid = t.string,
        FirstAreaSlotKey = t.optional(t.string)
    }),
    AreaEggDropRequest = t.interface({ Reason = t.optional(v14) }),
    AreaEggCarryState = t.interface({
        IsCarrying = t.boolean,
        Uid = t.optional(t.string),
        AreaId = t.optional(t.string),
        AssetCategory = t.optional(t.string),
        RunBackWakeDelayRequired = t.optional(t.boolean),
        GuardDisabled = t.optional(t.boolean),
        SpeedMultiplier = t.number
    }),
    AreaEggClaimFeedback = t.interface({
        AssetCategory = t.string,
        DisplayName = t.string,
        Rarity = t.string,
        Color = t.Color3,
        Position = t.Vector3
    })
}
return v1
