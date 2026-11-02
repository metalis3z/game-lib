-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)

return table.freeze({
	Enabled = FastFlags.Replicated("Game.Codes.Enabled", Asserts.Boolean, true)
})