-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local VFX = require(script.Parent.VFX)
local v5 = { "BackgroundTransparency", "TextTransparency", "TextStrokeTransparency", "ImageTransparency" }
local v6 = {}

local function recall(v7, v8, v9, v10) -- line 10
    local v11 = v7[v8]
    if not v11 then
        v11 = {}
        v7[v8] = v11
    end
    if v11[v9] == nil then
        v11[v9] = v10()
    end
    return v11[v9]
end

local function recallProperty(v12, v13, v14) -- line 21
    local function v1() -- line 22 | captures: v13, v14
        return v13[v14]
    end

    local v15 = v12[v13]
    if not v15 then
        v15 = {}
        v12[v13] = v15
    end
    if v15[v14] == nil then
        v15[v14] = v13[v14]
    end
    return v15[v14]
end

local function towards(v16, v17, v18) -- line 35
    return v16 * (1 - v18) + v17 * v18
end

local function sequenceTowards(v19, v20, v21) -- line 38
    local function v22(v23, ...)
        table.insert(v23, ...)
    end

    local v24 = {}
    for v25, v26 in v19.Keypoints do
        local v27 = v26.Value * (1 - v21) + v20 * v21
        local v28 = 1 - v27
        local v29 = math.min(v27, v28)
        local v30 = math.max(0, v29)
        local new = NumberSequenceKeypoint.new
        local Time = v26.Time
        local Envelope = v26.Envelope
        v22(v24, new(Time, v27, (math.min(Envelope, v30))))
    end
    return NumberSequence.new(v24)
end

local v31 = {}
local v32 = {
    sequenced = false,
    guarded = false,
    classes = { "BasePart", "UIStroke", "Texture", "Decal" },
    properties = { "Transparency" }
}
local v33 = {
    sequenced = true,
    guarded = false,
    classes = { "ParticleEmitter", "Trail", "Beam" },
    properties = { "Transparency" }
}
local v34 = {
    sequenced = false,
    guarded = true
}

v34.classes = { "GuiObject" }
v34.properties = v5
v31[1] = v32
v31[2] = v33
v31[3] = v34

local function familyFor(v35) -- line 71 | captures: v31
    for v36, v37 in v31 do
        for v38, v39 in v37.classes do
            if v35:IsA(v39) then
                return v37
            end
        end
    end
    return nil
end

function v6.Fade() -- line 88 | captures: sequenceTowards, familyFor
    local v40 = {}
    local v41

    function v41(v42, v43, v44, v45) -- line 91 | captures: v41, v40, sequenceTowards, familyFor
        if v45 and table.find(v45, v42.ClassName) then
            return
        end
        local v46 = familyFor(v42)
        if v46 then
            for v47, v48 in v46.properties do
                if v46.guarded then
                    local pcall_2 = pcall
                    local v49 = v48
                    pcall_2(function() -- line 129 | captures: v42, v43, v44, v46, v49, v40, sequenceTowards
                        local function v3() -- line 134 | captures: v42, v49
                            return v42[v49]
                        end

                        local v50 = v40[v42]
                        if not v50 then
                            v50 = {}
                            v40[v42] = v50
                        end
                        if v50[v49] == nil then
                            v50[v49] = v42[v49]
                        end
                        local v51 = v50[v49]
                        local v52
                        if v46.sequenced then
                            v52 = sequenceTowards(v51, v43, v44)
                        else
                            v52 = v51 * (1 - v44) + v43 * v44
                        end
                        v42[v49] = v52
                    end)
                else
                    local v53 = v48

                    local function v4() -- line 110 | captures: v42, v53
                        return v42[v53]
                    end

                    local v54 = v40[v42]
                    if not v54 then
                        v54 = {}
                        v40[v42] = v54
                    end
                    if v54[v48] == nil then
                        v54[v48] = v42[v48]
                    end
                    local v55 = v54[v48]
                    local v56
                    if v46.sequenced then
                        v56 = sequenceTowards(v55, v43, v44)
                    else
                        v56 = v55 * (1 - v44) + v43 * v44
                    end
                    v42[v48] = v56
                end
            end
        end
        for v57, v58 in v42:GetChildren() do
            v41(v58, v43, v44, v45)
        end
    end

    return v41
end

function v6.Resizer(v59, v60, v61) -- line 164 | captures: VFX
    local v62 = {}
    local v63 = {}

    local function anchorFor(v64) -- line 168
        local Model = v64:FindFirstAncestorWhichIsA("Model")
        local BasePart
        if Model then
            BasePart = Model.PrimaryPart or v64:FindFirstAncestorWhichIsA("BasePart") or v64.AssemblyRootPart or v64
        else
            BasePart = v64:FindFirstAncestorWhichIsA("BasePart")
            if not BasePart then
                BasePart = v64.AssemblyRootPart
                if not BasePart then
                    return v64
                end
            end
        end
        return BasePart
    end

    local function reposition(v65, v66, v67, v68) -- line 193 | captures: v59, v62
        local v69 = v66:GetPivot()

        local function v2() -- line 198 | captures: v66
            return v66.Size
        end

        local v70 = v62[v66]
        if not v70 then
            v70 = {}
            v62[v66] = v70
        end
        if v70.Size == nil then
            v70.Size = v66.Size
        end
        local v71 = v69 * CFrame.new(v66.Size * v68) * CFrame.new(v70.Size * v67 * -v68)
        local v72
        if v59 then
            v72 = v69:ToObjectSpace(v65:GetPivot())
        else
            local function v3() -- line 213 | captures: v65, v69
                return v69:ToObjectSpace(v65:GetPivot())
            end

            local v73 = v62[v65]
            if not v73 then
                v73 = {}
                v62[v65] = v73
            end
            if v73.RelativePivot == nil then
                v73.RelativePivot = v69:ToObjectSpace(v65:GetPivot())
            end
            v72 = v73.RelativePivot
        end
        v65:PivotTo(v71:ToWorldSpace(v72 - v72.Position + v72.Position * v67))
    end

    local function scaleEmitter(v74, v75) -- line 230 | captures: v62, VFX
        local v76 = if typeof(v75) == "Vector3" then (v75.X + v75.Y + v75.Z) / 3 else v75

        local function v3() -- line 239 | captures: v74
            return v74.Size
        end

        local v77 = v62[v74]
        if not v77 then
            v77 = {}
            v62[v74] = v77
        end
        if v77.Size == nil then
            v77.Size = v74.Size
        end
        v74.Size = VFX.ScaleSequence(v77.Size, v76)

        local function v3_2() -- line 253 | captures: v74
            return v74.Drag
        end

        local v78 = v62[v74]
        if not v78 then
            v78 = {}
            v62[v74] = v78
        end
        if v78.Drag == nil then
            v78.Drag = v74.Drag
        end
        v74.Drag = v78.Drag * v76

        local function v3_3() -- line 267 | captures: v74
            return v74.VelocityInheritance
        end

        local v79 = v62[v74]
        if not v79 then
            v79 = {}
            v62[v74] = v79
        end
        if v79.VelocityInheritance == nil then
            v79.VelocityInheritance = v74.VelocityInheritance
        end
        v74.VelocityInheritance = v79.VelocityInheritance * v76

        local function v2() -- line 281 | captures: v74
            return v74.Speed
        end

        local v80 = v62[v74]
        if not v80 then
            v80 = {}
            v62[v74] = v80
        end
        if v80.Speed == nil then
            v80.Speed = v74.Speed
        end
        local Speed = v80.Speed
        v74.Speed = NumberRange.new(Speed.Min * v76, Speed.Max * v76)

        local function v4() -- line 296 | captures: v74
            return v74.Acceleration
        end

        local v81 = v62[v74]
        if not v81 then
            v81 = {}
            v62[v74] = v81
        end
        if v81.Acceleration == nil then
            v81.Acceleration = v74.Acceleration
        end
        v74.Acceleration = v81.Acceleration * v75

        local function v4_2() -- line 310 | captures: v74
            return v74.ZOffset
        end

        local v82 = v62[v74]
        if not v82 then
            v82 = {}
            v62[v74] = v82
        end
        if v82.ZOffset == nil then
            v82.ZOffset = v74.ZOffset
        end
        v74.ZOffset = v82.ZOffset * v76
    end

    local v83

    function v83(v84, v85, v86) -- line 323 | captures: v83, v60, v61, v62, v63, reposition, scaleEmitter
        local Model, v87
        if v60 then
            v87 = v60(v84)
        else
            local v88 = false
            local v89 = false
            local v90 = false
            local v91 = false
            local v92 = false
            local v93 = false
            local v94 = false
            if v61 then
                v94 = true
            else
                v88 = true
            end
            if v88 then
                if v84:IsA("BasePart") then
                    v90 = true
                else
                    v89 = true
                end
            end
            v88 = false
            if v89 then
                if v84:IsA("SpecialMesh") then
                    v91 = true
                else
                    v88 = true
                end
            end
            v89 = false
            if v88 then
                if v84:IsA("ParticleEmitter") then
                    v92 = true
                else
                    v89 = true
                end
            end
            v88 = false
            if v89 then
                if v84:IsA("Attachment") then
                    v88 = true
                else
                    v94 = false
                end
            end
            v89 = false
            local v95, v96
            if v88 then
                v95 = v62

                local function v2() -- line 394 | captures: v84
                    return v84.CFrame
                end

                local v97 = v62[v84]
                if v97 then
                    v96 = v97
                    v93 = true
                else
                    v89 = true
                end
            end
            v88 = false
            if v89 then
                v96 = {}
                v95[v84] = v96
                v93 = true
            end
            v89 = false
            if v93 then
                if v96.CFrame == nil then
                    v89 = true
                else
                    v88 = true
                end
            end
            v93 = false
            if v89 then
                v96.CFrame = v84.CFrame
                v88 = true
            end
            v89 = false
            if v88 then
                local CFrame = v96.CFrame
                v84.CFrame = CFrame - CFrame.Position + CFrame.Position * v85
                v94 = false
            end
            v88 = false
            if v92 then
                scaleEmitter(v84, v85)
                v94 = false
            end
            local v98, v99
            if v91 then
                v98 = v62

                local function v3() -- line 362 | captures: v84
                    return v84.Scale
                end

                local v100 = v62[v84]
                if v100 then
                    v99 = v100
                    v89 = true
                else
                    v88 = true
                end
            end
            v91 = false
            if v88 then
                v99 = {}
                v98[v84] = v99
                v89 = true
            end
            v88 = false
            if v89 then
                if v99.Scale == nil then
                    v88 = true
                else
                    v91 = true
                end
            end
            v89 = false
            if v88 then
                v99.Scale = v84.Scale
                v91 = true
            end
            v88 = false
            local v101, v102
            if v91 then
                v84.Scale = v99.Scale * v85
                v101 = v62

                local function v3() -- line 376 | captures: v84
                    return v84.Offset
                end

                local v103 = v62[v84]
                if v103 then
                    v102 = v103
                    v89 = true
                else
                    v88 = true
                end
            end
            v91 = false
            if v88 then
                v102 = {}
                v101[v84] = v102
                v89 = true
            end
            v88 = false
            if v89 then
                if v102.Offset == nil then
                    v88 = true
                else
                    v91 = true
                end
            end
            v89 = false
            if v88 then
                v102.Offset = v84.Offset
                v91 = true
            end
            v88 = false
            if v91 then
                v84.Offset = v102.Offset * v85
                v94 = false
            end
            v91 = false
            if v90 then
                if v86 == nil then
                    v88 = true
                else
                    v91 = true
                end
            end
            v90 = false
            local Model_2
            if v91 then
                Model_2 = v84:FindFirstAncestorWhichIsA("Model")
                if Model_2 then
                    v89 = true
                else
                    v90 = true
                end
            end
            v91 = false
            local v104
            if v90 then
                local BasePart = v84:FindFirstAncestorWhichIsA("BasePart")
                if BasePart then
                    v104 = BasePart
                    v93 = true
                else
                    v91 = true
                end
            end
            v90 = false
            if v91 then
                local AssemblyRootPart = v84.AssemblyRootPart
                if AssemblyRootPart then
                    v104 = AssemblyRootPart
                    v93 = true
                else
                    v90 = true
                end
            end
            if v90 then
                v104 = v84
                v93 = true
            end
            v90 = false
            if v89 then
                v104 = Model_2.PrimaryPart
                v93 = true
            end
            if v93 then
                reposition(v84, v104, v85, v86)
                v88 = true
            end
            v93 = false
            local v105, v106
            if v88 then
                v105 = v62

                local function v3() -- line 347 | captures: v84
                    return v84.Size
                end

                local v107 = v62[v84]
                if v107 then
                    v106 = v107
                    v93 = true
                else
                    v90 = true
                end
            end
            v88 = false
            if v90 then
                v106 = {}
                v105[v84] = v106
                v93 = true
            end
            v90 = false
            if v93 then
                if v106.Size == nil then
                    v90 = true
                else
                    v88 = true
                end
            end
            if v90 then
                v106.Size = v84.Size
                v88 = true
            end
            if v88 then
                v84.Size = v106.Size * v85
                v94 = false
            end
            if not v94 then
                for v108, v109 in v84:GetChildren() do
                    v83(v109, v85, v86)
                end
                return
            end
            Model = v84:IsA("Model")
        end
        if v60 and v87 or not v60 and not Model or v60 then
            return
        end
        local v110 = math.max(0.001, v85)
        local v111 = v63[v84]
        if v111 then
            v84:ScaleTo(v111 * v110)
        else
            v63[v84] = v110
            v84:ScaleTo(v110)
        end
    end

    return v83
end

return v6
