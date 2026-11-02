-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function withKeys(v1, ...) -- line 19
    local v2 = {}
    for v3, v4 in ipairs({ ... }) do
        v2[v4] = v1[v4]
    end
    return v2
end

return withKeys
