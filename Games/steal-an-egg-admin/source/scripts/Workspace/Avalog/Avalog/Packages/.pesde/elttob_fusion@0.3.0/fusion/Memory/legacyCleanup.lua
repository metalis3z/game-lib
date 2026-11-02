-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local doCleanup = require(Parent.Memory.doCleanup)

local function legacyCleanup(v1) -- line 11 | captures: External, doCleanup
    External.logWarn("cleanupWasRenamed")
    return doCleanup(v1)
end

return legacyCleanup
