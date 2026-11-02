--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

return table.freeze({
	PriceOverrides = FastFlags.Replicated("Game.GearShop.PriceOverrides", Asserts.Map(Asserts.String, Asserts.AnyOf(Asserts.FiniteNonNegative, Asserts.Equals(-1))), {})
})