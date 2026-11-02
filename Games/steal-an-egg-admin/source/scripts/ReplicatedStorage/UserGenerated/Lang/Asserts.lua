-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function IsEqual(v1, v2) -- line 6
    if rawequal(v1, v2) then
        return true
    end
    if type(v1) == "number" and type(v2) == "number" and v1 ~= v1 then
        return v2 ~= v2
    end
    return false
end

local function IsASCII(v3) -- line 18
    local v4 = string.len(v3)
    for v5 = 1, v4 do
        local v6 = string.byte(v3, v5)
        if not (v6 >= 32 and v6 <= 126) then
            return false
        end
    end
    return true
end

local function IsFinite(v7) -- line 31
    if v7 == v7 then
        if v7 == (1/0) then
            return false
        end
        return v7 ~= (-1/0)
    end
    return false
end

local function IsInteger(v8) -- line 35
    if math.floor(v8) == v8 then
        if v8 == (1/0) then
            return false
        end
        return v8 ~= (-1/0)
    end
    return false
end

local function LuaString(v9) -- line 39
    return (string.format("%q", v9):gsub("\n", "n"))
end

local function StringRep(v12) -- line 44
    if type(v12) == "string" then
        return (string.format("%q", v12):gsub("\n", "n"))
    end
    if typeof(v12) == "Instance" then
        return v12:GetFullName()
    end
    return (tostring(v12))
end

local function SafeKeyStringRep(v13) -- line 55
    if type(v13) == "number" or type(v13) == "boolean" then
        return (("%*"):format(v13))
    end
    if type(v13) == "string" then
        local v14 = utf8.len(v13)
        if v14 then
            local v15 = string.len(v13)
            for v16 = 1, v15 do
                local v17 = string.byte(v13, v16)
                local v18, v19
                if v17 < 32 then
                    v18 = false
                    v19 = false
                elseif v17 <= 126 then
                    v19 = true
                else
                    v18 = false
                    v19 = false
                end
                if not v19 then
                    if v18 then
                        if v14 <= 30 then
                            return (string.format("%q", v13):gsub("\n", "n"))
                        end
                        local v20 = string.sub(v13, 1, 30)
                        return (("%*...%*"):format(string.format("%q", v20):gsub("\n", "n"), v14 - 30))
                    end
                    return "NonASCII"
                end
            end
            if v14 <= 30 then
                return (string.format("%q", v13):gsub("\n", "n"))
            end
            local v21 = string.sub(v13, 1, 30)
            return (("%*...%*"):format(string.format("%q", v21):gsub("\n", "n"), v14 - 30))
        end
        return "InvalidUTF8"
    end
    if typeof(v13) == "Instance" then
        return v13:GetFullName()
    end
    return (("UnknownType(%*)"):format((typeof(v13))))
end

local function StripErrorSource(v22) -- line 108
    local v23 = tostring(v22)
    local v24, v25 = string.match(v23, "^(.*:%d+): (.+)$")
    return v24 and v25 or v23
end

local function ParseError(v26) -- line 117
    local v27 = tostring(v26)
    local v28, v29 = string.match(v27, "^(.*:%d+): (.+)$")
    local v30 = v28 and v29 or v27
    local v31, v32 = string.match(v30, "^(.+) $(%[.+)$")
    if not (v31 and v32) then
        v31 = v30
    end
    return v31, v32
end

local function MakeError(v33, v34) -- line 131
    return (("%* $%*"):format(v33, v34))
end

local v35 = {
    IsCFrameFinite = function(v36) -- IsCFrameFinite | line 135
        local v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48 = v36:GetComponents()
        local v49 = v37 + v38 + v39 + v40 + v41 + v42 + v43 + v44 + v45 + v46 + v47 + v48
        if v49 == v49 then
            if v49 == (1/0) then
                return false
            end
            return v49 ~= (-1/0)
        end
        return false
    end,
    IsVector2Finite = function(v50) -- IsVector2Finite | line 142
        local v51 = v50.X + v50.Y
        if v51 == v51 then
            if v51 == (1/0) then
                return false
            end
            return v51 ~= (-1/0)
        end
        return false
    end,
    IsVector3Finite = function(v52) -- IsVector3Finite | line 147
        local v53 = v52.X + v52.Y + v52.Z
        if v53 == v53 then
            if v53 == (1/0) then
                return false
            end
            return v53 ~= (-1/0)
        end
        return false
    end
}

function v35.Array(v54) -- line 153 | captures: SafeKeyStringRep, v35
    v35.Function(v54)
    return function(v55) -- line 155 | captures: v54, SafeKeyStringRep
        if type(v55) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v55) ~= nil then
            error("metatable", 2)
        end
        local v56 = rawlen(v55)
        local v57 = 0
        for v58, v59 in pairs(v55) do
            v57 += 1
            if v58 ~= v57 then
                local v60 = ("[%*]"):format((SafeKeyStringRep(v58)))
                error(("IndexMismatch $%*"):format(v60), 2)
            end
            if v56 < v57 then
                local v61 = ("[%*]"):format(v57)
                error(("IndexOverflow $%*"):format(v61), 2)
            end
            local v62, v63 = pcall(v54, v59)
            if not v62 then
                local v64 = tostring(v63)
                local v65, v66 = string.match(v64, "^(.*:%d+): (.+)$")
                local v67 = v65 and v66 or v64
                local v68, v69 = string.match(v67, "^(.+) $(%[.+)$")
                if not (v68 and v69) then
                    v68 = v67
                end
                local v70 = ("[%*]%*"):format(v57, v69 or "")
                error(("%* $%*"):format(v68, v70), 2)
            end
        end
        if v56 ~= v57 then
            error("LengthMismatch", 2)
        end
        return v10
    end
end

function v35.ArrayCoerce(v71) -- line 197 | captures: SafeKeyStringRep, v35
    v35.Function(v71)
    return function(v72) -- line 199 | captures: v71, SafeKeyStringRep
        if type(v72) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v72) ~= nil then
            error("metatable", 2)
        end
        local v73 = rawlen(v72)
        local v74 = {}
        local v75 = 0
        for v76, v77 in pairs(v72) do
            v75 += 1
            if v76 ~= v75 then
                local v78 = ("[%*]"):format((SafeKeyStringRep(v76)))
                error(("IndexMismatch $%*"):format(v78), 2)
            end
            if v73 < v75 then
                local v79 = ("[%*]"):format(v75)
                error(("IndexOverflow $%*"):format(v79), 2)
            end
            local v80, v81 = pcall(v71, v77)
            if not v80 then
                local v82 = tostring(v81)
                local v83, v84 = string.match(v82, "^(.*:%d+): (.+)$")
                local v85 = v83 and v84 or v82
                local v86, v87 = string.match(v85, "^(.+) $(%[.+)$")
                if not (v86 and v87) then
                    v86 = v85
                end
                local v88 = ("[%*]%*"):format(v75, v87 or "")
                error(("%* $%*"):format(v86, v88), 2)
            end
            v74[v76] = v81
        end
        if v73 ~= v75 then
            error("LengthMismatch", 2)
        end
        return v74
    end
end

function v35.UniqueArray(v89) -- line 243 | captures: SafeKeyStringRep, v35
    v35.Function(v89)
    return function(v90) -- line 245 | captures: v89, SafeKeyStringRep
        if type(v90) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v90) ~= nil then
            error("metatable", 2)
        end
        local v91 = {}
        local v92 = rawlen(v90)
        local v93 = 0
        for v94, v95 in pairs(v90) do
            v93 += 1
            if v94 ~= v93 then
                local v96 = ("[%*]"):format((SafeKeyStringRep(v94)))
                error(("IndexMismatch $%*"):format(v96), 2)
            end
            if v92 < v93 then
                local v97 = ("[%*]"):format(v93)
                error(("IndexOverflow $%*"):format(v97), 2)
            end
            if v91[v95] then
                local v98 = ("[%*]"):format(v93)
                error(("UniqueArray $%*"):format(v98), 2)
            end
            v91[v95] = true
            if not v91[v95] then
                local v99 = ("[%*]"):format(v93)
                error(("InvalidKey $%*"):format(v99), 2)
            end
            local v100, v101 = pcall(v89, v95)
            if not v100 then
                local v102 = tostring(v101)
                local v103, v104 = string.match(v102, "^(.*:%d+): (.+)$")
                local v105 = v103 and v104 or v102
                local v106, v107 = string.match(v105, "^(.+) $(%[.+)$")
                if not (v106 and v107) then
                    v106 = v105
                end
                local v108 = ("[%*]%*"):format(v93, v107 or "")
                error(("%* $%*"):format(v106, v108), 2)
            end
        end
        if v92 ~= v93 then
            error("LengthMismatch", 2)
        end
        return v11
    end
end

function v35.UniqueArrayCoerce(v109) -- line 297 | captures: SafeKeyStringRep, v35
    v35.Function(v109)
    return function(v110) -- line 299 | captures: v109, SafeKeyStringRep
        if type(v110) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v110) ~= nil then
            error("metatable", 2)
        end
        local v111 = {}
        local v112 = rawlen(v110)
        local v113 = {}
        local v114 = 0
        for v115, v116 in pairs(v110) do
            v114 += 1
            if v115 ~= v114 then
                local v117 = ("[%*]"):format((SafeKeyStringRep(v115)))
                error(("IndexMismatch $%*"):format(v117), 2)
            end
            if v112 < v114 then
                local v118 = ("[%*]"):format(v114)
                error(("IndexOverflow $%*"):format(v118), 2)
            end
            if v111[v116] then
                local v119 = ("[%*]"):format(v114)
                error(("UniqueArray $%*"):format(v119), 2)
            end
            v111[v116] = true
            if not v111[v116] then
                local v120 = ("[%*]"):format(v114)
                error(("InvalidKey $%*"):format(v120), 2)
            end
            local v121, v122 = pcall(v109, v116)
            if not v121 then
                local v123 = tostring(v122)
                local v124, v125 = string.match(v123, "^(.*:%d+): (.+)$")
                local v126 = v124 and v125 or v123
                local v127, v128 = string.match(v126, "^(.+) $(%[.+)$")
                if not (v127 and v128) then
                    v127 = v126
                end
                local v129 = ("[%*]%*"):format(v114, v128 or "")
                error(("%* $%*"):format(v127, v129), 2)
            end
            v113[v115] = v122
        end
        if v112 ~= v114 then
            error("LengthMismatch", 2)
        end
        return v113
    end
end

function v35.Map(v130, v131, v132) -- line 353 | captures: SafeKeyStringRep, v35
    v35.Function(v130)
    v35.Function(v131)
    v35.Optional(v35.IntegerPositive)(v132)
    local v133 = v132 or (1/0)
    return function(v134) -- line 359 | captures: v130, v131, v133, SafeKeyStringRep
        if type(v134) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v134) ~= nil then
            error("metatable", 2)
        end
        local v135 = 0
        for v136, v137 in pairs(v134) do
            v135 += 1
            if v133 < v135 then
                local v138 = ("LengthLimit(%*)"):format(v133)
                error(v138, 2)
            end
            local v139, v140 = pcall(v130, v136)
            if not v139 then
                local v141 = tostring(v140)
                local v142, v143 = string.match(v141, "^(.*:%d+): (.+)$")
                local v144 = v142 and v143 or v141
                local v145, v146 = string.match(v144, "^(.+) $(%[.+)$")
                if not (v145 and v146) then
                    v145 = v144
                end
                local v147 = ("<%*>%*"):format(SafeKeyStringRep(v136), v146 or "")
                error(("%* $%*"):format(v145, v147), 2)
            end
            local v148, v149 = pcall(v131, v137)
            if not v148 then
                local v150 = tostring(v149)
                local v151, v152 = string.match(v150, "^(.*:%d+): (.+)$")
                local v153 = v151 and v152 or v150
                local v154, v155 = string.match(v153, "^(.+) $(%[.+)$")
                if not (v154 and v155) then
                    v154 = v153
                end
                local v156 = ("[%*]%*"):format(SafeKeyStringRep(v136), v155 or "")
                error(("%* $%*"):format(v154, v156), 2)
            end
        end
        return v134
    end
end

function v35.MapCoerce(v157, v158, v159) -- line 410 | captures: SafeKeyStringRep, v35
    v35.Function(v157)
    v35.Function(v158)
    v35.Optional(v35.IntegerPositive)(v159)
    local v160 = v159 or (1/0)
    return function(v161) -- line 416 | captures: v157, v158, v160, SafeKeyStringRep
        if type(v161) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v161) ~= nil then
            error("metatable", 2)
        end
        local v162 = {}
        local v163 = 0
        for v164, v165 in pairs(v161) do
            v163 += 1
            if v160 < v163 then
                local v166 = ("LengthLimit(%*)"):format(v160)
                error(v166, 2)
            end
            local v167, v168 = pcall(v157, v164)
            if not v167 then
                local v169 = tostring(v168)
                local v170, v171 = string.match(v169, "^(.*:%d+): (.+)$")
                local v172 = v170 and v171 or v169
                local v173, v174 = string.match(v172, "^(.+) $(%[.+)$")
                if not (v173 and v174) then
                    v173 = v172
                end
                local v175 = ("<%*>%*"):format(SafeKeyStringRep(v164), v174 or "")
                error(("%* $%*"):format(v173, v175), 2)
            end
            local v176, v177 = pcall(v158, v165)
            if not v176 then
                local v178 = tostring(v177)
                local v179, v180 = string.match(v178, "^(.*:%d+): (.+)$")
                local v181 = v179 and v180 or v178
                local v182, v183 = string.match(v181, "^(.+) $(%[.+)$")
                if not (v182 and v183) then
                    v182 = v181
                end
                local v184 = ("[%*]%*"):format(SafeKeyStringRep(v164), v183 or "")
                error(("%* $%*"):format(v182, v184), 2)
            end
            v162[v168] = v177
        end
        return v162
    end
end

function v35.Table(v185) -- line 469 | captures: SafeKeyStringRep, v35
    v35.NoMetatable(v185)
    for v186, v187 in pairs(v185) do
        v35.Function(v187)
    end
    local v188 = table.clone(v185)
    return function(v189) -- line 475 | captures: v188, SafeKeyStringRep
        if type(v189) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v189) ~= nil then
            error("metatable", 2)
        end
        if rawlen(v188) ~= rawlen(v189) then
            error("LengthMismatch", 2)
        end
        for v190, v191 in pairs(v189) do
            if not v188[v190] then
                local v192 = ("[%*]"):format((SafeKeyStringRep(v190)))
                error(("UnknownKey $%*"):format(v192), 2)
            end
        end
        for v193, v194 in pairs(v188) do
            local v195, v196 = pcall(v194, v189[v193])
            if not v195 then
                local v197 = tostring(v196)
                local v198, v199 = string.match(v197, "^(.*:%d+): (.+)$")
                local v200 = v198 and v199 or v197
                local v201, v202 = string.match(v200, "^(.+) $(%[.+)$")
                if not (v201 and v202) then
                    v201 = v200
                end
                local v203
                if type(v193) == "string" then
                    v203 = string.format("%q", v193):gsub("\n", "n")
                elseif typeof(v193) == "Instance" then
                    v203 = v193:GetFullName()
                else
                    v203 = tostring(v193)
                end
                local v204 = ("[%*]%*"):format(v203, v202 or "")
                error(("%* $%*"):format(v201, v204), 2)
            end
        end
        return v189
    end
end

function v35.TablePermissive(v205) -- line 523 | captures: v35
    v35.NoMetatable(v205)
    for v206, v207 in pairs(v205) do
        v35.Function(v207)
    end
    local v208 = table.clone(v205)
    return function(v209) -- line 529 | captures: v208
        if type(v209) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v209) ~= nil then
            error("metatable", 2)
        end
        if rawlen(v208) ~= rawlen(v209) then
            error("LengthMismatch", 2)
        end
        for v210, v211 in pairs(v208) do
            local v212, v213 = pcall(v211, v209[v210])
            if not v212 then
                local v214 = tostring(v213)
                local v215, v216 = string.match(v214, "^(.*:%d+): (.+)$")
                local v217 = v215 and v216 or v214
                local v218, v219 = string.match(v217, "^(.+) $(%[.+)$")
                if not (v218 and v219) then
                    v218 = v217
                end
                local v220
                if type(v210) == "string" then
                    v220 = string.format("%q", v210):gsub("\n", "n")
                elseif typeof(v210) == "Instance" then
                    v220 = v210:GetFullName()
                else
                    v220 = tostring(v210)
                end
                local v221 = ("[%*]%*"):format(v220, v219 or "")
                error(("%* $%*"):format(v218, v221), 2)
            end
        end
        return v209
    end
end

function v35.TableCoerce(v222) -- line 571 | captures: SafeKeyStringRep, v35
    v35.NoMetatable(v222)
    for v223, v224 in pairs(v222) do
        v35.Function(v224)
    end
    local v225 = table.clone(v222)
    return function(v226) -- line 577 | captures: v225, SafeKeyStringRep
        if type(v226) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v226) ~= nil then
            error("metatable", 2)
        end
        if rawlen(v225) ~= rawlen(v226) then
            error("LengthMismatch", 2)
        end
        local v227 = {}
        for v228, v229 in pairs(v226) do
            if not v225[v228] then
                local v230 = ("[%*]"):format((SafeKeyStringRep(v228)))
                error(("UnknownKey $%*"):format(v230), 2)
            end
        end
        for v231, v232 in pairs(v225) do
            local v233, v234 = pcall(v232, v226[v231])
            if not v233 then
                local v235 = tostring(v234)
                local v236, v237 = string.match(v235, "^(.*:%d+): (.+)$")
                local v238 = v236 and v237 or v235
                local v239, v240 = string.match(v238, "^(.+) $(%[.+)$")
                if not (v239 and v240) then
                    v239 = v238
                end
                local v241
                if type(v231) == "string" then
                    v241 = string.format("%q", v231):gsub("\n", "n")
                elseif typeof(v231) == "Instance" then
                    v241 = v231:GetFullName()
                else
                    v241 = tostring(v231)
                end
                local v242 = ("[%*]%*"):format(v241, v240 or "")
                error(("%* $%*"):format(v239, v242), 2)
            end
            v227[v231] = v234
        end
        return v227
    end
end

local function IsASCII_2(v243) -- line 627
    if type(v243) == "string" then
        local v244 = string.len(v243)
        for v245 = 1, v244 do
            local v246 = string.byte(v243, v245)
            if not (v246 >= 32 and v246 <= 126) then
                return false
            end
        end
        return true
    end
    return false
end

v35.IsASCII = IsASCII_2

local function IsFinite_2(v247) -- line 644
    if type(v247) == "number" and v247 == v247 then
        if v247 == (1/0) then
            return false
        end
        return v247 ~= (-1/0)
    end
    return false
end

v35.IsFinite = IsFinite_2

local function IsInteger_2(v248) -- line 648
    if type(v248) == "number" and math.floor(v248) == v248 then
        if v248 == (1/0) then
            return false
        end
        return v248 ~= (-1/0)
    end
    return false
end

v35.IsInteger = IsInteger_2

local function IsCFrameFinite(v249) -- line 652
    if typeof(v249) == "CFrame" then
        local v250, v251, v252, v253, v254, v255, v256, v257, v258, v259, v260, v261 = v249:GetComponents()
        local v262 = v250 + v251 + v252 + v253 + v254 + v255 + v256 + v257 + v258 + v259 + v260 + v261
        if v262 == v262 then
            if v262 == (1/0) then
                return false
            end
            return v262 ~= (-1/0)
        end
    end
    return false
end

v35.IsCFrameFinite = IsCFrameFinite

local function IsVector2Finite(v263) -- line 662
    if typeof(v263) == "Vector2" then
        local v264 = v263.X + v263.Y
        if v264 == v264 then
            if v264 == (1/0) then
                return false
            end
            return v264 ~= (-1/0)
        end
    end
    return false
end

v35.IsVector2Finite = IsVector2Finite

local function Optional(v265) -- line 670
    if type(v265) ~= "function" then
        error("function", 2)
    end
    return function(v266) -- line 674 | captures: v265
        if v266 == nil then
            return nil
        end
        local v267, v268 = pcall(v265, v266)
        if not v267 then
            local v269 = tostring(v268)
            local v270, v271 = string.match(v269, "^(.*:%d+): (.+)$")
            local v272 = v270 and v271 or v269
            error(v272, 2)
        end
        return v268
    end
end

v35.Optional = Optional

local function Default(v273, v274) -- line 692
    if type(v273) ~= "function" then
        error("function", 2)
    end
    local v275 = v273(v274)
    return function(v276) -- line 697 | captures: v273, v275
        if v276 == nil then
            return v275
        end
        local v277, v278 = pcall(v273, v276)
        if not v277 then
            local v279 = tostring(v278)
            local v280, v281 = string.match(v279, "^(.*:%d+): (.+)$")
            local v282 = v280 and v281 or v279
            error(v282, 2)
        end
        return v278
    end
end

v35.Default = Default

local function AnyOf(...) -- line 715
    local v283 = table.pack(...)
    local n = v283.n
    for v284 = 1, n do
        local v285 = v283[v284]
        local v286 = type(v285) == "function"
        assert(v286, "function")
    end
    local v287 = v283.n > 0
    assert(v287)
    return function(v288) -- line 726 | captures: v283
        local n = v283.n
        for v289 = 1, n do
            local v290, v291 = pcall(v283[v289], v288)
            if v290 then
                return v291
            end
        end
        error("AnyOf", 2)
    end
end

v35.AnyOf = AnyOf

local function AllOf(...) -- line 739
    local v292 = table.pack(...)
    local n = v292.n
    for v293 = 1, n do
        local v294 = v292[v293]
        local v295 = type(v294) == "function"
        assert(v295, "function")
    end
    local v296 = v292.n > 0
    assert(v296)
    return function(v297) -- line 750 | captures: v292
        local n = v292.n
        for v298 = 1, n do
            local v299, v300 = pcall(v292[v298], v297)
            if not v299 then
                local v301 = tostring(v300)
                local v302, v303 = string.match(v301, "^(.*:%d+): (.+)$")
                local v304 = v302 and v303 or v301
                error(v304, 2)
            end
        end
        return v297
    end
end

v35.AllOf = AllOf

local function AnyTable(v305) -- line 769
    if type(v305) ~= "table" then
        error("table", 2)
    end
    return v305
end

v35.AnyTable = AnyTable

local function Number(v306) -- line 775
    if type(v306) ~= "number" then
        error("number", 2)
    end
    return v306
end

v35.Number = Number

local function Boolean(v307) -- line 781
    if type(v307) ~= "boolean" then
        error("boolean", 2)
    end
    return v307
end

v35.Boolean = Boolean

local function Buffer(v308) -- line 787
    if type(v308) ~= "buffer" then
        error("buffer", 2)
    end
    return v308
end

v35.Buffer = Buffer

local function Function(v309) -- line 793
    if type(v309) ~= "function" then
        error("function", 2)
    end
    return v309
end

v35.Function = Function

local function Thread(v310) -- line 799
    if type(v310) ~= "thread" then
        error("thread", 2)
    end
    return v310
end

v35.Thread = Thread

local function String(v311) -- line 805
    if type(v311) ~= "string" then
        error("string", 2)
    end
    if not utf8.len(v311) then
        error("UTF8", 2)
    end
    return v311
end

v35.String = String

local function RawString(v312) -- line 814
    if type(v312) ~= "string" then
        error("string", 2)
    end
    return v312
end

v35.RawString = RawString

local function Any(v313) -- line 820
    return v313
end

v35.Any = Any

local function Equals(v314) -- line 823
    return function(v315) -- line 824 | captures: v314
        if not (rawequal(v315, v314) or type(v315) == "number" and type(v314) == "number" and v315 ~= v315 and v314 ~= v314) then
            error("Equals", 2)
        end
        return v315
    end
end

v35.Equals = Equals

function v35.Set(v316) -- line 844 | captures: v35
    v35.Array(v35.Any)
    local v317 = {}
    for v318, v319 in ipairs(v316) do
        if v319 ~= v319 then
            error("InvalidKeyNaN", 2)
        end
        v317[v319] = true
        if not v317[v319] then
            error("InvalidKey", 2)
        end
    end
    return function(v320) -- line 856 | captures: v317
        if not v317[v320] then
            error("Set", 2)
        end
        return v320
    end
end

function v35.Pattern(v321) -- line 863 | captures: v35
    v35.String(v321)
    return function(v322) -- line 865 | captures: v321
        if type(v322) ~= "string" then
            error("string", 2)
        end
        if not utf8.len(v322) then
            error("UTF8", 2)
        end
        if not string.find(v322, v321) then
            error("Pattern", 2)
        end
        return v322
    end
end

local function NoMetatable(v323) -- line 878
    if type(v323) ~= "table" then
        error("table", 2)
    end
    if getmetatable(v323) ~= nil then
        error("metatable", 2)
    end
    return v323
end

v35.NoMetatable = NoMetatable

local function Finite(v324) -- line 887
    if type(v324) ~= "number" then
        error("number", 2)
    end
    if not (v324 == v324 and v324 ~= (1/0) and v324 ~= (-1/0)) then
        error("Finite", 2)
    end
    return v324
end

v35.Finite = Finite

local function FinitePositive(v325) -- line 897
    if type(v325) ~= "number" then
        error("number", 2)
    end
    if not (v325 == v325 and v325 ~= (1/0) and v325 ~= (-1/0)) then
        error("Finite", 2)
    end
    if v325 <= 0 then
        error("Positive", 2)
    end
    return v325
end

v35.FinitePositive = FinitePositive

local function FiniteNonNegative(v326) -- line 910
    if type(v326) ~= "number" then
        error("number", 2)
    end
    if not (v326 == v326 and v326 ~= (1/0) and v326 ~= (-1/0)) then
        error("Finite", 2)
    end
    if v326 < 0 then
        error("NonNegative", 2)
    end
    return v326
end

v35.FiniteNonNegative = FiniteNonNegative

local function Positive(v327) -- line 923
    if type(v327) ~= "number" then
        error("number", 2)
    end
    if v327 <= 0 then
        error("Positive", 2)
    end
    return v327
end

v35.Positive = Positive

local function NonNegative(v328) -- line 932
    if type(v328) ~= "number" then
        error("number", 2)
    end
    if v328 < 0 then
        error("NonNegative", 2)
    end
    return v328
end

v35.NonNegative = NonNegative

local function Real(v329) -- line 941
    if type(v329) ~= "number" then
        error("number", 2)
    end
    if v329 ~= v329 then
        error("Real", 2)
    end
    return v329
end

v35.Real = Real

function v35.Range(v330, v331) -- line 950 | captures: v35
    v35.Real(v330)
    v35.Real(v331)
    if v331 < v330 then
        error("a<=b", 2)
    end
    return function(v332) -- line 956 | captures: v330, v331
        if type(v332) ~= "number" then
            error("number", 2)
        end
        if v332 < v330 then
            local v333 = ("Range(%*,%*)"):format(v330, v331)
            error(v333, 2)
        elseif v331 < v332 then
            local v334 = ("Range(%*,%*)"):format(v330, v331)
            error(v334, 2)
        end
        return v332
    end
end

local function Integer(v335) -- line 971
    if type(v335) ~= "number" then
        error("number", 2)
    end
    if not (math.floor(v335) == v335 and v335 ~= (1/0) and v335 ~= (-1/0)) then
        error("Integer", 2)
    end
    return v335
end

v35.Integer = Integer

local function Unsigned32(v336) -- line 981
    if bit32.bor(v336, 0) ~= v336 then
        error("Unsigned32", 2)
    end
    return v336
end

v35.Unsigned32 = Unsigned32

local function IntegerPositive(v337) -- line 987
    if type(v337) ~= "number" then
        error("number", 2)
    end
    if not (math.floor(v337) == v337 and v337 ~= (1/0) and v337 ~= (-1/0)) then
        error("Integer", 2)
    end
    if v337 < 1 then
        error("Positive", 2)
    end
    return v337
end

v35.IntegerPositive = IntegerPositive

local function Index(v338) -- line 1000
    if type(v338) ~= "number" then
        error("number", 2)
    end
    if not (math.floor(v338) == v338 and v338 ~= (1/0) and v338 ~= (-1/0)) then
        error("Integer", 2)
    end
    if v338 < 1 then
        error("Positive", 2)
    end
    return v338
end

v35.Index = Index

local function IntegerNonNegative(v339) -- line 1013
    if type(v339) ~= "number" then
        error("number", 2)
    end
    if not (math.floor(v339) == v339 and v339 ~= (1/0) and v339 ~= (-1/0)) then
        error("Integer", 2)
    end
    if v339 < 0 then
        error("NonNegative", 2)
    end
    return v339
end

v35.IntegerNonNegative = IntegerNonNegative

function v35.IntegerRange(v340, v341) -- line 1026 | captures: v35
    v35.Integer(v340)
    v35.Integer(v341)
    if v341 < v340 then
        error("a<=b", 2)
    end
    return function(v342) -- line 1032 | captures: v340, v341
        if type(v342) ~= "number" then
            error("number", 2)
        end
        if not (math.floor(v342) == v342 and v342 ~= (1/0) and v342 ~= (-1/0)) then
            error("Integer", 2)
        end
        if v342 < v340 then
            local v343 = ("Range(%*,%*)"):format(v340, v341)
            error(v343, 2)
        elseif v341 < v342 then
            local v344 = ("Range(%*,%*)"):format(v340, v341)
            error(v344, 2)
        end
        return v342
    end
end

local function UInt32() -- line 1051
    return function(v345) -- line 1052
        if type(v345) ~= "number" then
            error("number", 2)
        end
        if bit32.bor(v345, 0) ~= v345 then
            error("UInt32", 2)
        end
        return v345
    end
end

v35.UInt32 = UInt32

function v35.StringRange(v346, v347) -- line 1062 | captures: v35
    v35.Integer(v346)
    v35.Integer(v347)
    if v347 < v346 then
        error("a<=b", 2)
    end
    return function(v348) -- line 1068 | captures: v346, v347
        if type(v348) ~= "string" then
            error("string", 2)
        end
        local v349 = utf8.len(v348)
        if not v349 then
            error("UTF8", 2)
        end
        if v349 < v346 then
            local v350 = ("StringRange(%*,%*)"):format(v346, v347)
            error(v350, 2)
        elseif v347 < v349 then
            local v351 = ("StringRange(%*,%*)"):format(v346, v347)
            error(v351, 2)
        end
        return v348
    end
end

local function ASCII(v352) -- line 1087
    if type(v352) ~= "string" then
        error("string", 2)
    end
    local v353 = string.len(v352)
    for v354 = 1, v353 do
        local v355 = string.byte(v352, v354)
        if v355 < 32 then
            error("ASCII", 2)
        elseif v355 <= 126 then
        end
    end
    return v352
end

v35.ASCII = ASCII

function v35.ASCIIRange(v356, v357) -- line 1104 | captures: v35
    v35.Integer(v356)
    v35.Integer(v357)
    if v357 < v356 then
        error("a<=b", 2)
    end
    return function(v358) -- line 1110 | captures: v356, v357
        if type(v358) ~= "string" then
            error("string", 2)
        end
        local v359 = string.len(v358)
        if v359 < v356 then
            local v360 = ("ASCIIRange(%*,%*)"):format(v356, v357)
            error(v360, 2)
        elseif v359 <= v357 then
        end
        for v361 = 1, v359 do
            local v362 = string.byte(v358, v361)
            if v362 < 32 then
                error("ASCII", 2)
            elseif v362 <= 126 then
            end
        end
        return v358
    end
end

local function CFrame(v363) -- line 1134
    if typeof(v363) ~= "CFrame" then
        error("CFrame", 2)
    end
    return v363
end

v35.CFrame = CFrame

local function CFrameFinite(v364) -- line 1140
    if typeof(v364) ~= "CFrame" then
        error("CFrame", 2)
    end
    local v365, v366, v367, v368, v369, v370, v371, v372, v373, v374, v375, v376 = v364:GetComponents()
    local v377 = v365 + v366 + v367 + v368 + v369 + v370 + v371 + v372 + v373 + v374 + v375 + v376
    if not (v377 == v377 and v377 ~= (1/0) and v377 ~= (-1/0)) then
        error("CFrameFinite", 2)
    end
    return v364
end

v35.CFrameFinite = CFrameFinite

local function Vector2(v378) -- line 1153
    if typeof(v378) ~= "Vector2" then
        error("Vector2", 2)
    end
    return v378
end

v35.Vector2 = Vector2

local function Vector2Finite(v379) -- line 1159
    if typeof(v379) ~= "Vector2" then
        error("Vector2", 2)
    end
    local v380 = v379.X + v379.Y
    if not (v380 == v380 and v380 ~= (1/0) and v380 ~= (-1/0)) then
        error("Vector2Finite", 2)
    end
    return v379
end

v35.Vector2Finite = Vector2Finite

local function Vector2Unit(v381) -- line 1170
    if typeof(v381) ~= "Vector2" then
        error("Vector2", 2)
    end
    local v382 = v381.X + v381.Y
    if not (v382 == v382 and v382 ~= (1/0) and v382 ~= (-1/0)) then
        error("Vector2Finite", 2)
    end
    local v383 = v381.Magnitude - 1
    if math.abs(v383) > 0.000001 then
        error("Vector2Unit", 2)
    end
    return v381
end

v35.Vector2Unit = Vector2Unit

local function Vector3(v384) -- line 1185
    if typeof(v384) ~= "Vector3" then
        error("Vector3", 2)
    end
    return v384
end

v35.Vector3 = Vector3

local function Vector3Finite(v385) -- line 1191
    if typeof(v385) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v386 = v385.X + v385.Y + v385.Z
    if not (v386 == v386 and v386 ~= (1/0) and v386 ~= (-1/0)) then
        error("Vector3Finite", 2)
    end
    return v385
end

v35.Vector3Finite = Vector3Finite

local function Vector3Unit(v387) -- line 1202
    if typeof(v387) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v388 = v387.X + v387.Y + v387.Z
    if not (v388 == v388 and v388 ~= (1/0) and v388 ~= (-1/0)) then
        error("Vector3Finite", 2)
    end
    local v389 = v387.Magnitude - 1
    if math.abs(v389) > 0.000001 then
        error("Vector3Unit", 2)
    end
    return v387
end

v35.Vector3Unit = Vector3Unit

local function Vector3Positive(v390) -- line 1217
    if typeof(v390) ~= "Vector3" then
        error("Vector3", 2)
    end
    local v391 = v390.X + v390.Y + v390.Z
    if not (v391 == v391 and v391 ~= (1/0) and v391 ~= (-1/0)) then
        error("Vector3Finite", 2)
    end
    if v390.X <= 0 or v390.Y <= 0 or v390.Z <= 0 then
        error("Vector3Positive")
    end
    return v390
end

v35.Vector3Positive = Vector3Positive

local function Vector3int16(v392) -- line 1235
    if typeof(v392) ~= "Vector3int16" then
        error("Vector3int16", 2)
    end
    return v392
end

v35.Vector3int16 = Vector3int16

local function Vector2int16(v393) -- line 1241
    if typeof(v393) ~= "Vector2int16" then
        error("Vector2int16", 2)
    end
    return v393
end

v35.Vector2int16 = Vector2int16

local function Region3(v394) -- line 1247
    if typeof(v394) ~= "Region3" then
        error("Region3", 2)
    end
    return v394
end

v35.Region3 = Region3

local function Region3int16(v395) -- line 1253
    if typeof(v395) ~= "Region3int16" then
        error("Region3int16", 2)
    end
    return v395
end

v35.Region3int16 = Region3int16

local function UDim(v396) -- line 1259
    if typeof(v396) ~= "UDim" then
        error("UDim", 2)
    end
    return v396
end

v35.UDim = UDim

local function UDim2(v397) -- line 1265
    if typeof(v397) ~= "UDim2" then
        error("UDim2", 2)
    end
    return v397
end

v35.UDim2 = UDim2

local function Rect(v398) -- line 1271
    if typeof(v398) ~= "Rect" then
        error("Rect", 2)
    end
    return v398
end

v35.Rect = Rect

local function PhysicalProperties(v399) -- line 1277
    if typeof(v399) ~= "PhysicalProperties" then
        error("PhysicalProperties", 2)
    end
    return v399
end

v35.PhysicalProperties = PhysicalProperties

function v35.Storable(v400, v401) -- line 1283 | captures: SafeKeyStringRep, v35
    if type(v400) ~= "boolean" and type(v400) ~= "number" then
        if type(v400) == "string" then
            if not utf8.len(v400) then
                error("UTF8", 2)
            end
        elseif type(v400) ~= "buffer" then
            if type(v400) == "table" then
                if type(v400) ~= "table" then
                    error("table", 2)
                end
                if getmetatable(v400) ~= nil then
                    error("metatable", 2)
                end
                local v402 = v401 or {}
                if v402[v400] then
                    error("Loop", 2)
                end
                v402[v400] = true
                local v403 = rawlen(v400)
                if v403 <= 0 then
                    for v404, v405 in pairs(v400) do
                        if type(v404) ~= "string" then
                            local v406 = ("[%*]"):format((SafeKeyStringRep(v404)))
                            error(("KeyString $%*"):format(v406), 2)
                        end
                        if not utf8.len(v404) then
                            local v407 = ("[%*]"):format((SafeKeyStringRep(v404)))
                            error(("KeyUTF8 $%*"):format(v407), 2)
                        end
                        local v408, v409 = pcall(v35.Storable, v405, v402)
                        if not v408 then
                            local v410 = tostring(v409)
                            local v411, v412 = string.match(v410, "^(.*:%d+): (.+)$")
                            local v413 = v411 and v412 or v410
                            local v414, v415 = string.match(v413, "^(.+) $(%[.+)$")
                            if not (v414 and v415) then
                                v414 = v413
                            end
                            local v416 = ("[%*]%*"):format(SafeKeyStringRep(v404), v415 or "")
                            error(("%* $%*"):format(v414, v416), 2)
                        end
                    end
                else
                    local v417 = 0
                    for v418, v419 in pairs(v400) do
                        v417 += 1
                        if v418 ~= v417 then
                            local v420 = ("[%*]"):format((SafeKeyStringRep(v418)))
                            error(("IndexMismatch $%*"):format(v420), 2)
                        end
                        if v403 < v417 then
                            local v421 = ("[%*]"):format(v417)
                            error(("IndexOverflow $%*"):format(v421), 2)
                        end
                        local v422, v423 = pcall(v35.Storable, v419, v402)
                        if not v422 then
                            local v424 = tostring(v423)
                            local v425, v426 = string.match(v424, "^(.*:%d+): (.+)$")
                            local v427 = v425 and v426 or v424
                            local v428, v429 = string.match(v427, "^(.+) $(%[.+)$")
                            if not (v428 and v429) then
                                v428 = v427
                            end
                            local v430 = ("[%*]%*"):format(v417, v429 or "")
                            error(("%* $%*"):format(v428, v430), 2)
                        end
                    end
                    if v403 ~= v417 then
                        error("LengthMismatch", 2)
                    end
                end
            else
                error("Storable", 2)
            end
        end
    end
    return v400
end

local v431 = {
    boolean = true,
    number = true,
    string = true,
    buffer = true,
    Color3 = true,
    Instance = true,
    NumberRange = true,
    Rect = true,
    Region3 = true,
    Region3int16 = true,
    UDim = true,
    UDim2 = true,
    CFrame = true,
    Vector2 = true,
    Vector2int16 = true,
    Vector3 = true,
    Vector3int16 = true,
    EnumItem = true
}
table.freeze(v431)

function v35.Networkable(v432, v433) -- line 1402 | captures: SafeKeyStringRep, v35, v431
    if type(v432) == "string" then
        if not utf8.len(v432) then
            error("UTF8", 2)
        end
    elseif type(v432) == "table" then
        if type(v432) ~= "table" then
            error("table", 2)
        end
        if getmetatable(v432) ~= nil then
            error("metatable", 2)
        end
        local v434 = v433 or {}
        if v434[v432] then
            error("Loop", 2)
        end
        v434[v432] = true
        local v435 = rawlen(v432)
        if v435 <= 0 then
            for v436, v437 in pairs(v432) do
                if type(v436) ~= "string" then
                    local v438 = ("[%*]"):format((SafeKeyStringRep(v436)))
                    error(("KeyString $%*"):format(v438), 2)
                end
                if not utf8.len(v436) then
                    local v439 = ("[%*]"):format((SafeKeyStringRep(v436)))
                    error(("KeyUTF8 $%*"):format(v439), 2)
                end
                local v440, v441 = pcall(v35.Networkable, v437, v434)
                if not v440 then
                    local v442 = tostring(v441)
                    local v443, v444 = string.match(v442, "^(.*:%d+): (.+)$")
                    local v445 = v443 and v444 or v442
                    local v446, v447 = string.match(v445, "^(.+) $(%[.+)$")
                    if not (v446 and v447) then
                        v446 = v445
                    end
                    local v448 = ("[%*]%*"):format(SafeKeyStringRep(v436), v447 or "")
                    error(("%* $%*"):format(v446, v448), 2)
                end
            end
        else
            local v449 = 0
            for v450, v451 in pairs(v432) do
                v449 += 1
                if v450 ~= v449 then
                    local v452 = ("[%*]"):format((SafeKeyStringRep(v450)))
                    error(("IndexMismatch $%*"):format(v452), 2)
                end
                if v435 < v449 then
                    local v453 = ("[%*]"):format(v449)
                    error(("IndexOverflow $%*"):format(v453), 2)
                end
                local v454, v455 = pcall(v35.Networkable, v451, v434)
                if not v454 then
                    local v456 = tostring(v455)
                    local v457, v458 = string.match(v456, "^(.*:%d+): (.+)$")
                    local v459 = v457 and v458 or v456
                    local v460, v461 = string.match(v459, "^(.+) $(%[.+)$")
                    if not (v460 and v461) then
                        v460 = v459
                    end
                    local v462 = ("[%*]%*"):format(v449, v461 or "")
                    error(("%* $%*"):format(v460, v462), 2)
                end
            end
            if v435 ~= v449 then
                error("LengthMismatch", 2)
            end
        end
    elseif not v431[typeof(v432)] then
        error("Networkable", 2)
    end
    return v432
end

local function Enum(v463) -- line 1499
    if typeof(v463) ~= "Enum" then
        error("Enum", 2)
    end
    return function(v464) -- line 1503 | captures: v463
        if typeof(v464) ~= "EnumItem" then
            error("EnumItem", 2)
        end
        if v464.EnumType ~= v463 then
            local v465 = tostring(v463)
            error(v465, 2)
        end
        return v464
    end
end

v35.Enum = Enum

local function EnumValue(v466) -- line 1514
    if typeof(v466) ~= "Enum" then
        error("Enum", 2)
    end
    local v467 = {}
    for v468, v469 in ipairs(v466:GetEnumItems()) do
        v467[v469.Value] = v469
    end
    return function(v470) -- line 1522 | captures: v467
        if typeof(v470) ~= "number" then
            error("number", 2)
        end
        if not v467[v470] then
            error("EnumValue", 2)
        end
        return v470
    end
end

v35.EnumValue = EnumValue

local function Player(v471) -- line 1532
    if typeof(v471) == "Instance" then
        if not v471:IsA("Player") then
            error("Player", 2)
        end
    else
        error("Player", 2)
    end
    return v471
end

v35.Player = Player

local function BasePart(v472) -- line 1540
    if typeof(v472) == "Instance" then
        if not v472:IsA("BasePart") then
            error("BasePart", 2)
        end
    else
        error("BasePart", 2)
    end
    return v472
end

v35.BasePart = BasePart

local function Part(v473) -- line 1548
    if typeof(v473) == "Instance" then
        if not v473:IsA("Part") then
            error("Part", 2)
        end
    else
        error("Part", 2)
    end
    return v473
end

v35.Part = Part

local function MeshPart(v474) -- line 1556
    if typeof(v474) == "Instance" then
        if not v474:IsA("MeshPart") then
            error("MeshPart", 2)
        end
    else
        error("MeshPart", 2)
    end
    return v474
end

v35.MeshPart = MeshPart

local function Model(v475) -- line 1564
    if typeof(v475) == "Instance" then
        if not v475:IsA("Model") then
            error("Model", 2)
        end
    else
        error("Model", 2)
    end
    return v475
end

v35.Model = Model

local function Animation(v476) -- line 1572
    if typeof(v476) == "Instance" then
        if not v476:IsA("Animation") then
            error("Animation", 2)
        end
    else
        error("Animation", 2)
    end
    return v476
end

v35.Animation = Animation

local function Humanoid(v477) -- line 1580
    if typeof(v477) == "Instance" then
        if not v477:IsA("Humanoid") then
            error("Humanoid", 2)
        end
    else
        error("Humanoid", 2)
    end
    return v477
end

v35.Humanoid = Humanoid

local function ParticleEmitter(v478) -- line 1588
    if typeof(v478) == "Instance" then
        if not v478:IsA("ParticleEmitter") then
            error("ParticleEmitter", 2)
        end
    else
        error("ParticleEmitter", 2)
    end
    return v478
end

v35.ParticleEmitter = ParticleEmitter

local function Sound(v479) -- line 1596
    if typeof(v479) == "Instance" then
        if not v479:IsA("Sound") then
            error("Sound", 2)
        end
    else
        error("Sound", 2)
    end
    return v479
end

v35.Sound = Sound

local function Instance(v480) -- line 1604
    if typeof(v480) ~= "Instance" then
        error("Instance", 2)
    end
    return v480
end

v35.Instance = Instance

function v35.InstanceOf(v481) -- line 1610 | captures: v35
    v35.String(v481)
    return function(v482) -- line 1612 | captures: v481
        if typeof(v482) ~= "Instance" then
            error("Instance", 2)
        end
        if not v482:IsA(v481) then
            error(v481, 2)
        end
        return v482
    end
end

function v35.InstanceClass(v483) -- line 1622 | captures: v35
    v35.String(v483)
    return function(v484) -- line 1624 | captures: v483
        if typeof(v484) ~= "Instance" then
            error("Instance", 2)
        end
        if v484.ClassName ~= v483 then
            error(v483, 2)
        end
        return v484
    end
end

local function HexLower(v485) -- line 1634
    if type(v485) ~= "string" then
        error("string", 2)
    end
    local v486 = string.len(v485)
    for v487 = 1, v486 do
        local v488 = string.byte(v485, v487)
        if v488 < 48 then
            if v488 < 97 then
                error("HexLower", 2)
            elseif v488 <= 102 then
            end
        elseif v488 <= 57 then
        end
    end
    return v485
end

v35.HexLower = HexLower

local function HexUpper(v489) -- line 1654
    if type(v489) ~= "string" then
        error("string", 2)
    end
    local v490 = string.len(v489)
    for v491 = 1, v490 do
        local v492 = string.byte(v489, v491)
        if v492 < 48 then
            if v492 < 65 then
                error("HexUpper", 2)
            elseif v492 <= 70 then
            end
        elseif v492 <= 57 then
        end
    end
    return v489
end

v35.HexUpper = HexUpper

local function UUIDStripped(v493) -- line 1674
    if type(v493) ~= "string" then
        error("string", 2)
    end
    local v494 = string.len(v493)
    if v494 ~= 32 then
        error("Length32", 2)
    end
    for v495 = 1, v494 do
        local v496 = string.byte(v493, v495)
        if v496 < 48 then
            if v496 < 97 then
                error("HexLower", 2)
            elseif v496 <= 102 then
            end
        elseif v496 <= 57 then
        end
    end
    return v493
end

v35.UUIDStripped = UUIDStripped

local function UUID(v497) -- line 1698
    if type(v497) ~= "string" then
        error("string", 2)
    end
    if string.len(v497) ~= 36 then
        error("Length36", 2)
    end
    if not v497:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2)
    end
    return v497
end

v35.UUID = UUID

local function Base64(v498) -- line 1710
    if type(v498) ~= "string" then
        error("string", 2)
    end
    if string.len(v498) % 4 ~= 0 then
        error("Base64Length", 2)
    end
    if string.match(v498, "^[A-Za-z0-9+/]*=?=?$") then
        if string.match(v498, "[^=]=+[^=]") then
            error("Base64", 2)
        end
    else
        error("Base64", 2)
    end
    return v498
end

v35.Base64 = Base64

local function ToNumber(v499) -- line 1724
    return function(v500) -- line 1725 | captures: v499
        local v501 = tonumber(v500)
        if not v501 then
            error("tonumber", 2)
        end
        local v502, v503 = pcall(v499, v501)
        if not v502 then
            local v504 = tostring(v503)
            local v505, v506 = string.match(v504, "^(.*:%d+): (.+)$")
            local v507 = v505 and v506 or v504
            error(v507, 2)
        end
        return v503
    end
end

v35.ToNumber = ToNumber

local function IsoDate(v508) -- line 1744
    if not DateTime.fromIsoDate(v508) then
        error("IsoDate", 2)
    end
    return v508
end

v35.IsoDate = IsoDate
return table.freeze(v35)
