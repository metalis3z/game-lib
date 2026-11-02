--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = FastFlags.Replicated("Game.Perf.Client.AgeUpdateMaxHz", Asserts.FinitePositive, 60)
local v2 = FastFlags.Replicated("Game.Perf.Client.MutationVFXDisabled", Asserts.Boolean, false)
local v3 = FastFlags.Replicated("Game.Perf.Client.DroppedItemAnimationsDisabled", Asserts.Boolean, false)
local v4 = FastFlags.Replicated("Game.Perf.Client.AnimatedGradientsDisabled", Asserts.Boolean, false)

return table.freeze({
	AgeUpdateMaxHz = v1,
	MutationVFXDisabled = v2,
	DroppedItemAnimationsDisabled = v3,
	AnimatedGradientsDisabled = v4,
	PlantVisualizerBudget = FastFlags.Replicated("Game.Perf.Client.PlantVisualizerBudget", Asserts.FinitePositive, 75)
})