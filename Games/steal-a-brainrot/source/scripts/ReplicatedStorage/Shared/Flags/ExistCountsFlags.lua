

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v4 = FastFlags.Replicated("ExistCounts.PublicBrainrots", Asserts.Array(Asserts.String), {})
local v5 = FastFlags.Replicated("ExistCounts.FullAccessUserIds", Asserts.Array(Asserts.Integer), {})

return table.freeze({
	PublicBrainrots = v4,
	FullAccessUserIds = v5
})
