-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
require(ReplicatedStorage.Datas.ServerData)
local v1 = FastFlags.Replicated("Duels.PreTeleportSelection", Asserts.Boolean, false)
return table.freeze({
	PreTeleportSelection = v1,
	MedusaCooldownDecreasePerMinute = FastFlags.Replicated("Duels.MedusaCooldownDecreasePerMinute", Asserts.FiniteNonNegative, 5)
})