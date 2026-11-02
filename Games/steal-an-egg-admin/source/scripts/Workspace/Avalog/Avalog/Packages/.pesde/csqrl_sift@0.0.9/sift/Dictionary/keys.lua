-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function keys(v1) -- line 17
    local v2 = {}
    for v3 in pairs(v1) do
        table.insert(v2, v3)
    end
    return v2
end

return keys
