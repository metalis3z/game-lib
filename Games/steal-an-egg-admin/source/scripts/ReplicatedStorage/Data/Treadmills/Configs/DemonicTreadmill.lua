-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "DemonicTreadmill",
    Price = 50000000000000,
    Icon = "rbxassetid://99849961715962",
    SpeedMultiplier = 1000,
    DisplayInShop = true,
    DisplayName = "Demonic Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_DemonicTreadmill,
    Rarity = Rarity.Rarities.Eternal
})
