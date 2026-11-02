-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function replaceIndex(v1, v2, v3) -- line 5
    local v4 = {}
    local v5 = #v1
    local v6 = v2 <= v5
    assert(v6, "index must be less or equal than the list length")
    for v7 = 1, v5 do
        if v7 == v2 then
            v4[v7] = v3
        else
            v4[v7] = v1[v7]
        end
    end
    return v4
end

return replaceIndex
