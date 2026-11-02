-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeIndices(v1, ...) -- line 19
    local v2 = #v1
    local v3 = {}
    local v4 = {}
    for v5, v6 in ipairs({ ... }) do
        local v7 = if v6 < 1 then v6 + v2 else v6
        v3[v7] = true
    end
    for v8, v9 in ipairs(v1) do
        if not v3[v8] then
            table.insert(v4, v9)
        end
    end
    return v4
end

return removeIndices
