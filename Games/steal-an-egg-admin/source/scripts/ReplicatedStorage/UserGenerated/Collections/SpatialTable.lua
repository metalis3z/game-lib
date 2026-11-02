-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function hash(v1, v2, v3) -- line 6
    return (bit32.band(v1, 262143) * 262144 + bit32.band(v3, 262143)) * 131072 + bit32.band(v2, 131071)
end

local function quantize(v4, v5) -- line 11
    return v4.X // v5, v4.Y // v5, v4.Z // v5
end

local function key(v6, v7) -- line 14
    local v8 = v6.Y // v7
    local v9 = v6.X // v7
    local v10 = bit32.band(v9, 262143) * 262144
    local v11 = v6.Z // v7
    return (v10 + bit32.band(v11, 262143)) * 131072 + bit32.band(v8, 131071)
end

local v12 = {}
local v13 = { __index = v12 }
local v14 = table.freeze(v13)

function v12.Insert(v15, v16, v17) -- line 23
    local v18 = typeof(v16) == "Vector3"
    assert(v18)
    local Epsilon = v15.Epsilon
    local v19 = v16.Y // Epsilon
    local v20 = v16.X // Epsilon
    local v21 = bit32.band(v20, 262143) * 262144
    local v22 = v16.Z // Epsilon
    local v23 = (v21 + bit32.band(v22, 262143)) * 131072 + bit32.band(v19, 131071)
    local Table = v15.Table
    if not Table[v23] then
        Table[v23] = {}
    end
    local v24 = Table[v23]
    local v25 = {
        Pos = v16,
        Value = v17
    }
    table.insert(v24, v25)
end

function v12.Remove(v26, v27, v28) -- line 37
    local v29 = typeof(v27) == "Vector3"
    assert(v29)
    local Epsilon = v26.Epsilon
    local v30 = v27.X // Epsilon
    local v31 = v27.Y // Epsilon
    local v32 = bit32.band(v30, 262143) * 262144
    local v33 = v27.Z // Epsilon
    local v34 = (v32 + bit32.band(v33, 262143)) * 131072 + bit32.band(v31, 131071)
    local v35 = v26.Table[v34]
    if not v35 then
        return
    end
    local v36 = #v35
    for v37 = v36, 1, -1 do
        if v35[v37].Value == v28 then
            table.remove(v35, v37)
        end
    end
    if #v35 == 0 then
        (nil).Table[v34] = nil
    end
end

function v12.Collect(v38, v39, v40) -- line 63
    local v41 = typeof(v39) == "Vector3"
    assert(v41)
    local v42
    if v40 == nil then
        v42 = true
    elseif type(v40) == "number" and v40 > 0 then
        v42 = math.floor(v40) == v40
    else
        v42 = false
    end
    assert(v42)
    local Epsilon = v38.Epsilon
    local v43 = v39.X // Epsilon
    local v44 = v39.Y // Epsilon
    local v45 = v39.Z // Epsilon
    local Table = v38.Table
    local v46 = v40 or 1
    local v47 = {}
    local v48 = -v46
    local v49 = 0
    for v50 = v48, v46 do
        local v51 = -v46
        for v52 = v51, v46 do
            local v53 = -v46
            for v54 = v53, v46 do
                local v55 = v43 + v50
                local v56 = bit32.band(v55, 262143) * 262144
                local v57 = v45 + v54
                local v58 = (v56 + bit32.band(v57, 262143)) * 131072
                local v59 = v44 + v52
                local v60 = Table[v58 + bit32.band(v59, 131071)]
                if v60 then
                    local v61 = v49
                    for v62, v63 in ipairs(v60) do
                        v61 += 1
                        v47[v61] = v63.Value
                        v49 = v61
                    end
                end
            end
        end
    end
    v47.n = v49
    return v47
end

function v12.Query(v64, v65, v66) -- line 101
    local v67 = typeof(v65) == "Vector3"
    assert(v67)
    local v68
    if v66 == nil then
        v68 = true
    elseif type(v66) == "number" and v66 > 0 then
        v68 = math.floor(v66) == v66
    else
        v68 = false
    end
    assert(v68)
    local Epsilon = v64.Epsilon
    local v69 = v65.X // Epsilon
    local v70 = v65.Y // Epsilon
    local v71 = v65.Z // Epsilon
    local Table = v64.Table
    local v72 = v66 or 1
    local v73 = -v72
    local v74, v75
    for v76 = v73, v72 do
        local v77 = -v72
        for v78 = v77, v72 do
            local v79 = -v72
            for v80 = v79, v72 do
                local v81 = v69 + v76
                local v82 = bit32.band(v81, 262143) * 262144
                local v83 = v71 + v80
                local v84 = (v82 + bit32.band(v83, 262143)) * 131072
                local v85 = v70 + v78
                local v86 = Table[v84 + bit32.band(v85, 131071)]
                if v86 then
                    local v87 = v74
                    local v88 = v75
                    for v89, v90 in ipairs(v86) do
                        local Magnitude = (v90.Pos - v65).Magnitude
                        if v88 then
                            if v88 <= Magnitude then
                            end
                        else
                            v87 = v90.Value
                            v88 = Magnitude
                        end
                        v74 = v87
                        v75 = v88
                    end
                end
            end
        end
    end
    return v74
end

table.freeze(v12)
local freeze = table.freeze
local v91 = {}

function v91.new(v92, v93) -- line 145 | captures: v14
    local v94
    if v92 == nil then
        v94 = true
    elseif type(v92) == "number" then
        v94 = v92 > 0
    else
        v94 = false
    end
    assert(v94)
    local v95 = {
        Table = {},
        Epsilon = v92 or 10
    }
    return (setmetatable(v95, v14))
end

return freeze(v91)
