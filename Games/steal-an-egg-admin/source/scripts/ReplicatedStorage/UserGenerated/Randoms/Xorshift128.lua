-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Randoms.Base)
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
local Theory = require(script.Theory)
local bxor = bit32.bxor
local bor = bit32.bor
local band = bit32.band
local lshift = bit32.lshift
local rshift = bit32.rshift
local floor = math.floor
local ldexp = math.ldexp
local sqrt = math.sqrt
local log = math.log
local max = math.max
local sin = math.sin
local cos = math.cos
local clamp = math.clamp
local format = string.format
local new = Vector2.new
local new_2 = Vector3.new
assert(true)
local v1 = Random.new()

local function Mul32(v2, v3) -- line 28 | captures: band, lshift, rshift
    local v4 = rshift(v2, 16)
    local v5 = band(v2, 65535)
    local v6 = rshift(v3, 16)
    local v7 = band(v3, 65535)
    local v8 = v4 * v7 + v5 * v6
    local v9 = band(v8, 65535)
    return lshift(v9, 16) + v5 * v7
end

local function IsInteger(v10) -- line 36 | captures: floor
    if type(v10) == "number" and floor(v10) == v10 then
        if v10 == (1/0) then
            return false
        end
        return v10 ~= (-1/0)
    end
    return false
end

local function AssertInteger(v11) -- line 40 | captures: floor
    if not (type(v11) == "number" and floor(v11) == v11 and v11 ~= (1/0) and v11 ~= (-1/0)) then
        error("Integer", 2)
    end
end

local function AssertIntegerNonNegative(v12) -- line 46 | captures: floor
    if not (type(v12) == "number" and floor(v12) == v12 and v12 ~= (1/0) and v12 ~= (-1/0)) then
        error("Integer", 2)
    end
    if v12 < 0 then
        error("NonNegative", 2)
    end
end

local function Seed(v13, v14) -- line 55 | captures: bor, band, lshift, rshift, v1
    local v15
    if v14 == nil then
        v15 = {}
    elseif type(v14) == "number" then
        v15 = { v14 }
    else
        v15 = v14
    end
    local v16 = v15[1]
    local v17 = v15[2]
    local v18 = v15[3]
    local v19 = v15[4]
    local v20 = v16 or v1:NextInteger(0, 4294967295)
    local v21 = bor(v20, 0)
    if not v17 then
        local v22 = rshift(v21, 16)
        local v23 = band(v21, 65535)
        local v24 = v23 * 27655 + v22 * 35173
        local v25 = band(v24, 65535)
        v17 = lshift(v25, 16) + v23 * 35173 + 1
    end
    local v26 = bor(v17, 0)
    if not v18 then
        local v27 = rshift(v26, 16)
        local v28 = band(v26, 65535)
        local v29 = v28 * 27655 + v27 * 35173
        local v30 = band(v29, 65535)
        v18 = lshift(v30, 16) + v28 * 35173 + 1
    end
    local v31 = bor(v18, 0)
    if not v19 then
        local v32 = rshift(v31, 16)
        local v33 = band(v31, 65535)
        local v34 = v33 * 27655 + v32 * 35173
        local v35 = band(v34, 65535)
        v19 = lshift(v35, 16) + v33 * 35173 + 1
    end
    v13.x = v21
    v13.y = v26
    v13.z = v31
    v13.w = bor(v19, 0)
end

local freeze = table.freeze
local v36 = {}

function v36.NextU32(v37) -- line 101 | captures: bxor, lshift, rshift
    local x = v37.x
    local w = v37.w
    local v38 = lshift(x, 11)
    local v39 = bxor(x, v38)
    local v40 = rshift(v39, 8)
    local v41 = bxor(v39, v40)
    local v42 = bxor(v41, w)
    local v43 = rshift(w, 19)
    local v44 = bxor(v42, v43)
    local z = v37.z
    v37.x = v37.y
    v37.y = z
    v37.z = w
    v37.w = v44
    return v44
end

function v36.NextU64(v45) -- line 113 | captures: bxor, lshift, rshift, ldexp
    local x = v45.x
    local w = v45.w
    local v46 = lshift(x, 11)
    local v47 = bxor(x, v46)
    local v48 = rshift(v47, 8)
    local v49 = bxor(v47, v48)
    local v50 = bxor(v49, w)
    local v51 = rshift(w, 19)
    local v52 = bxor(v50, v51)
    local z = v45.z
    v45.x = v45.y
    v45.y = z
    v45.z = w
    v45.w = v52
    local v53 = ldexp(v52, 32)
    local x_2 = v45.x
    local w_2 = v45.w
    local v54 = lshift(x_2, 11)
    local v55 = bxor(x_2, v54)
    local v56 = rshift(v55, 8)
    local v57 = bxor(v55, v56)
    local v58 = bxor(v57, w_2)
    local v59 = rshift(w_2, 19)
    local v60 = bxor(v58, v59)
    local z_2 = v45.z
    v45.x = v45.y
    v45.y = z_2
    v45.z = w_2
    v45.w = v60
    return v53 + v60
end

function v36.NextFloat(v61) -- line 135 | captures: bxor, lshift, rshift, ldexp
    local x = v61.x
    local w = v61.w
    local v62 = lshift(x, 11)
    local v63 = bxor(x, v62)
    local v64 = rshift(v63, 8)
    local v65 = bxor(v63, v64)
    local v66 = bxor(v65, w)
    local v67 = rshift(w, 19)
    local v68 = bxor(v66, v67)
    local z = v61.z
    v61.x = v61.y
    v61.y = z
    v61.z = w
    v61.w = v68
    return (ldexp(v68, -32))
end

function v36.NextDouble(v69) -- line 148 | captures: bxor, lshift, rshift, ldexp
    local x = v69.x
    local w = v69.w
    local v70 = lshift(x, 11)
    local v71 = bxor(x, v70)
    local v72 = rshift(v71, 8)
    local v73 = bxor(v71, v72)
    local v74 = bxor(v73, w)
    local v75 = rshift(w, 19)
    local v76 = bxor(v74, v75)
    local z = v69.z
    v69.x = v69.y
    v69.y = z
    v69.z = w
    v69.w = v76
    local v77 = ldexp(v76, 32)
    local x_2 = v69.x
    local w_2 = v69.w
    local v78 = lshift(x_2, 11)
    local v79 = bxor(x_2, v78)
    local v80 = rshift(v79, 8)
    local v81 = bxor(v79, v80)
    local v82 = bxor(v81, w_2)
    local v83 = rshift(w_2, 19)
    local v84 = bxor(v82, v83)
    local z_2 = v69.z
    v69.x = v69.y
    v69.y = z_2
    v69.z = w_2
    v69.w = v84
    local v85 = v77 + v84
    return (ldexp(v85, -64))
end

function v36.NextNumber(v86, v87, v88) -- line 171 | captures: bxor, lshift, rshift, ldexp
    local x = v86.x
    local w = v86.w
    local v89 = lshift(x, 11)
    local v90 = bxor(x, v89)
    local v91 = rshift(v90, 8)
    local v92 = bxor(v90, v91)
    local v93 = bxor(v92, w)
    local v94 = rshift(w, 19)
    local v95 = bxor(v93, v94)
    local z = v86.z
    v86.x = v86.y
    v86.y = z
    v86.z = w
    v86.w = v95
    local v96 = ldexp(v95, 32)
    local x_2 = v86.x
    local w_2 = v86.w
    local v97 = lshift(x_2, 11)
    local v98 = bxor(x_2, v97)
    local v99 = rshift(v98, 8)
    local v100 = bxor(v98, v99)
    local v101 = bxor(v100, w_2)
    local v102 = rshift(w_2, 19)
    local v103 = bxor(v101, v102)
    local z_2 = v86.z
    v86.x = v86.y
    v86.y = z_2
    v86.z = w_2
    v86.w = v103
    local v104 = v88 - v87
    local v105 = v96 + v103
    return v87 + v104 * ldexp(v105, -64)
end

function v36.NextInteger(v106, v107, v108) -- line 193 | captures: bxor, lshift, rshift, floor, ldexp
    local v109 = v108 - v107 + 1
    local x = v106.x
    local w = v106.w
    local v110 = lshift(x, 11)
    local v111 = bxor(x, v110)
    local v112 = rshift(v111, 8)
    local v113 = bxor(v111, v112)
    local v114 = bxor(v113, w)
    local v115 = rshift(w, 19)
    local v116 = bxor(v114, v115)
    local z = v106.z
    v106.x = v106.y
    v106.y = z
    v106.z = w
    v106.w = v116
    local v117 = ldexp(v116, 32)
    local x_2 = v106.x
    local w_2 = v106.w
    local v118 = lshift(x_2, 11)
    local v119 = bxor(x_2, v118)
    local v120 = rshift(v119, 8)
    local v121 = bxor(v119, v120)
    local v122 = bxor(v121, w_2)
    local v123 = rshift(w_2, 19)
    local v124 = bxor(v122, v123)
    local z_2 = v106.z
    v106.x = v106.y
    v106.y = z_2
    v106.z = w_2
    v106.w = v124
    local v125 = v117 + v124
    local v126 = v107 + v109 * ldexp(v125, -64)
    return (floor(v126))
end

function v36.NextNormal(v127, v128, v129) -- line 217 | captures: bxor, lshift, rshift, ldexp, sqrt, log, max, sin, cos
    local x = v127.x
    local w = v127.w
    local v130 = lshift(x, 11)
    local v131 = bxor(x, v130)
    local v132 = rshift(v131, 8)
    local v133 = bxor(v131, v132)
    local v134 = bxor(v133, w)
    local v135 = rshift(w, 19)
    local v136 = bxor(v134, v135)
    local z = v127.z
    v127.x = v127.y
    v127.y = z
    v127.z = w
    v127.w = v136
    local v137 = ldexp(v136, 32)
    local x_2 = v127.x
    local w_2 = v127.w
    local v138 = lshift(x_2, 11)
    local v139 = bxor(x_2, v138)
    local v140 = rshift(v139, 8)
    local v141 = bxor(v139, v140)
    local v142 = bxor(v141, w_2)
    local v143 = rshift(w_2, 19)
    local v144 = bxor(v142, v143)
    local z_2 = v127.z
    v127.x = v127.y
    v127.y = z_2
    v127.z = w_2
    v127.w = v144
    local v145 = v137 + v144
    local v146 = ldexp(v145, -64)
    local v147 = max(0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014, v146)
    local v148 = log(v147) * -2
    local v149 = sqrt(v148) * (v129 or 0)
    local x_3 = v127.x
    local w_3 = v127.w
    local v150 = lshift(x_3, 11)
    local v151 = bxor(x_3, v150)
    local v152 = rshift(v151, 8)
    local v153 = bxor(v151, v152)
    local v154 = bxor(v153, w_3)
    local v155 = rshift(w_3, 19)
    local v156 = bxor(v154, v155)
    local z_3 = v127.z
    v127.x = v127.y
    v127.y = z_3
    v127.z = w_3
    v127.w = v156
    local v157 = ldexp(v156, 32)
    local x_4 = v127.x
    local w_4 = v127.w
    local v158 = lshift(x_4, 11)
    local v159 = bxor(x_4, v158)
    local v160 = rshift(v159, 8)
    local v161 = bxor(v159, v160)
    local v162 = bxor(v161, w_4)
    local v163 = rshift(w_4, 19)
    local v164 = bxor(v162, v163)
    local z_4 = v127.z
    v127.x = v127.y
    v127.y = z_4
    v127.z = w_4
    v127.w = v164
    local v165 = v157 + v164
    local v166 = ldexp(v165, -64) * 6.283185307179586
    local v167 = v128 or 0
    return cos(v166) * v149 + v167, sin(v166) * v149 + v167
end

function v36.NextBoolean(v168, v169) -- line 264 | captures: bxor, lshift, rshift, ldexp
    local x = v168.x
    local w = v168.w
    local v170 = lshift(x, 11)
    local v171 = bxor(x, v170)
    local v172 = rshift(v171, 8)
    local v173 = bxor(v171, v172)
    local v174 = bxor(v173, w)
    local v175 = rshift(w, 19)
    local v176 = bxor(v174, v175)
    local z = v168.z
    v168.x = v168.y
    v168.y = z
    v168.z = w
    v168.w = v176
    local v177 = ldexp(v176, 32)
    local x_2 = v168.x
    local w_2 = v168.w
    local v178 = lshift(x_2, 11)
    local v179 = bxor(x_2, v178)
    local v180 = rshift(v179, 8)
    local v181 = bxor(v179, v180)
    local v182 = bxor(v181, w_2)
    local v183 = rshift(w_2, 19)
    local v184 = bxor(v182, v183)
    local z_2 = v168.z
    v168.x = v168.y
    v168.y = z_2
    v168.z = w_2
    v168.w = v184
    local v185 = v177 + v184
    if ldexp(v185, -64) < v169 then
    end
    return true
end

function v36.NextVector2(v186, v187) -- line 293 | captures: bxor, lshift, rshift, ldexp, sin, cos, new
    local v188 = v187 or 1
    local x = v186.x
    local w = v186.w
    local v189 = lshift(x, 11)
    local v190 = bxor(x, v189)
    local v191 = rshift(v190, 8)
    local v192 = bxor(v190, v191)
    local v193 = bxor(v192, w)
    local v194 = rshift(w, 19)
    local v195 = bxor(v193, v194)
    local z = v186.z
    v186.x = v186.y
    v186.y = z
    v186.z = w
    v186.w = v195
    local v196 = ldexp(v195, 32)
    local x_2 = v186.x
    local w_2 = v186.w
    local v197 = lshift(x_2, 11)
    local v198 = bxor(x_2, v197)
    local v199 = rshift(v198, 8)
    local v200 = bxor(v198, v199)
    local v201 = bxor(v200, w_2)
    local v202 = rshift(w_2, 19)
    local v203 = bxor(v201, v202)
    local z_2 = v186.z
    v186.x = v186.y
    v186.y = z_2
    v186.z = w_2
    v186.w = v203
    local v204 = v196 + v203
    local v205 = ldexp(v204, -64) * 6.283185307179586
    local v206 = cos(v205) * v188
    return new(v206, sin(v205) * v188)
end

function v36.NextVector3(v207, v208) -- line 318 | captures: bxor, lshift, rshift, ldexp, sqrt, sin, cos, new_2
    local v209 = v208 or 1
    local x = v207.x
    local w = v207.w
    local v210 = lshift(x, 11)
    local v211 = bxor(x, v210)
    local v212 = rshift(v211, 8)
    local v213 = bxor(v211, v212)
    local v214 = bxor(v213, w)
    local v215 = rshift(w, 19)
    local v216 = bxor(v214, v215)
    local z = v207.z
    v207.x = v207.y
    v207.y = z
    v207.z = w
    v207.w = v216
    local v217 = ldexp(v216, 32)
    local x_2 = v207.x
    local w_2 = v207.w
    local v218 = lshift(x_2, 11)
    local v219 = bxor(x_2, v218)
    local v220 = rshift(v219, 8)
    local v221 = bxor(v219, v220)
    local v222 = bxor(v221, w_2)
    local v223 = rshift(w_2, 19)
    local v224 = bxor(v222, v223)
    local z_2 = v207.z
    v207.x = v207.y
    v207.y = z_2
    v207.z = w_2
    v207.w = v224
    local v225 = v217 + v224
    local v226 = ldexp(v225, -64) * 6.283185307179586
    local x_3 = v207.x
    local w_3 = v207.w
    local v227 = lshift(x_3, 11)
    local v228 = bxor(x_3, v227)
    local v229 = rshift(v228, 8)
    local v230 = bxor(v228, v229)
    local v231 = bxor(v230, w_3)
    local v232 = rshift(w_3, 19)
    local v233 = bxor(v231, v232)
    local z_3 = v207.z
    v207.x = v207.y
    v207.y = z_3
    v207.z = w_3
    v207.w = v233
    local v234 = ldexp(v233, 32)
    local x_4 = v207.x
    local w_4 = v207.w
    local v235 = lshift(x_4, 11)
    local v236 = bxor(x_4, v235)
    local v237 = rshift(v236, 8)
    local v238 = bxor(v236, v237)
    local v239 = bxor(v238, w_4)
    local v240 = rshift(w_4, 19)
    local v241 = bxor(v239, v240)
    local z_4 = v207.z
    v207.x = v207.y
    v207.y = z_4
    v207.z = w_4
    v207.w = v241
    local v242 = v234 + v241
    local v243 = ldexp(v242, -64) * 2 - 1
    local v244 = 1 - v243 * v243
    local v245 = sqrt(v244)
    local v246 = cos(v226) * v245 * v209
    local v247 = sin(v226) * v245 * v209
    local v248 = v243 * v209
    return (new_2(v246, v247, v248))
end

function v36.NextUUIDv4(v249) -- line 365 | captures: bxor, bor, band, lshift, rshift, format
    local x = v249.x
    local w = v249.w
    local v250 = lshift(x, 11)
    local v251 = bxor(x, v250)
    local v252 = rshift(v251, 8)
    local v253 = bxor(v251, v252)
    local v254 = bxor(v253, w)
    local v255 = rshift(w, 19)
    local v256 = bxor(v254, v255)
    local z = v249.z
    v249.x = v249.y
    v249.y = z
    v249.z = w
    v249.w = v256
    local x_2 = v249.x
    local w_2 = v249.w
    local v257 = lshift(x_2, 11)
    local v258 = bxor(x_2, v257)
    local v259 = rshift(v258, 8)
    local v260 = bxor(v258, v259)
    local v261 = bxor(v260, w_2)
    local v262 = rshift(w_2, 19)
    local v263 = bxor(v261, v262)
    local z_2 = v249.z
    v249.x = v249.y
    v249.y = z_2
    v249.z = w_2
    v249.w = v263
    local v264 = band(v263, 4294905855)
    local v265 = bor(v264, 16384)
    local x_3 = v249.x
    local w_3 = v249.w
    local v266 = lshift(x_3, 11)
    local v267 = bxor(x_3, v266)
    local v268 = rshift(v267, 8)
    local v269 = bxor(v267, v268)
    local v270 = bxor(v269, w_3)
    local v271 = rshift(w_3, 19)
    local v272 = bxor(v270, v271)
    local z_3 = v249.z
    v249.x = v249.y
    v249.y = z_3
    v249.z = w_3
    v249.w = v272
    local v273 = band(v272, 1073741823)
    local v274 = bor(v273, 2147483648)
    local x_4 = v249.x
    local w_4 = v249.w
    local v275 = lshift(x_4, 11)
    local v276 = bxor(x_4, v275)
    local v277 = rshift(v276, 8)
    local v278 = bxor(v276, v277)
    local v279 = bxor(v278, w_4)
    local v280 = rshift(w_4, 19)
    local v281 = bxor(v279, v280)
    local z_4 = v249.z
    v249.x = v249.y
    v249.y = z_4
    v249.z = w_4
    v249.w = v281
    return format("%08x%08x%08x%08x", v256, v265, v274, v281)
end

v36.Seed = Seed

function v36.Shuffle(v282, v283) -- line 410 | captures: bxor, lshift, rshift, floor, ldexp
    local v284 = type(v283) == "table"
    assert(v284)
    local v285 = #v283
    for v286 = v285, 2, -1 do
        local x = v282.x
        local w = v282.w
        local v287 = lshift(x, 11)
        local v288 = bxor(x, v287)
        local v289 = rshift(v288, 8)
        local v290 = bxor(v288, v289)
        local v291 = bxor(v290, w)
        local v292 = rshift(w, 19)
        local v293 = bxor(v291, v292)
        local z = v282.z
        v282.x = v282.y
        v282.y = z
        v282.z = w
        v282.w = v293
        local v294 = ldexp(v293, 32)
        local x_2 = v282.x
        local w_2 = v282.w
        local v295 = lshift(x_2, 11)
        local v296 = bxor(x_2, v295)
        local v297 = rshift(v296, 8)
        local v298 = bxor(v296, v297)
        local v299 = bxor(v298, w_2)
        local v300 = rshift(w_2, 19)
        local v301 = bxor(v299, v300)
        local z_2 = v282.z
        v282.x = v282.y
        v282.y = z_2
        v282.z = w_2
        v282.w = v301
        local v302 = v286 - 1 + 1
        local v303 = v294 + v301
        local v304 = v302 * ldexp(v303, -64) + 1
        local v305 = floor(v304)
        local v306 = v283[v286]
        v283[v286] = v283[v305]
        v283[v305] = v306
    end
end

function v36.Clone(v307) -- line 442
    local v308 = {
        x = v307.x,
        y = v307.y,
        z = v307.z,
        w = v307.w
    }
    local v309 = getmetatable(v307)
    return (setmetatable(v308, v309))
end

function v36.GetState(v310) -- line 446
    return {
        v310.x,
        v310.y,
        v310.z,
        v310.w
    }
end

function v36.Skip(v311, v312) -- line 449 | captures: Theory, floor
    if not (type(v312) == "number" and floor(v312) == v312 and v312 ~= (1/0) and v312 ~= (-1/0)) then
        error("Integer", 2)
    end
    local v313, v314, v315, v316 = Theory.Transform(v311.x, v311.y, v311.z, v311.w, v312)
    v311.x = v313
    v311.y = v314
    v311.z = v315
    v311.w = v316
end

local v317 = freeze(v36)
local v318 = table.freeze({ __index = v317 })
local v319 = {}

function v319.new(v320) -- line 464 | captures: Seed, v318
    local v321 = {
        x = 0,
        y = 0,
        z = 0,
        w = 0
    }
    Seed(v321, v320)
    return (setmetatable(v321, v318))
end

function v319.Unique(v322) -- line 470 | captures: GenerateSeed, floor, clamp, v319
    if v322 ~= nil then
        if not (type(v322) == "number" and floor(v322) == v322 and v322 ~= (1/0) and v322 ~= (-1/0)) then
            error("Integer", 2)
        end
        if v322 < 0 then
            error("NonNegative", 2)
        end
    end
    local v323 = v322 or 4
    local v324 = clamp(v323, 0, 4)
    return v319.new(GenerateSeed(v324))
end

v319.R = v319.Unique()
return table.freeze(v319)
