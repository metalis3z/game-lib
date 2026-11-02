-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local HttpService = game:GetService("HttpService")
local v1 = Random.new()
local v2

function v2(v3, v4) -- line 9 | captures: v2
    local v5 = type(v3) == "table"
    assert(v5, "First argument must be a table")
    local v6 = type(v4) == "table"
    assert(v6, "Second argument must be a table")
    local v7 = table.clone(v3)
    for v8, v9 in pairs(v7) do
        local v10 = v4[v8]
        if v10 == nil then
            v7[v8] = nil
        elseif type(v9) == type(v10) then
            if type(v9) == "table" then
                v7[v8] = v2(v9, v10)
            end
        elseif type(v10) == "table" then
            local function DeepCopy_2(v11) -- line 27 | captures: DeepCopy_2
                local v12 = table.clone(v11)
                for v13, v14 in v12 do
                    if type(v14) == "table" then
                        v12[v13] = DeepCopy_2(v14)
                    end
                end
                return v12
            end

            v7[v8] = DeepCopy_2(v10)
        else
            v7[v8] = v10
        end
    end
    for v15, v16 in pairs(v4) do
        if v7[v15] == nil then
            if type(v16) == "table" then
                local function DeepCopy(v17) -- line 50 | captures: DeepCopy
                    local v18 = table.clone(v17)
                    for v19, v20 in v18 do
                        if type(v20) == "table" then
                            v18[v19] = DeepCopy(v20)
                        end
                    end
                    return v18
                end

                v7[v15] = DeepCopy(v16)
            else
                v7[v15] = v16
            end
        end
    end
    return v7
end

local v21

function v21(v22, v23) -- line 68 | captures: v21
    local v24 = type(v22) == "table"
    assert(v24, "First argument must be a table")
    local v25 = type(v23) == "table"
    assert(v25, "Second argument must be a table")
    local v26 = table.clone(v22)
    for v27, v28 in v23 do
        local v29 = v22[v27]
        if v29 == nil then
            if type(v28) == "table" then
                local function DeepCopy(v30) -- line 103 | captures: DeepCopy
                    local v31 = table.clone(v30)
                    for v32, v33 in v31 do
                        if type(v33) == "table" then
                            v31[v32] = DeepCopy(v33)
                        end
                    end
                    return v31
                end

                v26[v27] = DeepCopy(v28)
            else
                v26[v27] = v28
            end
        elseif type(v29) == "table" then
            if type(v28) == "table" then
                v26[v27] = v21(v29, v28)
            else
                local function DeepCopy_2(v34) -- line 83 | captures: DeepCopy_2
                    local v35 = table.clone(v34)
                    for v36, v37 in v35 do
                        if type(v37) == "table" then
                            v35[v36] = DeepCopy_2(v37)
                        end
                    end
                    return v35
                end

                v26[v27] = DeepCopy_2(v29)
            end
        end
    end
    return v26
end

local function Map(v38, v39) -- line 120
    local v40 = type(v38) == "table"
    assert(v40, "First argument must be a table")
    local v41 = type(v39) == "function"
    assert(v41, "Second argument must be a function")
    local v42 = table.create(#v38)
    for v43, v44 in v38 do
        v42[v43] = v39(v44, v43, v38)
    end
    return v42
end

local v45 = {
    Copy = function(v46, v47) -- Copy | line 135
        if v47 then
            local v48

            function v48(v49) -- line 140 | captures: v48
                local v50 = table.clone(v49)
                for v51, v52 in v50 do
                    if type(v52) == "table" then
                        v50[v51] = v48(v52)
                    end
                end
                return v50
            end

            return (v48(v46))
        end
        return (table.clone(v46))
    end,
    Sync = v2,
    Reconcile = v21,
    SwapRemove = function(v53, v54) -- SwapRemove | line 156
        local v55 = #v53
        v53[v54] = v53[v55]
        v53[v55] = nil
    end,
    SwapRemoveFirstValue = function(v56, v57) -- SwapRemoveFirstValue | line 161
        local v58 = table.find(v56, v57)
        if v58 then
            local v59 = #v56
            v56[v58] = v56[v59]
            v56[v59] = nil
        end
        return v58
    end,
    Map = Map,
    Filter = function(v60, v61) -- Filter | line 171
        local v62 = type(v60) == "table"
        assert(v62, "First argument must be a table")
        local v63 = type(v61) == "function"
        assert(v63, "Second argument must be a function")
        local v64 = table.create(#v60)
        if #v60 <= 0 then
            for v65, v66 in v60 do
                if v61(v66, v65, v60) then
                    v64[v65] = v66
                end
            end
        else
            local v67 = 0
            for v68, v69 in v60 do
                if v61(v69, v68, v60) then
                    v67 += 1
                    v64[v67] = v69
                end
            end
        end
        return v64
    end,
    Reduce = function(v70, v71, v72) -- Reduce | line 201
        local v73 = type(v70) == "table"
        assert(v73, "First argument must be a table")
        local v74 = type(v71) == "function"
        assert(v74, "Second argument must be a function")
        if #v70 > 0 then
            local v75, v76
            if v72 == nil then
                v75, v76 = 2, v70[1]
            else
                v75 = 1
                v76 = v72
            end
            local v77 = #v70
            for v78 = v75, v77 do
                v76 = v71(v76, v70[v78], v78, v70)
            end
            return v76
        end
        local v79, v80
        if v72 == nil then
            v79 = next(v70)
            v80 = v79
        else
            v80 = v72
        end
        for v81, v82 in next, v70, v79 do
            v80 = v71(v80, v82, v81, v70)
        end
        return v80
    end,
    Assign = function(v83, ...) -- Assign | line 234
        local v84 = table.clone(v83)
        for v85, v86 in { ... } do
            for v87, v88 in v86 do
                v84[v87] = v88
            end
        end
        return v84
    end,
    Extend = function(v89, v90) -- Extend | line 250
        local v91 = table.clone(v89)
        for v92, v93 in v90 do
            table.insert(v91, v93)
        end
        return v91
    end,
    Reverse = function(v94) -- Reverse | line 260
        local v95 = #v94
        local v96 = table.create(v95)
        for v97 = 1, v95 do
            v96[v97] = v94[v95 - v97 + 1]
        end
        return v96
    end
}

function v45.Shuffle(v98, v99) -- line 270 | captures: v1
    local v100 = type(v98) == "table"
    assert(v100, "First argument must be a table")
    local v101 = table.clone(v98)
    local v102 = if typeof(v99) == "Random" then v99 else v1
    local v103 = #v98
    for v104 = v103, 2, -1 do
        local v105 = v102:NextInteger(1, v104)
        local v106 = v101[v104]
        v101[v104] = v101[v105]
        v101[v105] = v106
    end
    return v101
end

function v45.Sample(v107, v108, v109) -- line 290 | captures: v1
    local v110 = type(v107) == "table"
    assert(v110, "First argument must be a table")
    local v111 = type(v108) == "number"
    assert(v111, "Second argument must be a number")
    local v112 = #v107
    if v112 == 0 then
        return {}
    end
    local v113 = table.clone(v107)
    local v114 = table.create(v108)
    local v115 = if typeof(v109) == "Random" then v109 else v1
    local v116 = math.clamp(v108, 1, v112)
    for v117 = 1, v116 do
        local v118 = v115:NextInteger(v117, v112)
        local v119 = v113[v117]
        v113[v117] = v113[v118]
        v113[v118] = v119
    end
    table.move(v113, 1, v116, 1, v114)
    return v114
end

function v45.Flat(v120, v121) -- line 319
    local v122 = if type(v121) == "number" then v121 else 1
    local v123 = table.create(#v120)
    local v124

    function v124(v125, v126) -- line 327 | captures: v124, v122, v123
        for v127, v128 in v125 do
            if type(v128) == "table" then
                if v126 < v122 then
                    v124(v128, v126 + 1)
                end
            else
                table.insert(v123, v128)
            end
        end
    end

    v124(v120, 0)
    return v123
end

function v45.FlatMap(v129, v130) -- line 343 | captures: Map
    local v131 = Map(v129, v130)
    local v132 = table.create(#v131)
    local v133

    function v133(v134, v135) -- line 348 | captures: v133, v132
        for v136, v137 in v134 do
            if type(v137) == "table" then
                if v135 < 1 then
                    v133(v137, v135 + 1)
                end
            else
                table.insert(v132, v137)
            end
        end
    end

    v133(v131, 0)
    return v132
end

function v45.Keys(v138) -- line 364
    local v139 = table.create(#v138)
    for v140 in v138 do
        table.insert(v139, v140)
    end
    return v139
end

function v45.Values(v141) -- line 374
    local v142 = table.create(#v141)
    for v143, v144 in v141 do
        table.insert(v142, v144)
    end
    return v142
end

function v45.Find(v145, v146) -- line 384
    for v147, v148 in v145 do
        if v146(v148, v147, v145) then
            return v148, v147
        end
    end
    return nil, nil
end

function v45.Every(v149, v150) -- line 395
    for v151, v152 in v149 do
        if not v150(v152, v151, v149) then
            return false
        end
    end
    return true
end

function v45.Some(v153, v154) -- line 406
    for v155, v156 in v153 do
        if v154(v156, v155, v153) then
            return true
        end
    end
    return false
end

function v45.Truncate(v157, v158) -- line 417
    local v159 = #v157
    local v160 = math.clamp(v158, 1, v159)
    if v160 == v159 then
        return (table.clone(v157))
    end
    return (table.move(v157, 1, v160, 1, table.create(v160)))
end

function v45.Zip(...) -- line 425
    local v161 = select("#", ...) > 0
    assert(v161, "Must supply at least 1 table")
    local v162 = { ... }
    if #v162[1] > 0 then
        return function(v163, v164) -- line 432
                local v165 = v164 + 1
                local v166 = {}
                for v167, v168 in v163 do
                    local v169 = v168[v165]
                    if v169 == nil then
                        return nil, nil
                    end
                    v166[v167] = v169
                end
                return v165, v166
            end,
            v162,
            0
    end
    return function(v170, v171) -- line 450
            local v172 = {}
            for v173, v174 in v170 do
                local v175 = next(v174, v171)
                if v175 == nil then
                    return nil, nil
                end
                v172[v173] = v175
            end
            return v171, v172
        end,
        v162,
        nil
end

function v45.Lock(v176) -- line 467
    local v177

    function v177(v178) -- line 469 | captures: v177
        for v179, v180 in pairs(v178) do
            if type(v180) == "table" then
                v178[v179] = v177(v180)
            end
        end
        return table.freeze(v178)
    end

    return v177(v176)
end

function v45.IsEmpty(v181) -- line 479
    return next(v181) == nil
end

function v45.EncodeJSON(v182) -- line 483 | captures: HttpService
    return HttpService:JSONEncode(v182)
end

function v45.DecodeJSON(v183) -- line 486 | captures: HttpService
    return HttpService:JSONDecode(v183)
end

function v45.ShallowReconcile(v184, v185) -- line 489
    local v186 = type(v184) == "table"
    assert(v186, "First argument must be a table")
    local v187 = type(v185) == "table"
    assert(v187, "Second argument must be a table")
    local v188 = table.clone(v184)
    for v189, v190 in v185 do
        if v184[v189] == nil then
            if type(v190) == "table" then
                local function DeepCopy(v191) -- line 503 | captures: DeepCopy
                    local v192 = table.clone(v191)
                    for v193, v194 in v192 do
                        if type(v194) == "table" then
                            v192[v193] = DeepCopy(v194)
                        end
                    end
                    return v192
                end

                v188[v189] = DeepCopy(v190)
            else
                v188[v189] = v190
            end
        end
    end
    return v188
end

function v45.HardShallowReconcile(v195, v196) -- line 521
    local v197 = type(v195) == "table"
    assert(v197, "First argument must be a table")
    local v198 = type(v196) == "table"
    assert(v198, "Second argument must be a table")
    for v199, v200 in v196 do
        if v195[v199] == nil then
            if type(v200) == "table" then
                local function DeepCopy(v201) -- line 534 | captures: DeepCopy
                    local v202 = table.clone(v201)
                    for v203, v204 in v202 do
                        if type(v204) == "table" then
                            v202[v203] = DeepCopy(v204)
                        end
                    end
                    return v202
                end

                v195[v199] = DeepCopy(v200)
            else
                v195[v199] = v200
            end
        end
    end
    return v195
end

function v45.CopySafe(v205, v206, v207) -- line 552
    if v206 then
        local v208 = {}
        local v209

        function v209(v210) -- line 558 | captures: v209, v207, v208
            local v211 = v208[v210]
            if v211 then
                return v211
            end
            local v212 = table.clone(v210)
            local v213
            if v207 then
                v213 = getmetatable(v210)
            end
            v208[v210] = v212
            if v213 then
                setmetatable(v212, v213)
            end
            for v214, v215 in v212 do
                if type(v215) == "table" then
                    v212[v214] = v209(v215)
                end
            end
            return v212
        end

        return (v209(v205))
    end
    return (table.clone(v205))
end

function v45.HardReconcile(v216, v217) -- line 586 | captures: v21
    local v218 = type(v216) == "table"
    assert(v218, "First argument must be a table")
    local v219 = type(v217) == "table"
    assert(v219, "Second argument must be a table")
    for v220, v221 in v217 do
        local v222 = v216[v220]
        if v222 == nil then
            if type(v221) == "table" then
                local function DeepCopy(v223) -- line 620 | captures: DeepCopy
                    local v224 = table.clone(v223)
                    for v225, v226 in v224 do
                        if type(v226) == "table" then
                            v224[v225] = DeepCopy(v226)
                        end
                    end
                    return v224
                end

                v216[v220] = DeepCopy(v221)
            else
                v216[v220] = v221
            end
        elseif type(v222) == "table" then
            if type(v221) == "table" then
                v216[v220] = v21(v222, v221)
            else
                local function DeepCopy_2(v227) -- line 600 | captures: DeepCopy_2
                    local v228 = table.clone(v227)
                    for v229, v230 in v228 do
                        if type(v230) == "table" then
                            v228[v229] = DeepCopy_2(v230)
                        end
                    end
                    return v228
                end

                v216[v220] = DeepCopy_2(v222)
            end
        end
    end
    return v216
end

return v45
