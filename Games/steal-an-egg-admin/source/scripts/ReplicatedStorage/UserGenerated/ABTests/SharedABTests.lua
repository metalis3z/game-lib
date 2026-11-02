-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = Asserts.Map(Asserts.String, Asserts.Any)
local v2 = FastFlags.Replicated("UserGenerated.ABTestDefaults", v1, {})
return table.freeze({
    UpdateRemote = script:WaitForChild("Update"),
    ABTestDefaults = v2
})
