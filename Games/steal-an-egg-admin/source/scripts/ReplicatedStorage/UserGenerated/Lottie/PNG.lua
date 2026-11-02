-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Types)
local chunks = require(script.chunks)
local crc32 = require(script.crc32)
local zlib = require(script.zlib)
local v1 = {}

v1[0] = 1
v1[2] = 3
v1[3] = 1
v1[4] = 2
v1[6] = 4

local v2 = { 0, 0, 4, 0, 2, 0, 1 }
local v3 = { 0, 4, 0, 2, 0, 1, 0 }
local v4 = { 8, 8, 8, 4, 4, 2, 2 }
local v5 = { 8, 8, 4, 4, 2, 2, 1 }
local v6 = {}

function v6.decode(v7, v8) -- line 53 | captures: chunks, crc32, zlib, v1, v2, v3, v4, v5
    local v9 = buffer.len(v7)
    local v10 = v9 >= 8
    assert(v10, "not a PNG")
    local v11 = buffer.readstring(v7, 0, 8) == "\137PNG\r\n\026\n"
    assert(v11, "not a PNG")
    local v12 = table.create(3)
    local v13 = if v8 == nil then false else v8.allowIncorrectCRC == true
    local v14 = 8
    local v15
    while true do
        local v16 = buffer.readu32(v7, v14)
        local v17 = bit32.byteswap(v16)
        local v18 = buffer.readstring(v7, v14 + 4, 4)
        local v19 = string.match(v18, "%a%a%a%a")
        local v20 = ("invalid chunk type %*"):format(v18)
        assert(v19, v20)
        local v21 = v14 + 8
        v15 = v21 + v17 + 4
        local v22 = v15 <= v9
        local v23 = ("EOF while reading %* chunk"):format(v18)
        assert(v22, v23)
        local v24 = v15 - 4
        local v25 = buffer.readu32(v7, v24)
        local v26 = bit32.byteswap(v25)
        local v27 = crc32(v7, v14 + 4, v15 - 5)
        local v28 = v13 or v26 == v27
        local v29 = ("incorrect checksum in %*"):format(v18)
        assert(v28, v29)
        local v30 = {
            type = v18,
            offset = v21,
            length = v17
        }
        table.insert(v12, v30)
        if v9 <= v15 then
            break
        end
        v14 = v15
    end
    local v31 = v15 == v9
    assert(v31, "trailing data in file")
    for v32, v33 in v12 do
        local type = v33.type
        local v34 = string.byte(type, 1, 1)
        if bit32.extract(v34, 5) == 0 and type ~= "IHDR" and type ~= "IDAT" and type ~= "PLTE" and type ~= "IEND" then
            error((("unhandled critical chunk %*"):format(type)))
        end
    end
    local v35 = v12[1]
    local v36 = v35.type == "IHDR"
    assert(v36, "first chunk must be IHDR")
    local v37 = #v12
    for v38 = 2, v37 do
        local v39 = v12[v38].type ~= "IHDR"
        assert(v39, "multiple IHDR chunks are not allowed")
    end
    local v40 = chunks.IHDR(v7, v35)
    local v41 = 0
    local v42 = -1
    local v43 = -1
    for v44, v45 in v12 do
        if v45.type == "IDAT" then
            if v42 >= 0 then
                local v46 = v44 == v43 + 1
                assert(v46, "multiple IDAT chunks must be consecutive")
            else
                v42 = v44
            end
            v41 += v45.length
            v43 = v44
        end
    end
    local v47 = v42 > 0
    assert(v47, "no IDAT chunks")
    local v48 = v41 > 0
    assert(v48, "no image data in IDAT chunks")
    local v49
    local v50 = -1
    for v51, v52 in v12 do
        if v52.type == "PLTE" then
            local v53 = not v49
            assert(v53, "multiple PLTE chunks are not allowed")
            local v54 = v51 < v42
            assert(v54, "PLTE not allowed after IDAT chunks")
            local v55 = if v40.colorType == 0 then false else v40.colorType ~= 4
            assert(v55, "PLTE not allowed for color type")
            v49 = chunks.PLTE(v7, v52, v40)
            v50 = v51
        end
    end
    if v40.colorType == 3 then
        local v56 = v49 ~= nil
        assert(v56, "color type requires a PLTE chunk")
    end
    local v57
    for v58, v59 in v12 do
        if v59.type == "tRNS" then
            local v60 = v57 == nil
            assert(v60, "multiple tRNS chunks are not allowed")
            local v61 = v58 < v42
            assert(v61, "tRNS not allowed after IDAT chunks")
            local v62 = not v49 or v50 < v58
            assert(v62, "tRNS must be after PLTE")
            local v63 = if v40.colorType == 4 then false else v40.colorType ~= 6
            assert(v63, "tRNS not allowed for color type")
            v57 = chunks.tRNS(v7, v59, v40, v49)
        end
    end
    local v64 = v12[#v12]
    local v65 = v64.type == "IEND"
    assert(v65, "final chunk must be IEND")
    local v66 = v64.length == 0
    assert(v66, "IEND chunk must be empty")
    local v67 = #v12 - 1
    for v68 = 2, v67 do
        local v69 = v12[v68].type ~= "IEND"
        assert(v69, "multiple IEND chunks are not allowed")
    end
    local v70 = buffer.create(v41)
    local v71 = 0
    for v72, v73 in v12 do
        if v73.type == "IDAT" then
            buffer.copy(v70, v71, v7, v73.offset, v73.length)
            v71 += v73.length
        end
    end
    local width = v40.width
    local height = v40.height
    local bitDepth = v40.bitDepth
    local colorType = v40.colorType
    local v74 = v1[colorType]
    local v75
    if v40.interlaced then
        v75 = 0
        for v76 = 1, 7 do
            local v77 = (width - v3[v76]) / v5[v76]
            local v78 = math.ceil(v77)
            local v79 = (height - v2[v76]) / v4[v76]
            local v80 = math.ceil(v79)
            if v78 > 0 and v80 > 0 then
                local v81 = v78 * v74 * bitDepth / 8
                v75 += v80 * (math.ceil(v81) + 1)
            end
        end
    else
        local v82 = width * v74 * bitDepth / 8
        v75 = height * (math.ceil(v82) + 1)
    end
    local v83 = if v49 then v49.colors else nil
    local v84
    if not (colorType ~= 3 and bitDepth < 8) then
    else
        v84 = 255 / (2 ^ bitDepth - 1)
    end
    local v85 = v74 * bitDepth / 8
    local v86 = math.ceil(v85)
    local v87 = 2 ^ bitDepth - 1
    local v88 = 0
    local v89 = buffer.create(v75)
    local v90 = zlib.inflate(v70, v89) == v75
    assert(v90, "decompressed data size mismatch")
    local v91 = buffer.create(width * height * 4)
    local v92, v93, v94, v95
    if v57 then
        v93 = v57.gray
        v95 = v57.red
        v94 = v57.green
        v92 = v57.blue
    else
        v93 = -1
        v95 = -1
        v94 = -1
        v92 = -1
    end
    local v96 = v84

    local function pass(v97, v98, v99, v100) -- line 248 | captures: v92, v83, v93, v94, v95, v88, width, height, bitDepth, colorType, v74, v86, v87, v89, v91, v96
        local v101 = (width - v97) / v99
        local v102 = math.ceil(v101)
        local v103 = (height - v98) / v100
        v101 = math.ceil(v103)
        if v102 < 1 or v101 < 1 then
            return
        end
        local v104 = v102 * v74 * bitDepth / 8
        v103 = math.ceil(v104)
        local v105 = v88
        local v106, v107, v108, v109
        for v110 = 1, v101 do
            local v111 = v88
            local v112 = buffer.readu8(v89, v111)
            v88 += 1
            if v112 == 0 then
                v88 += v103
            elseif v112 ~= 2 then
                if v112 == 1 then
                    for v113 = 1, v103 do
                        local v114
                        if v86 < v113 then
                            v108 = v88 - v86
                            v114 = buffer.readu8(v89, v108)
                        else
                            v114 = 0
                        end
                        v108 = v88
                        v106 = buffer.readu8(v89, v108) + v114
                        local v115 = bit32.band(v106, 255)
                        v108 = v88
                        buffer.writeu8(v89, v108, v115)
                        v88 += 1
                    end
                elseif v112 == 2 then
                    for v116 = 1, v103 do
                        v108 = v88
                        local v117 = buffer.readu8(v89, v108)
                        v109 = v88 - v103 - 1
                        v106 = v117 + buffer.readu8(v89, v109)
                        v117 = bit32.band(v106, 255)
                        v108 = v88
                        buffer.writeu8(v89, v108, v117)
                        v88 += 1
                    end
                elseif v112 == 3 then
                    for v118 = 1, v103 do
                        local v119
                        if v86 < v118 then
                            v108 = v88 - v86
                            v119 = buffer.readu8(v89, v108)
                        else
                            v119 = 0
                        end
                        local v120
                        if v110 == 1 then
                            v120 = 0
                        else
                            v108 = v88 - v103 - 1
                            v120 = buffer.readu8(v89, v108)
                        end
                        v108 = v88
                        local v121 = buffer.readu8(v89, v108)
                        local v122 = v119 + v120
                        local v123 = v121 + bit32.rshift(v122, 1)
                        v106 = bit32.band(v123, 255)
                        v108 = v88
                        buffer.writeu8(v89, v108, v106)
                        v88 += 1
                    end
                elseif v112 == 4 then
                    for v124 = 1, v103 do
                        local v125
                        if v86 < v124 then
                            v108 = v88 - v86
                            v125 = buffer.readu8(v89, v108)
                        else
                            v125 = 0
                        end
                        local v126
                        if v110 == 1 then
                            v126 = 0
                        else
                            v108 = v88 - v103 - 1
                            v126 = buffer.readu8(v89, v108)
                        end
                        if v124 <= v86 then
                            v106 = 0
                        elseif v110 ~= 1 then
                            v108 = v88 - v103 - v86 - 1
                            v106 = buffer.readu8(v89, v108)
                        end
                        local v127 = v126 - v106
                        local v128 = math.abs(v127)
                        v127 = v125 - v106
                        local v129 = math.abs(v127)
                        v127 = v125 + v126 - v106 * 2
                        local v130 = math.abs(v127)
                        if v129 < v128 then
                            if v130 < v129 then
                                v107 = v106
                            else
                                v107 = v126
                            end
                        elseif v128 <= v130 then
                            v107 = v125
                        end
                        v108 = v88
                        local v131 = buffer.readu8(v89, v108) + v107
                        v128 = bit32.band(v131, 255)
                        v108 = v88
                        buffer.writeu8(v89, v108, v128)
                        v88 += 1
                    end
                else
                    error("invalid row filter")
                end
            end
        end
        local v132 = 8

        local function readValue() -- line 351 | captures: v105, v132, bitDepth, v89
            local v133 = v105
            local v134 = buffer.readu8(v89, v133)
            if bitDepth < 8 then
                local v135 = v132 - bitDepth
                local v136 = bit32.extract(v134, v135, bitDepth)
                v132 -= bitDepth
                if v132 == 0 then
                    v132 = 8
                    v105 += 1
                end
                return v136
            end
            if bitDepth == 8 then
                v105 += 1
                return v134
            end
            local v137 = bit32.lshift(v134, 8)
            local v138 = v105 + 1
            local v139 = buffer.readu8(v89, v138)
            local v140 = bit32.bor(v137, v139)
            v105 += 2
            return v140
        end

        for v141 = 1, v101 do
            v105 += 1
            if v132 < 8 then
                v132 = 8
                v105 += 1
            end
            for v142 = 1, v102 do
                local v143, v144, v145, v146
                if colorType == 0 then
                    local v147 = v105
                    v143 = buffer.readu8(v89, v147)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v143 = bit32.extract(v143, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v143, 8)
                        local v148 = v105 + 1
                        v146 = buffer.readu8(v89, v148)
                        v143 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    if v143 == v93 then
                        v145 = 0
                    else
                        v145 = v87
                    end
                    v108 = v143
                    v144 = v143
                elseif colorType == 2 then
                    local v149 = v105
                    v108 = buffer.readu8(v89, v149)
                    local v150
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v108 = bit32.extract(v108, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v108, 8)
                        v150 = v105 + 1
                        v146 = buffer.readu8(v89, v150)
                        v108 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    local v151 = v105
                    v144 = buffer.readu8(v89, v151)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v144 = bit32.extract(v144, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v144 = bit32.lshift(v144, 8)
                        v150 = v105 + 1
                        v146 = buffer.readu8(v89, v150)
                        v144 = bit32.bor(v144, v146)
                        v105 += 2
                    end
                    local v152 = v105
                    v143 = buffer.readu8(v89, v152)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v143 = bit32.extract(v143, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v143 = bit32.lshift(v143, 8)
                        v150 = v105 + 1
                        v146 = buffer.readu8(v89, v150)
                        v143 = bit32.bor(v143, v146)
                        v105 += 2
                    end
                    if v108 == v95 then
                        if v144 == v94 and v143 == v92 then
                            v145 = 0
                        end
                    else
                        v145 = v87
                    end
                elseif colorType == 3 then
                    local v153 = v105
                    v108 = buffer.readu8(v89, v153)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v108 = bit32.extract(v108, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v108, 8)
                        local v154 = v105 + 1
                        v146 = buffer.readu8(v89, v154)
                        v108 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    local v155 = v83[v108 + 1]
                    v108 = v155.r
                    v144 = v155.g
                    v143 = v155.b
                    v145 = v155.a
                elseif colorType == 4 then
                    local v156 = v105
                    v143 = buffer.readu8(v89, v156)
                    local v157
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v143 = bit32.extract(v143, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v143, 8)
                        v157 = v105 + 1
                        v146 = buffer.readu8(v89, v157)
                        v143 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    local v158 = v105
                    v145 = buffer.readu8(v89, v158)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v145 = bit32.extract(v145, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v145, 8)
                        v157 = v105 + 1
                        v146 = buffer.readu8(v89, v157)
                        v145 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    v144 = v143
                    v108 = v143
                elseif colorType == 6 then
                    local v159 = v105
                    v108 = buffer.readu8(v89, v159)
                    local v160
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v108 = bit32.extract(v108, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v108 = bit32.lshift(v108, 8)
                        v160 = v105 + 1
                        v146 = buffer.readu8(v89, v160)
                        v108 = bit32.bor(v108, v146)
                        v105 += 2
                    end
                    local v161 = v105
                    v144 = buffer.readu8(v89, v161)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v144 = bit32.extract(v144, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v144 = bit32.lshift(v144, 8)
                        v160 = v105 + 1
                        v146 = buffer.readu8(v89, v160)
                        v144 = bit32.bor(v144, v146)
                        v105 += 2
                    end
                    local v162 = v105
                    v143 = buffer.readu8(v89, v162)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v143 = bit32.extract(v143, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v143 = bit32.lshift(v143, 8)
                        v160 = v105 + 1
                        v146 = buffer.readu8(v89, v160)
                        v143 = bit32.bor(v143, v146)
                        v105 += 2
                    end
                    local v163 = v105
                    v145 = buffer.readu8(v89, v163)
                    if bitDepth < 8 then
                        v146 = v132 - bitDepth
                        v145 = bit32.extract(v145, v146, bitDepth)
                        v132 -= bitDepth
                        if v132 == 0 then
                            v132 = 8
                            v105 += 1
                        end
                    elseif bitDepth == 8 then
                        v105 += 1
                    else
                        v145 = bit32.lshift(v145, 8)
                        v160 = v105 + 1
                        v146 = buffer.readu8(v89, v160)
                        v145 = bit32.bor(v145, v146)
                        v105 += 2
                    end
                else
                    v108 = nil
                end
                if v96 then
                    v109 = v108 * v96
                    v108 = math.round(v109)
                    v109 = v144 * v96
                    v144 = math.round(v109)
                    v109 = v143 * v96
                    v143 = math.round(v109)
                    v109 = v145 * v96
                    v145 = math.round(v109)
                elseif bitDepth == 16 then
                    v108 = bit32.rshift(v108, 8)
                    v144 = bit32.rshift(v144, 8)
                    v143 = bit32.rshift(v143, 8)
                    v145 = bit32.rshift(v145, 8)
                end
                v145 = bit32.lshift(v145, 24)
                v143 = bit32.lshift(v143, 16)
                v144 = bit32.lshift(v144, 8)
                v146 = ((nil + (v141 - 1) * nil) * width + (nil + (v142 - 1) * nil)) * 4
                local v164 = bit32.bor(v145, v143, v144, v108)
                buffer.writeu32(v91, v146, v164)
            end
        end
    end

    if v40.interlaced then
        for v165 = 1, 7 do
            pass(v3[v165], v2[v165], v5[v165], v4[v165])
        end
    else
        pass(0, 0, 1, 1)
    end
    local v166 = {
        width = width,
        height = height,
        pixels = v91
    }

    function v166.readPixel(v167, v168) -- line 620 | captures: width, height, v91
        local v169 = if v167 >= 1 and v167 <= width and v168 >= 1 then v168 <= height else false
        assert(v169, "pixel out of range")
        local v170 = ((v168 - 1) * width + v167 - 1) * 4
        local v171 = buffer.readu8(v91, v170)
        local v172 = v170 + 1
        local v173 = buffer.readu8(v91, v172)
        local v174 = v170 + 2
        local v175 = buffer.readu8(v91, v174)
        local v176 = v170 + 3
        return v171, v173, v175, (buffer.readu8(v91, v176))
    end

    return v166
end

function v6.encode(v177, v178) -- line 631 | captures: crc32, zlib
    local width = v178.width
    local height = v178.height
    local v179 = buffer.len(v177)
    local v180 = width * height * 4
    local v181 = v179 == v180
    local v182 = ("expected %* bytes, got %* bytes"):format(v180, v179)
    assert(v181, v182)
    local v183 = width * 4 + 1
    local v184 = buffer.create(height * v183)
    local v185 = height - 1
    for v186 = 0, v185 do
        local v187 = v186 * v183
        buffer.writeu8(v184, v187, 0)
        buffer.copy(v184, v187 + 1, v177, v186 * width * 4, width * 4)
    end
    local v188, v189 = zlib.deflate(v184)
    local v190 = buffer.create(v189 + 8 + 4 + 33 + 12)
    buffer.writestring(v190, 0, "\137PNG\r\n\026\n")
    local v191 = bit32.byteswap(13)
    buffer.writeu32(v190, 8, v191)
    buffer.writestring(v190, 12, "IHDR")
    local v192 = bit32.byteswap(width)
    buffer.writeu32(v190, 16, v192)
    local v193 = bit32.byteswap(height)
    buffer.writeu32(v190, 20, v193)
    buffer.writeu8(v190, 24, 8)
    buffer.writeu8(v190, 25, 6)
    buffer.writeu8(v190, 26, 0)
    buffer.writeu8(v190, 27, 0)
    buffer.writeu8(v190, 28, 0)
    local v194 = crc32(v190, 12, 28)
    local v195 = bit32.byteswap(v194)
    buffer.writeu32(v190, 29, v195)
    local v196 = bit32.byteswap(v189)
    buffer.writeu32(v190, 33, v196)
    buffer.writestring(v190, 37, "IDAT")
    buffer.copy(v190, 41, v188, 0, v189)
    local v197 = v189 + 41
    local v198 = crc32(v190, 37, v197 - 1)
    local v199 = bit32.byteswap(v198)
    buffer.writeu32(v190, v197, v199)
    local v200 = v197 + 4
    buffer.writeu32(v190, v200, 0)
    buffer.writestring(v190, v197 + 8, "IEND")
    local v201 = v197 + 12
    buffer.writeu32(v190, v201, 2187346606)
    return v190
end

return v6
