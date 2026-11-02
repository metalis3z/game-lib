-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = not game:GetService("RunService"):IsClient()
assert(v1)
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local EncodingService = game:GetService("EncodingService")
require(script.Types)
local Easing = require(script.Easing)
local v2 = Rect.new(64, 64, 192, 192)
local v3 = UDim2.fromScale(0, 0)
local v4 = UDim2.fromScale(1, 1)
local v5
local v6, v7 = pcall(require, script.PNG)

if v6 then
    v5 = v7
end

local function HexToColor3(v8) -- line 21
    local v9 = string.sub(v8, 2, 3)
    local v14 = tonumber(v9, 16) or 0
    local v15 = string.sub(v8, 4, 5)
    local v16 = tonumber(v15, 16) or 0
    local v17 = string.sub(v8, 6, 7)
    local v18 = tonumber(v17, 16) or 0
    return Color3.fromRGB(v14, v16, v18)
end

local function IsPropertyAnimated(v19) -- line 30
    if v19 == nil then
        return false
    end
    return v19.a == 1
end

local function HasAnimatedOpacity(v20) -- line 37
    if v20 == nil then
        return false
    end
    local o = v20.o
    if o == nil then
        return false
    end
    return o.a == 1
end

local function SubdivideCubicBezier(v21, v22, v23, v24, v25, v26, v27, v28, v29, v30) -- line 48
    for v31 = 1, v29 do
        local v32 = v31 / v29
        local v33 = 1 - v32
        local v34 = v33 * v33
        local v35 = v34 * v33
        local v36 = v32 * v32
        local v37 = v36 * v32
        local v38 = {
            v35 * v21 + v34 * 3 * v32 * v23 + v33 * 3 * v36 * v25 + v37 * v27,
            v35 * v22 + v34 * 3 * v32 * v24 + v33 * 3 * v36 * v26 + v37 * v28
        }
        table.insert(v30, v38)
    end
end

local function BezierShapeToPolyline(v39) -- line 62 | captures: SubdivideCubicBezier
    local v = v39.v
    local i = v39.i
    local o = v39.o
    local v40 = #v
    if v40 == 0 then
        return {}
    end
    local v41 = {}
    v41[1] = {
        v[1][1],
        v[1][2]
    }
    local v42 = if v39.c then v40 else v40 - 1
    for v43 = 1, v42 do
        local v44 = if v40 <= v43 then 1 else v43 + 1
        local v45 = v[v43]
        local v46 = v[v44]
        local v47 = o[v43]
        local v48 = i[v44]
        local v49 = v45[1]
        local v50 = v45[2]
        local v51 = v46[1]
        local v52 = v46[2]
        local v53 = v47[1]
        local v54
        if math.abs(v53) < 0.01 then
            local v55 = v47[2]
            if math.abs(v55) < 0.01 then
                local v56 = v48[1]
                if math.abs(v56) < 0.01 then
                    local v57 = v48[2]
                    v54 = math.abs(v57) < 0.01
                else
                    v54 = false
                end
            else
                v54 = false
            end
        else
            v54 = false
        end
        if v54 then
            local v58 = { v51, v52 }
            table.insert(v41, v58)
        else
            SubdivideCubicBezier(v49, v50, v49 + v47[1], v50 + v47[2], v46[1] + v48[1], v46[2] + v48[2], v51, v52, 12, v41)
        end
    end
    return v41
end

local function Cross2D(v59, v60, v61, v62, v63, v64) -- line 117
    return (v61 - v59) * (v64 - v60) - (v62 - v60) * (v63 - v59)
end

local function PointInTriangle(v65, v66, v67, v68, v69, v70, v71, v72) -- line 120
    local v73 = (v67 - v65) * (v70 - v66) - (v68 - v66) * (v69 - v65)
    local v74 = (v69 - v65) * (v72 - v66) - (v70 - v66) * (v71 - v65)
    local v75 = (v71 - v65) * (v68 - v66) - (v72 - v66) * (v67 - v65)
    local v76 = if v73 >= 0 and v74 >= 0 then v75 < 0 else true
    local v77 = if v73 <= 0 and v74 <= 0 then v75 > 0 else true
    return not (v76 and v77)
end

local function IsConvexPolygon(v78) -- line 128
    local v79 = #v78
    if v79 < 3 then
        return false
    end
    local v80 = 0
    for v81 = 1, v79 do
        local v82 = if v79 <= v81 then 1 else v81 + 1
        local v83 = if v79 <= v82 then 1 else v82 + 1
        local v84 = (nil)[v81][1]
        local v85 = (nil)[v81][2]
        local v86 = ((nil)[v82][1] - v84) * ((nil)[v83][2] - v85) - ((nil)[v82][2] - v85) * ((nil)[v83][1] - v84)
        if v86 ~= 0 then
            if v80 == 0 then
                if v86 <= 0 then
                    v80 = -1
                else
                    v80 = 1
                end
            elseif not (v86 > 0 and v80 < 0) then
                if v86 < 0 and v80 > 0 then
                    return false
                end
            else
                return false
            end
        end
    end
    return true
end

local function TriangulateFan(v87) -- line 168
    local v88 = {}
    local v89 = #v87 - 1
    for v90 = 2, v89 do
        local v91 = {
            v87[1],
            v87[v90],
            v87[v90 + 1]
        }
        table.insert(v88, v91)
    end
    return v88
end

local function TriangulateEarClip(v92) -- line 177 | captures: PointInTriangle, IsConvexPolygon, TriangulateFan
    local v93 = #v92
    if v93 < 3 then
        return {}
    end
    if v93 == 3 then
        return {
            {
                v92[1],
                v92[2],
                v92[3]
            }
        }
    end
    if IsConvexPolygon(v92) then
        return (TriangulateFan(v92))
    end
    local v94 = table.create(v93)
    local v95 = 0
    for v96 = 1, v93 do
        v94[v96] = v96
        local v97 = if v93 <= v96 then 1 else v96 + 1
        v95 += ((nil)[v97][1] - (nil)[v96][1]) * ((nil)[v97][2] + (nil)[v96][2])
    end
    local v98
    if v95 > 0 then
        v98 = table.create(v93)
        for v99 = 1, v93 do
            v98[v99] = v94[v93 - v99 + 1]
        end
    else
        v98 = v94
    end
    local v100 = {}
    local v101 = #v98
    local v102 = v101 * v101
    local v103 = 0
    local v104 = 1
    while true do
        local v105, v106, v107
        if v101 > 2 then
            if v102 <= v103 then
                v107 = true
            else
                v105 = v103 + 1
                if v101 < v104 then
                    v106 = 1
                else
                    v106 = v104
                end
                v107 = false
            end
        else
            v107 = true
        end
        if v107 then
            break
        end
        local v108 = if v106 <= 1 then v101 else v106 - 1
        local v109 = if v101 <= v106 then 1 else v106 + 1
        local v110 = (nil)[v98[v108]]
        local v111 = (nil)[v98[v106]]
        local v112 = (nil)[v98[v109]]
        local v113 = v110[1]
        local v114 = v110[2]
        if (v111[1] - v113) * (v112[2] - v114) - (v111[2] - v114) * (v112[1] - v113) <= 0 then
            v104 = v106 + 1
        else
            local v115 = true
            for v116 = 1, v101 do
                if v116 ~= v108 and v116 ~= v106 and v116 ~= v109 then
                    local v117 = (nil)[v98[v116]][1]
                    local v118 = (nil)[v98[v116]][2]
                    if PointInTriangle(v117, v118, v110[1], v110[2], v111[1], v111[2], v112[1], v112[2]) then
                        v115 = false
                        break
                    end
                end
                v115 = true
            end
            if v115 then
                local v119 = { v110, v111, v112 }
                table.insert(v100, v119)
                table.remove(v98, v106)
                v101 -= 1
                if v101 < v106 then
                    v104 = 1
                else
                    v104 = v106
                end
            else
                v104 = v106
            end
        end
        v103 = v105
    end
    return v100
end

local function CreateWedge(v120) -- line 270
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Image = "rbxassetid://83051256678409"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = v120
    return ImageLabel
end

local function UpdateTriangle(v121, v122, v123, v124, v125, v126, v127, v128, v129) -- line 279
    local v130 = v124 - v122
    local v131 = v125 - v123
    local v132 = v126 - v122
    local v133 = v127 - v123
    if v130 * v133 - v131 * v132 < 0 then
        v130, v131, v132, v133 = v126 - v122, v127 - v123, v124 - v122, v125 - v123
    end
    local v134 = v130 * v130 + v131 * v131
    local v135 = math.sqrt(v134)
    local v136 = v132 * v132 + v133 * v133
    local v137 = math.sqrt(v136)
    if not (v135 < 0.000001) and not (v137 < 0.000001) then
        local v138 = v130 / v135
        local v139 = v131 / v135
        local v140 = v132 * v138 + v133 * v139
        local v141 = v132 - v138 * v140
        local v142 = v133 - v139 * v140
        local v143 = v141 * v141 + v142 * v142
        local v144 = math.sqrt(v143)
        if v144 < 0.000001 then
            v121.A.Visible = false
            v121.B.Visible = false
        else
            local v145 = math.atan2(v139, v138) * 57.29577951308232
            local A = v121.A
            A.Visible = true
            A.Position = UDim2.fromScale(v122, v123)
            local v146 = math.max(v140, 0.0001)
            A.Size = UDim2.fromScale(v146, v144)
            A.Rotation = v145
            A.AnchorPoint = Vector2.zero
            A.ImageColor3 = v128
            A.ImageTransparency = v129
            local B = v121.B
            local v147 = v135 - v140
            B.Visible = v147 > 0.000001
            if B.Visible then
                B.Position = UDim2.fromScale(v122 + v138 * v135, v123 + v139 * v135)
                local v148 = math.max(v147, 0.0001)
                B.Size = UDim2.fromScale(v148, v144)
                B.Rotation = v145 + 180
                B.AnchorPoint = Vector2.zero
                B.ImageColor3 = v128
                B.ImageTransparency = v129
            end
        end
    else
        v121.A.Visible = false
        v121.B.Visible = false
    end
end

local function CreateTrianglePair(v149) -- line 333
    local v150 = {}
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Image = "rbxassetid://83051256678409"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = v149
    v150.A = ImageLabel
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Image = "rbxassetid://83051256678409"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.Size = UDim2.fromScale(1, 1)
    ImageLabel_2.Parent = v149
    v150.B = ImageLabel_2
    return v150
end

local function BuildFilledPath(v151, v152, v153, v154, v155, v156, v157) -- line 351 | captures: BezierShapeToPolyline, TriangulateEarClip, UpdateTriangle
    local v158 = BezierShapeToPolyline(v152)
    if #v158 < 3 then
        return
    end
    local v159 = table.create(#v158)
    for v160, v161 in v158 do
        v159[v160] = {
            v161[1] / v154,
            v161[2] / v155
        }
    end
    local v162 = TriangulateEarClip(v159)
    local v163 = v151.Triangles or {}
    for v164, v165 in v162 do
        local v166
        if #v163 < v164 then
            v166 = {}
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Image = "rbxassetid://83051256678409"
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.BorderSizePixel = 0
            ImageLabel.Size = UDim2.fromScale(1, 1)
            ImageLabel.Parent = v153
            v166.A = ImageLabel
            local ImageLabel_2 = Instance.new("ImageLabel")
            ImageLabel_2.Image = "rbxassetid://83051256678409"
            ImageLabel_2.BackgroundTransparency = 1
            ImageLabel_2.BorderSizePixel = 0
            ImageLabel_2.Size = UDim2.fromScale(1, 1)
            ImageLabel_2.Parent = v153
            v166.B = ImageLabel_2
            table.insert(v163, v166)
        else
            v166 = v163[v164]
        end
        UpdateTriangle(v166, v165[1][1], v165[1][2], v165[2][1], v165[2][2], v165[3][1], v165[3][2], v11, v12)
    end
    local v167 = #v163
    local v168 = #v162 + 1
    for v169 = v168, v167 do
        v163[v169].A.Visible = false
        v163[v169].B.Visible = false
    end
    v151.Triangles = v163
end

local function BuildStrokedPath(v170, v171, v172, v173, v174, v175, v176, v177, v178, v179, v180, v181) -- line 404 | captures: Easing, BezierShapeToPolyline
    local function v182(v183, ...)
        table.insert(v183, ...)
    end

    local v184 = BezierShapeToPolyline(v171)
    if #v184 < 2 then
        return
    end
    local v185 = v170.Segments or {}
    local v186 = v179 or 0
    local v187 = v180 or 100
    local v188 = v181 or 0
    local v189 = { 0 }
    local v190 = #v184
    local v191 = 0
    for v192 = 2, v190 do
        local v193 = v184[v192][1] - v184[v192 - 1][1]
        local v194 = v184[v192][2] - v184[v192 - 1][2]
        local v195 = v193 * v193 + v194 * v194
        v191 += math.sqrt(v195)
        v189[v192] = v191
    end
    local v196
    if v178 then
        v196 = {}
        for v197, v198 in v178 do
            if v198.v then
                v182(v196, Easing.EvaluateScalar(v198.v, 0))
            end
        end
        if not (#v196 > 0) then
            v196 = nil
        end
    end
    local v199 = v177 / math.min(v173, v174)
    local v200 = #v184
    local v201 = 0
    for v202 = 2, v200 do
        local v203 = v184[v202 - 1]
        local v204 = v184[v202]
        local v205 = v204[1] - v203[1]
        local v206 = v204[2] - v203[2]
        local v207 = v205 * v205 + v206 * v206
        local v208 = math.sqrt(v207)
        if v208 >= 0.01 then
            local v209 = ((v189[v202 - 1] + v189[v202]) * 0.5 / math.max(v191, 0.000001) * 100 + v188) % 100
            if v186 <= v209 and v209 <= v187 then
                local v210
                if v196 then
                    local v211 = 0
                    for v212, v213 in v196 do
                        v211 += v213
                    end
                    if v211 > 0 then
                        local v214 = 0
                        v210 = true
                        for v215, v216 in v196 do
                            v214 += v216
                            if v189[v202 - 1] % v211 < v214 then
                                v210 = v215 % 2 == 1
                                break
                            end
                            v210 = true
                        end
                    else
                        v210 = true
                    end
                else
                    v210 = true
                end
                v201 += 1
                local Frame
                if #v185 < v201 then
                    Frame = Instance.new("Frame")
                    Frame.BorderSizePixel = 0
                    Frame.AnchorPoint = Vector2.new(0, 0.5)
                    Frame.Parent = v172
                    table.insert(v185, Frame)
                else
                    Frame = v185[v201]
                end
                Frame.Visible = v210
                if v210 then
                    local v217 = math.atan2(v206, v205) * 57.29577951308232
                    Frame.Position = UDim2.fromScale(v203[1] / v173, v203[2] / v174)
                    Frame.Size = UDim2.fromScale(v208 / v173, v199)
                    Frame.Rotation = v217
                    Frame.BackgroundColor3 = v175
                    Frame.BackgroundTransparency = v176
                end
            end
        end
    end
    local v218 = #v185
    local v219 = v201 + 1
    for v220 = v219, v218 do
        v185[v220].Visible = false
    end
    v170.Segments = v185
end

local function BuildLinearGradient(v221, v222, v223, v224, v225) -- line 510 | captures: Easing
    local function v226(v227, ...)
        table.insert(v227, ...)
    end

    local UIGradient = Instance.new("UIGradient")
    local p = v222.p
    local v228 = Easing.EvaluateVector(v222.k, v225, {})
    local v229 = {}
    local v230 = p - 1
    for v231 = 0, v230 do
        local v232 = v231 * 4
        local v233 = v228[v232 + 1]
        if not v233 then
            local v234 = p - 1
            v233 = v231 / math.max(v234, 1)
        end
        local v235 = v228[v232 + 2] or 1
        local v236 = v228[v232 + 3] or 1
        local v237 = math.clamp(v233, 0, 1)
        v226(v229, ColorSequenceKeypoint.new(v237, Color3.new(v235, v236, v228[v232 + 4] or 1)))
    end
    if #v229 < 2 then
        v229 = {}
        v229[1] = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1))
        v229[2] = ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
    end
    UIGradient.Color = ColorSequence.new(v229)
    local v238 = Easing.EvaluateVector(v10, v11, { 0, 0 })
    local v239 = Easing.EvaluateVector(v12, v11, { 1, 0 })
    local v240 = v239[2] - v238[2]
    local v241 = v239[1] - v238[1]
    UIGradient.Rotation = math.atan2(v240, v241) * 57.29577951308232
    UIGradient.Parent = v13
    return UIGradient
end

local function BuildRadialGradientApprox(v242, v243, v244, v245, v246, v247, v248) -- line 543 | captures: Easing
    local p = v243.p
    local v249 = Easing.EvaluateVector(v243.k, v246, {})
    local v250 = Easing.EvaluateVector(v244, v246, {
        v247 / 2,
        v248 / 2
    })
    local v251 = Easing.EvaluateVector(v245, v246, {
        v247,
        v248 / 2
    })
    local v252 = v250[1]
    local v253 = v250[2]
    local v254 = v251[1] - v252
    local v255 = v251[2] - v253
    local v256 = v254 * v254 + v255 * v255
    local v257 = math.sqrt(v256)
    local v258 = {}
    local v259 = math.min(p, 6)
    for v260 = v259, 1, -1 do
        local v261 = v260 / v259
        local v262 = v261 * (p - 1)
        local v263 = math.floor(v262)
        local v264 = p - 1
        local v265 = math.min(v263, v264) * 4
        local v266 = v249[v265 + 2] or 1
        local v267 = v249[v265 + 3] or 1
        local v268 = v249[v265 + 4] or 1
        local v269 = v257 * 2 * v261
        local Frame = Instance.new("Frame")
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.Position = UDim2.fromScale(v252 / v247, v253 / v248)
        Frame.Size = UDim2.fromScale(v269 / v247, v269 / v248)
        Frame.BackgroundColor3 = Color3.new(v266, v267, v268)
        Frame.BackgroundTransparency = 0
        Frame.BorderSizePixel = 0
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.5, 0)
        UICorner.Parent = Frame
        Frame.Parent = v242
        table.insert(v258, Frame)
    end
    return v258
end

local function ApplyTransform(v270, v271, v272, v273, v274, v275, v276, v277) -- line 581 | captures: Easing
    if v271 == nil then
        return
    end
    local v278 = { 0, 0 }
    local p = v271.p
    if p ~= nil and type(p) == "table" then
        if p.s == true then
            v278 = {
                Easing.EvaluateScalarAtFrame(p.x, v272, 0),
                (Easing.EvaluateScalarAtFrame(p.y, v272, 0))
            }
        else
            v278 = Easing.EvaluateVector(p, v272, { 0, 0 })
        end
    end
    local v279 = Easing.EvaluateVector(v271.s, v272, { 100, 100 })
    local v280 = Easing.EvaluateScalarAtFrame(v271.r, v272, 0)
    local v281 = Easing.EvaluateScalarAtFrame(v271.o, v272, 100)
    local v282 = Easing.EvaluateVector(v271.a, v272, { 0, 0 })
    local v283 = v279[1] / 100
    local v284 = v279[2] / 100
    v270.Position = UDim2.fromScale(v278[1] / v273, v278[2] / v274)
    v270.Rotation = v280
    v270.Size = UDim2.fromScale(v276 * v283, v277 * v284)
    if v275 then
        v270.GroupTransparency = 1 - v281 / 100
    end
    local v285 = v276 * v283 * v273
    local v286 = v277 * v284 * v274
    if v282[1] == 0 then
        if v282[2] ~= 0 and v285 > 0 and v286 > 0 then
            local v287 = v282[1] / v285
            local v288 = math.clamp(v287, 0, 1)
            local v289 = v282[2] / v286
            v270.AnchorPoint = Vector2.new(v288, (math.clamp(v289, 0, 1)))
        end
    elseif v285 > 0 and v286 > 0 then
        local v290 = v282[1] / v285
        local v291 = math.clamp(v290, 0, 1)
        local v292 = v282[2] / v286
        v270.AnchorPoint = Vector2.new(v291, (math.clamp(v292, 0, 1)))
    end
end

local function CollectShapeInfo(v293) -- line 623
    local c, o, c_2, o_2, w, ks, da, s, e, o_3, m, v294, mm
    for v295, v296 in v293 do
        if not v296.hd then
            local ty = v296.ty
            if ty == "fl" then
                c, o = v296.c, v296.o
            elseif ty == "st" then
                c_2, o_2, w, da = v296.c, v296.o, v296.w, v296.da
            elseif ty == "sh" then
                ks = v296.ks
            elseif ty == "tr" then
                v294 = v296
            elseif ty == "tm" then
                s, e, o_3, m = v296.s, v296.e, v296.o, v296.m
            elseif ty == "mm" then
                mm = v296.mm
            end
        end
    end
    return c, o, c_2, o_2, w, ks, da, s, e, o_3, m, v294, mm
end

local v297

function v297(v298, v299, v300, v301, v302) -- line 668 | captures: v297, Easing, v3, v4, BuildFilledPath, BuildStrokedPath, BuildLinearGradient, BuildRadialGradientApprox, ApplyTransform, CollectShapeInfo
    local v303 = v298.it or {}
    local v304, v305, v306, v307, v308, v309, v310, v311, v312, v313, v314, v315 = CollectShapeInfo(v303)
    _ = v314
    local v316 = false
    for v317, v318 in v303 do
        if v318.ty == "tr" then
            local o = v318.o
            if o ~= nil and o.a == 1 then
                v316 = true
                break
            end
        end
        v316 = false
    end
    local v319
    if v316 then
        v319 = Instance.new("CanvasGroup")
    else
        v319 = Instance.new("Frame")
    end
    v319.BackgroundTransparency = 1
    v319.BorderSizePixel = 0
    v319.Size = v4
    v319.Position = v3
    v319.Parent = v299
    if v315 then
        ApplyTransform(v319, {
            a = v315.a,
            p = v315.p,
            s = v315.s,
            r = v315.r,
            o = v315.o
        }, v302, v300, v301, v316, 1, 1)
    end
    local v320 = {
        Shape = v298,
        Frame = v319
    }
    v320.Children = {}
    v320.FillColor = v304
    v320.FillOpacity = v305
    v320.StrokeColor = v306
    v320.StrokeOpacity = v307
    v320.StrokeWidth = v308
    v320.PathData = v309
    if v309 == nil then
        v320.IsAnimatedPath = false
    else
        v320.IsAnimatedPath = v309.a == 1
    end
    local v321 = Easing.EvaluateColor(v304, v302)
    local v322 = 1 - Easing.EvaluateScalarAtFrame(v305, v302, 100) / 100
    local v323 = Easing.EvaluateColor(v306, v302)
    local v324 = 1 - Easing.EvaluateScalarAtFrame(v307, v302, 100) / 100
    local v325 = Easing.EvaluateScalarAtFrame(v308, v302, 0)
    local v326 = Easing.EvaluateScalarAtFrame(v311, v302, 0)
    local v327 = Easing.EvaluateScalarAtFrame(v312, v302, 100)
    local v328 = Easing.EvaluateScalarAtFrame(v313, v302, 0)
    local v329 = 0
    for v330, v331 in v303 do
        if v331.ty == "op" and v331.a then
            v329 = Easing.EvaluateScalarAtFrame(v331.a, v302, 0)
        end
    end
    for v332, v333 in v303 do
        if not v333.hd then
            local ty = v333.ty
            if ty == "sh" then
                local v334 = Easing.EvaluateBezierShape(v333.ks, v302)
                if v334 and v329 ~= 0 then
                    local v335 = 0
                    local v336 = 0
                    for v337, v338 in v334.v do
                        v335, v336 = v335 + v338[1], v336 + v338[2]
                    end
                    local v339 = v335 / #v334.v
                    local v340 = v336 / #v334.v
                    local v341 = (v334.v[1][1] - v339) ^ 2 + (v334.v[1][2] - v340) ^ 2
                    local v342 = math.sqrt(v341)
                    local v343 = v329 / math.max(v342, 1) + 1
                    local v344 = table.create(#v334.v)
                    for v345, v346 in v334.v do
                        v344[v345] = {
                            v339 + (v346[1] - v339) * v343,
                            v340 + (v346[2] - v340) * v343
                        }
                    end
                    v334 = {
                        v = v344,
                        i = v334.i,
                        o = v334.o,
                        c = v334.c
                    }
                end
                if v334 then
                    if v304 then
                        BuildFilledPath(v320, v334, v319, v300, v301, v321, v322)
                    end
                    if v306 and v325 > 0 then
                        BuildStrokedPath(v320, v334, v319, v300, v301, v323, v324, v325, v310, v326, v327, v328)
                    end
                end
            elseif ty == "rc" then
                local Frame = Instance.new("Frame")
                Frame.BorderSizePixel = 0
                local v347 = Easing.EvaluateVector(v333.s, v302, { 100, 100 })
                local v348 = Easing.EvaluateVector(v333.p, v302, { 0, 0 })
                local v349 = Easing.EvaluateScalarAtFrame(v333.r, v302, 0)
                Frame.Size = UDim2.fromScale(v347[1] / v300, v347[2] / v301)
                Frame.Position = UDim2.fromScale(v348[1] / v300, v348[2] / v301)
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                if v304 then
                    Frame.BackgroundColor3 = v321
                    Frame.BackgroundTransparency = v322
                else
                    Frame.BackgroundTransparency = 1
                end
                if v349 > 0 then
                    local UICorner = Instance.new("UICorner")
                    UICorner.CornerRadius = UDim.new(0, v349)
                    UICorner.Parent = Frame
                    v320.UICorner = UICorner
                end
                if v306 and v325 > 0 then
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = v323
                    UIStroke.Transparency = v324
                    UIStroke.Thickness = v325 / math.min(v300, v301)
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    if not pcall(function() -- line 811 | captures: UIStroke
                            UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                        end) then
                        UIStroke.Thickness = v325
                    end
                    UIStroke.Parent = Frame
                    v320.UIStroke = UIStroke
                end
                Frame.Parent = v319
                v320.Frame = Frame
            elseif ty == "el" then
                local Frame = Instance.new("Frame")
                Frame.BorderSizePixel = 0
                local v350 = Easing.EvaluateVector(v333.s, v302, { 100, 100 })
                local v351 = Easing.EvaluateVector(v333.p, v302, { 0, 0 })
                Frame.Size = UDim2.fromScale(v350[1] / v300, v350[2] / v301)
                Frame.Position = UDim2.fromScale(v351[1] / v300, v351[2] / v301)
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                if v304 then
                    Frame.BackgroundColor3 = v321
                    Frame.BackgroundTransparency = v322
                else
                    Frame.BackgroundTransparency = 1
                end
                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0.5, 0)
                UICorner.Parent = Frame
                v320.UICorner = UICorner
                if v306 and v325 > 0 then
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = v323
                    UIStroke.Transparency = v324
                    UIStroke.Thickness = v325 / math.min(v300, v301)
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    pcall(function() -- line 846 | captures: UIStroke
                        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                    end)
                    UIStroke.Parent = Frame
                    v320.UIStroke = UIStroke
                end
                Frame.Parent = v319
                v320.Frame = Frame
            elseif ty == "gf" then
                local v352 = v333.t or 1
                if v333.g then
                    if v352 == 1 then
                        v320.UIGradient = BuildLinearGradient(v319, v333.g, v333.s, v333.e, v302)
                    elseif v352 == 2 then
                        BuildRadialGradientApprox(v319, v333.g, v333.s, v333.e, v302, v300, v301)
                    end
                end
            elseif ty ~= "gs" then
                if ty == "gr" then
                    local v353 = v297(v333, v319, v300, v301, v302)
                    if v320.Children then
                        local Children = v320.Children
                        table.insert(Children, v353)
                    end
                elseif ty == "rp" then
                    local v354 = Easing.EvaluateScalarAtFrame(v333.c, v302, 1)
                    local tr = v333.tr
                    if tr and v354 > 1 then
                        local v355 = Easing.EvaluateScalarAtFrame(tr.so, v302, 100)
                        local v356 = Easing.EvaluateScalarAtFrame(tr.eo, v302, 100)
                        local v357 = math.floor(v354) - 1
                        for v358 = 0, v357 do
                            local Frame = Instance.new("Frame")
                            Frame.BackgroundTransparency = 1
                            Frame.BorderSizePixel = 0
                            Frame.Size = v4
                            local v359 = v354 - 1
                            local v360 = v358 / math.max(v359, 1)
                            Frame.BackgroundTransparency = 1 - math.lerp(v355, v356, v360) / 100
                            local v361 = {
                                p = tr.p,
                                s = tr.s,
                                r = tr.r,
                                a = tr.a,
                                o = tr.o
                            }
                            local v362 = Easing.EvaluateVector(tr.p, v302, { 0, 0 })
                            Easing.EvaluateVector(tr.s, v302, { 100, 100 })
                            local v363 = Easing.EvaluateScalarAtFrame(tr.r, v302, 0)
                            Frame.Position = UDim2.fromScale(v362[1] * v358 / v300, v362[2] * v358 / v301)
                            Frame.Rotation = v363 * v358
                            Frame.Parent = v319
                            for v364, v365 in v303 do
                                if v365.ty == "gr" and v365 ~= v298 then
                                    v297(v365, Frame, v300, v301, v302)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return v320
end

local function BuildShapeLayer(v366, v367, v368, v369, v370) -- line 912 | captures: v297
    local shapes = v366.shapes
    if shapes == nil then
        return {}
    end
    local v371 = {}
    local v372 = #shapes
    for v373 = v372, 1, -1 do
        local v374 = shapes[v373]
        if not v374.hd and v374.ty == "gr" then
            local v375 = v297(v374, v367, v368, v369, v370)
            table.insert(v371, v375)
        end
    end
    return v371
end

local function BuildTextLayer(v376, v377, v378, v379, v380) -- line 931 | captures: v4
    local t = v376.t
    if t == nil then
        return nil
    end
    local d = t.d
    if d == nil then
        return nil
    end
    local k = d.k
    if k == nil or #k == 0 then
        return nil
    end
    local s, s_2
    for v381, v382 in k do
        if v382.t == nil then
            s_2 = v382.s
            s = s_2
        elseif v380 < v382.t then
        end
    end
    if s_2 == nil then
        s_2 = k[1].s
        s = s_2
    end
    if s_2 == nil then
        return nil
    end
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderSizePixel = 0
    TextLabel.Size = v4
    TextLabel.Text = s_2.t or ""
    TextLabel.TextScaled = false
    TextLabel.RichText = false
    TextLabel.TextSize = (s_2.s or 24) / v379 * 100
    if s_2.fc then
        local fc = s_2.fc
        TextLabel.TextColor3 = Color3.new(fc[1] or 1, fc[2] or 1, fc[3] or 1)
    end
    local v383 = s_2.j or 0
    if v383 == 0 then
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    elseif v383 == 1 then
        TextLabel.TextXAlignment = Enum.TextXAlignment.Right
    else
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    end
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    if s_2.f then
        local v384, v385 = pcall(function() -- line 985 | captures: s
            return Enum.Font[s.f]
        end)
        if v384 and v385 then
            TextLabel.Font = v385
        else
            TextLabel.Font = Enum.Font.GothamMedium
        end
    end
    TextLabel.Parent = v377
    return TextLabel
end

local function BuildImageLayer(v386, v387, v388, v389, v390) -- line 999 | captures: v5, AssetService, EncodingService, v4
    local refId = v386.refId
    if refId == nil then
        return nil
    end
    local v391 = v388[refId]
    if v391 == nil then
        return nil
    end
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = v4
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    if v391.e == 1 and v391.p then
        local p = v391.p
        if string.sub(p, 1, 22) == "data:image/png;base64," then
            local v392 = string.sub(p, 23)
            if v5 then
                local v393, v394 = pcall(function() -- line 1024 | captures: v392, v5, EncodingService
                    local v395 = EncodingService:Base64Decode(buffer.fromstring(v392))
                    return v5.decode(v395)
                end)
                if v393 and v394 then
                    local v396, v397 = pcall(function() -- line 1030 | captures: v394, AssetService
                        return AssetService:CreateEditableImage({ Size = Vector2.new(v394.width, v394.height) })
                    end)
                    if v396 and
                        v397 and
                        pcall(function() -- line 1033 | captures: v394, v397
                            local v398 = Vector2.new(v394.width, v394.height)
                            v397:WritePixelsBuffer(Vector2.zero, v398, v394.pixels)
                        end) then
                        ImageLabel.ImageContent = Content.fromObject(v397)
                    end
                end
            end
        elseif string.sub(p, 1, 23) == "data:image/jpeg;base64," then
            warn("[Lottie] Embedded JPEG not supported, skipping image layer:", v386.nm or "")
        end
    elseif v391.p and not v391.e then
        ImageLabel.Image = v391.p
    end
    ImageLabel.Parent = v387
    return ImageLabel
end

local function BuildDropShadow(v399, v400, v401, v402, v403) -- line 1052 | captures: Easing, v2
    local ef = v399.ef
    if ef ~= nil then
        for v404, v405 in ef do
            if v405.ty == 25 then
                local ef = v405.ef
                if ef ~= nil then
                    local v406 = Color3.new(0, 0, 0)
                    local v407 = 0.5
                    local v408 = 0
                    local v409 = 5
                    local v410 = 5
                    for v411, v412 in ef do
                        local ty = v412.ty
                        if ty ~= nil then
                            if ty == 1 then
                                v406 = Easing.EvaluateColor(v412.v, v403)
                            elseif ty == 0 then
                                v407 = Easing.EvaluateScalarAtFrame(v412.v, v403, 128) / 255
                            elseif ty == 3 then
                                v408 = Easing.EvaluateScalarAtFrame(v412.v, v403, 0)
                            elseif ty == 2 then
                                v409 = Easing.EvaluateScalarAtFrame(v412.v, v403, 5)
                            elseif ty == 4 then
                                v410 = Easing.EvaluateScalarAtFrame(v412.v, v403, 5)
                            end
                        end
                    end
                    local v413 = v408 + 180
                    local v414 = math.rad(v413)
                    local v415 = math.cos(v414) * v409 / v401
                    local v416 = math.sin(v414) * v409 / v402
                    local v417 = (v410 * 2 + math.max(v401, v402)) / math.max(v401, v402)
                    local ImageLabel = Instance.new("ImageLabel")
                    ImageLabel.Image = "rbxassetid://100849323991833"
                    ImageLabel.ScaleType = Enum.ScaleType.Slice
                    ImageLabel.SliceCenter = v2
                    ImageLabel.ImageColor3 = v406
                    ImageLabel.ImageTransparency = 1 - v407
                    ImageLabel.BackgroundTransparency = 1
                    ImageLabel.BorderSizePixel = 0
                    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                    ImageLabel.Position = UDim2.fromScale(v415 + 0.5, v416 + 0.5)
                    ImageLabel.Size = UDim2.fromScale(v417, v417)
                    ImageLabel.ZIndex = -1
                    ImageLabel.Parent = v400
                    return
                end
            end
        end
    end
end

local v418

function v418(v419, v420, v421, v422, v423, v424) -- line 1112 | captures: v418, Easing, v4, ApplyTransform, BuildShapeLayer, BuildTextLayer, BuildImageLayer, BuildDropShadow
    local v425 = {}
    local v426 = {}
    local v427 = #v419
    for v428 = v427, 1, -1 do
        local v429 = v419[v428]
        if not v429.hd then
            local ty = v429.ty
            local ks = v429.ks
            local v430
            if ks == nil then
                v430 = false
            else
                local o = ks.o
                if o == nil then
                    v430 = false
                else
                    v430 = o.a == 1
                end
            end
            local Frame
            if ty == 1 then
                local Frame_2 = Instance.new("Frame")
                Frame_2.BorderSizePixel = 0
                if v429.sc then
                    local sc = v429.sc
                    local v431 = string.sub(sc, 2, 3)
                    local v432 = tonumber(v431, 16) or 0
                    local v433 = string.sub(sc, 4, 5)
                    local v434 = tonumber(v433, 16) or 0
                    local v435 = string.sub(sc, 6, 7)
                    local v436 = tonumber(v435, 16) or 0
                    Frame_2.BackgroundColor3 = Color3.fromRGB(v432, v434, v436)
                else
                    Frame_2.BackgroundColor3 = Color3.new(0, 0, 0)
                end
                Frame_2.BackgroundTransparency = 0
                Frame_2.Size = UDim2.fromScale((v429.sw or v422) / v422, (v429.sh or v423) / v423)
                Frame = Frame_2
            else
                if v430 then
                    Frame = Instance.new("CanvasGroup")
                else
                    Frame = Instance.new("Frame")
                end
                Frame.BackgroundTransparency = 1
                Frame.BorderSizePixel = 0
                Frame.Size = v4
            end
            Frame.Name = v429.nm or ("Layer_%*"):format(v429.ind or v428)
            local Scale = Frame.Size.X.Scale
            local Scale_2 = Frame.Size.Y.Scale
            local v437 = {
                Layer = v429,
                Frame = Frame,
                BaseSizeX = Scale,
                BaseSizeY = Scale_2
            }
            if v429.ind then
                v426[v429.ind] = v437
            end
            if ty == 4 then
                v437.Shapes = BuildShapeLayer(v429, Frame, v422, v423, v424)
            elseif ty == 5 then
                v437.TextLabel = BuildTextLayer(v429, Frame, v422, v423, v424)
            elseif ty == 2 then
                v437.ImageLabel = BuildImageLayer(v429, Frame, v421, v422, v423)
            else
                local v438, w, v439
                if ty == 0 then
                    local refId = v429.refId
                    if refId and v421[refId] then
                        v438 = v421[refId]
                        if v438.layers then
                            w = v429.w or v438.w or v422
                            v439 = false
                        else
                            v439 = true
                        end
                    else
                        v439 = true
                    end
                else
                    v439 = true
                end
                if not v439 then
                    local h = v429.h or v438.h or v423
                    Frame.ClipsDescendants = true
                    Frame.Size = UDim2.fromScale(w / v422, h / v423)
                    v437.Children = v418(v438.layers, Frame, v421, w, h, v424)
                end
            end
            BuildDropShadow(v429, Frame, v422, v423, v424)
            if v429.masksProperties then
                for v440, v441 in v429.masksProperties do
                    if v441.mode == "a" then
                        local v442 = Easing.EvaluateBezierShape(v441.pt, v424)
                        if v442 then
                            local v443 = (1/0)
                            local v444 = (1/0)
                            local v445 = (-1/0)
                            local v446 = (-1/0)
                            for v447, v448 in v442.v do
                                local v449 = v448[1]
                                v443 = math.min(v443, v449)
                                local v450 = v448[2]
                                v444 = math.min(v444, v450)
                                local v451 = v448[1]
                                v445 = math.max(v445, v451)
                                local v452 = v448[2]
                                v446 = math.max(v446, v452)
                            end
                            local Frame_2 = Instance.new("Frame")
                            Frame_2.BackgroundTransparency = 1
                            Frame_2.BorderSizePixel = 0
                            Frame_2.ClipsDescendants = true
                            Frame_2.Position = UDim2.fromScale(v443 / v422, v444 / v423)
                            Frame_2.Size = UDim2.fromScale((v445 - v443) / v422, (v446 - v444) / v423)
                            Frame_2.Parent = v420
                            Frame.Parent = Frame_2
                            v437.MatteClip = Frame_2
                        end
                    elseif v441.mode == nil then
                    end
                end
            end
            ApplyTransform(Frame, v429.ks, v424, v422, v423, v430, Scale, Scale_2)
            local v453 = v424 - (v429.st or 0)
            if v429.ip <= v453 then
                Frame.Visible = v453 < v429.op
            else
                Frame.Visible = false
            end
            table.insert(v425, v437)
        end
    end
    for v454, v455 in v425 do
        local Layer = v455.Layer
        if Layer.parent then
            if v426[Layer.parent] then
                v455.Frame.Parent = v426[Layer.parent].Frame
            end
        elseif v455.MatteClip == nil then
            v455.Frame.Parent = v420
        end
    end
    local v456 = #v425 - 1
    for v457 = 1, v456 do
        local v458 = v425[v457]
        local v459 = v425[v457 + 1]
        if v459.Layer.tt then
            local v460
            for v461, v462 in v458.Shapes or {} do
                if v462.PathData then
                    v460 = Easing.EvaluateBezierShape(v462.PathData, v424)
                    break
                end
                v460 = nil
            end
            if v460 then
                local v463 = (1/0)
                local v464 = (1/0)
                local v465 = (-1/0)
                local v466 = (-1/0)
                for v467, v468 in v460.v do
                    local v469 = v468[1]
                    v463 = math.min(v463, v469)
                    local v470 = v468[2]
                    v464 = math.min(v464, v470)
                    local v471 = v468[1]
                    v465 = math.max(v465, v471)
                    local v472 = v468[2]
                    v466 = math.max(v466, v472)
                end
                local Frame = Instance.new("Frame")
                Frame.BackgroundTransparency = 1
                Frame.BorderSizePixel = 0
                Frame.ClipsDescendants = true
                Frame.Position = UDim2.fromScale(v463 / v422, v464 / v423)
                Frame.Size = UDim2.fromScale((v465 - v463) / v422, (v466 - v464) / v423)
                Frame.Parent = v420
                v459.Frame.Parent = Frame
                v459.MatteClip = Frame
                v458.Frame.Visible = false
            end
        end
    end
    return v425
end

local v473, v474

function v474(v475, v476, v477, v478) -- line 1313 | captures: v474, v473, Easing, ApplyTransform
    for v479, v480 in v475 do
        local Layer = v480.Layer
        local v481 = v476 - (Layer.st or 0)
        local v482 = if Layer.ip <= v481 then v481 < Layer.op else false
        v480.Frame.Visible = v482
        if v482 then
            local CanvasGroup = v480.Frame:IsA("CanvasGroup")
            ApplyTransform(v480.Frame, Layer.ks, v481, nil, nil, CanvasGroup, v480.BaseSizeX, v480.BaseSizeY)
            if v480.Shapes then
                for v483, v484 in v480.Shapes do
                    v473(v484, v481, nil, nil)
                end
            end
            if v480.Children then
                local v485 = if Layer.tm then Easing.EvaluateScalarAtFrame(Layer.tm, v481, 0) * (Layer.op - Layer.ip) else v481
                v474(v480.Children, v485, Layer.w or nil, Layer.h or nil)
            end
            if v480.TextLabel and Layer.t then
                local d = Layer.t.d
                if d and d.k then
                    local s
                    for v486, v487 in d.k do
                        if v487.t == nil then
                            s = v487.s
                        elseif v481 < v487.t then
                        end
                    end
                    if s then
                        v480.TextLabel.Text = s.t or ""
                        if s.fc then
                            v480.TextLabel.TextColor3 = Color3.new(s.fc[1] or 1, s.fc[2] or 1, s.fc[3] or 1)
                        end
                    end
                end
            end
        end
    end
end

function v473(v488, v489, v490, v491) -- line 1367 | captures: v473, Easing, BuildFilledPath, BuildStrokedPath
    if v488.Children then
        for v492, v493 in v488.Children do
            v473(v493, v489, v490, v491)
        end
    end
    local v494, v495
    if v488.IsAnimatedPath then
        if v488.PathData then
            local v496 = Easing.EvaluateBezierShape(v488.PathData, v489)
            if v496 and v488.Frame then
                local v497 = Easing.EvaluateColor(v488.FillColor, v489)
                local v498 = Easing.EvaluateScalarAtFrame(v488.FillOpacity, v489, 100)
                if v488.FillColor then
                    BuildFilledPath(v488, v496, v488.Frame, v490, v491, v497, 1 - v498 / 100)
                end
                if v488.StrokeColor then
                    local v499 = Easing.EvaluateColor(v488.StrokeColor, v489)
                    local v500 = Easing.EvaluateScalarAtFrame(v488.StrokeOpacity, v489, 100)
                    local v501 = Easing.EvaluateScalarAtFrame(v488.StrokeWidth, v489, 0)
                    if not (v501 <= 0) then
                        BuildStrokedPath(v488, v496, v488.Frame, v490, v491, v499, 1 - v500 / 100, v501)
                    end
                end
            end
            v494 = v488
        end
    else
        if v488.FillColor then
            local FillColor = v488.FillColor
            if FillColor ~= nil and FillColor.a == 1 then
                local v502 = Easing.EvaluateColor(v488.FillColor, v489)
                local v503 = 1 - Easing.EvaluateScalarAtFrame(v488.FillOpacity, v489, 100) / 100
                if v488.Triangles then
                    for v504, v505 in v488.Triangles do
                        if v505.A.Visible then
                            v505.A.ImageColor3 = v502
                            v505.A.ImageTransparency = v503
                        end
                        if v505.B.Visible then
                            v505.B.ImageColor3 = v502
                            v505.B.ImageTransparency = v503
                        end
                    end
                end
                if v488.Frame and v488.Frame.BackgroundTransparency < 1 then
                    v488.Frame.BackgroundColor3 = v502
                    v488.Frame.BackgroundTransparency = v503
                end
                v495 = v489
            end
        end
        v494 = v488
    end
    if v494.StrokeColor then
        local StrokeColor = v494.StrokeColor
        if StrokeColor ~= nil and StrokeColor.a == 1 then
            local v506 = Easing.EvaluateColor(v494.StrokeColor, v495)
            local v507 = Easing.EvaluateScalarAtFrame(v494.StrokeOpacity, v495, 100)
            if v494.Segments then
                for v508, v509 in v494.Segments do
                    if v509.Visible then
                        v509.BackgroundColor3 = v506
                        v509.BackgroundTransparency = 1 - v507 / 100
                    end
                end
            end
            if v494.UIStroke then
                v494.UIStroke.Color = v506
                v494.UIStroke.Transparency = 1 - v507 / 100
            end
        end
    end
end

local v510 = {}

function v510.Parse(v511) -- line 1474 | captures: HttpService
    return (HttpService:JSONDecode(v511))
end

function v510.Create(v512) -- line 1477 | captures: v418, v4
    local w = v512.w
    local h = v512.h
    local ip = v512.ip
    local op = v512.op
    local fr = v512.fr
    local Frame = Instance.new("Frame")
    Frame.Name = v512.nm or "LottieAnimation"
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true
    Frame.Size = v4
    local v513 = {}
    if v512.assets then
        for v514, v515 in v512.assets do
            v513[v515.id] = v515
        end
    end
    return {
        Animation = v512,
        Root = Frame,
        Layers = v418(v512.layers, Frame, v513, w, h, ip),
        AssetMap = v513,
        Duration = (op - ip) / fr,
        Width = w,
        Height = h
    }
end

function v510.Render(v516, v517) -- line 1510 | captures: v474
    local Animation = v516.Animation
    local ip = Animation.ip
    v474(v516.Layers, ip + v517 * Animation.fr % (Animation.op - ip), v516.Width, v516.Height)
end

function v510.Destroy(v518) -- line 1515
    v518.Root:Destroy()
    table.clear(v518.Layers)
    table.clear(v518.AssetMap)
end

return (table.freeze(v510))
