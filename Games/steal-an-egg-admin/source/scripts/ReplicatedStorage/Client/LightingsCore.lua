-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Collections = require(Shared:WaitForChild("Utils").Collections)
local Stringify = require(ReplicatedStorage.UserGenerated.Strings.Stringify)
require(ReplicatedStorage.Data.Lightings.Types.Interface)

local function onCircle(v1, v2) -- line 12
    local v3
    if v1 >= 0 then
        v3 = v1
    else
        local v4 = -v1 / v2
        v3 = v1 + math.ceil(v4) * v2
    end
    return v3 % v2
end

local function shortestArc(v5, v6, v7) -- line 21
    local v8
    if v6 < 0 then
        local v9 = -v6 / v7
        v8 = v6 + math.ceil(v9) * v7
    else
        v8 = v6
    end
    local v10
    if v5 < 0 then
        local v11 = -v5 / v7
        v10 = v5 + math.ceil(v11) * v7
    else
        v10 = v5
    end
    local v12 = v8 % v7 - v10 % v7
    if v7 / 2 < v12 then
        return v12 - v7
    end
    if v12 < -v7 / 2 then
        return v12 + v7
    end
    return v12
end

local function alongCircle(v13, v14, v15, v16) -- line 39
    local v17
    if v14 < 0 then
        local v18 = -v14 / v15
        v17 = v14 + math.ceil(v18) * v15
    else
        v17 = v14
    end
    local v19
    if v13 < 0 then
        local v20 = -v13 / v15
        v19 = v13 + math.ceil(v20) * v15
    else
        v19 = v13
    end
    local v21 = v17 % v15 - v19 % v15
    if v15 / 2 < v21 then
        v21 -= v15
    elseif not (-v15 / 2 <= v21) then
        v21 += v15
    end
    return v13 + v21 * v16
end

local v22 = {
    clock = function(v23, v24, v25) -- clock | line 60
        local v26
        if v24 < 0 then
            local v27 = -v24 / 24
            v26 = v24 + math.ceil(v27) * 24
        else
            v26 = v24
        end
        local v28
        if v23 < 0 then
            local v29 = -v23 / 24
            v28 = v23 + math.ceil(v29) * 24
        else
            v28 = v23
        end
        local v30 = v26 % 24 - v28 % 24
        if v30 > 12 then
            v30 -= 24
        elseif not (v30 >= -12) then
            v30 += 24
        end
        return v23 + v30 * v25
    end,
    colour = function(v31, v32, v33) -- colour | line 80
        return v31:Lerp(v32, v33)
    end,
    latitude = function(v34, v35, v36) -- latitude | line 83
        local v37
        if v35 < 0 then
            local v38 = -v35 / 360
            v37 = v35 + math.ceil(v38) * 360
        else
            v37 = v35
        end
        local v39
        if v34 < 0 then
            local v40 = -v34 / 360
            v39 = v34 + math.ceil(v40) * 360
        else
            v39 = v34
        end
        local v41 = v37 % 360 - v39 % 360
        if v41 > 180 then
            v41 -= 360
        elseif not (v41 >= -180) then
            v41 += 360
        end
        return v34 + v41 * v36
    end,
    scalar = function(v42, v43, v44) -- scalar | line 103
        return (v43 - v42) * v44 + v42
    end,
    snap = function(v45, v46, v47) -- snap | line 106
        if v47 >= 0.5 then
            return v46
        end
        return v45
    end,
    whole = function(v48, v49, v50) -- whole | line 112
        local v51 = (v49 - v48) * v50 + v48
        return (math.round(v51))
    end
}
local v52 = {
    clock = "number",
    colour = "Color3",
    latitude = "number",
    scalar = "number"
}
local v53 = {}

v53[1] = {
    Key = "Ambient",
    Kind = "colour"
}
v53[2] = {
    Key = "Brightness",
    Kind = "scalar"
}
v53[3] = {
    Key = "ColorShift_Bottom",
    Kind = "colour"
}
v53[4] = {
    Key = "ColorShift_Top",
    Kind = "colour"
}
v53[5] = {
    Key = "EnvironmentDiffuseScale",
    Kind = "scalar"
}
v53[6] = {
    Key = "EnvironmentSpecularScale",
    Kind = "scalar"
}
v53[7] = {
    Key = "OutdoorAmbient",
    Kind = "colour"
}
v53[8] = {
    Key = "ShadowSoftness",
    Kind = "scalar"
}
v53[9] = {
    Key = "ClockTime",
    Kind = "clock"
}
v53[10] = {
    Key = "GeographicLatitude",
    Kind = "latitude"
}
v53[11] = {
    Key = "ExposureCompensation",
    Kind = "scalar"
}
v53[12] = {
    Key = "FogColor",
    Kind = "colour"
}
v53[13] = {
    Key = "FogEnd",
    Kind = "scalar"
}
v53[14] = {
    Key = "FogStart",
    Kind = "scalar"
}

local v54 = {
    Key = "Clouds",
    Class = "Clouds",
    Gated = true
}
local v55 = {}
local v56 = {
    Key = "Color",
    Kind = "colour",
    Fallback = Color3.new(1, 1, 1)
}

v55[1] = {
    Key = "Cover",
    Kind = "scalar",
    Fallback = 0
}
v55[2] = {
    Key = "Density",
    Kind = "scalar",
    Fallback = 0
}
v55[3] = v56
v55[4] = {
    Key = "Enabled",
    Kind = "snap",
    Fallback = true
}
v54.Fields = v55

local v57 = {}
local v58 = {
    Key = "Atmosphere",
    Class = "Atmosphere"
}
local v59 = {}
local v60 = {
    Key = "Color",
    Kind = "colour",
    Fallback = Color3.new(0, 0, 0)
}
local v61 = {
    Key = "Decay",
    Kind = "colour",
    Fallback = Color3.new(0, 0, 0)
}

v59[1] = {
    Key = "Density",
    Kind = "scalar",
    Fallback = 0
}
v59[2] = {
    Key = "Offset",
    Kind = "scalar",
    Fallback = 0
}
v59[3] = v60
v59[4] = v61
v59[5] = {
    Key = "Glare",
    Kind = "scalar",
    Fallback = 0
}
v59[6] = {
    Key = "Haze",
    Kind = "scalar",
    Fallback = 0
}
v58.Fields = v59

local v62 = {
    Key = "ColorCorrection",
    Class = "ColorCorrectionEffect",
    Child = "ColorCorrection",
    Gated = true
}
local v63 = {}
local v64 = {
    Key = "TintColor",
    Kind = "colour",
    Fallback = Color3.new(1, 1, 1)
}

v63[1] = {
    Key = "Brightness",
    Kind = "scalar",
    Fallback = 0
}
v63[2] = {
    Key = "Contrast",
    Kind = "scalar",
    Fallback = 0
}
v63[3] = {
    Key = "Enabled",
    Kind = "snap",
    Fallback = true
}
v63[4] = {
    Key = "Saturation",
    Kind = "scalar",
    Fallback = 0
}
v63[5] = v64
v62.Fields = v63

local v65 = {
    Key = "DepthOfField",
    Class = "DepthOfFieldEffect",
    Child = "DepthOfField",
    Gated = true
}
local v66 = {}
local v67 = {
    Key = "InFocusRadius",
    Kind = "scalar",
    Fallback = 50
}
local v68 = {
    Key = "NearIntensity",
    Kind = "scalar",
    Fallback = 0
}

v66[1] = {
    Key = "Enabled",
    Kind = "snap",
    Fallback = true
}
v66[2] = {
    Key = "FarIntensity",
    Kind = "scalar",
    Fallback = 0
}
v66[3] = {
    Key = "FocusDistance",
    Kind = "scalar",
    Fallback = 0
}
v66[4] = v67
v66[5] = v68
v65.Fields = v66

local v69 = {
    Key = "Blur",
    Class = "BlurEffect",
    Child = "Blur",
    Gated = true
}
local v70 = {}

v70[1] = {
    Key = "Enabled",
    Kind = "snap",
    Fallback = true
}
v70[2] = {
    Key = "Size",
    Kind = "scalar",
    Fallback = 0
}
v69.Fields = v70
v57[1] = v58
v57[2] = {
    Key = "Sky",
    Class = "Sky",
    Fields = {
        {
            Key = "CelestialBodiesShown",
            Kind = "snap",
            Fallback = false
        },
        {
            Key = "MoonAngularSize",
            Kind = "scalar",
            Fallback = 0
        },
        {
            Key = "MoonTextureId",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxBk",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxDn",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxFt",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxLf",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxRt",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "SkyboxUp",
            Kind = "snap",
            Fallback = ""
        },
        {
            Key = "StarCount",
            Kind = "whole",
            Fallback = 0
        },
        {
            Key = "SunAngularSize",
            Kind = "scalar",
            Fallback = 0
        },
        {
            Key = "SunTextureId",
            Kind = "snap",
            Fallback = ""
        }
    }
}
v57[3] = {
    Key = "Bloom",
    Class = "BloomEffect",
    Child = "Bloom",
    Gated = true,
    Fields = {
        {
            Key = "Enabled",
            Kind = "snap",
            Fallback = true
        },
        {
            Key = "Intensity",
            Kind = "scalar",
            Fallback = 0
        },
        {
            Key = "Size",
            Kind = "scalar",
            Fallback = 0
        },
        {
            Key = "Threshold",
            Kind = "scalar",
            Fallback = 4
        }
    }
}
v57[4] = v62
v57[5] = {
    Key = "SunRays",
    Class = "SunRaysEffect",
    Child = "SunRays",
    Gated = true,
    Fields = {
        {
            Key = "Enabled",
            Kind = "snap",
            Fallback = true
        },
        {
            Key = "Intensity",
            Kind = "scalar",
            Fallback = 0
        },
        {
            Key = "Spread",
            Kind = "scalar",
            Fallback = 0
        }
    }
}
v57[6] = v65
v57[7] = v69
v57[8] = v54

local v71 = {}
local v72 = {}
for v73, v74 in v53 do
    local Key = v74.Key
    table.insert(v72, Key)
end
for v75, v76 in v57 do
    local v77 = {}
    local v78 = {}
    for v79, v80 in v76.Fields do
        v77[v80.Key] = v80.Fallback
        local Key = v80.Key
        table.insert(v78, Key)
    end
    v71[v76.Key] = v77
    local v81 = {
        Key = v76.Key,
        Value = v78
    }
    table.insert(v72, v81)
end
local v82 = Stringify.CompileOrder(v72)

local function readFields(v83, v84) -- line 249
    local v85 = {}
    for v86, v87 in v83 do
        v85[v87.Key] = v84[v87.Key]
    end
    return v85
end

local function writeFields(v88, v89, v90) -- line 259
    for v91, v92 in v88 do
        v89[v92.Key] = v90[v92.Key]
    end
end

local function blendFields(v93, v94, v95, v96) -- line 267 | captures: v22
    local v97 = {}
    for v98, v99 in v93 do
        v97[v99.Key] = v22[v99.Kind](v94[v99.Key], v95[v99.Key], v96)
    end
    return v97
end

local function componentChild(v100, v101) -- line 277
    local v102 = v100:FindFirstChild(v101.Child or v101.Class)
    if v102 and v102:IsA(v101.Class) then
        return v102
    end
    return nil
end

local function readComponent(v103, v104) -- line 291
    local v105 = v103:FindFirstChild(v104.Child or v104.Class)
    if not (v105 and v105:IsA(v104.Class)) then
        v105 = nil
    end
    if v105 then
        local v106 = {}
        for v107, v108 in v104.Fields do
            v106[v108.Key] = v105[v108.Key]
        end
        return v106
    end
    return nil
end

local function writeComponent(v109, v110, v111) -- line 315
    local v112 = v109:FindFirstChild(v110.Child or v110.Class)
    if not (v112 and v112:IsA(v110.Class)) then
        v112 = nil
    end
    if v111 then
        if v112 then
            for v113, v114 in v110.Fields do
                v112[v114.Key] = v111[v114.Key]
            end
            return nil
        end
        local v115 = Instance.new(v110.Class)
        v115.Name = v110.Child or v110.Class
        for v116, v117 in v110.Fields do
            v115[v117.Key] = v111[v117.Key]
        end
        v115.Parent = v109
        return v115
    end
    if v112 then
        v112:Destroy()
    end
    return nil
end

local function blendComponent(v118, v119, v120, v121) -- line 357 | captures: v71, blendFields
    if v121 == 0 then
        return v119
    end
    if v121 == 1 then
        return v120
    end
    local v122, v123
    if v118.Gated then
        local v124
        if v119 then
            if v119.Enabled then
                v124 = v119
            end
        else
            v124 = v119
        end
        if v120 then
            if v120.Enabled then
                v123 = v120
            end
        else
            v123 = v120
        end
        v122 = v124
    else
        v122 = v119
        v123 = v120
    end
    if v122 then
        local v125 = v71[v118.Key]
        return (blendFields(v118.Fields, v122 or v125, v123 or v125, v121))
    end
    if v123 then
        local v126 = v71[v118.Key]
        return (blendFields(v118.Fields, v122 or v126, v123 or v126, v121))
    end
    return nil
end

local function readOverride(v127, v128) -- line 385 | captures: v52
    local v129 = v127:GetAttribute(v128.Key)
    if v129 ~= nil then
        local v130 = v52[v128.Kind]
        local v131 = typeof(v129) == v130
        local v132 = typeof(v129)
        local v133 = ("lighting override %* holds a %*, and that property takes a %*"):format(v128.Key, v132, v130)
        assert(v131, v133)
    end
    return v129
end

local v134 = {
    MEMBER_ORDER = v82,
    TEXT_STYLE = {
        Pretty = true,
        IndentChar = "\t",
        IndentSize = 1,
        Order = v82
    }
}

function v134.Describe(v135) -- line 399 | captures: Stringify, v134
    return Stringify.Pretty(v135, v134.TEXT_STYLE)
end

function v134.Capture(v136) -- line 402 | captures: v53, v57
    local v137 = {}
    for v138, v139 in v53 do
        v137[v139.Key] = v136[v139.Key]
    end
    local v140
    for v141, v142 in v57 do
        local Key = v142.Key
        local v143 = v136:FindFirstChild(v142.Child or v142.Class)
        if v143 then
            if v143:IsA(v142.Class) then
                v140 = v143
            end
        else
            v140 = nil
        end
        local v144
        if v140 then
            v144 = {}
            for v145, v146 in v142.Fields do
                v144[v146.Key] = v140[v146.Key]
            end
        end
        v137[Key] = v144
    end
    return v137
end

function v134.CaptureClouds(v147) -- line 443 | captures: v54
    local v148 = {}
    for v149, v150 in v54.Fields do
        v148[v150.Key] = v147[v150.Key]
    end
    return v148
end

function v134.Resolve(v151, v152) -- line 453 | captures: v52, v53, v57
    local v153 = {}
    for v154, v155 in v53 do
        local Key = v155.Key
        local v156 = v151:GetAttribute(v155.Key)
        if v156 ~= nil then
            local v157 = v52[v155.Kind]
            local v158 = typeof(v156) == v157
            local v159 = typeof(v156)
            local v160 = ("lighting override %* holds a %*, and that property takes a %*"):format(v155.Key, v159, v157)
            assert(v158, v160)
        end
        v153[Key] = v156 or v152[v155.Key]
    end
    local v161
    for v162, v163 in v57 do
        local Key = v163.Key
        local v164 = v151:FindFirstChild(v163.Child or v163.Class)
        if v164 then
            if v164:IsA(v163.Class) then
                v161 = v164
            end
        else
            v161 = nil
        end
        local v165
        if v161 then
            v165 = {}
            for v166, v167 in v163.Fields do
                v165[v167.Key] = v161[v167.Key]
            end
        end
        v153[Key] = v165 or v152[v163.Key]
    end
    return v153
end

function v134.Blend(v168, v169, v170) -- line 509 | captures: v53, v57, blendFields, blendComponent
    local v171 = blendFields(v53, v168, v169, v170)
    for v172, v173 in v57 do
        v171[v173.Key] = blendComponent(v173, v168[v173.Key], v169[v173.Key], v170)
    end
    return v171
end

function v134.Commit(v174, v175) -- line 519 | captures: v53, v57, writeComponent
    for v176, v177 in v53 do
        v174[v177.Key] = v175[v177.Key]
    end
    for v178, v179 in v57 do
        writeComponent(v174, v179, v175[v179.Key])
    end
end

function v134.CommitClouds(v180, v181) -- line 533 | captures: v54
    for v182, v183 in v54.Fields do
        v180[v183.Key] = v181[v183.Key]
    end
end

function v134.Draft(v184, v185, v186) -- line 541 | captures: Collections, v53, v57, writeComponent
    local Folder = Instance.new("Folder")
    for v187, v188 in v53 do
        if v186 then
            Folder:SetAttribute(v188.Key, v184[v188.Key])
        elseif v184[v188.Key] == v185[v188.Key] then
        end
    end
    for v189, v190 in v57 do
        if v186 then
            writeComponent(Folder, v190, v184[v190.Key])
        else
            local v191 = v184[v190.Key]
            if Collections.MatchesFast(v191, v185[v190.Key]) then
            end
        end
    end
    return Folder
end

return v134
