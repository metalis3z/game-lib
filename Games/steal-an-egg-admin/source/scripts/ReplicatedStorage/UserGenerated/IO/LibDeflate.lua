-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local byte = string.byte
local char = string.char
local find = string.find
local gsub = string.gsub
local sub = string.sub
local concat = table.concat
local sort = table.sort
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = {}
local v7 = {}
local v8 = {}
local v9 = {}
local v10 = {}
local v11 = {
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
local v12 = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
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
local v13 = {}

v13[0] = 1
v13[1] = 2
v13[2] = 3
v13[3] = 4
v13[4] = 5
v13[5] = 7
v13[6] = 9
v13[7] = 13
v13[8] = 17
v13[9] = 25
v13[10] = 33
v13[11] = 49
v13[12] = 65
v13[13] = 97
v13[14] = 129
v13[15] = 193
v13[16] = 257
v13[17] = 385
v13[18] = 513
v13[19] = 769
v13[20] = 1025
v13[21] = 1537
v13[22] = 2049
v13[23] = 3073
v13[24] = 4097
v13[25] = 6145
v13[26] = 8193
v13[27] = 12289
v13[28] = 16385
v13[29] = 24577

local v14 = {}

v14[0] = 0
v14[1] = 0
v14[2] = 0
v14[3] = 0
v14[4] = 1
v14[5] = 1
v14[6] = 2
v14[7] = 2
v14[8] = 3
v14[9] = 3
v14[10] = 4
v14[11] = 4
v14[12] = 5
v14[13] = 5
v14[14] = 6
v14[15] = 6
v14[16] = 7
v14[17] = 7
v14[18] = 8
v14[19] = 8
v14[20] = 9
v14[21] = 9
v14[22] = 10
v14[23] = 10
v14[24] = 11
v14[25] = 11
v14[26] = 12
v14[27] = 12
v14[28] = 13
v14[29] = 13

local v15 = {
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
local v16 = {}
local v17 = {}
local v18 = {}
local v19 = {}
local v20 = {}
local v21 = {}
local v22 = {}
local v23 = {}
for v24 = 0, 255 do
    v3[v24] = char(v24)
end
local v25 = 1
for v26 = 0, 32 do
    v2[v26] = v25
    v25 *= 2
end
local v27, v28, v29
for v30 = 1, 9 do
    v4[v30] = {}
    v29 = v2[v30 + 1] - 1
    for v31 = 0, v29 do
        local v32 = 0
        v28 = v31
        for v33 = 1, v30 do
            if v32 % 2 == 1 then
                v27 = 1
            elseif v28 % 2 ~= 1 then
                v27 = 0
            end
            v32 = v32 - v32 % 2 + v27
            v28 = (v28 - v28 % 2) / 2
            v32 *= 2
        end
        v4[v30][v31] = (v32 - v32 % 2) / 2
    end
end
v29 = 1
v25 = 18
local v34 = 16
local v35 = 265
local v36, v37, v38, v39
for v40 = 3, 258 do
    if v40 <= 10 then
        v5[v40] = v40 + 254
        v7[v40] = 0
    elseif v40 == 258 then
        v5[v40] = 285
        v7[v40] = 0
    else
        if v25 < v40 then
            v36 = v25 + v34
            v37 = v34 * 2
            v38 = v35 + 4
            v39 = v29 + 1
        else
            v39 = v29
            v36 = v25
            v37 = v34
            v38 = v35
        end
        v28 = v40 - v36 - 1 + v37 / 2
        v5[v40] = (v28 - v28 % (v37 / 8)) / (v37 / 8) + v38
        v7[v40] = v39
        v6[v40] = v28 % (v37 / 8)
        v29 = v39
        v25 = v36
        v34 = v37
        v35 = v38
    end
end
v8[1] = 0
v8[2] = 1
v10[1] = 0
v10[2] = 0
v39 = 0
v36 = 3
v37 = 4
v38 = 2
for v41 = 3, 256 do
    if v37 < v41 then
        v36 *= 2
        v37 *= 2
        v38 += 2
        v39 += 1
    end
    if v36 < v41 then
        v28 = v38 + 1
    else
        v28 = v38
    end
    v8[v41] = v28
    if v39 >= 0 then
        v28 = v39
    else
        v28 = 0
    end
    v10[v41] = v28
    if v37 >= 8 then
        v9[v41] = (v41 - v37 / 2 - 1) % (v37 / 4)
    end
end

function v1.Adler32(v42, v43) -- line 272 | captures: byte
    if type(v43) ~= "string" then
        local v44 = ("Usage: LibDeflate:Adler32(str): 'str' - string expected got '%s'."):format((type(v43)))
        error(v44, 2)
    end
    local v45 = #v43
    local v46 = 1
    local v47 = 1
    local v48 = 0
    local v49, v50, v51
    while true do
        if v46 <= v45 - 15 then
            local v52 = v46 + 15
            local v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68 = byte(v43, v46, v52)
            v48 = (v48 + v47 * 16 + v53 * 16 + 15 * v54 + 14 * v55 + 13 * v56 + 12 * v57 + 11 * v58 + 10 * v59 + 9 * v60 + 8 * v61 + 7 * v62 + 6 * v63 + 5 * v64 + 4 * v65 + 3 * v66 + 2 * v67 + v68) % 65521
            v47 = (v47 + v53 + v54 + v55 + v56 + v57 + v58 + v59 + v60 + v61 + v62 + v63 + v64 + v65 + v66 + v67 + v68) % 65521
            v46 += 16
            continue
        end
        v49 = v46
        v50 = v47
        v51 = v48
        break
    end
    while v49 <= v45 do
        v50 = (v50 + byte(v43, v49, v49)) % 65521
        v51 = (v51 + v50) % 65521
        v49 += 1
    end
    return (v51 * 65536 + v50) % 4294967296
end

local function IsEqualAdler32(v69, v70) -- line 295
    return v69 % 4294967296 == v70 % 4294967296
end

function v1.CreateDictionary(v71, v72, v73, v74) -- line 299 | captures: byte
    if type(v72) ~= "string" then
        local v75 = ("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - string expected got '%s'."):format((type(v72)))
        error(v75, 2)
    end
    if type(v73) ~= "number" then
        local v76 = ("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'strlen' - number expected got '%s'."):format((type(v73)))
        error(v76, 2)
    end
    if type(v74) ~= "number" then
        local v77 = ("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'adler32' - number expected got '%s'."):format((type(v74)))
        error(v77, 2)
    end
    if v73 ~= #v72 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'strlen' does not match the actual length of 'str'. 'strlen': %u, '#str': %u . Please check if 'str' is modified unintentionally."):format(v73, #v72))
    end
    if v73 == 0 then
        error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - Empty string is not allowed.", 2)
    end
    if v73 > 32768 then
        local v78 = ("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(v73)
        error(v78, 2)
    end
    local v79 = v71:Adler32(v72)
    if v74 % 4294967296 ~= v79 % 4294967296 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'adler32' does not match the actual adler32 of 'str'. 'adler32': %u, 'Adler32(str)': %u . Please check if 'str' is modified unintentionally."):format(v74, v79))
    end
    local v80 = {
        adler32 = v74,
        hash_tables = {},
        string_table = {},
        strlen = v73
    }
    local string_table = v80.string_table
    local hash_tables = v80.hash_tables
    string_table[1] = byte(v72, 1, 1)
    string_table[2] = byte(v72, 2, 2)
    if v73 >= 3 then
        local v81, v82 = 1, string_table[1] * 256 + string_table[2]
        local v83, v84
        while true do
            local v85, v86, v87, v88, v89
            if v81 <= v73 - 2 - 3 then
                local v90 = v81 + 2
                local v91 = v81 + 5
                local v92
                v92, v85, v86, v87 = byte(v72, v90, v91)
                string_table[v81 + 2] = v92
                string_table[v81 + 3] = v85
                string_table[v81 + 4] = v86
                string_table[v81 + 5] = v87
                v88 = (v82 * 256 + v92) % 16777216
                v89 = hash_tables[v88]
                if not v89 then
                    v89 = {}
                    hash_tables[v88] = v89
                end
            else
                v83 = v81
                v84 = v82
                break
            end
            v89[#v89 + 1] = v81 - v73
            local v93 = v81 + 1
            local v94 = (v88 * 256 + v85) % 16777216
            local v95 = hash_tables[v94]
            if not v95 then
                v95 = {}
                hash_tables[v94] = v95
            end
            v95[#v95 + 1] = v93 - v73
            local v96 = v93 + 1
            local v97 = (v94 * 256 + v86) % 16777216
            local v98 = hash_tables[v97]
            if not v98 then
                v98 = {}
                hash_tables[v97] = v98
            end
            v98[#v98 + 1] = v96 - v73
            local v99 = v96 + 1
            v82 = (v97 * 256 + v87) % 16777216
            local v100 = hash_tables[v82]
            if not v100 then
                v100 = {}
                hash_tables[v82] = v100
            end
            v100[#v100 + 1] = v99 - v73
            v81 = v99 + 1
        end
        while true do
            local v101, v102
            if v83 <= v73 - 2 then
                local v103 = v83 + 2
                local v104 = byte(v72, v103)
                string_table[v83 + 2] = v104
                v101 = (v84 * 256 + v104) % 16777216
                v102 = hash_tables[v101]
                if not v102 then
                    v102 = {}
                    hash_tables[v101] = v102
                end
            else
                break
            end
            v102[#v102 + 1] = v83 - v73
            v83 += 1
            v84 = v101
        end
    end
    return v80
end

local function IsValidDictionary(v105) -- line 393
    if not (v105 ~= nil and type(v105) == "table") then
        return false, ("'dictionary' - table expected got '%s'."):format((type(v105)))
    end
    local adler32 = v105.adler32
    if type(adler32) == "number" then
        local string_table = v105.string_table
        if type(string_table) == "table" then
            local strlen = v105.strlen
            if type(strlen) == "number" and not (v105.strlen <= 0) and not (v105.strlen > 32768) and v105.strlen == #v105.string_table then
                local hash_tables = v105.hash_tables
                if type(hash_tables) == "table" then
                    return true, ""
                end
            end
        end
    end
    return false, ("'%s' - corrupted dictionary."):format((type(v105)))
end

local v106 = {}

v106[0] = { false, nil, 0, 0, 0 }
v106[1] = { false, nil, 4, 8, 4 }
v106[2] = { false, nil, 5, 18, 8 }
v106[3] = { false, nil, 6, 32, 32 }
v106[4] = { true, 4, 4, 16, 16 }
v106[5] = { true, 8, 16, 32, 32 }
v106[6] = { true, 8, 16, 128, 128 }
v106[7] = { true, 8, 32, 128, 256 }
v106[8] = { true, 32, 128, 258, 1024 }
v106[9] = { true, 32, 258, 258, 4096 }

local function IsValidArguments(v107, v108, v109, v110, v111) -- line 475 | captures: IsValidDictionary, v106
    if type(v107) == "string" then
        local v112, v113, v114
        if v108 then
            v112, v113 = IsValidDictionary(v109)
        else
            local v115
            if v110 then
                v115 = type(v111)
                if v115 == "nil" then
                    if v115 == "table" then
                        assert(v111)
                        for v116, v117 in pairs(v111) do
                            if v116 ~= "level" and v116 ~= "strategy" then
                                return false, ("'configs' - unsupported table key in the configs: '%s'."):format(v116)
                            end
                            if v116 == "level" and not v106[v117] then
                                return false, ("'configs' - unsupported 'level': %s."):format((tostring(v117)))
                            end
                            if v116 == "strategy" and v117 ~= "fixed" and v117 ~= "huffman_only" and v117 ~= "dynamic" then
                                return false, ("'configs' - unsupported 'strategy': '%s'."):format((tostring(v117)))
                            end
                        end
                    end
                    return true, ""
                end
            else
                return true, ""
            end
            v114 = v115 == "table"
        end
        if v108 and v112 or not v108 and v114 then
            return
        end
        if v108 then
            return false, v113
        end
        return false, ("'configs' - nil or table expected got '%s'."):format((type(v111)))
    end
    return false, ("'str' - string expected got '%s'."):format((type(v107)))
end

local function CreateWriter() -- line 512 | captures: char, concat, v2, v3
    local v118 = 0
    local v119 = 0
    local v120 = 0
    local v121 = 0
    local v122 = {}
    local v123 = {}
    return function(v124, v125) -- line 519 | captures: v118, v119, v120, v121, v122, v2, v3
            v119 += v124 * v2[v120]
            v120 += v125
            v121 += v125
            if not (v120 >= 32) then
                return
            end
            v118 += 1
            v122[v118] = v3[v119 % 256] .. v3[(v119 - v119 % 256) / 256 % 256] .. v3[(v119 - v119 % 65536) / 65536 % 256] .. v3[(v119 - v119 % 16777216) / 16777216 % 256]
            local v126 = v2[32 - v120 + v125]
            v119 = (v124 - v124 % v126) / v126
            v120 -= 32
        end,
        function(v127) -- line 530 | captures: v118, v119, v120, v121, v122, char
            local v128 = v120
            for v129 = 1, v128, 8 do
                v118 += 1
                local v130 = v122
                local v131 = v118
                local v132 = v119 % 256
                v130[v131] = char(v132)
                v119 = (v119 - v119 % 256) / 256
            end
            v120 = 0
            v118 += 1
            v122[v118] = v127
            v121 += #v127 * 8
        end,
        function(v133) -- line 542 | captures: v118, v119, v120, v121, v122, v123, concat, v2, v3
            if v133 == 3 then
                return v121, nil
            end
            if v133 == 1 then
                local v134 = (8 - v120 % 8) % 8
                if v120 > 0 then
                    v119 = v119 - v2[v120] + v2[v120 + v134]
                    local v135 = v120
                    for v136 = 1, v135, 8 do
                        v118 += 1
                        v122[v118] = v3[v119 % 256]
                        v119 = (v119 - v119 % 256) / 256
                    end
                    v119 = 0
                    v120 = 0
                end
                if v133 == 2 then
                    v121 += v134
                    return v121, nil
                end
                local v137 = concat(v122)
                v122 = {}
                v118 = 0
                v123[#v123 + 1] = v137
            else
                if v133 == 2 then
                    return
                end
                local v138 = concat(v122)
                v122 = {}
                v118 = 0
                v123[#v123 + 1] = v138
            end
            if v133 == 0 then
                return v121, nil
            end
            return v121, concat(v123)
        end
end

local function MinHeapPush(v139, v140, v141) -- line 585
    local v142 = v141 + 1
    v139[v142] = v140
    local v143 = (v142 - v142 % 2) / 2
    while v143 >= 1 do
        local v144 = v140[1]
        if v139[v143][1] <= v144 then
            break
        end
        local v145 = v139[v143]
        v139[v143] = v140
        v139[v142] = v145
        v142, v143 = v143, (v143 - v143 % 2) / 2
    end
end

local function MinHeapPop(v146, v147) -- line 602
    local v148 = v146[1]
    local v149 = v146[v147]
    local v150 = v149[1]
    v146[1] = v149
    v146[v147] = v148
    local v151 = v147 - 1
    local v152 = 2
    local v153 = 2 + 1
    while true do
        local v154, v155, v156
        if v152 <= v151 then
            local v157 = v146[v152]
            if v153 <= v151 and v146[v153][1] < v157[1] then
                local v158 = v146[v153]
                if v150 <= v158[1] then
                    v156 = true
                else
                    v146[v153] = v149
                    v146[1] = v158
                    v154, v155 = v152, v153 * 2 + 1
                    v156 = false
                end
            elseif v150 <= v157[1] then
                v156 = true
            else
                v146[v152] = v149
                v146[1] = v157
                v154 = v152 * 2
                v155 = v154 + 1
                v156 = false
            end
        else
            v156 = true
        end
        if v156 then
            break
        end
        v152 = v154
        v153 = v155
    end
    return v148
end

local function GetHuffmanCodeFromBitlen(v159, v160, v161, v162) -- line 639 | captures: v4
    local v163 = {}
    local v164 = {}
    local v165 = 0
    for v166 = 1, v162 do
        v165 = (v165 + (v159[v166 - 1] or 0)) * 2
        v163[v166] = v165
    end
    local v167
    for v168 = 0, v161 do
        local v169 = v160[v168]
        if v169 then
            local v170 = v163[v169]
            v163[v169] = v170 + 1
            if v169 > 9 then
                local v171 = 0
                for v172 = 1, v169 do
                    if v171 % 2 == 1 then
                        v167 = 1
                    elseif v170 % 2 ~= 1 then
                        v167 = 0
                    end
                    local v173 = v171 - v171 % 2 + v167
                    v170 = (v170 - v170 % 2) / 2
                    v171 = v173 * 2
                end
                v164[v168] = (v171 - v171 % 2) / 2
            else
                v164[v168] = v4[v169][v170]
            end
        end
    end
    return v164
end

local function SortByFirstThenSecond(v174, v175) -- line 680
    local v176 = v174[1]
    if v175[1] <= v176 then
        if v174[1] == v175[1] then
            return v174[2] < v175[2]
        end
        return false
    end
    return true
end

local function GetHuffmanBitlenAndCode(v177, v178, v179) -- line 684 | captures: sort, MinHeapPush, MinHeapPop, GetHuffmanCodeFromBitlen, SortByFirstThenSecond
    local v180 = {}
    local v181 = {}
    local v182 = {}
    local v183 = {}
    local v184 = {}
    local v185 = 0
    for v186, v187 in pairs(v177) do
        v185 += 1
        v180[v185] = { v187, v186 }
    end
    if v185 == 0 then
        return {}, {}, -1
    end
    if v185 == 1 then
        local v188 = v180[1][2]
        v182[v188] = 1
        v183[v188] = 0
        return v182, v183, v188
    end
    sort(v180, SortByFirstThenSecond)
    for v189 = 1, v185 do
        v181[v189] = v180[v189]
    end
    while v185 > 1 do
        local v190 = MinHeapPop(v181, v185)
        local v191 = v185 - 1
        local v192 = MinHeapPop(v181, v191)
        local v193 = v191 - 1
        MinHeapPush(v181, {
            v190[1] + v192[1],
            -1,
            v190,
            v192
        }, v193)
        v185 = v193 + 1
    end
    local v194 = {}
    local v195 = {}
    local v196 = {}
    v194[1] = v181[1]
    v194[2] = {}
    v194[3] = v195
    v194[4] = v196
    v181[1][1] = 0
    local v197 = 0
    local v198 = -1
    local v199 = 1
    local v200 = 1
    while true do
        local v201, v202, v203, v204
        if v200 <= v199 then
            local v205 = v194[v200]
            v201 = v205[1]
            v202 = v205[2]
            local v206 = v205[3]
            v203 = v205[4]
            if v206 then
                v204 = v199 + 1
                v194[v204] = v206
                v206[1] = v201 + 1
            else
                v204 = v199
            end
        else
            break
        end
        if v203 then
            v199 = v204 + 1
            v194[v199] = v203
            v203[1] = v201 + 1
        else
            v199 = v204
        end
        v200 += 1
        local v207
        if v178 < v201 then
            v197 += 1
            v207 = v178
        else
            v207 = v201
        end
        if v202 >= 0 then
            v182[v202] = v207
            local v208 = if v202 <= v198 then v198 else v202
            v184[v207] = (v184[v207] or 0) + 1
            v198 = v208
        end
    end
    if v197 > 0 then
        local v209 = v178 - 1
        while true do
            if v184[v209] then
            end
            v209 -= 1
        end
    end
    return v182, GetHuffmanCodeFromBitlen(v184, v182, v179, v178), v198
end

local function RunLengthEncodeHuffmanBitlen(v210, v211, v212, v213) -- line 794
    local v214 = {}
    local v215 = {}
    local v216 = {}
    local v217 = if v213 >= 0 then v213 else 0
    local v218 = v211 + v217 + 1
    local v219 = v218 + 1
    local v220 = 0
    local v221 = 0
    local v222
    local v223 = 0
    for v224 = 0, v219 do
        local v225
        if v224 <= v211 then
            v225 = v210[v224] or 0
        elseif v218 < v224 then
        else
            v225 = v212[v224 - v211 - 1] or 0
        end
        if v225 == v222 then
            v223 += 1
            if v225 == 0 then
                if v223 == 138 then
                    v220 += 1
                    v214[v220] = 18
                    v221 += 1
                    v216[v221] = 127
                    v215[18] = (v215[18] or 0) + 1
                    v223 = 0
                end
            elseif v223 == 6 then
                v220 += 1
                v214[v220] = 16
                v221 += 1
                v216[v221] = 3
                v215[16] = (v215[16] or 0) + 1
                v223 = 0
            end
        else
            local v226, v227
            if v223 == 1 then
                assert(v222)
                v226 = v220 + 1
                v214[v226] = v222
                v215[v222] = (v215[v222] or 0) + 1
                v227 = v221
            elseif v223 == 2 then
                assert(v222)
                local v228 = v220 + 1
                v214[v228] = v222
                v226 = v228 + 1
                v214[v226] = v222
                v215[v222] = (v215[v222] or 0) + 2
                v227 = v221
            elseif v223 >= 3 then
                v226 = v220 + 1
                local v229
                if v222 == 0 then
                    if v223 > 10 then
                        v229 = 18
                    else
                        v229 = 17
                    end
                else
                    v229 = 16
                end
                v214[v226] = v229
                v215[v229] = (v215[v229] or 0) + 1
                v227 = v221 + 1
                if v223 > 10 then
                    v216[v227] = v223 - 11
                else
                    v216[v227] = v223 - 3
                end
            else
                v226 = v220
                v227 = v221
            end
            if v225 then
                if v225 == 0 then
                    v220 = v226
                else
                    v220 = v226 + 1
                    v214[v220] = v225
                    v215[v225] = (v215[v225] or 0) + 1
                    v223 = 0
                end
            else
                v220 = v226
                v223 = 1
            end
            v222 = v225
            v221 = v227
        end
    end
    return v214, v216, v215
end

local function LoadStringToTable(v230, v231, v232, v233, v234) -- line 890 | captures: byte
    local v235 = v232 - v234
    local v236
    while true do
        if v235 <= v233 - 15 - v234 then
            local v237 = v235 + v234
            local v238 = v235 + 15 + v234
            local v239, v240, v241, v242, v243, v244, v245, v246, v247, v248, v249, v250, v251, v252, v253, v254 = byte(v230, v237, v238)
            v231[v235] = v239
            v231[v235 + 1] = v240
            v231[v235 + 2] = v241
            v231[v235 + 3] = v242
            v231[v235 + 4] = v243
            v231[v235 + 5] = v244
            v231[v235 + 6] = v245
            v231[v235 + 7] = v246
            v231[v235 + 8] = v247
            v231[v235 + 9] = v248
            v231[v235 + 10] = v249
            v231[v235 + 11] = v250
            v231[v235 + 12] = v251
            v231[v235 + 13] = v252
            v231[v235 + 14] = v253
            v231[v235 + 15] = v254
            v235 += 16
            continue
        end
        v236 = v235
        break
    end
    while v236 <= v233 - v234 do
        local v255 = v236 + v234
        local v256 = v236 + v234
        v231[v236] = byte(v230, v255, v256)
        v236 += 1
    end
    return v231
end

local function GetBlockLZ77Result(v257, v258, v259, v260, v261, v262, v263) -- line 919 | captures: v5, v6, v7, v8, v9, v10, v106
    local v264 = v106[v257]
    local v265 = v264[1]
    local v266 = v264[2]
    local v267 = v264[3]
    local v268 = v264[4]
    local v269 = v264[5]
    local v270 = if v265 then 2147483646 else v267
    local v271 = v269 - v269 % 4 / 4
    local v272 = {}
    local v273 = {}
    local v274, v275, v276
    if v263 then
        local hash_tables = v263.hash_tables
        local string_table = v263.string_table
        local strlen = v263.strlen
        local v277 = v260 == 1
        assert(v277)
        if v260 <= v261 and strlen >= 2 then
            local v278 = string_table[strlen - 1] * 65536 + string_table[strlen] * 256 + v258[1]
            local v279 = v259[v278]
            if not v279 then
                v279 = {}
                v259[v278] = v279
            end
            v279[#v279 + 1] = -1
        end
        if v260 + 1 <= v261 and strlen >= 1 then
            local v280 = string_table[strlen] * 65536 + v258[1] * 256 + v258[2]
            local v281 = v259[v280]
            if not v281 then
                v281 = {}
                v259[v280] = v281
            end
            v281[#v281 + 1] = 0
        end
        v275 = hash_tables
        v276 = string_table
        v274 = strlen
    else
        v275 = v272
        v276 = v273
        v274 = 0
    end
    local v282 = v274 + 3
    local v283 = (v258[v260 - v262] or 0) * 256 + (v258[v260 + 1 - v262] or 0)
    local v284 = {}
    local v285 = {}
    local v286 = {}
    local v287 = {}
    local v288 = {}
    local v289 = {}
    local v290 = if v265 then 1 else 0
    local v291 = v261 + v290
    local v292
    local v293
    local v294 = 0
    local v295 = 0
    local v296 = 0
    local v297 = 0
    local v298 = false
    local v299 = 0
    local v300 = 0
    local v301 = v260
    while true do
        local v302, v303, v304, v305, v306, v307, v308, v309
        if v301 <= v291 then
            v302 = v301 - v262
            v303 = v262 - 3
            v304 = (v283 * 256 + (v258[v302 + 2] or 0)) % 16777216
            v305 = v259[v304]
            if v305 then
                v307 = #v305
                v306 = v305
                v308 = v292
                v309 = v293
            else
                v259[v304] = {}
                if v275 then
                    v306 = v275[v304]
                    if v306 then
                        v307 = #v306
                    else
                        v307 = 0
                    end
                    v309 = v307
                else
                    v307 = 0
                    v309 = v293
                end
                v308 = 0
            end
        else
            break
        end
        if v301 <= v261 then
            v305[v308 + 1] = v301
        end
        local v310, v311, v312
        if v307 > 0 and v301 + 2 <= v261 then
            if v265 then
                if v267 <= v299 then
                end
                v312 = v309
                v310 = 0
                v311 = v300
            else
                local v313 = v269
                local v314 = v261 - v301
                if not (v314 < 257) then
                    v314 = 257
                end
                local v315 = v314 + v302
                local v316 = v302 + 3
                local v317 = v307
                local v318 = v306
                local v319 = 0
                local v320 = v300
                while true do
                    if v317 >= 1 then
                        if v313 <= 0 then
                            v312 = v313
                            v310 = v319
                            v311 = v320
                            break
                        end
                        local v321 = v318[v317]
                        if v301 - v321 > 32768 then
                            v312 = v313
                            v310 = v319
                            v311 = v320
                            break
                        end
                        if v321 < v301 then
                            local v322
                            if v321 < -257 then
                                local v323, v324 = v316, v282 + v321
                                while true do
                                    if v323 <= v315 and v276[v324] == v258[v323] then
                                        v323, v324 = v323 + 1, v324 + 1
                                        continue
                                    end
                                    v322 = v323
                                    break
                                end
                            else
                                local v325, v326 = v316, v321 - v303
                                while true do
                                    if v325 <= v315 and v258[v326] == v258[v325] then
                                        v325, v326 = v325 + 1, v326 + 1
                                        continue
                                    end
                                    v322 = v325
                                    break
                                end
                            end
                            local v327 = v322 - v302
                            if v319 < v327 then
                                v319, v320 = v327, v301 - v321
                            end
                            if v268 <= v319 then
                                v312 = v313
                                v310 = v319
                                v311 = v320
                                break
                            end
                        end
                        v317 -= 1
                        v313 -= 1
                        if v317 == 0 and v321 > 0 and v275 then
                            v318 = v275[v304]
                            if v318 then
                                v317 = #v318
                            else
                                v317 = 0
                            end
                        end
                        continue
                    end
                    v312 = v313
                    v310 = v319
                    v311 = v320
                    break
                end
            end
        else
            v312 = v309
            v310 = 0
            v311 = v300
        end
        if v265 then
            v283 = v304
            v293 = v312
        elseif v310 > 3 then
            if v310 <= v310 then
                v293 = v5[v310]
                local v328 = v7[v310]
                if v311 > 256 then
                    local v329 = 16
                    local v330 = 7
                    local v331 = 384
                    local v332 = 512
                    local v333, v334, v335, v336, v337, v338, v339, v340
                    while true do
                        if v331 < v311 then
                            if v332 < v311 then
                                v329 += 2
                                v330 += 1
                                v331 *= 2
                                v332 *= 2
                                continue
                            end
                            local v341 = (v311 - v332 / 2 - 1) % (v332 / 4)
                            local v342 = v329 + 1
                            v333 = v294 + 1
                            v284[v333] = v293
                            v285[v293] = (v285[v293] or 0) + 1
                            v334 = v295 + 1
                            v286[v334] = v342
                            v287[v342] = (v287[v342] or 0) + 1
                            if v328 > 0 then
                                v335 = v296 + 1
                                v288[v335] = v6[v310]
                            else
                                v335 = v296
                            end
                            if v330 > 0 then
                                v336 = v297 + 1
                                v289[v336] = v341
                            else
                                v336 = v297
                            end
                            local v343 = 1
                            local v344 = v301 + v310 - v343
                            local v345 = v301 + 1
                            v337 = v304
                            for v346 = v345, v344 do
                                v337 = (v337 * 256 + (v258[v346 - v262 + 2] or 0)) % 16777216
                                if v310 <= v270 then
                                    local v347 = v259[v337]
                                    if not v347 then
                                        v347 = {}
                                        v259[v337] = v347
                                    end
                                    v347[#v347 + 1] = v346
                                end
                            end
                            v338 = 0
                            v340, v339 = false, v301 + v310 - v338
                        else
                            v337 = v304
                            v338 = v332
                            v333 = v294
                            v334 = v295
                            v335 = v296
                            v336 = v297
                            v340 = v298
                            v339 = v301
                        end
                        break
                    end
                    local v348 = (v311 - v338 / 2 - 1) % (v338 / 4)
                    v283 = v337
                    v294 = v333
                    v295 = v334
                    v296 = v335
                    v297 = v336
                    v298 = v340
                    v301 = v339
                else
                    local v349 = v8[v311]
                    local v350 = v9[v311]
                    local v351 = v10[v311]
                    v283 = v304
                end
            else
                v293 = v258[v302]
                v294 += 1
                v284[v294] = v293
                v285[v293] = (v285[v293] or 0) + 1
                v283, v301 = v304, v301 + 1
            end
        else
            if v310 == 3 and v311 >= 4096 then
            end
            v283 = v304
            v293 = v312
        end
        v292 = v308
        v299 = v310
        v300 = v311
    end
    v284[v294 + 1] = 256
    v285[256] = (v285[256] or 0) + 1
    return v284, v288, v285, v286, v289, v287
end

local function GetBlockDynamicHuffmanHeader(v352, v353) -- line 1178 | captures: v15, GetHuffmanBitlenAndCode, RunLengthEncodeHuffmanBitlen
    local v354, v355, v356 = GetHuffmanBitlenAndCode(v352, 15, 285)
    local v357, v358, v359 = GetHuffmanBitlenAndCode(v353, 15, 29)
    local v360, v361, v362 = RunLengthEncodeHuffmanBitlen(v354, v356, v357, v359)
    local v363, v364 = GetHuffmanBitlenAndCode(v362, 7, 18)
    local v365 = 0
    for v366 = 1, 19 do
        if v363[v15[v366]] then
            v365 = v366
        end
    end
    local v367 = v359 + 1 - 1
    if v367 < 0 then
        v367 = 0
    end
    return v356 + 1 - 257, v367, v365 - 4, v363, v364, v360, v361, v354, v355, v357, v358
end

local function GetDynamicHuffmanBlockSize(v368, v369, v370, v371, v372, v373, v374) -- line 1198 | captures: v12
    local v375 = 17 + (v370 + 4) * 3
    local v376 = #v372
    for v377 = 1, v376 do
        local v378 = v372[v377]
        local v379 = v375 + v371[v378]
        if v378 >= 16 then
            local v380
            if v378 == 16 then
                v380 = 2
            elseif v378 == 17 then
                v380 = 3
            else
                v380 = 7
            end
            v375 = v379 + v380
        else
            v375 = v379
        end
    end
    local v381 = #v368
    local v382 = 0
    for v383 = 1, v381 do
        local v384 = v368[v383]
        local v385 = v375 + v373[v384]
        local v386, v387
        if v384 > 256 then
            local v388 = v382 + 1
            local v389 = if v384 > 264 and v384 < 285 then v385 + v12[v384 - 256] else v385
            local v390 = v369[v388]
            v386 = v389 + v374[v390]
            if v390 > 3 then
                v386 += (v390 - v390 % 2) / 2 - 1
                v387 = v388
            else
                v387 = v388
            end
        else
            v386 = v385
            v387 = v382
        end
        v375 = v386
        v382 = v387
    end
    return v375
end

local function CompressDynamicHuffmanBlock(v391, v392, v393, v394, v395, v396, v397, v398, v399, v400, v401, v402, v403, v404, v405, v406, v407) -- line 1238 | captures: v12, v15
    local v408 = if v392 then 1 else 0
    v391(v408, 1)
    v391(2, 2)
    v391(v397, 5)
    v391(v398, 5)
    v391(v399, 4)
    local v409 = v399 + 4
    for v410 = 1, v409 do
        v391(v400[v15[v410]] or 0, 3)
    end
    local v411 = #v402
    local v412 = 1
    for v413 = 1, v411 do
        local v414 = v402[v413]
        v391(v401[v414], v400[v414])
        if v414 >= 16 then
            local v415
            if v414 == 16 then
                v415 = 2
            elseif v414 == 17 then
                v415 = 3
            else
                v415 = 7
            end
            v391(v403[v412], v415)
            v412 += 1
        end
    end
    local v416 = #v393
    local v417 = 0
    local v418 = 0
    local v419 = 0
    for v420 = 1, v416 do
        local v421 = v393[v420]
        v391(v405[v421], v404[v421])
        local v422, v423, v424
        if v421 > 256 then
            local v425 = v417 + 1
            local v426
            if v421 > 264 and v421 < 285 then
                v426 = v418 + 1
                v391(v394[v426], v12[v421 - 256])
            else
                v426 = v418
            end
            local v427 = v395[v425]
            v391(v407[v427], v406[v427])
            if v427 > 3 then
                v422 = v419 + 1
                v391(v396[v422], (v427 - v427 % 2) / 2 - 1)
            else
                v422 = v419
            end
            v423 = v425
            v424 = v426
        else
            v423 = v417
            v424 = v418
            v422 = v419
        end
        v417 = v423
        v418 = v424
        v419 = v422
    end
end

local function GetFixedHuffmanBlockSize(v428, v429) -- line 1297 | captures: v18, v12
    local v430 = #v428
    local v431 = 3
    local v432 = 0
    for v433 = 1, v430 do
        local v434 = v428[v433]
        local v435 = v431 + v18[v434]
        local v436, v437
        if v434 > 256 then
            local v438 = v432 + 1
            local v439 = if v434 > 264 and v434 < 285 then v435 + v12[v434 - 256] else v435
            local v440 = v429[v438]
            v436 = v439 + 5
            if v440 > 3 then
                v436 += (v440 - v440 % 2) / 2 - 1
                v437 = v438
            else
                v437 = v438
            end
        else
            v436 = v435
            v437 = v432
        end
        v431 = v436
        v432 = v437
    end
    return v431
end

local function CompressFixedHuffmanBlock(v441, v442, v443, v444, v445, v446) -- line 1321 | captures: v18, v12, v16, v20
    local v447 = if v442 then 1 else 0
    v441(v447, 1)
    v441(1, 2)
    local v448 = #v443
    local v449 = 0
    local v450 = 0
    local v451 = 0
    for v452 = 1, v448 do
        local v453 = v443[v452]
        v441(v16[v453], v18[v453])
        local v454, v455, v456
        if v453 > 256 then
            local v457 = v450 + 1
            local v458
            if v453 > 264 and v453 < 285 then
                v458 = v449 + 1
                v441(v444[v458], v12[v453 - 256])
            else
                v458 = v449
            end
            local v459 = v445[v457]
            v441(v20[v459], 5)
            if v459 > 3 then
                v454 = v451 + 1
                v441(v446[v454], (v459 - v459 % 2) / 2 - 1)
            else
                v454 = v451
            end
            v455 = v457
            v456 = v458
        else
            v456 = v449
            v455 = v450
            v454 = v451
        end
        v449 = v456
        v450 = v455
        v451 = v454
    end
end

local function GetStoreBlockSize(v460, v461, v462) -- line 1354
    local v463 = v461 - v460 + 1 <= 65535
    assert(v463)
    return 3 + (8 - (v462 + 3) % 8) % 8 + 32 + (v461 - v460 + 1) * 8
end

local function CompressStoreBlock(v464, v465, v466, v467, v468, v469, v470) -- line 1360 | captures: v2
    local v471 = v469 - v468 + 1 <= 65535
    assert(v471)
    local v472 = if v466 then 1 else 0
    v464(v472, 1)
    v464(0, 2)
    local v473 = (8 - (v470 + 3) % 8) % 8
    if v473 > 0 then
        v464(v2[v473] - 1, v473)
    end
    local v474 = v469 - v468 + 1
    v464(v474, 16)
    v464(255 - v474 % 256 + (255 - (v474 - v474 % 256) / 256) * 256, 16)
    v465(v467:sub(v468, v469))
end

local function Deflate(v475, v476, v477, v478, v479, v480) -- line 1380 | captures: LoadStringToTable, GetBlockLZ77Result, GetBlockDynamicHuffmanHeader, GetDynamicHuffmanBlockSize, CompressDynamicHuffmanBlock, GetFixedHuffmanBlockSize, CompressFixedHuffmanBlock, CompressStoreBlock
    local v481 = {}
    local v482 = {}
    local v483 = v478(3)
    local v484 = #v479
    local v485, strategy
    if v475 then
        if v475.level then
            v485 = v475.level
        end
        if v475.strategy then
            strategy = v475.strategy
        end
    end
    if not v485 then
        if v484 < 2048 then
            v485 = 7
        elseif v484 <= 65536 then
            v485 = 5
        else
            v485 = 3
        end
    end
    local v486
    local v487 = 0
    local v488 = 0
    local v489
    while true do
        if v486 then
            break
        end
        local v490, v491, v492
        if v487 == 0 then
            v491 = 0
            v492 = 1
            v490 = 65535
        else
            v492 = v488 + 1
            v490 = v488 + 32768
            v491 = v492 - 32768 - 1
        end
        if v490 < v484 then
            v486 = false
            v488 = v490
        else
            v486 = true
            v488 = v484
        end
        local v493 = {}
        local v494 = {}
        local v495 = {}
        local v496 = {}
        local v497 = {}
        local v498 = {}
        local v499 = {}
        local v500 = {}
        local v501 = {}
        local v502 = {}
        local v503 = {}
        local v504 = {}
        local v505 = {}
        local v506 = {}
        local v507, v508, v509, v510
        if v485 == 0 then
        else
            LoadStringToTable(nil, v481, v492, v488 + 3, v491)
            if v492 == 1 and v489 then
                local strlen = v489.strlen
                local v511 = if -strlen + 1 >= -257 then -strlen + 1 else -257
                for v512 = 0, v511, -1 do
                    v481[v512] = v489.string_table[strlen + v512]
                end
            end
            local v513, v514
            if strategy == "huffman_only" then
                v493 = {}
                LoadStringToTable(nil, v493, v492, v488, v492 - 1)
                v494 = {}
                v513 = {}
                v493[v488 - v492 + 2] = 256
                local v515 = v488 - v492 + 2
                for v516 = 1, v515 do
                    local v517 = v493[v516]
                    v513[v517] = (v513[v517] or 0) + 1
                end
                v496, v497, v514 = {}, {}, {}
            else
                v493, v494, v513, v496, v497, v514 = GetBlockLZ77Result(v485, v481, v482, v492, v488, v491, v489)
            end
            local v518, v519, v520, v521, v522
            v507, v508, v518, v519, v500, v520, v502, v521, v504, v522, v506 = GetBlockDynamicHuffmanHeader(v513, v514)
            v510, v509 = GetDynamicHuffmanBlockSize(v493, v496, v518, v519, v520, v521, v522), GetFixedHuffmanBlockSize(v493, v496)
        end
        local v523 = v488 - v492 + 1 <= 65535
        assert(v523)
        local v524 = 3 + (8 - (v483 + 3) % 8) % 8 + 32 + (v488 - v492 + 1) * 8
        local v525
        if v509 then
            if v509 < v524 then
                v525 = v509
            else
                v525 = v488
            end
        else
            v525 = v524
        end
        if v510 and v510 < v525 then
            v525 = v510
        end
        if v485 == 0 then
            CompressStoreBlock(nil, nil, v486, nil, v492, v488, v483)
            v483 += v524
        elseif strategy == "fixed" then
            if strategy == "dynamic" then
                CompressDynamicHuffmanBlock(nil, v486, v493, v494, v496, v497, v507, v508, nil, v499, v500, v501, v502, v503, v504, v505, v506)
                v483 += assert(v510)
            elseif strategy == "fixed" then
                CompressFixedHuffmanBlock(nil, v486, v493, v494, v496, v497)
                v483 += assert(v509)
            elseif v509 == v525 then
            end
        elseif strategy ~= "dynamic" and v524 == v525 then
        end
        local v526
        if v486 then
            v526 = (nil)(3)
        else
            v526 = (nil)(0)
        end
        local v527 = v526 == v483
        assert(v527)
        if not v486 then
            if v489 and v492 == 1 then
                local v528 = 0
                while v481[v528] do
                    v481[v528] = nil
                    v528 -= 1
                end
            end
            local v529 = v488 - 32767
            local v530 = 1
            for v531 = v529, v488 do
                v481[v530] = v481[v531 - v491]
                v530 += 1
            end
            v489 = nil
            for v532, v533 in pairs(v482) do
                local v534 = #v533
                if v534 > 0 and v488 + 1 - v533[1] > 32768 then
                    if v534 == 1 then
                        v482[v532] = nil
                    else
                        local v535 = {}
                        local v536 = 0
                        for v537 = 2, v534 do
                            local v538 = v533[v537]
                            if v488 + 1 - v538 <= 32768 then
                                v536 += 1
                                v535[v536] = v538
                            end
                        end
                        v482[v532] = v535
                    end
                end
                v489 = nil
            end
        end
        v487 = v492
    end
end

local function CompressDeflateInternal(v539, v540, v541) -- line 1579 | captures: CreateWriter, Deflate
    local v542, v543, v544 = CreateWriter()
    Deflate(v541, v542, v543, v544, v539, v540)
    local v545, v546 = v544(1)
    assert(v546)
    return v546, (8 - v545 % 8) % 8
end

local function CompressZlibInternal(v547, v548, v549) -- line 1587 | captures: v1, CreateWriter, Deflate
    local v550, v551, v552 = CreateWriter()
    v550(120, 8)
    local v553 = if v548 then 1 else 0
    local v554 = 128 + v553 * 32
    v550(v554 + (31 - (30720 + v554) % 31), 8)
    if v553 == 1 then
        assert(v548)
        local adler32 = v548.adler32
        local v555 = adler32 % 256
        local v556 = (adler32 - v555) / 256
        local v557 = v556 % 256
        local v558 = (v556 - v557) / 256
        local v559 = v558 % 256
        v550((v558 - v559) / 256 % 256, 8)
        v550(v559, 8)
        v550(v557, 8)
        v550(v555, 8)
    end
    Deflate(v549, v550, v551, v552, v547, v548)
    v552(2)
    local v560 = v1:Adler32(v547)
    local v561 = v560 % 256
    local v562 = (v560 - v561) / 256
    local v563 = v562 % 256
    local v564 = (v562 - v563) / 256
    local v565 = v564 % 256
    v550((v564 - v565) / 256 % 256, 8)
    v550(v565, 8)
    v550(v563, 8)
    v550(v561, 8)
    local v566, v567 = v552(1)
    assert(v567)
    return v567, (8 - v566 % 8) % 8
end

function v1.CompressDeflate(v568, v569, v570) -- line 1627 | captures: IsValidArguments, CompressDeflateInternal
    local v571, v572 = IsValidArguments(v569, false, nil, true, v570)
    if not v571 then
        error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v572, 2)
    end
    return CompressDeflateInternal(v569, nil, v570)
end

function v1.CompressDeflateWithDict(v573, v574, v575, v576) -- line 1635 | captures: IsValidDictionary, CompressDeflateInternal
    local v577
    if type(v574) == "string" then
        local v578
        v578, v577 = IsValidDictionary(v575)
        if v578 then
            v577 = nil
        end
    else
        local v579
        v579, v577 = false, ("'str' - string expected got '%s'."):format((type(v574)))
    end
    error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v577, 2)
    return CompressDeflateInternal(v574, v575, v576)
end

function v1.CompressZlib(v580, v581, v582) -- line 1643 | captures: IsValidArguments, CompressZlibInternal
    local v583, v584 = IsValidArguments(v581, false, nil, true, v582)
    if not v583 then
        error("Usage: LibDeflate:CompressZlib(str, configs): " .. v584, 2)
    end
    return CompressZlibInternal(v581, nil, v582)
end

function v1.CompressZlibWithDict(v585, v586, v587, v588) -- line 1651 | captures: IsValidDictionary, CompressZlibInternal
    local v589
    if type(v586) == "string" then
        local v590
        v590, v589 = IsValidDictionary(v587)
        if v590 then
            v589 = nil
        end
    else
        local v591
        v591, v589 = false, ("'str' - string expected got '%s'."):format((type(v586)))
    end
    error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v589, 2)
    return CompressZlibInternal(v586, v587, v588)
end

local function CreateReader(v592) -- line 1659 | captures: byte, char, sub, v2, v4
    local v593 = #v592
    local v594 = 1
    local v595 = 0
    local v596 = 0
    return function(v597) -- line 1664 | captures: v594, v595, v596, v592, byte, v2
            local v598 = v2[v597]
            if v597 <= v595 then
                local v599 = v596 % v598
                v596 = (v596 - v599) / v598
                v595 -= v597
                return v599
            end
            local v600 = v2[v595]
            local v601 = v594
            local v602 = v594 + 3
            local v603, v604, v605, v606 = byte(v592, v601, v602)
            v596 += ((v603 or 0) + (v604 or 0) * 256 + (v605 or 0) * 65536 + (v606 or 0) * 16777216) * v600
            v594 += 4
            v595 = v595 + 32 - v597
            local v607 = v596 % v598
            v596 = (v596 - v607) / v598
            return v607
        end,
        function(v608, v609, v610) -- line 1681 | captures: v594, v595, v596, v592, v593, char, sub
            local v611 = v595 % 8 == 0
            assert(v611)
            local v612 = if v608 <= v595 / 8 then v608 else v595 / 8
            local v613 = v610
            for v614 = 1, v612 do
                local v615 = v596 % 256
                v613 += 1
                v609[v613] = char(v615)
                v596 = (v596 - v615) / 256
            end
            v595 -= v612 * 8
            local v616 = v608 - v612
            if (v593 - v594 - v616 + 1) * 8 + v595 < 0 then
                return -1
            end
            local v617 = v594 + v616 - 1
            local v618 = v594
            for v619 = v618, v617 do
                v613 += 1
                v609[v613] = sub(v592, v619, v619)
            end
            v594 += v616
            return v613
        end,
        function(v620, v621, v622) -- line 1714 | captures: v594, v595, v596, v592, byte, v2, v4
            if v622 <= 0 then
                local v623 = v622 + 1
                local v624 = 0
                local v625 = 0
                local v626 = 0
                for v627 = v623, 15 do
                    local v628 = v596 % 2
                    v596 = (v596 - v628) / 2
                    v595 -= 1
                    if v628 == 1 then
                        v624 = v624 + 1 - v624 % 2
                    end
                    local v629 = v620[v627] or 0
                    local v630 = v624 - v625
                    if v630 < v629 then
                        return v621[v626 + v630]
                    end
                    v626 += v629
                    v625 = (v625 + v629) * 2
                    v624 *= 2
                end
                return -10
            end
            if v595 < 15 and v592 then
                local v631 = v2[v595]
                local v632 = v594
                local v633 = v594 + 3
                local v634, v635, v636, v637 = byte(v592, v632, v633)
                v596 += ((v634 or 0) + (v635 or 0) * 256 + (v636 or 0) * 65536 + (v637 or 0) * 16777216) * v631
                v594 += 4
                v595 += 32
            end
            local v638 = v2[v622]
            v595 -= v622
            local v639 = v596 % v638
            v596 = (v596 - v639) / v638
            local v640 = v4[v622][v639]
            local v641 = v620[v622]
            if v640 < v641 then
                return v621[v640]
            end
            local v642 = v641 * 2
            local v643 = v640 * 2
        end,
        function() -- line 1766 | captures: v594, v595, v593
            return (v593 - v594 + 1) * 8 + v595
        end,
        function() -- line 1768 | captures: v595, v596, v2
            local v644 = v595 % 8
            local v645 = v2[v644]
            v595 -= v644
            v596 = (v596 - v596 % v645) / v645
        end
end

local function CreateDecompressState(v646, v647) -- line 1775 | captures: CreateReader
    local v648, v649, v650, v651, v652 = CreateReader(v646)
    return {
        buffer_size = 0,
        ReadBits = v648,
        ReadBytes = v649,
        Decode = v650,
        ReaderBitlenLeft = v651,
        SkipToByteBoundary = v652,
        buffer = {},
        result_buffer = {},
        dictionary = v647
    }
end

local function GetHuffmanForDecode(v653, v654, v655) -- line 1790
    local v656 = {}
    local v657
    local v658 = v655
    for v659 = 0, v654 do
        local v660 = v653[v659] or 0
        if v660 <= 0 then
            v657 = v658
        elseif v660 < v658 then
            v657 = v660
        end
        v656[v660] = (v656[v660] or 0) + 1
        v658 = v657
    end
    if v656[0] == v654 + 1 then
        return 0, v656, {}, 0
    end
    local v661 = 1
    for v662 = 1, v655 do
        v661 = v661 * 2 - (v656[v662] or 0)
        if v661 < 0 then
            return v661, {}, {}, 0
        end
    end
    local v663 = { 0 }
    local v664 = v655 - 1
    for v665 = 1, v664 do
        v663[v665 + 1] = v663[v665] + (v656[v665] or 0)
    end
    local v666 = {}
    for v667 = 0, v654 do
        local v668 = v653[v667] or 0
        if v668 ~= 0 then
            v666[v663[v668]] = v667
            v663[v668] += 1
        end
    end
    return v661, v656, v666, v658
end

local function DecodeUntilEndOfBlock(v669, v670, v671, v672, v673, v674, v675) -- line 1838 | captures: concat, v3, v11, v12, v13, v14
    local buffer = v669.buffer
    local buffer_size = v669.buffer_size
    local ReadBits = v669.ReadBits
    local Decode = v669.Decode
    local ReaderBitlenLeft = v669.ReaderBitlenLeft
    local result_buffer = v669.result_buffer
    local dictionary = v669.dictionary
    local v676 = {}
    local strlen, v677, v678, v679, v680, v681, v682, v683, v684
    if dictionary then
        if buffer[0] then
            v684 = v669
            v678 = v670
            v679 = v671
            v680 = v672
            v681 = v673
            v682 = v674
            v683 = v675
            v677 = 1
        else
            local string_table = dictionary.string_table
            strlen = dictionary.strlen
            v677 = -strlen + 1
            local v685 = if -strlen + 1 >= -257 then -strlen + 1 else -257
            v676 = string_table
            for v686 = 0, v685, -1 do
                buffer[v686] = v3[string_table[strlen + v686]]
                v684 = nil
                v678 = nil
                v679 = nil
                v680 = nil
                v681 = nil
                v682 = nil
                v683 = nil
                v676 = string_table
            end
        end
    else
        v684 = v669
        v678 = v670
        v679 = v671
        v680 = v672
        v681 = v673
        v682 = v674
        v683 = v675
        v677 = 1
    end
    while true do
        local v687 = Decode(v678, v679, v680)
        if not (v687 < 0) and not (v687 > 285) then
            if v687 < 256 then
                buffer_size += 1
                buffer[buffer_size] = v3[v687]
                continue
            end
            if not (v687 > 256) then
                continue
            end
            local v688 = v687 - 256
            local v689 = v11[v688]
            if not (v688 < 8) then
                v689 += ReadBits(v12[v688])
            end
            local v690 = Decode(v681, v682, v683)
            if v690 >= 0 and v690 <= 29 then
                local v691 = v13[v690]
                if not (v691 <= 4) then
                    v691 += ReadBits(v14[v690])
                end
                local v692 = buffer_size - v691 + 1
                if v692 < v677 then
                    break
                end
                if v692 < -257 then
                    local v693 = strlen + v692
                    for v694 = 1, v689 do
                        buffer_size += 1
                        buffer[buffer_size] = v3[v676[v693]]
                        v693 += 1
                    end
                else
                    for v695 = 1, v689 do
                        buffer_size += 1
                        buffer[buffer_size] = buffer[v692]
                        v692 += 1
                    end
                end
                if ReaderBitlenLeft() < 0 then
                    return 2
                end
                if buffer_size >= 65536 then
                    result_buffer[#result_buffer + 1] = concat(buffer, "", 1, 32768)
                    for v696 = 32769, buffer_size do
                        buffer[v696 - 32768] = buffer[v696]
                    end
                    buffer_size -= 32768
                    buffer[buffer_size + 1] = nil
                end
                if v690 == 256 then
                    v684.buffer_size = buffer_size
                    return 0
                end
                continue
            end
        end
        return -10
    end
    return -11
end

local function DecompressStoreBlock(v697) -- line 1940 | captures: concat
    local buffer = v697.buffer
    local ReadBits = v697.ReadBits
    local ReaderBitlenLeft = v697.ReaderBitlenLeft
    local result_buffer = v697.result_buffer
    v697.SkipToByteBoundary()
    local v698 = ReadBits(16)
    if ReaderBitlenLeft() < 0 then
        return 2
    end
    local v699 = ReadBits(16)
    if ReaderBitlenLeft() < 0 then
        return 2
    end
    if v698 % 256 + v699 % 256 == 255 and (v698 - v698 % 256) / 256 + (v699 - v699 % 256) / 256 == 255 then
        local v700 = v697.ReadBytes(v698, buffer, v697.buffer_size)
        if v700 < 0 then
            return 2
        end
        if v700 >= 65536 then
            result_buffer[#result_buffer + 1] = concat(buffer, "", 1, 32768)
            for v701 = 32769, v700 do
                buffer[v701 - 32768] = buffer[v701]
            end
            v700 -= 32768
            buffer[v700 + 1] = nil
        end
        v697.buffer_size = v700
        return 0
    end
    return -2
end

local function DecompressFixBlock(v702) -- line 1978 | captures: v19, v23, v17, v21, DecodeUntilEndOfBlock
    return (DecodeUntilEndOfBlock(v702, v19, v17, 7, v23, v21, 5))
end

local function DecompressDynamicBlock(v703) -- line 1981 | captures: v15, GetHuffmanForDecode, DecodeUntilEndOfBlock
    local ReadBits = v703.ReadBits
    local Decode = v703.Decode
    local v704 = ReadBits(5) + 257
    local v705 = ReadBits(5) + 1
    local v706 = ReadBits(4) + 4
    if v704 > 286 or v705 > 30 then
        return -3
    end
    local v707 = {}
    for v708 = 1, v706 do
        v707[v15[v708]] = ReadBits(3)
    end
    local v709, v710, v711, v712 = GetHuffmanForDecode(v707, 18, 7)
    if v709 == 0 then
        local v713 = {}
        local v714 = {}
        local v715 = 0
        while v715 < v704 + v705 do
            local v716 = Decode(v710, v711, v712)
            if v716 < 0 then
                return v716
            end
            local v717
            if v716 >= 16 then
                if v716 == 16 then
                    if v715 == 0 then
                        return -5
                    end
                    if v704 <= v715 - 1 then
                        local v718 = v714[v715 - v704 - 1]
                    else
                        local v719 = v713[v715 - 1]
                    end
                    local v720 = 3 + ReadBits(2)
                    v717 = v715
                else
                    local v721 = if v716 == 17 then 3 + ReadBits(3) else 11 + ReadBits(7)
                    if v704 + v705 < v715 + v721 then
                        return -6
                    end
                    local v722 = v721
                    while true do
                        if v722 > 0 then
                            v722 -= 1
                            if v704 <= v715 then
                                v714[v715 - v704] = 0
                            else
                                v713[v715] = 0
                            end
                            v715 += 1
                            continue
                        end
                        v717 = v715
                        break
                    end
                end
            else
                if v704 <= v715 then
                    v714[v715 - v704] = v716
                else
                    v713[v715] = v716
                end
                v717 = v715 + 1
            end
            v715 = v717
        end
        if v713[256] then
            local v723, v724, v725, v726 = GetHuffmanForDecode(v713, v704 - 1, 15)
            if v723 == 0 then
                local v727, v728, v729, v730 = GetHuffmanForDecode(v714, v705 - 1, 15)
                if v727 == 0 then
                    return (DecodeUntilEndOfBlock(v703, v724, v725, v726, v728, v729, v730))
                end
                if not (v727 < 0) and v705 == (v728[0] or 0) + (v728[1] or 0) then
                    return (DecodeUntilEndOfBlock(v703, v724, v725, v726, v728, v729, v730))
                end
                return -8
            end
            if not (v723 < 0) and v704 == (v724[0] or 0) + (v724[1] or 0) then
                local v731, v732, v733, v734 = GetHuffmanForDecode(v714, v705 - 1, 15)
                if v731 == 0 then
                    return (DecodeUntilEndOfBlock(v703, v724, v725, v726, v732, v733, v734))
                end
                if not (v731 < 0) and v705 == (v732[0] or 0) + (v732[1] or 0) then
                    return (DecodeUntilEndOfBlock(v703, v724, v725, v726, v732, v733, v734))
                end
                return -8
            end
            return -7
        end
        return -9
    end
    return -4
end

local function Inflate(v735) -- line 2088 | captures: v19, v23, concat, v17, v21, DecodeUntilEndOfBlock, DecompressStoreBlock, DecompressDynamicBlock
    local ReadBits = v735.ReadBits
    local v736
    while true do
        if v736 then
            v735.result_buffer[#v735.result_buffer + 1] = concat(v735.buffer, "", 1, v735.buffer_size)
            return concat(v735.result_buffer), 0
        end
        v736 = ReadBits(1) == 1
        local v737 = ReadBits(2)
        if v737 == 0 then
            DecompressStoreBlock(v735)
            continue
        end
        if v737 == 1 then
            DecodeUntilEndOfBlock(v735, v19, v17, 7, v23, v21, 5)
            continue
        end
        if v737 == 2 then
            local v738 = DecompressDynamicBlock(v735)
            if v738 == 0 then
                continue
            end
            return nil, v738
        end
        break
    end
    return nil, -1
end

local function DecompressDeflateInternal(v739, v740) -- line 2112 | captures: CreateDecompressState, Inflate
    local v741 = CreateDecompressState(v739, v740)
    local v742, v743 = Inflate(v741)
    if v742 then
        local v744 = v741.ReaderBitlenLeft()
        return v742, (v744 - v744 % 8) / 8
    end
    return nil, v743
end

local function DecompressZlibInternal(v745, v746) -- line 2122 | captures: v1, CreateDecompressState, Inflate
    local v747 = CreateDecompressState(v745, v746)
    local ReadBits = v747.ReadBits
    local v748 = ReadBits(8)
    if v747.ReaderBitlenLeft() < 0 then
        return nil, 2
    end
    local v749 = v748 % 16
    local v750 = (v748 - v749) / 16
    if v749 == 8 then
        if v750 > 7 then
            return nil, -13
        end
        local v751 = ReadBits(8)
        if v747.ReaderBitlenLeft() < 0 then
            return nil, 2
        end
        if (v748 * 256 + v751) % 31 == 0 then
            if (v751 - v751 % 32) / 32 % 2 == 1 then
                if v746 then
                    local v752 = ReadBits(8)
                    local v753 = ReadBits(8)
                    local v754 = ReadBits(8)
                    local v755 = v752 * 16777216 + v753 * 65536 + v754 * 256 + ReadBits(8)
                    if v747.ReaderBitlenLeft() < 0 then
                        return nil, 2
                    end
                    if v755 % 4294967296 == v746.adler32 % 4294967296 then
                        return
                    end
                    return nil, -17
                end
                return nil, -16
            end
            local v756, v757 = Inflate(v747)
            if v756 then
                v747.SkipToByteBoundary()
                local v758 = ReadBits(8)
                local v759 = ReadBits(8)
                local v760 = ReadBits(8)
                local v761 = ReadBits(8)
                if v747.ReaderBitlenLeft() < 0 then
                    return nil, 2
                end
                local v762 = v758 * 16777216 + v759 * 65536 + v760 * 256 + v761
                local v763 = v1:Adler32(v756)
                if v762 % 4294967296 == v763 % 4294967296 then
                    local v764 = v747.ReaderBitlenLeft()
                    return v756, (v764 - v764 % 8) / 8
                end
                return nil, -15
            end
            return nil, v757
        end
        return nil, -14
    end
    return nil, -12
end

function v1.DecompressDeflate(v765, v766) -- line 2185 | captures: DecompressDeflateInternal
    local v767, v768
    if type(v766) == "string" then
        v767 = true
        v768 = ""
    else
        v767, v768 = false, ("'str' - string expected got '%s'."):format((type(v766)))
    end
    if not v767 then
        error("Usage: LibDeflate:DecompressDeflate(str): " .. v768, 2)
    end
    return DecompressDeflateInternal(v766)
end

function v1.DecompressDeflateWithDict(v769, v770, v771) -- line 2199 | captures: IsValidDictionary, DecompressDeflateInternal
    local v772, v773
    if type(v770) == "string" then
        local v774
        v774, v772 = IsValidDictionary(v771)
        if v774 then
            v773 = true
            v772 = ""
        else
            v773 = false
        end
    else
        v773, v772 = false, ("'str' - string expected got '%s'."):format((type(v770)))
    end
    if not v773 then
        error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v772, 2)
    end
    return DecompressDeflateInternal(v770, v771)
end

function v1.DecompressZlib(v775, v776) -- line 2220 | captures: DecompressZlibInternal
    local v777, v778
    if type(v776) == "string" then
        v777 = true
        v778 = ""
    else
        v777, v778 = false, ("'str' - string expected got '%s'."):format((type(v776)))
    end
    if not v777 then
        error("Usage: LibDeflate:DecompressZlib(str): " .. v778, 2)
    end
    return DecompressZlibInternal(v776)
end

function v1.DecompressZlibWithDict(v779, v780, v781) -- line 2234 | captures: IsValidDictionary, DecompressZlibInternal
    local v782, v783
    if type(v780) == "string" then
        local v784
        v784, v782 = IsValidDictionary(v781)
        if v784 then
            v783 = true
            v782 = ""
        else
            v783 = false
        end
    else
        v783, v782 = false, ("'str' - string expected got '%s'."):format((type(v780)))
    end
    if not v783 then
        error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v782, 2)
    end
    return DecompressZlibInternal(v780, v781)
end

v18 = {}
for v785 = 0, 143 do
    v18[v785] = 8
end
for v786 = 144, 255 do
    v18[v786] = 9
end
v18[256] = 7
v18[257] = 7
v18[258] = 7
v18[259] = 7
v18[260] = 7
v18[261] = 7
v18[262] = 7
v18[263] = 7
v18[264] = 7
v18[265] = 7
v18[266] = 7
v18[267] = 7
v18[268] = 7
v18[269] = 7
v18[270] = 7
v18[271] = 7
v18[272] = 7
v18[273] = 7
v18[274] = 7
v18[275] = 7
v18[276] = 7
v18[277] = 7
v18[278] = 7
v18[279] = 7
v18[280] = 8
v18[281] = 8
v18[282] = 8
v18[283] = 8
v18[284] = 8
v18[285] = 8
v18[286] = 8
v18[287] = 8
v22 = {}
for v787 = 0, 31 do
    v22[v787] = 5
end
local v788, v789 = GetHuffmanForDecode(v18, 287, 9)
v19 = v789
local v790 = v788 == 0
assert(v790)
local v791
v788, v791 = GetHuffmanForDecode(v22, 31, 5)
v23 = v791
v790 = v788 == 0
assert(v790)
local v792 = {}

v792["\000"] = "%z"
v792["("] = "%("
v792[")"] = "%)"
v792["."] = "%."
v792["%"] = "%%"
v792["+"] = "%+"
v792["-"] = "%-"
v792["*"] = "%*"
v792["?"] = "%?"
v792["["] = "%["
v792["]"] = "%]"
v792["^"] = "%^"
v792["$"] = "%$"

local function escape_for_gsub(v793) -- line 2326 | captures: v792
    return (v793:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792))
end

function v1.CreateCodec(v794, v795, v796, v797) -- line 2330 | captures: byte, find, gsub, sub, concat, v3, v792
    if type(v795) == "string" then
        if type(v796) == "string" and type(v797) == "string" then
        end
    else
        error("Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.", 2)
    end
    if v796 == "" then
        return nil, "No escape characters supplied."
    end
    if #v795 < #v797 then
        return nil, "The number of reserved characters must be at least as many as the number of mapped chars."
    end
    if v795 == "" then
        return nil, "No characters to encode."
    end
    local v798 = v795 .. v796 .. v797
    local v799 = {}
    local v800 = #v798
    for v801 = 1, v800 do
        local v802 = byte(v798, v801, v801)
        if v799[v802] then
            return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars."
        end
        v799[v802] = true
    end
    local v803 = {}
    local v804 = {}
    local v805 = {}
    local v806 = {}
    if #v797 > 0 then
        local v807 = {}
        local v808 = {}
        local v809 = #v797
        for v810 = 1, v809 do
            local v811 = sub(v795, v810, v810)
            local v812 = sub(v797, v810, v810)
            v806[v811] = v812
            v805[#v805 + 1] = v811
            v808[v812] = v811
            v807[#v807 + 1] = v812
        end
        v803[#v803 + 1] = "([" .. concat(v807):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "])"
        v804[#v804 + 1] = v808
    end
    local v813 = sub(v796, 1, 1)
    local v814 = {}
    local v815 = {}
    local v816 = #v798
    local v817 = 1
    local v818 = 0
    for v819 = 1, v816 do
        local v820 = sub(v798, v819, v819)
        if not v806[v820] then
            while true do
                if v818 >= 256 then
                    v818 += 1
                    if v818 > 255 then
                        v803[#v803 + 1] = v813:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "([" .. concat(v814):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "])"
                        v804[#v804 + 1] = v815
                        v817 += 1
                        v813 = sub(v796, v817, v817)
                        v814 = {}
                        v815 = {}
                        if v813 then
                            if v813 == "" then
                                return nil, "Out of escape characters."
                            end
                            v818 = 0
                        else
                            return nil, "Out of escape characters."
                        end
                    end
                    continue
                end
                if v799[v818] then
                    continue
                end
                break
            end
            local v821 = v3[v818]
            v806[v820] = v813 .. v821
            v805[#v805 + 1] = v820
            v815[v821] = v820
            v814[#v814 + 1] = v821
            v818 += 1
        end
        if v819 == #v798 then
            v803[#v803 + 1] = v813:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "([" .. concat(v814):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "])"
            v804[#v804 + 1] = v815
        end
    end
    local v822 = {}
    local v823 = "([" .. concat(v805):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "])"

    function v822.Encode(v824, v825) -- line 2430 | captures: v806, v823, gsub
        if type(v825) ~= "string" then
            local v826 = ("Usage: codec:Encode(str): 'str' - string expected got '%s'."):format((type(v825)))
            error(v826, 2)
        end
        return (gsub(v825, v823, v806))
    end

    local v827 = #v803
    local v828 = "([" .. v795:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", v792) .. "])"

    function v822.Decode(v829, v830) -- line 2441 | captures: v803, v804, v827, v828, find, gsub
        if type(v830) ~= "string" then
            local v831 = ("Usage: codec:Decode(str): 'str' - string expected got '%s'."):format((type(v830)))
            error(v831, 2)
        end
        if find(v830, v828) then
            return nil
        end
        local v832 = v830
        for v833 = 1, v827 do
            v832 = gsub(v832, v803[v833], v804[v833])
        end
        return v832
    end

    return v822, ""
end

v1.internals = {
    LoadStringToTable = LoadStringToTable,
    IsValidDictionary = IsValidDictionary,
    IsEqualAdler32 = IsEqualAdler32
}
return table.freeze(v1)
