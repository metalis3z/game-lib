-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function map(v1, v2) -- line 26
    local v3 = {}
    for v4, v5 in pairs(v1) do
        local v6, v7 = v2(v5, v4, v1)
        v3[v7 or v4] = v6
    end
    return v3
end

return map
