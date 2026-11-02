-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local Common = t.literal("Common")
local Uncommon = t.literal("Uncommon")
local Rare = t.literal("Rare")
local Legendary = t.literal("Legendary")
local Mythical = t.literal("Mythical")
local Divine = t.literal("Divine")
local Prismatic = t.literal("Prismatic")

v1.Rarity = t.union(Common, Uncommon, Rare, Legendary, Mythical, Divine, Prismatic, t.literal("Transcendent"))
return v1
