-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "Lucky BlockTreadmill",
    Price = 75000000000,
    Icon = "rbxassetid://85546442623094",
    SpeedMultiplier = 200,
    DisplayInShop = true,
    DisplayName = "Lucky Block Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Treadmill_Lucky BlockTreadmill"],
    Rarity = Rarity.Rarities.Cosmic
})
