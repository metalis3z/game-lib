-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function reverse(v1) -- line 17
    local v2 = {}
    local v3 = #v1
    for v4 = v3, 1, -1 do
        local v5 = v1[v4]
        table.insert(v2, v5)
    end
    return v2
end

return reverse
