-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function pop(v1, v2) -- line 20
    local v3 = #v1
    local v4 = {}
    local v5 = if type(v2) == "number" then v2 else 1
    local v6 = v3 - v5
    for v7 = 1, v6 do
        local v8 = v1[v7]
        table.insert(v4, v8)
    end
    return v4
end

return pop
