

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v4 = FastFlags.Replicated("Game.Codes.Enabled", Asserts.Boolean, true)

return table.freeze({
	Enabled = v4
})
