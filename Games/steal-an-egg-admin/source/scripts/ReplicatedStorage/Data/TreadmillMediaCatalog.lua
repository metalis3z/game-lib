-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {
    BASELINE_RELEASE_VERSION = 1,
    BASELINE_MEDIA_COUNT = 246,
    CURRENT_RELEASE_VERSION = 3
}

function v1.ResolveEntryReleaseVersion(v2) -- line 12 | captures: t
    t.strict(t.intersection(t.integer, t.numberPositive))(v2)
    return v2
end

return v1
