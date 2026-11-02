-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local HttpService = game:GetService("HttpService")
local v2 = Random.new()

local function Copy(v3, v4) -- line 40
    if v4 then
        local function DeepCopy(v5) -- line 44 | captures: DeepCopy
            local v6 = table.clone(v5)
            for v7, v8 in v6 do
                if type(v8) == "table" then
                    v6[v7] = DeepCopy(v8)
                end
            end
            return v6
        end

        return (DeepCopy(v3))
    end
    return (table.clone(v3))
end

local function Sync(v9, v10) -- line 84 | captures: Sync
    local v11 = type(v9) == "table"
    assert(v11, "First argument must be a table")
    local v12 = type(v10) == "table"
    assert(v12, "Second argument must be a table")
    local v13 = table.clone(v9)
    for v14, v15 in pairs(v13) do
        local v16 = v10[v14]
        if v16 == nil then
            v13[v14] = nil
        elseif type(v15) == type(v16) then
            if type(v15) == "table" then
                v13[v14] = Sync(v15, v16)
            end
        elseif type(v16) == "table" then
            local function DeepCopy(v17) -- line 44 | captures: DeepCopy
                local v18 = table.clone(v17)
                for v19, v20 in v18 do
                    if type(v20) == "table" then
                        v18[v19] = DeepCopy(v20)
                    end
                end
                return v18
            end

            v13[v14] = DeepCopy(v16)
        else
            v13[v14] = v16
        end
    end
    for v21, v22 in pairs(v10) do
        if v13[v21] == nil then
            if type(v22) == "table" then
                local function DeepCopy(v23) -- line 44 | captures: DeepCopy
                    local v24 = table.clone(v23)
                    for v25, v26 in v24 do
                        if type(v26) == "table" then
                            v24[v25] = DeepCopy(v26)
                        end
                    end
                    return v24
                end

                v13[v21] = DeepCopy(v22)
            else
                v13[v21] = v22
            end
        end
    end
    return v13
end

local function Reconcile(v27, v28) -- line 156 | captures: Reconcile
    local v29 = type(v27) == "table"
    assert(v29, "First argument must be a table")
    local v30 = type(v28) == "table"
    assert(v30, "Second argument must be a table")
    local v31 = table.clone(v27)
    for v32, v33 in v28 do
        local v34 = v27[v32]
        if v34 == nil then
            if type(v33) == "table" then
                local function DeepCopy(v35) -- line 44 | captures: DeepCopy
                    local v36 = table.clone(v35)
                    for v37, v38 in v36 do
                        if type(v38) == "table" then
                            v36[v37] = DeepCopy(v38)
                        end
                    end
                    return v36
                end

                v31[v32] = DeepCopy(v33)
            else
                v31[v32] = v33
            end
        elseif type(v34) == "table" then
            if type(v33) == "table" then
                v31[v32] = Reconcile(v34, v33)
            else
                local function DeepCopy(v39) -- line 44 | captures: DeepCopy
                    local v40 = table.clone(v39)
                    for v41, v42 in v40 do
                        if type(v42) == "table" then
                            v40[v41] = DeepCopy(v42)
                        end
                    end
                    return v40
                end

                v31[v32] = DeepCopy(v34)
            end
        end
    end
    return v31
end

local function SwapRemove(v43, v44) -- line 209
    local v45 = #v43
    v43[v44] = v43[v45]
    v43[v45] = nil
end

local function SwapRemoveFirstValue(v46, v47) -- line 234
    local v48 = table.find(v46, v47)
    if v48 then
        local v49 = #v46
        v46[v48] = v46[v49]
        v46[v49] = nil
    end
    return v48
end

local function Map(v50, v51) -- line 262
    local v52 = type(v50) == "table"
    assert(v52, "First argument must be a table")
    local v53 = type(v51) == "function"
    assert(v53, "Second argument must be a function")
    local v54 = table.create(#v50)
    for v55, v56 in v50 do
        v54[v55] = v51(v56, v55, v50)
    end
    return v54
end

local function Filter(v57, v58) -- line 292
    local v59 = type(v57) == "table"
    assert(v59, "First argument must be a table")
    local v60 = type(v58) == "function"
    assert(v60, "Second argument must be a function")
    local v61 = table.create(#v57)
    if #v57 > 0 then
        local v62 = 0
        for v63, v64 in v57 do
            if v58(v64, v63, v57) then
                v62 += 1
                v61[v62] = v64
            end
        end
    else
        for v65, v66 in v57 do
            if v58(v66, v65, v57) then
                v61[v65] = v66
            end
        end
    end
    return v61
end

local function Reduce(v67, v68, v69) -- line 335
    local v70 = type(v67) == "table"
    assert(v70, "First argument must be a table")
    local v71 = type(v68) == "function"
    assert(v71, "Second argument must be a function")
    local v72
    if #v67 > 0 then
        local v73
        if v69 == nil then
            v72 = v67[1]
            v73 = 2
        else
            v72 = v69
            v73 = 1
        end
        local v74 = #v67
        for v75 = v73, v74 do
            v72 = v68(v72, v67[v75], v75, v67)
        end
    else
        local v76
        if v69 == nil then
            v72 = next(v67)
            v76 = v72
        else
            v72 = v69
        end
        local v77 = v72
        for v78, v79 in next, v67, v76 do
            v77 = v68(v77, v79, v78, v67)
            v72 = v77
        end
    end
    return v72
end

local function Assign(v80, ...) -- line 378
    local v81 = table.clone(v80)
    for v82, v83 in { ... } do
        for v84, v85 in v83 do
            v81[v84] = v85
        end
    end
    return v81
end

local function Extend(v86, v87) -- line 407
    local v88 = table.clone(v86)
    for v89, v90 in v87 do
        table.insert(v88, v90)
    end
    return v88
end

local function Reverse(v91) -- line 432
    local v92 = #v91
    local v93 = table.create(v92)
    for v94 = 1, v92 do
        v93[v94] = v91[v92 - v94 + 1]
    end
    return v93
end

local function Shuffle(v95, v96) -- line 459 | captures: v2
    local v97 = type(v95) == "table"
    assert(v97, "First argument must be a table")
    local v98 = table.clone(v95)
    local v99 = if typeof(v96) == "Random" then v96 else v2
    local v100 = #v95
    for v101 = v100, 2, -1 do
        local v102 = v99:NextInteger(1, v101)
        local v103 = v98[v102]
        local v104 = v98[v101]
        v98[v101] = v103
        v98[v102] = v104
    end
    return v98
end

local function Sample(v105, v106, v107) -- line 489 | captures: v2
    local v108 = type(v105) == "table"
    assert(v108, "First argument must be a table")
    local v109 = type(v106) == "number"
    assert(v109, "Second argument must be a number")
    local v110 = #v105
    if v110 == 0 then
        return {}
    end
    local v111 = table.clone(v105)
    local v112 = table.create(v106)
    local v113 = if typeof(v107) == "Random" then v107 else v2
    local v114 = math.clamp(v106, 1, v110)
    for v115 = 1, v114 do
        local v116 = v113:NextInteger(v115, v110)
        local v117 = v111[v116]
        local v118 = v111[v115]
        v111[v115] = v117
        v111[v116] = v118
    end
    table.move(v111, 1, v114, 1, v112)
    return v112
end

local function Flat(v119, v120) -- line 537
    local v121 = if type(v120) == "number" then v120 else 1
    local v122 = table.create(#v119)
    local v123 = v121
    local Scan

    local function Scan_2(v124, v125) -- line 540 | captures: v122, v123, Scan
        for v126, v127 in v124 do
            if type(v127) == "table" and v125 < v123 then
                Scan(v127, v125 + 1)
            else
                table.insert(v122, v127)
            end
        end
    end

    Scan = Scan_2
    Scan_2(v119, 0)
    return v122
end

local function FlatMap(v128, v129) -- line 574 | captures: Map
    local v130 = Map(v128, v129)
    local v131 = table.create(#v130)
    local v132 = 1
    local Scan

    local function Scan_2(v133, v134) -- line 540 | captures: v131, v132, Scan
        for v135, v136 in v133 do
            if type(v136) == "table" and v134 < v132 then
                Scan(v136, v134 + 1)
            else
                table.insert(v131, v136)
            end
        end
    end

    Scan = Scan_2
    Scan_2(v130, 0)
    return v131
end

local function Keys(v137) -- line 600
    local v138 = table.create(#v137)
    for v139 in v137 do
        table.insert(v138, v139)
    end
    return v138
end

local function Values(v140) -- line 630
    local v141 = table.create(#v140)
    for v142, v143 in v140 do
        table.insert(v141, v143)
    end
    return v141
end

local function Find(v144, v145) -- line 669
    for v146, v147 in v144 do
        if v145(v147, v146, v144) then
            return v147, v146
        end
    end
    return nil, nil
end

local function Every(v148, v149) -- line 698
    for v150, v151 in v148 do
        if not v149(v151, v150, v148) then
            return false
        end
    end
    return true
end

local function Some(v152, v153) -- line 727
    for v154, v155 in v152 do
        if v153(v155, v154, v152) then
            return true
        end
    end
    return false
end

local function Truncate(v156, v157) -- line 753
    local v158 = #v156
    local v159 = math.clamp(v157, 1, v158)
    if v159 == v158 then
        return (table.clone(v156))
    end
    return (table.move(v156, 1, v159, 1, table.create(v159)))
end

local function Zip(...) -- line 786
    local v160 = select("#", ...) > 0
    assert(v160, "Must supply at least 1 table")

    local function ZipIteratorArray(v161, v162) -- line 788
        local v163 = v162 + 1
        local v164 = {}
        for v165, v166 in v161 do
            local v167 = v166[v163]
            if v167 == nil then
                return nil, nil
            end
            v164[v165] = v167
        end
        return v163, v164
    end

    local function ZipIteratorMap(v168, v169) -- line 801
        local v170 = {}
        for v171, v172 in v168 do
            local v173 = next(v172, v169)
            if v173 == nil then
                return nil, nil
            end
            v170[v171] = v173
        end
        return v169, v170
    end

    local v174 = { ... }
    if #v174[1] > 0 then
        return ZipIteratorArray, v174, 0
    end
    return ZipIteratorMap, v174, nil
end

local function Lock(v175) -- line 839
    local function Freeze(v176) -- line 840 | captures: Freeze
        for v177, v178 in pairs(v176) do
            if type(v178) == "table" then
                v176[v177] = Freeze(v178)
            end
        end
        return table.freeze(v176)
    end

    return Freeze(v175)
end

local function IsEmpty(v179) -- line 869
    return next(v179) == nil
end

local function EncodeJSON(v180) -- line 881 | captures: HttpService
    return HttpService:JSONEncode(v180)
end

local function DecodeJSON(v181) -- line 893 | captures: HttpService
    return HttpService:JSONDecode(v181)
end

v1.Copy = Copy
v1.Sync = Sync
v1.Reconcile = Reconcile
v1.SwapRemove = SwapRemove
v1.SwapRemoveFirstValue = SwapRemoveFirstValue
v1.Map = Map
v1.Filter = Filter
v1.Reduce = Reduce
v1.Assign = Assign
v1.Extend = Extend
v1.Reverse = Reverse
v1.Shuffle = Shuffle
v1.Sample = Sample
v1.Flat = Flat
v1.FlatMap = FlatMap
v1.Keys = Keys
v1.Values = Values
v1.Find = Find
v1.Every = Every
v1.Some = Some
v1.Truncate = Truncate
v1.Zip = Zip
v1.Lock = Lock
v1.IsEmpty = IsEmpty
v1.EncodeJSON = EncodeJSON
v1.DecodeJSON = DecodeJSON
return v1
