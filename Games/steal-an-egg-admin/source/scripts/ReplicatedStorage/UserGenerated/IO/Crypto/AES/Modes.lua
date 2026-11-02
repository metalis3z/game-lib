-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local bxor = bit32.bxor
local copy = buffer.copy
local create = buffer.create
local len = buffer.len
local readu8 = buffer.readu8
local readu32 = buffer.readu32
local writestring = buffer.writestring
local writeu8 = buffer.writeu8
local writeu32 = buffer.writeu32
local random = math.random
local pack = string.pack
local v1 = create(16)

local function addByteCtr(v2, v3, v4, v5, v6) -- line 19 | captures: readu8, writeu8
    if v6 then
        local v7 = readu8(v2, v4) + v3
        writeu8(v2, v4, v7)
        if not (v7 < 256) then
            local v8 = v4 + 1
            for v9 = v8, v5 do
                local v10 = readu8(v2, v9) + 1
                writeu8(v2, v9, v10)
                if v10 < 256 then
                    return
                end
            end
        end
    else
        local v11 = readu8(v2, v5) + v3
        writeu8(v2, v5, v11)
        if v11 >= 256 then
            local v12 = v5 - 1
            for v13 = v12, v4, -1 do
                local v14 = readu8(v2, v13) + 1
                writeu8(v2, v13, v14)
                if v14 < 256 then
                    break
                end
            end
        end
    end
end

local v15 = {}
local v16 = {}

function v16.FwdMode(v17, v18, v19, v20) -- line 54 | captures: len
    local v21 = len(v19) - 16
    local v22 = v21 % 16 == 0
    assert(v22, "Input length must be a multiple of 16 bytes")
    for v23 = 0, v21, 16 do
        v17(v19, v23, v20, v23)
    end
end

function v16.InvMode(v24, v25, v26, v27) -- line 64 | captures: len
    local v28 = len(v26) - 16
    local v29 = v28 % 16 == 0
    assert(v29, "Input length must be a multiple of 16 bytes")
    for v30 = 0, v28, 16 do
        v25(v26, v30, v27, v30)
    end
end

v15.ECB = v16
table.freeze(v15.ECB)
local v31 = {}

function v31.FwdMode(v32, v33, v34, v35, v36, v37) -- line 78 | captures: bxor, len, readu32, writeu32, v1
    local v38 = len(v34) - 16
    local v39 = v38 % 16 == 0
    assert(v39, "Input length must be a multiple of 16 bytes")
    local v40 = v37 or v1
    local v41 = len(v40) == 16
    assert(v41, "Initialization vector must be 16 bytes long")
    local v42 = readu32(v34, 0)
    local v43 = readu32(v40, 0)
    local v44 = bxor(v42, v43)
    writeu32(v35, 0, v44)
    local v45 = readu32(v34, 4)
    local v46 = readu32(v40, 4)
    local v47 = bxor(v45, v46)
    writeu32(v35, 4, v47)
    local v48 = readu32(v34, 8)
    local v49 = readu32(v40, 8)
    local v50 = bxor(v48, v49)
    writeu32(v35, 8, v50)
    local v51 = readu32(v34, 12)
    local v52 = readu32(v40, 12)
    local v53 = bxor(v51, v52)
    writeu32(v35, 12, v53)
    v32(v35, 0, v35, 0)
    for v54 = 16, v38, 16 do
        local v55 = readu32(v34, v54)
        local v56 = v54 - 16
        local v57 = readu32(v35, v56)
        local v58 = bxor(v55, v57)
        writeu32(v35, v54, v58)
        local v59 = v54 + 4
        local v60 = readu32(v34, v59)
        local v61 = v54 + 4
        local v62 = v54 - 12
        local v63 = readu32(v35, v62)
        local v64 = bxor(v60, v63)
        writeu32(v35, v61, v64)
        local v65 = v54 + 8
        local v66 = readu32(v34, v65)
        local v67 = v54 + 8
        local v68 = v54 - 8
        local v69 = readu32(v35, v68)
        local v70 = bxor(v66, v69)
        writeu32(v35, v67, v70)
        local v71 = v54 + 12
        local v72 = readu32(v34, v71)
        local v73 = v54 + 12
        local v74 = v54 - 4
        local v75 = readu32(v35, v74)
        local v76 = bxor(v72, v75)
        writeu32(v35, v73, v76)
        v32(v35, v54, v35, v54)
    end
end

function v31.InvMode(v77, v78, v79, v80, v81, v82) -- line 114 | captures: bxor, len, readu32, writeu32, v1
    local v83 = len(v79) - 16
    local v84 = v83 % 16 == 0
    assert(v84, "Input length must be a multiple of 16 bytes")
    local v85 = v82 or v1
    local v86 = len(v85) == 16
    assert(v86, "Initialization vector must be 16 bytes long")
    local v87 = readu32(v79, 0)
    local v88 = readu32(v79, 4)
    local v89 = readu32(v79, 8)
    local v90 = readu32(v79, 12)
    v78(v79, 0, v80, 0)
    local v91 = readu32(v80, 0)
    local v92 = readu32(v85, 0)
    local v93 = bxor(v91, v92)
    writeu32(v80, 0, v93)
    local v94 = readu32(v80, 4)
    local v95 = readu32(v85, 4)
    local v96 = bxor(v94, v95)
    writeu32(v80, 4, v96)
    local v97 = readu32(v80, 8)
    local v98 = readu32(v85, 8)
    local v99 = bxor(v97, v98)
    writeu32(v80, 8, v99)
    local v100 = readu32(v80, 12)
    local v101 = readu32(v85, 12)
    local v102 = bxor(v100, v101)
    writeu32(v80, 12, v102)
    for v103 = 16, v83, 16 do
        local v104 = readu32(v79, v103)
        local v105 = v103 + 4
        local v106 = readu32(v79, v105)
        local v107 = v103 + 8
        local v108 = readu32(v79, v107)
        local v109 = v103 + 12
        local v110 = readu32(v79, v109)
        v78(v79, v103, v80, v103)
        local v111 = readu32(v80, v103)
        local v112 = bxor(v111, v87)
        writeu32(v80, v103, v112)
        local v113 = v103 + 4
        local v114 = readu32(v80, v113)
        local v115 = v103 + 4
        local v116 = bxor(v114, v88)
        writeu32(v80, v115, v116)
        local v117 = v103 + 8
        local v118 = readu32(v80, v117)
        local v119 = v103 + 8
        local v120 = bxor(v118, v89)
        writeu32(v80, v119, v120)
        local v121 = v103 + 12
        local v122 = readu32(v80, v121)
        local v123 = v103 + 12
        local v124 = bxor(v122, v90)
        writeu32(v80, v123, v124)
        v88 = v106
        v87 = v104
        v89 = v108
        v90 = v110
    end
end

v15.CBC = v31
table.freeze(v15.CBC)
local v125 = {}

function v125.FwdMode(v126, v127, v128, v129, v130, v131) -- line 164 | captures: bxor, len, readu32, writeu32, v1
    local v132 = len(v128) - 16
    local v133 = v132 % 16 == 0
    assert(v133, "Input length must be a multiple of 16 bytes")
    local v134 = v131 or v1
    local v135 = len(v134) == 16
    assert(v135, "Initialization vector must be 16 bytes long")
    local v136 = readu32(v128, 0)
    local v137 = readu32(v128, 4)
    local v138 = readu32(v128, 8)
    local v139 = readu32(v128, 12)
    local v140 = readu32(v134, 0)
    local v141 = bxor(v136, v140)
    writeu32(v129, 0, v141)
    local v142 = readu32(v134, 4)
    local v143 = bxor(v137, v142)
    writeu32(v129, 4, v143)
    local v144 = readu32(v134, 8)
    local v145 = bxor(v138, v144)
    writeu32(v129, 8, v145)
    local v146 = readu32(v134, 12)
    local v147 = bxor(v139, v146)
    writeu32(v129, 12, v147)
    v126(v129, 0, v129, 0)
    for v148 = 16, v132, 16 do
        local v149 = readu32(v128, v148)
        local v150 = v148 + 4
        local v151 = readu32(v128, v150)
        local v152 = v148 + 8
        local v153 = readu32(v128, v152)
        local v154 = v148 + 12
        local v155 = readu32(v128, v154)
        local v156 = v148 - 16
        local v157 = readu32(v129, v156)
        local v158 = bxor(v136, v149, v157)
        writeu32(v129, v148, v158)
        local v159 = v148 + 4
        local v160 = v148 - 12
        local v161 = readu32(v129, v160)
        local v162 = bxor(v137, v151, v161)
        writeu32(v129, v159, v162)
        local v163 = v148 + 8
        local v164 = v148 - 8
        local v165 = readu32(v129, v164)
        local v166 = bxor(v138, v153, v165)
        writeu32(v129, v163, v166)
        local v167 = v148 + 12
        local v168 = v148 - 4
        local v169 = readu32(v129, v168)
        local v170 = bxor(v139, v155, v169)
        writeu32(v129, v167, v170)
        v126(v129, v148, v129, v148)
        v137 = v151
        v136 = v149
        v138 = v153
        v139 = v155
    end
end

function v125.InvMode(v171, v172, v173, v174, v175, v176) -- line 203 | captures: bxor, len, readu32, writeu32, v1
    local v177 = len(v173) - 16
    local v178 = v177 % 16 == 0
    assert(v178, "Input length must be a multiple of 16 bytes")
    local v179 = v176 or v1
    local v180 = len(v179) == 16
    assert(v180, "Initialization vector must be 16 bytes long")
    local v181 = readu32(v173, 0)
    local v182 = readu32(v173, 4)
    local v183 = readu32(v173, 8)
    local v184 = readu32(v173, 12)
    v172(v173, 0, v174, 0)
    local v185 = readu32(v174, 0)
    local v186 = readu32(v179, 0)
    local v187 = bxor(v185, v186)
    local v188 = readu32(v174, 4)
    local v189 = readu32(v179, 4)
    local v190 = bxor(v188, v189)
    local v191 = readu32(v174, 8)
    local v192 = readu32(v179, 8)
    local v193 = bxor(v191, v192)
    local v194 = readu32(v174, 12)
    local v195 = readu32(v179, 12)
    local v196 = bxor(v194, v195)
    writeu32(v174, 0, v187)
    writeu32(v174, 4, v190)
    writeu32(v174, 8, v193)
    writeu32(v174, 12, v196)
    local v197 = 0
    local v198 = 4
    local v199 = 8
    local v200 = 12
    for v201 = 16, v177, 16 do
        v197 += 16
        v198 += 16
        v199 += 16
        v200 += 16
        local v202 = readu32(v173, v197)
        local v203 = readu32(v173, v198)
        local v204 = readu32(v173, v199)
        local v205 = readu32(v173, v200)
        v172(v173, v201, v174, v201)
        local v206 = readu32(v174, v197)
        v187 = bxor(v181, v187, v206)
        local v207 = readu32(v174, v198)
        v190 = bxor(v182, v190, v207)
        local v208 = readu32(v174, v199)
        v193 = bxor(v183, v193, v208)
        local v209 = readu32(v174, v200)
        v196 = bxor(v184, v196, v209)
        writeu32(v174, v197, v187)
        writeu32(v174, v198, v190)
        writeu32(v174, v199, v193)
        writeu32(v174, v200, v196)
        v182 = v203
        v181 = v202
        v183 = v204
        v184 = v205
    end
end

v15.PCBC = v125
table.freeze(v15.PCBC)

local function cfbFwd(v210, v211, v212, v213, v214, v215) -- line 264 | captures: bxor, copy, create, len, readu8, writeu8, v1
    local SegmentSize = v214.SegmentSize
    local v216 = len(v212)
    local v217 = v216 % SegmentSize == 0
    assert(v217, "Input length must be a multiple of segment size")
    local v218 = v215 or v1
    local v219 = len(v218) == 16
    assert(v219, "Initialization vector must be 16 bytes long")
    local v220 = v214.CommonTemp or create(31)
    if v216 == SegmentSize then
        v210(v218, 0, v220, 0)
        local v221 = SegmentSize - 1
        for v222 = 0, v221 do
            local v223 = readu8(v212, v222)
            local v224 = readu8(v220, v222)
            local v225 = bxor(v223, v224)
            writeu8(v213, v222, v225)
        end
    else
        local v226 = v216 - SegmentSize
        local v227 = 16 - SegmentSize
        v210(v218, 0, v220, 0)
        local v228 = SegmentSize - 1
        for v229 = 0, v228 do
            local v230 = readu8(v212, v229)
            local v231 = readu8(v220, v229)
            local v232 = bxor(v230, v231)
            writeu8(v213, v229, v232)
        end
        copy(v220, 0, v218, SegmentSize, v227)
        copy(v220, v227, v213, 0, SegmentSize)
        local v233 = v226 - SegmentSize
        for v234 = SegmentSize, v233, SegmentSize do
            copy(v220, 16, v220, SegmentSize, v227)
            v210(v220, 0, v220, 0)
            local v235 = v234 + SegmentSize - 1
            local v236 = 0
            for v237 = v234, v235 do
                local v238 = readu8(v212, v237)
                local v239 = readu8(v220, v236)
                local v240 = bxor(v238, v239)
                writeu8(v213, v237, v240)
                v236 += 1
            end
            copy(v220, 0, v220, 16, v227)
            copy(v220, v227, v213, v234, SegmentSize)
        end
        v210(v220, 0, v220, 0)
        local v241 = v216 - 1
        local v242 = 0
        for v243 = v226, v241 do
            local v244 = readu8(v212, v243)
            local v245 = readu8(v220, v242)
            local v246 = bxor(v244, v245)
            writeu8(v213, v243, v246)
            v242 += 1
        end
    end
end

local function cfbInv(v247, v248, v249, v250, v251, v252) -- line 329 | captures: bxor, copy, create, len, readu8, writeu8, v1
    local v253 = len(v249)
    local SegmentSize = v251.SegmentSize
    local v254 = v253 % SegmentSize == 0
    assert(v254, "Input length must be a multiple of segment size")
    local v255 = v252 or v1
    local v256 = len(v255) == 16
    assert(v256, "Initialization vector must be 16 bytes long")
    local v257 = v251.CommonTemp or create(31)
    if v253 == SegmentSize then
        v247(v255, 0, v257, 0)
        local v258 = SegmentSize - 1
        for v259 = 0, v258 do
            local v260 = readu8(v249, v259)
            local v261 = readu8(v257, v259)
            local v262 = bxor(v260, v261)
            writeu8(v250, v259, v262)
        end
    else
        local v263 = v253 - SegmentSize
        local v264 = 16 - SegmentSize
        v247(v255, 0, v257, 0)
        local v265 = SegmentSize - 1
        for v266 = 0, v265 do
            local v267 = readu8(v249, v266)
            local v268 = readu8(v257, v266)
            local v269 = bxor(v267, v268)
            writeu8(v250, v266, v269)
        end
        copy(v257, 0, v255, SegmentSize, v264)
        copy(v257, v264, v249, 0, SegmentSize)
        local v270 = v263 - SegmentSize
        for v271 = SegmentSize, v270, SegmentSize do
            copy(v257, 16, v257, SegmentSize, v264)
            v247(v257, 0, v257, 0)
            local v272 = v271 + SegmentSize - 1
            local v273 = 0
            for v274 = v271, v272 do
                local v275 = readu8(v249, v274)
                local v276 = readu8(v257, v273)
                local v277 = bxor(v275, v276)
                writeu8(v250, v274, v277)
                v273 += 1
            end
            copy(v257, 0, v257, 16, v264)
            copy(v257, v264, v249, v271, SegmentSize)
        end
        v247(v257, 0, v257, 0)
        local v278 = v253 - 1
        local v279 = 0
        for v280 = v263, v278 do
            local v281 = readu8(v249, v280)
            local v282 = readu8(v257, v279)
            local v283 = bxor(v281, v282)
            writeu8(v250, v280, v283)
            v279 += 1
        end
    end
end

local function ofbMode(v284, v285, v286, v287, v288, v289) -- line 394 | captures: bxor, len, readu32, writeu32, v1
    local v290 = len(v286) - 16
    local v291 = v290 % 16 == 0
    assert(v291, "Input length must be a multiple of 16 bytes")
    local v292 = v289 or v1
    local v293 = len(v292) == 16
    assert(v293, "Initialization vector must be 16 bytes long")
    local v294 = readu32(v286, 0)
    local v295 = readu32(v286, 4)
    local v296 = readu32(v286, 8)
    local v297 = readu32(v286, 12)
    v284(v292, 0, v287, 0)
    local v298 = readu32(v287, 0)
    local v299 = bxor(v294, v298)
    local v300 = readu32(v287, 4)
    local v301 = bxor(v295, v300)
    local v302 = readu32(v287, 8)
    local v303 = bxor(v296, v302)
    local v304 = readu32(v287, 12)
    local v305 = bxor(v297, v304)
    for v306 = 16, v290, 16 do
        local v307 = readu32(v286, v306)
        local v308 = v306 + 4
        local v309 = readu32(v286, v308)
        local v310 = v306 + 8
        local v311 = readu32(v286, v310)
        local v312 = v306 + 12
        local v313 = readu32(v286, v312)
        v284(v287, v306 - 16, v287, v306)
        local v314 = v306 - 16
        writeu32(v287, v314, v299)
        local v315 = v306 - 12
        writeu32(v287, v315, v301)
        local v316 = v306 - 8
        writeu32(v287, v316, v303)
        local v317 = v306 - 4
        writeu32(v287, v317, v305)
        local v318 = readu32(v287, v306)
        v299 = bxor(v307, v318)
        local v319 = v306 + 4
        local v320 = readu32(v287, v319)
        v301 = bxor(v309, v320)
        local v321 = v306 + 8
        local v322 = readu32(v287, v321)
        v303 = bxor(v311, v322)
        local v323 = v306 + 12
        local v324 = readu32(v287, v323)
        v305 = bxor(v313, v324)
    end
    writeu32(v287, v290, v299)
    local v325 = v290 + 4
    writeu32(v287, v325, v301)
    local v326 = v290 + 8
    writeu32(v287, v326, v303)
    local v327 = v290 + 12
    writeu32(v287, v327, v305)
end

v15.OFB = {
    FwdMode = ofbMode,
    InvMode = ofbMode
}
table.freeze(v15.OFB)

local function ctrMode(v328, v329, v330, v331, v332) -- line 440 | captures: bxor, len, readu32, writestring, writeu32, addByteCtr
    local v333 = len(v330) - 16
    local v334 = v333 % 16 == 0
    assert(v334, "Input length must be a multiple of 16 bytes")
    local CommonTemp = v332.CommonTemp
    local InitValue = v332.InitValue
    local Prefix = v332.Prefix
    local v335 = #Prefix
    local v336 = v335 + #InitValue - 1
    writestring(CommonTemp, 0, Prefix)
    writestring(CommonTemp, v335, InitValue)
    writestring(CommonTemp, v336 + 1, v332.Suffix)
    local v337 = readu32(v330, 0)
    local v338 = readu32(v330, 4)
    local v339 = readu32(v330, 8)
    local v340 = readu32(v330, 12)
    v328(CommonTemp, 0, v331, 0)
    local v341 = readu32(v331, 0)
    local v342 = bxor(v341, v337)
    writeu32(v331, 0, v342)
    local v343 = readu32(v331, 4)
    local v344 = bxor(v343, v338)
    writeu32(v331, 4, v344)
    local v345 = readu32(v331, 8)
    local v346 = bxor(v345, v339)
    writeu32(v331, 8, v346)
    local v347 = readu32(v331, 12)
    local v348 = bxor(v347, v340)
    writeu32(v331, 12, v348)
    for v349 = 16, v333, 16 do
        local v350 = readu32(v330, v349)
        local v351 = v349 + 4
        local v352 = readu32(v330, v351)
        local v353 = v349 + 8
        local v354 = readu32(v330, v353)
        local v355 = v349 + 12
        local v356 = readu32(v330, v355)
        addByteCtr(CommonTemp, v332.Step, v335, v336, v332.LittleEndian)
        v328(CommonTemp, 0, v331, v349)
        local v357 = readu32(v331, v349)
        local v358 = bxor(v350, v357)
        writeu32(v331, v349, v358)
        local v359 = v349 + 4
        local v360 = v349 + 4
        local v361 = readu32(v331, v360)
        local v362 = bxor(v352, v361)
        writeu32(v331, v359, v362)
        local v363 = v349 + 8
        local v364 = v349 + 8
        local v365 = readu32(v331, v364)
        local v366 = bxor(v354, v365)
        writeu32(v331, v363, v366)
        local v367 = v349 + 12
        local v368 = v349 + 12
        local v369 = readu32(v331, v368)
        local v370 = bxor(v356, v369)
        writeu32(v331, v367, v370)
    end
end

local v371 = {}

function v371.__index(v372, v373) -- line 481 | captures: create, random, pack, cfbFwd, cfbInv, ctrMode
    if v373 == "CFB" then
        return {
            SegmentSize = 16,
            FwdMode = cfbFwd,
            InvMode = cfbInv,
            CommonTemp = create(31)
        }
    end
    if v373 == "CTR" then
        local v374 = {
            Prefix = "",
            Suffix = "",
            Step = 1,
            LittleEndian = false,
            FwdMode = ctrMode,
            InvMode = ctrMode
        }
        local v375 = random(0, 65535)
        local v376 = random(0, 65535)
        local v377 = random(0, 65535)
        local v378 = random(0, 65535)
        local v379 = random(0, 65535)
        local v380 = random(0, 65535)
        local v381 = random(0, 65535)
        v374.InitValue = pack("I2I2I2I2I2I2I2I2", v375, v376, v377, v378, v379, v380, v381, random(0, 65535))
        v374.CommonTemp = create(16)
        return v374
    end
    return nil
end

function v371.__newindex() -- line 507
end

setmetatable(v15, v371)
v15.CFB = {}
v15.CTR = {}
table.freeze(v15)
v371.__metatable = "This metatable is locked"
return v15
