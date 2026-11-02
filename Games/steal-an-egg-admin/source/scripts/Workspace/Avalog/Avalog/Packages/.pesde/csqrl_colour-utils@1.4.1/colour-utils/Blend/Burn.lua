-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _Filter = require(script.Parent._Filter)
local lshift = bit32.lshift
local clamp = math.clamp
local max = math.max
return _Filter("Burn", function(v1, v2) -- line 15 | captures: lshift, clamp, max
    local v3 = v1 * 255
    local v4 = clamp(v3, 0, 255)
    local v5 = v2 * 255
    if v4 ~= 0 or not v4 then
        local v6 = 255 - v5
        local v7 = 255 - lshift(v6, 8) / v4
        v4 = max(0, v7)
    end
    return v4
end)
