-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 6
    local v3 = type(v1) == "number"
    assert(v3)
    local v4 = type(v2) == "number"
    assert(v4)
    if v2 == 0 then
        return v1
    end
    local v5 = ("%*e%*"):format(string.format("%f", v1), v2)
    return tonumber(v5) or v1 * 10 ^ v2
end
