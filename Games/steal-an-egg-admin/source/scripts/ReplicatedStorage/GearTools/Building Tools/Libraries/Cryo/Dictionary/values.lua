-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function values(v1) -- line 5
    local v2 = {}
    local v3 = 1
    for v4, v5 in pairs(v1) do
        v2[v3] = v5
        v3 += 1
    end
    return v2
end

return values
