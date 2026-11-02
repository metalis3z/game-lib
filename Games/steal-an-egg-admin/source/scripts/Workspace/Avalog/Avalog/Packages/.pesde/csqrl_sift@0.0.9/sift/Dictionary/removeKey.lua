-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function removeKey(v1, v2) -- line 21 | captures: copy
    local v3 = copy(v1)
    v3[v2] = nil
    return v3
end

return removeKey
