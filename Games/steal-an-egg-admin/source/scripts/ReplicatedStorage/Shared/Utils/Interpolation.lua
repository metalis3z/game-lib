-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Numeric = require(script.Parent.Numeric)
local v1 = {
    Circular = "Circ",
    Exponential = "Expo"
}
local v2 = {}

v2[0] = 0
v2[1] = 1

local v3 = {}
local v4 = {
    edge = 0.9090909090909091,
    shift = 0.8181818181818182,
    lift = 0.9375
}

v3[1] = {
    edge = 0.36363636363636365,
    shift = 0,
    lift = 0
}
v3[2] = {
    edge = 0.7272727272727273,
    shift = 0.5454545454545454,
    lift = 0.75
}
v3[3] = v4

local v5 = {
    "Quad",
    "Cubic",
    "Quart",
    "Quint",
    "Sine",
    "Expo",
    "Circ",
    "Elastic",
    "Back",
    "Bounce"
}
local v6 = {}

local function integerPower(v7, v8) -- line 29
    local v9 = v7
    for v10 = 2, v8 do
        v9 *= v7
    end
    return v9
end

local function bounceOut(v11) -- line 38 | captures: v3
    for v12, v13 in v3 do
        if v11 < v13.edge then
            local v14 = v11 - v13.shift
            return v14 * 7.5625 * v14 + v13.lift
        end
    end
    local v15 = v11 - 0.9545454545454546
    return v15 * 7.5625 * v15 + 0.984375
end

local v16 = {
    BackIn = function(v17) -- BackIn | line 53
        return v17 * v17 * (v17 * 2.70158 - 1.70158)
    end,
    BackOut = function(v18) -- BackOut | line 56
        local v19 = v18 - 1
        return v19 * v19 * (v19 * 2.70158 + 1.70158) + 1
    end,
    BackInOut = function(v20) -- BackInOut | line 60
        local v21 = v20 * 2
        local v22 = v21 - 2
        if v21 < 1 then
            return v21 * v21 * (3.5949095 * v21 - 2.5949095) * 0.5
        end
        return (v22 * v22 * (3.5949095 * v22 + 2.5949095) + 2) * 0.5
    end,
    BounceOut = bounceOut
}

function v16.BounceIn(v23) -- line 69 | captures: bounceOut
    return 1 - bounceOut(1 - v23)
end

function v16.BounceInOut(v24) -- line 72 | captures: bounceOut
    if v24 < 0.5 then
        return (1 - bounceOut(1 - v24 * 2)) * 0.5
    end
    return bounceOut(v24 * 2 - 1) * 0.5 + 0.5
end

local function CircIn(v25) -- line 78
    local v26 = 1 - v25 * v25
    return 1 - math.sqrt(v26)
end

v16.CircIn = CircIn

local function CircOut(v27) -- line 81
    local v28 = v27 - 1
    local v29 = 1 - v28 * v28
    return (math.sqrt(v29))
end

v16.CircOut = CircOut

local function CircInOut(v30) -- line 85
    local v31 = v30 * 2
    local v32 = v31 - 2
    if v31 < 1 then
        local v33 = 1 - v31 * v31
        return (1 - math.sqrt(v33)) * 0.5
    end
    local v34 = 1 - v32 * v32
    return (math.sqrt(v34) + 1) * 0.5
end

v16.CircInOut = CircInOut

local function CubicIn(v35) -- line 93
    return v35 * v35 * v35
end

v16.CubicIn = CubicIn

local function CubicOut(v36) -- line 96
    local v37 = v36 - 1
    return v37 * v37 * v37 + 1
end

v16.CubicOut = CubicOut

local function CubicInOut(v38) -- line 100
    local v39 = v38 * 2
    if v39 < 1 then
        return v39 * v39 * v39 * 0.5
    end
    local v40 = v39 - 2
    return (v40 * v40 * v40 + 2) * 0.5
end

v16.CubicInOut = CubicInOut

function v16.ElasticIn(v41) -- line 108 | captures: v2
    local v42 = v2[v41]
    if v42 then
        return v42
    end
    local v43 = v41 - 1
    local v44 = 2 ^ (v43 * 10)
    local v45 = (v43 - 0.075) * 6.283185307179586 / 0.3
    return -(v44 * math.sin(v45))
end

function v16.ElasticOut(v46) -- line 116 | captures: v2
    local v47 = v2[v46]
    if v47 then
        return v47
    end
    local v48 = 2 ^ (v46 * -10)
    local v49 = (v46 - 0.075) * 6.283185307179586 / 0.3
    return v48 * math.sin(v49) + 1
end

function v16.ElasticInOut(v50) -- line 123 | captures: v2
    local v51 = v2[v50]
    if v51 then
        return v51
    end
    local v52 = v50 * 2
    local v53 = v52 - 1
    local v54 = (v53 - 0.1125) * 6.283185307179586 / 0.45
    local v55 = math.sin(v54)
    if v52 < 1 then
        return 2 ^ (v53 * 10) * v55 * -0.5
    end
    return 2 ^ (v53 * -10) * v55 * 0.5 + 1
end

local function ExpoIn(v56) -- line 136
    if v56 == 0 then
        return 0
    end
    return 2 ^ ((v56 - 1) * 10) - 0.001
end

v16.ExpoIn = ExpoIn

local function ExpoOut(v57) -- line 142
    if v57 == 1 then
        return 1
    end
    return 1.001 * (1 - 2 ^ (v57 * -10))
end

v16.ExpoOut = ExpoOut

function v16.ExpoInOut(v58) -- line 148 | captures: v2
    local v59 = v2[v58]
    if v59 then
        return v59
    end
    local v60 = v58 * 2 - 1
    if v58 < 0.5 then
        return 2 ^ (v60 * 10) * 0.5 - 0.0005
    end
    return 0.50025 * (2 - 2 ^ (v60 * -10))
end

local function QuadIn(v61) -- line 159
    return v61 * v61
end

v16.QuadIn = QuadIn

local function QuadOut(v62) -- line 162
    return v62 * (2 - v62)
end

v16.QuadOut = QuadOut

local function QuadInOut(v63) -- line 165
    local v64 = v63 * 2
    if v64 < 1 then
        return v64 * v64 * 0.5
    end
    return ((v64 - 1) * (v64 - 3) - 1) * -0.5
end

v16.QuadInOut = QuadInOut

local function QuartIn(v65) -- line 172
    return v65 * v65 * v65 * v65
end

v16.QuartIn = QuartIn

local function QuartOut(v66) -- line 175
    local v67 = v66 - 1
    return 1 - v67 * v67 * v67 * v67
end

v16.QuartOut = QuartOut

local function QuartInOut(v68) -- line 179
    local v69 = v68 * 2
    if v69 < 1 then
        return v69 * v69 * v69 * v69 * 0.5
    end
    local v70 = v69 - 2
    return (2 - v70 * v70 * v70 * v70) * 0.5
end

v16.QuartInOut = QuartInOut

local function QuintIn(v71) -- line 187
    return v71 * v71 * v71 * v71 * v71
end

v16.QuintIn = QuintIn

local function QuintOut(v72) -- line 190
    local v73 = v72 - 1
    return v73 * v73 * v73 * v73 * v73 + 1
end

v16.QuintOut = QuintOut

local function QuintInOut(v74) -- line 194
    local v75 = v74 * 2
    if v75 < 1 then
        return v75 * v75 * v75 * v75 * v75 * 0.5
    end
    local v76 = v75 - 2
    return (v76 * v76 * v76 * v76 * v76 + 2) * 0.5
end

v16.QuintInOut = QuintInOut

local function SineIn(v77) -- line 202
    local v78 = v77 * 1.5707963267948966
    return 1 - math.cos(v78)
end

v16.SineIn = SineIn

local function SineOut(v79) -- line 205
    local v80 = v79 * 1.5707963267948966
    return (math.sin(v80))
end

v16.SineOut = SineOut

local function SineInOut(v81) -- line 208
    local v82 = 3.141592653589793 * v81
    return (1 - math.cos(v82)) * 0.5
end

v16.SineInOut = SineInOut
for v83, v84 in v5 do
    local v85 = v16[v84 .. "Out"]
    local v86 = v16[v84 .. "In"]
    if v84 ~= "Sine" then
        u88 = 1
    end
    local v87 = v84 .. "OutIn"

    v16[v87] = function(v88) -- line 223 | captures: v85, v86
        if v88 < 0.5 then
            return (v85(v88 * 2))
        end
        return (v86(v88 * 2 - u88))
    end
end

local function componentName(v89, v90) -- line 230
    if v89 == nil then
        return "Sine"
    end
    local v91 = if typeof(v89) == "string" then v89 else v89.Name
    if type(v91) == "string" then
        return v91
    end
    local v92 = tostring(v91)
    return (string.sub(v92, v90))
end

function v6.Ease(v93, v94, v95) -- line 246 | captures: v1, v16
    local v96
    if v94 == nil then
        v96 = "Sine"
    else
        if typeof(v94) == "string" then
            v96 = v94
        else
            v96 = v94.Name
        end
        if type(v96) ~= "string" then
            local v97 = tostring(v96)
            v96 = string.sub(v97, 18)
        end
    end
    local v98
    if v95 == nil then
        v98 = "Sine"
    else
        if typeof(v95) == "string" then
            v98 = v95
        else
            v98 = v95.Name
        end
        if type(v98) ~= "string" then
            local v99 = tostring(v98)
            v98 = string.sub(v99, 22)
        end
    end
    local v100 = v1[v96] or v96
    if v100 == "Linear" then
        return v93
    end
    local v101 = v100 .. v98
    local v102 = v16[v101]
    if v102 then
        return (v102(v93))
    end
    return (error((("no easing curve is registered under %*"):format(v101))))
end

function v6.SpatialCurve(...) -- line 291 | captures: Numeric
    local v103 = table.pack(...)
    local v104 = v103.n - 1
    local v105 = 0
    for v106 = 1, v104 do
        v105 += (v103[v106] - v103[v106 + 1]).Magnitude
    end
    local v107 = table.create(v104 + 1)
    for v108 = 0, v104 do
        v107[v108 + 1] = Numeric.Binomial(v104, v108)
    end
    return function(v109) -- line 306 | captures: v103, v104, v107
            local v110 = Vector3.new(0, 0, 0)
            for v111 = 0, v104 do
                v110 += v103[v111 + 1] * (v107[v111 + 1] * (1 - v109) ^ (v104 - v111) * v109 ^ v111)
            end
            return v110
        end,
        v105
end

function v6.PlanarCurve(...) -- line 316 | captures: Numeric
    local v112 = table.pack(...)
    local v113 = v112.n - 1
    local v114 = table.create(v113 + 1)
    for v115 = 0, v113 do
        v114[v115 + 1] = Numeric.Binomial(v113, v115)
    end
    return function(v116) -- line 325 | captures: v112, v113, v114
        local v117 = Vector2.new()
        for v118 = 0, v113 do
            v117 += v112[v118 + 1] * (v114[v118 + 1] * (1 - v116) ^ (v113 - v118) * v116 ^ v118)
        end
        return v117
    end
end

return table.freeze(v6)
