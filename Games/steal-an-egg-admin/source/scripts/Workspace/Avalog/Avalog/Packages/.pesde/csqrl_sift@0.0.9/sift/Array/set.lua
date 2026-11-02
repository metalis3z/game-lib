-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function set(v1, v2, v3) -- line 20
    local v4 = #v1
    local v5 = {}
    local v6 = if v2 < 1 then v2 + v4 else v2
    for v7, v8 in ipairs(v1) do
        if v7 == v6 then
            table.insert(v5, v3)
        else
            table.insert(v5, v8)
        end
    end
    return v5
end

return set
