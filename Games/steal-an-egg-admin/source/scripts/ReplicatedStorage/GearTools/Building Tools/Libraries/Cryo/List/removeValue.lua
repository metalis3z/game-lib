-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function removeValue(v1, v2) -- line 4
    local v3 = {}
    local v4 = #v1
    local v5 = 1
    for v6 = 1, v4 do
        if v1[v6] ~= v2 then
            v3[v5] = v1[v6]
            v5 += 1
        end
    end
    return v3
end

return removeValue
