-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "OPTREADMILL",
    DisplayName = "OP Treadmill",
    Icon = "rbxassetid://131220261336100",
    Standalone = true,
    DisplayInShop = false,
    SpeedMultiplier = 1,
    FixedSpeedPowerPerSecond = 1000000,
    SpeedGainInterval = 0.1,
    Rarity = Rarity.Rarities.Divine
})
