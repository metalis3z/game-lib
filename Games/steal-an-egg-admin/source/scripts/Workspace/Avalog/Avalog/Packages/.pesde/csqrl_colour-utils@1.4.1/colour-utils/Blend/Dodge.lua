-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _Filter = require(script.Parent._Filter)
local lshift = bit32.lshift
local clamp = math.clamp
local min = math.min
return _Filter("Dodge", function(v1, v2) -- line 15 | captures: lshift, clamp, min
    local v3 = v1 * 255
    local v4 = clamp(v3, 0, 255)
    local v5 = v2 * 255
    if v4 ~= 255 or not v4 then
        local v6 = lshift(v5, 8) / (255 - v4)
        v4 = min(255, v6)
    end
    return v4
end)
