-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)

local function readU16(v1, v2, v3) -- line 7
    local v4 = buffer.readu8(v1, v2)
    local v5 = bit32.lshift(v4, 8)
    local v6 = v2 + 1
    local v7 = buffer.readu8(v1, v6)
    local v8 = bit32.bor(v5, v7)
    return (bit32.extract(v8, 0, v3))
end

return function(v9, v10, v11, v12) -- line 13
    local v13, v14, v15, v16
    if v11.colorType == 0 then
        local v17 = v10.length == 2
        assert(v17, "invalid tRNS length for color type")
        local offset = v10.offset
        local v18 = buffer.readu8(v9, offset)
        local v19 = bit32.lshift(v18, 8)
        local v20 = offset + 1
        local v21 = buffer.readu8(v9, v20)
        local v22 = bit32.bor(v19, v21)
        local bitDepth = v11.bitDepth
        v13 = bit32.extract(v22, 0, bitDepth)
        v14 = -1
        v15 = -1
        v16 = -1
    elseif v11.colorType == 2 then
        local v23 = v10.length == 6
        assert(v23, "invalid tRNS length for color type")
        local offset = v10.offset
        local v24 = buffer.readu8(v9, offset)
        local v25 = bit32.lshift(v24, 8)
        local v26 = offset + 1
        local v27 = buffer.readu8(v9, v26)
        local v28 = bit32.bor(v25, v27)
        local bitDepth = v11.bitDepth
        v14 = bit32.extract(v28, 0, bitDepth)
        local v29 = v10.offset + 2
        local v30 = buffer.readu8(v9, v29)
        local v31 = bit32.lshift(v30, 8)
        local v32 = v29 + 1
        local v33 = buffer.readu8(v9, v32)
        local v34 = bit32.bor(v31, v33)
        local bitDepth_2 = v11.bitDepth
        v15 = bit32.extract(v34, 0, bitDepth_2)
        local v35 = v10.offset + 4
        local v36 = buffer.readu8(v9, v35)
        local v37 = bit32.lshift(v36, 8)
        local v38 = v35 + 1
        local v39 = buffer.readu8(v9, v38)
        local v40 = bit32.bor(v37, v39)
        local bitDepth_3 = v11.bitDepth
        v13, v16 = -1, bit32.extract(v40, 0, bitDepth_3)
    else
        local length = v10.length
        assert(v12, "tRNS requires PLTE for color type")
        local v41 = length <= #v12.colors
        assert(v41, "tRNS specified too many PLTE alphas")
        v13 = -1
        v14 = -1
        v15 = -1
        v16 = -1
        for v42 = 1, length do
            local v43 = v12.colors[v42]
            local v44 = v10.offset + v42 - 1
            v43.a = buffer.readu8(v9, v44)
            v13 = -1
            v14 = -1
            v15 = -1
            v16 = -1
        end
    end
    return {
        gray = v13,
        red = v14,
        green = v15,
        blue = v16
    }
end
