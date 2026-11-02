-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = ipairs
local v_u_2 = Color3.new()
local function v6(p_u_3, p_u_4)
    return function(p5)
        return p_u_3:Lerp(p_u_4, p5)
    end
end
local function v_u_9(p7, p8)
    return p7.Time < p8.Time
end
local function v_u_51(p10, p11)
    local v12 = p10.R
    local v13 = p10.G
    local v14 = p10.B
    local v15 = v12 < 0.0404482362771076 and v12 / 12.92 or 0.87941546140213 * (v12 + 0.055) ^ 2.4
    local v16 = v13 < 0.0404482362771076 and v13 / 12.92 or 0.87941546140213 * (v13 + 0.055) ^ 2.4
    local v17 = v14 < 0.0404482362771076 and v14 / 12.92 or 0.87941546140213 * (v14 + 0.055) ^ 2.4
    local v18 = 0.2125862307855956 * v15 + 0.7151703037034108 * v16 + 0.0722004986433362 * v17
    local v19 = 3.6590806972265884 * v15 + 11.442689580057424 * v16 + 4.114991502426484 * v17
    local v_u_20 = v18 > 0.008856451679035631 and 116 * v18 ^ 0.3333333333333333 - 16 or 903.296296296296 * v18
    local v_u_21, v_u_22
    if v19 > 1e-15 then
        v_u_21 = v_u_20 * (0.9257063972951867 * v15 - 0.8333736323779866 * v16 - 0.09209820666085898 * v17) / v19
        v_u_22 = v_u_20 * (9 * v18 / v19 - 0.46832)
    else
        v_u_21 = -0.19783 * v_u_20
        v_u_22 = -0.46832 * v_u_20
    end
    local v23 = p11.R
    local v24 = p11.G
    local v25 = p11.B
    local v26 = v23 < 0.0404482362771076 and v23 / 12.92 or 0.87941546140213 * (v23 + 0.055) ^ 2.4
    local v27 = v24 < 0.0404482362771076 and v24 / 12.92 or 0.87941546140213 * (v24 + 0.055) ^ 2.4
    local v28 = v25 < 0.0404482362771076 and v25 / 12.92 or 0.87941546140213 * (v25 + 0.055) ^ 2.4
    local v29 = 0.2125862307855956 * v26 + 0.7151703037034108 * v27 + 0.0722004986433362 * v28
    local v30 = 3.6590806972265884 * v26 + 11.442689580057424 * v27 + 4.114991502426484 * v28
    local v_u_31 = v29 > 0.008856451679035631 and 116 * v29 ^ 0.3333333333333333 - 16 or 903.296296296296 * v29
    local v_u_32, v_u_33
    if v30 > 1e-15 then
        v_u_32 = v_u_31 * (0.9257063972951867 * v26 - 0.8333736323779866 * v27 - 0.09209820666085898 * v28) / v30
        v_u_33 = v_u_31 * (9 * v29 / v30 - 0.46832)
    else
        v_u_32 = -0.19783 * v_u_31
        v_u_33 = -0.46832 * v_u_31
    end
    return function(p34)
        local v35 = (1 - p34) * v_u_20 + p34 * v_u_31
        if v35 < 0.0197955 then
            return v_u_2
        end
        local v36 = ((1 - p34) * v_u_21 + p34 * v_u_32) / v35 + 0.19783
        local v37 = ((1 - p34) * v_u_22 + p34 * v_u_33) / v35 + 0.46832
        local v38 = (v35 + 16) / 116
        local v39 = v38 > 0.20689655172413793 and v38 * v38 * v38 or 0.12841854934601665 * v38 - 0.01771290335807126
        local v40 = v39 * v36 / v37
        local v41 = v39 * ((3 - 0.75 * v36) / v37 - 5)
        local v42 = 7.2914074 * v40 - 1.537208 * v39 - 0.4986286 * v41
        local v43 = -2.180094 * v40 + 1.8757561 * v39 + 0.0415175 * v41
        local v44 = 0.1253477 * v40 - 0.2040211 * v39 + 1.0569959 * v41
        if v42 < 0 and (v42 < v43 and v42 < v44) then
            v43 = v43 - v42
            v44 = v44 - v42
            v42 = 0
        elseif v43 < 0 and v43 < v44 then
            v42 = v42 - v43
            v44 = v44 - v43
            v43 = 0
        elseif v44 < 0 then
            v42 = v42 - v44
            v43 = v43 - v44
            v44 = 0
        end
        local v45 = v42 < 0.0031306684425 and 12.92 * v42 or 1.055 * v42 ^ 0.4166666666666667 - 0.055
        local v46 = v43 < 0.0031306684425 and 12.92 * v43 or 1.055 * v43 ^ 0.4166666666666667 - 0.055
        local v47 = v44 < 0.0031306684425 and 12.92 * v44 or 1.055 * v44 ^ 0.4166666666666667 - 0.055
        local v48 = v45 > 1 and 1 or (v45 < 0 and 0 or v45)
        local v49 = v46 > 1 and 1 or (v46 < 0 and 0 or v46)
        local v50 = v47 > 1 and 1 or (v47 < 0 and 0 or v47)
        return Color3.new(v48, v49, v50)
    end
end
return setmetatable({
    ["boolean"] = function(p_u_52, p_u_53)
        return function(p54)
            if p54 < 0.5 then
                return p_u_52
            else
                return p_u_53
            end
        end
    end,
    ["number"] = function(p_u_55, p56)
        local v_u_57 = p56 - p_u_55
        return function(p58)
            return p_u_55 + v_u_57 * p58
        end
    end,
    ["string"] = function(p59, p_u_60)
        local v61 = false
        local v62, v63, v64, v65 = string.match(p59, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
        local v66, v67, v68, v69 = string.match(p_u_60, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
        local v_u_70, v_u_71
        if v62 and v66 then
            v_u_70 = 3600 * (tonumber(v63) or 0) + 60 * (tonumber(v64) or 0) + (tonumber(v65) or 0)
            local v72 = 3600 * (tonumber(v67) or 0) + 60 * (tonumber(v68) or 0) + (tonumber(v69) or 0)
            if v62 == "-" then
                v_u_70 = -v_u_70
            end
            local v73 = 43200
            if v66 == "-" or not v72 then
                v72 = -v72
            end
            v_u_71 = (v73 + v72 - v_u_70) % 86400 - 43200
        else
            v61 = true
            v_u_70 = nil
            v_u_71 = nil
        end
        if not v61 then
            return function(p74)
                local v75 = (v_u_70 + v_u_71 * p74) % 86400
                local v76 = math.abs(v75)
                return string.format(v75 < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u", (v76 - v76 % 3600) / 3600, (v76 % 3600 - v76 % 60) / 60, v76 % 60)
            end
        end
        local v_u_77 = #p_u_60
        return function(p78)
            local v79 = 1 + v_u_77 * p78
            local v80 = p_u_60
            local v81 = v79 < v_u_77 and v79 and v79 or v_u_77
            return string.sub(v80, 1, v81)
        end
    end,
    ["CFrame"] = v6,
    ["Color3"] = v_u_51,
    ["NumberRange"] = function(p82, p83)
        local Min = p82.Min
        local Max = p82.Max
        local v_u_86 = p83.Min - Min
        local v_u_87 = p83.Max - Max
        return function(p88)
            return NumberRange.new(Min + p88 * v_u_86, Max + p88 * v_u_87)
        end
    end,
    ["NumberSequenceKeypoint"] = function(p89, p90)
        local Time = p89.Time
        local Value = p89.Value
        local Envelope = p89.Envelope
        local v_u_94 = p90.Time - Time
        local v_u_95 = p90.Value - Value
        local v_u_96 = p90.Envelope - Envelope
        return function(p97)
            return NumberSequenceKeypoint.new(Time + p97 * v_u_94, Value + p97 * v_u_95, Envelope + p97 * v_u_96)
        end
    end,
    ["PhysicalProperties"] = function(p98, p99)
        local Density = p98.Density
        local Elasticity = p98.Elasticity
        local ElasticityWeight = p98.ElasticityWeight
        local Friction = p98.Friction
        local FrictionWeight = p98.FrictionWeight
        local v_u_105 = p99.Density - Density
        local v_u_106 = p99.Elasticity - Elasticity
        local v_u_107 = p99.ElasticityWeight - ElasticityWeight
        local v_u_108 = p99.Friction - Friction
        local v_u_109 = p99.FrictionWeight - FrictionWeight
        return function(p110)
            return PhysicalProperties.new(Density + p110 * v_u_105, Elasticity + p110 * v_u_106, ElasticityWeight + p110 * v_u_107, Friction + p110 * v_u_108, FrictionWeight + p110 * v_u_109)
        end
    end,
    ["Ray"] = function(p111, p112)
        local Origin = p111.Origin
        local Direction = p111.Direction
        local Origin_0 = p112.Origin
        local Direction_0 = p112.Direction
        local v_u_117 = Origin.X
        local v_u_118 = Origin.Y
        local v_u_119 = Origin.Z
        local v_u_120 = Direction.X
        local v_u_121 = Direction.Y
        local v_u_122 = Direction.Z
        local v_u_123 = Origin_0.X - v_u_117
        local v_u_124 = Origin_0.Y - v_u_118
        local v_u_125 = Origin_0.Z - v_u_119
        local v_u_126 = Direction_0.X - v_u_120
        local v_u_127 = Direction_0.Y - v_u_121
        local v_u_128 = Direction_0.Z - v_u_122
        return function(p129)
            local new = Ray.new
            local v131 = v_u_117 + p129 * v_u_123
            local v132 = v_u_118 + p129 * v_u_124
            local v133 = v_u_119 + p129 * v_u_125
            local v134 = Vector3.new(v131, v132, v133)
            local v135 = v_u_120 + p129 * v_u_126
            local v136 = v_u_121 + p129 * v_u_127
            local v137 = v_u_122 + p129 * v_u_128
            return new(v134, (Vector3.new(v135, v136, v137)))
        end
    end,
    ["UDim"] = function(p138, p139)
        local Scale = p138.Scale
        local Offset = p138.Offset
        local v_u_142 = p139.Scale - Scale
        local v_u_143 = p139.Offset - Offset
        return function(p144)
            return UDim.new(Scale + p144 * v_u_142, Offset + p144 * v_u_143)
        end
    end,
    ["UDim2"] = v6,
    ["Vector2"] = v6,
    ["Vector3"] = v6,
    ["Rect"] = function(p_u_145, p_u_146)
        return function(p147)
            return Rect.new(p_u_145.Min.X + p147 * (p_u_146.Min.X - p_u_145.Min.X), p_u_145.Min.Y + p147 * (p_u_146.Min.Y - p_u_145.Min.Y), p_u_145.Max.X + p147 * (p_u_146.Max.X - p_u_145.Max.X), p_u_145.Max.Y + p147 * (p_u_146.Max.Y - p_u_145.Max.Y))
        end
    end,
    ["Region3"] = function(p_u_148, p_u_149)
        return function(p150)
            local v151 = p_u_148.CFrame * (-p_u_148.Size / 2)
            local v152 = v151 + p150 * (p_u_149.CFrame * (-p_u_149.Size / 2) - v151)
            local v153 = p_u_148.CFrame * (p_u_148.Size / 2)
            local v154 = v153 + p150 * (p_u_149.CFrame * (p_u_149.Size / 2) - v153)
            local v155 = v152.X
            local v156 = v154.X
            local v157 = v152.Y
            local v158 = v154.Y
            local v159 = v152.Z
            local v160 = v154.Z
            local new_0 = Region3.new
            local v162 = v155 < v156 and v155 and v155 or v156
            local v163 = v157 < v158 and v157 and v157 or v158
            local v164 = v159 < v160 and v159 and v159 or v160
            local v165 = Vector3.new(v162, v163, v164)
            if v156 < v155 then
                v156 = v155 or v156
            end
            if v158 < v157 then
                v158 = v157 or v158
            end
            if v160 < v159 then
                v160 = v159 or v160
            end
            return new_0(v165, (Vector3.new(v156, v158, v160)))
        end
    end,
    ["NumberSequence"] = function(p_u_166, p_u_167)
        return function(p168)
            local v169 = 0
            local v170 = {}
            local v171 = {}
            for _, v172 in v_u_1(p_u_166.Keypoints) do
                local v173 = nil
                local v174 = nil
                for _, v175 in v_u_1(p_u_167.Keypoints) do
                    if v175.Time == v172.Time then
                        v173 = v175
                        v174 = v173
                        local v176 = v173
                        v173 = v174
                        v176 = v174
                        break
                    end
                    if v175.Time < v172.Time and (v173 == nil or v175.Time > v173.Time) then
                        v173 = v175
                    elseif v175.Time > v172.Time and (v174 == nil or v175.Time < v174.Time) then
                        v174 = v175
                    end
                end
                local v177, v178
                if v174 == v173 then
                    v177 = v174.Value
                    v178 = v174.Envelope
                else
                    local v179 = (v172.Time - v173.Time) / (v174.Time - v173.Time)
                    v177 = (v174.Value - v173.Value) * v179 + v173.Value
                    v178 = (v174.Envelope - v173.Envelope) * v179 + v173.Envelope
                end
                v169 = v169 + 1
                v170[v169] = NumberSequenceKeypoint.new(v172.Time, (v177 - v172.Value) * p168 + v172.Value, (v178 - v172.Envelope) * p168 + v172.Envelope)
                v171[v172.Time] = true
            end
            for _, v180 in v_u_1(p_u_167.Keypoints) do
                if not v171[v180.Time] then
                    local v181 = nil
                    local v182 = nil
                    for _, v183 in v_u_1(p_u_166.Keypoints) do
                        if v183.Time == v180.Time then
                            v181 = v183
                            v182 = v181
                            local v184 = v181
                            v181 = v182
                            v184 = v182
                            break
                        end
                        if v183.Time < v180.Time and (v181 == nil or v183.Time > v181.Time) then
                            v181 = v183
                        elseif v183.Time > v180.Time and (v182 == nil or v183.Time < v182.Time) then
                            v182 = v183
                        end
                    end
                    local v185, v186
                    if v182 == v181 then
                        v185 = v182.Value
                        v186 = v182.Envelope
                    else
                        local v187 = (v180.Time - v181.Time) / (v182.Time - v181.Time)
                        v185 = (v182.Value - v181.Value) * v187 + v181.Value
                        v186 = (v182.Envelope - v181.Envelope) * v187 + v181.Envelope
                    end
                    v169 = v169 + 1
                    v170[v169] = NumberSequenceKeypoint.new(v180.Time, (v180.Value - v185) * p168 + v185, (v180.Envelope - v186) * p168 + v186)
                end
            end
            table.sort(v170, v_u_9)
            return NumberSequence.new(v170)
        end
    end,
    ["ColorSequence"] = function(p_u_188, p_u_189)
        return function(p190)
            local v191 = 0
            local v192 = {}
            local v193 = {}
            for _, v194 in v_u_1(p_u_188.Keypoints) do
                local v195 = nil
                local v196 = nil
                for _, v197 in v_u_1(p_u_189.Keypoints) do
                    if v197.Time == v194.Time then
                        v195 = v197
                        v196 = v195
                        local v198 = v195
                        v195 = v196
                        v198 = v196
                        break
                    end
                    if v197.Time < v194.Time and (v195 == nil or v197.Time > v195.Time) then
                        v195 = v197
                    elseif v197.Time > v194.Time and (v196 == nil or v197.Time < v196.Time) then
                        v196 = v197
                    end
                end
                local v199
                if v196 == v195 then
                    v199 = v196.Value
                else
                    v199 = v_u_51(v195.Value, v196.Value)((v194.Time - v195.Time) / (v196.Time - v195.Time))
                end
                v191 = v191 + 1
                v192[v191] = ColorSequenceKeypoint.new(v194.Time, v_u_51(v194.Value, v199)(p190))
                v193[v194.Time] = true
            end
            for _, v200 in v_u_1(p_u_189.Keypoints) do
                if not v193[v200.Time] then
                    local v201 = nil
                    local v202 = nil
                    for _, v203 in v_u_1(p_u_188.Keypoints) do
                        if v203.Time == v200.Time then
                            v201 = v203
                            v202 = v201
                            local v204 = v201
                            v201 = v202
                            v204 = v202
                            break
                        end
                        if v203.Time < v200.Time and (v201 == nil or v203.Time > v201.Time) then
                            v201 = v203
                        elseif v203.Time > v200.Time and (v202 == nil or v203.Time < v202.Time) then
                            v202 = v203
                        end
                    end
                    local v205
                    if v202 == v201 then
                        v205 = v202.Value
                    else
                        v205 = v_u_51(v201.Value, v202.Value)((v200.Time - v201.Time) / (v202.Time - v201.Time))
                    end
                    v191 = v191 + 1
                    v192[v191] = ColorSequenceKeypoint.new(v200.Time, v_u_51(v200.Value, v205)(p190))
                end
            end
            table.sort(v192, v_u_9)
            return ColorSequence.new(v192)
        end
    end
}, {
    ["__index"] = function(_, p206)
        error("No lerp function is defined for type " .. tostring(p206) .. ".", 4)
    end,
    ["__newindex"] = function(_, p207)
        error("No lerp function is defined for type " .. tostring(p207) .. ".", 4)
    end
})
