-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatOdds = require(ReplicatedStorage.UserGenerated.Strings.FormatOdds)
local FormatPercent = require(ReplicatedStorage.UserGenerated.Strings.FormatPercent)
return function(v1, v2) -- line 9 | captures: FormatOdds, FormatPercent
    local v3 = type(v1) == "number"
    assert(v3)
    local v4 = if v2 == nil then true else type(v2) == "number"
    assert(v4)
    local v5 = math.clamp(v1, 0, 1)
    local v6 = v2 or v5
    local v7 = math.clamp(v6, 0, 1)
    if not (v5 <= 0 or v7 > 0.0002) and v5 <= 0.001 then
        return FormatOdds(v5)
    end
    return FormatPercent(v5)
end
