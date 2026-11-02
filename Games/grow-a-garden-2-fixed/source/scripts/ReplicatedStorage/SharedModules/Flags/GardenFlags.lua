--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

return table.freeze({
	ExpansionPriceOverrides = FastFlags.Replicated("Game.Garden.ExpansionPriceOverrides", Asserts.Map(Asserts.String, Asserts.FiniteNonNegative), {})
})