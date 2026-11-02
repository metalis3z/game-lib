-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local v1 = {
    3614090360,
    3905402710,
    606105819,
    3250441966,
    4118548399,
    1200080426,
    2821735955,
    4249261313,
    1770035416,
    2336552879,
    4294925233,
    2304563134,
    1804603682,
    4254626195,
    2792965006,
    1236535329,
    4129170786,
    3225465664,
    643717713,
    3921069994,
    3593408605,
    38016083,
    3634488961,
    3889429448,
    568446438,
    3275163606,
    4107603335,
    1163531501,
    2850285829,
    4243563512,
    1735328473,
    2368359562,
    4294588738,
    2272392833,
    1839030562,
    4259657740,
    2763975236,
    1272893353,
    4139469664,
    3200236656,
    681279174,
    3936430074,
    3572445317,
    76029189,
    3654602809,
    3873151461,
    530742520,
    3299628645,
    4096336452,
    1126891415,
    2878612391,
    4237533241,
    1700485571,
    2399980690,
    4293915773,
    2240044497,
    1873313359,
    4264355552,
    2734768916,
    1309151649,
    4149444226,
    3174756917,
    718787259,
    3951481745
}
local v2 = {
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21
}
local v3 = table.create(64, 0)

function processBlocks(v4, v5, v6, v7) -- line 141 | captures: v1, v2, v3
    local v8, v9, v10, v11 = v4[1], v4[2], v4[3], v4[4]
    for v12 = v6, v7, 64 do
        local v13 = v12
        for v14 = 1, 16 do
            local v15 = v13 + 3
            local v16, v17, v18, v19 = string.byte(v5, v13, v15)
            local v20 = bit32.lshift(v19, 24)
            local v21 = bit32.lshift(v18, 16)
            local v22 = bit32.lshift(v17, 8)
            v3[v14] = bit32.bor(v20, v21, v22, v16)
            v13 += 4
        end
        local v23 = v8
        local v24 = v9
        local v25 = v10
        local v26 = v11
        for v27 = 0, 15 do
            local v28 = bit32.bxor(v24, v25)
            local v29 = bit32.band(v24, v28)
            local v30 = v23 + bit32.bxor(v25, v29) + v1[v27 + 1] + v3[v27 + 1]
            local v31 = v2[v27 + 1]
            v23, v24, v25, v26 = v26, v24 + bit32.lrotate(v30, v31), v24, v25
        end
        for v32 = 16, 31 do
            local v33 = bit32.bxor(v24, v24)
            local v34 = bit32.band(v25, v33)
            local v35 = v23 + bit32.bxor(v24, v34) + v1[v32 + 1] + v3[(v32 * 5 + 1) % 16 + 1]
            local v36 = v2[v32 + 1]
            v23, v24, v25, v26 = v26, v24 + bit32.lrotate(v35, v36), v24, v25
        end
        for v37 = 32, 47 do
            local v38 = v23 + bit32.bxor(v24, v24, v25) + v1[v37 + 1] + v3[(v37 * 3 + 5) % 16 + 1]
            local v39 = v2[v37 + 1]
            v23, v24 = v26, v24 + bit32.lrotate(v38, v39)
        end
        for v40 = 48, 63 do
            local v41 = bit32.bnot(v25)
            local v42 = bit32.bor(v24, v41)
            local v43 = v23 + bit32.bxor(v24, v42) + v1[v40 + 1] + v3[v40 * 7 % 16 + 1]
            local v44 = v2[v40 + 1]
            v23, v24, v26 = v26, v24 + bit32.lrotate(v43, v44), v25
        end
        local v45 = v23 + v8
        v8 = bit32.bor(v45)
        local v46 = v24 + v9
        v9 = bit32.bor(v46)
        local v47 = v25 + v10
        v10 = bit32.bor(v47)
        local v48 = v26 + v11
        v11 = bit32.bor(v48)
    end
    v4[1] = v8
    v4[2] = v9
    v4[3] = v10
    v4[4] = v11
end

function md5(v49) -- line 213
    local v50 = { 1732584193, 4023233417, 2562383102, 271733878 }
    local v51 = #v49
    local v52 = v51 % 64
    if v51 >= 64 then
        processBlocks(v50, v49, 1, v51 - v52)
    end
    local v53 = v52 + 32
    local v54 = bit32.band(v53, 4294967232)
    local v55 = {}
    local v56
    if v52 == 0 then
        v56 = ""
    else
        local v57 = -v52
        v56 = string.sub(v49, v57)
    end
    local v58 = string.rep("\000", (v54 - v52 - 9) % 64)
    v55[1] = v56
    v55[2] = "\128"
    v55[3] = v58
    v55[4] = string.pack("<L", v51 * 8)
    local v59 = table.concat(v55)
    processBlocks(v50, v59, 1, #v59)
    local v60 = buffer.create(16)
    local v61 = v50[1]
    buffer.writeu32(v60, 0, v61)
    local v62 = v50[2]
    buffer.writeu32(v60, 4, v62)
    local v63 = v50[3]
    buffer.writeu32(v60, 8, v63)
    local v64 = v50[4]
    buffer.writeu32(v60, 12, v64)
    return v60
end

local v65 = {
    Name = "MD5",
    BlockSize = 64,
    OutputSize = 16,
    Digest = function(v66) -- Digest | line 246
        return buffer.tostring(md5(v66))
    end,
    DigestBuffer = function(v67) -- DigestBuffer | line 249
        return md5(buffer.tostring(v67))
    end,
    DigestToBuffer = md5
}
table.freeze(v65)
return v65
