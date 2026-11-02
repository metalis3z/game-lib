-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "HackerTreadmill",
    Price = 2000000000000,
    Icon = "rbxassetid://114661675379027",
    SpeedMultiplier = 500,
    DisplayInShop = true,
    DisplayName = "Hacker Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_HackerTreadmill,
    Rarity = Rarity.Rarities.Secret
})
