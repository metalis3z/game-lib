-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1, v2) -- line 6
    local v3 = buffer.len(v1)
    local v4 = buffer.len(v2)
    local v5 = math.min(v3, v4) - 1
    for v6 = 0, v5 do
        local v7 = buffer.readu8(v1, v6)
        local v8 = buffer.readu8(v2, v6)
        if v7 ~= v8 then
            return v7 - v8
        end
    end
    return v3 - v4
end
