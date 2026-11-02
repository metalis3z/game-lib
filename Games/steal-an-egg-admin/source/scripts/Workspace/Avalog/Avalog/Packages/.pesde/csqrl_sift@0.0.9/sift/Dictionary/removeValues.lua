-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local toSet = require(script.Parent.Parent.Array.toSet)

local function removeValues(v1, ...) -- line 23 | captures: toSet
    local v2 = toSet({ ... })
    local v3 = {}
    for v4, v5 in pairs(v1) do
        if not v2[v5] then
            v3[v4] = v5
        end
    end
    return v3
end

return removeValues
