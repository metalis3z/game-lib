-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local _ = script.Parent
local v_u_1 = game:GetService("HttpService")
local v_u_2 = {}
local v_u_3 = nil
local v_u_4 = nil
local v_u_117 = {
    ["BrickColor"] = {
        ["Serialize"] = function(p5)
            return {
                ["Index"] = p5.Number
            }
        end,
        ["Deserialize"] = function(p6)
            return BrickColor.new(p6.Index)
        end
    },
    ["CFrame"] = {
        ["Serialize"] = function(p7)
            -- upvalues: (ref) v_u_3
            return {
                ["Position"] = v_u_3(p7.Position),
                ["XVector"] = v_u_3(p7.XVector),
                ["YVector"] = v_u_3(p7.YVector),
                ["ZVector"] = v_u_3(p7.ZVector)
            }
        end,
        ["Deserialize"] = function(p8)
            -- upvalues: (ref) v_u_4
            return CFrame.fromMatrix(not p8.Position and Vector3.new(0, 0, 0) or v_u_4(p8.Position), v_u_4(p8.XVector), v_u_4(p8.YVector), v_u_4(p8.ZVector))
        end
    },
    ["Color3"] = {
        ["Serialize"] = function(p9)
            return {
                ["Hex"] = p9:ToHex()
            }
        end,
        ["Deserialize"] = function(p10)
            return Color3.fromHex(p10.Hex)
        end
    },
    ["ColorSequence"] = {
        ["Serialize"] = function(p11)
            -- upvalues: (ref) v_u_3
            local v12 = {}
            for v13, v14 in ipairs(p11.Keypoints) do
                v12[v13] = v_u_3(v14)
            end
            return {
                ["Keypoints"] = v12
            }
        end,
        ["Deserialize"] = function(p15)
            -- upvalues: (ref) v_u_4
            local v16 = {}
            for v17, v18 in ipairs(p15.Keypoints) do
                v16[v17] = v_u_4(v18)
            end
            return ColorSequence.new(v16)
        end
    },
    ["ColorSequenceKeypoint"] = {
        ["Serialize"] = function(p19)
            -- upvalues: (ref) v_u_3
            return {
                ["Time"] = p19.Time,
                ["Value"] = v_u_3(p19.Value)
            }
        end,
        ["Deserialize"] = function(p20)
            -- upvalues: (ref) v_u_4
            return ColorSequenceKeypoint.new(p20.Time, v_u_4(p20.Value))
        end
    },
    ["DateTime"] = {
        ["Serialize"] = function(p21)
            return {
                ["Milliseconds"] = p21.UnixTimestampMillis
            }
        end,
        ["Deserialize"] = function(p22)
            return DateTime.fromUnixTimestampMillis(p22.Milliseconds)
        end
    },
    ["Enum"] = {
        ["Serialize"] = function(p23)
            return {
                ["Name"] = tostring(p23)
            }
        end,
        ["Deserialize"] = function(p24)
            return Enum[p24.Name]
        end
    },
    ["EnumItem"] = {
        ["Serialize"] = function(p25)
            local v26 = {}
            local v27 = p25.EnumType
            v26.EnumName = tostring(v27)
            v26.Name = p25.Name
            return v26
        end,
        ["Deserialize"] = function(p28)
            return Enum[p28.EnumName][p28.Name]
        end
    },
    ["NumberRange"] = {
        ["Serialize"] = function(p29)
            return {
                ["Minimum"] = p29.Min,
                ["Maximum"] = p29.Max
            }
        end,
        ["Deserialize"] = function(p30)
            return NumberRange.new(p30.Minimum, p30.Maximum)
        end
    },
    ["NumberSequence"] = {
        ["Serialize"] = function(p31)
            -- upvalues: (ref) v_u_3
            local v32 = {}
            for v33, v34 in ipairs(p31.Keypoints) do
                v32[v33] = v_u_3(v34)
            end
            return {
                ["Keypoints"] = v32
            }
        end,
        ["Deserialize"] = function(p35)
            -- upvalues: (ref) v_u_4
            local v36 = {}
            for v37, v38 in ipairs(p35.Keypoints) do
                v36[v37] = v_u_4(v38)
            end
            return NumberSequence.new(v36)
        end
    },
    ["NumberSequenceKeypoint"] = {
        ["Serialize"] = function(p39)
            return {
                ["Time"] = p39.Time,
                ["Value"] = p39.Value
            }
        end,
        ["Deserialize"] = function(p40)
            return NumberSequenceKeypoint.new(p40.Time, p40.Value)
        end
    },
    ["PathWaypoint"] = {
        ["Serialize"] = function(p41)
            -- upvalues: (ref) v_u_3
            return {
                ["Position"] = v_u_3(p41.Position),
                ["Action"] = v_u_3(p41.Action),
                ["Label"] = p41.Label
            }
        end,
        ["Deserialize"] = function(p42)
            -- upvalues: (ref) v_u_4
            return PathWaypoint.new(v_u_4(p42.Position), v_u_4(p42.Action), p42.Label)
        end
    },
    ["PhysicalProperties"] = {
        ["Serialize"] = function(p43)
            return {
                ["Density"] = p43.Density,
                ["Friction"] = p43.Friction,
                ["Elasticity"] = p43.Elasticity,
                ["FrictionWeight"] = p43.FrictionWeight,
                ["ElasticityWeight"] = p43.ElasticityWeight
            }
        end,
        ["Deserialize"] = function(p44)
            return PhysicalProperties.new(p44.Density, p44.Friction, p44.Elasticity, p44.FrictionWeight, p44.ElasticityWeight)
        end
    },
    ["Ray"] = {
        ["Serialize"] = function(p45)
            -- upvalues: (ref) v_u_3
            return {
                ["Origin"] = v_u_3(p45.Origin),
                ["Direction"] = v_u_3(p45.Direction)
            }
        end,
        ["Deserialize"] = function(p46)
            -- upvalues: (ref) v_u_4
            return Ray.new(v_u_4(p46.Origin), v_u_4(p46.Direction))
        end
    },
    ["Rect"] = {
        ["Serialize"] = function(p47)
            -- upvalues: (ref) v_u_3
            return {
                ["Min"] = v_u_3(p47.Min),
                ["Max"] = v_u_3(p47.Max)
            }
        end,
        ["Deserialize"] = function(p48)
            -- upvalues: (ref) v_u_4
            return Rect.new(v_u_4(p48.Min), v_u_4(p48.Max))
        end
    },
    ["Region3"] = {
        ["Serialize"] = function(p49)
            -- upvalues: (ref) v_u_3
            return {
                ["Size"] = v_u_3(p49.Size),
                ["CFrame"] = v_u_3(p49.CFrame)
            }
        end,
        ["Deserialize"] = function(p50)
            -- upvalues: (ref) v_u_4
            local v51 = v_u_4(p50.CFrame)
            local v52 = v_u_4(p50.Size)
            local v53 = (v51 * CFrame.new(-v52 / 2)).Position
            local v54 = (v51 * CFrame.new(v52 / 2)).Position
            local v55 = Region3.new
            local v56 = v53.X
            local v57 = v54.X
            local v58 = math.min(v56, v57)
            local v59 = v53.Y
            local v60 = v54.Y
            local v61 = math.min(v59, v60)
            local v62 = v53.Z
            local v63 = v54.Z
            local v64 = math.min(v62, v63)
            local v65 = Vector3.new(v58, v61, v64)
            local v66 = v53.X
            local v67 = v54.X
            local v68 = math.max(v66, v67)
            local v69 = v53.Y
            local v70 = v54.Y
            local v71 = math.max(v69, v70)
            local v72 = v53.Z
            local v73 = v54.Z
            local v74 = math.max(v72, v73)
            return v55(v65, (Vector3.new(v68, v71, v74)))
        end
    },
    ["Region3int16"] = {
        ["Serialize"] = function(p75)
            -- upvalues: (ref) v_u_3
            return {
                ["Minimum"] = v_u_3(p75.Min),
                ["Maximum"] = v_u_3(p75.Max)
            }
        end,
        ["Deserialize"] = function(p76)
            -- upvalues: (ref) v_u_4
            return Region3int16.new(v_u_4(p76.Min), v_u_4(p76.Max))
        end
    },
    ["TweenInfo"] = {
        ["Serialize"] = function(p77)
            -- upvalues: (ref) v_u_3
            return {
                ["Time"] = p77.Time,
                ["EasingStyle"] = v_u_3(p77.EasingStyle),
                ["EasingDirection"] = v_u_3(p77.EasingDirection),
                ["RepeatCount"] = p77.RepeatCount,
                ["Reverses"] = p77.Reverses,
                ["DelayTime"] = p77.DelayTime
            }
        end,
        ["Deserialize"] = function(p78)
            -- upvalues: (ref) v_u_4
            return TweenInfo.new(p78.Time, v_u_4(p78.EasingStyle), v_u_4(p78.EasingDirection), p78.RepeatCount, p78.Reverses, p78.DelayTime)
        end
    },
    ["UDim"] = {
        ["Serialize"] = function(p79)
            return {
                ["Scale"] = p79.Scale,
                ["Offset"] = p79.Offset
            }
        end,
        ["Deserialize"] = function(p80)
            return UDim.new(p80.Scale, p80.Offset)
        end
    },
    ["UDim2"] = {
        ["Serialize"] = function(p81)
            -- upvalues: (ref) v_u_3
            return {
                ["X"] = v_u_3(p81.X),
                ["Y"] = v_u_3(p81.Y)
            }
        end,
        ["Deserialize"] = function(p82)
            -- upvalues: (ref) v_u_4
            return UDim2.new(v_u_4(p82.X), v_u_4(p82.Y))
        end
    },
    ["Vector2"] = {
        ["Serialize"] = function(p83)
            return {
                ["X"] = p83.X,
                ["Y"] = p83.Y
            }
        end,
        ["Deserialize"] = function(p84)
            return Vector2.new(p84.X, p84.Y)
        end
    },
    ["Vector2int16"] = {
        ["Serialize"] = function(p85)
            return {
                ["X"] = p85.X,
                ["Y"] = p85.Y
            }
        end,
        ["Deserialize"] = function(p86)
            return Vector2int16.new(p86.X, p86.Y)
        end
    },
    ["Vector3"] = {
        ["Serialize"] = function(p87)
            return {
                ["X"] = p87.X,
                ["Y"] = p87.Y,
                ["Z"] = p87.Z
            }
        end,
        ["Deserialize"] = function(p88)
            local v89 = p88.X
            local v90 = p88.Y
            local v91 = p88.Z
            return Vector3.new(v89, v90, v91)
        end
    },
    ["Vector3int16"] = {
        ["Serialize"] = function(p92)
            return {
                ["X"] = p92.X,
                ["Y"] = p92.Y,
                ["Z"] = p92.Z
            }
        end,
        ["Deserialize"] = function(p93)
            return Vector3int16.new(p93.X, p93.Y, p93.Z)
        end
    },
    ["nil"] = {
        ["Serialize"] = function()
            return "nil"
        end,
        ["Deserialize"] = function(_)
            return nil
        end
    },
    ["number"] = {
        ["Serialize"] = function(p94)
            return p94
        end,
        ["Deserialize"] = function(p95)
            return p95
        end
    },
    ["string"] = {
        ["Serialize"] = function(p96)
            return p96
        end,
        ["Deserialize"] = function(p97)
            return p97
        end
    },
    ["boolean"] = {
        ["Serialize"] = function(p98)
            return p98
        end,
        ["Deserialize"] = function(p99)
            return p99
        end
    },
    ["table"] = {
        ["Serialize"] = function(p100)
            -- upvalues: (ref) v_u_3
            local v_u_101 = {}
            local function v_u_108(p102)
                -- upvalues: (copy) v_u_101, (ref) v_u_3, (copy) v_u_108
                if v_u_101[p102] then
                    return v_u_101[p102]
                end
                v_u_101[p102] = p102
                if typeof(p102) ~= "table" then
                    return v_u_3(p102)
                end
                if p102.TYPE then
                    local v103 = v_u_3(p102)
                    v_u_101[p102] = v103
                    return v103
                end
                local v104 = {}
                for v105, v106 in pairs(p102) do
                    if not v_u_101[v105] then
                        v_u_101[v105] = v_u_108(v105)
                    end
                    local v107 = v_u_101[v105]
                    if not v_u_101[v106] then
                        v_u_101[v106] = v_u_108(v106)
                    end
                    v104[v107] = v_u_101[v106]
                end
                v_u_101[p102] = v104
                return v104
            end
            return v_u_108(p100)
        end,
        ["Deserialize"] = function(p109)
            -- upvalues: (ref) v_u_4
            local function v_u_116(p110)
                -- upvalues: (ref) v_u_4, (copy) v_u_116
                local v111 = {}
                for v115, v114 in pairs(p110) do
                    if typeof(v114) == "table" then
                        local v114
                        if v114.TYPE then
                            v114 = v_u_4(v114)
                        else
                            v114 = v_u_116(v114)
                        end
                    end
                    if typeof(v115) == "table" then
                        local v115
                        if v115.TYPE then
                            v115 = v_u_4(v115)
                        else
                            v115 = v_u_116(v115)
                        end
                    end
                    v111[v115] = v114
                end
                return v111
            end
            return v_u_116(p109)
        end
    }
}
v_u_3 = function(p118)
    -- upvalues: (copy) v_u_117
    if type(p118) ~= "table" and (type(p118) ~= "userdata" and type(p118) ~= "vector") then
        return p118
    end
    local v119 = typeof(p118)
    local v120 = v_u_117[v119]
    local v121 = v120 ~= nil
    local v122 = "No current support for " .. tostring(v119)
    assert(v121, v122)
    return {
        ["TYPE"] = v119,
        ["DATA"] = v120.Serialize(p118)
    }
end
v_u_4 = function(p123)
    -- upvalues: (copy) v_u_117
    if type(p123) ~= "table" then
        return p123
    end
    local v124 = p123.TYPE
    local v125 = p123.DATA
    local v126 = v_u_117[tostring(v124)]
    local v127 = v126 ~= nil
    local v128 = "No current support for " .. tostring(v124)
    assert(v127, v128)
    local v129 = p123 ~= nil
    local v130 = "Bad data for " .. tostring(v124)
    assert(v129, v130)
    return v126.Deserialize(v125)
end
function v_u_2.serialize(p131)
    -- upvalues: (ref) v_u_3
    return v_u_3(p131)
end
function v_u_2.deserialize(p132)
    -- upvalues: (ref) v_u_4
    return v_u_4(p132)
end
function v_u_2.serializeDictionary(p133)
    -- upvalues: (copy) v_u_1, (copy) v_u_2
    local v134 = {}
    for v135, v136 in pairs(p133) do
        v134[v_u_1:JSONEncode(v_u_2.serialize(v135))] = v_u_2.serialize(v136)
    end
    return v_u_1:JSONEncode(v134)
end
function v_u_2.deserializeDictionary(p137)
    -- upvalues: (copy) v_u_1, (copy) v_u_2
    local v138 = v_u_1:JSONDecode(p137)
    local v139 = {}
    for v140, v141 in pairs(v138) do
        v139[v_u_2.deserialize(v_u_1:JSONDecode(v140))] = v_u_2.deserialize(v141)
    end
    return v139
end
return v_u_2