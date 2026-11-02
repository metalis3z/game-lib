-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function flip(v1) -- line 17
    local v2 = {}
    for v3, v4 in pairs(v1) do
        v2[v4] = v3
    end
    return v2
end

return flip
