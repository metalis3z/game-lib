-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function map(v1, v2) -- line 4
    local v3 = {}
    local v4 = #v1
    for v5 = 1, v4 do
        v3[v5] = v2(v1[v5], v5)
    end
    return v3
end

return map
