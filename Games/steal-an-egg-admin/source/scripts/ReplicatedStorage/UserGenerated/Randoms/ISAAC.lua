-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.UserGenerated.Randoms.Base)
local GenerateSeed = require(ReplicatedStorage.UserGenerated.IO.Crypto.GenerateSeed)
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
local create = table.create
local clone = table.clone
local format = string.format
local new = Vector2.new
local new_2 = Vector3.new
assert(true)
local v1 = Random.new()

local function IsInteger(v2) -- line 29 | captures: floor
    if type(v2) == "number" and floor(v2) == v2 then
        if v2 == (1/0) then
            return false
        end
        return v2 ~= (-1/0)
    end
    return false
end

local function AssertIntegerNonNegative(v3) -- line 33 | captures: floor
    if not (type(v3) == "number" and floor(v3) == v3 and v3 ~= (1/0) and v3 ~= (-1/0)) then
        error("Integer", 2)
    end
    if v3 < 0 then
        error("NonNegative", 2)
    end
end

local function IsaacMix(v4) -- line 42 | captures: bxor, bor, lshift, rshift
    local v5 = v4[2]
    local v6 = v4[3]
    local v7 = v4[1]
    local v9 = lshift(v5, 11)
    local v10 = bxor(v7, v9)
    local v11 = v4[4] + v10
    local v12 = bor(v11, 0)
    local v13 = v5 + v6
    local v14 = bor(v13, 0)
    local v15 = rshift(v6, 2)
    local v16 = bxor(v14, v15)
    local v17 = v4[5] + v16
    local v18 = bor(v17, 0)
    local v19 = v6 + v12
    local v20 = bor(v19, 0)
    local v21 = lshift(v12, 8)
    local v22 = bxor(v20, v21)
    local v23 = v4[6] + v22
    local v24 = bor(v23, 0)
    local v25 = v12 + v18
    local v26 = bor(v25, 0)
    local v27 = rshift(v18, 16)
    local v28 = bxor(v26, v27)
    local v29 = v4[7] + v28
    local v30 = bor(v29, 0)
    local v31 = v18 + v24
    local v32 = bor(v31, 0)
    local v33 = lshift(v24, 10)
    local v34 = bxor(v32, v33)
    local v35 = v4[8] + v34
    local v36 = bor(v35, 0)
    local v37 = v24 + v30
    local v38 = bor(v37, 0)
    local v39 = rshift(v30, 4)
    local v40 = bxor(v38, v39)
    local v41 = v10 + v40
    local v42 = bor(v41, 0)
    local v43 = v30 + v36
    local v44 = bor(v43, 0)
    local v45 = lshift(v36, 8)
    local v46 = bxor(v44, v45)
    local v47 = v16 + v46
    local v48 = bor(v47, 0)
    local v49 = v36 + v42
    local v50 = bor(v49, 0)
    local v51 = rshift(v42, 9)
    local v52 = bxor(v50, v51)
    local v53 = v22 + v52
    local v54 = bor(v53, 0)
    local v55 = v42 + v48
    v4[1] = bor(v55, 0)
    v4[2] = v48
    v4[3] = v54
    v4[4] = v28
    v4[5] = v34
    v4[6] = v40
    v4[7] = v46
    v4[8] = v52
end

local function Isaac(v56) -- line 70 | captures: bxor, bor, band, lshift, rshift
    local v57 = v56.AA
    local MM = v56.MM
    local RSL = v56.RSL
    local v58 = v56.CC + 1
    local v59 = bor(v58, 0)
    local v60 = v56.BB + v59
    local v61 = bor(v60, 0)
    for v62 = 1, 256 do
        local v63 = MM[v62]
        local v64 = band(v62, 3)
        if v64 == 0 then
            local v65 = rshift(v57, 16)
            v57 = bxor(v57, v65)
        elseif v64 == 1 then
            local v66 = lshift(v57, 13)
            v57 = bxor(v57, v66)
        elseif v64 == 2 then
            local v67 = rshift(v57, 6)
            v57 = bxor(v57, v67)
        elseif v64 == 3 then
            local v68 = lshift(v57, 2)
            v57 = bxor(v57, v68)
        end
        local v69 = v62 + 127
        local v70 = MM[band(v69, 255) + 1] + v57
        v57 = bor(v70, 0)
        local v71 = rshift(v63, 2)
        local v72 = MM[band(v71, 255) + 1] + v57 + v61
        local v73 = bor(v72, 0)
        MM[v62] = v73
        local v74 = rshift(v73, 10)
        local v75 = MM[band(v74, 255) + 1] + v63
        v61 = bor(v75, 0)
        RSL[v62] = v61
    end
    (nil).AA = v57;
    (nil).BB = v61;
    (nil).CC = v59
end

local function IsaacInit(v76, v77) -- line 106 | captures: bor, create, IsaacMix
    v76.AA = 0
    v76.BB = 0
    v76.CC = 0
    v76.Count = 256
    local MM = v76.MM
    local RSL = v76.RSL
    local v78 = create(8, 2654435769)
    IsaacMix(v78)
    IsaacMix(v78)
    IsaacMix(v78)
    IsaacMix(v78)
    for v79 = 0, 255, 8 do
        if v77 then
            for v80 = 1, 8 do
                local v81 = v78[v80] + RSL[v79 + v80]
                v78[v80] = bor(v81, 0)
            end
        end
        IsaacMix(v78)
        MM[v79 + 1] = v78[1]
        MM[v79 + 2] = v78[2]
        MM[v79 + 3] = v78[3]
        MM[v79 + 4] = v78[4]
        MM[v79 + 5] = v78[5]
        MM[v79 + 6] = v78[6]
        MM[v79 + 7] = v78[7]
        MM[v79 + 8] = v78[8]
    end
    if v77 then
        for v82 = 0, 255, 8 do
            for v83 = 1, 8 do
                local v84 = v78[v83] + MM[v82 + v83]
                v78[v83] = bor(v84, 0)
            end
            IsaacMix(v78)
            MM[v82 + 1] = v78[1]
            MM[v82 + 2] = v78[2]
            MM[v82 + 3] = v78[3]
            MM[v82 + 4] = v78[4]
            MM[v82 + 5] = v78[5]
            MM[v82 + 6] = v78[6]
            MM[v82 + 7] = v78[7]
            MM[v82 + 8] = v78[8]
        end
    end
end

local function Seed(v85, v86, v87) -- line 161 | captures: bor, v1, IsaacInit
    local v88
    if v86 == nil then
        v88 = { v1:NextInteger(0, 4294967295) }
    elseif type(v86) == "number" then
        v88 = { v86 }
    else
        local v89 = type(v86) == "table"
        assert(v89)
        v88 = v86
    end
    local v90
    if v87 == nil then
        v90 = true
    else
        local v91 = type(v87) == "boolean"
        assert(v91)
        v90 = v87
    end
    local v92 = #v88
    local v93 = math.min(256, v92)
    local RSL = v85.RSL
    for v94 = 1, 256 do
        v85.MM[v94] = 0
        RSL[v94] = 0
    end
    for v95 = 1, v93 do
        local v96 = v88[v95]
        RSL[v95] = bor(v96, 0)
    end
    IsaacInit(v85, v90)
end

local freeze = table.freeze
local v97 = {}

function v97.NextU32(v98) -- line 194 | captures: Isaac
    local v99 = v98.Count + 1
    if v99 > 256 then
        Isaac(v98)
        v99 = 1
    end
    v98.Count = v99
    return v98.RSL[v99]
end

function v97.NextU64(v100) -- line 203 | captures: ldexp, Isaac
    local v101 = v100.Count + 1
    if v101 > 256 then
        Isaac(v100)
        v101 = 1
    end
    v100.Count = v101
    local v102 = v100.RSL[v101]
    local v103 = ldexp(v102, 32)
    local v104 = v100.Count + 1
    if v104 > 256 then
        Isaac(v100)
        v104 = 1
    end
    v100.Count = v104
    return v103 + v100.RSL[v104]
end

function v97.NextFloat(v105) -- line 219 | captures: ldexp, Isaac
    local v106 = v105.Count + 1
    if v106 > 256 then
        Isaac(v105)
        v106 = 1
    end
    v105.Count = v106
    local v107 = v105.RSL[v106]
    return (ldexp(v107, -32))
end

function v97.NextDouble(v108) -- line 229 | captures: ldexp, Isaac
    local v109 = v108.Count + 1
    if v109 > 256 then
        Isaac(v108)
        v109 = 1
    end
    v108.Count = v109
    local v110 = v108.RSL[v109]
    local v111 = ldexp(v110, 32)
    local v112 = v108.Count + 1
    if v112 > 256 then
        Isaac(v108)
        v112 = 1
    end
    v108.Count = v112
    local v113 = v111 + v108.RSL[v112]
    return (ldexp(v113, -64))
end

function v97.NextNumber(v114, v115, v116) -- line 246 | captures: ldexp, Isaac
    local v117 = v114.Count + 1
    if v117 > 256 then
        Isaac(v114)
        v117 = 1
    end
    v114.Count = v117
    local v118 = v114.RSL[v117]
    local v119 = ldexp(v118, 32)
    local v120 = v114.Count + 1
    if v120 > 256 then
        Isaac(v114)
        v120 = 1
    end
    v114.Count = v120
    local v121 = v116 - v115
    local v122 = v119 + v114.RSL[v120]
    return v115 + v121 * ldexp(v122, -64)
end

function v97.NextInteger(v123, v124, v125) -- line 262 | captures: floor, ldexp, Isaac
    local v126 = v123.Count + 1
    if v126 > 256 then
        Isaac(v123)
        v126 = 1
    end
    v123.Count = v126
    local v127 = v123.RSL[v126]
    local v128 = ldexp(v127, 32)
    local v129 = v123.Count + 1
    if v129 > 256 then
        Isaac(v123)
        v129 = 1
    end
    v123.Count = v129
    local v130 = v128 + v123.RSL[v129]
    local v131 = v124 + (v125 - v124 + 1) * ldexp(v130, -64)
    return (floor(v131))
end

function v97.NextNormal(v132, v133, v134) -- line 279 | captures: ldexp, sqrt, log, max, sin, cos, Isaac
    local v135 = v132.Count + 1
    if v135 > 256 then
        Isaac(v132)
        v135 = 1
    end
    v132.Count = v135
    local v136 = v132.RSL[v135]
    local v137 = ldexp(v136, 32)
    local v138 = v132.Count + 1
    if v138 > 256 then
        Isaac(v132)
        v138 = 1
    end
    v132.Count = v138
    local v139 = v137 + v132.RSL[v138]
    local v140 = ldexp(v139, -64)
    local v141 = max(0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014, v140)
    local v142 = log(v141) * -2
    local v143 = sqrt(v142) * (v134 or 0)
    local v144 = v132.Count + 1
    if v144 > 256 then
        Isaac(v132)
        v144 = 1
    end
    v132.Count = v144
    local v145 = v132.RSL[v144]
    local v146 = ldexp(v145, 32)
    local v147 = v132.Count + 1
    if v147 > 256 then
        Isaac(v132)
        v147 = 1
    end
    v132.Count = v147
    local v148 = v146 + v132.RSL[v147]
    local v149 = ldexp(v148, -64) * 6.283185307179586
    local v150 = v133 or 0
    return cos(v149) * v143 + v150, sin(v149) * v143 + v150
end

function v97.NextBoolean(v151, v152) -- line 314 | captures: ldexp, Isaac
    local v153 = v151.Count + 1
    if v153 > 256 then
        Isaac(v151)
        v153 = 1
    end
    v151.Count = v153
    local v154 = v151.RSL[v153]
    local v155 = ldexp(v154, 32)
    local v156 = v151.Count + 1
    if v156 > 256 then
        Isaac(v151)
        v156 = 1
    end
    v151.Count = v156
    local v157 = v155 + v151.RSL[v156]
    if ldexp(v157, -64) < v152 then
    end
    return true
end

function v97.NextVector2(v158, v159) -- line 337 | captures: ldexp, sin, cos, new, Isaac
    local v160 = v159 or 1
    local v161 = v158.Count + 1
    if v161 > 256 then
        Isaac(v158)
        v161 = 1
    end
    v158.Count = v161
    local v162 = v158.RSL[v161]
    local v163 = ldexp(v162, 32)
    local v164 = v158.Count + 1
    if v164 > 256 then
        Isaac(v158)
        v164 = 1
    end
    v158.Count = v164
    local v165 = v163 + v158.RSL[v164]
    local v166 = ldexp(v165, -64) * 6.283185307179586
    local v167 = cos(v166) * v160
    return new(v167, sin(v166) * v160)
end

function v97.NextVector3(v168, v169) -- line 356 | captures: ldexp, sqrt, sin, cos, new_2, Isaac
    local v170 = v169 or 1
    local v171 = v168.Count + 1
    if v171 > 256 then
        Isaac(v168)
        v171 = 1
    end
    v168.Count = v171
    local v172 = v168.RSL[v171]
    local v173 = ldexp(v172, 32)
    local v174 = v168.Count + 1
    if v174 > 256 then
        Isaac(v168)
        v174 = 1
    end
    v168.Count = v174
    local v175 = v173 + v168.RSL[v174]
    local v176 = ldexp(v175, -64) * 6.283185307179586
    local v177 = v168.Count + 1
    if v177 > 256 then
        Isaac(v168)
        v177 = 1
    end
    v168.Count = v177
    local v178 = v168.RSL[v177]
    local v179 = ldexp(v178, 32)
    local v180 = v168.Count + 1
    if v180 > 256 then
        Isaac(v168)
        v180 = 1
    end
    v168.Count = v180
    local v181 = v179 + v168.RSL[v180]
    local v182 = ldexp(v181, -64) * 2 - 1
    local v183 = 1 - v182 * v182
    local v184 = sqrt(v183)
    local v185 = cos(v176) * v184 * v170
    local v186 = sin(v176) * v184 * v170
    local v187 = v182 * v170
    return (new_2(v185, v186, v187))
end

function v97.NextUUIDv4(v188) -- line 391 | captures: bor, band, format, Isaac
    local v189 = v188.Count + 1
    if v189 > 256 then
        Isaac(v188)
        v189 = 1
    end
    v188.Count = v189
    local v190 = v188.Count + 1
    if v190 > 256 then
        Isaac(v188)
        v190 = 1
    end
    v188.Count = v190
    local v191 = v188.RSL[v190]
    local v192 = band(v191, 4294905855)
    local v193 = bor(v192, 16384)
    local v194 = v188.Count + 1
    if v194 > 256 then
        Isaac(v188)
        v194 = 1
    end
    v188.Count = v194
    local v195 = v188.RSL[v194]
    local v196 = band(v195, 1073741823)
    local v197 = bor(v196, 2147483648)
    local v198 = v188.Count + 1
    if v198 > 256 then
        Isaac(v188)
        v198 = 1
    end
    v188.Count = v198
    return format("%08x%08x%08x%08x", v188.RSL[v193], v193, v197, v188.RSL[v198])
end

v97.Seed = Seed

function v97.Shuffle(v199, v200) -- line 423 | captures: floor, ldexp, Isaac
    local v201 = type(v200) == "table"
    assert(v201)
    local v202 = #v200
    for v203 = v202, 2, -1 do
        local v204 = v199.Count + 1
        if v204 > 256 then
            Isaac(v199)
            v204 = 1
        end
        v199.Count = v204
        local v205 = v199.RSL[v204]
        local v206 = ldexp(v205, 32)
        local v207 = v199.Count + 1
        if v207 > 256 then
            Isaac(v199)
            v207 = 1
        end
        v199.Count = v207
        local v208 = v203 - 1 + 1
        local v209 = v206 + v199.RSL[v207]
        local v210 = v208 * ldexp(v209, -64) + 1
        local v211 = floor(v210)
        local v212 = v8[v203]
        v8[v203] = v8[v211]
        v8[v211] = v212
    end
end

function v97.Clone(v213) -- line 450 | captures: clone
    local v214 = {
        RSL = clone(v213.RSL),
        Count = v213.Count,
        MM = clone(v213.MM),
        AA = v213.AA,
        BB = v213.BB,
        CC = v213.CC
    }
    local v215 = getmetatable(v213)
    return (setmetatable(v214, v215))
end

local v216 = freeze(v97)
local v217 = table.freeze({ __index = v216 })
local v218 = {}

function v218.new(v219, v220) -- line 464 | captures: create, Seed, v217
    local v221 = {
        Count = 0,
        AA = 0,
        BB = 0,
        CC = 0,
        RSL = create(256, 0),
        MM = create(256, 0)
    }
    Seed(v221, v219, v220)
    return (setmetatable(v221, v217))
end

function v218.Unique(v222) -- line 477 | captures: GenerateSeed, floor, clamp, v218
    if v222 ~= nil then
        if not (type(v222) == "number" and floor(v222) == v222 and v222 ~= (1/0) and v222 ~= (-1/0)) then
            error("Integer", 2)
        end
        if v222 < 0 then
            error("NonNegative", 2)
        end
    end
    local v223 = v222 or 32
    local v224 = clamp(v223, 0, 256)
    local v225 = GenerateSeed(v224)
    return v218.new(v225, true)
end

v218.R = v218.Unique()
return table.freeze(v218)
