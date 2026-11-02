-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return function(v1) -- line 6
    local v2 = string.len(v1)
    local v3 = buffer.create(v2 * 2)
    local v4 = v2 - 1
    for v5 = 0, v4 do
        local v6 = v5 + 1
        local v7 = string.byte(v1, v6)
        local v8 = bit32.rshift(v7, 4)
        local v9 = bit32.band(v7, 15)
        local v10 = if v8 >= 10 then v8 + 87 else v8 + 48
        local v11 = v5 * 2 + 0
        buffer.writeu8(v3, v11, v10)
        local v12 = if v9 >= 10 then v9 + 87 else v9 + 48
        local v13 = v5 * 2 + 1
        buffer.writeu8(v3, v13, v12)
    end
    return buffer.tostring(v3)
end
