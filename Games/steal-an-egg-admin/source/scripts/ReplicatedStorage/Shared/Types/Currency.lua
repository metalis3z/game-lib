-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    AllCurrencyTypes = {
        Money = "Money",
        SakuraCrystals = "SakuraCrystals"
    },
    AllCurrencyTypesArray = { "Money", "SakuraCrystals" }
}
local v2 = {}
local Money = t.literal("Money")

v2.AllCurrencyTypes = t.union(Money, t.literal("SakuraCrystals"))
v1.SchemaValidation = v2
return v1
