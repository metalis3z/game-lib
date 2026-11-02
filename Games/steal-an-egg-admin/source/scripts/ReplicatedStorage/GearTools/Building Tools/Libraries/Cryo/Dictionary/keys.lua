-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function keys(v1) -- line 4
    local v2 = {}
    local v3 = 1
    for v4 in pairs(v1) do
        v2[v3] = v4
        v3 += 1
    end
    return v2
end

return keys
