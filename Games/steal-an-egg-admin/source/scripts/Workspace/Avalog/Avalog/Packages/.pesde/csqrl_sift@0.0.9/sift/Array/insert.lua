-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function insert(v1, v2, ...) -- line 21
    local v3 = #v1
    local v4 = if v2 < 1 then v2 + (v3 + 1) else v2
    if v3 < v4 then
        if v3 + 1 < v4 then
            return v1
        end
        v4, v3 = v3 + 1, v3 + 1
    end
    local v5 = {}
    for v6 = 1, v3 do
        if v6 == v4 then
            for v7, v8 in ipairs({ ... }) do
                table.insert(v5, v8)
            end
        end
        local v9 = v1[v6]
        table.insert(v5, v9)
    end
    return v5
end

return insert
