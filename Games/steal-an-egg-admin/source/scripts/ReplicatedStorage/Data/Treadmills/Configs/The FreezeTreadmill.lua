-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "The FreezeTreadmill",
    Price = 3000000000,
    Icon = "rbxassetid://97611802500180",
    SpeedMultiplier = 100,
    DisplayInShop = true,
    DisplayName = "The Freeze Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Treadmill_The FreezeTreadmill"],
    Rarity = Rarity.Rarities.Mythic
})
