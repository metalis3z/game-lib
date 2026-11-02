--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

return table.freeze({
	PriceOverrides = FastFlags.Replicated("Game.SeedShop.PriceOverrides", Asserts.Map(Asserts.String, Asserts.FiniteNonNegative), {})
})