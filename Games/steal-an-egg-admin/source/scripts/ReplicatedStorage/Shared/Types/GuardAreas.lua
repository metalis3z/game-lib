-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = {
    ForestGuardHitRequest = t.interface({
        EggUid = t.string,
        GuardCFrame = t.CFrame
    })
}
local v3 = { EggUid = t.string }
local Attached = t.literal("Attached")

v3.Kind = t.union(Attached, t.literal("Deposited"))
v2.ForestGuardDepositRequest = t.interface(v3)
v1.SchemaValidation = v2
return v1
