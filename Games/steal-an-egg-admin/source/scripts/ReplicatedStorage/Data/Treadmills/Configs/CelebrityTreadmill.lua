-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "CelebrityTreadmill",
    Price = 5000000,
    Icon = "rbxassetid://75188836342954",
    SpeedMultiplier = 30,
    DisplayInShop = true,
    DisplayName = "Celebrity Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Treadmill_CelebrityTreadmill,
    Rarity = Rarity.Rarities.Epic
})
