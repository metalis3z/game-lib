-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1[0] = -12336
v1[1] = -12592
v1[2] = -12848
v1[3] = -13104
v1[4] = -13360
v1[5] = -13616
v1[6] = -13872
v1[7] = -14128
v1[8] = 25180
v1[9] = 29788
v1[10] = 28252
v1[11] = -25136
v1[12] = 26204
v1[13] = 29276
v1[14] = -25904
v1[15] = -26160
v1[16] = -12337
v1[17] = -12593
v1[18] = -12849
v1[19] = -13105
v1[20] = -13361
v1[21] = -13617
v1[22] = -13873
v1[23] = -14129
v1[24] = -14385
v1[25] = -14641
v1[26] = -24881
v1[27] = -25137
v1[28] = -25393
v1[29] = -25649
v1[30] = -25905
v1[31] = -26161

local v2 = {}

v2[36] = true
v2[95] = true

local v3 = {}

v3[36] = true
v3[95] = true
for v4 = 65, 90 do
    v2[v4] = true
    v3[v4] = true
end
for v5 = 97, 122 do
    v2[v5] = true
    v3[v5] = true
end
v3[48] = true
v3[49] = true
v3[50] = true
v3[51] = true
v3[52] = true
v3[53] = true
v3[54] = true
v3[55] = true
v3[56] = true
v3[57] = true

local function Stream(v6) -- line 67
    return {
        Pos = 0,
        Indent = 0,
        Pretty = false,
        QuoteChar = 34,
        UnquoteIdent = false,
        Buf = v6,
        Cap = buffer.len(v6),
        Encoders = {}
    }
end

local function ToString(v7) -- line 79
    return buffer.readstring(v7.Buf, 0, v7.Pos)
end

local function AllocSize(v8) -- line 82
    local v10 = math.log(v8, 2)
    local v11 = 2 ^ math.ceil(v10)
    return (math.max(v8, v11))
end

local function Reserve(v12, v13) -- line 85
    local Pos = v12.Pos
    local v14 = Pos + v13
    if v12.Cap < v14 then
        local v15 = math.log(v14, 2)
        local v16 = 2 ^ math.ceil(v15)
        local v17 = math.max(v14, v16)
        local v18 = buffer.create(v17)
        buffer.copy(v18, 0, v12.Buf, 0, Pos)
        v12.Buf = v18
        v12.Cap = v17
    end
    v12.Pos = v14
    return Pos
end

local function WriteString(v19, v20) -- line 98 | captures: Reserve
    local v21 = string.len(v20)
    local v22 = Reserve(v19, v21)
    buffer.writestring(v19.Buf, v22, v20, v21)
end

local function WriteIndent(v23) -- line 103 | captures: Reserve
    local v24 = v23.Indent * 2
    local v25 = Reserve(v23, v24)
    local v26 = v24 - 1
    for v27 = 0, v26 do
        local Buf = v23.Buf
        local v28 = v25 + v27 * 2
        buffer.writeu16(Buf, v28, 8224)
    end
end

local function IncrementIndent(v29, v30) -- line 112
    v29.Indent += v30
end

local function WriteU8(v31, v32) -- line 115 | captures: Reserve
    local v33 = Reserve(v31, 1)
    local Buf = v31.Buf
    buffer.writeu8(Buf, v33, v32)
end

local function WriteU16(v34, v35) -- line 119 | captures: Reserve
    local v36 = Reserve(v34, 2)
    local Buf = v34.Buf
    buffer.writeu16(Buf, v36, v35)
end

local function WriteU32(v37, v38) -- line 123 | captures: Reserve
    local v39 = Reserve(v37, 4)
    local Buf = v37.Buf
    buffer.writeu32(Buf, v39, v38)
end

local function EncodeNumber(v40, v41) -- line 127 | captures: Reserve
    if v41 == v41 then
        if v41 == (1/0) then
            local v42 = Reserve(v40, 8)
            local Buf = v40.Buf
            buffer.writeu32(Buf, v42, 1768320585)
            local v43 = v42 + 4
            buffer.writeu32(Buf, v43, 2037672302)
        elseif v41 == (-1/0) then
            local v44 = Reserve(v40, 9)
            local Buf = v40.Buf
            buffer.writeu8(Buf, v44, 45)
            local v45 = v44 + 1
            buffer.writeu32(Buf, v45, 1768320585)
            local v46 = v44 + 5
            buffer.writeu32(Buf, v46, 2037672302)
        else
            local v47 = tostring(v41)
            local v48 = string.find(v47, "e%+")
            if v48 then
                local v49 = string.sub(v47, 1, v48)
                local v50 = v48 + 2
                v47 = v49 .. string.sub(v47, v50)
            end
            local v51 = string.len(v47)
            local v52 = Reserve(v40, v51)
            buffer.writestring(v40.Buf, v52, v47, v51)
        end
    else
        local v53 = Reserve(v40, 3)
        local Buf = v40.Buf
        buffer.writeu16(Buf, v53, 24910)
        local v54 = v53 + 2
        buffer.writeu8(Buf, v54, 78)
    end
end

local function IsIdentifierName(v55, v56) -- line 162 | captures: v2, v3
    local v57 = string.len(v56)
    if v57 ~= 0 then
        local v58 = string.byte(v56, 1)
        if v2[v58] then
            for v59 = 2, v57 do
                if not v3[string.byte(v56, v59)] then
                    return false
                end
            end
            return true
        end
    end
    return false
end

local function EncodeString(v60, v61, v62) -- line 180 | captures: v1, v2, v3, Reserve
    if v62 then
        local v63 = string.len(v61)
        if v63 ~= 0 then
            local v64 = string.byte(v61, 1)
            if v2[v64] then
                for v65 = 2, v63 do
                    if not v3[string.byte(v61, v65)] then
                        local v66 = string.len(v61)
                        local v67 = Reserve(v60, v66 * 6 + 2)
                        local Buf = v60.Buf
                        local QuoteChar = v60.QuoteChar
                        buffer.writeu8(Buf, v67, QuoteChar)
                        local v68 = v67 + 1
                        for v69 = 1, v66 do
                            local v70 = string.byte(v61, v69)
                            if v70 <= 31 then
                                local v71 = v1[v70]
                                local v72
                                if v71 < 0 then
                                    v71 = -v71
                                    buffer.writeu32(Buf, v68, 808482140)
                                    v72 = v68 + 4
                                else
                                    v72 = v68
                                end
                                buffer.writeu16(Buf, v72, v71)
                                v68 = v72 + 2
                            elseif v70 == QuoteChar then
                                local v73 = bit32.lshift(v70, 8) + 92
                                buffer.writeu16(Buf, v68, v73)
                                v68 += 2
                            elseif v70 ~= 92 then
                                buffer.writeu8(Buf, v68, v70)
                                v68 += 1
                            end
                        end
                        buffer.writeu8(Buf, v68, QuoteChar)
                        v60.Pos = v68 + 1
                        return
                    end
                end
            end
        end
    end
end

local function EncodeAny(v74, v75) -- line 248
    local v76
    if v75 == v74.Null then
    else
        v76 = v75
    end
    v74.Encoders[typeof(v76)](v74, v76)
end

local function EncodeArray(v77, v78) -- line 258 | captures: Reserve
    local Pretty = v77.Pretty
    local v79 = Reserve(v77, 1)
    local Buf = v77.Buf
    buffer.writeu8(Buf, v79, 91)
    if Pretty then
        v77.Indent += 1
    end
    for v80, v81 in ipairs(v78) do
        if v80 > 1 then
            local v82 = Reserve(v77, 1)
            local Buf = v77.Buf
            buffer.writeu8(Buf, v82, 44)
        end
        if Pretty then
            local v83 = Reserve(v77, 1)
            local Buf = v77.Buf
            buffer.writeu8(Buf, v83, 10)
            local v84 = v77.Indent * 2
            local v85 = Reserve(v77, v84)
            local v86 = v84 - 1
            for v87 = 0, v86 do
                local Buf = v77.Buf
                local v88 = v85 + v87 * 2
                buffer.writeu16(Buf, v88, 8224)
            end
        end
        local v89
        if v81 == v77.Null then
        else
            v89 = v81
        end
        v77.Encoders[typeof(v89)](v77, v89)
    end
    if Pretty then
        v77.Indent += -1
        if #v78 > 0 then
            local v90 = Reserve(v77, 1)
            local Buf = v77.Buf
            buffer.writeu8(Buf, v90, 10)
            local v91 = v77.Indent * 2
            local v92 = Reserve(v77, v91)
            local v93 = v91 - 1
            for v94 = 0, v93 do
                local Buf = v77.Buf
                local v95 = v92 + v94 * 2
                buffer.writeu16(Buf, v95, 8224)
            end
        end
    end
    local v96 = Reserve(v77, 1)
    local Buf_2 = v77.Buf
    buffer.writeu8(Buf_2, v96, 93)
end

local function EncodeMap(v97, v98) -- line 307 | captures: Reserve, EncodeString
    local v99 = {}
    for v100, v101 in pairs(v98) do
        local v102 = type(v100) == "string"
        assert(v102)
        table.insert(v99, v100)
    end
    table.sort(v99)
    local Pretty = v97.Pretty
    local UnquoteIdent = v97.UnquoteIdent
    local v103 = Reserve(v97, 1)
    local Buf = v97.Buf
    buffer.writeu8(Buf, v103, 123)
    if Pretty then
        v97.Indent += 1
    end
    for v104, v105 in ipairs(v99) do
        if v104 > 1 then
            local v106 = Reserve(v97, 1)
            local Buf = v97.Buf
            buffer.writeu8(Buf, v106, 44)
        end
        if Pretty then
            local v107 = Reserve(v97, 1)
            local Buf = v97.Buf
            buffer.writeu8(Buf, v107, 10)
            local v108 = v97.Indent * 2
            local v109 = Reserve(v97, v108)
            local v110 = v108 - 1
            for v111 = 0, v110 do
                local Buf = v97.Buf
                local v112 = v109 + v111 * 2
                buffer.writeu16(Buf, v112, 8224)
            end
        end
        EncodeString(v97, v105, UnquoteIdent)
        if Pretty then
            local v113 = Reserve(v97, 2)
            local Buf = v97.Buf
            buffer.writeu16(Buf, v113, 8250)
        else
            local v114 = Reserve(v97, 1)
            local Buf = v97.Buf
            buffer.writeu8(Buf, v114, 58)
        end
        local v115 = v9[v105]
        if v115 == v97.Null then
            v115 = nil
        end
        v97.Encoders[typeof(v115)](v97, v115)
    end
    if Pretty then
        v97.Indent += -1
        if #v99 > 0 then
            local v116 = Reserve(v97, 1)
            local Buf = v97.Buf
            buffer.writeu8(Buf, v116, 10)
            local v117 = v97.Indent * 2
            local v118 = Reserve(v97, v117)
            local v119 = v117 - 1
            for v120 = 0, v119 do
                local Buf = v97.Buf
                local v121 = v118 + v120 * 2
                buffer.writeu16(Buf, v121, 8224)
            end
        end
    end
    local v122 = Reserve(v97, 1)
    local Buf_2 = v97.Buf
    buffer.writeu8(Buf_2, v122, 125)
end

local v123 = {}

v123["nil"] = function(v124, v125) -- line 373 | captures: Reserve
    local v126 = Reserve(v124, 4)
    local Buf = v124.Buf
    buffer.writeu32(Buf, v126, 1819047278)
end

function v123.boolean(v127, v128) -- line 377 | captures: Reserve
    if v128 then
        local v129 = Reserve(v127, 4)
        local Buf = v127.Buf
        buffer.writeu32(Buf, v129, 1702195828)
    else
        local v130 = Reserve(v127, 5)
        local Buf = v127.Buf
        buffer.writeu32(Buf, v130, 1936482662)
        local v131 = v130 + 4
        buffer.writeu8(Buf, v131, 101)
    end
end

v123.number = EncodeNumber
v123.string = EncodeString

function v123.buffer(v132, v133) -- line 391 | captures: v1, Reserve
    local v134 = buffer.len(v133)
    local v135 = Reserve(v132, 2 + v134 * 6)
    local Buf = v132.Buf
    local QuoteChar = v132.QuoteChar
    buffer.writeu8(Buf, v135, QuoteChar)
    local v136 = v135 + 1
    local v137 = v134 - 1
    for v138 = 0, v137 do
        local v139 = buffer.readu8(v133, v138)
        if v139 <= 31 then
            local v140 = v1[v139]
            local v141
            if v140 < 0 then
                v140 = -v140
                buffer.writeu32(Buf, v136, 808482140)
                v141 = v136 + 4
            else
                v141 = v136
            end
            buffer.writeu16(Buf, v141, v140)
            v136 = v141 + 2
        elseif v139 == QuoteChar then
            local v142 = bit32.lshift(v139, 8) + 92
            buffer.writeu16(Buf, v136, v142)
            v136 += 2
        elseif v139 ~= 92 then
            buffer.writeu8(Buf, v136, v139)
            v136 += 1
        end
    end
    buffer.writeu8(Buf, v136, QuoteChar)
    v132.Pos = v136 + 1
end

function v123.table(v143, v144) -- line 424 | captures: EncodeArray, EncodeMap
    if #v144 > 0 or next(v144) == nil then
        EncodeArray(v143, v144)
    else
        EncodeMap(v143, v144)
    end
end

local v145 = table.clone(v123)

function v145.Vector2(v146, v147) -- line 432 | captures: EncodeArray
    EncodeArray(v146, {
        v147.X,
        v147.Y
    })
end

function v145.Vector3(v148, v149) -- line 435 | captures: EncodeArray
    EncodeArray(v148, {
        v149.X,
        v149.Y,
        v149.Z
    })
end

function v145.Vector2int16(v150, v151) -- line 438 | captures: EncodeArray
    EncodeArray(v150, {
        v151.X,
        v151.Y
    })
end

function v145.Vector3int16(v152, v153) -- line 441 | captures: EncodeArray
    EncodeArray(v152, {
        v153.X,
        v153.Y,
        v153.Z
    })
end

function v145.Region3(v154, v155) -- line 444 | captures: EncodeArray
    local v156 = v155.CFrame * (v155.Size * -0.5)
    local v157 = v155.CFrame * (v155.Size * 0.5)
    EncodeArray(v154, {
        v156.X,
        v156.Y,
        v156.Z,
        v157.X,
        v157.Y,
        v157.Z
    })
end

function v145.Region3int16(v158, v159) -- line 456 | captures: EncodeArray
    EncodeArray(v158, {
        v159.Min.X,
        v159.Min.Y,
        v159.Min.Z,
        v159.Max.X,
        v159.Max.Y,
        v159.Max.Z
    })
end

function v145.UDim(v160, v161) -- line 466 | captures: EncodeArray
    EncodeArray(v160, {
        v161.Scale,
        v161.Offset
    })
end

function v145.UDim2(v162, v163) -- line 469 | captures: EncodeArray
    EncodeArray(v162, {
        v163.X.Scale,
        v163.X.Offset,
        v163.Y.Scale,
        v163.Y.Offset
    })
end

function v145.CFrame(v164, v165) -- line 472 | captures: EncodeArray
    EncodeArray(v164, { v165:GetComponents() })
end

function v145.Color3(v166, v167) -- line 475 | captures: EncodeArray
    local v168 = {}
    local v169 = v167.R * 255
    local v170 = math.round(v169)
    local v171 = v167.G * 255
    local v172 = math.round(v171)
    v168[1] = v170
    v168[2] = v172
    local v173 = v167.B * 255
    v168[3] = math.round(v173)
    EncodeArray(v166, v168)
end

function v145.NumberRange(v174, v175) -- line 484 | captures: EncodeArray
    EncodeArray(v174, {
        v175.Min,
        v175.Max
    })
end

function v145.Rect(v176, v177) -- line 487 | captures: EncodeArray
    EncodeArray(v176, {
        v177.Min.X,
        v177.Min.Y,
        v177.Max.X,
        v177.Max.Y
    })
end

function v145.EnumItem(v178, v179) -- line 490 | captures: EncodeNumber
    EncodeNumber(v178, v179.Value)
end

local v180 = buffer.create(4096)
local v181 = Stream(v180)

v181.Encoders = v123

local v182 = Stream(v180)

v182.Encoders = v123
v182.Pretty = true

local v183 = Stream(v180)

v183.Encoders = v145

local v184 = Stream(v180)

v184.Encoders = v145
v184.Pretty = true

local v185 = Stream(v180)

v185.Encoders = v123
v185.UnquoteIdent = true
v185.QuoteChar = 39

local v186 = Stream(v180)

v186.Encoders = v123
v186.Pretty = true
v186.UnquoteIdent = true
v186.QuoteChar = 39

local freeze = table.freeze
local v187 = {}

function v187.Compact(v188, v189) -- line 514 | captures: ToString, v181
    v181.Pos = 0
    v181.Null = v189
    local v190
    if v188 == v181.Null then
    else
        v190 = v188
    end
    v181.Encoders[typeof(v190)](v181, v190)
    return ToString(v181)
end

function v187.Pretty(v191, v192) -- line 526 | captures: ToString, v182
    v182.Pos = 0
    v182.Indent = 0
    v182.Null = v192
    local v193
    if v191 == v182.Null then
    else
        v193 = v191
    end
    v182.Encoders[typeof(v193)](v182, v193)
    return ToString(v182)
end

function v187.CompactExt(v194, v195) -- line 539 | captures: ToString, v183
    v183.Pos = 0
    v183.Null = v195
    local v196
    if v194 == v183.Null then
    else
        v196 = v194
    end
    v183.Encoders[typeof(v196)](v183, v196)
    return ToString(v183)
end

function v187.PrettyExt(v197, v198) -- line 551 | captures: ToString, v184
    v184.Pos = 0
    v184.Indent = 0
    v184.Null = v198
    local v199
    if v197 == v184.Null then
    else
        v199 = v197
    end
    v184.Encoders[typeof(v199)](v184, v199)
    return ToString(v184)
end

function v187.Compact5(v200, v201) -- line 564 | captures: ToString, v185
    v185.Pos = 0
    v185.Null = v201
    local v202
    if v200 == v185.Null then
    else
        v202 = v200
    end
    v185.Encoders[typeof(v202)](v185, v202)
    return ToString(v185)
end

function v187.Pretty5(v203, v204) -- line 576 | captures: ToString, v186
    v186.Pos = 0
    v186.Indent = 0
    v186.Null = v204
    local v205
    if v203 == v186.Null then
    else
        v205 = v203
    end
    v186.Encoders[typeof(v205)](v186, v205)
    return ToString(v186)
end

return freeze(v187)
