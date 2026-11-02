-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function filter(v1, v2) -- line 5
    local v3 = {}
    local v4 = #v1
    local v5 = 1
    for v6 = 1, v4 do
        local v7 = v1[v6]
        if v2(v7, v6) then
            v3[v5] = v7
            v5 += 1
        end
    end
    return v3
end

return filter
