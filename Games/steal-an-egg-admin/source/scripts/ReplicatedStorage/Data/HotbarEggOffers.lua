-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)
local v1 = {
    table.freeze({
        Uid = "PromptMonsterEgg",
        Slot = 1,
        AssetCategory = "Scorpio",
        ProductId = MonetizationConfig.ProductIds.MonsterEgg,
        DisplayName = require(ReplicatedStorage.Data.LimitedEgg).DisplayName
    }),
    table.freeze({
        Uid = "PromptBrainrotEgg",
        Slot = 2,
        AssetCategory = "Strawberry Elephant",
        ProductId = MonetizationConfig.ProductIds.BrainrotEgg,
        DisplayName = require(ReplicatedStorage.Data.BrainrotEgg).DisplayName
    })
}
local v2 = {}
for v3, v4 in ipairs(v1) do
    v2[v4.Uid] = v4
end
return table.freeze({
    BatSlot = 3,
    TrapSlot = 4,
    Offers = table.freeze(v1),
    ByUid = table.freeze(v2)
})
