-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local InstanceCache = require(ReplicatedStorage.Packages.InstanceCache)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Money = ReplicatedStorage.Assets.Models.Orbs.Money
local v1 = {
    _id = "Money",
    DisplayName = "Money",
    Icon = "rbxassetid://112678965246772",
    Desc = "",
    Rarity = Rarity.Rarities.Uncommon
}

v1.Sounds = {
    Single = {
        Ids = { "rbxassetid://109773907278305" },
        Data = {
            Volume = 0.5,
            Speed = { 0.95, 1.05 }
        }
    }
}
v1.Instance = Constants.IS_SERVER and Money or InstanceCache.new(Money, 1):SetExpandAmount(1)
return table.freeze(v1)
