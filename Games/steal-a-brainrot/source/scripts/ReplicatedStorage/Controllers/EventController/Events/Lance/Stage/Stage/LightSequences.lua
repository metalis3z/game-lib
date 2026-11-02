--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  With Script + GUI
  Discord: https://discord.gg/nDWm6PkFrT
--]]

-- Decompiled with Velocity Script Decompiler
local v_u_1 = game:GetService("TweenService")
local v_u_2 = {}
local v_u_3 = script.Parent.Rotate.TheRomantic.Ceiling.Lights
local v_u_4 = Color3.fromRGB(180, 144, 120)
local v_u_5 = Color3.fromRGB(195, 128, 89)
local v_u_6 = Color3.fromRGB(111, 73, 61)
local v7 = Color3.fromRGB(90, 192, 217)
local v_u_8 = Color3.fromRGB(90, 180, 90)
local v_u_9 = Color3.fromRGB(40, 93, 180)
local v_u_10 = Color3.fromRGB(255, 0, 0)
local v_u_11 = Color3.fromRGB(0, 0, 0)
local v_u_12 = { "1" }
local v_u_13 = {
    "2a",
    "2b",
    "2c",
    "2d",
    "2e"
}
local v_u_14 = {
    "3a",
    "3b",
    "3c",
    "3d",
    "3e"
}
local v_u_15 = {
    "4a",
    "4b",
    "4c",
    "4d",
    "4e"
}
local v_u_16 = {
    "5a",
    "5b",
    "5c",
    "5d",
    "5e"
}
local v_u_17 = {
    "1",
    "2a",
    "2b",
    "2c",
    "2d",
    "2e",
    "3a",
    "3b",
    "3c",
    "3d",
    "3e",
    "4a",
    "4b",
    "4c",
    "4d",
    "4e",
    "5a",
    "5b",
    "5c",
    "5d",
    "5e"
}
local v_u_18 = {}
local function v_u_20()
    -- upvalues: (copy) v_u_18, (copy) v_u_3
    table.clear(v_u_18)
    for _, v19 in ipairs(v_u_3:GetChildren()) do
        if v19:IsA("BasePart") then
            v_u_18[v19.Name] = v19
        end
    end
end
v_u_20()
local v_u_21 = {}
local function v_u_25(p22)
    -- upvalues: (copy) v_u_21
    local v23 = v_u_21[p22]
    if v23 then
        for _, v_u_24 in ipairs(v23) do
            pcall(function()
                -- upvalues: (copy) v_u_24
                v_u_24:Cancel()
            end)
        end
    end
    v_u_21[p22] = nil
end
local function v_u_32(p26, p27, p28)
    -- upvalues: (copy) v_u_18, (copy) v_u_1, (copy) v_u_21
    local v29 = v_u_18[p26]
    if not v29 then
        return nil
    end
    local v30 = v_u_1:Create(v29, TweenInfo.new(p28, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["Color"] = p27
    })
    v_u_21[p26] = v_u_21[p26] or {}
    local v31 = v_u_21[p26]
    table.insert(v31, v30)
    v30:Play()
    return v30
end
local v_u_33 = Random.new()
local function v_u_45(p34, p35)
    local v36 = p34.R * 255 * p35 + 0.5
    local v37 = math.floor(v36)
    local v38 = math.clamp(v37, 0, 255)
    local v39 = p34.G * 255 * p35 + 0.5
    local v40 = math.floor(v39)
    local v41 = math.clamp(v40, 0, 255)
    local v42 = p34.B * 255 * p35 + 0.5
    local v43 = math.floor(v42)
    local v44 = math.clamp(v43, 0, 255)
    return Color3.fromRGB(v38, v41, v44)
end
local function v_u_47()
    -- upvalues: (copy) v_u_17, (copy) v_u_25, (copy) v_u_32, (copy) v_u_11
    for _, v46 in ipairs(v_u_17) do
        v_u_25(v46)
        v_u_32(v46, v_u_11, 0.1)
    end
end
local function v_u_51()
    -- upvalues: (copy) v_u_17, (copy) v_u_25, (copy) v_u_11, (copy) v_u_18
    for _, v48 in ipairs(v_u_17) do
        v_u_25(v48)
        local v49 = v_u_11
        local v50 = v_u_18[v48]
        if v50 then
            v50.Color = v49
        end
    end
end
local function v_u_77(p52)
    -- upvalues: (copy) v_u_16, (copy) v_u_15, (copy) v_u_14, (copy) v_u_13, (copy) v_u_12, (copy) v_u_4
    local v53 = {}
    if p52.RingColors then
        local v54 = p52.RingColors
        if v54[5] ~= nil then
            for _, v55 in ipairs(v_u_16) do
                v53[v55] = v54[5]
            end
        end
        if v54[4] ~= nil then
            for _, v56 in ipairs(v_u_15) do
                v53[v56] = v54[4]
            end
        end
        if v54[3] ~= nil then
            for _, v57 in ipairs(v_u_14) do
                v53[v57] = v54[3]
            end
        end
        if v54[2] ~= nil then
            for _, v58 in ipairs(v_u_13) do
                v53[v58] = v54[2]
            end
        end
        if p52.CenterColor ~= nil then
            for _, v59 in ipairs(v_u_12) do
                v53[v59] = p52.CenterColor
            end
        end
        return v53
    end
    if p52.RingOn then
        local v60 = p52.RingOn
        local v61 = v_u_16
        if v60[5] then
            for _, v62 in ipairs(v61) do
                v53[v62] = v_u_4
            end
        end
        local v63 = v_u_15
        if v60[4] then
            for _, v64 in ipairs(v63) do
                v53[v64] = v_u_4
            end
        end
        local v65 = v_u_14
        if v60[3] then
            for _, v66 in ipairs(v65) do
                v53[v66] = v_u_4
            end
        end
        local v67 = v_u_13
        if v60[2] then
            for _, v68 in ipairs(v67) do
                v53[v68] = v_u_4
            end
        end
    end
    if p52.OnNames then
        local v69 = p52.Color or v_u_4
        local v70 = p52.ColorMap
        for _, v71 in ipairs(p52.OnNames) do
            local v72
            if v70 then
                v72 = v70[v71] or v69
            else
                v72 = v69
            end
            v53[v71] = v72
        end
        return v53
    end
    if not p52.OnName then
        if p52.CenterOn then
            for _, v73 in ipairs(v_u_12) do
                v53[v73] = v_u_4
            end
        end
        return v53
    end
    local v74 = p52.Color or v_u_4
    local v75 = p52.ColorMap
    local v76 = p52.OnName
    if v75 then
        v74 = v75[p52.OnName] or v74
    end
    v53[v76] = v74
    return v53
end
local function v_u_159(p78, p79, p80, p_u_81, p_u_82, p83)
    -- upvalues: (copy) v_u_77, (copy) v_u_6, (copy) v_u_5, (copy) v_u_4, (copy) v_u_25, (copy) v_u_32, (copy) v_u_11, (copy) v_u_18, (copy) v_u_33, (copy) v_u_45
    local v84 = v_u_77(p78)
    local v85 = p83.TweenEnabled == true
    local v86 = p83.TweenMode or "None"
    local v87 = p83.TweenInSeconds or 0.08
    local v88 = p83.TweenOffSeconds or 0.08
    local v89 = p83.TweenChangeSeconds or 0.06
    local v90 = p83.Palette or { v_u_6, v_u_5, v_u_4 }
    if p79 then
        for v91, _ in pairs(p79) do
            if v84[v91] == nil then
                v_u_25(v91)
                if v85 and v88 > 0 then
                    v_u_32(v91, v_u_11, v88)
                else
                    local v92 = v_u_11
                    local v93 = v_u_18[v91]
                    if v93 then
                        v93.Color = v92
                    end
                end
            end
        end
    end
    if not v85 or v86 == "None" then
        for v94, v95 in pairs(v84) do
            v_u_25(v94)
            local v96 = v_u_18[v94]
            if v96 then
                v96.Color = v95
            end
        end
        return v84
    end
    if v86 == "Direct" then
        for v97, v98 in pairs(v84) do
            local v99 = p79 and p79[v97] ~= nil and true or false
            local v100
            if p79 then
                v100 = p79[v97] or nil
            else
                v100 = nil
            end
            v_u_25(v97)
            if v99 then
                if v100 and v100 ~= v98 then
                    if v98 == v_u_11 and v88 > 0 then
                        v_u_32(v97, v_u_11, v88)
                    elseif v89 > 0 then
                        v_u_32(v97, v98, v89)
                    else
                        local v101 = v_u_18[v97]
                        if v101 then
                            v101.Color = v98
                        end
                    end
                else
                    local v102 = v_u_18[v97]
                    if v102 then
                        v102.Color = v98
                    end
                end
            else
                local v103 = v_u_11
                local v104 = v_u_18[v97]
                if v104 then
                    v104.Color = v103
                end
                if v98 == v_u_11 then
                    local v105 = v_u_11
                    local v106 = v_u_18[v97]
                    if v106 then
                        v106.Color = v105
                    end
                elseif v87 > 0 then
                    v_u_32(v97, v98, v87)
                else
                    local v107 = v_u_18[v97]
                    if v107 then
                        v107.Color = v98
                    end
                end
            end
        end
        return v84
    end
    local v108 = p80 / 3
    local v109 = math.max(v108, 0.001)
    local v_u_110 = p83.RandomizeEnabled == true
    local v_u_111 = p83.OnChance or 1
    local v_u_112 = p83.MinOnPerRing or 0
    local v113 = p83.TweenDurationMultiplierRange or { 1, 1 }
    local v114 = p83.IntensityRange or { 1, 1 }
    local v139 = (function(p115)
        -- upvalues: (copy) v_u_110, (copy) v_u_112, (ref) v_u_33, (copy) v_u_111
        if not v_u_110 then
            local v116 = {}
            for v117, _ in pairs(p115) do
                v116[v117] = true
            end
            return v116
        end
        local v118 = {
            {},
            {},
            {},
            {},
            {}
        }
        for v119, _ in pairs(p115) do
            if v119 == "1" then
                local v120 = v118[1]
                table.insert(v120, v119)
            elseif v119:sub(1, 1) == "2" then
                local v121 = v118[2]
                table.insert(v121, v119)
            elseif v119:sub(1, 1) == "3" then
                local v122 = v118[3]
                table.insert(v122, v119)
            elseif v119:sub(1, 1) == "4" then
                local v123 = v118[4]
                table.insert(v123, v119)
            elseif v119:sub(1, 1) == "5" then
                local v124 = v118[5]
                table.insert(v124, v119)
            end
        end
        local v_u_125 = {}
        local function v130(p126)
            -- upvalues: (ref) v_u_112, (ref) v_u_33, (copy) v_u_125
            if v_u_112 <= 0 then
                return
            elseif #p126 ~= 0 then
                local v127 = v_u_112
                local v128 = #p126
                for _ = 1, math.min(v127, v128) do
                    local v129 = v_u_33:NextInteger(1, #p126)
                    v_u_125[p126[v129]] = true
                    table.remove(p126, v129)
                end
            end
        end
        for _, v131 in pairs(v118) do
            for _, v132 in ipairs(v131) do
                local v133 = v_u_111
                if v_u_33:NextNumber() < math.clamp(v133, 0, 1) then
                    v_u_125[v132] = true
                end
            end
        end
        for _, v134 in pairs(v118) do
            local v135 = false
            for _, v136 in ipairs(v134) do
                if v_u_125[v136] then
                    v135 = true
                    break
                end
            end
            if not v135 then
                local v137 = {}
                for _, v138 in ipairs(v134) do
                    table.insert(v137, v138)
                end
                v130(v137)
            end
        end
        return v_u_125
    end)(v84)
    for v140, _ in pairs(v84) do
        if not v139[v140] then
            v_u_25(v140)
            if v85 and v88 > 0 then
                v_u_32(v140, v_u_11, v88)
            else
                local v141 = v_u_11
                local v142 = v_u_18[v140]
                if v142 then
                    v142.Color = v141
                end
            end
        end
    end
    for v_u_143, _ in pairs(v84) do
        if v139[v_u_143] then
            v_u_25(v_u_143)
            local v144 = v114[1]
            local v145 = v114[2]
            if v145 >= v144 then
                local v146 = v145
                v145 = v144
                v144 = v146
            end
            local v147 = v145 + (v144 - v145) * v_u_33:NextNumber()
            local v148 = v_u_45(v90[1], v147)
            local v_u_149 = v_u_45(v90[2], v147)
            local v_u_150 = v_u_45(v90[3], v147)
            local v151 = v113[1]
            local v152 = v113[2]
            if v152 >= v151 then
                local v153 = v152
                v152 = v151
                v151 = v153
            end
            local v154 = v109 * (v152 + (v151 - v152) * v_u_33:NextNumber())
            local v_u_155 = math.max(v154, 0.001)
            local v156 = v_u_18[v_u_143]
            if v156 then
                v156.Color = v148
            end
            task.spawn(function()
                -- upvalues: (copy) p_u_82, (copy) p_u_81, (ref) v_u_32, (copy) v_u_143, (copy) v_u_149, (copy) v_u_155, (copy) v_u_150
                if p_u_82() == p_u_81 then
                    local v_u_157 = v_u_32(v_u_143, v_u_149, v_u_155)
                    if v_u_157 then
                        pcall(function()
                            -- upvalues: (copy) v_u_157
                            v_u_157.Completed:Wait()
                        end)
                    end
                    if p_u_82() == p_u_81 then
                        local v_u_158 = v_u_32(v_u_143, v_u_150, v_u_155)
                        if v_u_158 then
                            pcall(function()
                                -- upvalues: (copy) v_u_158
                                v_u_158.Completed:Wait()
                            end)
                        end
                        if p_u_82() == p_u_81 then
                            task.wait(v_u_155)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end)
        end
    end
    return v84
end
local v160 = {}
local v161 = {
    ["StepDelaySeconds"] = 999999,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    }
}
local v162 = {}
local v163 = {
    ["RingColors"] = {
        [2] = v_u_4,
        [3] = v_u_4,
        [4] = v_u_4,
        [5] = v_u_4
    },
    ["CenterColor"] = v_u_4
}
v162[1] = v163
v161.Steps = v162
v160.WhitePlain = v161
local v164 = {
    ["StepDelaySeconds"] = 999999,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    }
}
local v165 = {}
local v166 = {
    ["RingColors"] = {
        [2] = v_u_5,
        [3] = v_u_5,
        [4] = v_u_5,
        [5] = v_u_5
    },
    ["CenterColor"] = v_u_5
}
v165[1] = v166
v164.Steps = v165
v160.OrangePlain = v164
local v167 = {
    ["StepDelaySeconds"] = 999999,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    }
}
local v168 = {}
local v169 = {
    ["RingColors"] = {
        [2] = v7,
        [3] = v7,
        [4] = v7,
        [5] = v7
    },
    ["CenterColor"] = v7
}
v168[1] = v169
v167.Steps = v168
v160.BluePlain = v167
local v170 = {
    ["StepDelaySeconds"] = 999999,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    }
}
local v171 = {}
local v172 = {
    ["RingColors"] = {
        [2] = v_u_10,
        [3] = v_u_10,
        [4] = v_u_10,
        [5] = v_u_10
    },
    ["CenterColor"] = v_u_10
}
v171[1] = v172
v170.Steps = v171
v160.RedPlain = v170
local v173 = {
    ["StepDelaySeconds"] = 0.5,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "PaletteCycle",
        ["Palette"] = { v_u_6, v_u_5, v_u_4 },
        ["TweenOffSeconds"] = 1,
        ["RandomizeEnabled"] = true,
        ["OnChance"] = 0.75,
        ["MinOnPerRing"] = 1,
        ["TweenDurationMultiplierRange"] = { 0.5, 1.5 },
        ["IntensityRange"] = { 0.65, 1.25 }
    }
}
local v174 = {}
local v175 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true
    }
}
local v176 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true,
        [3] = true
    }
}
local v177 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true,
        [2] = true
    }
}
local v178 = {
    ["RingOn"] = {
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v179 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v180 = {
    ["RingOn"] = {
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v181 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true
    }
}
local v182 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true
    }
}
local v183 = {
    ["RingOn"] = {
        [5] = true
    }
}
v174 = { v175, v176, v177, v178, v179, v180, v181, v182, v183 }
v173.Steps = v174
v160.Mirage = v173
local v184 = {
    ["StepDelaySeconds"] = 0.5,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "PaletteCycle",
        ["Palette"] = { v_u_10, v_u_10, v_u_10 },
        ["TweenOffSeconds"] = 1,
        ["RandomizeEnabled"] = true,
        ["OnChance"] = 0.75,
        ["MinOnPerRing"] = 1,
        ["TweenDurationMultiplierRange"] = { 0.5, 1.5 },
        ["IntensityRange"] = { 0.65, 1.25 }
    }
}
local v185 = {}
local v186 = {
    ["RingColors"] = {
        [2] = v_u_10,
        [3] = v_u_10,
        [4] = v_u_10,
        [5] = v_u_10
    },
    ["CenterColor"] = v_u_10
}
local v187 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true
    }
}
local v188 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true,
        [3] = true
    }
}
local v189 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true,
        [2] = true
    }
}
local v190 = {
    ["RingOn"] = {
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v191 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v192 = {
    ["RingOn"] = {
        [3] = true,
        [2] = true
    },
    ["CenterOn"] = true
}
local v193 = {
    ["RingOn"] = {
        [4] = true,
        [3] = true
    }
}
local v194 = {
    ["RingOn"] = {
        [5] = true,
        [4] = true
    }
}
local v195 = {
    ["RingOn"] = {
        [5] = true
    }
}
v185 = { v186, v187, v188, v189, v190, v191, v192, v193, v194, v195 }
v184.Steps = v185
v160.MirageRed = v184
local v196 = {
    ["StepDelaySeconds"] = 0.05,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "PaletteCycle",
        ["Palette"] = { v_u_6, v_u_5, v_u_4 },
        ["TweenOffSeconds"] = 0.5,
        ["RandomizeEnabled"] = true,
        ["OnChance"] = 0.75,
        ["MinOnPerRing"] = 1,
        ["TweenDurationMultiplierRange"] = { 0.5, 1.5 },
        ["IntensityRange"] = { 0.65, 1.25 }
    },
    ["Steps"] = {
        {
            ["OnName"] = "5a"
        },
        {
            ["OnName"] = "4a"
        },
        {
            ["OnName"] = "3a"
        },
        {
            ["OnName"] = "2a"
        },
        {
            ["OnName"] = "1"
        },
        {
            ["OnName"] = "2e"
        },
        {
            ["OnName"] = "3e"
        },
        {
            ["OnName"] = "4e"
        },
        {
            ["OnName"] = "5e"
        },
        {
            ["OnName"] = "5d"
        },
        {
            ["OnName"] = "4d"
        },
        {
            ["OnName"] = "3d"
        },
        {
            ["OnName"] = "2d"
        },
        {
            ["OnName"] = "2c"
        },
        {
            ["OnName"] = "3c"
        },
        {
            ["OnName"] = "4c"
        },
        {
            ["OnName"] = "5c"
        },
        {
            ["OnName"] = "5b"
        },
        {
            ["OnName"] = "4b"
        },
        {
            ["OnName"] = "3b"
        },
        {
            ["OnName"] = "2b"
        }
    }
}
v160.Sweep = v196
local v197 = {
    ["StepDelaySeconds"] = 0.125,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "PaletteCycle",
        ["Palette"] = { v_u_6, v_u_5, v_u_4 },
        ["TweenOffSeconds"] = 2,
        ["RandomizeEnabled"] = true,
        ["OnChance"] = 0.85,
        ["MinOnPerRing"] = 1,
        ["TweenDurationMultiplierRange"] = { 0.6, 1.4 },
        ["IntensityRange"] = { 0.65, 1.25 }
    },
    ["Steps"] = {
        {
            ["OnName"] = "3a"
        },
        {
            ["OnName"] = "3b"
        },
        {
            ["OnName"] = "3c"
        },
        {
            ["OnName"] = "3d"
        },
        {
            ["OnName"] = "3e"
        },
        {
            ["OnName"] = "2e"
        },
        {
            ["OnName"] = "2d"
        },
        {
            ["OnName"] = "2c"
        },
        {
            ["OnName"] = "2b"
        },
        {
            ["OnName"] = "2a"
        },
        {
            ["OnName"] = "4a"
        },
        {
            ["OnName"] = "4b"
        },
        {
            ["OnName"] = "4c"
        },
        {
            ["OnName"] = "4d"
        },
        {
            ["OnName"] = "4e"
        },
        {
            ["OnName"] = "5e"
        },
        {
            ["OnName"] = "5d"
        },
        {
            ["OnName"] = "5c"
        },
        {
            ["OnName"] = "5b"
        },
        {
            ["OnName"] = "5a"
        },
        {
            ["OnName"] = "1"
        }
    }
}
v160.Spiral = v197
local v198 = {
    ["StepDelaySeconds"] = 0.125,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "PaletteCycle",
        ["Palette"] = { v_u_10, v_u_10, v_u_10 },
        ["TweenOffSeconds"] = 2,
        ["RandomizeEnabled"] = true,
        ["OnChance"] = 0.85,
        ["MinOnPerRing"] = 1,
        ["TweenDurationMultiplierRange"] = { 0.6, 1.4 },
        ["IntensityRange"] = { 0.65, 1.25 }
    },
    ["Steps"] = {
        {
            ["OnName"] = "3a"
        },
        {
            ["OnName"] = "3b"
        },
        {
            ["OnName"] = "3c"
        },
        {
            ["OnName"] = "3d"
        },
        {
            ["OnName"] = "3e"
        },
        {
            ["OnName"] = "2e"
        },
        {
            ["OnName"] = "2d"
        },
        {
            ["OnName"] = "2c"
        },
        {
            ["OnName"] = "2b"
        },
        {
            ["OnName"] = "2a"
        },
        {
            ["OnName"] = "4a"
        },
        {
            ["OnName"] = "4b"
        },
        {
            ["OnName"] = "4c"
        },
        {
            ["OnName"] = "4d"
        },
        {
            ["OnName"] = "4e"
        },
        {
            ["OnName"] = "5e"
        },
        {
            ["OnName"] = "5d"
        },
        {
            ["OnName"] = "5c"
        },
        {
            ["OnName"] = "5b"
        },
        {
            ["OnName"] = "5a"
        },
        {
            ["OnName"] = "1"
        }
    }
}
v160.SpiralRed = v198
local v199 = {
    ["StepDelaySeconds"] = 0.35,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    },
    ["Steps"] = {
        {
            ["OnNames"] = {
                "1",
                "2b",
                "3b",
                "4b",
                "5b",
                "2c",
                "3c",
                "4c",
                "5c",
                "2d",
                "3d",
                "4d",
                "5d"
            }
        },
        {
            ["OnNames"] = {
                "1",
                "2a",
                "3a",
                "4a",
                "5a",
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
    }
}
v160.BackAndForth = v199
local v200 = {
    ["StepDelaySeconds"] = 0.35,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    },
    ["Steps"] = {
        {
            ["Color"] = v_u_5,
            ["OnNames"] = {
                "1",
                "2b",
                "3b",
                "4b",
                "5b",
                "2c",
                "3c",
                "4c",
                "5c",
                "2d",
                "3d",
                "4d",
                "5d"
            }
        },
        {
            ["Color"] = v_u_5,
            ["OnNames"] = {
                "1",
                "2a",
                "3a",
                "4a",
                "5a",
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
    }
}
v160.BackAndForthOrange = v200
local v201 = {
    ["StepDelaySeconds"] = 0.35,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    },
    ["Steps"] = {
        {
            ["Color"] = v_u_10,
            ["OnNames"] = {
                "1",
                "2b",
                "3b",
                "4b",
                "5b",
                "2c",
                "3c",
                "4c",
                "5c",
                "2d",
                "3d",
                "4d",
                "5d"
            }
        },
        {
            ["Color"] = v_u_10,
            ["OnNames"] = {
                "1",
                "2a",
                "3a",
                "4a",
                "5a",
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
    }
}
v160.BackAndForthRed = v201
local v202 = {
    ["StepDelaySeconds"] = 0.35,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    },
    ["Steps"] = {
        {
            ["Color"] = v7,
            ["OnNames"] = {
                "1",
                "2b",
                "3b",
                "4b",
                "5b",
                "2c",
                "3c",
                "4c",
                "5c",
                "2d",
                "3d",
                "4d",
                "5d"
            }
        },
        {
            ["Color"] = v7,
            ["OnNames"] = {
                "1",
                "2a",
                "3a",
                "4a",
                "5a",
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
    }
}
v160.BackAndForthBlue = v202
local v210 = {
    ["StepDelaySeconds"] = 0.15,
    ["Profile"] = {
        ["TweenEnabled"] = false,
        ["TweenMode"] = "None"
    },
    ["Steps"] = (function()
        -- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_17, (copy) v_u_33
        local v203 = {
            v_u_4,
            v_u_5,
            v_u_6,
            v_u_8
        }
        local v204 = {}
        local v205 = {}
        for _, v206 in ipairs(v_u_17) do
            v204[v206] = v203[v_u_33:NextInteger(1, #v203)]
        end
        local v207 = {
            ["ColorMap"] = v204,
            ["OnNames"] = v_u_17
        }
        table.insert(v205, v207)
        for _ = 1, 80 do
            local v208 = {}
            for _ = 1, v_u_33:NextInteger(4, 10) do
                v208[v_u_17[v_u_33:NextInteger(1, #v_u_17)]] = v203[v_u_33:NextInteger(1, #v203)]
            end
            local v209 = {
                ["ColorMap"] = v208,
                ["OnNames"] = v_u_17
            }
            table.insert(v205, v209)
        end
        return v205
    end)()
}
v160.Crazy = v210
local v221 = {
    ["StepDelaySeconds"] = 0.15,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "Direct",
        ["TweenOffSeconds"] = 0.25,
        ["TweenInSeconds"] = 0.05,
        ["TweenChangeSeconds"] = 0.05
    },
    ["Steps"] = (function()
        -- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_5, (copy) v_u_6, (copy) v_u_17, (copy) v_u_33, (copy) v_u_11
        local v211 = {
            v_u_9,
            v_u_10,
            v_u_5,
            v_u_6
        }
        local v212 = {}
        local v213 = {}
        local v214 = {
            {
                "2a",
                "3a",
                "4a",
                "5a"
            },
            {
                "2b",
                "3b",
                "4b",
                "5b"
            },
            {
                "2c",
                "3c",
                "4c",
                "5c"
            },
            {
                "2d",
                "3d",
                "4d",
                "5d"
            },
            {
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
        for _, v215 in ipairs(v_u_17) do
            v212[v215] = v211[v_u_33:NextInteger(1, #v211)]
        end
        local v216 = {
            ["Color"] = v_u_11,
            ["ColorMap"] = v212,
            ["OnNames"] = v_u_17
        }
        table.insert(v213, v216)
        for _ = 1, 120 do
            local v217 = {}
            for _ = 1, v_u_33:NextInteger(1, 3) do
                local v218 = v214[v_u_33:NextInteger(1, #v214)]
                for _, v219 in ipairs(v218) do
                    v217[v219] = v211[v_u_33:NextInteger(1, #v211)]
                end
            end
            if v_u_33:NextNumber() < 0.6 then
                v217["1"] = v211[v_u_33:NextInteger(1, #v211)]
            end
            if v_u_33:NextNumber() < 0.75 then
                for _ = 1, v_u_33:NextInteger(2, 6) do
                    v217[v_u_17[v_u_33:NextInteger(1, #v_u_17)]] = v211[v_u_33:NextInteger(1, #v211)]
                end
            end
            local v220 = {
                ["Color"] = v_u_11,
                ["ColorMap"] = v217,
                ["OnNames"] = v_u_17
            }
            table.insert(v213, v220)
        end
        return v213
    end)()
}
v160.ExtraCrazy = v221
local v229 = {
    ["StepDelaySeconds"] = 0.12,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "Direct",
        ["TweenOffSeconds"] = 0.18,
        ["TweenInSeconds"] = 0.06,
        ["TweenChangeSeconds"] = 0.06
    },
    ["Steps"] = (function()
        -- upvalues: (copy) v_u_11, (copy) v_u_17, (copy) v_u_4
        local v222 = {
            {
                "2a",
                "3a",
                "4a",
                "5a"
            },
            {
                "2b",
                "3b",
                "4b",
                "5b"
            },
            {
                "2c",
                "3c",
                "4c",
                "5c"
            },
            {
                "2d",
                "3d",
                "4d",
                "5d"
            },
            {
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
        local v223 = {}
        for _ = 1, 40 do
            for _, v224 in ipairs(v222) do
                local v225 = {
                    ["1"] = v_u_11
                }
                for _, v226 in ipairs(v_u_17) do
                    if v226 ~= "1" then
                        v225[v226] = v_u_11
                    end
                end
                for _, v227 in ipairs(v224) do
                    v225[v227] = v_u_4
                end
                local v228 = {
                    ["Color"] = v_u_11,
                    ["ColorMap"] = v225,
                    ["OnNames"] = v_u_17
                }
                table.insert(v223, v228)
            end
        end
        return v223
    end)()
}
v160.RowSpinWhite = v229
local v237 = {
    ["StepDelaySeconds"] = 0.12,
    ["Profile"] = {
        ["TweenEnabled"] = true,
        ["TweenMode"] = "Direct",
        ["TweenOffSeconds"] = 0.18,
        ["TweenInSeconds"] = 0.06,
        ["TweenChangeSeconds"] = 0.06
    },
    ["Steps"] = (function()
        -- upvalues: (copy) v_u_11, (copy) v_u_17, (copy) v_u_10
        local v230 = {
            {
                "2a",
                "3a",
                "4a",
                "5a"
            },
            {
                "2b",
                "3b",
                "4b",
                "5b"
            },
            {
                "2c",
                "3c",
                "4c",
                "5c"
            },
            {
                "2d",
                "3d",
                "4d",
                "5d"
            },
            {
                "2e",
                "3e",
                "4e",
                "5e"
            }
        }
        local v231 = {}
        for _ = 1, 40 do
            for _, v232 in ipairs(v230) do
                local v233 = {
                    ["1"] = v_u_11
                }
                for _, v234 in ipairs(v_u_17) do
                    if v234 ~= "1" then
                        v233[v234] = v_u_11
                    end
                end
                for _, v235 in ipairs(v232) do
                    v233[v235] = v_u_10
                end
                local v236 = {
                    ["Color"] = v_u_11,
                    ["ColorMap"] = v233,
                    ["OnNames"] = v_u_17
                }
                table.insert(v231, v236)
            end
        end
        return v231
    end)()
}
v160.RowSpinRed = v237
v_u_2.Sequences = v160
local v_u_238 = nil
local v_u_239 = false
local v_u_240 = 0
local function v_u_241()
    -- upvalues: (ref) v_u_240
    return v_u_240
end
function v_u_2.Stop(p242)
    -- upvalues: (ref) v_u_239, (ref) v_u_240, (ref) v_u_238, (copy) v_u_17, (copy) v_u_25, (copy) v_u_51, (copy) v_u_47
    v_u_239 = false
    v_u_240 = v_u_240 + 1
    if v_u_238 then
        pcall(task.cancel, v_u_238)
    end
    v_u_238 = nil
    for _, v243 in ipairs(v_u_17) do
        v_u_25(v243)
    end
    if p242 then
        v_u_51()
    else
        v_u_47()
    end
end
function v_u_2.Play(p244, p245)
    -- upvalues: (copy) v_u_20, (copy) v_u_2, (ref) v_u_239, (ref) v_u_240, (ref) v_u_238, (copy) v_u_17, (copy) v_u_25, (copy) v_u_47, (copy) v_u_159, (copy) v_u_241
    v_u_20()
    local v246 = v_u_2.Sequences[p244]
    if v246 then
        local v_u_247 = v246.Steps
        local v_u_248 = v246.Profile or {
            ["TweenEnabled"] = false,
            ["TweenMode"] = "None"
        }
        v_u_239 = false
        v_u_240 = v_u_240 + 1
        if v_u_238 then
            pcall(task.cancel, v_u_238)
        end
        v_u_238 = nil
        for _, v249 in ipairs(v_u_17) do
            v_u_25(v249)
        end
        v_u_47()
        local v_u_250 = p245 or (v246.StepDelaySeconds or 0.25)
        v_u_239 = true
        local v_u_251 = v_u_240
        v_u_238 = task.spawn(function()
            -- upvalues: (ref) v_u_239, (copy) v_u_251, (ref) v_u_240, (copy) v_u_247, (copy) v_u_250, (ref) v_u_159, (ref) v_u_241, (copy) v_u_248
            local v252 = nil
            while v_u_239 and v_u_251 == v_u_240 do
                for _, v253 in ipairs(v_u_247) do
                    if not v_u_239 or v_u_251 ~= v_u_240 then
                        return
                    end
                    local v254 = v253.DelaySeconds or v_u_250
                    v252 = v_u_159(v253, v252, v254, v_u_251, v_u_241, v_u_248)
                    task.wait(v254)
                end
            end
        end)
    else
        warn(("LightSequences.Play: Unknown sequence \'%s\'"):format(p244))
    end
end
return v_u_2