--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

return table.freeze({
	OpenEnabled = FastFlags.Replicated("Game.Mailbox.OpenEnabled", Asserts.Boolean, true)
})