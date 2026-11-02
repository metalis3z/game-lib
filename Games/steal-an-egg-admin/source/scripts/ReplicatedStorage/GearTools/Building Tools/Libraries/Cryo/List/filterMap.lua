-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function filterMap(v1, v2) -- line 7
    local v3 = {}
    local v4 = #v1
    local v5 = 1
    for v6 = 1, v4 do
        local v7 = v2(v1[v6], v6)
        if v7 ~= nil then
            v3[v5] = v7
            v5 += 1
        end
    end
    return v3
end

return filterMap
