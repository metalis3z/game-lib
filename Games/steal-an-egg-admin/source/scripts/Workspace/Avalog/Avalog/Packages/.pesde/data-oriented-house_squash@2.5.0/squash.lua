-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function newcursor(v1, v2) -- line 11
    return {
        Buf = buffer.create(v1 or 8),
        Pos = v2 or 0
    }
end

local function frombuffer(v3) -- line 18
    return {
        Buf = v3,
        Pos = buffer.len(v3)
    }
end

local function tobuffer(v4) -- line 25
    local v5 = buffer.create(v4.Pos)
    buffer.copy(v5, 0, v4.Buf, 0, v4.Pos)
    return v5
end

local function tryRealloc(v6, v7) -- line 31
    local Buf = v6.Buf
    local Pos = v6.Pos
    local v8 = buffer.len(Buf)
    if not (v8 < Pos + v7) then
        return
    end
    local v9 = (v7 + Pos) / v8
    local v10 = math.log(v9, 1.5)
    local v11 = math.ceil(v10)
    local v12 = buffer.create(v8 * 1.5 ^ v11)
    buffer.copy(v12, 0, Buf, 0)
    v6.Buf = v12
end

local function pushu1(v13, v14) -- line 43 | captures: tryRealloc
    tryRealloc(v13, 1)
    local Buf = v13.Buf
    local Pos = v13.Pos
    buffer.writeu8(Buf, Pos, v14)
    v13.Pos += 1
end

local function popu1(v15) -- line 49
    v15.Pos -= 1
    local Buf = v15.Buf
    local Pos = v15.Pos
    return (buffer.readu8(Buf, Pos))
end

local function pushu2(v16, v17) -- line 54 | captures: tryRealloc
    tryRealloc(v16, 2)
    local Buf = v16.Buf
    local Pos = v16.Pos
    buffer.writeu16(Buf, Pos, v17)
    v16.Pos += 2
end

local function popu2(v18) -- line 60
    v18.Pos -= 2
    local Buf = v18.Buf
    local Pos = v18.Pos
    return (buffer.readu16(Buf, Pos))
end

local function pushu3(v19, v20) -- line 65 | captures: tryRealloc
    tryRealloc(v19, 3)
    local Buf = v19.Buf
    local Pos = v19.Pos
    buffer.writeu8(Buf, Pos, v20)
    local Buf_2 = v19.Buf
    local v21 = v19.Pos + 1
    local v22 = v20 // 256
    buffer.writeu16(Buf_2, v21, v22)
    v19.Pos += 3
end

local function popu3(v23) -- line 72
    v23.Pos -= 3
    local Buf = v23.Buf
    local Pos = v23.Pos
    local v24 = buffer.readu8(Buf, Pos)
    local Buf_2 = v23.Buf
    local v25 = v23.Pos + 1
    return v24 + buffer.readu16(Buf_2, v25) * 256
end

local function pushu4(v26, v27) -- line 79 | captures: tryRealloc
    tryRealloc(v26, 4)
    local Buf = v26.Buf
    local Pos = v26.Pos
    buffer.writeu32(Buf, Pos, v27)
    v26.Pos += 4
end

local function popu4(v28) -- line 85
    v28.Pos -= 4
    local Buf = v28.Buf
    local Pos = v28.Pos
    return (buffer.readu32(Buf, Pos))
end

local function pushu5(v29, v30) -- line 90 | captures: tryRealloc
    tryRealloc(v29, 5)
    local Buf = v29.Buf
    local Pos = v29.Pos
    buffer.writeu8(Buf, Pos, v30)
    local Buf_2 = v29.Buf
    local v31 = v29.Pos + 1
    local v32 = v30 // 256
    buffer.writeu32(Buf_2, v31, v32)
    v29.Pos += 5
end

local function popu5(v33) -- line 97
    v33.Pos -= 5
    local Buf = v33.Buf
    local Pos = v33.Pos
    local v34 = buffer.readu8(Buf, Pos)
    local Buf_2 = v33.Buf
    local v35 = v33.Pos + 1
    return v34 + buffer.readu32(Buf_2, v35) * 256
end

local function pushu6(v36, v37) -- line 104 | captures: tryRealloc
    tryRealloc(v36, 6)
    local Buf = v36.Buf
    local Pos = v36.Pos
    buffer.writeu16(Buf, Pos, v37)
    local Buf_2 = v36.Buf
    local v38 = v36.Pos + 2
    local v39 = v37 // 65536
    buffer.writeu32(Buf_2, v38, v39)
    v36.Pos += 6
end

local function popu6(v40) -- line 111
    v40.Pos -= 6
    local Buf = v40.Buf
    local Pos = v40.Pos
    local v41 = buffer.readu16(Buf, Pos)
    local Buf_2 = v40.Buf
    local v42 = v40.Pos + 2
    return v41 + buffer.readu32(Buf_2, v42) * 65536
end

local function pushu7(v43, v44) -- line 118 | captures: tryRealloc
    tryRealloc(v43, 7)
    local Buf = v43.Buf
    local Pos = v43.Pos
    buffer.writeu8(Buf, Pos, v44)
    local Buf_2 = v43.Buf
    local v45 = v43.Pos + 1
    local v46 = v44 // 256
    buffer.writeu16(Buf_2, v45, v46)
    local Buf_3 = v43.Buf
    local v47 = v43.Pos + 3
    local v48 = v44 // 16777216
    buffer.writeu32(Buf_3, v47, v48)
    v43.Pos += 7
end

local function popu7(v49) -- line 126
    v49.Pos -= 7
    local Buf = v49.Buf
    local Pos = v49.Pos
    local v50 = buffer.readu8(Buf, Pos)
    local Buf_2 = v49.Buf
    local v51 = v49.Pos + 1
    local v52 = buffer.readu16(Buf_2, v51)
    local Buf_3 = v49.Buf
    local v53 = v49.Pos + 3
    local v54 = buffer.readu32(Buf_3, v53)
    return v50 + v52 * 256 + v54 * 16777216
end

local function pushu8(v55, v56) -- line 134 | captures: tryRealloc
    tryRealloc(v55, 8)
    local Buf = v55.Buf
    local Pos = v55.Pos
    buffer.writeu32(Buf, Pos, v56)
    local Buf_2 = v55.Buf
    local v57 = v55.Pos + 4
    local v58 = v56 // 4294967296
    buffer.writeu32(Buf_2, v57, v58)
    v55.Pos += 8
end

local function popu8(v59) -- line 141
    v59.Pos -= 8
    local Buf = v59.Buf
    local Pos = v59.Pos
    local v60 = buffer.readu32(Buf, Pos)
    local Buf_2 = v59.Buf
    local v61 = v59.Pos + 4
    return v60 + buffer.readu32(Buf_2, v61) * 4294967296
end

local function pushi1(v62, v63) -- line 148 | captures: tryRealloc
    tryRealloc(v62, 1)
    local Buf = v62.Buf
    local Pos = v62.Pos
    buffer.writei8(Buf, Pos, v63)
    v62.Pos += 1
end

local function popi1(v64) -- line 154
    v64.Pos -= 1
    local Buf = v64.Buf
    local Pos = v64.Pos
    return (buffer.readi8(Buf, Pos))
end

local function pushi2(v65, v66) -- line 159 | captures: tryRealloc
    tryRealloc(v65, 2)
    local Buf = v65.Buf
    local Pos = v65.Pos
    buffer.writei16(Buf, Pos, v66)
    v65.Pos += 2
end

local function popi2(v67) -- line 165
    v67.Pos -= 2
    local Buf = v67.Buf
    local Pos = v67.Pos
    return (buffer.readi16(Buf, Pos))
end

local function pushi3(v68, v69) -- line 170 | captures: tryRealloc
    local v70 = v69 % 16777216
    if v70 < 0 then
        v70 += 16777216
    end
    tryRealloc(v68, 3)
    local Buf = v68.Buf
    local Pos = v68.Pos
    buffer.writeu8(Buf, Pos, v70)
    local Buf_2 = v68.Buf
    local v71 = v68.Pos + 1
    local v72 = v70 // 256
    buffer.writeu16(Buf_2, v71, v72)
    v68.Pos += 3
end

local function popi3(v73) -- line 179
    v73.Pos -= 3
    local Buf = v73.Buf
    local Pos = v73.Pos
    local v74 = buffer.readu8(Buf, Pos)
    local Buf_2 = v73.Buf
    local v75 = v73.Pos + 1
    local v76 = v74 + buffer.readu16(Buf_2, v75) * 256
    if v76 > 65535 then
        return v76 - 16777216
    end
    return v76
end

local function pushi4(v77, v78) -- line 187 | captures: tryRealloc
    tryRealloc(v77, 4)
    local Buf = v77.Buf
    local Pos = v77.Pos
    buffer.writei32(Buf, Pos, v78)
    v77.Pos += 4
end

local function popi4(v79) -- line 193
    v79.Pos -= 4
    local Buf = v79.Buf
    local Pos = v79.Pos
    return (buffer.readi32(Buf, Pos))
end

local function pushi5(v80, v81) -- line 198 | captures: tryRealloc
    local v82 = v81 % 1099511627776
    if v82 < 0 then
        v82 += 1099511627776
    end
    tryRealloc(v80, 5)
    local Buf = v80.Buf
    local Pos = v80.Pos
    buffer.writei8(Buf, Pos, v82)
    local Buf_2 = v80.Buf
    local v83 = v80.Pos + 1
    local v84 = v82 // 256
    buffer.writei32(Buf_2, v83, v84)
    v80.Pos += 5
end

local function popi5(v85) -- line 207
    v85.Pos -= 5
    local Buf = v85.Buf
    local Pos = v85.Pos
    local v86 = buffer.readi8(Buf, Pos)
    local Buf_2 = v85.Buf
    local v87 = v85.Pos + 1
    local v88 = v86 + buffer.readi32(Buf_2, v87) * 256
    if v88 > 4294967295 then
        return v88 - 1099511627776
    end
    return v88
end

local function pushi6(v89, v90) -- line 215 | captures: tryRealloc
    local v91 = v90 % 281474976710656
    if v91 < 0 then
        v91 += 281474976710656
    end
    tryRealloc(v89, 6)
    local Buf = v89.Buf
    local Pos = v89.Pos
    buffer.writei16(Buf, Pos, v91)
    local Buf_2 = v89.Buf
    local v92 = v89.Pos + 2
    local v93 = v91 // 65536
    buffer.writei32(Buf_2, v92, v93)
    v89.Pos += 6
end

local function popi6(v94) -- line 224
    v94.Pos -= 6
    local Buf = v94.Buf
    local Pos = v94.Pos
    local v95 = buffer.readi16(Buf, Pos)
    local Buf_2 = v94.Buf
    local v96 = v94.Pos + 2
    local v97 = v95 + buffer.readi32(Buf_2, v96) * 65536
    if v97 > 1099511627775 then
        return v97 - 281474976710656
    end
    return v97
end

local function pushi7(v98, v99) -- line 232 | captures: tryRealloc
    local v100 = v99 % 72057594037927940
    if v100 < 0 then
        v100 += 72057594037927940
    end
    tryRealloc(v98, 7)
    local Buf = v98.Buf
    local Pos = v98.Pos
    buffer.writei8(Buf, Pos, v100)
    local Buf_2 = v98.Buf
    local v101 = v98.Pos + 1
    local v102 = v100 // 256
    buffer.writei16(Buf_2, v101, v102)
    local Buf_3 = v98.Buf
    local v103 = v98.Pos + 3
    local v104 = v100 // 16777216
    buffer.writei32(Buf_3, v103, v104)
    v98.Pos += 7
end

local function popi7(v105) -- line 242
    v105.Pos -= 7
    local Buf = v105.Buf
    local Pos = v105.Pos
    local v106 = buffer.readi8(Buf, Pos)
    local Buf_2 = v105.Buf
    local v107 = v105.Pos + 1
    local v108 = buffer.readi16(Buf_2, v107)
    local Buf_3 = v105.Buf
    local v109 = v105.Pos + 3
    local v110 = buffer.readi32(Buf_3, v109)
    local v111 = v106 + v108 * 256 + v110 * 16777216
    if v111 > 281474976710655 then
        return v111 - 72057594037927940
    end
    return v111
end

local function pushi8(v112, v113) -- line 251 | captures: tryRealloc
    local v114 = v113 % 18446744073709552000
    if v114 < 0 then
        v114 = 18446744073709552000 - v114
    end
    tryRealloc(v112, 8)
    local Buf = v112.Buf
    local Pos = v112.Pos
    buffer.writei32(Buf, Pos, v114)
    local Buf_2 = v112.Buf
    local v115 = v112.Pos + 4
    local v116 = v114 // 4294967296
    buffer.writei32(Buf_2, v115, v116)
    v112.Pos += 8
end

local function popi8(v117) -- line 260
    v117.Pos -= 8
    local Buf = v117.Buf
    local Pos = v117.Pos
    local v118 = buffer.readi32(Buf, Pos)
    local Buf_2 = v117.Buf
    local v119 = v117.Pos + 4
    local v120 = v118 + buffer.readi32(Buf_2, v119) * 4294967296
    if v120 > 72057594037927940 then
        return v120 - 18446744073709552000
    end
    return v120
end

local function pushf4(v121, v122) -- line 268 | captures: tryRealloc
    tryRealloc(v121, 4)
    local Buf = v121.Buf
    local Pos = v121.Pos
    buffer.writef32(Buf, Pos, v122)
    v121.Pos += 4
end

local function popf4(v123) -- line 274
    v123.Pos -= 4
    local Buf = v123.Buf
    local Pos = v123.Pos
    return (buffer.readf32(Buf, Pos))
end

local function pushf8(v124, v125) -- line 279 | captures: tryRealloc
    tryRealloc(v124, 8)
    local Buf = v124.Buf
    local Pos = v124.Pos
    buffer.writef64(Buf, Pos, v125)
    v124.Pos += 8
end

local function popf8(v126) -- line 285
    v126.Pos -= 8
    local Buf = v126.Buf
    local Pos = v126.Pos
    return (buffer.readf64(Buf, Pos))
end

local function pushbool(v127, v128, v129, v130, v131, v132, v133, v134, v135) -- line 290 | captures: tryRealloc
    local v136 = if v128 then 1 else 0
    local v137 = if v129 then 2 else 0
    local v138 = v136 + v137
    local v139 = if v130 then 4 else 0
    local v140 = v138 + v139
    local v141 = if v131 then 8 else 0
    local v142 = v140 + v141
    local v143 = if v132 then 16 else 0
    local v144 = v142 + v143
    local v145 = if v133 then 32 else 0
    local v146 = v144 + v145
    local v147 = if v134 then 64 else 0
    local v148 = v146 + v147
    local v149 = if v135 then 128 else 0
    local v150 = v148 + v149
    tryRealloc(v127, 1)
    local Buf = v127.Buf
    local Pos = v127.Pos
    buffer.writeu8(Buf, Pos, v150)
    v127.Pos += 1
end

local function popbool(v151) -- line 303
    v151.Pos -= 1
    local Buf = v151.Buf
    local Pos = v151.Pos
    local v152 = buffer.readu8(Buf, Pos)
    return v152 % 2 >= 1, v152 % 4 >= 2, v152 % 8 >= 4, v152 % 16 >= 8, v152 % 32 >= 16, v152 % 64 >= 32, v152 % 128 >= 64, v152 % 256 >= 128
end

local function pushvlq(v153, v154) -- line 316 | captures: tryRealloc
    local v155 = v154 // 1 % 128
    local v156 = v154 // 128 % 128
    local v157 = v154 // 16384 % 128
    local v158 = v154 // 2097152 % 128
    local v159 = v154 // 268435456 % 128
    local v160 = v154 // 34359738368 % 128
    local v161 = v154 // 4398046511104 % 128
    local v162 = v154 // 562949953421312 % 128
    if v162 == 0 then
        if v161 == 0 then
            if v160 == 0 then
                if v159 == 0 then
                    if v158 == 0 then
                        if v157 == 0 then
                            if v156 == 0 then
                                local v163 = v155 + 128
                                tryRealloc(v153, 1)
                                local Buf = v153.Buf
                                local Pos = v153.Pos
                                buffer.writeu8(Buf, Pos, v163)
                                v153.Pos += 1
                            else
                                local v164 = v155 * 256 + v156 + 128
                                tryRealloc(v153, 2)
                                local Buf = v153.Buf
                                local Pos = v153.Pos
                                buffer.writeu16(Buf, Pos, v164)
                                v153.Pos += 2
                            end
                        else
                            local v165 = v155 * 65536 + v156 * 256 + v157 + 128
                            tryRealloc(v153, 3)
                            local Buf = v153.Buf
                            local Pos = v153.Pos
                            buffer.writeu8(Buf, Pos, v165)
                            local Buf_2 = v153.Buf
                            local v166 = v153.Pos + 1
                            local v167 = v165 // 256
                            buffer.writeu16(Buf_2, v166, v167)
                            v153.Pos += 3
                        end
                    else
                        local v168 = v155 * 16777216 + v156 * 65536 + v157 * 256 + v158 + 128
                        tryRealloc(v153, 4)
                        local Buf = v153.Buf
                        local Pos = v153.Pos
                        buffer.writeu32(Buf, Pos, v168)
                        v153.Pos += 4
                    end
                else
                    local v169 = v155 * 4294967296 + v156 * 16777216 + v157 * 65536 + v158 * 256 + v159 + 128
                    tryRealloc(v153, 5)
                    local Buf = v153.Buf
                    local Pos = v153.Pos
                    buffer.writeu8(Buf, Pos, v169)
                    local Buf_2 = v153.Buf
                    local v170 = v153.Pos + 1
                    local v171 = v169 // 256
                    buffer.writeu32(Buf_2, v170, v171)
                    v153.Pos += 5
                end
            else
                local v172 = v155 * 1099511627776 + v156 * 4294967296 + v157 * 16777216 + v158 * 65536 + v159 * 256 + v160 + 128
                tryRealloc(v153, 6)
                local Buf = v153.Buf
                local Pos = v153.Pos
                buffer.writeu16(Buf, Pos, v172)
                local Buf_2 = v153.Buf
                local v173 = v153.Pos + 2
                local v174 = v172 // 65536
                buffer.writeu32(Buf_2, v173, v174)
                v153.Pos += 6
            end
        else
            local v175 = v155 * 281474976710656 + v156 * 1099511627776 + v157 * 4294967296 + v158 * 16777216 + v159 * 65536 + v160 * 256 + v161 + 128
            tryRealloc(v153, 7)
            local Buf = v153.Buf
            local Pos = v153.Pos
            buffer.writeu8(Buf, Pos, v175)
            local Buf_2 = v153.Buf
            local v176 = v153.Pos + 1
            local v177 = v175 // 256
            buffer.writeu16(Buf_2, v176, v177)
            local Buf_3 = v153.Buf
            local v178 = v153.Pos + 3
            local v179 = v175 // 16777216
            buffer.writeu32(Buf_3, v178, v179)
            v153.Pos += 7
        end
    else
        local v180 = v155 * 72057594037927940 + v156 * 281474976710656 + v157 * 1099511627776 + v158 * 4294967296 + v159 * 16777216 + v160 * 65536 + v161 * 256 + v162 + 128
        tryRealloc(v153, 8)
        local Buf = v153.Buf
        local Pos = v153.Pos
        buffer.writeu32(Buf, Pos, v180)
        local Buf_2 = v153.Buf
        local v181 = v153.Pos + 4
        local v182 = v180 // 4294967296
        buffer.writeu32(Buf_2, v181, v182)
        v153.Pos += 8
    end
end

local function popvlq(v183) -- line 345
    v183.Pos -= 1
    local Buf = v183.Buf
    local Pos = v183.Pos
    local v184 = buffer.readu8(Buf, Pos)
    if v184 >= 128 then
        return v184 - 128
    end
    v183.Pos -= 1
    local Buf_2 = v183.Buf
    local Pos_2 = v183.Pos
    local v185 = buffer.readu8(Buf_2, Pos_2)
    if v185 >= 128 then
        return v184 + (v185 - 128) * 128
    end
    local v186 = v184 + v185 * 128
    v183.Pos -= 1
    local Buf_3 = v183.Buf
    local Pos_3 = v183.Pos
    local v187 = buffer.readu8(Buf_3, Pos_3)
    if v187 >= 128 then
        return v186 + (v187 - 128) * 16384
    end
    local v188 = v186 + v187 * 16384
    v183.Pos -= 1
    local Buf_4 = v183.Buf
    local Pos_4 = v183.Pos
    local v189 = buffer.readu8(Buf_4, Pos_4)
    if v189 >= 128 then
        return v188 + (v189 - 128) * 2097152
    end
    local v190 = v188 + v189 * 2097152
    v183.Pos -= 1
    local Buf_5 = v183.Buf
    local Pos_5 = v183.Pos
    local v191 = buffer.readu8(Buf_5, Pos_5)
    if v191 >= 128 then
        return v190 + (v191 - 128) * 268435456
    end
    local v192 = v190 + v191 * 268435456
    v183.Pos -= 1
    local Buf_6 = v183.Buf
    local Pos_6 = v183.Pos
    local v193 = buffer.readu8(Buf_6, Pos_6)
    if v193 >= 128 then
        return v192 + (v193 - 128) * 34359738368
    end
    local v194 = v192 + v193 * 34359738368
    v183.Pos -= 1
    local Buf_7 = v183.Buf
    local Pos_7 = v183.Pos
    local v195 = buffer.readu8(Buf_7, Pos_7)
    if v195 >= 128 then
        return v194 + (v195 - 128) * 4398046511104
    end
    local v196 = v194 + v195 * 4398046511104
    v183.Pos -= 1
    local Buf_8 = v183.Buf
    local Pos_8 = v183.Pos
    local v197 = buffer.readu8(Buf_8, Pos_8)
    if v197 >= 128 then
        return v196 + (v197 - 128) * 562949953421312
    end
    local v198 = v196 + v197 * 562949953421312
    error((("Not a valid vlq: %* = %*"):format(v198, (buffer.tostring(v183.Buf)))))
end

local function pushstr(v199, v200, v201) -- line 397 | captures: tryRealloc, pushvlq
    local v202 = v201 or #v200
    tryRealloc(v199, v202)
    buffer.writestring(v199.Buf, v199.Pos, v200)
    v199.Pos += v202
    if not v201 then
        pushvlq(v199, v202)
    end
end

local function popstr(v203, v204) -- line 408 | captures: popvlq
    local v205 = v204 or popvlq(v203)
    v203.Pos -= v205
    return buffer.readstring(v203.Buf, v203.Pos, v205)
end

local function pushbuf(v206, v207, v208) -- line 414 | captures: tryRealloc, pushvlq
    local v209 = v208 or buffer.len(v207)
    tryRealloc(v206, v209)
    buffer.copy(v206.Buf, v206.Pos, v207, 0, v209)
    v206.Pos += v209
    if not v208 then
        pushvlq(v206, v209)
    end
end

local function popbuf(v210, v211) -- line 425 | captures: popvlq
    local v212 = v211 or popvlq(v210)
    v210.Pos -= v212
    local v213 = buffer.create(v212)
    buffer.copy(v213, 0, v210.Buf, v210.Pos, v212)
    return v213
end

local v214 = {
    print = function(v215) -- printcursor | line 433
        local v216 = buffer.tostring(v215.Buf)
        local v217 = { string.byte(v216, 1, -1) }
        local Pos = v215.Pos
        local v218 = 7
        for v219 = 1, Pos do
            local v220 = v217[v219]
            local v221
            if v220 == 0 then
                v221 = 1
            else
                local v222 = 1 + v220
                local v223 = math.log10(v222)
                v221 = math.ceil(v223)
            end
            v218 += v221 + 1
        end
        local v224 = v217[v215.Pos + 1]
        local v225
        if v224 then
            local v226
            if v224 == 0 then
                v226 = 1
            else
                local v227 = 1 + v224
                local v228 = math.log10(v227)
                v226 = math.ceil(v228)
            end
            v225 = v218 + v226 // 2
        else
            v225 = v218
        end
        if #v217 == 0 or v215.Pos == buffer.len(v215.Buf) then
            table.insert(v217, " ")
        end
        print((("Pos: %* / %*\nBuf: { %* }\n%*^"):format(v215.Pos, buffer.len(v215.Buf), table.concat(v217, " "), (string.rep(" ", v225)))))
    end,
    cursor = newcursor,
    frombuffer = frombuffer,
    tobuffer = tobuffer,
    T = function(v229) -- T | line 467
        return v229
    end
}
local v230 = {
    ser = pushbool,
    des = popbool
}

function v214.boolean() -- line 475 | captures: v230
    return v230
end

local v231 = {}

function v214.uint(v232) -- line 480 | captures: pushu1, popu1, pushu2, popu2, pushu3, popu3, pushu4, popu4, pushu5, popu5, pushu6, popu6, pushu7, popu7, pushu8, popu8, v231
    if v231[v232] then
        return v231[v232]
    end
    local v233, v234
    if v232 == 1 then
        v233 = pushu1
        v234 = popu1
    elseif v232 == 2 then
        v233 = pushu2
        v234 = popu2
    elseif v232 == 3 then
        v233 = pushu3
        v234 = popu3
    elseif v232 == 4 then
        v233 = pushu4
        v234 = popu4
    elseif v232 == 5 then
        v233 = pushu5
        v234 = popu5
    elseif v232 == 6 then
        v233 = pushu6
        v234 = popu6
    elseif v232 == 7 then
        v233 = pushu7
        v234 = popu7
    elseif v232 == 8 then
        v233 = pushu8
        v234 = popu8
    else
        error((("uint bytes must be integer between [1, 8], got %*"):format(v232)))
    end
    local v235 = {
        ser = v233,
        des = v234
    }
    v231[v232] = v235
    return v235
end

local v236 = {}

function v214.int(v237) -- line 516 | captures: pushi1, popi1, pushi2, popi2, pushi3, popi3, pushi4, popi4, pushi5, popi5, pushi6, popi6, pushi7, popi7, pushi8, popi8, v236
    if v236[v237] then
        return v236[v237]
    end
    local v238, v239
    if v237 == 1 then
        v238 = pushi1
        v239 = popi1
    elseif v237 == 2 then
        v238 = pushi2
        v239 = popi2
    elseif v237 == 3 then
        v238 = pushi3
        v239 = popi3
    elseif v237 == 4 then
        v238 = pushi4
        v239 = popi4
    elseif v237 == 5 then
        v238 = pushi5
        v239 = popi5
    elseif v237 == 6 then
        v238 = pushi6
        v239 = popi6
    elseif v237 == 7 then
        v238 = pushi7
        v239 = popi7
    elseif v237 == 8 then
        v238 = pushi8
        v239 = popi8
    else
        error((("int bytes must be integer between [1, 8], got %*"):format(v237)))
    end
    local v240 = {
        ser = v238,
        des = v239
    }
    v236[v237] = v240
    return v240
end

local v241 = {}

function v214.number(v242) -- line 552 | captures: pushf4, popf4, pushf8, popf8, v236, v241
    if v241[v242] then
        return v241[v242]
    end
    local v243, v244
    if v242 == 4 then
        v243 = pushf4
        v244 = popf4
    elseif v242 == 8 then
        v243 = pushf8
        v244 = popf8
    else
        error((("number bytes must be integer 4 or 8, got %*"):format(v242)))
    end
    local v245 = {
        ser = v243,
        des = v244
    }
    v236[v242] = v245
    return v245
end

local v246 = {}
local v247 = {}
local v248 = {
    ser = pushstr,
    des = popstr
}

function v247.__call(v249, v250) -- line 581 | captures: tryRealloc, pushvlq, popstr, v246, v248
    if v250 then
        if v246[v250] then
            return v246[v250]
        end
        local v251 = {}

        function v251.ser(v252, v253) -- line 591 | captures: v250, tryRealloc, pushvlq
            local v254 = v250 or #v253
            tryRealloc(v252, v254)
            buffer.writestring(v252.Buf, v252.Pos, v253)
            v252.Pos += v254
            if not v250 then
                pushvlq(v252, v254)
            end
        end

        function v251.des(v255) -- line 595 | captures: v250, popstr
            return popstr(v255, v250)
        end

        v246[v250] = v251
        return v251
    end
    return v248
end

local v256 = {
    convert = function(v257, v258, v259) -- convert | line 604
        local v260 = {}
        local v261 = #v258
        for v262 = 1, v261 do
            v260[string.byte(v258, v262)] = v262 - 1
        end
        local v263 = {}
        local v264 = #v259
        for v265 = 1, v264 do
            v263[v265 - 1] = string.byte(v259, v265)
        end
        local v266 = {}
        local v267 = #v257
        for v268 = 1, v267 do
            local v269 = v260[string.byte(v257, v268)]
            table.insert(v266, v269)
        end
        local v270 = {}
        local v271 = #v258
        local v272 = #v259
        while #v266 > 0 do
            local v273 = #v266
            local v274 = 0
            for v275 = 1, v273 do
                local v276 = v266[v275] + v274 * v271
                local v277 = v276 / v272
                v266[v275] = math.floor(v277)
                v274 = v276 % v272
            end
            while #v266 > 0 and v266[1] == 0 do
                table.remove(v266, 1)
            end
            local v278 = v263[v274]
            local v279 = string.char(v278)
            table.insert(v270, 1, v279)
        end
        return table.concat(v270)
    end,
    alphabet = function(v280) -- alphabet | line 642
        local v281 = {}
        local v282 = table.create(#v280)
        local v283 = #v280
        for v284 = 1, v283 do
            local v285 = string.sub(v280, v284, v284)
            if not v281[v285] then
                v281[v285] = true
                table.insert(v282, v285)
            end
        end
        table.sort(v282)
        return table.concat(v282)
    end,
    binary = "01",
    octal = "01234567",
    decimal = "0123456789",
    duodecimal = "0123456789AB",
    hexadecimal = "0123456789ABCDEF"
}
local v286 = table.create(256)
for v287 = 0, 255 do
    v286[v287 + 1] = string.char(v287)
end
v256.utf8 = table.concat(v286)
v256.lower = "abcdefghijklmnopqrstuvwxyz"
v256.upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
v256.letters = v256.lower .. v256.upper
v256.punctuation = " .,?!:;'\"-_"
v256.english = v256.letters .. v256.punctuation
v256.filepath = v256.letters .. ":/"
v256.datastore = " !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~"
v214.string = setmetatable(v256, v247)

local v288 = {}

function v214.opt(v289) -- line 677 | captures: tryRealloc, v288
    if v288[v289] then
        return v288[v289]
    end
    local v290 = {}

    function v290.ser(v291, v292) -- line 683 | captures: v289, tryRealloc
        if v292 == nil then
            tryRealloc(v291, 1)
            local Buf = v291.Buf
            local Pos = v291.Pos
            buffer.writeu8(Buf, Pos, 0)
        else
            v289.ser(v291, v292)
            tryRealloc(v291, 1)
            local Buf = v291.Buf
            local Pos = v291.Pos
            buffer.writeu8(Buf, Pos, 1)
        end
        v291.Pos += 1
    end

    function v290.des(v293) -- line 692 | captures: v289
        v293.Pos -= 1
        local Buf = v293.Buf
        local Pos = v293.Pos
        if buffer.readu8(Buf, Pos) == 1 then
            return v289.des(v293)
        end
        return nil
    end

    v288[v289] = v290
    return v290
end

local v294 = {}
local v295 = {
    ser = pushbuf,
    des = popbuf
}

function v214.buffer(v296) -- line 709 | captures: popvlq, pushbuf, v294, v295
    if v296 then
        if v294[v296] then
            return v294[v296]
        end
        local v297 = {}

        function v297.ser(v298, v299) -- line 719 | captures: v296, pushbuf
            pushbuf(v298, v299, v296)
        end

        function v297.des(v300) -- line 723 | captures: v296, popvlq
            local v301 = v296 or popvlq(v300)
            v300.Pos -= v301
            local v302 = buffer.create(v301)
            buffer.copy(v302, 0, v300.Buf, v300.Pos, v301)
            return v302
        end

        v294[v296] = v297
        return v297
    end
    return v295
end

local v303 = {
    ser = pushvlq,
    des = popvlq
}

function v214.vlq() -- line 735 | captures: v303
    return v303
end

local v304 = {}

function v214.array(v305, v306) -- line 740 | captures: pushvlq, popvlq, v304
    local v307 = v304[v305]
    local v308 = v306 or 0
    local v309, v310
    if v307 then
        v309 = v307[v308]
    else
        v310 = {}
        v304[v305] = v310
    end
    if v307 and not v309 or not v307 then
        local v311 = v307 or v310
        local ser = v305.ser
        local des = v305.des
        local v312 = {}
        if v306 then
            function v312.ser(v313, v314) -- line 755 | captures: v306, ser
                for v315 = 1, v306 do
                    ser(v313, v314[v315])
                end
            end
        else
            function v312.ser(v316, v317) -- line 760 | captures: ser, pushvlq
                for v318, v319 in v317 do
                    ser(v316, v319)
                end
                pushvlq(v316, #v317)
            end
        end

        function v312.des(v320) -- line 768 | captures: v306, des, popvlq
            local v321 = v306 or popvlq(v320)
            local v322 = table.create(v321)
            for v323 = v321, 1, -1 do
                v322[v323] = des(v320)
            end
            return v322
        end

        v311[v308] = v312
        return v312
    end
    return v307[v308]
end

function v214.tuple(...) -- line 784
    local v324 = { ... }
    local v325 = #v324
    if v325 == 1 then
        return v324[1]
    end
    local v326 = {}

    function v326.ser(v327, ...) -- line 792 | captures: v324
        for v328, v329 in { ... } do
            v324[v328].ser(v327, v329)
        end
    end

    function v326.des(v330) -- line 798 | captures: v324, v325
        local v331 = table.create(v325)
        for v332 = v325, 1, -1 do
            v331[v332] = v324[v332].des(v330)
        end
        return table.unpack(v331)
    end

    return v326
end

function v214.record(v333) -- line 810 | captures: tryRealloc, v230
    local v334 = {}
    local v335 = {}
    for v336, v337 in v333 do
        if type(v336) == "string" then
            if v337 == v230 then
                table.insert(v334, v336)
            else
                table.insert(v335, v336)
            end
        end
    end
    table.sort(v335)
    local v338 = v333[true]
    table.insert(v335, v338)
    local v339 = v333[false]
    table.insert(v335, v339)
    local v340 = #v334
    if v340 > 0 then
        table.sort(v334)
    end
    local v341 = {}
    if v340 == 0 then
        function v341.ser(v342, v343) -- line 833 | captures: v333, v335
            for v344, v345 in v335 do
                v333[v345].ser(v342, v343[v345])
            end
        end
    else
        function v341.ser(v346, v347) -- line 839 | captures: v333, v334, v335, v340, tryRealloc
            local v348 = v340 // 8
            for v349 = 0, v348 do
                local v350 = v349 * 8 + 1
                local v351 = v347[v334[v350 + 0]]
                local v352 = v347[v334[v350 + 1]]
                local v353 = v347[v334[v350 + 2]]
                local v354 = v347[v334[v350 + 3]]
                local v355 = v347[v334[v350 + 4]]
                local v356 = v347[v334[v350 + 5]]
                local v357 = v347[v334[v350 + 6]]
                local v358 = v347[v334[v350 + 7]]
                local v359 = if v351 then 1 else 0
                local v360 = if v352 then 2 else 0
                local v361 = v359 + v360
                local v362 = if v353 then 4 else 0
                local v363 = v361 + v362
                local v364 = if v354 then 8 else 0
                local v365 = v363 + v364
                local v366 = if v355 then 16 else 0
                local v367 = v365 + v366
                local v368 = if v356 then 32 else 0
                local v369 = v367 + v368
                local v370 = if v357 then 64 else 0
                local v371 = v369 + v370
                local v372 = if v358 then 128 else 0
                local v373 = v371 + v372
                tryRealloc(v346, 1)
                local Buf = v346.Buf
                local Pos = v346.Pos
                buffer.writeu8(Buf, Pos, v373)
                v346.Pos += 1
            end
            for v374, v375 in v335 do
                v333[v375].ser(v346, v347[v375])
            end
        end
    end
    if v340 == 0 then
        function v341.des(v376) -- line 861 | captures: v333, v335
            local v377 = {}
            local v378 = #v335
            for v379 = v378, 1, -1 do
                local v380 = v335[v379]
                v377[v380] = v333[v380].des(v376)
            end
            return v377
        end
    else
        function v341.des(v381) -- line 869 | captures: v333, v334, v335, v340
            local v382 = {}
            local v383 = #v335
            for v384 = v383, 1, -1 do
                local v385 = v335[v384]
                v382[v385] = v333[v385].des(v381)
            end
            local v386 = v340 // 8 * 8 + 1
            local v387 = v340 % 8
            v381.Pos -= 1
            local Buf = v381.Buf
            local Pos = v381.Pos
            local v388 = buffer.readu8(Buf, Pos)
            local v389 = v388 % 2 >= 1
            local v390 = v388 % 4 >= 2
            local v391 = v388 % 8 >= 4
            local v392 = v388 % 16 >= 8
            local v393 = v388 % 32 >= 16
            local v394 = v388 % 64 >= 32
            local v395 = v388 % 128 >= 64
            local v396 = v388 % 256 >= 128
            v382[v334[v386 + 0]] = v389
            if v387 ~= 1 then
                v382[v334[v386 + 1]] = v390
                if v387 ~= 2 then
                    v382[v334[v386 + 2]] = v391
                    if v387 ~= 3 then
                        v382[v334[v386 + 3]] = v392
                        if v387 ~= 4 then
                            v382[v334[v386 + 4]] = v393
                            if v387 ~= 5 then
                                v382[v334[v386 + 5]] = v394
                                if v387 ~= 6 then
                                    v382[v334[v386 + 6]] = v395
                                    if v387 ~= 7 then
                                        v382[v334[v386 + 7]] = v396
                                    end
                                end
                            end
                        end
                    end
                end
            end
            local v397 = v340 // 8 - 1
            for v398 = v397, 0, -1 do
                local v399 = v398 * 8 + 1
                local v400 = v334[v399 + 0]
                local v401 = v334[v399 + 1]
                local v402 = v334[v399 + 2]
                local v403 = v334[v399 + 3]
                local v404 = v334[v399 + 4]
                local v405 = v334[v399 + 5]
                local v406 = v334[v399 + 6]
                local v407 = v334[v399 + 7]
                v381.Pos -= 1
                local Buf = v381.Buf
                local Pos = v381.Pos
                local v408 = buffer.readu8(Buf, Pos)
                local v409 = v408 % 2 >= 1
                local v410 = v408 % 4 >= 2
                local v411 = v408 % 8 >= 4
                local v412 = v408 % 16 >= 8
                local v413 = v408 % 32 >= 16
                local v414 = v408 % 64 >= 32
                local v415 = v408 % 128 >= 64
                local v416 = v408 % 256 >= 128
                v382[v400] = v409
                v382[v401] = v410
                v382[v402] = v411
                v382[v403] = v412
                v382[v404] = v413
                v382[v405] = v414
                v382[v406] = v415
                v382[v407] = v416
            end
            return v382
        end
    end
    return v341
end

function v214.map(v417, v418) -- line 948 | captures: pushvlq, popvlq
    local v419 = {}

    function v419.ser(v420, v421) -- line 950 | captures: v417, v418, pushvlq
        local v422 = 0
        for v423, v424 in v421 do
            v418.ser(v420, v424)
            v417.ser(v420, v423)
            v422 += 1
        end
        pushvlq(v420, v422)
    end

    function v419.des(v425) -- line 960 | captures: v417, v418, popvlq
        local v426 = {}
        local v427 = popvlq(v425)
        for v428 = 1, v427 do
            v426[v417.des(v425)] = v418.des(v425)
        end
        return v426
    end

    return v419
end

function v214.literal(...) -- line 976 | captures: tryRealloc
    local v429 = { ... }
    local v430 = {}
    for v431, v432 in v429 do
        v430[v432] = v431 - 1
    end
    local v433 = {}

    function v433.ser(v434, v435) -- line 985 | captures: v430, tryRealloc
        local v436 = v430[v435]
        tryRealloc(v434, 1)
        local Buf = v434.Buf
        local Pos = v434.Pos
        buffer.writeu8(Buf, Pos, v436)
        v434.Pos += 1
    end

    function v433.des(v437) -- line 989 | captures: v429
        v437.Pos -= 1
        local Buf = v437.Buf
        local Pos = v437.Pos
        return v429[buffer.readu8(Buf, Pos) + 1]
    end

    return v433
end

function v214.table(v438) -- line 996 | captures: tryRealloc, pushvlq, popvlq
    local v439 = {}
    for v440, v441 in v438 do
        table.insert(v439, v440)
    end
    local v442 = {}

    function v442.ser(v443, v444) -- line 1004 | captures: v438, v439, tryRealloc, pushvlq
        local v445 = 0
        for v446, v447 in v444 do
            local v448 = typeof(v447)
            local v449 = v438[v448]
            if v449 then
                local v450 = typeof(v446)
                local v451 = v438[v450]
                if v451 then
                    v449.ser(v443, v447)
                    local v452 = (table.find(v439, v448) or error("")) - 1
                    tryRealloc(v443, 1)
                    local Buf = v443.Buf
                    local Pos = v443.Pos
                    buffer.writeu8(Buf, Pos, v452)
                    v443.Pos += 1
                    v451.ser(v443, v446)
                    local v453 = (table.find(v439, v450) or error("")) - 1
                    tryRealloc(v443, 1)
                    local Buf_2 = v443.Buf
                    local Pos_2 = v443.Pos
                    buffer.writeu8(Buf_2, Pos_2, v453)
                    v443.Pos += 1
                    v445 += 1
                end
            end
        end
        pushvlq(v443, v445)
    end

    function v442.des(v454) -- line 1033 | captures: v438, v439, popvlq
        local v455 = {}
        local v456 = popvlq(v454)
        for v457 = 1, v456 do
            v454.Pos -= 1
            local Buf = v454.Buf
            local Pos = v454.Pos
            local v458 = buffer.readu8(Buf, Pos) + 1
            local v459 = v439[v458]
            local v460 = v438[v459].des(v454)
            v454.Pos -= 1
            local Buf_2 = v454.Buf
            local Pos_2 = v454.Pos
            local v461 = buffer.readu8(Buf_2, Pos_2) + 1
            local v462 = v439[v461]
            v455[v460] = v438[v462].des(v454)
        end
        return v455
    end

    return v442
end

local v463 = {}

function v463.ser(v464, v465) -- line 1056 | captures: tryRealloc
    local Back = v465.Back
    local Bottom = v465.Bottom
    local Front = v465.Front
    local Left = v465.Left
    local Right = v465.Right
    local Top = v465.Top
    local v466 = if Back then 1 else 0
    local v467 = if Bottom then 2 else 0
    local v468 = v466 + v467
    local v469 = if Front then 4 else 0
    local v470 = v468 + v469
    local v471 = if Left then 8 else 0
    local v472 = v470 + v471
    local v473 = if Right then 16 else 0
    local v474 = v472 + v473
    local v475 = if Top then 32 else 0
    local v476 = v474 + v475 + 0 + 0
    tryRealloc(v464, 1)
    local Buf = v464.Buf
    local Pos = v464.Pos
    buffer.writeu8(Buf, Pos, v476)
    v464.Pos += 1
    local X = v465.X
    local Y = v465.Y
    local Z = v465.Z
    local v477 = if X then 1 else 0
    local v478 = if Y then 2 else 0
    local v479 = v477 + v478
    local v480 = if Z then 4 else 0
    local v481 = v479 + v480 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v464, 1)
    local Buf_2 = v464.Buf
    local Pos_2 = v464.Pos
    buffer.writeu8(Buf_2, Pos_2, v481)
    v464.Pos += 1
end

local function des(v482) -- line 1061
    v482.Pos -= 1
    local Buf = v482.Buf
    local Pos = v482.Pos
    local v483 = buffer.readu8(Buf, Pos)
    local v484 = v483 % 2 >= 1
    local v485 = v483 % 4 >= 2
    local v486 = v483 % 8 >= 4
    if v483 % 16 >= 8 then
    end
    if v483 % 32 >= 16 then
    end
    if v483 % 64 >= 32 then
    end
    if v483 % 128 >= 64 then
    end
    if v483 % 256 >= 128 then
    end
    v482.Pos -= 1
    local Buf_2 = v482.Buf
    local Pos_2 = v482.Pos
    local v487 = buffer.readu8(Buf_2, Pos_2)
    local v488 = v487 % 2 >= 1
    local v489 = v487 % 4 >= 2
    local v490 = v487 % 8 >= 4
    local v491 = v487 % 16 >= 8
    local v492 = v487 % 32 >= 16
    local v493 = v487 % 64 >= 32
    if v487 % 128 >= 64 then
    end
    if v487 % 256 >= 128 then
    end
    return Axes.new(v484 and Enum.Axis.X, v485 and Enum.Axis.Y, v486 and Enum.Axis.Z, v488 and Enum.NormalId.Back, v489 and Enum.NormalId.Bottom, v490 and Enum.NormalId.Front, v491 and Enum.NormalId.Left, v492 and Enum.NormalId.Right, v493 and Enum.NormalId.Top)
end

v463.des = des

function v214.Axes() -- line 1077 | captures: v463
    return v463
end

local v494 = {}

function v494.ser(v495, v496) -- line 1082 | captures: tryRealloc
    local Number = v496.Number
    tryRealloc(v495, 2)
    local Buf = v495.Buf
    local Pos = v495.Pos
    buffer.writeu16(Buf, Pos, Number)
    v495.Pos += 2
end

local function des_2(v497) -- line 1086
    v497.Pos -= 2
    local Buf = v497.Buf
    local Pos = v497.Pos
    local v498 = buffer.readu16(Buf, Pos)
    return BrickColor.new(v498)
end

v494.des = des_2

function v214.BrickColor() -- line 1091 | captures: v494
    return v494
end

local v499 = {}

local function enumitem(v500) -- line 1096 | captures: pushvlq, popvlq, v499
    if v499[v500] then
        return v499[v500]
    end
    local v501 = v500:GetEnumItems()
    table.sort(v501, function(v502, v503) -- line 1102
        return v502.Value < v503.Value
    end)
    local v504 = {}
    local v505 = table.create(#v501)
    for v506, v507 in v501 do
        v504[v507] = v506
        v505[v506] = v507
    end
    local v508 = {}

    function v508.ser(v509, v510) -- line 1112 | captures: v504, pushvlq
        pushvlq(v509, v504[v510])
    end

    function v508.des(v511) -- line 1116 | captures: v505, popvlq
        local v512 = popvlq(v511)
        return v505[v512]
    end

    v499[v500] = v508
    return v508
end

v214.EnumItem = enumitem

local v513 = {}

function v513.ser(v514, v515) -- line 1128 | captures: tryRealloc, pushvlq, enumitem
    local v516 = if v515.IncludeOffSale then 1 else 0
    local v517 = v516 + 0 + 0 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v514, 1)
    local Buf = v514.Buf
    local Pos = v514.Pos
    buffer.writeu8(Buf, Pos, v517)
    v514.Pos += 1
    local Limit = v515.Limit
    tryRealloc(v514, 1)
    local Buf_2 = v514.Buf
    local Pos_2 = v514.Pos
    buffer.writeu8(Buf_2, Pos_2, Limit)
    v514.Pos += 1
    local MinPrice = v515.MinPrice
    tryRealloc(v514, 4)
    local Buf_3 = v514.Buf
    local Pos_3 = v514.Pos
    buffer.writeu32(Buf_3, Pos_3, MinPrice)
    v514.Pos += 4
    local MaxPrice = v515.MaxPrice
    tryRealloc(v514, 4)
    local Buf_4 = v514.Buf
    local Pos_4 = v514.Pos
    buffer.writeu32(Buf_4, Pos_4, MaxPrice)
    v514.Pos += 4
    local CreatorName = v515.CreatorName
    local v518 = #CreatorName
    tryRealloc(v514, v518)
    buffer.writestring(v514.Buf, v514.Pos, CreatorName)
    v514.Pos += v518
    pushvlq(v514, v518)
    local SearchKeyword = v515.SearchKeyword
    local v519 = #SearchKeyword
    tryRealloc(v514, v519)
    buffer.writestring(v514.Buf, v514.Pos, SearchKeyword)
    v514.Pos += v519
    pushvlq(v514, v519)
    enumitem(Enum.CatalogSortType).ser(v514, v515.SortType)
    enumitem(Enum.CatalogSortAggregation).ser(v514, v515.SortAggregation)
    enumitem(Enum.CatalogCategoryFilter).ser(v514, v515.CategoryFilter)
    enumitem(Enum.SalesTypeFilter).ser(v514, v515.SalesTypeFilter)
    for v520, v521 in v515.AssetTypes do
        enumitem(Enum.AssetType).ser(v514, v521)
    end
    pushvlq(v514, #v515.AssetTypes)
end

function v513.des(v522) -- line 1145 | captures: popvlq, enumitem
    local v523 = CatalogSearchParams.new()
    local v524 = popvlq(v522)
    local v525 = table.create(v524)
    for v526 = v524, 1, -1 do
        v525[v526] = enumitem(Enum.AssetType).des(v522)
    end
    v523.AssetTypes = v525
    v523.SalesTypesFilter = enumitem(Enum.SalesTypeFilter).des(v522)
    v523.CategoryFilter = enumitem(Enum.CatalogCategoryFilter).des(v522)
    v523.SortAggregation = enumitem(Enum.CatalogSortAggregation).des(v522)
    v523.SortType = enumitem(Enum.CatalogSortType).des(v522)
    local v527 = popvlq(v522)
    v522.Pos -= v527
    v523.SearchKeyword = buffer.readstring(v522.Buf, v522.Pos, v527)
    local v528 = popvlq(v522)
    v522.Pos -= v528
    v523.CreatorName = buffer.readstring(v522.Buf, v522.Pos, v528)
    v522.Pos -= 4
    local Buf = v522.Buf
    local Pos = v522.Pos
    v523.MaxPrice = buffer.readu32(Buf, Pos)
    v522.Pos -= 4
    local Buf_2 = v522.Buf
    local Pos_2 = v522.Pos
    v523.MinPrice = buffer.readu32(Buf_2, Pos_2)
    v522.Pos -= 1
    local Buf_3 = v522.Buf
    local Pos_3 = v522.Pos
    v523.Limit = buffer.readu8(Buf_3, Pos_3)
    v522.Pos -= 1
    local Buf_4 = v522.Buf
    local Pos_4 = v522.Pos
    local v529 = buffer.readu8(Buf_4, Pos_4)
    local v530 = v529 % 2 >= 1
    if v529 % 4 >= 2 then
    end
    if v529 % 8 >= 4 then
    end
    if v529 % 16 >= 8 then
    end
    if v529 % 32 >= 16 then
    end
    if v529 % 64 >= 32 then
    end
    if v529 % 128 >= 64 then
    end
    if v529 % 256 >= 128 then
    end
    v523.IncludeOffSale = v530
end

function v214.CatalogueSearchParams() -- line 1166 | captures: v513
    return v513
end

local function cframeLookupEntries() -- line 1170
    return {
        CFrame.Angles(0, 0, 0),
        CFrame.Angles(1.5707963267948966, 0, 0),
        CFrame.Angles(0, 3.141592653589793, 3.141592653589793),
        CFrame.Angles(-1.5707963267948966, 0, 0),
        CFrame.Angles(0, 3.141592653589793, 1.5707963267948966),
        CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966),
        CFrame.Angles(0, 0, 1.5707963267948966),
        CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
        CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0),
        CFrame.Angles(0, -1.5707963267948966, 0),
        CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0),
        CFrame.Angles(0, 1.5707963267948966, 3.141592653589793),
        CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
        CFrame.Angles(0, 3.141592653589793, 0),
        CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0),
        CFrame.Angles(0, 0, 3.141592653589793),
        CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
        CFrame.Angles(0, 0, -1.5707963267948966),
        CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
        CFrame.Angles(0, -3.141592653589793, -1.5707963267948966),
        CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966),
        CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0),
        CFrame.Angles(0, 1.5707963267948966, 0),
        CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)
    }
end

local function cframeSpecialCaseLookup(v531) -- line 1199
    local function v532(...)
        return (Vector3.new(...))
    end

    local v533 = {}
    for v534, v535 in v531 do
        v533[v532(v535:ToOrientation())] = v534
    end
    return v533
end

local v536, v537

local function rotser(v538, v539) -- line 1211 | captures: v536, v537, tryRealloc, cframeLookupEntries, cframeSpecialCaseLookup
    local function v540(...)
        return (Vector3.new(...))
    end

    v536 = v536 or cframeLookupEntries()
    v537 = v537 or cframeSpecialCaseLookup(v536)
    local v541 = v537[v540(v539:ToOrientation())]
    if v541 then
        tryRealloc(v538, 1)
        local Buf = v538.Buf
        local Pos = v538.Pos
        buffer.writeu8(Buf, Pos, v541)
    else
        local v542, v543 = v539:ToAxisAngle()
        local v544 = v543 / 2
        local v545 = v542 * math.sin(v544)
        local v546 = (v545.Z + 1) * 32767.5
        tryRealloc(v538, 2)
        local Buf = v538.Buf
        local Pos = v538.Pos
        buffer.writeu16(Buf, Pos, v546)
        v538.Pos += 2
        local v547 = (v545.Y + 1) * 32767.5
        tryRealloc(v538, 2)
        local Buf_2 = v538.Buf
        local Pos_2 = v538.Pos
        buffer.writeu16(Buf_2, Pos_2, v547)
        v538.Pos += 2
        local v548 = (v545.X + 1) * 32767.5
        tryRealloc(v538, 2)
        local Buf_3 = v538.Buf
        local Pos_3 = v538.Pos
        buffer.writeu16(Buf_3, Pos_3, v548)
        v538.Pos += 2
        tryRealloc(v538, 1)
        local Buf_4 = v538.Buf
        local Pos_4 = v538.Pos
        buffer.writeu8(Buf_4, Pos_4, 0)
    end
    v538.Pos += 1
end

local function rotdes(v549) -- line 1229 | captures: v536
    v549.Pos -= 1
    local Buf = v549.Buf
    local Pos = v549.Pos
    local v550 = buffer.readu8(Buf, Pos)
    if v550 == 0 then
        v549.Pos -= 2
        local Buf = v549.Buf
        local Pos = v549.Pos
        local v551 = buffer.readu16(Buf, Pos) * 0.000030518043793392844 - 1
        v549.Pos -= 2
        local Buf_2 = v549.Buf
        local Pos_2 = v549.Pos
        local v552 = buffer.readu16(Buf_2, Pos_2) * 0.000030518043793392844 - 1
        v549.Pos -= 2
        local Buf_3 = v549.Buf
        local Pos_3 = v549.Pos
        local v553 = buffer.readu16(Buf_3, Pos_3) * 0.000030518043793392844 - 1
        local v554 = 1 - v551 * v551 - v552 * v552 - v553 * v553
        local v555 = math.sqrt(v554)
        return CFrame.new(0, 0, 0, v551, v552, v553, v555)
    end
    return v536[v550]
end

local v556 = {
    ser = rotser,
    des = rotdes
}

function v214.rotation() -- line 1246 | captures: v556
    return v556
end

local v557 = {}

local function cframe(v558) -- line 1251 | captures: rotser, rotdes, v557
    if v557[v558] then
        return v557[v558]
    end
    local ser = v558.ser
    local des = v558.des
    local v559 = {}

    function v559.ser(v560, v561) -- line 1259 | captures: ser, rotser
        rotser(v560, v561)
        local Position = v561.Position
        ser(v560, Position.Z)
        ser(v560, Position.Y)
        ser(v560, Position.X)
    end

    function v559.des(v562) -- line 1268 | captures: des, rotdes
        local v563 = des(v562)
        local v564 = des(v562)
        local v565 = des(v562)
        return rotdes(v562) + Vector3.new(v563, v564, v565)
    end

    v557[v558] = v559
    return v559
end

v214.CFrame = cframe

local function pushcolor3(v566, v567) -- line 1279 | captures: tryRealloc
    local v568 = v567.B * 255
    tryRealloc(v566, 1)
    local Buf = v566.Buf
    local Pos = v566.Pos
    buffer.writeu8(Buf, Pos, v568)
    v566.Pos += 1
    local v569 = v567.G * 255
    tryRealloc(v566, 1)
    local Buf_2 = v566.Buf
    local Pos_2 = v566.Pos
    buffer.writeu8(Buf_2, Pos_2, v569)
    v566.Pos += 1
    local v570 = v567.R * 255
    tryRealloc(v566, 1)
    local Buf_3 = v566.Buf
    local Pos_3 = v566.Pos
    buffer.writeu8(Buf_3, Pos_3, v570)
    v566.Pos += 1
end

local function popcolor3(v571) -- line 1284
    local fromRGB = Color3.fromRGB
    v571.Pos -= 1
    local Buf = v571.Buf
    local Pos = v571.Pos
    local v572 = buffer.readu8(Buf, Pos)
    v571.Pos -= 1
    local Buf_2 = v571.Buf
    local Pos_2 = v571.Pos
    local v573 = buffer.readu8(Buf_2, Pos_2)
    v571.Pos -= 1
    local Buf_3 = v571.Buf
    local Pos_3 = v571.Pos
    return fromRGB(v572, v573, (buffer.readu8(Buf_3, Pos_3)))
end

local v574 = {
    ser = pushcolor3,
    des = popcolor3
}

function v214.Color3() -- line 1291 | captures: v574
    return v574
end

local v575 = {
    ser = function(v576, v577) -- pushcolorsequencekeypoint | line 1295 | captures: tryRealloc
        local Value = v577.Value
        local v578 = Value.B * 255
        tryRealloc(v576, 1)
        local Buf = v576.Buf
        local Pos = v576.Pos
        buffer.writeu8(Buf, Pos, v578)
        v576.Pos += 1
        local v579 = Value.G * 255
        tryRealloc(v576, 1)
        local Buf_2 = v576.Buf
        local Pos_2 = v576.Pos
        buffer.writeu8(Buf_2, Pos_2, v579)
        v576.Pos += 1
        local v580 = Value.R * 255
        tryRealloc(v576, 1)
        local Buf_3 = v576.Buf
        local Pos_3 = v576.Pos
        buffer.writeu8(Buf_3, Pos_3, v580)
        v576.Pos += 1
        local v581 = v577.Time * 255
        tryRealloc(v576, 1)
        local Buf_4 = v576.Buf
        local Pos_4 = v576.Pos
        buffer.writeu8(Buf_4, Pos_4, v581)
        v576.Pos += 1
    end,
    des = function(v582) -- popcolorsequencekeypoint | line 1299 | captures: popcolor3
        local new = ColorSequenceKeypoint.new
        v582.Pos -= 1
        local Buf = v582.Buf
        local Pos = v582.Pos
        return new(buffer.readu8(Buf, Pos) / 255, popcolor3(v582))
    end
}

function v214.ColorSequenceKeypoint() -- line 1309 | captures: v575
    return v575
end

local v583 = {}

function v583.ser(v584, v585) -- line 1314 | captures: tryRealloc, pushvlq
    for v586, v587 in v585.Keypoints do
        local Value = v587.Value
        local v588 = Value.B * 255
        tryRealloc(v584, 1)
        local Buf = v584.Buf
        local Pos = v584.Pos
        buffer.writeu8(Buf, Pos, v588)
        v584.Pos += 1
        local v589 = Value.G * 255
        tryRealloc(v584, 1)
        local Buf_2 = v584.Buf
        local Pos_2 = v584.Pos
        buffer.writeu8(Buf_2, Pos_2, v589)
        v584.Pos += 1
        local v590 = Value.R * 255
        tryRealloc(v584, 1)
        local Buf_3 = v584.Buf
        local Pos_3 = v584.Pos
        buffer.writeu8(Buf_3, Pos_3, v590)
        v584.Pos += 1
        local v591 = v587.Time * 255
        tryRealloc(v584, 1)
        local Buf_4 = v584.Buf
        local Pos_4 = v584.Pos
        buffer.writeu8(Buf_4, Pos_4, v591)
        v584.Pos += 1
    end
    pushvlq(v584, #v585.Keypoints)
end

function v583.des(v592) -- line 1321 | captures: popvlq, popcolor3
    local v593 = popvlq(v592)
    local v594 = table.create(v593)
    for v595 = v593, 1, -1 do
        local new = ColorSequenceKeypoint.new
        v592.Pos -= 1
        local Buf = v592.Buf
        local Pos = v592.Pos
        v594[v595] = new(buffer.readu8(Buf, Pos) / 255, popcolor3(v592))
    end
    return ColorSequence.new(v594)
end

function v214.ColorSequence() -- line 1330 | captures: v583
    return v583
end

local v596 = {}

function v596.ser(v597, v598) -- line 1335 | captures: tryRealloc
    local UnixTimestampMillis = v598.UnixTimestampMillis
    tryRealloc(v597, 6)
    local Buf = v597.Buf
    local Pos = v597.Pos
    buffer.writeu16(Buf, Pos, UnixTimestampMillis)
    local Buf_2 = v597.Buf
    local v599 = v597.Pos + 2
    local v600 = UnixTimestampMillis // 65536
    buffer.writeu32(Buf_2, v599, v600)
    v597.Pos += 6
end

local function des_3(v601) -- line 1338
    local fromUnixTimestampMillis = DateTime.fromUnixTimestampMillis
    v601.Pos -= 6
    local Buf = v601.Buf
    local Pos = v601.Pos
    local v602 = buffer.readu16(Buf, Pos)
    local Buf_2 = v601.Buf
    local v603 = v601.Pos + 2
    return fromUnixTimestampMillis(v602 + buffer.readu32(Buf_2, v603) * 65536)
end

v596.des = des_3

function v214.DateTime() -- line 1342 | captures: v596
    return v596
end

local v604 = {}

function v604.ser(v605, v606) -- line 1347 | captures: tryRealloc
    local Back = v606.Back
    local Bottom = v606.Bottom
    local Front = v606.Front
    local Left = v606.Left
    local Right = v606.Right
    local Top = v606.Top
    local v607 = if Back then 1 else 0
    local v608 = if Bottom then 2 else 0
    local v609 = v607 + v608
    local v610 = if Front then 4 else 0
    local v611 = v609 + v610
    local v612 = if Left then 8 else 0
    local v613 = v611 + v612
    local v614 = if Right then 16 else 0
    local v615 = v613 + v614
    local v616 = if Top then 32 else 0
    local v617 = v615 + v616 + 0 + 0
    tryRealloc(v605, 1)
    local Buf = v605.Buf
    local Pos = v605.Pos
    buffer.writeu8(Buf, Pos, v617)
    v605.Pos += 1
end

local function des_4(v618) -- line 1351
    v618.Pos -= 1
    local Buf = v618.Buf
    local Pos = v618.Pos
    local v619 = buffer.readu8(Buf, Pos)
    local v620 = v619 % 2 >= 1
    local v621 = v619 % 4 >= 2
    local v622 = v619 % 8 >= 4
    local v623 = v619 % 16 >= 8
    local v624 = v619 % 32 >= 16
    local v625 = v619 % 64 >= 32
    if v619 % 128 >= 64 then
    end
    if v619 % 256 >= 128 then
    end
    return Faces.new(v620 and Enum.NormalId.Back, v621 and Enum.NormalId.Bottom, v622 and Enum.NormalId.Front, v623 and Enum.NormalId.Left, v624 and Enum.NormalId.Right, v625 and Enum.NormalId.Top)
end

v604.des = des_4

function v214.Faces() -- line 1363 | captures: v604
    return v604
end

local v626 = {}

function v626.ser(v627, v628) -- line 1368 | captures: tryRealloc, enumitem
    enumitem(Enum.KeyInterpolationMode).ser(v627, v628.Interpolation)
    local Value = v628.Value
    tryRealloc(v627, 4)
    local Buf = v627.Buf
    local Pos = v627.Pos
    buffer.writef32(Buf, Pos, Value)
    v627.Pos += 4
    local Time = v628.Time
    tryRealloc(v627, 4)
    local Buf_2 = v627.Buf
    local Pos_2 = v627.Pos
    buffer.writef32(Buf_2, Pos_2, Time)
    v627.Pos += 4
end

function v626.des(v629) -- line 1374 | captures: enumitem
    local new = FloatCurveKey.new
    v629.Pos -= 4
    local Buf = v629.Buf
    local Pos = v629.Pos
    local v630 = buffer.readf32(Buf, Pos)
    v629.Pos -= 4
    local Buf_2 = v629.Buf
    local Pos_2 = v629.Pos
    return new(v630, buffer.readf32(Buf_2, Pos_2), (enumitem(Enum.KeyInterpolationMode).des(v629)))
end

function v214.FloatCurveKey() -- line 1382 | captures: v626
    return v626
end

local v631 = {}

function v631.ser(v632, v633) -- line 1387 | captures: tryRealloc, pushvlq, enumitem
    local v634 = string.match(v633.Family, "rbxasset://fonts/families/(.+).json") or error((("Invalid font family %*"):format(v633.Family)))
    local v635 = #v634
    tryRealloc(v632, v635)
    buffer.writestring(v632.Buf, v632.Pos, v634)
    v632.Pos += v635
    pushvlq(v632, v635)
    local v636 = if v633.Bold then 1 else 0
    local v637 = v636 + 0 + 0 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v632, 1)
    local Buf = v632.Buf
    local Pos = v632.Pos
    buffer.writeu8(Buf, Pos, v637)
    v632.Pos += 1
    enumitem(Enum.FontWeight).ser(v632, v633.Weight)
    enumitem(Enum.FontStyle).ser(v632, v633.Style)
end

function v631.des(v638) -- line 1395 | captures: popvlq, enumitem
    local v639 = enumitem(Enum.FontStyle).des(v638)
    local v640 = enumitem(Enum.FontWeight).des(v638)
    v638.Pos -= 1
    local Buf = v638.Buf
    local Pos = v638.Pos
    local v641 = buffer.readu8(Buf, Pos)
    local v642 = v641 % 2 >= 1
    if v641 % 4 >= 2 then
    end
    if v641 % 8 >= 4 then
    end
    if v641 % 16 >= 8 then
    end
    if v641 % 32 >= 16 then
    end
    if v641 % 64 >= 32 then
    end
    if v641 % 128 >= 64 then
    end
    if v641 % 256 >= 128 then
    end
    local v643 = popvlq(v638)
    v638.Pos -= v643
    local v644 = buffer.readstring(v638.Buf, v638.Pos, v643)
    local v645 = Font.new(("rbxasset://fonts/families/%*.json"):format(v644), v640, v639)
    v645.Bold = v642
    return v645
end

function v214.Font() -- line 1405 | captures: v631
    return v631
end

local v646 = {}

function v214.NumberRange(v647) -- line 1410 | captures: v646
    if v646[v647] then
        return v646[v647]
    end
    local ser = v647.ser
    local des = v647.des
    local v648 = {}

    function v648.ser(v649, v650) -- line 1418 | captures: ser
        ser(v649, v650.Max)
        ser(v649, v650.Min)
    end

    function v648.des(v651) -- line 1423 | captures: des
        return NumberRange.new(des(v651), des(v651))
    end

    v646[v647] = v648
    return v648
end

local v652 = {}

local function numbersequencekeypoint(v653) -- line 1433 | captures: tryRealloc, v652
    if v652[v653] then
        return v652[v653]
    end
    local ser = v653.ser
    local des = v653.des
    local v654 = {}

    function v654.ser(v655, v656) -- line 1441 | captures: ser, tryRealloc
        ser(v655, v656.Value)
        ser(v655, v656.Envelope)
        local v657 = v656.Time * 255
        tryRealloc(v655, 8)
        local Buf = v655.Buf
        local Pos = v655.Pos
        buffer.writeu32(Buf, Pos, v657)
        local Buf_2 = v655.Buf
        local v658 = v655.Pos + 4
        local v659 = v657 // 4294967296
        buffer.writeu32(Buf_2, v658, v659)
        v655.Pos += 8
    end

    function v654.des(v660) -- line 1447 | captures: des
        v660.Pos -= 8
        local Buf = v660.Buf
        local Pos = v660.Pos
        local v661 = buffer.readu32(Buf, Pos)
        local Buf_2 = v660.Buf
        local v662 = v660.Pos + 4
        local v663 = (v661 + buffer.readu32(Buf_2, v662) * 4294967296) / 255
        local v664 = des(v660)
        local v665 = des(v660)
        return NumberSequenceKeypoint.new(v663, v665, v664)
    end

    v652[v653] = v654
    return v654
end

v214.NumberSequenceKeypoint = numbersequencekeypoint

local v666 = {}

function v214.NumberSequence(v667) -- line 1460 | captures: pushvlq, popvlq, numbersequencekeypoint, v666
    if v666[v667] then
        return v666[v667]
    end
    local ser = numbersequencekeypoint(v667).ser
    local des = numbersequencekeypoint(v667).des
    local v668 = {}

    function v668.ser(v669, v670) -- line 1468 | captures: ser, pushvlq
        for v671, v672 in v670.Keypoints do
            ser(v669, v672)
        end
        pushvlq(v669, #v670.Keypoints)
    end

    function v668.des(v673) -- line 1475 | captures: des, popvlq
        local v674 = popvlq(v673)
        local v675 = table.create(v674)
        for v676 = v674, 1, -1 do
            v675[v676] = des(v673)
        end
        return NumberSequence.new(v675)
    end

    v666[v667] = v668
    return v668
end

local v677 = {}

function v677.ser(v678, v679) -- line 1492 | captures: tryRealloc, pushvlq, enumitem
    local BruteForceAllSlow = v679.BruteForceAllSlow
    local RespectCanCollide = v679.RespectCanCollide
    local v680 = if BruteForceAllSlow then 1 else 0
    local v681 = if RespectCanCollide then 2 else 0
    local v682 = v680 + v681 + 0 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v678, 1)
    local Buf = v678.Buf
    local Pos = v678.Pos
    buffer.writeu8(Buf, Pos, v682)
    v678.Pos += 1
    local MaxParts = v679.MaxParts
    tryRealloc(v678, 2)
    local Buf_2 = v678.Buf
    local Pos_2 = v678.Pos
    buffer.writeu16(Buf_2, Pos_2, MaxParts)
    v678.Pos += 2
    enumitem(Enum.RaycastFilterType).ser(v678, v679.FilterType)
    local CollisionGroup = v679.CollisionGroup
    local v683 = #CollisionGroup
    tryRealloc(v678, v683)
    buffer.writestring(v678.Buf, v678.Pos, CollisionGroup)
    v678.Pos += v683
    pushvlq(v678, v683)
end

function v677.des(v684) -- line 1499 | captures: popvlq, enumitem
    local v685 = OverlapParams.new()
    local v686 = popvlq(v684)
    v684.Pos -= v686
    v685.CollisionGroup = buffer.readstring(v684.Buf, v684.Pos, v686)
    v685.FilterType = enumitem(Enum.RaycastFilterType).des(v684)
    v684.Pos -= 2
    local Buf = v684.Buf
    local Pos = v684.Pos
    v685.MaxParts = buffer.readu16(Buf, Pos)
    v684.Pos -= 1
    local Buf_2 = v684.Buf
    local Pos_2 = v684.Pos
    local v687 = buffer.readu8(Buf_2, Pos_2)
    local v688 = v687 % 2 >= 1
    local v689 = v687 % 4 >= 2
    if v687 % 8 >= 4 then
    end
    if v687 % 16 >= 8 then
    end
    if v687 % 32 >= 16 then
    end
    if v687 % 64 >= 32 then
    end
    if v687 % 128 >= 64 then
    end
    if v687 % 256 >= 128 then
    end
    v685.BruteForceAllSlow = v688
    v685.RespectCanCollide = v689
    return v685
end

function v214.OverlapParams() -- line 1508 | captures: v677
    return v677
end

local v690 = {}

function v690.ser(v691, v692) -- line 1513 | captures: tryRealloc, pushvlq, enumitem
    local BruteForceAllSlow = v692.BruteForceAllSlow
    local RespectCanCollide = v692.RespectCanCollide
    local IgnoreWater = v692.IgnoreWater
    local v693 = if BruteForceAllSlow then 1 else 0
    local v694 = if RespectCanCollide then 2 else 0
    local v695 = v693 + v694
    local v696 = if IgnoreWater then 4 else 0
    local v697 = v695 + v696 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v691, 1)
    local Buf = v691.Buf
    local Pos = v691.Pos
    buffer.writeu8(Buf, Pos, v697)
    v691.Pos += 1
    enumitem(Enum.RaycastFilterType).ser(v691, v692.FilterType)
    local CollisionGroup = v692.CollisionGroup
    local v698 = #CollisionGroup
    tryRealloc(v691, v698)
    buffer.writestring(v691.Buf, v691.Pos, CollisionGroup)
    v691.Pos += v698
    pushvlq(v691, v698)
end

function v690.des(v699) -- line 1519 | captures: popvlq, enumitem
    local v700 = RaycastParams.new()
    local v701 = popvlq(v699)
    v699.Pos -= v701
    v700.CollisionGroup = buffer.readstring(v699.Buf, v699.Pos, v701)
    v700.FilterType = enumitem(Enum.RaycastFilterType).des(v699)
    v699.Pos -= 1
    local Buf = v699.Buf
    local Pos = v699.Pos
    local v702 = buffer.readu8(Buf, Pos)
    local v703 = v702 % 2 >= 1
    local v704 = v702 % 4 >= 2
    local v705 = v702 % 8 >= 4
    if v702 % 16 >= 8 then
    end
    if v702 % 32 >= 16 then
    end
    if v702 % 64 >= 32 then
    end
    if v702 % 128 >= 64 then
    end
    if v702 % 256 >= 128 then
    end
    v700.BruteForceAllSlow = v703
    v700.RespectCanCollide = v704
    v700.IgnoreWater = v705
    return v700
end

function v214.RaycastParams() -- line 1527 | captures: v690
    return v690
end

local v706 = {}

function v214.Vector3(v707) -- line 1532 | captures: v706
    if v706[v707] then
        return v706[v707]
    end
    local ser = v707.ser
    local des = v707.des
    local v708 = {}

    function v708.ser(v709, v710) -- line 1540 | captures: ser
        ser(v709, v710.Z)
        ser(v709, v710.Y)
        ser(v709, v710.X)
    end

    function v708.des(v711) -- line 1546 | captures: des
        local function v712(v713, v714, ...)
            return (Vector3.new(v713, v714, ...))
        end

        return (v712(des(v711), des(v711), des(v711)))
    end

    v706[v707] = v708
    return v708
end

local v715 = {}

function v214.PathWaypoint(v716) -- line 1557 | captures: tryRealloc, pushvlq, popstr, enumitem, v715
    if v715[v716] then
        return v715[v716]
    end
    local ser = v716.ser
    local des = v716.des
    local v717 = {}

    function v717.ser(v718, v719) -- line 1565 | captures: ser, tryRealloc, pushvlq, enumitem
        local Label = v719.Label
        local v720 = #Label
        tryRealloc(v718, v720)
        buffer.writestring(v718.Buf, v718.Pos, Label)
        v718.Pos += v720
        pushvlq(v718, v720)
        enumitem(Enum.PathWaypointAction).ser(v718, v719.Action)
        ser(v718, v719.Position.Z)
        ser(v718, v719.Position.Y)
        ser(v718, v719.Position.X)
    end

    function v717.des(v721) -- line 1573 | captures: des, popstr, enumitem
        local function v722(v723, v724, ...)
            return (Vector3.new(v723, v724, ...))
        end

        return PathWaypoint.new(v722(des(v721), des(v721), des(v721)), enumitem(Enum.PathWaypointAction).des(v721), popstr(v721))
    end

    v715[v716] = v717
    return v717
end

local v725 = {}

function v725.ser(v726, v727) -- line 1587 | captures: tryRealloc
    local ElasticityWeight = v727.ElasticityWeight
    tryRealloc(v726, 4)
    local Buf = v726.Buf
    local Pos = v726.Pos
    buffer.writef32(Buf, Pos, ElasticityWeight)
    v726.Pos += 4
    local FrictionWeight = v727.FrictionWeight
    tryRealloc(v726, 4)
    local Buf_2 = v726.Buf
    local Pos_2 = v726.Pos
    buffer.writef32(Buf_2, Pos_2, FrictionWeight)
    v726.Pos += 4
    local Elasticity = v727.Elasticity
    tryRealloc(v726, 4)
    local Buf_3 = v726.Buf
    local Pos_3 = v726.Pos
    buffer.writef32(Buf_3, Pos_3, Elasticity)
    v726.Pos += 4
    local Friction = v727.Friction
    tryRealloc(v726, 4)
    local Buf_4 = v726.Buf
    local Pos_4 = v726.Pos
    buffer.writef32(Buf_4, Pos_4, Friction)
    v726.Pos += 4
    local Density = v727.Density
    tryRealloc(v726, 4)
    local Buf_5 = v726.Buf
    local Pos_5 = v726.Pos
    buffer.writef32(Buf_5, Pos_5, Density)
    v726.Pos += 4
end

local function des_5(v728) -- line 1595
    local new = PhysicalProperties.new
    v728.Pos -= 4
    local Buf = v728.Buf
    local Pos = v728.Pos
    local v729 = buffer.readf32(Buf, Pos)
    v728.Pos -= 4
    local Buf_2 = v728.Buf
    local Pos_2 = v728.Pos
    local v730 = buffer.readf32(Buf_2, Pos_2)
    v728.Pos -= 4
    local Buf_3 = v728.Buf
    local Pos_3 = v728.Pos
    local v731 = buffer.readf32(Buf_3, Pos_3)
    v728.Pos -= 4
    local Buf_4 = v728.Buf
    local Pos_4 = v728.Pos
    local v732 = buffer.readf32(Buf_4, Pos_4)
    v728.Pos -= 4
    local Buf_5 = v728.Buf
    local Pos_5 = v728.Pos
    return new(v729, v730, v731, v732, (buffer.readf32(Buf_5, Pos_5)))
end

v725.des = des_5

function v214.PhysicalProperties() -- line 1605 | captures: v725
    return v725
end

local v733 = {}

function v214.Ray(v734) -- line 1610 | captures: v733
    if v733[v734] then
        return v733[v734]
    end
    local ser = v734.ser
    local des = v734.des
    local v735 = {}

    function v735.ser(v736, v737) -- line 1618 | captures: ser
        ser(v736, v737.Direction.Z)
        ser(v736, v737.Direction.Y)
        ser(v736, v737.Direction.X)
        ser(v736, v737.Origin.Z)
        ser(v736, v737.Origin.Y)
        ser(v736, v737.Origin.X)
    end

    function v735.des(v738) -- line 1627 | captures: des
        local function v739(v740, v741, ...)
            return (Vector3.new(v740, v741, ...))
        end

        local function v742(v743, v744, ...)
            return (Vector3.new(v743, v744, ...))
        end

        return Ray.new(v739(des(v738), des(v738), des(v738)), (v742(des(v738), des(v738), des(v738))))
    end

    v733[v734] = v735
    return v735
end

local v745 = {}

function v214.RaycastResult(v746) -- line 1647 | captures: tryRealloc, enumitem, v690, v745
    if v745[v746] then
        return v690[v746]
    end
    local ser = v746.ser
    local des = v746.des
    local v747 = {}

    function v747.ser(v748, v749) -- line 1655 | captures: ser, tryRealloc, enumitem
        local Distance = v749.Distance
        tryRealloc(v748, 4)
        local Buf = v748.Buf
        local Pos = v748.Pos
        buffer.writef32(Buf, Pos, Distance)
        v748.Pos += 4
        ser(v748, v749.Position.Z)
        ser(v748, v749.Position.Y)
        ser(v748, v749.Position.X)
        ser(v748, v749.Normal.Z)
        ser(v748, v749.Normal.Y)
        ser(v748, v749.Normal.X)
        enumitem(Enum.Material).ser(v748, v749.Material)
    end

    function v747.des(v750) -- line 1666 | captures: des, enumitem
        local function v751(v752, v753, ...)
            return (Vector3.new(v752, v753, ...))
        end

        local function v754(v755, v756, ...)
            return (Vector3.new(v755, v756, ...))
        end

        local v757 = {
            Instance = nil,
            Material = enumitem(Enum.Material).des(v750),
            Normal = v751(des(v750), des(v750), des(v750)),
            Position = v754(des(v750), des(v750), des(v750))
        }
        v750.Pos -= 4
        local Buf = v750.Buf
        local Pos = v750.Pos
        v757.Distance = buffer.readf32(Buf, Pos)
        return v757
    end

    v745[v746] = v747
    return v747
end

local v758 = {}

function v214.Vector2(v759) -- line 1682 | captures: v758
    if v758[v759] then
        return v758[v759]
    end
    local ser = v759.ser
    local des = v759.des
    local v760 = {}

    function v760.ser(v761, v762) -- line 1690 | captures: ser
        ser(v761, v762.Y)
        ser(v761, v762.X)
    end

    function v760.des(v763) -- line 1695 | captures: des
        return Vector2.new(des(v763), des(v763))
    end

    v758[v759] = v760
    return v760
end

local v764 = {}

function v214.Rect(v765) -- line 1705 | captures: v764
    if v764[v765] then
        return v764[v765]
    end
    local ser = v765.ser
    local des = v765.des
    local v766 = {}

    function v766.ser(v767, v768) -- line 1713 | captures: ser
        ser(v767, v768.Max.Y)
        ser(v767, v768.Max.X)
        ser(v767, v768.Min.Y)
        ser(v767, v768.Min.X)
    end

    function v766.des(v769) -- line 1720 | captures: des
        return Rect.new(des(v769), des(v769), des(v769), des(v769))
    end

    v764[v765] = v766
    return v766
end

local v770 = {}

function v214.Region3(v771) -- line 1729 | captures: v770
    if v770[v771] then
        return v770[v771]
    end
    local ser = v771.ser
    local des = v771.des
    local v772 = {}

    function v772.ser(v773, v774) -- line 1737 | captures: ser
        local Size = v774.Size
        ser(v773, Size.Z)
        ser(v773, Size.Y)
        ser(v773, Size.X)
        local Position = v774.CFrame.Position
        ser(v773, Position.Z)
        ser(v773, Position.Y)
        ser(v773, Position.X)
    end

    function v772.des(v775) -- line 1748 | captures: des
        local function v776(v777, v778, ...)
            return (Vector3.new(v777, v778, ...))
        end

        local function v779(v780, v781, ...)
            return (Vector3.new(v780, v781, ...))
        end

        local v782 = v776(des(v775), des(v775), des(v775))
        local v783 = v779(des(v775), des(v775), des(v775)) * 0.5
        return Region3.new(v782 - v783, v782 + v783)
    end

    v770[v771] = v772
    return v772
end

local v784 = {}

function v784.ser(v785, v786) -- line 1759 | captures: tryRealloc
    local Max = v786.Max
    local Z = Max.Z
    tryRealloc(v785, 2)
    local Buf = v785.Buf
    local Pos = v785.Pos
    buffer.writei16(Buf, Pos, Z)
    v785.Pos += 2
    local Y = Max.Y
    tryRealloc(v785, 2)
    local Buf_2 = v785.Buf
    local Pos_2 = v785.Pos
    buffer.writei16(Buf_2, Pos_2, Y)
    v785.Pos += 2
    local X = Max.X
    tryRealloc(v785, 2)
    local Buf_3 = v785.Buf
    local Pos_3 = v785.Pos
    buffer.writei16(Buf_3, Pos_3, X)
    v785.Pos += 2
    local Min = v786.Min
    local Z_2 = Min.Z
    tryRealloc(v785, 2)
    local Buf_4 = v785.Buf
    local Pos_4 = v785.Pos
    buffer.writei16(Buf_4, Pos_4, Z_2)
    v785.Pos += 2
    local Y_2 = Min.Y
    tryRealloc(v785, 2)
    local Buf_5 = v785.Buf
    local Pos_5 = v785.Pos
    buffer.writei16(Buf_5, Pos_5, Y_2)
    v785.Pos += 2
    local X_2 = Min.X
    tryRealloc(v785, 2)
    local Buf_6 = v785.Buf
    local Pos_6 = v785.Pos
    buffer.writei16(Buf_6, Pos_6, X_2)
    v785.Pos += 2
end

local function des_6(v787) -- line 1770
    local new = Vector3int16.new
    v787.Pos -= 2
    local Buf = v787.Buf
    local Pos = v787.Pos
    local v788 = buffer.readi16(Buf, Pos)
    v787.Pos -= 2
    local Buf_2 = v787.Buf
    local Pos_2 = v787.Pos
    local v789 = buffer.readi16(Buf_2, Pos_2)
    v787.Pos -= 2
    local Buf_3 = v787.Buf
    local Pos_3 = v787.Pos
    local v790 = new(v788, v789, (buffer.readi16(Buf_3, Pos_3)))
    local new_2 = Vector3int16.new
    v787.Pos -= 2
    local Buf_4 = v787.Buf
    local Pos_4 = v787.Pos
    local v791 = buffer.readi16(Buf_4, Pos_4)
    v787.Pos -= 2
    local Buf_5 = v787.Buf
    local Pos_5 = v787.Pos
    local v792 = buffer.readi16(Buf_5, Pos_5)
    v787.Pos -= 2
    local Buf_6 = v787.Buf
    local Pos_6 = v787.Pos
    local v793 = new_2(v791, v792, (buffer.readi16(Buf_6, Pos_6)))
    return Region3int16.new(v790, v793)
end

v784.des = des_6

function v214.Region3int16() -- line 1776 | captures: v784
    return v784
end

local v794 = {}

function v214.RotationCurveKey(v795) -- line 1781 | captures: tryRealloc, enumitem, cframe, v794
    if v794[v795] then
        return v794[v795]
    end
    local ser = cframe(v795).ser
    local des = cframe(v795).des
    local v796 = {}

    function v796.ser(v797, v798) -- line 1789 | captures: ser, tryRealloc, enumitem
        enumitem(Enum.KeyInterpolationMode).ser(v797, v798.Interpolation)
        ser(v797, v798.Value)
        local Time = v798.Time
        tryRealloc(v797, 4)
        local Buf = v797.Buf
        local Pos = v797.Pos
        buffer.writef32(Buf, Pos, Time)
        v797.Pos += 4
    end

    function v796.des(v799) -- line 1795 | captures: des, enumitem
        local new = RotationCurveKey.new
        v799.Pos -= 4
        local Buf = v799.Buf
        local Pos = v799.Pos
        return new(buffer.readf32(Buf, Pos), des(v799), (enumitem(Enum.KeyInterpolationMode).des(v799)))
    end

    v794[v795] = v796
    return v796
end

local v800 = {}

function v800.ser(v801, v802) -- line 1808 | captures: tryRealloc, pushvlq, enumitem
    local DelayTime = v802.DelayTime
    tryRealloc(v801, 4)
    local Buf = v801.Buf
    local Pos = v801.Pos
    buffer.writef32(Buf, Pos, DelayTime)
    v801.Pos += 4
    local v803 = if v802.Reverses then 1 else 0
    local v804 = v803 + 0 + 0 + 0 + 0 + 0 + 0 + 0
    tryRealloc(v801, 1)
    local Buf_2 = v801.Buf
    local Pos_2 = v801.Pos
    buffer.writeu8(Buf_2, Pos_2, v804)
    v801.Pos += 1
    pushvlq(v801, v802.RepeatCount)
    enumitem(Enum.EasingDirection).ser(v801, v802.EasingDirection)
    enumitem(Enum.EasingStyle).ser(v801, v802.EasingStyle)
    local Time = v802.Time
    tryRealloc(v801, 4)
    local Buf_3 = v801.Buf
    local Pos_3 = v801.Pos
    buffer.writef32(Buf_3, Pos_3, Time)
    v801.Pos += 4
end

function v800.des(v805) -- line 1817 | captures: popvlq, enumitem
    local new = TweenInfo.new
    v805.Pos -= 4
    local Buf = v805.Buf
    local Pos = v805.Pos
    local v806 = buffer.readf32(Buf, Pos)
    local v807 = enumitem(Enum.EasingStyle).des(v805)
    local v808 = enumitem(Enum.EasingDirection).des(v805)
    local v809 = popvlq(v805)
    v805.Pos -= 1
    local Buf_2 = v805.Buf
    local Pos_2 = v805.Pos
    local v810 = buffer.readu8(Buf_2, Pos_2)
    local v811 = v810 % 2 >= 1
    if v810 % 4 >= 2 then
    end
    if v810 % 8 >= 4 then
    end
    if v810 % 16 >= 8 then
    end
    if v810 % 32 >= 16 then
    end
    if v810 % 64 >= 32 then
    end
    if v810 % 128 >= 64 then
    end
    if v810 % 256 >= 128 then
    end
    v805.Pos -= 4
    local Buf_3 = v805.Buf
    local Pos_3 = v805.Pos
    return new(v806, v807, v808, v809, v811, (buffer.readf32(Buf_3, Pos_3)))
end

function v214.TweenInfo() -- line 1828 | captures: v800
    return v800
end

local v812 = {}

function v214.UDim(v813) -- line 1833 | captures: v812
    if v812[v813] then
        return v812[v813]
    end
    local ser = v813.ser
    local des = v813.des
    local v814 = {}

    function v814.ser(v815, v816) -- line 1841 | captures: ser
        ser(v815, v816.Offset)
        ser(v815, v816.Scale)
    end

    function v814.des(v817) -- line 1846 | captures: des
        return UDim.new(des(v817), des(v817))
    end

    v812[v813] = v814
    return v814
end

local v818 = {}

function v214.UDim2(v819) -- line 1856 | captures: v818
    if v818[v819] then
        return v818[v819]
    end
    local ser = v819.ser
    local des = v819.des
    local v820 = {}

    function v820.ser(v821, v822) -- line 1864 | captures: ser
        ser(v821, v822.Y.Offset)
        ser(v821, v822.Y.Scale)
        ser(v821, v822.X.Offset)
        ser(v821, v822.X.Scale)
    end

    function v820.des(v823) -- line 1871 | captures: des
        return UDim2.new(des(v823), des(v823), des(v823), des(v823))
    end

    v818[v819] = v820
    return v820
end

local v824 = {}

function v824.ser(v825, v826) -- line 1881 | captures: tryRealloc
    local Y = v826.Y
    tryRealloc(v825, 2)
    local Buf = v825.Buf
    local Pos = v825.Pos
    buffer.writei16(Buf, Pos, Y)
    v825.Pos += 2
    local X = v826.X
    tryRealloc(v825, 2)
    local Buf_2 = v825.Buf
    local Pos_2 = v825.Pos
    buffer.writei16(Buf_2, Pos_2, X)
    v825.Pos += 2
end

local function des_7(v827) -- line 1886
    local new = Vector2int16.new
    v827.Pos -= 2
    local Buf = v827.Buf
    local Pos = v827.Pos
    local v828 = buffer.readi16(Buf, Pos)
    v827.Pos -= 2
    local Buf_2 = v827.Buf
    local Pos_2 = v827.Pos
    return new(v828, (buffer.readi16(Buf_2, Pos_2)))
end

v824.des = des_7

function v214.Vector2int16() -- line 1890 | captures: v824
    return v824
end

local v829 = {}

function v829.ser(v830, v831) -- line 1895 | captures: tryRealloc
    local Z = v831.Z
    tryRealloc(v830, 2)
    local Buf = v830.Buf
    local Pos = v830.Pos
    buffer.writei16(Buf, Pos, Z)
    v830.Pos += 2
    local Y = v831.Y
    tryRealloc(v830, 2)
    local Buf_2 = v830.Buf
    local Pos_2 = v830.Pos
    buffer.writei16(Buf_2, Pos_2, Y)
    v830.Pos += 2
    local X = v831.X
    tryRealloc(v830, 2)
    local Buf_3 = v830.Buf
    local Pos_3 = v830.Pos
    buffer.writei16(Buf_3, Pos_3, X)
    v830.Pos += 2
end

local function des_8(v832) -- line 1901
    local new = Vector3int16.new
    v832.Pos -= 2
    local Buf = v832.Buf
    local Pos = v832.Pos
    local v833 = buffer.readi16(Buf, Pos)
    v832.Pos -= 2
    local Buf_2 = v832.Buf
    local Pos_2 = v832.Pos
    local v834 = buffer.readi16(Buf_2, Pos_2)
    v832.Pos -= 2
    local Buf_3 = v832.Buf
    local Pos_3 = v832.Pos
    return new(v833, v834, (buffer.readi16(Buf_3, Pos_3)))
end

v829.des = des_8

function v214.Vector3int16() -- line 1905 | captures: v829
    return v829
end

return v214
