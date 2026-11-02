-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated)
return function(v1) -- line 8 | captures: FormatAbbreviated
    local v2 = type(v1) == "number"
    assert(v2)
    if v1 == 0 then
        return "0"
    end
    if v1 == (1/0) then
        return "Infinity"
    end
    if v1 == (-1/0) then
        return "-Infinity"
    end
    if v1 == v1 then
        return "1/" .. FormatAbbreviated(1 / v1)
    end
    return "NaN"
end
