-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1[48] = 0
v1[49] = 1
v1[50] = 2
v1[51] = 3
v1[52] = 4
v1[53] = 5
v1[54] = 6
v1[55] = 7
v1[56] = 8
v1[57] = 9
v1[65] = 10
v1[66] = 11
v1[67] = 12
v1[68] = 13
v1[69] = 14
v1[70] = 15
v1[97] = 10
v1[98] = 11
v1[99] = 12
v1[100] = 13
v1[101] = 14
v1[102] = 15
return function(v2) -- line 29 | captures: v1
    local v3 = #v2
    local v4 = v3 % 2 == 0
    assert(v4, "hex length must be even")
    local v5 = buffer.create(v3 // 2)
    local v6 = 0
    for v7 = 1, v3, 2 do
        local v8 = v7 + 1
        local v9, v10 = string.byte(v2, v7, v8)
        local v11 = v1[v9]
        if not v11 then
            error((("invalid hex at %*"):format(v7)))
        end
        local v12 = v1[v10]
        if not v12 then
            error((("invalid hex at %*"):format(v7 + 1)))
        end
        local v13 = v11 * 16 + v12
        buffer.writeu8(v5, v6, v13)
        v6 += 1
    end
    return v5
end
