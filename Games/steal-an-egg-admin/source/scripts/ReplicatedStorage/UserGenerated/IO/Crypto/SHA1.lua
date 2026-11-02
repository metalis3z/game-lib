-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local v1 = table.create(80, 0)

function processBlocks(v2, v3, v4, v5) -- line 9 | captures: v1
    local v6, v7, v8, v9, v10 = v2[1], v2[2], v2[3], v2[4], v2[5]
    for v11 = v4, v5, 64 do
        local v12 = v11
        for v13 = 1, 16 do
            local v14 = v12 + 3
            local v15, v16, v17, v18 = string.byte(v3, v12, v14)
            local v19 = bit32.lshift(v15, 24)
            local v20 = bit32.lshift(v16, 16)
            local v21 = bit32.lshift(v17, 8)
            v1[v13] = bit32.bor(v19, v20, v21, v18)
            v12 += 4
        end
        for v22 = 17, 80 do
            local v23 = v1[v22 - 3]
            local v24 = v1[v22 - 8]
            local v25 = v1[v22 - 14]
            local v26 = v1[v22 - 16]
            local v27 = bit32.bxor(v23, v24, v25, v26)
            v1[v22] = bit32.lrotate(v27, 1)
        end
        local v28 = v6
        local v29 = v7
        local v30 = v8
        local v31 = v9
        local v32 = v10
        for v33 = 1, 20 do
            local v34 = bit32.lrotate(v28, 5) + bit32.band(v29, v30)
            local v35 = bit32.bnot(v29)
            v28, v29, v30, v31, v32 = v34 + bit32.band(v35, v31) + v32 + 1518500249 + v1[v33], v28, bit32.lrotate(v29, 30), v30, v31
        end
        for v36 = 21, 40 do
            v28, v29, v30, v31, v32 = bit32.lrotate(v28, 5) + bit32.bxor(v29, v30, v31) + v32 + 1859775393 + v1[v36], v28, bit32.lrotate(v29, 30), v30, v31
        end
        for v37 = 41, 60 do
            local v38 = bit32.lrotate(v28, 5) + bit32.band(v31, v30)
            local v39 = bit32.bxor(v31, v30)
            v28, v29, v30, v31, v32 = v38 + bit32.band(v29, v39) + v32 + 2400959708 + v1[v37], v28, bit32.lrotate(v29, 30), v30, v31
        end
        for v40 = 61, 80 do
            v28, v29, v30, v31, v32 = bit32.lrotate(v28, 5) + bit32.bxor(v29, v30, v31) + v32 + 3395469782 + v1[v40], v28, bit32.lrotate(v29, 30), v30, v31
        end
        local v41 = v28 + v6
        v6 = bit32.bor(v41, 0)
        local v42 = v29 + v7
        v7 = bit32.bor(v42, 0)
        local v43 = v30 + v8
        v8 = bit32.bor(v43, 0)
        local v44 = v31 + v9
        v9 = bit32.bor(v44, 0)
        local v45 = v32 + v10
        v10 = bit32.bor(v45, 0)
    end
    v2[1] = v6
    v2[2] = v7
    v2[3] = v8
    v2[4] = v9
    v2[5] = v10
end

function sha1(v46) -- line 106
    local v47 = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 }
    local v48 = #v46
    local v49 = v48 % 64
    if v48 >= 64 then
        processBlocks(v47, v46, 1, v48 - v49)
    end
    local v50 = v49 + 32
    local v51 = bit32.band(v50, 4294967232)
    local v52 = {}
    local v53
    if v49 == 0 then
        v53 = ""
    else
        local v54 = -v49
        v53 = string.sub(v46, v54)
    end
    local v55 = string.rep("\000", (v51 - v49 - 9) % 64)
    v52[1] = v53
    v52[2] = "\128"
    v52[3] = v55
    v52[4] = string.pack(">L", v48 * 8)
    local v56 = table.concat(v52)
    processBlocks(v47, v56, 1, #v56)
    local v57 = buffer.create(20)
    local v58 = v47[1]
    local v59 = bit32.byteswap(v58)
    buffer.writeu32(v57, 0, v59)
    local v60 = v47[2]
    local v61 = bit32.byteswap(v60)
    buffer.writeu32(v57, 4, v61)
    local v62 = v47[3]
    local v63 = bit32.byteswap(v62)
    buffer.writeu32(v57, 8, v63)
    local v64 = v47[4]
    local v65 = bit32.byteswap(v64)
    buffer.writeu32(v57, 12, v65)
    local v66 = v47[5]
    local v67 = bit32.byteswap(v66)
    buffer.writeu32(v57, 16, v67)
    return v57
end

local v68 = {
    Name = "SHA-1",
    BlockSize = 64,
    OutputSize = 20,
    Digest = function(v69) -- Digest | line 146
        return buffer.tostring(sha1(v69))
    end,
    DigestBuffer = function(v70) -- DigestBuffer | line 149
        return sha1(buffer.tostring(v70))
    end,
    DigestToBuffer = sha1
}
table.freeze(v68)
return v68
