-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Types)

local function SampleCurve(v1, v2, v3, v4) -- line 8
    return ((v1 * v4 + v2) * v4 + v3) * v4
end

local function SampleDerivative(v5, v6, v8, v9) -- line 11
    return (v5 * 3 * v9 + v6 * 2) * v9 + v8
end

local function SolveCubicBezier(v10, v11, v12, v13, v14) -- line 14
    if v14 <= 0 then
        return 0
    end
    if v14 >= 1 then
        return 1
    end
    if v10 == v11 then
        if v12 == v13 then
            return v14
        end
    else
        local v15 = v10 * 3
        local v16 = (v12 - v10) * 3 - v15
        local v17 = 1 - v15 - v16
        local v18 = v11 * 3
        local v19 = (v13 - v11) * 3 - v18
        local v20 = 1 - v18 - v19
        local v21 = v14
        for v22 = 1, 8 do
            local v23 = ((v17 * v21 + v16) * v21 + v15) * v21 - v14
            local v24 = math.abs(v23)
            if v24 < 0.0000001 then
                return ((v20 * v21 + v19) * v21 + v18) * v21
            end
            local v25 = (v17 * 3 * v21 + v16 * 2) * v21 + v15
            if math.abs(v25) < 0.0000001 then
                break
            end
            v21 -= v23 / v24
        end
        local v26 = v14
        local v27 = 0
        local v28 = 1
        for v29 = 1, 16 do
            local v30 = ((v17 * v26 + v16) * v26 + v15) * v26 - v14
            if math.abs(v30) < 0.0000001 then
                break
            end
            if v30 <= 0 then
                v27 = v26
            else
                v28 = v26
            end
            v26 = (v27 + v28) * 0.5
        end
        return ((v20 * v26 + v19) * v26 + v18) * v26
    end
end

local function NormalizeHandle(v31, v32) -- line 73
    if type(v31) == "number" then
        return v31
    end
    return v31[v32 or 1] or 0
end

local function LerpScalar(v33, v34, v35) -- line 79
    return v33 + (v34 - v33) * v35
end

local function LerpArray(v36, v37, v38) -- line 82
    local v39 = table.create(#v36)
    local v40 = #v36
    for v41 = 1, v40 do
        local v42 = v37[v41] or v36[v41]
        v39[v41] = v36[v41] + (v42 - v36[v41]) * v7
    end
    return v39
end

local function LerpBezierShape(v43, v44, v45) -- line 97
    local v46 = table.create(#v43.v)
    local v47 = table.create(#v43.i)
    local v48 = table.create(#v43.o)
    local v49 = #v43.v
    for v50 = 1, v49 do
        local v51 = v43.v[v50]
        local v52 = v44.v[v50]
        local v53 = v43.i[v50]
        local v54 = v44.i[v50]
        local v55 = v43.o[v50]
        local v56 = v44.o[v50]
        v46[v50] = {
            v51[1] + (v52[1] - v51[1]) * v45,
            v51[2] + (v52[2] - v51[2]) * v45
        }
        v47[v50] = {
            v53[1] + (v54[1] - v53[1]) * v45,
            v53[2] + (v54[2] - v53[2]) * v45
        }
        v48[v50] = {
            v55[1] + (v56[1] - v55[1]) * v45,
            v55[2] + (v56[2] - v55[2]) * v45
        }
    end
    return {
        v = v46,
        i = v47,
        o = v48,
        c = v43.c
    }
end

local function FindKeyframes(v57, v58) -- line 117
    local v59 = #v57
    if v59 == 0 then
        return nil, nil, 0
    end
    if v59 == 1 then
        return v57[1], nil, 0
    end
    local v60 = v57[1]
    if v58 <= v60.t then
        return v60, nil, 0
    end
    for v61 = 2, v59 do
        local v62 = v57[v61]
        if v58 < v62.t then
            return v57[v61 - 1], v62, v61 - 1
        end
    end
    return v57[v59], nil, v59
end

local function ExtractValue(v63) -- line 140
    if v63 == nil or #v63 == 0 then
        return nil
    end
    local v64 = v63[1]
    if type(v64) == "table" then
        return v63[1]
    end
    return v63
end

local function Evaluate(v65, v66) -- line 149 | captures: SolveCubicBezier, LerpArray, LerpBezierShape, FindKeyframes
    local a = v65.a
    local k = v65.k
    if a == nil then
        if type(k) == "number" then
            return k
        end
        if type(k) == "table" then
            if not (#k <= 0) then
                local v67 = k[1]
                if type(v67) == "table" then
                    return k[1]
                end
            end
            return k
        end
        return nil
    end
    if a == 0 then
        if type(k) == "number" then
            return k
        end
        if type(k) == "table" then
            if not (#k <= 0) then
                local v68 = k[1]
                if type(v68) == "table" then
                    return k[1]
                end
            end
            return k
        end
        return nil
    end
    local v69, v70 = FindKeyframes(k, v66)
    if v69 == nil then
        return nil
    end
    if v70 == nil then
        local s = v69.s
        if s == nil or #s == 0 then
            s = nil
        else
            local v71 = s[1]
            if type(v71) == "table" then
                s = s[1]
            end
        end
        if s == nil then
            local e = v69.e
            if e == nil or #e == 0 then
                return nil
            end
            local v72 = e[1]
            if type(v72) == "table" then
                return e[1]
            end
            return e
        end
        return s
    end
    if v69.h == 1 then
        local s = v69.s
        if s == nil or #s == 0 then
            return nil
        end
        local v73 = s[1]
        if type(v73) == "table" then
            return s[1]
        end
        return s
    end
    local t = v69.t
    local v74 = v70.t - t
    if v74 <= 0 then
        local s = v69.s
        if s == nil or #s == 0 then
            return nil
        end
        local v75 = s[1]
        if type(v75) == "table" then
            return s[1]
        end
        return s
    end
    local v76 = (v66 - t) / v74
    local v77 = math.clamp(v76, 0, 1)
    local s = v69.s
    if s == nil or #s == 0 then
        s = nil
    else
        local v78 = s[1]
        if type(v78) == "table" then
            s = s[1]
        end
    end
    local s_2 = v70.s
    if s_2 == nil or #s_2 == 0 then
        s_2 = nil
    else
        local v79 = s_2[1]
        if type(v79) == "table" then
            s_2 = s_2[1]
        end
    end
    if not s_2 then
        s_2 = v69.e
        if s_2 == nil or #s_2 == 0 then
            s_2 = nil
        else
            local v80 = s_2[1]
            if type(v80) == "table" then
                s_2 = s_2[1]
            end
        end
    end
    if s ~= nil then
        local v81 = false
        local v82 = false
        local v83 = false
        local v84 = false
        if s_2 == nil then
            v84 = true
        else
            v81 = true
        end
        local o, i, v85
        if v81 then
            o = v69.o
            i = v69.i
            if o then
                v82 = true
            else
                v85 = v77
                v84 = false
            end
        end
        v81 = false
        if v82 then
            if i then
                v81 = true
            else
                v85 = v77
                v84 = false
            end
        end
        v82 = false
        local x
        if v81 then
            x = o.x
            if type(x) == "number" then
                v83 = true
            else
                v82 = true
            end
        end
        v81 = false
        local v86
        if v82 then
            v86 = x[1] or 0
            v81 = true
        end
        v82 = false
        if v83 then
            v86 = x
            v81 = true
        end
        v83 = false
        local y
        if v81 then
            y = o.y
            if type(y) == "number" then
                v82 = true
            else
                v83 = true
            end
        end
        v81 = false
        local v87
        if v83 then
            v87 = y[1] or 0
            v81 = true
        end
        v83 = false
        if v82 then
            v87 = y
            v81 = true
        end
        v82 = false
        local x_2
        if v81 then
            x_2 = i.x
            if type(x_2) == "number" then
                v83 = true
            else
                v82 = true
            end
        end
        v81 = false
        local v88
        if v82 then
            v88 = x_2[1] or 0
            v81 = true
        end
        v82 = false
        if v83 then
            v88 = x_2
            v81 = true
        end
        v83 = false
        local y_2
        if v81 then
            y_2 = i.y
            if type(y_2) == "number" then
                v82 = true
            else
                v83 = true
            end
        end
        v81 = false
        local v89
        if v83 then
            v89 = y_2[1] or 0
            v81 = true
        end
        if v82 then
            v89 = y_2
            v81 = true
        end
        if v81 then
            v85 = SolveCubicBezier(v86, v87, v88, v89, v77)
            v84 = false
        end
        if not v84 then
            if type(s) == "number" then
                return s + (s_2 - s) * v85
            end
            if type(s) == "table" then
                if not (#s <= 0) then
                    local v90 = s[1]
                    if type(v90) == "number" then
                        return (LerpArray(s, s_2, v85))
                    end
                end
                return (LerpBezierShape(s, s_2, v85))
            end
            return s
        end
    end
    return s or s_2
end

local v91 = {
    SolveCubicBezier = SolveCubicBezier,
    Evaluate = Evaluate
}

function v91.EvaluateScalar(v92, v93) -- line 317 | captures: Evaluate
    if v92 == nil then
        return v93
    end
    local v94 = Evaluate(v92, 0)
    if v94 == nil then
        return v93
    end
    if type(v94) == "number" then
        return v94
    end
    return type(v94) == "table" and v94[1] or v93
end

function v91.EvaluateScalarAtFrame(v95, v96, v97) -- line 333 | captures: Evaluate
    if v95 == nil then
        return v97
    end
    local v98 = Evaluate(v95, v96)
    if v98 == nil then
        return v97
    end
    if type(v98) == "number" then
        return v98
    end
    return type(v98) == "table" and v98[1] or v97
end

function v91.EvaluateVector(v99, v100, v101) -- line 349 | captures: Evaluate
    if v99 ~= nil then
        local v102 = Evaluate(v99, v100)
        if v102 ~= nil then
            if type(v102) == "table" then
                return v102
            end
            if type(v102) == "number" then
                return { v102 }
            end
        end
    end
    return v101
end

function v91.EvaluateColor(v103, v104) -- line 365 | captures: Evaluate
    if v103 ~= nil then
        local v105 = Evaluate(v103, v104)
        if v105 ~= nil and type(v105) == "table" then
            return Color3.new(v105[1] or 1, v105[2] or 1, v105[3] or 1)
        end
    end
    return Color3.new(1, 1, 1)
end

function v91.EvaluateBezierShape(v106, v107) -- line 378 | captures: Evaluate
    if v106 ~= nil then
        local v108 = Evaluate(v106, v107)
        if v108 ~= nil and type(v108) == "table" and not (#v108 <= 0) then
            local v109 = v108[1]
            if type(v109) == "number" then
                return nil
            end
            return v108
        end
    end
    return nil
end

v91.LerpArray = LerpArray
return (table.freeze(v91))
