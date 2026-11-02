-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local copy = require(script.Parent.copy)

local function removeKeys(v1, ...) -- line 20 | captures: copy
    local v2 = copy(v1)
    for v3, v4 in ipairs({ ... }) do
        v2[v4] = nil
    end
    return v2
end

return removeKeys
