

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v4 = FastFlags.Replicated("LuckyBlocks.OddsOverride", Asserts.Map(Asserts.String, Asserts.Map(Asserts.String, Asserts.FiniteNonNegative)), {})

return table.freeze({
	OddsOverride = v4
})
