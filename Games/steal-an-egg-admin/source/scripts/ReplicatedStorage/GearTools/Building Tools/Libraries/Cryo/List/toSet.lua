-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function toSet(v1) -- line 6
    local v2 = {}
    local v3 = #v1
    for v4 = 1, v3 do
        v2[v1[v4]] = true
    end
    return v2
end

return toSet
