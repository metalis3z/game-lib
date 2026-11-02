-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    if v1 >= 0 then
        local v2 = v1 // 4294967296
        return bit32.bor(v2, 0), (bit32.bor(v1, 0))
    end
    local v3 = -1 - v1
    local v4 = v3 // 4294967296
    return bit32.bnot(v4), (bit32.bnot(v3))
end
