-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function reverse(v1) -- line 5
    local v2 = {}
    local v3 = #v1
    local v4 = v3 + 1
    for v5 = 1, v3 do
        v2[v5] = v1[v4 - v5]
    end
    return v2
end

return reverse
