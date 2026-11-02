-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local bxor = bit32.bxor
local rrotate = bit32.rrotate
local copy = buffer.copy
local create = buffer.create
local fromstring = buffer.fromstring
local len = buffer.len
local readu8 = buffer.readu8
local readu16 = buffer.readu16
local readu32 = buffer.readu32
local tostring = buffer.tostring
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu16 = buffer.writeu16
local writeu32 = buffer.writeu32
local floor = math.floor
local sub = string.sub
local v1 = create(131072)
local v2 = create(65536)
local v3 = create(65536)
local v4 = create(65536)
local v5 = create(65536)
local v6 = create(65536)

local function keySchedule(v7, v8, v9, v10) -- line 29 | captures: bxor, rrotate, copy, readu16, readu32, writestring, writeu32, floor, v1
    if v10 then
        copy(v9, 0, v7, 0, v8)
    else
        writestring(v9, 0, v7, v8)
    end
    local v11 = v8 - 4
    local v12 = readu32(v9, v11)
    local v13 = rrotate(v12, 8)
    if v8 == 32 then
        local v14 = 0.5
        for v15 = 32, 192, 32 do
            v14 = v14 * 2 % 229
            local v16 = v15 - 32
            local v17 = readu32(v9, v16)
            local v18 = v13 / 65536
            local v19 = floor(v18) * 2
            local v20 = readu16(v1, v19) * 65536
            local v21 = v13 % 65536 * 2
            local v22 = v20 + readu16(v1, v21)
            local v23 = bxor(v17, v22, v14)
            writeu32(v9, v15, v23)
            local v24 = v15 - 28
            local v25 = readu32(v9, v24)
            local v26 = bxor(v25, v23)
            local v27 = v15 + 4
            writeu32(v9, v27, v26)
            local v28 = v15 - 24
            local v29 = readu32(v9, v28)
            local v30 = bxor(v29, v26)
            local v31 = v15 + 8
            writeu32(v9, v31, v30)
            local v32 = v15 - 20
            local v33 = readu32(v9, v32)
            local v34 = bxor(v33, v30)
            local v35 = v15 + 12
            writeu32(v9, v35, v34)
            local v36 = v15 - 16
            local v37 = readu32(v9, v36)
            local v38 = v34 / 65536
            local v39 = floor(v38) * 2
            local v40 = readu16(v1, v39) * 65536
            local v41 = v34 % 65536 * 2
            local v42 = v40 + readu16(v1, v41)
            local v43 = bxor(v37, v42)
            local v44 = v15 + 16
            writeu32(v9, v44, v43)
            local v45 = v15 - 12
            local v46 = readu32(v9, v45)
            local v47 = bxor(v46, v43)
            local v48 = v15 + 20
            writeu32(v9, v48, v47)
            local v49 = v15 - 8
            local v50 = readu32(v9, v49)
            local v51 = bxor(v50, v47)
            local v52 = v15 + 24
            writeu32(v9, v52, v51)
            local v53 = v15 - 4
            local v54 = readu32(v9, v53)
            local v55 = bxor(v54, v51)
            local v56 = v15 + 28
            writeu32(v9, v56, v55)
            v13 = rrotate(v55, 8)
        end
        local v57 = readu32(v9, 192)
        local v58 = v13 / 65536
        local v59 = floor(v58) * 2
        local v60 = readu16(v1, v59) * 65536
        local v61 = v13 % 65536 * 2
        local v62 = v60 + readu16(v1, v61)
        local v63 = bxor(v57, v62, 64)
        writeu32(v9, 224, v63)
        local v64 = readu32(v9, 196)
        local v65 = bxor(v64, v63)
        writeu32(v9, 228, v65)
        local v66 = readu32(v9, 200)
        local v67 = bxor(v66, v65)
        writeu32(v9, 232, v67)
        local v68 = readu32(v9, 204)
        local v69 = bxor(v68, v67)
        writeu32(v9, 236, v69)
    elseif v8 == 24 then
        local v70 = 0.5
        for v71 = 24, 168, 24 do
            v70 = v70 * 2 % 229
            local v72 = v71 - 24
            local v73 = readu32(v9, v72)
            local v74 = v13 / 65536
            local v75 = floor(v74) * 2
            local v76 = readu16(v1, v75) * 65536
            local v77 = v13 % 65536 * 2
            local v78 = v76 + readu16(v1, v77)
            local v79 = bxor(v73, v78, v70)
            writeu32(v9, v71, v79)
            local v80 = v71 - 20
            local v81 = readu32(v9, v80)
            local v82 = bxor(v81, v79)
            local v83 = v71 + 4
            writeu32(v9, v83, v82)
            local v84 = v71 - 16
            local v85 = readu32(v9, v84)
            local v86 = bxor(v85, v82)
            local v87 = v71 + 8
            writeu32(v9, v87, v86)
            local v88 = v71 - 12
            local v89 = readu32(v9, v88)
            local v90 = bxor(v89, v86)
            local v91 = v71 + 12
            writeu32(v9, v91, v90)
            local v92 = v71 - 8
            local v93 = readu32(v9, v92)
            local v94 = bxor(v93, v90)
            local v95 = v71 + 16
            writeu32(v9, v95, v94)
            local v96 = v71 - 4
            local v97 = readu32(v9, v96)
            local v98 = bxor(v97, v94)
            local v99 = v71 + 20
            writeu32(v9, v99, v98)
            v13 = rrotate(v98, 8)
        end
        local v100 = readu32(v9, 168)
        local v101 = v13 / 65536
        local v102 = floor(v101) * 2
        local v103 = readu16(v1, v102) * 65536
        local v104 = v13 % 65536 * 2
        local v105 = v103 + readu16(v1, v104)
        local v106 = bxor(v100, v105, 128)
        writeu32(v9, 192, v106)
        local v107 = readu32(v9, 172)
        local v108 = bxor(v107, v106)
        writeu32(v9, 196, v108)
        local v109 = readu32(v9, 176)
        local v110 = bxor(v109, v108)
        writeu32(v9, 200, v110)
        local v111 = readu32(v9, 180)
        local v112 = bxor(v111, v110)
        writeu32(v9, 204, v112)
    else
        local v113 = 0.5
        for v114 = 16, 144, 16 do
            v113 = v113 * 2 % 229
            local v115 = v114 - 16
            local v116 = readu32(v9, v115)
            local v117 = v13 / 65536
            local v118 = floor(v117) * 2
            local v119 = readu16(v1, v118) * 65536
            local v120 = v13 % 65536 * 2
            local v121 = v119 + readu16(v1, v120)
            local v122 = bxor(v116, v121, v113)
            writeu32(v9, v114, v122)
            local v123 = v114 - 12
            local v124 = readu32(v9, v123)
            local v125 = bxor(v124, v122)
            local v126 = v114 + 4
            writeu32(v9, v126, v125)
            local v127 = v114 - 8
            local v128 = readu32(v9, v127)
            local v129 = bxor(v128, v125)
            local v130 = v114 + 8
            writeu32(v9, v130, v129)
            local v131 = v114 - 4
            local v132 = readu32(v9, v131)
            local v133 = bxor(v132, v129)
            local v134 = v114 + 12
            writeu32(v9, v134, v133)
            v13 = rrotate(v133, 8)
        end
        local v135 = readu32(v9, 144)
        local v136 = v13 / 65536
        local v137 = floor(v136) * 2
        local v138 = readu16(v1, v137) * 65536
        local v139 = v13 % 65536 * 2
        local v140 = v138 + readu16(v1, v139)
        local v141 = bxor(v135, v140, 54)
        writeu32(v9, 160, v141)
        local v142 = readu32(v9, 148)
        local v143 = bxor(v142, v141)
        writeu32(v9, 164, v143)
        local v144 = readu32(v9, 152)
        local v145 = bxor(v144, v143)
        writeu32(v9, 168, v145)
        local v146 = readu32(v9, 156)
        local v147 = bxor(v146, v145)
        writeu32(v9, 172, v147)
    end
    return v9
end

local function encryptBlock(v148, v149, v150, v151, v152, v153) -- line 165 | captures: bxor, readu8, readu16, readu32, writeu32, v1, v2, v3
    local v154 = readu8(v150, v151)
    local v155 = readu8(v148, 0)
    local v156 = bxor(v154, v155)
    local v157 = v151 + 1
    local v158 = readu8(v150, v157)
    local v159 = readu8(v148, 1)
    v155 = bxor(v158, v159)
    v159 = v151 + 2
    local v160 = readu8(v150, v159)
    local v161 = readu8(v148, 2)
    v157 = bxor(v160, v161)
    v161 = v151 + 3
    local v162 = readu8(v150, v161)
    local v163 = readu8(v148, 3)
    v159 = bxor(v162, v163)
    v163 = v151 + 4
    local v164 = readu8(v150, v163)
    local v165 = readu8(v148, 4)
    v161 = bxor(v164, v165)
    v165 = v151 + 5
    local v166 = readu8(v150, v165)
    local v167 = readu8(v148, 5)
    v163 = bxor(v166, v167)
    v167 = v151 + 6
    local v168 = readu8(v150, v167)
    local v169 = readu8(v148, 6)
    v165 = bxor(v168, v169)
    v169 = v151 + 7
    local v170 = readu8(v150, v169)
    local v171 = readu8(v148, 7)
    v167 = bxor(v170, v171)
    v171 = v151 + 8
    local v172 = readu8(v150, v171)
    local v173 = readu8(v148, 8)
    v169 = bxor(v172, v173)
    v173 = v151 + 9
    local v174 = readu8(v150, v173)
    local v175 = readu8(v148, 9)
    v171 = bxor(v174, v175)
    v175 = v151 + 10
    local v176 = readu8(v150, v175)
    local v177 = readu8(v148, 10)
    v173 = bxor(v176, v177)
    v177 = v151 + 11
    local v178 = readu8(v150, v177)
    local v179 = readu8(v148, 11)
    v175 = bxor(v178, v179)
    v179 = v151 + 12
    local v180 = readu8(v150, v179)
    local v181 = readu8(v148, 12)
    v177 = bxor(v180, v181)
    v181 = v151 + 13
    local v182 = readu8(v150, v181)
    local v183 = readu8(v148, 13)
    v179 = bxor(v182, v183)
    v183 = v151 + 14
    local v184 = readu8(v150, v183)
    local v185 = readu8(v148, 14)
    v181 = bxor(v184, v185)
    v185 = v151 + 15
    local v186 = readu8(v150, v185)
    local v187 = readu8(v148, 15)
    v183 = bxor(v186, v187)
    local v188, v189, v190, v191, v192, v193, v194, v195, v196, v197, v198, v199
    v181, v183, v185, v187, v188, v190, v189, v191, v192, v194, v193, v195, v196, v198, v197, v199 = v156 * 256 + v163, v163 * 256 + v173, v173 * 256 + v183, v183 * 256 + v156, v161 * 256 + v171, v171 * 256 + v181, v181 * 256 + v159, v159 * 256 + v161, v169 * 256 + v179, v179 * 256 + v157, v157 * 256 + v167, v167 * 256 + v169, v177 * 256 + v155, v155 * 256 + v165, v165 * 256 + v175, v175 * 256 + v177
    local v200, v201, v202, v203
    for v204 = 16, v149, 16 do
        v200 = readu8(v2, v181)
        v203 = readu8(v3, v185)
        v202 = readu8(v148, v204)
        v200 = bxor(v200, v203, v202)
        v203 = readu8(v2, v183)
        local v205 = readu8(v3, v187)
        v201 = v204 + 1
        v202 = readu8(v148, v201)
        v203 = bxor(v203, v205, v202)
        v205 = readu8(v2, v185)
        local v206 = readu8(v3, v181)
        v201 = v204 + 2
        v202 = readu8(v148, v201)
        v205 = bxor(v205, v206, v202)
        v206 = readu8(v2, v187)
        local v207 = readu8(v3, v183)
        v201 = v204 + 3
        v202 = readu8(v148, v201)
        v206 = bxor(v206, v207, v202)
        v207 = readu8(v2, v188)
        local v208 = readu8(v3, v189)
        v201 = v204 + 4
        v202 = readu8(v148, v201)
        v207 = bxor(v207, v208, v202)
        v208 = readu8(v2, v190)
        local v209 = readu8(v3, v191)
        v201 = v204 + 5
        v202 = readu8(v148, v201)
        v208 = bxor(v208, v209, v202)
        v209 = readu8(v2, v189)
        local v210 = readu8(v3, v188)
        v201 = v204 + 6
        v202 = readu8(v148, v201)
        v209 = bxor(v209, v210, v202)
        v210 = readu8(v2, v191)
        local v211 = readu8(v3, v190)
        v201 = v204 + 7
        v202 = readu8(v148, v201)
        v210 = bxor(v210, v211, v202)
        v211 = readu8(v2, v192)
        local v212 = readu8(v3, v193)
        v201 = v204 + 8
        v202 = readu8(v148, v201)
        v211 = bxor(v211, v212, v202)
        v212 = readu8(v2, v194)
        local v213 = readu8(v3, v195)
        v201 = v204 + 9
        v202 = readu8(v148, v201)
        v212 = bxor(v212, v213, v202)
        v213 = readu8(v2, v193)
        local v214 = readu8(v3, v192)
        v201 = v204 + 10
        v202 = readu8(v148, v201)
        v213 = bxor(v213, v214, v202)
        v214 = readu8(v2, v195)
        local v215 = readu8(v3, v194)
        v201 = v204 + 11
        v202 = readu8(v148, v201)
        v214 = bxor(v214, v215, v202)
        v215 = readu8(v2, v196)
        local v216 = readu8(v3, v197)
        v201 = v204 + 12
        v202 = readu8(v148, v201)
        v215 = bxor(v215, v216, v202)
        v216 = readu8(v2, v198)
        local v217 = readu8(v3, v199)
        v201 = v204 + 13
        v202 = readu8(v148, v201)
        v216 = bxor(v216, v217, v202)
        v217 = readu8(v2, v197)
        local v218 = readu8(v3, v196)
        v201 = v204 + 14
        v202 = readu8(v148, v201)
        v217 = bxor(v217, v218, v202)
        v218 = readu8(v2, v199)
        local v219 = readu8(v3, v198)
        v201 = v204 + 15
        v202 = readu8(v148, v201)
        v218 = bxor(v218, v219, v202)
        v181, v183, v185, v187, v188, v190, v189, v191, v192, v194, v193, v195, v196, v198, v197, v199 = v200 * 256 + v208, v208 * 256 + v213, v213 * 256 + v218, v218 * 256 + v200, v207 * 256 + v212, v212 * 256 + v217, v217 * 256 + v206, v206 * 256 + v207, v211 * 256 + v216, v216 * 256 + v205, v205 * 256 + v210, v210 * 256 + v211, v215 * 256 + v203, v203 * 256 + v209, v209 * 256 + v214, v214 * 256 + v215
    end
    local v220 = readu8(v2, v199)
    local v221 = readu8(v3, v198)
    v201 = v149 + 31
    v202 = readu8(v148, v201)
    local v222 = bxor(v220, v221, v202) * 512
    v200 = readu8(v2, v193)
    v203 = readu8(v3, v192)
    local v223 = v149 + 26
    local v224 = readu8(v148, v223)
    v202 = v222 + bxor(v200, v203, v224) * 2
    local v225 = readu16(v1, v202) * 65536
    local v226 = readu8(v2, v190)
    local v227 = readu8(v3, v191)
    local v228 = v149 + 21
    local v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v181)
    v227 = readu8(v3, v185)
    v223 = v149 + 16
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    local v230 = v225 + readu16(v1, v202)
    v224 = v149 + 32
    v228 = readu32(v148, v224)
    v229 = bxor(v230, v228)
    writeu32(v152, v153, v229)
    v226 = readu8(v2, v187)
    v227 = readu8(v3, v183)
    v228 = v149 + 19
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v197)
    v227 = readu8(v3, v196)
    v223 = v149 + 30
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v225 = readu16(v1, v202) * 65536
    v226 = readu8(v2, v194)
    v227 = readu8(v3, v195)
    v228 = v149 + 25
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v188)
    v227 = readu8(v3, v189)
    v223 = v149 + 20
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v230 = v225 + readu16(v1, v202)
    v202 = v153 + 4
    v224 = v149 + 36
    v228 = readu32(v148, v224)
    v229 = bxor(v230, v228)
    writeu32(v152, v202, v229)
    v226 = readu8(v2, v191)
    v227 = readu8(v3, v190)
    v228 = v149 + 23
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v185)
    v227 = readu8(v3, v181)
    v223 = v149 + 18
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v225 = readu16(v1, v202) * 65536
    v226 = readu8(v2, v198)
    v227 = readu8(v3, v199)
    v228 = v149 + 29
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v192)
    v227 = readu8(v3, v193)
    v223 = v149 + 24
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v230 = v225 + readu16(v1, v202)
    v202 = v153 + 8
    v224 = v149 + 40
    v228 = readu32(v148, v224)
    v229 = bxor(v230, v228)
    writeu32(v152, v202, v229)
    v226 = readu8(v2, v195)
    v227 = readu8(v3, v194)
    v228 = v149 + 27
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v189)
    v227 = readu8(v3, v188)
    v223 = v149 + 22
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v225 = readu16(v1, v202) * 65536
    v226 = readu8(v2, v183)
    v227 = readu8(v3, v187)
    v228 = v149 + 17
    v229 = readu8(v148, v228)
    v222 = bxor(v226, v227, v229) * 512
    v226 = readu8(v2, v196)
    v227 = readu8(v3, v197)
    v223 = v149 + 28
    v224 = readu8(v148, v223)
    v202 = v222 + bxor(v226, v227, v224) * 2
    v230 = v225 + readu16(v1, v202)
    v202 = v153 + 12
    v224 = v149 + 44
    v228 = readu32(v148, v224)
    v229 = bxor(v230, v228)
    writeu32(v152, v202, v229)
end

local function decryptBlock(v231, v232, v233, v234, v235, v236) -- line 336 | captures: bxor, readu8, writeu32, v4, v5, v6
    local v237 = readu8(v233, v234) * 256
    local v238 = v232 + 32
    local v239 = v237 + readu8(v231, v238)
    local v240 = readu8(v4, v239)
    v238 = v232 + 16
    local v241 = readu8(v231, v238)
    local v242 = bxor(v240, v241)
    v238 = v234 + 13
    v239 = readu8(v233, v238) * 256
    local v243 = v232 + 45
    v238 = v239 + readu8(v231, v243)
    v241 = readu8(v4, v238)
    v243 = v232 + 17
    local v244 = readu8(v231, v243)
    local v245 = bxor(v241, v244)
    local v246 = v234 + 10
    local v247 = readu8(v233, v246) * 256
    local v248 = v232 + 42
    v246 = v247 + readu8(v231, v248)
    v238 = readu8(v4, v246)
    v248 = v232 + 18
    v243 = readu8(v231, v248)
    v244 = bxor(v238, v243)
    local v249 = v234 + 7
    local v250 = readu8(v233, v249) * 256
    local v251 = v232 + 39
    v249 = v250 + readu8(v231, v251)
    v246 = readu8(v4, v249)
    local v252 = v232 + 19
    v249 = readu8(v231, v252)
    v246 = bxor(v246, v249)
    v248 = v234 + 4
    local v253 = readu8(v233, v248) * 256
    local v254 = v232 + 36
    v248 = v253 + readu8(v231, v254)
    v243 = readu8(v4, v248)
    v251 = v232 + 20
    v248 = readu8(v231, v251)
    v243 = bxor(v243, v248)
    v252 = v234 + 1
    local v255 = readu8(v233, v252) * 256
    local v256 = v232 + 33
    v252 = v255 + readu8(v231, v256)
    v249 = readu8(v4, v252)
    v254 = v232 + 21
    v252 = readu8(v231, v254)
    v249 = bxor(v249, v252)
    v251 = v234 + 14
    local v257 = readu8(v233, v251) * 256
    local v258 = v232 + 46
    v251 = v257 + readu8(v231, v258)
    v248 = readu8(v4, v251)
    v256 = v232 + 22
    v251 = readu8(v231, v256)
    v248 = bxor(v248, v251)
    v254 = v234 + 11
    local v259 = readu8(v233, v254) * 256
    local v260 = v232 + 43
    v254 = v259 + readu8(v231, v260)
    v252 = readu8(v4, v254)
    v258 = v232 + 23
    v254 = readu8(v231, v258)
    v252 = bxor(v252, v254)
    v256 = v234 + 8
    local v261 = readu8(v233, v256) * 256
    local v262 = v232 + 40
    v256 = v261 + readu8(v231, v262)
    v251 = readu8(v4, v256)
    v260 = v232 + 24
    v256 = readu8(v231, v260)
    v251 = bxor(v251, v256)
    v258 = v234 + 5
    local v263 = readu8(v233, v258) * 256
    local v264 = v232 + 37
    v258 = v263 + readu8(v231, v264)
    v254 = readu8(v4, v258)
    v262 = v232 + 25
    v258 = readu8(v231, v262)
    v254 = bxor(v254, v258)
    v260 = v234 + 2
    local v265 = readu8(v233, v260) * 256
    local v266 = v232 + 34
    v260 = v265 + readu8(v231, v266)
    v256 = readu8(v4, v260)
    v264 = v232 + 26
    v260 = readu8(v231, v264)
    v256 = bxor(v256, v260)
    v262 = v234 + 15
    local v267 = readu8(v233, v262) * 256
    local v268 = v232 + 47
    v262 = v267 + readu8(v231, v268)
    v258 = readu8(v4, v262)
    v266 = v232 + 27
    v262 = readu8(v231, v266)
    v258 = bxor(v258, v262)
    v264 = v234 + 12
    local v269 = readu8(v233, v264) * 256
    local v270 = v232 + 44
    v264 = v269 + readu8(v231, v270)
    v260 = readu8(v4, v264)
    v268 = v232 + 28
    v264 = readu8(v231, v268)
    v260 = bxor(v260, v264)
    v266 = v234 + 9
    local v271 = readu8(v233, v266) * 256
    local v272 = v232 + 41
    v266 = v271 + readu8(v231, v272)
    v262 = readu8(v4, v266)
    v270 = v232 + 29
    v266 = readu8(v231, v270)
    v262 = bxor(v262, v266)
    v268 = v234 + 6
    local v273 = readu8(v233, v268) * 256
    local v274 = v232 + 38
    v268 = v273 + readu8(v231, v274)
    v264 = readu8(v4, v268)
    v272 = v232 + 30
    v268 = readu8(v231, v272)
    v264 = bxor(v264, v268)
    v270 = v234 + 3
    local v275 = readu8(v233, v270) * 256
    local v276 = v232 + 35
    v270 = v275 + readu8(v231, v276)
    v266 = readu8(v4, v270)
    v274 = v232 + 31
    v270 = readu8(v231, v274)
    v266 = bxor(v266, v270)
    local v277, v278, v279, v280, v281, v282
    v258, v260, v262, v264, v266, v268, v270, v272, v274, v276, v279, v282, v281, v277, v280, v278 = v242 * 256 + v245, v245 * 256 + v244, v244 * 256 + v246, v246 * 256 + v242, v243 * 256 + v249, v249 * 256 + v248, v248 * 256 + v252, v252 * 256 + v243, v251 * 256 + v254, v254 * 256 + v256, v256 * 256 + v258, v258 * 256 + v251, v260 * 256 + v262, v262 * 256 + v264, v264 * 256 + v266, v266 * 256 + v260
    local v283, v284
    for v285 = v232, 16, -16 do
        v284 = readu8(v5, v258) * 256 + readu8(v6, v262)
        v283 = readu8(v4, v284)
        v284 = readu8(v231, v285)
        v283 = bxor(v283, v284)
        v284 = readu8(v5, v277) * 256 + readu8(v6, v278)
        local v286 = readu8(v4, v284)
        local v287 = v285 + 1
        v284 = readu8(v231, v287)
        v286 = bxor(v286, v284)
        v284 = readu8(v5, v279) * 256 + readu8(v6, v274)
        local v288 = readu8(v4, v284)
        v287 = v285 + 2
        v284 = readu8(v231, v287)
        v288 = bxor(v288, v284)
        v284 = readu8(v5, v272) * 256 + readu8(v6, v268)
        local v289 = readu8(v4, v284)
        v287 = v285 + 3
        v284 = readu8(v231, v287)
        v289 = bxor(v289, v284)
        v284 = readu8(v5, v266) * 256 + readu8(v6, v270)
        local v290 = readu8(v4, v284)
        v287 = v285 + 4
        v284 = readu8(v231, v287)
        v290 = bxor(v290, v284)
        v284 = readu8(v5, v260) * 256 + readu8(v6, v264)
        local v291 = readu8(v4, v284)
        v287 = v285 + 5
        v284 = readu8(v231, v287)
        v291 = bxor(v291, v284)
        v284 = readu8(v5, v280) * 256 + readu8(v6, v281)
        local v292 = readu8(v4, v284)
        v287 = v285 + 6
        v284 = readu8(v231, v287)
        v292 = bxor(v292, v284)
        v284 = readu8(v5, v282) * 256 + readu8(v6, v276)
        local v293 = readu8(v4, v284)
        v287 = v285 + 7
        v284 = readu8(v231, v287)
        v293 = bxor(v293, v284)
        v284 = readu8(v5, v274) * 256 + readu8(v6, v279)
        local v294 = readu8(v4, v284)
        v287 = v285 + 8
        v284 = readu8(v231, v287)
        v294 = bxor(v294, v284)
        v284 = readu8(v5, v268) * 256 + readu8(v6, v272)
        local v295 = readu8(v4, v284)
        v287 = v285 + 9
        v284 = readu8(v231, v287)
        v295 = bxor(v295, v284)
        v284 = readu8(v5, v262) * 256 + readu8(v6, v258)
        local v296 = readu8(v4, v284)
        v287 = v285 + 10
        v284 = readu8(v231, v287)
        v296 = bxor(v296, v284)
        v284 = readu8(v5, v278) * 256 + readu8(v6, v277)
        local v297 = readu8(v4, v284)
        v287 = v285 + 11
        v284 = readu8(v231, v287)
        v297 = bxor(v297, v284)
        v284 = readu8(v5, v281) * 256 + readu8(v6, v280)
        local v298 = readu8(v4, v284)
        v287 = v285 + 12
        v284 = readu8(v231, v287)
        v298 = bxor(v298, v284)
        v284 = readu8(v5, v276) * 256 + readu8(v6, v282)
        local v299 = readu8(v4, v284)
        v287 = v285 + 13
        v284 = readu8(v231, v287)
        v299 = bxor(v299, v284)
        v284 = readu8(v5, v270) * 256 + readu8(v6, v266)
        local v300 = readu8(v4, v284)
        v287 = v285 + 14
        v284 = readu8(v231, v287)
        v300 = bxor(v300, v284)
        v284 = readu8(v5, v264) * 256 + readu8(v6, v260)
        local v301 = readu8(v4, v284)
        v287 = v285 + 15
        v284 = readu8(v231, v287)
        v301 = bxor(v301, v284)
        v258, v260, v262, v264, v266, v268, v270, v272, v274, v276, v279, v282, v281, v277, v280, v278 = v283 * 256 + v286, v286 * 256 + v288, v288 * 256 + v289, v289 * 256 + v283, v290 * 256 + v291, v291 * 256 + v292, v292 * 256 + v293, v293 * 256 + v290, v294 * 256 + v295, v295 * 256 + v296, v296 * 256 + v297, v297 * 256 + v294, v298 * 256 + v299, v299 * 256 + v300, v300 * 256 + v301, v301 * 256 + v298
    end
    v283 = readu8(v5, v272) * 256 + readu8(v6, v268)
    local v302 = readu8(v4, v283)
    v284 = readu8(v231, 3)
    local v303 = bxor(v302, v284) * 16777216
    local v304 = readu8(v5, v279) * 256 + readu8(v6, v274)
    local v305 = readu8(v4, v304)
    local v306 = readu8(v231, 2)
    v284 = v303 + bxor(v305, v306) * 65536
    local v307 = readu8(v5, v277) * 256 + readu8(v6, v278)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 1)
    local v308 = v284 + bxor(v304, v306) * 256
    v307 = readu8(v5, v258) * 256 + readu8(v6, v262)
    v304 = readu8(v4, v307)
    local v309 = readu8(v231, 0)
    v306 = v308 + bxor(v304, v309)
    writeu32(v235, v236, v306)
    v307 = readu8(v5, v282) * 256 + readu8(v6, v276)
    v304 = readu8(v4, v307)
    v307 = readu8(v231, 7)
    v303 = bxor(v304, v307) * 16777216
    v307 = readu8(v5, v280) * 256 + readu8(v6, v281)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 6)
    v284 = v303 + bxor(v304, v306) * 65536
    v307 = readu8(v5, v260) * 256 + readu8(v6, v264)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 5)
    v308 = v284 + bxor(v304, v306) * 256
    v307 = readu8(v5, v266) * 256 + readu8(v6, v270)
    v304 = readu8(v4, v307)
    v307 = v236 + 4
    v309 = readu8(v231, 4)
    v306 = v308 + bxor(v304, v309)
    writeu32(v235, v307, v306)
    v307 = readu8(v5, v278) * 256 + readu8(v6, v277)
    v304 = readu8(v4, v307)
    v307 = readu8(v231, 11)
    v303 = bxor(v304, v307) * 16777216
    v307 = readu8(v5, v262) * 256 + readu8(v6, v258)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 10)
    v284 = v303 + bxor(v304, v306) * 65536
    v307 = readu8(v5, v268) * 256 + readu8(v6, v272)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 9)
    v308 = v284 + bxor(v304, v306) * 256
    v307 = readu8(v5, v274) * 256 + readu8(v6, v279)
    v304 = readu8(v4, v307)
    v307 = v236 + 8
    v309 = readu8(v231, 8)
    v306 = v308 + bxor(v304, v309)
    writeu32(v235, v307, v306)
    v307 = readu8(v5, v264) * 256 + readu8(v6, v260)
    v304 = readu8(v4, v307)
    v307 = readu8(v231, 15)
    v303 = bxor(v304, v307) * 16777216
    v307 = readu8(v5, v270) * 256 + readu8(v6, v266)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 14)
    v284 = v303 + bxor(v304, v306) * 65536
    v307 = readu8(v5, v276) * 256 + readu8(v6, v282)
    v304 = readu8(v4, v307)
    v306 = readu8(v231, 13)
    v308 = v284 + bxor(v304, v306) * 256
    v307 = readu8(v5, v281) * 256 + readu8(v6, v280)
    v304 = readu8(v4, v307)
    v307 = v236 + 12
    v309 = readu8(v231, 12)
    v306 = v308 + bxor(v304, v309)
    writeu32(v235, v307, v306)
end

local v310 = create(256)
local v311 = create(256)
local v312 = create(256)
local v313 = create(256)
local v314 = create(256)

local function gfmul(v315, v316) -- line 526 | captures: bxor, floor
    local v317 = v315
    local v318 = v316
    local v319 = 0
    for v320 = 0, 7 do
        if v318 % 2 == 1 then
            v319 = bxor(v319, v317)
        end
        if v317 < 128 then
            v317 = v317 * 2 % 256
        else
            local v321 = v317 * 2 % 256
            v317 = bxor(v321, 27)
        end
        local v322 = v318 / 2
        v318 = floor(v322)
    end
    return v319
end

writeu8(v310, 0, 99)
local v323 = 1
local v324 = 1
for v325 = 1, 255 do
    local v326 = if v323 >= 128 then 27 else 0
    v323 = bxor(v323, v323 * 2, v326) % 256
    local v327 = bxor(v324, v324 * 2)
    local v328 = bxor(v327, v327 * 4)
    v324 = bxor(v328, v328 * 16) % 256
    if v324 >= 128 then
        v324 = bxor(v324, 9)
    end
    local v329 = bxor(v324, v324 % 128 * 2 + v324 / 128, v324 % 64 * 4 + v324 / 64, v324 % 32 * 8 + v324 / 32, v324 % 16 * 16 + v324 / 16, 99)
    writeu8(v310, v323, v329)
    writeu8(v311, v329, v323)
    writeu8(v312, v323, (gfmul(3, v323)))
    writeu8(v313, v323, (gfmul(9, v323)))
    writeu8(v314, v323, (gfmul(11, v323)))
end
local v330 = 0
for v331 = 0, 255 do
    local v332 = readu8(v310, v331)
    local v333 = gfmul(14, v331)
    for v334 = 0, 255 do
        local v335 = readu8(v310, v334)
        writeu16(v1, v330 * 2, v332 * 256 + v335)
        writeu8(v4, v330, (readu8(v311, (bxor(v331, v334)))))
        writeu8(v2, v330, (bxor(gfmul(2, v332), (readu8(v312, v335)))))
        writeu8(v3, v330, (bxor(v332, v335)))
        writeu8(v5, v330, (bxor(v333, (readu8(v314, v334)))))
        writeu8(v6, v330, (bxor(gfmul(13, v331), (readu8(v313, v334)))))
        v330 += 1
    end
end

local function newidx(v336, v337) -- line 587
    return error((("%* cannot be assigned to"):format(v337)))
end

local function tostr() -- line 590
    return "AesCipher"
end

local Modes = require(script.Modes)
local Pads = require(script.Pads)

local function expandKey(v338, v339) -- line 595 | captures: create, len, keySchedule
    local v340 = typeof(v338) == "buffer"
    local v341
    if v340 then
        v341 = len(v338)
    else
        v341 = #v338
    end
    local v342
    if v341 == 32 then
        v342 = 240
    elseif v341 == 24 then
        v342 = 208
    elseif v341 == 16 then
        v342 = 176
    else
        v342 = error("Key must be either 16, 24 or 32 bytes long")
    end
    local v343 = v339 or create(v342)
    return (keySchedule(v338, v341, v343, v340))
end

local function fromKey(v344, v345, v346) -- line 618 | captures: create, fromstring, len, tostring, sub, encryptBlock, decryptBlock, newidx, tostr, Modes, Pads
    local v347 = len(v344)
    local v348 = v347
    local v349, v350
    local v351 = tostring(v344)
    local v352 = v351
    if v347 == 240 then
        v349 = 192
        v350 = sub(v351, 1, 32)
    elseif v347 == 208 then
        v349 = 160
        v350 = sub(v351, 1, 24)
    elseif v347 == 176 then
        v349 = 128
        v350 = sub(v351, 1, 16)
    else
        error("Round keys must be either 240, 208 or 128 bytes long")
    end
    local v353 = v344
    local v354 = v345
    local ECB
    if v345 then
        ECB = v345
    else
        ECB = Modes.ECB
        v354 = ECB
    end
    local FwdMode = ECB.FwdMode
    local InvMode = ECB.InvMode
    local v355 = ECB.SegmentSize or 16
    local v356 = v346
    local Pkcs7
    if v346 then
        Pkcs7 = v346
    else
        Pkcs7 = Pads.Pkcs7
        v356 = Pkcs7
    end
    local Pad = Pkcs7.Pad
    local Unpad = Pkcs7.Unpad
    local v357 = newproxy(true)
    local v358 = getmetatable(v357)

    local function encp(v359, v360, v361, v362) -- line 651 | captures: v349, v353, encryptBlock
        encryptBlock(v353, v349, v359, v360, v361, v362)
    end

    local function decp(v363, v364, v365, v366) -- line 654 | captures: v349, v353, decryptBlock
        decryptBlock(v353, v349, v363, v364, v365, v366)
    end

    local function enc(v367, v368, v369, ...) -- line 657 | captures: v349, v354, FwdMode, v356, v355, Pad, v357, encp, decp, create, fromstring
        local v370
        if typeof(v368) == "buffer" then
            v370 = v368
        elseif typeof(v368) == "string" then
            v370 = fromstring(v368)
        else
            v370 = error((("Unable to cast %* to buffer"):format((typeof(v368)))))
        end
        local v371 = if typeof(v369) == "buffer" then v369 else false
        if v367 == v357 then
            if v349 then
                local v372 = Pad(v370, v371, v355)
                if v356.Overwrite ~= false then
                    v370 = v372
                end
                FwdMode(encp, decp, v370, v372, v354, ...)
                return v372
            end
            error("AesCipher object's already destroyed")
            return create(0)
        end
        return v367:Encrypt(v370, v371, ...)
    end

    local function encb(v373, v374, v375, v376, v377) -- line 684 | captures: v349, v353, v357, encryptBlock
        if v373 == v357 then
            if v349 then
                encryptBlock(v353, v349, v374, v375, v376 or v374, v377 or v375)
            else
                error("AesCipher object's already destroyed")
            end
        else
            v373:EncryptBlock(v374, v375, v376, v377)
        end
    end

    local function dec(v378, v379, v380, ...) -- line 695 | captures: v349, v354, InvMode, v356, v355, Unpad, v357, encp, decp, create, fromstring, len
        local v381
        if typeof(v379) == "buffer" then
            v381 = v379
        elseif typeof(v379) == "string" then
            v381 = fromstring(v379)
        else
            v381 = error((("Unable to cast %* to buffer"):format((typeof(v379)))))
        end
        local v382 = if typeof(v380) == "buffer" then v380 else false
        if v378 == v357 then
            if v349 then
                local Overwrite = v356.Overwrite
                local v383
                if Overwrite == nil then
                    v383 = create(len(v381))
                elseif Overwrite then
                    v383 = v381
                else
                    v383 = v382 or create(len(v381))
                end
                InvMode(encp, decp, v381, v383, v354, ...)
                return (Unpad(v383, v382, v355))
            end
            error("AesCipher object's already destroyed")
            return create(0)
        end
        return v378:Decrypt(v381, v382, ...)
    end

    local function decb(v384, v385, v386, v387, v388) -- line 727 | captures: v349, v353, v357, decryptBlock
        if v384 == v357 then
            if v349 then
                decryptBlock(v353, v349, v385, v386, v387 or v385, v388 or v386)
            else
                error("AesCipher object's already destroyed")
            end
        else
            v384:DecryptBlock(v385, v386, v387, v388)
        end
    end

    local function destroy(v389) -- line 738 | captures: v348, v349, v350, v352, v353, v354, FwdMode, InvMode, v356, v357
        if v389 == v357 then
            if v349 then
                v352 = nil
                v353 = nil
                v349 = nil
                FwdMode = nil
                InvMode = nil
                v354 = nil
                v356 = nil
                v350 = nil
                v348 = nil
            else
                error("AesCipher object's already destroyed")
            end
        else
            v389:Destroy()
        end
    end

    function v358.__index(v390, v391) -- line 757 | captures: v348, v349, v350, v352, v354, v356, enc, encb, dec, decb, destroy
        if v391 == "Encrypt" then
            return enc
        end
        if v391 == "Decrypt" then
            return dec
        end
        if v391 == "EncryptBlock" then
            return encb
        end
        if v391 == "DecryptBlock" then
            return decb
        end
        if v391 == "Destroy" then
            return destroy
        end
        if v349 then
            if v391 == "Key" then
                return v350
            end
            if v391 == "RoundKeys" then
                return v352
            end
            if v391 == "Mode" then
                return v354
            end
            if v391 == "Padding" then
                return v356
            end
            if v391 == "Length" then
                return v348
            end
            return (error((("%* is not a valid member of AesCipher"):format(v391))))
        end
        return (error("AesCipher object's already destroyed"))
    end

    v358.__newindex = newidx
    v358.__tostring = tostr

    function v358.__len() -- line 795 | captures: v348
        return v348 or error("AesCipher object's destroyed")
    end

    v358.__metatable = "AesCipher object: Metatable's locked"
    return v357
end

local freeze = table.freeze
local v392 = {}

function v392.new(v393, v394, v395) -- line 806 | captures: expandKey, fromKey
    local v396 = expandKey(v393)
    return (fromKey(v396, v394, v395))
end

v392.expandKey = expandKey
v392.fromKey = fromKey
v392.modes = Modes
v392.pads = Pads
return freeze(v392)
