-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function foldLeft(v1, v2, v3) -- line 4
    local v4 = #v1
    local v5 = v3
    for v6 = 1, v4 do
        v5 = v2(v5, v1[v6], v6)
    end
    return v5
end

return foldLeft
