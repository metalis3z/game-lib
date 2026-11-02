-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    SlapControllerProfile = t.interface({
        Duration = t.number,
        Force = t.number,
        BrainrotDamage = t.number,
        MaxBrainrotTargets = t.optional(t.number)
    })
}

v1.SlapControllerData = t.interface({
    Player = v1.SlapControllerProfile,
    Brainrot = v1.SlapControllerProfile,
    PlayerCooldown = t.optional(t.number),
    MobCooldown = t.optional(t.number)
})
return v1
