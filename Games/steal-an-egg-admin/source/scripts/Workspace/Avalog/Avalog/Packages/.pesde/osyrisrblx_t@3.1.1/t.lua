-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    type = function(v2) -- type | line 5
        return function(v3) -- line 6 | captures: v2
            local v4 = type(v3)
            if v4 == v2 then
                return true
            end
            return false, string.format("%s expected, got %s", v2, v4)
        end
    end,
    typeof = function(v5) -- typeof | line 16
        return function(v6) -- line 17 | captures: v5
            local v7 = typeof(v6)
            if v7 == v5 then
                return true
            end
            return false, string.format("%s expected, got %s", v5, v7)
        end
    end,
    any = function(v8) -- any | line 34
        if v8 == nil then
            return false, "any expected, got nil"
        end
        return true
    end
}

v1.boolean = v1.typeof("boolean")
v1.buffer = v1.typeof("buffer")
v1.thread = v1.typeof("thread")
v1.callback = v1.typeof("function")
v1["function"] = v1.callback
v1.none = v1.typeof("nil")
v1["nil"] = v1.none
v1.string = v1.typeof("string")
v1.table = v1.typeof("table")
v1.userdata = v1.type("userdata")
v1.vector = v1.type("vector")

local function number(v9) -- line 134
    local v10 = typeof(v9)
    if v10 == "number" then
        if v9 == v9 then
            return true
        end
        return false, "unexpected NaN value"
    end
    return false, string.format("number expected, got %s", v10)
end

v1.number = number

local function nan(v11) -- line 154
    local v12 = typeof(v11)
    if v12 == "number" then
        if v11 == v11 then
            return false, "unexpected non-NaN value"
        end
        return true
    end
    return false, string.format("number expected, got %s", v12)
end

v1.nan = nan
v1.Axes = v1.typeof("Axes")
v1.BrickColor = v1.typeof("BrickColor")
v1.CatalogSearchParams = v1.typeof("CatalogSearchParams")
v1.CFrame = v1.typeof("CFrame")
v1.Color3 = v1.typeof("Color3")
v1.ColorSequence = v1.typeof("ColorSequence")
v1.ColorSequenceKeypoint = v1.typeof("ColorSequenceKeypoint")
v1.DateTime = v1.typeof("DateTime")
v1.DockWidgetPluginGuiInfo = v1.typeof("DockWidgetPluginGuiInfo")
v1.Enum = v1.typeof("Enum")
v1.EnumItem = v1.typeof("EnumItem")
v1.Enums = v1.typeof("Enums")
v1.Faces = v1.typeof("Faces")
v1.FloatCurveKey = v1.typeof("FloatCurveKey")
v1.Font = v1.typeof("Font")
v1.Instance = v1.typeof("Instance")
v1.NumberRange = v1.typeof("NumberRange")
v1.NumberSequence = v1.typeof("NumberSequence")
v1.NumberSequenceKeypoint = v1.typeof("NumberSequenceKeypoint")
v1.OverlapParams = v1.typeof("OverlapParams")
v1.PathWaypoint = v1.typeof("PathWaypoint")
v1.PhysicalProperties = v1.typeof("PhysicalProperties")
v1.Random = v1.typeof("Random")
v1.Ray = v1.typeof("Ray")
v1.RaycastParams = v1.typeof("RaycastParams")
v1.RaycastResult = v1.typeof("RaycastResult")
v1.RBXScriptConnection = v1.typeof("RBXScriptConnection")
v1.RBXScriptSignal = v1.typeof("RBXScriptSignal")
v1.Rect = v1.typeof("Rect")
v1.Region3 = v1.typeof("Region3")
v1.Region3int16 = v1.typeof("Region3int16")
v1.TweenInfo = v1.typeof("TweenInfo")
v1.UDim = v1.typeof("UDim")
v1.UDim2 = v1.typeof("UDim2")
v1.Vector2 = v1.typeof("Vector2")
v1.Vector2int16 = v1.typeof("Vector2int16")
v1.Vector3 = v1.typeof("Vector3")
v1.Vector3int16 = v1.typeof("Vector3int16")

function v1.literal(...) -- line 518 | captures: v1
    local v13 = select("#", ...)
    if v13 == 1 then
        local v14 = ...
        return function(v15) -- line 522 | captures: v14
            if v15 == v14 then
                return true
            end
            return false, string.format("expected %s, got %s", tostring(v14), (tostring(v15)))
        end
    end
    local v16 = {}
    for v17 = 1, v13 do
        local v18 = select(v17, ...)
        v16[v17] = v1.literal(v18)
    end
    return v1.union(table.unpack(v16, 1, v13))
end

v1.exactly = v1.literal

function v1.keyOf(v19) -- line 553 | captures: v1
    local v20 = {}
    local v21 = 0
    for v22 in pairs(v19) do
        v21 += 1
        v20[v21] = v22
    end
    return v1.literal(table.unpack(v20, 1, v21))
end

function v1.valueOf(v23) -- line 571 | captures: v1
    local v24 = {}
    local v25 = 0
    for v26, v27 in pairs(v23) do
        v25 += 1
        v24[v25] = v27
    end
    return v1.literal(table.unpack(v24, 1, v25))
end

function v1.integer(v28) -- line 589 | captures: v1
    local v29, v30 = v1.number(v28)
    if v29 then
        if v28 % 1 == 0 then
            return true
        end
        return false, string.format("integer expected, got %s", v28)
    end
    return false, v30 or ""
end

function v1.numberMin(v31) -- line 609 | captures: v1
    return function(v32) -- line 610 | captures: v31, v1
        local v33, v34 = v1.number(v32)
        if v33 then
            if v31 <= v32 then
                return true
            end
            return false, string.format("number >= %s expected, got %s", v31, v32)
        end
        return false, v34 or ""
    end
end

function v1.numberMax(v35) -- line 631 | captures: v1
    return function(v36) -- line 632 | captures: v35, v1
        local v37, v38 = v1.number(v36)
        if v37 then
            if v36 <= v35 then
                return true
            end
            return false, string.format("number <= %s expected, got %s", v35, v36)
        end
        return false, v38
    end
end

function v1.numberMinExclusive(v39) -- line 653 | captures: v1
    return function(v40) -- line 654 | captures: v39, v1
        local v41, v42 = v1.number(v40)
        if v41 then
            if v39 < v40 then
                return true
            end
            return false, string.format("number > %s expected, got %s", v39, v40)
        end
        return false, v42 or ""
    end
end

function v1.numberMaxExclusive(v43) -- line 675 | captures: v1
    return function(v44) -- line 676 | captures: v43, v1
        local v45, v46 = v1.number(v44)
        if v45 then
            if v44 < v43 then
                return true
            end
            return false, string.format("number < %s expected, got %s", v43, v44)
        end
        return false, v46 or ""
    end
end

v1.numberPositive = v1.numberMinExclusive(0)
v1.numberNegative = v1.numberMaxExclusive(0)

function v1.numberConstrained(v47, v48) -- line 712 | captures: v1
    local function v49(...)
        assert(...)
    end

    local function v50(...)
        assert(...)
    end

    v49(v1.number(v47))
    v50(v1.number(v48))
    local v51 = v1.numberMin(v47)
    local v52 = v1.numberMax(v48)
    return function(v53) -- line 718 | captures: v51, v52
        local v54, v55 = v51(v53)
        if v54 then
            local v56, v57 = v52(v53)
            if v56 then
                return true
            end
            return false, v57 or ""
        end
        return false, v55 or ""
    end
end

function v1.numberConstrainedExclusive(v58, v59) -- line 741 | captures: v1
    local function v60(...)
        assert(...)
    end

    local function v61(...)
        assert(...)
    end

    v60(v1.number(v58))
    v61(v1.number(v59))
    local v62 = v1.numberMinExclusive(v58)
    local v63 = v1.numberMaxExclusive(v59)
    return function(v64) -- line 747 | captures: v62, v63
        local v65, v66 = v62(v64)
        if v65 then
            local v67, v68 = v63(v64)
            if v67 then
                return true
            end
            return false, v68 or ""
        end
        return false, v66 or ""
    end
end

function v1.match(v69) -- line 769 | captures: v1
    local function v70(...)
        assert(...)
    end

    v70(v1.string(v69))
    return function(v71) -- line 771 | captures: v69, v1
        local v72, v73 = v1.string(v71)
        if v72 then
            if string.match(v71, v69) == nil then
                return false, string.format("%q failed to match pattern %q", v71, v69)
            end
            return true
        end
        return false, v73
    end
end

function v1.optional(v74) -- line 792 | captures: v1
    local function v75(...)
        assert(...)
    end

    v75(v1.callback(v74))
    return function(v76) -- line 794 | captures: v74
        if v76 == nil then
            return true
        end
        local v77, v78 = v74(v76)
        if v77 then
            return true
        end
        return false, string.format("(optional) %s", v78 or "")
    end
end

local function tuple(...) -- line 815
    local v79 = { ... }
    return function(...) -- line 817 | captures: v79
        local v80 = { ... }
        for v81, v82 in ipairs(v79) do
            local v83, v84 = v82(v80[v81])
            if v83 == false then
                return false, string.format("Bad tuple index #%s:\n\t%s", v81, v84 or "")
            end
        end
        return true
    end
end

v1.tuple = tuple

function v1.keys(v85) -- line 837 | captures: v1
    local function v86(...)
        assert(...)
    end

    v86(v1.callback(v85))
    return function(v87) -- line 839 | captures: v85, v1
        local v88, v89 = v1.table(v87)
        if v88 == false then
            return false, v89 or ""
        end
        for v90 in pairs(v87) do
            local v91, v92 = v85(v90)
            if v91 == false then
                return false, string.format("bad key %s:\n\t%s", tostring(v90), v92 or "")
            end
        end
        return true
    end
end

function v1.values(v93) -- line 863 | captures: v1
    local function v94(...)
        assert(...)
    end

    v94(v1.callback(v93))
    return function(v95) -- line 865 | captures: v93, v1
        local v96, v97 = v1.table(v95)
        if v96 == false then
            return false, v97 or ""
        end
        for v98, v99 in pairs(v95) do
            local v100, v101 = v93(v99)
            if v100 == false then
                return false, string.format("bad value for key %s:\n\t%s", tostring(v98), v101 or "")
            end
        end
        return true
    end
end

function v1.map(v102, v103) -- line 890 | captures: v1
    local function v104(...)
        assert(...)
    end

    local function v105(...)
        assert(...)
    end

    v104(v1.callback(v102))
    v105(v1.callback(v103))
    local v106 = v1.keys(v102)
    local v107 = v1.values(v103)
    return function(v108) -- line 896 | captures: v106, v107
        local v109, v110 = v106(v108)
        if v109 then
            local v111, v112 = v107(v108)
            if v111 then
                return true
            end
            return false, v112 or ""
        end
        return false, v110 or ""
    end
end

function v1.set(v113) -- line 918 | captures: v1
    return v1.map(v113, v1.literal(true))
end

local v114 = v1.keys(v1.integer)

function v1.array(v115) -- line 931 | captures: v1, v114
    local function v116(...)
        assert(...)
    end

    v116(v1.callback(v115))
    local v117 = v1.values(v115)
    return function(v118) -- line 935 | captures: v117, v114
        local v119, v120 = v114(v118)
        if v119 == false then
            return false, string.format("[array] %s", v120 or "")
        end
        local v121 = 0
        for v122 in ipairs(v118) do
            v121 += 1
        end
        for v123 in pairs(v118) do
            if v123 < 1 or v121 < v123 then
                return false, string.format("[array] key %s must be sequential", (tostring(v123)))
            end
        end
        local v124, v125 = v117(v118)
        if v124 then
            return true
        end
        return false, string.format("[array] %s", v125 or "")
    end
end

function v1.strictArray(...) -- line 971 | captures: v1, v114
    local function v126(...)
        assert(...)
    end

    local v127 = { ... }
    v126(v1.array(v1.callback)(v127))
    return function(v128) -- line 975 | captures: v127, v114
        local v129, v130 = v114(v128)
        if v129 == false then
            return false, string.format("[strictArray] %s", v130 or "")
        end
        if #v127 < #v128 then
            return false, string.format("[strictArray] Array size exceeds limit of %d", #v127)
        end
        for v131, v132 in pairs(v127) do
            local v133, v134 = v132(v128[v131])
            if not v133 then
                return false, string.format("[strictArray] Array index #%d - %s", v131, v134)
            end
        end
        return true
    end
end

local v135 = v1.array(v1.callback)

function v1.union(...) -- line 1007 | captures: v135
    local function v136(...)
        assert(...)
    end

    local v137 = { ... }
    v136(v135(v137))
    return function(v138) -- line 1011 | captures: v137
        for v139, v140 in ipairs(v137) do
            if v140(v138) then
                return true
            end
        end
        return false, "bad type for union"
    end
end

v1.some = v1.union

function v1.intersection(...) -- line 1034 | captures: v135
    local function v141(...)
        assert(...)
    end

    local v142 = { ... }
    v141(v135(v142))
    return function(v143) -- line 1038 | captures: v142
        for v144, v145 in ipairs(v142) do
            local v146, v147 = v145(v143)
            if not v146 then
                return false, v147 or ""
            end
        end
        return true
    end
end

v1.every = v1.intersection

local v148 = v1.map(v1.any, v1.callback)

function v1.interface(v149) -- line 1065 | captures: v1, v148
    local function v150(...)
        assert(...)
    end

    v150(v148(v149))
    return function(v151) -- line 1067 | captures: v149, v1
        local v152, v153 = v1.table(v151)
        if v152 == false then
            return false, v153 or ""
        end
        for v154, v155 in pairs(v149) do
            local v156, v157 = v155(v151[v154])
            if v156 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v154), v157 or "")
            end
        end
        return true
    end
end

function v1.strictInterface(v158) -- line 1091 | captures: v1, v148
    local function v159(...)
        assert(...)
    end

    v159(v148(v158))
    return function(v160) -- line 1093 | captures: v158, v1
        local v161, v162 = v1.table(v160)
        if v161 == false then
            return false, v162 or ""
        end
        for v163, v164 in pairs(v158) do
            local v165, v166 = v164(v160[v163])
            if v165 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(v163), v166 or "")
            end
        end
        for v167 in pairs(v160) do
            if not v158[v167] then
                return false, string.format("[interface] unexpected field %q", (tostring(v167)))
            end
        end
        return true
    end
end

function v1.instanceOf(v168, v169) -- line 1124 | captures: v1
    local function v170(...)
        assert(...)
    end

    v170(v1.string(v168))
    local v171
    if v169 ~= nil then
        v171 = v1.children(v169)
    end
    return function(v172) -- line 1132 | captures: v171, v168, v1
        local v173, v174 = v1.Instance(v172)
        if v173 then
            if v172.ClassName == v168 then
                local v175 = v171
                local v176, v177
                if v175 then
                    v176, v177 = v171(v172)
                end
                if not v175 or v176 then
                    return true
                end
                return false, v177
            end
            return false, string.format("%s expected, got %s", v168, v172.ClassName)
        end
        return false, v174 or ""
    end
end

v1.instance = v1.instanceOf

function v1.instanceIsA(v178, v179) -- line 1162 | captures: v1
    local function v180(...)
        assert(...)
    end

    v180(v1.string(v178))
    local v181
    if v179 ~= nil then
        v181 = v1.children(v179)
    end
    return function(v182) -- line 1170 | captures: v181, v178, v1
        local v183, v184 = v1.Instance(v182)
        if v183 then
            if v182:IsA(v178) then
                local v185 = v181
                local v186, v187
                if v185 then
                    v186, v187 = v181(v182)
                end
                if not v185 or v186 then
                    return true
                end
                return false, v187
            end
            return false, string.format("%s expected, got %s", v178, v182.ClassName)
        end
        return false, v184 or ""
    end
end

function v1.enum(v188) -- line 1198 | captures: v1
    local function v189(...)
        assert(...)
    end

    v189(v1.Enum(v188))
    return function(v190) -- line 1200 | captures: v188, v1
        local v191, v192 = v1.EnumItem(v190)
        if v191 then
            if v190.EnumType == v188 then
                return true
            end
            local format = string.format
            local v193 = tostring(v188)
            local EnumType = v190.EnumType
            return false, format("enum of %s expected, got enum of %s", v193, (tostring(EnumType)))
        end
        return false, v192
    end
end

local v194 = v1.tuple(v1.callback, v1.callback)

function v1.wrap(v195, v196) -- line 1225 | captures: v194
    local function v197(...)
        assert(...)
    end

    v197(v194(v195, v196))
    return function(...) -- line 1227 | captures: v195, v196
        local function v198(...)
            assert(...)
        end

        v198(v196(...))
        return v195(...)
    end
end

local function strict(v199) -- line 1241
    return function(...) -- line 1242 | captures: v199
        local function v200(...)
            assert(...)
        end

        v200(v199(...))
    end
end

v1.strict = strict

local v201 = v1.map(v1.string, v1.callback)

function v1.children(v202) -- line 1261 | captures: v1, v201
    local function v203(...)
        assert(...)
    end

    v203(v201(v202))
    return function(v204) -- line 1264 | captures: v202, v1
        local v205, v206 = v1.Instance(v204)
        if v205 then
            local v207 = {}
            for v208, v209 in ipairs(v204:GetChildren()) do
                local Name = v209.Name
                if v202[Name] then
                    if v207[Name] then
                        return false, string.format("Cannot process multiple children with the same name %q", Name)
                    end
                    v207[Name] = v209
                end
            end
            for v210, v211 in pairs(v202) do
                local v212, v213 = v211(v207[v210])
                if not v212 then
                    return false, string.format("[%s.%s] %s", v204:GetFullName(), v210, v213 or "")
                end
            end
            return true
        end
        return false, v206 or ""
    end
end

return v1
