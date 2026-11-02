--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = FastFlags.Replicated("Game.CrateShop.OpenEnabled", Asserts.Boolean, true)

return table.freeze({
	OpenEnabled = v1,
	PriceOverrides = FastFlags.Replicated("Game.CrateShop.PriceOverrides", Asserts.Map(Asserts.String, Asserts.AnyOf(Asserts.FiniteNonNegative, Asserts.Equals(-1))), {})
})