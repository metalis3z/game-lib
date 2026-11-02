-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "AngelicTreadmill",
    Price = 1000000000000000,
    Icon = "rbxassetid://104277706019985",
    SpeedMultiplier = 2000,
    DisplayInShop = true,
    DisplayName = "Angelic Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_AngelicTreadmill,
    Rarity = Rarity.Rarities.Divine
})
