-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function splice(v1, v2, v3, ...) -- line 22
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
    local v8 = v6 - 1
    for v9 = 1, v8 do
        local v10 = v1[v9]
        table.insert(v5, v10)
    end
    for v11, v12 in ipairs({ ... }) do
        table.insert(v5, v12)
    end
    local v13 = v7 + 1
    for v14 = v13, v4 do
        local v15 = v1[v14]
        table.insert(v5, v15)
    end
    return v5
end

return splice
