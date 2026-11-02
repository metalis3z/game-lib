-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "GoldenTreadmill",
    Price = 120000000,
    Icon = "rbxassetid://99555941892079",
    SpeedMultiplier = 80,
    DisplayInShop = true,
    DisplayName = "Golden Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_GoldenTreadmill,
    Rarity = Rarity.Rarities.Legendary
})
