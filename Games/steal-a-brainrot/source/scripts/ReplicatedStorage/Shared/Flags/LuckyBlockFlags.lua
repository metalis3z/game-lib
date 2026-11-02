-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
return table.freeze({
	OddsOverride = FastFlags.Replicated("LuckyBlocks.OddsOverride", Asserts.Map(Asserts.String, Asserts.Map(Asserts.String, Asserts.FiniteNonNegative)), {})
})