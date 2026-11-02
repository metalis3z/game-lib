

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

require(ReplicatedStorage.Datas.ServerData)

local v4 = FastFlags.Replicated("Duels.PreTeleportSelection", Asserts.Boolean, false)
local v5 = FastFlags.Replicated("Duels.MedusaCooldownDecreasePerMinute", Asserts.FiniteNonNegative, 5)

return table.freeze({
	PreTeleportSelection = v4,
	MedusaCooldownDecreasePerMinute = v5
})
