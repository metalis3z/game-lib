-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function entries(v1) -- line 17
    local v2 = {}
    for v3, v4 in pairs(v1) do
        local v5 = { v3, v4 }
        table.insert(v2, v5)
    end
    return v2
end

return entries
