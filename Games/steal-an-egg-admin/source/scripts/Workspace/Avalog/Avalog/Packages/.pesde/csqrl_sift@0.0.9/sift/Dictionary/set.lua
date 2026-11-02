-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function set(v1, v2, v3) -- line 21 | captures: copy
    local v4 = copy(v1)
    v4[v2] = v3
    return v4
end

return set
