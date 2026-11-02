-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local toSet = require(script.Parent.toSet)

local function removeValues(v1, ...) -- line 20 | captures: toSet
    local v2 = toSet({ ... })
    local v3 = {}
    for v4, v5 in ipairs(v1) do
        if not v2[v5] then
            table.insert(v3, v5)
        end
    end
    return v3
end

return removeValues
