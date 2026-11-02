-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "Treadmill",
    Price = 0,
    Icon = "rbxassetid://84421204509494",
    SpeedMultiplier = 2,
    DisplayInShop = true,
    DisplayName = "Treadmill",
    Rarity = Rarity.Rarities.Common
})
