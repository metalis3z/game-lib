-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local v1 = {
    1116352408,
    1899447441,
    3049323471,
    3921009573,
    961987163,
    1508970993,
    2453635748,
    2870763221,
    3624381080,
    310598401,
    607225278,
    1426881987,
    1925078388,
    2162078206,
    2614888103,
    3248222580,
    3835390401,
    4022224774,
    264347078,
    604807628,
    770255983,
    1249150122,
    1555081692,
    1996064986,
    2554220882,
    2821834349,
    2952996808,
    3210313671,
    3336571891,
    3584528711,
    113926993,
    338241895,
    666307205,
    773529912,
    1294757372,
    1396182291,
    1695183700,
    1986661051,
    2177026350,
    2456956037,
    2730485921,
    2820302411,
    3259730800,
    3345764771,
    3516065817,
    3600352804,
    4094571909,
    275423344,
    430227734,
    506948616,
    659060556,
    883997877,
    958139571,
    1322822218,
    1537002063,
    1747873779,
    1955562222,
    2024104815,
    2227730452,
    2361852424,
    2428436474,
    2756734187,
    3204031479,
    3329325298
}
local v2 = table.create(64, 0)

function processBlocks(v3, v4, v5, v6) -- line 75 | captures: v1, v2
    local v7, v8, v9, v10, v11, v12, v13, v14 = v3[1], v3[2], v3[3], v3[4], v3[5], v3[6], v3[7], v3[8]
    for v15 = v5, v6, 64 do
        local v16 = v15
        for v17 = 1, 16 do
            local v18 = v16 + 3
            local v19, v20, v21, v22 = string.byte(v4, v16, v18)
            local v23 = bit32.lshift(v19, 24)
            local v24 = bit32.lshift(v20, 16)
            local v25 = bit32.lshift(v21, 8)
            v2[v17] = bit32.bor(v23, v24, v25, v22)
            v16 += 4
        end
        for v26 = 17, 64 do
            local v27 = v2[v26 - 2]
            local v28 = v2[v26 - 15]
            local v29 = bit32.rrotate(v27, 17)
            local v30 = bit32.rrotate(v27, 19)
            local v31 = bit32.rshift(v27, 10)
            local v32 = bit32.bxor(v29, v30, v31) + v2[v26 - 7]
            local v33 = bit32.rrotate(v28, 7)
            local v34 = bit32.rrotate(v28, 18)
            local v35 = bit32.rshift(v28, 3)
            v2[v26] = v32 + bit32.bxor(v33, v34, v35) + v2[v26 - 16]
        end
        local v36 = v7
        local v37 = v8
        local v38 = v9
        local v39 = v10
        local v40 = v11
        local v41 = v12
        local v42 = v13
        local v43 = v14
        for v44 = 1, 64 do
            local v45 = bit32.rrotate(v40, 6)
            local v46 = bit32.rrotate(v40, 11)
            local v47 = bit32.rrotate(v40, 25)
            local v48 = v43 + bit32.bxor(v45, v46, v47) + bit32.band(v40, v41)
            local v49 = bit32.bnot(v40)
            local v50 = v48 + bit32.band(v49, v42) + v1[v44] + v2[v44]
            local v51 = bit32.band(v38, v37)
            local v52 = bit32.bxor(v38, v37)
            local v53 = v51 + bit32.band(v36, v52)
            local v54 = bit32.rrotate(v36, 2)
            local v55 = bit32.rrotate(v36, 13)
            local v56 = v39 + v50
            local v57 = bit32.rrotate(v36, 22)
            v36, v37, v38, v39, v40, v41, v42, v43 = v50 + (v53 + bit32.bxor(v54, v55, v57)), v36, v37, v38, v56, v40, v41, v42
        end
        local v58 = v36 + v7
        v7 = bit32.bor(v58, 0)
        local v59 = v37 + v8
        v8 = bit32.bor(v59, 0)
        local v60 = v38 + v9
        v9 = bit32.bor(v60, 0)
        local v61 = v39 + v10
        v10 = bit32.bor(v61, 0)
        local v62 = v40 + v11
        v11 = bit32.bor(v62, 0)
        local v63 = v41 + v12
        v12 = bit32.bor(v63, 0)
        local v64 = v42 + v13
        v13 = bit32.bor(v64, 0)
        local v65 = v43 + v14
        v14 = bit32.bor(v65, 0)
    end
    v3[1] = v7
    v3[2] = v8
    v3[3] = v9
    v3[4] = v10
    v3[5] = v11
    v3[6] = v12
    v3[7] = v13
    v3[8] = v14
end

function sha224(v66) -- line 164
    local v67 = { 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 }
    local v68 = #v66
    local v69 = v68 % 64
    if v68 >= 64 then
        processBlocks(v67, v66, 1, v68 - v69)
    end
    local v70 = v69 + 32
    local v71 = bit32.band(v70, 4294967232)
    local v72 = {}
    local v73
    if v69 == 0 then
        v73 = ""
    else
        local v74 = -v69
        v73 = string.sub(v66, v74)
    end
    local v75 = string.rep("\000", (v71 - v69 - 9) % 64)
    v72[1] = v73
    v72[2] = "\128"
    v72[3] = v75
    v72[4] = string.pack(">L", v68 * 8)
    local v76 = table.concat(v72)
    processBlocks(v67, v76, 1, #v76)
    local v77 = buffer.create(28)
    local v78 = v67[1]
    local v79 = bit32.byteswap(v78)
    buffer.writeu32(v77, 0, v79)
    local v80 = v67[2]
    local v81 = bit32.byteswap(v80)
    buffer.writeu32(v77, 4, v81)
    local v82 = v67[3]
    local v83 = bit32.byteswap(v82)
    buffer.writeu32(v77, 8, v83)
    local v84 = v67[4]
    local v85 = bit32.byteswap(v84)
    buffer.writeu32(v77, 12, v85)
    local v86 = v67[5]
    local v87 = bit32.byteswap(v86)
    buffer.writeu32(v77, 16, v87)
    local v88 = v67[6]
    local v89 = bit32.byteswap(v88)
    buffer.writeu32(v77, 20, v89)
    local v90 = v67[7]
    local v91 = bit32.byteswap(v90)
    buffer.writeu32(v77, 24, v91)
    return v77
end

local v92 = {
    Name = "SHA-224",
    BlockSize = 64,
    OutputSize = 28,
    Digest = function(v93) -- Digest | line 209
        return buffer.tostring(sha224(v93))
    end,
    DigestBuffer = function(v94) -- DigestBuffer | line 212
        return sha224(buffer.tostring(v94))
    end,
    DigestToBuffer = sha224
}
table.freeze(v92)
return v92
