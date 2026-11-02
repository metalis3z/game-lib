-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local _Filter = require(script.Parent._Filter)
local rshift = bit32.rshift
return _Filter("Screen", function(v1, v2) -- line 12 | captures: rshift
    local v3 = (255 - v2 * 255) * (255 - v1 * 255)
    return 255 - rshift(v3, 8)
end)
