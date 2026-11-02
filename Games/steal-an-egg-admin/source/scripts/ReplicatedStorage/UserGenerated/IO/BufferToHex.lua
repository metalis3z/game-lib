-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

function BufferToHex(v1) -- line 6
    local v2 = buffer.len(v1)
    local v3 = buffer.create(v2 * 2)
    local v4 = v2 - 1
    for v5 = 0, v4 do
        local v6 = buffer.readu8(v1, v5)
        local v7 = bit32.rshift(v6, 4)
        local v8 = bit32.band(v6, 15)
        local v9 = if v7 >= 10 then v7 + 87 else v7 + 48
        local v10 = v5 * 2 + 0
        buffer.writeu8(v3, v10, v9)
        local v11 = if v8 >= 10 then v8 + 87 else v8 + 48
        local v12 = v5 * 2 + 1
        buffer.writeu8(v3, v12, v11)
    end
    return buffer.tostring(v3)
end

return BufferToHex
