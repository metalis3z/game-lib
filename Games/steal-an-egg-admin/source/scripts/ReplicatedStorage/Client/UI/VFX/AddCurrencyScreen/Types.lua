-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local Money = t.literal("Money")

v1.AvailableCurrencyWidgetsTypes = t.union(Money, t.literal("Speed"))
return v1
