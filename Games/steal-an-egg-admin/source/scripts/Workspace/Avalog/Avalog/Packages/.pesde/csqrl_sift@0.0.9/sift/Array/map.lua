-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function map(v1, v2) -- line 20
    local v3 = {}
    for v4, v5 in ipairs(v1) do
        local v6 = v2(v5, v4, v1)
        if v6 ~= nil then
            table.insert(v3, v6)
        end
    end
    return v3
end

return map
