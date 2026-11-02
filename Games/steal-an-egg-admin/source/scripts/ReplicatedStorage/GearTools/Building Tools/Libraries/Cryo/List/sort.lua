-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function sort(v1, v2) -- line 6
    local v3 = {}
    local v4 = #v1
    for v5 = 1, v4 do
        v3[v5] = v1[v5]
    end
    table.sort(v3, v2)
    return v3
end

return sort
