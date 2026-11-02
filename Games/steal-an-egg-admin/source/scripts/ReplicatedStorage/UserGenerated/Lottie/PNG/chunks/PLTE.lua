-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return function(v1, v2, v3) -- line 7
    local v4 = v2.length % 3 == 0
    assert(v4, "malformed PLTE chunk")
    local v5 = v2.length / 3
    local v6 = v5 > 0
    assert(v6, "no entries in PLTE")
    local v7 = v5 <= 256
    assert(v7, "too many entries in PLTE")
    local v8 = v5 <= 2 ^ v3.bitDepth
    assert(v8, "too many entries in PLTE for bit depth")
    local v9 = table.create(v5)
    local v10 = v2.offset
    for v11 = 1, v5 do
        local v12 = {
            a = 255,
            r = buffer.readu8(v1, v10)
        }
        local v13 = v10 + 1
        v12.g = buffer.readu8(v1, v13)
        local v14 = v10 + 2
        v12.b = buffer.readu8(v1, v14)
        v9[v11] = v12
        v10 += 3
    end
    return { colors = v9 }
end
