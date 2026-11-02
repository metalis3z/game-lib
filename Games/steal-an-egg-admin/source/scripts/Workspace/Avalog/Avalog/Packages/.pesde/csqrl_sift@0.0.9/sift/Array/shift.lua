-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function shift(v1, v2) -- line 20
    local v3 = #v1
    local v4 = {}
    local v5 = if type(v2) == "number" then v2 + 1 else 2
    for v6 = v5, v3 do
        local v7 = v1[v6]
        table.insert(v4, v7)
    end
    return v4
end

return shift
