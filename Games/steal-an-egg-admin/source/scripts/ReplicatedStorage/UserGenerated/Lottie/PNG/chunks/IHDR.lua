-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
local v1 = {}

v1[0] = { 1, 2, 4, 8, 16 }
v1[2] = { 8, 16 }
v1[3] = { 1, 2, 4, 8 }
v1[4] = { 8, 16 }
v1[6] = { 8, 16 }
return function(v2, v3) -- line 20 | captures: v1
    local v4 = v3.length == 13
    assert(v4, "IHDR data must be 13 bytes")
    local offset = v3.offset
    local v5 = buffer.readu32(v2, offset)
    local v6 = bit32.byteswap(v5)
    local v7 = offset + 4
    local v8 = buffer.readu32(v2, v7)
    local v9 = bit32.byteswap(v8)
    local v10 = offset + 8
    local v11 = buffer.readu8(v2, v10)
    local v12 = offset + 9
    local v13 = buffer.readu8(v2, v12)
    local v14 = offset + 10
    local v15 = buffer.readu8(v2, v14)
    local v16 = offset + 11
    local v17 = buffer.readu8(v2, v16)
    local v18 = offset + 12
    local v19 = buffer.readu8(v2, v18)
    local v20 = if v6 > 0 and v6 <= 2147483648 and v9 > 0 then v9 <= 2147483648 else false
    assert(v20, "invalid dimensions")
    local v21 = v15 == 0
    assert(v21, "invalid compression method")
    local v22 = v17 == 0
    assert(v22, "invalid filter method")
    local v23 = if v19 == 0 then true else v19 == 1
    assert(v23, "invalid interlace method")
    local v24 = v1[v13]
    local v25 = v24 ~= nil
    assert(v25, "invalid color type")
    local v26 = table.find(v24, v11) ~= nil
    assert(v26, "invalid bit depth")
    local v27 = {
        width = v6,
        height = v9,
        bitDepth = v11,
        colorType = v13
    }
    v27.interlaced = v19 == 1
    return v27
end
