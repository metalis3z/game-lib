-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "FlameTreadmill",
    Price = 250000,
    Icon = "rbxassetid://103122274001487",
    SpeedMultiplier = 12,
    DisplayInShop = true,
    DisplayName = "Flame Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_FlameTreadmill,
    Rarity = Rarity.Rarities.Rare
})
