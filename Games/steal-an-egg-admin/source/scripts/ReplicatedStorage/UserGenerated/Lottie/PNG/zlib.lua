-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    15,
    17,
    19,
    23,
    27,
    31,
    35,
    43,
    51,
    59,
    67,
    83,
    99,
    115,
    131,
    163,
    195,
    227,
    258
}
local v2 = {
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
    4,
    5,
    5,
    5,
    5,
    0
}
local v3 = {
    1,
    2,
    3,
    4,
    5,
    7,
    9,
    13,
    17,
    25,
    33,
    49,
    65,
    97,
    129,
    193,
    257,
    385,
    513,
    769,
    1025,
    1537,
    2049,
    3073,
    4097,
    6145,
    8193,
    12289,
    16385,
    24577
}
local v4 = {
    0,
    0,
    0,
    1,
    1,
    2,
    2,
    3,
    3,
    4,
    4,
    5,
    5,
    6,
    6,
    7,
    7,
    8,
    8,
    9,
    9,
    10,
    10,
    11,
    11,
    12,
    12,
    13,
    13
}
local v5 = {
    16,
    17,
    18,
    0,
    8,
    7,
    9,
    6,
    10,
    5,
    11,
    4,
    12,
    3,
    13,
    2,
    14,
    1,
    15
}
local v6 = {
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8
}

local function createHuffmanTable(v7) -- line 435
    local v8 = table.create(15, 0)
    v8[0] = 0
    for v9, v10 in v7 do
        if v10 > 0 then
            v8[v10] = (v8[v10] or 0) + 1
        end
    end
    local v11 = table.create(15)
    local v12 = 1
    for v13 = 1, 15 do
        local v14 = v12 + v8[v13 - 1]
        v12 = bit32.lshift(v14, 1)
        v11[v13] = v12
    end
    local v15 = {}
    local v16 = {}
    local v17 = {}
    for v18, v19 in v7 do
        if v19 > 0 then
            v15[v11[v19]] = v18 - 1
            local v20 = v18 - 1
            local v21 = v11[v19]
            v16[v20] = bit32.extract(v21, 0, v19)
            v17[v18 - 1] = v19
            v11[v19] += 1
        end
    end
    return v15, v16, v17
end

local v22 = {}
local v23 = {}
local v24 = {}
for v25 = 3, 258 do
    local v26 = #v1
    local v27
    for v28 = v26, 1, -1 do
        if v1[v28] <= v25 then
            v27 = v28
            break
        end
        v27 = nil
    end
    v22[v25] = 256 + v27
    v23[v25] = v25 - v1[v27]
    v24[v25] = v2[v27 - 8] or 0
end
local v29 = {}
for v30 = 1, 1024 do
    local v31 = #v3
    local v32
    for v33 = v31, 1, -1 do
        if v3[v33] <= v30 then
            v32 = v33
            break
        end
        v32 = nil
    end
    v29[v30] = v32
end
local v34, v35, v36 = createHuffmanTable(v6)
local v37, v38, v39 = createHuffmanTable(table.create(32, 5))

local function getStoreSize(v40) -- line 506
    local v41 = v40 / 32768
    return math.ceil(v41) * 5 + v40
end

local function getDistIdx(v42) -- line 509 | captures: v29
    if v42 < 1025 then
        return v29[v42]
    end
    if v42 < 1537 then
        return 21
    end
    if v42 < 2049 then
        return 22
    end
    if v42 < 3073 then
        return 23
    end
    if v42 < 4097 then
        return 24
    end
    if v42 < 6145 then
        return 25
    end
    if v42 < 8193 then
        return 26
    end
    if v42 < 12289 then
        return 27
    end
    if v42 < 16385 then
        return 28
    end
    if v42 < 24577 then
        return 29
    end
    return 30
end

local function adler32(v43, v44, v45) -- line 542
    local v46 = v44 + v45 - 1
    local v47 = 1
    local v48 = 0
    local v49 = 0
    for v50 = v44, v46 do
        v47 += buffer.readu8(v43, v50)
        v48 += v47
        v49 += 1
        if v49 == 8400000 then
            v47, v48, v49 = v47 % 65521, v48 % 65521, 0
        end
    end
    local v51 = v48 % 65521
    local v52 = bit32.lshift(v51, 16)
    local v53 = v47 % 65521
    return (bit32.bor(v52, v53))
end

local v54 = {}

function v54.inflate(v55, v56) -- line 563 | captures: v1, v2, v3, v4, v5, createHuffmanTable, v34, v37, adler32
    local v57 = buffer.readu8(v55, 0)
    local v58 = buffer.readu8(v55, 1)
    local v59 = bit32.extract(v57, 0, 4) == 8
    assert(v59, "invalid zlib comp method")
    v59 = bit32.extract(v57, 4, 4) <= 7
    assert(v59, "invalid zlib window size")
    v59 = bit32.extract(v58, 5, 1) == 0
    assert(v59, "preset dictionary is not allowed")
    local v60 = bit32.lshift(v57, 8)
    v59 = bit32.bor(v60, v58) % 31 == 0
    assert(v59, "zlib header sum mismatch")
    local v61 = 2
    local v62 = 0

    local function readBit() -- line 579 | captures: v61, v62, v55
        local v63 = v61
        local v64 = buffer.readu8(v55, v63)
        local v65 = v62
        local v66 = bit32.extract(v64, v65)
        v62 += 1
        if v62 == 8 then
            v62 = 0
            v61 += 1
        end
        return v66
    end

    local function readBits(v67) -- line 589 | captures: v61, v62, v55
        local v68 = buffer.readbits(v55, v61 * 8 + v62, v67)
        v62 += v67
        local v69 = v61
        local v70 = v62
        v61 = v69 + bit32.rshift(v70, 3)
        local v71 = v62
        v62 = bit32.band(v71, 7)
        return v68
    end

    local function readHuffmanTable(v72) -- line 596 | captures: v61, v62, v55
        local v73 = v61
        local v74 = buffer.readu8(v55, v73)
        local v75 = v62
        local v76 = bit32.extract(v74, v75)
        v62 += 1
        if v62 == 8 then
            v62 = 0
            v61 += 1
        end
        local v77 = v76 + 2
        while true do
            if v72[v77] then
                break
            end
            local v78 = v61
            local v79 = buffer.readu8(v55, v78)
            local v80 = v62
            local v81 = bit32.extract(v79, v80)
            v62 += 1
            if v62 == 8 then
                v62 = 0
                v61 += 1
            end
            v77 = v77 * 2 + v81
        end
        return v72[v77]
    end

    local v82 = 0
    local v83, v84
    while true do
        local v85 = v61
        v83 = buffer.readu8(v55, v85)
        local v86 = v62
        v83 = bit32.extract(v83, v86)
        v62 += 1
        if v62 == 8 then
            v62 = 0
            v61 += 1
        end
        local v87 = v61 * 8 + v62
        local v88 = buffer.readbits(v55, v87, 2)
        v62 += 2
        local v89 = v62
        local v90 = bit32.rshift(v89, 3)
        local v91 = v61 + v90
        v61 = v91
        local v92 = v62
        v62 = bit32.band(v92, 7)
        local v93 = v88 ~= 3
        assert(v93, "reserved btype")
        if v88 == 0 then
            if v62 > 0 then
                v61 += 1
                v62 = 0
            end
            local v94 = v61
            v88 = buffer.readu16(v55, v94)
            local v95 = v61 + 2
            local v96 = buffer.readu16(v55, v95)
            v87 = bit32.bxor(v88, v96) == 65535
            assert(v87, "len ~= nlen")
            v61 += 4
            buffer.copy(nil, v82, v55, v61, v88)
            v84 = v82 + v88
            v61 += v88
        else
            local v97 = v34
            v93 = v37
            local v98, v99
            if v88 == 2 then
                v88 = buffer.readbits(v55, v61 * 8 + v62, 5)
                v62 += 5
                local v100 = v62
                v90 = bit32.rshift(v100, 3)
                v61 += v90
                local v101 = v62
                v62 = bit32.band(v101, 7)
                v87 = v88 + 257
                v88 = buffer.readbits(v55, v61 * 8 + v62, 5)
                v62 += 5
                local v102 = v62
                v90 = bit32.rshift(v102, 3)
                v61 += v90
                local v103 = v62
                v62 = bit32.band(v103, 7)
                v98 = v88 + 1
                v90 = buffer.readbits(v55, v61 * 8 + v62, 4)
                v62 += 4
                local v104 = v62
                v88 = bit32.rshift(v104, 3)
                v91 = v61 + v88
                v61 = v91
                local v105 = v62
                v62 = bit32.band(v105, 7)
                v88 = table.create(19, 0)
                v99 = v90 + 4
                local v106
                for v107 = 1, v99 do
                    v106 = v5[v107] + 1
                    local v108 = buffer.readbits(v55, v61 * 8 + v62, 3)
                    v62 += 3
                    local v109 = v62
                    local v110 = bit32.rshift(v109, 3)
                    v91 = v61 + v110
                    v61 = v91
                    local v111 = v62
                    v62 = bit32.band(v111, 7)
                    v88[v106] = v108
                end
                v88 = createHuffmanTable(v88)
                v90 = table.create(v87)
                local v112, v113, v114, v115, v116
                while true do
                    local v117 = v61
                    v113 = buffer.readu8(v55, v117)
                    local v118 = v62
                    v113 = bit32.extract(v113, v118)
                    v62 += 1
                    if v62 == 8 then
                        v62 = 0
                        v114 = v61 + 1
                        v61 = v114
                    else
                        v114 = v91
                    end
                    v116 = 2 + v113
                    while not v88[v116] do
                        local v119 = v61
                        v113 = buffer.readu8(v55, v119)
                        local v120 = v62
                        v113 = bit32.extract(v113, v120)
                        v62 += 1
                        if v62 == 8 then
                            v62 = 0
                            v114 = v61 + 1
                            v61 = v114
                        end
                        v116 = 2 * v116 + v113
                    end
                    v106 = v88[v116]
                    if v106 <= 15 then
                        v112 = v106
                        v116 = 1
                    elseif v106 == 16 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 2)
                        v62 += 2
                        local v121 = v62
                        v115 = bit32.rshift(v121, 3)
                        v114 = v61 + v115
                        v61 = v114
                        local v122 = v62
                        v62 = bit32.band(v122, 7)
                        v116 = v113 + 3
                    elseif v106 == 17 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 3)
                        v62 += 3
                        local v123 = v62
                        v115 = bit32.rshift(v123, 3)
                        v114 = v61 + v115
                        v61 = v114
                        local v124 = v62
                        v62 = bit32.band(v124, 7)
                        v112, v116 = 0, v113 + 3
                    elseif v106 == 18 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 7)
                        v62 += 7
                        local v125 = v62
                        v115 = bit32.rshift(v125, 3)
                        v114 = v61 + v115
                        v61 = v114
                        local v126 = v62
                        v62 = bit32.band(v126, 7)
                        v112, v116 = 0, v113 + 11
                    else
                        v116 = 1
                    end
                    for v127 = 1, v116 do
                        table.insert(v90, v112)
                    end
                    if v87 <= #v90 then
                        break
                    end
                    v91 = v114
                end
                v97 = createHuffmanTable(v90)
                v90 = table.create(v98)
                v116 = nil
                v91 = v114
                local v128, v129
                while true do
                    local v130 = v61
                    v113 = buffer.readu8(v55, v130)
                    local v131 = v62
                    v113 = bit32.extract(v113, v131)
                    v128 = v62 + 1
                    v62 = v128
                    if v62 == 8 then
                        v62 = 0
                        v129 = v61 + 1
                        v61 = v129
                        v128 = 0
                    else
                        v129 = v91
                    end
                    local v132 = 2 + v113
                    while not v88[v132] do
                        local v133 = v61
                        v113 = buffer.readu8(v55, v133)
                        local v134 = v62
                        v113 = bit32.extract(v113, v134)
                        v128 = v62 + 1
                        v62 = v128
                        if v62 == 8 then
                            v62 = 0
                            v129 = v61 + 1
                            v61 = v129
                            v128 = 0
                        end
                        v132 = 2 * v132 + v113
                    end
                    local v135 = v88[v132]
                    if v135 <= 15 then
                        v116 = v135
                        v132 = 1
                    elseif v135 == 16 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 2)
                        v62 += 2
                        local v136 = v62
                        v115 = bit32.rshift(v136, 3)
                        v129 = v61 + v115
                        v61 = v129
                        local v137 = v62
                        v128 = bit32.band(v137, 7)
                        v62 = v128
                        v132 = v113 + 3
                    elseif v135 == 17 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 3)
                        v62 += 3
                        local v138 = v62
                        v115 = bit32.rshift(v138, 3)
                        v129 = v61 + v115
                        v61 = v129
                        local v139 = v62
                        v128 = bit32.band(v139, 7)
                        v62 = v128
                        v116, v132 = 0, v113 + 3
                    elseif v135 == 18 then
                        v113 = buffer.readbits(v55, v61 * 8 + v62, 7)
                        v62 += 7
                        local v140 = v62
                        v115 = bit32.rshift(v140, 3)
                        v129 = v61 + v115
                        v61 = v129
                        local v141 = v62
                        v128 = bit32.band(v141, 7)
                        v62 = v128
                        v116, v132 = 0, v113 + 11
                    else
                        v132 = 1
                    end
                    for v142 = 1, v132 do
                        table.insert(v90, v116)
                    end
                    if v98 <= #v90 then
                        break
                    end
                    v91 = v129
                end
                v93, v91 = createHuffmanTable(v90), v129, v128
            end
            while true do
                local v143 = v61
                v88 = buffer.readu8(v55, v143)
                local v144 = v62
                v88 = bit32.extract(v88, v144)
                local v145 = v62 + 1
                v62 = v145
                if v62 == 8 then
                    v62 = 0
                    v91 = v61 + 1
                    v61 = v91
                    v145 = 0
                end
                local v146 = 2 + v88
                while not v97[v146] do
                    local v147 = v61
                    v88 = buffer.readu8(v55, v147)
                    local v148 = v62
                    v88 = bit32.extract(v88, v148)
                    v145 = v62 + 1
                    v62 = v145
                    if v62 == 8 then
                        v62 = 0
                        v91 = v61 + 1
                        v61 = v91
                        v145 = 0
                    end
                    v146 = 2 * v146 + v88
                end
                v87 = v97[v146]
                local v149, v150
                if v87 < 256 then
                    buffer.writeu8(nil, v82, v87)
                    local v151
                    v149, v151, v150 = v91, v145, v82 + 1
                elseif v87 > 256 then
                    v98 = v1[v87 - 256]
                    local v152
                    if v87 > 268 then
                        v152 = v2[v87 - 264]
                        v88 = buffer.readbits(v55, v61 * 8 + v62, v152)
                        v62 += v152
                        local v153 = v62
                        v90 = bit32.rshift(v153, 3)
                        v91 = v61 + v90
                        v61 = v91
                        local v154 = v62
                        v62 = bit32.band(v154, 7)
                        v98 += v88
                    elseif v87 > 264 then
                        local v155 = v61
                        v88 = buffer.readu8(v55, v155)
                        local v156 = v62
                        v88 = bit32.extract(v88, v156)
                        v62 += 1
                        if v62 == 8 then
                            v62 = 0
                            v91 = v61 + 1
                            v61 = v91
                        end
                        v98 += v88
                    end
                    local v157 = v61
                    v88 = buffer.readu8(v55, v157)
                    local v158 = v62
                    v88 = bit32.extract(v88, v158)
                    v145 = v62 + 1
                    v62 = v145
                    if v62 == 8 then
                        v62 = 0
                        v91 = v61 + 1
                        v61 = v91
                        v145 = 0
                    end
                    v99 = 2 + v88
                    while not v93[v99] do
                        local v159 = v61
                        v88 = buffer.readu8(v55, v159)
                        local v160 = v62
                        v88 = bit32.extract(v88, v160)
                        v145 = v62 + 1
                        v62 = v145
                        if v62 == 8 then
                            v62 = 0
                            v91 = v61 + 1
                            v61 = v91
                            v145 = 0
                        end
                        v99 = 2 * v99 + v88
                    end
                    v146 = v93[v99]
                    v152 = v3[v146 + 1]
                    if v146 > 5 then
                        local v161 = v4[v146]
                        v88 = buffer.readbits(v55, v61 * 8 + v62, v161)
                        v62 += v161
                        local v162 = v62
                        v90 = bit32.rshift(v162, 3)
                        v91 = v61 + v90
                        v61 = v91
                        local v163 = v62
                        v145 = bit32.band(v163, 7)
                        v62 = v145
                        v152 += v88
                    elseif v146 > 3 then
                        local v164 = v61
                        v88 = buffer.readu8(v55, v164)
                        local v165 = v62
                        v88 = bit32.extract(v88, v165)
                        v145 = v62 + 1
                        v62 = v145
                        if v62 == 8 then
                            v62 = 0
                            v91 = v61 + 1
                            v61 = v91
                            v145 = 0
                        end
                        v152 += v88
                    end
                    if v152 < v98 then
                        while true do
                            v88 = math.min(v98, v152)
                            buffer.copy(nil, v82, nil, v82 - v152, v88)
                            v82 += v88
                            v98 -= v88
                            v152 += v88
                            if v98 == 0 then
                                v149 = v91
                                v150 = v82
                                break
                            end
                        end
                    else
                        buffer.copy(nil, v82, nil, v82 - v152, v98)
                        local v166
                        v149, v166, v150 = v91, v145, v82 + v98
                    end
                else
                    v149 = v91
                    v150 = v82
                end
                if v87 == 256 then
                    v84 = v150
                    break
                end
                v91 = v149
                v82 = v150
            end
        end
        if v83 == 1 then
            break
        end
        v82 = v84
    end
    if v62 > 0 then
        v61 += 1
    end
    v83 = adler32(nil, 0, buffer.len(nil))
    local v167 = v61
    local v168 = buffer.readu32(v55, v167)
    local v169 = v83 == bit32.byteswap(v168)
    assert(v169, "adler-32 checksum mismatch")
    return v84
end

function v54.deflate(v170) -- line 906 | captures: v3, v4, v22, v23, v24, v29, v35, v36, v38, v39, adler32
    local v171 = buffer.len(v170)
    local create = buffer.create
    local v172 = v171 / 32768
    local v173 = create(math.ceil(v172) * 5 + v171 + 6)
    buffer.writeu16(v173, 0, 24184)
    local v174 = 2
    local v175 = 0

    local function writeBits(v176, v177) -- line 913 | captures: v174, v175, v173
        buffer.writebits(v173, v174 * 8 + v175, v177, v176)
        v175 += v177
        local v178 = v174
        local v179 = v175
        v174 = v178 + bit32.rshift(v179, 3)
        local v180 = v175
        v175 = bit32.band(v180, 7)
    end

    local function writeHuffmanBits(v181, v182) -- line 919 | captures: v174, v175, v173
        local v183 = bit32.rshift(v181, 1)
        local v184 = bit32.band(v183, 1431655765)
        local v185 = bit32.lshift(v181, 1)
        local v186 = bit32.band(v185, 2863311530)
        local v187 = bit32.bor(v184, v186)
        local v188 = bit32.rshift(v187, 2)
        local v189 = bit32.band(v188, 858993459)
        local v190 = bit32.lshift(v187, 2)
        local v191 = bit32.band(v190, 3435973836)
        local v192 = bit32.bor(v189, v191)
        local v193 = bit32.rshift(v192, 4)
        local v194 = bit32.band(v193, 252645135)
        local v195 = bit32.lshift(v192, 4)
        local v196 = bit32.band(v195, 4042322160)
        local v197 = bit32.bor(v194, v196)
        local v198 = bit32.rshift(v197, 8)
        local v199 = bit32.band(v198, 16711935)
        local v200 = bit32.lshift(v197, 8)
        local v201 = bit32.band(v200, 4278255360)
        local v202 = bit32.bor(v199, v201)
        local v203 = bit32.rshift(v202, 16)
        local v204 = bit32.lshift(v202, 16)
        local v205 = bit32.bor(v203, v204)
        local v206 = 32 - v182
        local v207 = bit32.rshift(v205, v206)
        local writebits = buffer.writebits
        local v208 = v174 * 8 + v175
        local v209 = bit32.lshift(1, v182) - 1
        writebits(v173, v208, v182, (bit32.band(v207, v209)))
        v175 += v182
        local v210 = v174
        local v211 = v175
        v174 = v210 + bit32.rshift(v211, 3)
        local v212 = v175
        v175 = bit32.band(v212, 7)
    end

    local function writeLitOrLen(v213) -- line 943 | captures: writeHuffmanBits, v35, v36
        writeHuffmanBits(v35[v213], v36[v213])
    end

    local function writeBackRef(v214, v215) -- line 946 | captures: v174, v175, v173, writeHuffmanBits, v3, v4, v22, v23, v24, v29, v35, v36, v38, v39
        local v216 = v22[v215]
        writeHuffmanBits(v35[v216], v36[v216])
        if v215 > 10 then
            local v217 = v24[v215]
            buffer.writebits(v173, v174 * 8 + v175, v217, v23[v215])
            v175 += v217
            local v218 = v174
            local v219 = v175
            v174 = v218 + bit32.rshift(v219, 3)
            local v220 = v175
            v175 = bit32.band(v220, 7)
        end
        local v221
        if v214 < 1025 then
            v221 = v29[v214]
        elseif v214 < 1537 then
            v221 = 21
        elseif v214 < 2049 then
            v221 = 22
        elseif v214 < 3073 then
            v221 = 23
        elseif v214 < 4097 then
            v221 = 24
        elseif v214 < 6145 then
            v221 = 25
        elseif v214 < 8193 then
            v221 = 26
        elseif v214 < 12289 then
            v221 = 27
        elseif v214 < 16385 then
            v221 = 28
        elseif v214 < 24577 then
            v221 = 29
        else
            v221 = 30
        end
        local v222 = v38[v221 - 1]
        writeHuffmanBits(v222, v39[v221 - 1])
        if not (v221 > 3) then
            return
        end
        local v223 = v4[v221 - 1]
        buffer.writebits(v173, v174 * 8 + v175, v223, v214 - v3[v221])
        v175 += v223
        local v224 = v174
        local v225 = v175
        v174 = v224 + bit32.rshift(v225, 3)
        local v226 = v175
        v175 = bit32.band(v226, 7)
    end

    local function getLitOrLenSize(v227) -- line 967 | captures: v36
        return v36[v227]
    end

    local function getBackRefSize(v228, v229) -- line 970 | captures: v4, v22, v24, v29, v36, v39
        local v230
        if v228 < 1025 then
            v230 = v29[v228]
        elseif v228 < 1537 then
            v230 = 21
        elseif v228 < 2049 then
            v230 = 22
        elseif v228 < 3073 then
            v230 = 23
        elseif v228 < 4097 then
            v230 = 24
        elseif v228 < 6145 then
            v230 = 25
        elseif v228 < 8193 then
            v230 = 26
        elseif v228 < 12289 then
            v230 = 27
        elseif v228 < 16385 then
            v230 = 28
        elseif v228 < 24577 then
            v230 = 29
        else
            v230 = 30
        end
        return v36[v22[v229]] + v24[v229] + v39[v230 - 1] + (v4[v230 - 1] or 0)
    end

    local v231 = {}
    local v232 = {}
    local v233 = {}
    local v234 = 0

    local function insertNode(v235, v236) -- line 978 | captures: v234, v231, v232
        v234 += 1
        v231[v234] = v235
        v232[v234] = v236
        return v234
    end

    local function clearTables() -- line 984 | captures: v234, v231, v232, v233
        table.clear(v231)
        table.clear(v232)
        table.clear(v233)
        v234 = 0
    end

    local v237 = v171 - 1
    for v238 = 0, v237, 32768 do
        local v239 = v238 + 32768
        local v240 = math.min(v171, v239)
        local v241 = {}
        local v242 = 0
        local v243 = v238
        local v244, v245
        while true do
            if v243 < v240 - 3 then
                local v246 = buffer.readu32(v170, v243)
                local v247 = bit32.band(v246, 16777215)
                v234 += 1
                v231[v234] = v243
                local v248 = v233[v247] or 0
                v232[v234] = v248
                local v249 = v234
                v233[v247] = v249
                local v250, v251, v252, v253 = 0, -1, 0, v232[v249]
                local v254, v255
                while true do
                    if v253 then
                        if (v231[v253] or (-1/0)) < v243 - 32510 then
                            v254 = v250
                            v255 = v251
                            break
                        end
                        if v252 >= 12 then
                            v254 = v250
                            v255 = v251
                            break
                        end
                        if v250 >= 96 then
                            v254 = v250
                            v255 = v251
                            break
                        end
                        local v256 = v231[v253]
                        local v257 = v243 + 258
                        local v258 = math.min(v240, v257)
                        local v259
                        if v243 + v250 < v258 then
                            local v260 = v256 + v250
                            local v261 = buffer.readu8(v170, v260)
                            local v262 = v243 + v250
                            v259 = v261 ~= buffer.readu8(v170, v262)
                        else
                            v259 = false
                        end
                        local v263 = 3
                        while not v259 do
                            if not (v263 >= 258) and not (v240 <= v243 + v263) then
                                local v264 = v256 + v263
                                local v265 = buffer.readu8(v170, v264)
                                local v266 = v243 + v263
                                if v265 == buffer.readu8(v170, v266) then
                                    v263 += 1
                                    continue
                                end
                            end
                            break
                        end
                        if v250 < v263 then
                            if v263 >= 258 then
                                v254 = v263
                                v255 = v256
                                break
                            end
                            v250 = v263
                            v251 = v256
                        end
                        v253 = v232[v253]
                        v252 += 1
                        continue
                    end
                    v254 = v250
                    v255 = v251
                    break
                end
                if v254 == 0 then
                    local v267 = buffer.readu8(v170, v243)
                    v242 += v36[v267]
                    local v268 = vector.create(0, v267)
                    table.insert(v241, v268)
                    v243 += 1
                else
                    local v269 = v243 - v255
                    local v270
                    if v269 < 1025 then
                        v270 = v29[v269]
                    elseif v269 < 1537 then
                        v270 = 21
                    elseif v269 < 2049 then
                        v270 = 22
                    elseif v269 < 3073 then
                        v270 = 23
                    elseif v269 < 4097 then
                        v270 = 24
                    elseif v269 < 6145 then
                        v270 = 25
                    elseif v269 < 8193 then
                        v270 = 26
                    elseif v269 < 12289 then
                        v270 = 27
                    elseif v269 < 16385 then
                        v270 = 28
                    elseif v269 < 24577 then
                        v270 = 29
                    else
                        v270 = 30
                    end
                    v242 += v36[v22[v254]] + v24[v254] + v39[v270 - 1] + (v4[v270 - 1] or 0)
                    local v271 = v243 - v255
                    local v272 = vector.create(1, v271, v254)
                    table.insert(v241, v272)
                    local v273 = v243 + v254 - 1
                    local v274 = v240 - 4
                    local v275 = math.min(v273, v274)
                    local v276 = v243 + 1
                    for v277 = v276, v275 do
                        local v278 = buffer.readu32(v170, v277)
                        local v279 = bit32.band(v278, 16777215)
                        v234 += 1
                        v231[v234] = v277
                        local v280 = v233[v279] or 0
                        v232[v234] = v280
                        v233[v279] = v234
                    end
                    v243 += v254
                end
                continue
            end
            v245 = v242
            v244 = v243
            break
        end
        while v244 < v240 do
            local v281 = buffer.readu8(v170, v244)
            v245 += v36[v281]
            local v282 = vector.create(0, v281)
            table.insert(v241, v282)
            v244 += 1
        end
        local v283 = vector.create(0, 256, 0)
        table.insert(v241, v283)
        if v240 == v171 then
            buffer.writebits(v173, v174 * 8 + v175, 1, 1)
            v175 += 1
            local v284 = v175
            local v285 = bit32.rshift(v284, 3)
            v174 += v285
            local v286 = v175
            v175 = bit32.band(v286, 7)
        else
            buffer.writebits(v173, v174 * 8 + v175, 1, 0)
            v175 += 1
            local v287 = v175
            local v288 = bit32.rshift(v287, 3)
            v174 += v288
            local v289 = v175
            v175 = bit32.band(v289, 7)
        end
        local v290 = v240 - v238
        local v291 = (v245 + v36[256]) / 8
        local v292 = math.ceil(v291) + 1
        local v293 = v290 / 32768
        if math.ceil(v293) * 5 + v290 <= v292 then
            buffer.writebits(v173, v174 * 8 + v175, 2, 0)
            v175 += 2
            local v294 = v175
            local v295 = bit32.rshift(v294, 3)
            v174 += v295
            local v296 = v175
            v175 = bit32.band(v296, 7)
            if v175 > 0 then
                v174 += 1
                v175 = 0
            end
            local v297 = v174
            buffer.writeu16(v173, v297, v290)
            local v298 = v174 + 2
            local v299 = bit32.bxor(65535, v290)
            buffer.writeu16(v173, v298, v299)
            buffer.copy(v173, v174 + 4, v170, v238, v290)
            local v300 = v290 + 4
            v174 += v300
        else
            buffer.writebits(v173, v174 * 8 + v175, 2, 1)
            v175 += 2
            local v301 = v175
            local v302 = bit32.rshift(v301, 3)
            v174 += v302
            local v303 = v175
            v175 = bit32.band(v303, 7)
            for v304, v305 in v241 do
                if v305.x == 0 then
                    local y = v305.y
                    writeHuffmanBits(v35[y], v36[y])
                else
                    writeBackRef(v305.y, v305.z)
                end
            end
        end
        if v234 > 50000 then
            table.clear(v231)
            table.clear(v232)
            table.clear(v233)
            v234 = 0
        end
    end
    if v175 > 0 then
        v174 += 1
    end
    local v306 = adler32(v170, 0, buffer.len(v170))
    local v307 = bit32.byteswap(v306)
    local v308 = v174
    buffer.writeu32(v173, v308, v307)
    return v173, v174 + 4
end

return v54
