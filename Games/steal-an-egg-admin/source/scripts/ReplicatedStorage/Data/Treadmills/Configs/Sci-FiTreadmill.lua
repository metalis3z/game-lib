-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "Sci-FiTreadmill",
    Price = 15000,
    Icon = "rbxassetid://81563639782445",
    SpeedMultiplier = 5,
    DisplayInShop = true,
    DisplayName = "Sci-Fi Treadmill",
    ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds["Treadmill_Sci-FiTreadmill"],
    Rarity = Rarity.Rarities.Uncommon
})
