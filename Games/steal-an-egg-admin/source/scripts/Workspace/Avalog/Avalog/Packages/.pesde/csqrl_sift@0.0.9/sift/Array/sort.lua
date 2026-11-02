-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function sort(v1, v2) -- line 22 | captures: copy
    local v3 = copy(v1)
    table.sort(v3, v2)
    return v3
end

return sort
