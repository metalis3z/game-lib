-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function add(v1, ...) -- line 18
    local v2 = {}
    for v3, v4 in pairs(v1) do
        v2[v3] = true
    end
    for v5, v6 in ipairs({ ... }) do
        v2[v6] = true
    end
    return v2
end

return add
