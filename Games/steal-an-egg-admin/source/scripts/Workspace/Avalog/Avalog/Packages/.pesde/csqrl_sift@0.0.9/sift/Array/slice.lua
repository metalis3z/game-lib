-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function slice(v1, v2, v3) -- line 21
    local v4 = #v1
    local v5 = {}
    local v6 = if type(v2) == "number" then v2 else 1
    local v7 = if type(v3) == "number" then v3 else v4
    if v6 < 1 then
        v6 += v4
    end
    if v7 < 1 then
        v7 += v4
    end
    for v8 = v6, v7 do
        local v9 = v1[v8]
        table.insert(v5, v9)
    end
    return v5
end

return slice
