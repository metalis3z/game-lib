-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeValue(v1, v2) -- line 18
    local v3 = {}
    for v4, v5 in ipairs(v1) do
        if v5 ~= v2 then
            table.insert(v3, v5)
        end
    end
    return v3
end

return removeValue
