-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    Pretty = true,
    IndentChar = " ",
    IndentSize = 2
}

local function isInt(v2) -- line 7
    local v3 = v2 - math.round(v2)
    return math.abs(v3) < 0.000001
end

local function roundTo(v4, v5) -- line 12
    local v6 = v4 * v5
    return math.round(v6) / v5
end

local function formatNum(v7, v8) -- line 15
    local v9 = 10 ^ v8
    local v10 = v7 * v9
    local v11 = math.round(v10) / v9
    if v11 == 0 then
        if v7 == 0 then
            local v12 = string.format("%." .. v8 .. "f", v11):gsub("%.?0+$", "")
            if v12 == "" or v12 == "-" then
                return "0"
            end
            return v12
        end
        return (tostring(v7))
    end
    local v13 = string.format("%." .. v8 .. "f", v11):gsub("%.?0+$", "")
    if v13 == "" then
        return "0"
    end
    if v13 == "-" then
        return "0"
    end
    return v13
end

local function isValidId(v14) -- line 40
    return v14:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == v14
end

local function makeIndent(v15, v16, v17) -- line 44
    return string.rep(v15, v16 * v17)
end

local v18 = {}

local function serialize(v19, v20) -- line 48 | captures: v18
    local v21 = v18[typeof(v19)]
    if v21 then
        return v21(v19, v20)
    end
    return (("[%*]"):format((typeof(v19))))
end

v18["nil"] = function(v22, v23) -- line 55
    return "nil"
end

local function boolean(v24, v25) -- line 58
    if v24 then
        return "true"
    end
    return "false"
end

v18.boolean = boolean

local function number(v26, v27) -- line 64
    if v26 == (1/0) then
        return "math.huge"
    end
    if v26 == (-1/0) then
        return "-math.huge"
    end
    if v26 == v26 then
        if v27.cfg.Pretty then
            local v28 = v26 * 1000000
            local v29 = math.round(v28) / 1000000
            local v30
            if v29 == 0 then
                if v26 == 0 then
                else
                    v30 = tostring(v26)
                end
            else
                v30 = string.format("%." .. 6 .. "f", v29):gsub("%.?0+$", "")
                if v30 == "" or v30 == "-" then
                    v30 = "0"
                end
            end
            return v30 or tostring(v26)
        end
        return (tostring(v26))
    end
    return "0/0"
end

v18.number = number

local function string_2(v31, v32) -- line 98
    return string.format("%q", v31)
end

v18.string = string_2

v18["function"] = function(v33) -- line 101
    return "[function]"
end

local function Instance(v34) -- line 104
    if v34.Parent then
        return (("[%* %*]"):format(v34.ClassName, (v34:GetFullName())))
    end
    return (("[%*]"):format(v34.ClassName))
end

v18.Instance = Instance

function v18.table(v35, v36) -- line 112 | captures: v18
    local v37 = getmetatable(v35)
    if v37 then
        if v37.__tostring then
            return tostring(v35):gsub("\n", "\n" .. string.rep(v36.cfg.IndentChar, v36.cfg.IndentSize * v36.depth))
        end
    else
        if v36.seen[v35] then
            return "{...}"
        end
        v36.seen[v35] = true
        local v38 = {}
        local v39 = 0
        for v40 in pairs(v35) do
            if typeof(v40) == "number" then
                local v41 = v40 - math.round(v40)
                if math.abs(v41) < 0.000001 and v40 > 0 then
                    v39 = math.max(v39, v40)
                end
            end
            table.insert(v38, v40)
        end
        local v42 = if #v38 == v39 then #v38 > 0 else false
        for v43 = 1, v39 do
            if v35[v43] == nil then
                v42 = false
                break
            end
        end
        v36.depth += 1
        local Pretty = v36.cfg.Pretty
        local v44, v45
        if Pretty then
            v45 = "\n" .. string.rep(v36.cfg.IndentChar, v36.cfg.IndentSize * v36.depth)
            v44 = ",\n" .. string.rep(v36.cfg.IndentChar, v36.cfg.IndentSize * v36.depth)
        else
            v45 = ""
            v44 = ","
        end
        local v46 = {}
        if v42 then
            for v47 = 1, v39 do
                local v48 = v35[v47]
                local v49 = v18[typeof(v48)]
                if v49 then
                    v46[v47] = v49(v48, v36)
                else
                    v46[v47] = ("[%*]"):format((typeof(v48)))
                end
            end
        else
            local order = v36.order
            local v50 = {}
            for v51, v52 in ipairs(v38) do
                v50[v52] = v51
            end
            local v53 = {}
            for v54, v55 in ipairs(v38) do
                local v56 = {
                    v55,
                    v35[v55]
                }
                table.insert(v53, v56)
            end
            if order then
                table.sort(v53, function(v57, v58) -- line 167 | captures: order, v50
                    local v59 = if order[v57[1]] then order[v57[1]].Index else (1/0)
                    local v60 = if order[v58[1]] then order[v58[1]].Index else (1/0)
                    if v59 == v60 then
                        return v50[v57[1]] < v50[v58[1]]
                    end
                    if v60 <= v59 then
                        return v50[v57[1]] < v50[v58[1]]
                    end
                    return true
                end)
            end
            local Child, v61
            for v62, v63 in ipairs(v53) do
                local v64 = v63[1]
                local v65 = v63[2]
                if order then
                    if order[v64] then
                        Child = order[v64].Child
                    end
                else
                    Child = nil
                end
                local order_2 = v36.order
                v36.order = Child
                if typeof(v64) == "string" then
                    if v64:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == v64 then
                        v61 = v64
                    end
                else
                    local v66 = v18[typeof(v64)]
                    local v67
                    if v66 then
                        v67 = v66(v64, v36)
                    else
                        v67 = ("[%*]"):format((typeof(v64)))
                    end
                    v61 = ("[%*]"):format(v67)
                end
                local v68 = v18[typeof(v65)]
                local v69
                if v68 then
                    v69 = v68(v65, v36)
                else
                    v69 = ("[%*]"):format((typeof(v65)))
                end
                local v70
                if Pretty then
                    v70 = ("%* = %*"):format(v61, v69)
                else
                    v70 = ("%*=%*"):format(v61, v69)
                end
                table.insert(v46, v70)
                v36.order = order_2
            end
        end
        v36.depth -= 1
        v36.seen[v35] = nil
        if #v46 == 0 then
            return "{}"
        end
        if Pretty then
            local v71 = "\n" .. string.rep(v36.cfg.IndentChar, v36.cfg.IndentSize * v36.depth)
            return "{" .. v45 .. table.concat(v46, v44) .. "," .. v71 .. "}"
        end
        return "{" .. table.concat(v46, v44) .. "}"
    end
end

function v18.Color3(v72, v73) -- line 261 | captures: v18
    local v74 = v72.R * 255
    local v75 = v72.G * 255
    local v76 = v72.B * 255
    local v77 = v74 - math.round(v74)
    local v78, v79, v80, v81
    if math.abs(v77) < 0.000001 then
        local v82 = v75 - math.round(v75)
        if math.abs(v82) < 0.000001 then
            local v83 = v76 - math.round(v76)
            if math.abs(v83) < 0.000001 then
                v78 = math.round(v74)
                v79 = math.round(v75)
                v80 = math.round(v76)
                v81 = "fromRGB"
            else
                v81 = "fromRGB"
            end
        else
            v81 = "fromRGB"
        end
    else
        v78 = v72.R
        v79 = v72.G
        v80 = v72.B
        v81 = "new"
    end
    if v73.cfg.Pretty then
        local v84 = v18[typeof(v78)]
        local v85
        if v84 then
            v85 = v84(v78, v73)
        else
            v85 = ("[%*]"):format((typeof(v78)))
        end
        local v86 = v18[typeof(v79)]
        local v87
        if v86 then
            v87 = v86(v79, v73)
        else
            v87 = ("[%*]"):format((typeof(v79)))
        end
        local v88 = v18[typeof(v80)]
        local v89
        if v88 then
            v89 = v88(v80, v73)
        else
            v89 = ("[%*]"):format((typeof(v80)))
        end
        return (("Color3.%*(%*, %*, %*)"):format(v81, v85, v87, v89))
    end
    local v90 = v18[typeof(v78)]
    local v91
    if v90 then
        v91 = v90(v78, v73)
    else
        v91 = ("[%*]"):format((typeof(v78)))
    end
    local v92 = v18[typeof(v79)]
    local v93
    if v92 then
        v93 = v92(v79, v73)
    else
        v93 = ("[%*]"):format((typeof(v79)))
    end
    local v94 = v18[typeof(v80)]
    local v95
    if v94 then
        v95 = v94(v80, v73)
    else
        v95 = ("[%*]"):format((typeof(v80)))
    end
    return (("Color3.%*(%*,%*,%*)"):format(v81, v91, v93, v95))
end

function v18.Vector3(v96, v97) -- line 337 | captures: v18
    if v96 == Vector3.new(0, 0, 0) then
        return "Vector3.zero"
    end
    if v96 == Vector3.new(1, 1, 1) then
        return "Vector3.one"
    end
    if v96 == Vector3.new(1, 0, 0) then
        return "Vector3.xAxis"
    end
    if v96 == Vector3.new(0, 1, 0) then
        return "Vector3.yAxis"
    end
    if v96 == Vector3.new(0, 0, 1) then
        return "Vector3.zAxis"
    end
    if v97.cfg.Pretty then
        local X = v96.X
        local v98 = v18[typeof(X)]
        local v99
        if v98 then
            v99 = v98(X, v97)
        else
            v99 = ("[%*]"):format((typeof(X)))
        end
        local Y = v96.Y
        local v100 = v18[typeof(Y)]
        local v101
        if v100 then
            v101 = v100(Y, v97)
        else
            v101 = ("[%*]"):format((typeof(Y)))
        end
        local Z = v96.Z
        local v102 = v18[typeof(Z)]
        local v103
        if v102 then
            v103 = v102(Z, v97)
        else
            v103 = ("[%*]"):format((typeof(Z)))
        end
        return (("Vector3.new(%*, %*, %*)"):format(v99, v101, v103))
    end
    local X = v96.X
    local v104 = v18[typeof(X)]
    local v105
    if v104 then
        v105 = v104(X, v97)
    else
        v105 = ("[%*]"):format((typeof(X)))
    end
    local Y = v96.Y
    local v106 = v18[typeof(Y)]
    local v107
    if v106 then
        v107 = v106(Y, v97)
    else
        v107 = ("[%*]"):format((typeof(Y)))
    end
    local Z = v96.Z
    local v108 = v18[typeof(Z)]
    local v109
    if v108 then
        v109 = v108(Z, v97)
    else
        v109 = ("[%*]"):format((typeof(Z)))
    end
    return (("Vector3.new(%*,%*,%*)"):format(v105, v107, v109))
end

function v18.Vector2(v110, v111) -- line 401 | captures: v18
    if v110 == Vector2.zero then
        return "Vector2.zero"
    end
    if v110 == Vector2.one then
        return "Vector2.one"
    end
    if v110 == Vector2.xAxis then
        return "Vector2.xAxis"
    end
    if v110 == Vector2.yAxis then
        return "Vector2.yAxis"
    end
    if v111.cfg.Pretty then
        local X = v110.X
        local v112 = v18[typeof(X)]
        local v113
        if v112 then
            v113 = v112(X, v111)
        else
            v113 = ("[%*]"):format((typeof(X)))
        end
        local Y = v110.Y
        local v114 = v18[typeof(Y)]
        local v115
        if v114 then
            v115 = v114(Y, v111)
        else
            v115 = ("[%*]"):format((typeof(Y)))
        end
        return (("Vector2.new(%*, %*)"):format(v113, v115))
    end
    local X = v110.X
    local v116 = v18[typeof(X)]
    local v117
    if v116 then
        v117 = v116(X, v111)
    else
        v117 = ("[%*]"):format((typeof(X)))
    end
    local Y = v110.Y
    local v118 = v18[typeof(Y)]
    local v119
    if v118 then
        v119 = v118(Y, v111)
    else
        v119 = ("[%*]"):format((typeof(Y)))
    end
    return (("Vector2.new(%*,%*)"):format(v117, v119))
end

function v18.CFrame(v120, v121) -- line 448 | captures: v18
    if v120 == CFrame.identity then
        return "CFrame.identity"
    end
    local Position = v120.Position
    local v122, v123, v124 = v120:ToOrientation()
    local v125, v126, v127, v128, v129, v130, v131, v132, v133, v134, v135, v136 = v120:GetComponents()
    _ = v125
    _ = v126
    _ = v127
    local v137 = v128 - 1
    local v138
    if math.abs(v137) <= 0.000001 then
        local v139 = v132 - 1
        if math.abs(v139) <= 0.000001 then
            local v140 = v136 - 1
            if math.abs(v140) <= 0.000001 and math.abs(v129) <= 0.000001 and math.abs(v130) <= 0.000001 and math.abs(v131) <= 0.000001 and math.abs(v133) <= 0.000001 and math.abs(v134) <= 0.000001 then
                v138 = math.abs(v135) > 0.000001
            else
                v138 = true
            end
        else
            v138 = true
        end
    else
        v138 = true
    end
    local v141 = Position.Magnitude > 0.000001
    local Pretty = v121.cfg.Pretty
    local v142, v143
    if Pretty then
        local v144 = Position.X * 1000000
        local v145 = math.round(v144) / 1000000
        local v146 = v18[typeof(v145)]
        local v147
        if v146 then
            v147 = v146(v145, v121)
        else
            v147 = ("[%*]"):format((typeof(v145)))
        end
        local v148 = Position.Y * 1000000
        local v149 = math.round(v148) / 1000000
        local v150 = v18[typeof(v149)]
        local v151
        if v150 then
            v151 = v150(v149, v121)
        else
            v151 = ("[%*]"):format((typeof(v149)))
        end
        local v152 = Position.Z * 1000000
        local v153 = math.round(v152) / 1000000
        local v154 = v18[typeof(v153)]
        local v155
        if v154 then
            v155 = v154(v153, v121)
        else
            v155 = ("[%*]"):format((typeof(v153)))
        end
        v143 = ("CFrame.new(%*, %*, %*)"):format(v147, v151, v155)
        local v156 = math.deg(v122) * 1000000
        local v157 = math.round(v156) / 1000000
        local v158 = v18[typeof(v157)]
        local v159
        if v158 then
            v159 = v158(v157, v121)
        else
            v159 = ("[%*]"):format((typeof(v157)))
        end
        local v160 = math.deg(v123) * 1000000
        local v161 = math.round(v160) / 1000000
        local v162 = v18[typeof(v161)]
        local v163
        if v162 then
            v163 = v162(v161, v121)
        else
            v163 = ("[%*]"):format((typeof(v161)))
        end
        local v164 = math.deg(v124) * 1000000
        local v165 = math.round(v164) / 1000000
        local v166 = v18[typeof(v165)]
        local v167
        if v166 then
            v167 = v166(v165, v121)
        else
            v167 = ("[%*]"):format((typeof(v165)))
        end
        v142 = ("CFrame.fromOrientation(math.rad(%*), math.rad(%*), math.rad(%*))"):format(v159, v163, v167)
    else
        local X = Position.X
        local v168 = v18[typeof(X)]
        local v169
        if v168 then
            v169 = v168(X, v121)
        else
            v169 = ("[%*]"):format((typeof(X)))
        end
        local Y = Position.Y
        local v170 = v18[typeof(Y)]
        local v171
        if v170 then
            v171 = v170(Y, v121)
        else
            v171 = ("[%*]"):format((typeof(Y)))
        end
        local Z = Position.Z
        local v172 = v18[typeof(Z)]
        local v173
        if v172 then
            v173 = v172(Z, v121)
        else
            v173 = ("[%*]"):format((typeof(Z)))
        end
        v143 = ("CFrame.new(%*,%*,%*)"):format(v169, v171, v173)
        local v174 = v18[typeof(v122)]
        local v175
        if v174 then
            v175 = v174(v122, v121)
        else
            v175 = ("[%*]"):format((typeof(v122)))
        end
        local v176 = v18[typeof(v123)]
        local v177
        if v176 then
            v177 = v176(v123, v121)
        else
            v177 = ("[%*]"):format((typeof(v123)))
        end
        local v178 = v18[typeof(v124)]
        local v179
        if v178 then
            v179 = v178(v124, v121)
        else
            v179 = ("[%*]"):format((typeof(v124)))
        end
        v142 = ("CFrame.fromOrientation(%*,%*,%*)"):format(v175, v177, v179)
    end
    if not v141 then
        return v142
    end
    if not v138 then
        return v143
    end
    local v180 = if Pretty then " * " else "*"
    return v143 .. v180 .. v142 or v143
end

local function EnumItem(v181, v182) -- line 601
    local EnumType = v181.EnumType
    return (("Enum.%*.%*"):format(tostring(EnumType), v181.Name))
end

v18.EnumItem = EnumItem

local v183 = { DEFAULT_CONFIG = v1 }

function v183.Pretty(v184, v185) -- line 607 | captures: v1, serialize
    local v186 = {}
    if v185 then
        v186.Pretty = v185.Pretty
        v186.IndentChar = v185.IndentChar
        v186.IndentSize = v185.IndentSize
    else
        v186.Pretty = v1.Pretty
        v186.IndentChar = v1.IndentChar
        v186.IndentSize = v1.IndentSize
    end
    v186.Order = v185 and v185.Order or v1.Order
    return serialize(v184, {
        depth = 0,
        cfg = v186,
        order = v186.Order,
        seen = {}
    })
end

function v183.Serialize(v187, v188) -- line 639 | captures: serialize
    return serialize(v187, {
        depth = 0,
        cfg = v188,
        order = v188.Order,
        seen = {}
    })
end

function v183.Default(v189) -- line 642 | captures: v1, serialize
    return serialize(v189, {
        depth = 0,
        cfg = v1,
        order = v1.Order,
        seen = {}
    })
end

function v183.DefaultArgs(...) -- line 647 | captures: v183
    local function v190(v191, ...)
        table.insert(v191, ...)
    end

    local v192 = table.pack(...)
    local v193 = {}
    local n = v192.n
    for v194 = 1, n do
        if v194 > 1 then
            table.insert(v193, ", ")
        end
        v190(v193, v183.Default(v192[v194]))
    end
    return table.concat(v193)
end

function v183.DefaultArgsPrefix(...) -- line 660 | captures: v183
    local function v195(v196, ...)
        table.insert(v196, ...)
    end

    local v197 = table.pack(...)
    local v198 = {}
    local n = v197.n
    for v199 = 1, n do
        table.insert(v198, ", ")
        v195(v198, v183.Default(v197[v199]))
    end
    return table.concat(v198)
end

function v183.CompileOrder(v200) -- line 671 | captures: v183
    local v201 = type(v200) == "table"
    assert(v201)
    local v202 = if #v200 == 0 then next(v200) == nil else true
    assert(v202)
    local v203 = {}
    for v204, v205 in ipairs(v200) do
        if type(v205) == "table" then
            local Key = v205.Key
            local v206 = type(Key) == "string"
            assert(v206)
            v203[Key] = {
                Index = v204,
                Child = v183.CompileOrder(v205.Value)
            }
        else
            v203[v205] = { Index = v204 }
        end
    end
    return v203
end

return table.freeze(v183)
