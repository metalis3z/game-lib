-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local v1 = table.create(80, 0)
local v2 = table.create(80, 0)
local v3 = {
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
    3329325298,
    3391569614,
    3515267271,
    3940187606,
    4118630271,
    116418474,
    174292421,
    289380356,
    460393269,
    685471733,
    852142971,
    1017036298,
    1126000580,
    1288033470,
    1501505948,
    1607167915,
    1816402316
}
local v4 = {
    3609767458,
    602891725,
    3964484399,
    2173295548,
    4081628472,
    3053834265,
    2937671579,
    3664609560,
    2734883394,
    1164996542,
    1323610764,
    3590304994,
    4068182383,
    991336113,
    633803317,
    3479774868,
    2666613458,
    944711139,
    2341262773,
    2007800933,
    1495990901,
    1856431235,
    3175218132,
    2198950837,
    3999719339,
    766784016,
    2566594879,
    3203337956,
    1034457026,
    2466948901,
    3758326383,
    168717936,
    1188179964,
    1546045734,
    1522805485,
    2643833823,
    2343527390,
    1014477480,
    1206759142,
    344077627,
    1290863460,
    3158454273,
    3505952657,
    106217008,
    3606008344,
    1432725776,
    1467031594,
    851169720,
    3100823752,
    1363258195,
    3750685593,
    3785050280,
    3318307427,
    3812723403,
    2003034995,
    3602036899,
    1575990012,
    1125592928,
    2716904306,
    442776044,
    593698344,
    3733110249,
    2999351573,
    3815920427,
    3928383900,
    566280711,
    3454069534,
    4000239992,
    1914138554,
    2731055270,
    3203993006,
    320620315,
    587496836,
    1086792851,
    365543100,
    2618297676,
    3409855158,
    4234509866,
    987167468,
    1246189591
}

function lil_sig0(v5, v6) -- line 174
    local v7 = bit32.rshift(v5, 1)
    local v8 = bit32.lshift(v6, 31)
    local v9 = bit32.rshift(v5, 8)
    local v10 = bit32.lshift(v6, 24)
    local v11 = bit32.rshift(v5, 7)
    local v12 = bit32.bxor(v7, v8, v9, v10, v11)
    local v13 = bit32.rshift(v6, 1)
    local v14 = bit32.lshift(v5, 31)
    local v15 = bit32.rshift(v6, 8)
    local v16 = bit32.lshift(v5, 24)
    local v17 = bit32.rshift(v6, 7)
    local v18 = bit32.lshift(v5, 25)
    return v12, (bit32.bxor(v13, v14, v15, v16, v17, v18))
end

function lil_sig1(v19, v20) -- line 187
    local v21 = bit32.rshift(v19, 19)
    local v22 = bit32.lshift(v20, 13)
    local v23 = bit32.lshift(v19, 3)
    local v24 = bit32.rshift(v20, 29)
    local v25 = bit32.rshift(v19, 6)
    local v26 = bit32.bxor(v21, v22, v23, v24, v25)
    local v27 = bit32.rshift(v20, 19)
    local v28 = bit32.lshift(v19, 13)
    local v29 = bit32.lshift(v20, 3)
    local v30 = bit32.rshift(v19, 29)
    local v31 = bit32.rshift(v20, 6)
    local v32 = bit32.lshift(v19, 26)
    return v26, (bit32.bxor(v27, v28, v29, v30, v31, v32))
end

function big_sig0(v33, v34) -- line 200
    local v35 = bit32.rshift(v33, 28)
    local v36 = bit32.lshift(v34, 4)
    local v37 = bit32.lshift(v33, 30)
    local v38 = bit32.rshift(v34, 2)
    local v39 = bit32.lshift(v33, 25)
    local v40 = bit32.rshift(v34, 7)
    local v41 = bit32.bxor(v35, v36, v37, v38, v39, v40)
    local v42 = bit32.rshift(v34, 28)
    local v43 = bit32.lshift(v33, 4)
    local v44 = bit32.lshift(v34, 30)
    local v45 = bit32.rshift(v33, 2)
    local v46 = bit32.lshift(v34, 25)
    local v47 = bit32.rshift(v33, 7)
    return v41, (bit32.bxor(v42, v43, v44, v45, v46, v47))
end

function big_sig1(v48, v49) -- line 214
    local v50 = bit32.rshift(v48, 14)
    local v51 = bit32.lshift(v49, 18)
    local v52 = bit32.rshift(v48, 18)
    local v53 = bit32.lshift(v49, 14)
    local v54 = bit32.lshift(v48, 23)
    local v55 = bit32.rshift(v49, 9)
    local v56 = bit32.bxor(v50, v51, v52, v53, v54, v55)
    local v57 = bit32.rshift(v49, 14)
    local v58 = bit32.lshift(v48, 18)
    local v59 = bit32.rshift(v49, 18)
    local v60 = bit32.lshift(v48, 14)
    local v61 = bit32.lshift(v49, 23)
    local v62 = bit32.rshift(v48, 9)
    return v56, (bit32.bxor(v57, v58, v59, v60, v61, v62))
end

function processBlocks(v63, v64, v65, v66, v67) -- line 228 | captures: v1, v2, v3, v4
    local v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81, v82, v83 = v63[1], v63[2], v63[3], v63[4], v63[5], v63[6], v63[7], v63[8], v64[1], v64[2], v64[3], v64[4], v64[5], v64[6], v64[7], v64[8]
    for v84 = v66, v67, 128 do
        local v85 = v84
        for v86 = 1, 16 do
            local v87 = v85 + 7
            local v88, v89, v90, v91, v92, v93, v94, v95 = string.byte(v65, v85, v87)
            local v96 = bit32.lshift(v88, 24)
            local v97 = bit32.lshift(v89, 16)
            local v98 = bit32.lshift(v90, 8)
            v1[v86] = bit32.bor(v96, v97, v98, v91)
            local v99 = bit32.lshift(v92, 24)
            local v100 = bit32.lshift(v93, 16)
            local v101 = bit32.lshift(v94, 8)
            v2[v86] = bit32.bor(v99, v100, v101, v95)
            v85 += 8
        end
        for v102 = 17, 80 do
            local v103, v104 = lil_sig0(v1[v102 - 15], v2[v102 - 15])
            local v105, v106 = lil_sig1(v1[v102 - 2], v2[v102 - 2])
            local v107 = v2[v102 - 16] + v104 + v2[v102 - 7] + v106
            v2[v102] = bit32.bor(v107, 0)
            v1[v102] = v1[v102 - 16] + v103 + v1[v102 - 7] + v105 + v107 // 4294967296
        end
        local v108 = v68
        local v109 = v69
        local v110 = v70
        local v111 = v71
        local v112 = v72
        local v113 = v73
        local v114 = v74
        local v115 = v75
        local v116 = v76
        local v117 = v77
        local v118 = v78
        local v119 = v79
        local v120 = v80
        local v121 = v81
        local v122 = v82
        local v123 = v83
        for v124 = 1, 80 do
            local v125, v126 = big_sig0(v108, v116)
            local v127, v128 = big_sig1(v112, v120)
            local v129 = bit32.band(v120, v121)
            local v130 = -1 - v120
            local v131 = bit32.band(v130, v122)
            local v132 = v123 + v128 + bit32.bor(v129, v131, 0) + v4[v124] + v2[v124]
            local v133 = bit32.band(v112, v113)
            local v134 = -1 - v112
            local v135 = bit32.band(v134, v114)
            local v136 = v115 + v127 + bit32.bor(v133, v135, 0) + v3[v124] + v1[v124] + v132 // 4294967296
            local v137 = bit32.bor(v132, 0)
            local v138 = v126 + bit32.band(v118, v117)
            local v139 = bit32.bxor(v118, v117)
            local v140 = v138 + bit32.band(v116, v139)
            local v141 = v125 + bit32.band(v110, v109)
            local v142 = bit32.bxor(v110, v109)
            local v143 = v141 + bit32.band(v108, v142)
            local v144 = v137 + v119
            local v145 = v136 + v111 + v144 // 4294967296
            local v146 = bit32.bor(v144, 0)
            local v147 = v137 + v140
            v108, v109, v110, v111, v112, v113, v114, v115, v116, v117, v118, v119, v120, v121, v122, v123 = v136 + v143 + v147 // 4294967296, v108, v109, v110, v145, v112, v113, v114, bit32.bor(v147, 0), v116, v117, v118, v146, v120, v121, v122
        end
        local v148 = v76 + v116
        local v149 = v68 + v108 + v148 // 4294967296
        v68 = bit32.bor(v149, 0)
        v76 = bit32.bor(v148, 0)
        local v150 = v77 + v117
        local v151 = v69 + v109 + v150 // 4294967296
        v69 = bit32.bor(v151, 0)
        v77 = bit32.bor(v150, 0)
        local v152 = v78 + v118
        local v153 = v70 + v110 + v152 // 4294967296
        v70 = bit32.bor(v153, 0)
        v78 = bit32.bor(v152, 0)
        local v154 = v79 + v119
        local v155 = v71 + v111 + v154 // 4294967296
        v71 = bit32.bor(v155, 0)
        v79 = bit32.bor(v154, 0)
        local v156 = v80 + v120
        local v157 = v72 + v112 + v156 // 4294967296
        v72 = bit32.bor(v157, 0)
        v80 = bit32.bor(v156, 0)
        local v158 = v81 + v121
        local v159 = v73 + v113 + v158 // 4294967296
        v73 = bit32.bor(v159, 0)
        v81 = bit32.bor(v158, 0)
        local v160 = v82 + v122
        local v161 = v74 + v114 + v160 // 4294967296
        v74 = bit32.bor(v161, 0)
        v82 = bit32.bor(v160, 0)
        local v162 = v83 + v123
        local v163 = v75 + v115 + v162 // 4294967296
        v75, v83 = bit32.bor(v163, 0), bit32.bor(v162, 0)
    end
    v63[1] = v68
    v64[1] = v76
    v63[2] = v69
    v64[2] = v77
    v63[3] = v70
    v64[3] = v78
    v63[4] = v71
    v64[4] = v79
    v63[5] = v72
    v64[5] = v80
    v63[6] = v73
    v64[6] = v81
    v63[7] = v74
    v64[7] = v82
    v63[8] = v75
    v64[8] = v83
end

function sha384(v164) -- line 371
    local v165 = { 3418070365, 1654270250, 2438529370, 355462360, 1731405415, 2394180231, 3675008525, 1203062813 }
    local v166 = { 3238371032, 914150663, 812702999, 4144912697, 4290775857, 1750603025, 1694076839, 3204075428 }
    local v167 = #v164
    if v167 > 1125899906842624 then
        error("cannot calculate the SHA-384 hash of a string longer than 2^50 bytes", 2)
    end
    local v168 = v167 % 128
    if v167 >= 128 then
        processBlocks(v165, v166, v164, 1, v167 - v168)
    end
    local v169 = v168 + 64
    local v170 = bit32.band(v169, 4294963200)
    local v171 = {}
    local v172
    if v168 == 0 then
        v172 = ""
    else
        local v173 = -v168
        v172 = string.sub(v164, v173)
    end
    local v174 = string.rep("\000", (v170 - v168 - 17) % 128)
    local v175 = string.pack(">L", v167 * 8 / 4294967296)
    v171[1] = v172
    v171[2] = "\128"
    v171[3] = v174
    v171[4] = v175
    local pack = string.pack
    local v176 = v167 * 8
    v171[5] = pack(">L", (bit32.bor(v176)))
    local v177 = table.concat(v171)
    processBlocks(v165, v166, v177, 1, #v177)
    local v178 = buffer.create(48)
    for v179 = 1, 6 do
        local v180 = (v179 - 1) * 8
        local v181 = v165[v179]
        local v182 = bit32.byteswap(v181)
        buffer.writeu32(v178, v180, v182)
        local v183 = (v179 - 1) * 8 + 4
        local v184 = v166[v179]
        local v185 = bit32.byteswap(v184)
        buffer.writeu32(v178, v183, v185)
    end
    return v178
end

local v186 = {
    Name = "SHA-384",
    BlockSize = 128,
    OutputSize = 48,
    Digest = function(v187) -- Digest | line 430
        return buffer.tostring(sha384(v187))
    end,
    DigestBuffer = function(v188) -- DigestBuffer | line 433
        return sha384(buffer.tostring(v188))
    end,
    DigestToBuffer = sha384
}
table.freeze(v186)
return v186
