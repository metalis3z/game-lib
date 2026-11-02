-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
return table.freeze({
    _id = "SpinnyWheelTickets",
    DisplayName = "SpinnyWheelTickets",
    Icon = "rbxassetid://120222769031450",
    Desc = "",
    Rarity = Rarity.Rarities.SuperRare,
    Sounds = {
        Single = {
            Ids = { "rbxassetid://109773907278305" },
            Data = {
                Volume = 0.5,
                Speed = { 0.95, 1.05 }
            }
        }
    }
})
