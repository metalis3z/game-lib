-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local v1 = { Enabled = FastFlags.Replicated("Game.MonsterParasite.Enabled", Asserts.Boolean, true) }
local v2 = Asserts.Map(Asserts.String, Asserts.Range(0, 100))

v1.SpawnChanceByArea = FastFlags.Replicated("Game.MonsterParasite.SpawnChanceByArea", v2, {})

local v3 = Asserts.Map(Asserts.String, Asserts.FiniteNonNegative)

v1.RewardWeights = FastFlags.Replicated("Game.MonsterParasite.RewardWeights", v3, {})
return table.freeze(v1)
