-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local Spatial = require(ReplicatedStorage.Shared.Utils.Spatial)
local v1 = {}
local v2

local function resolveTemplate() -- line 14 | captures: ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v3
    if Assets then
        v3 = Assets:FindFirstChild("Models")
    end
    local v4
    if v3 then
        v4 = v3:FindFirstChild(MonsterParasite.AssetsFolderName)
    end
    local v5
    if v4 then
        v5 = v4:FindFirstChild(MonsterParasite.ParasiteModelName)
    end
    if v5 and v5:IsA("Model") and v5.PrimaryPart then
        return v5
    end
    return nil
end

local function getIdleAnimation() -- line 40 | captures: v2, MonsterParasite
    local v6 = v2
    if v6 == nil then
        v6 = Instance.new("Animation")
        v6.Name = "ParasiteIdle"
        v6.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
        v2 = v6
    end
    return v6
end

local function stripEditorOnly(v7) -- line 50
    local InitialPoses = v7:FindFirstChild("InitialPoses")
    if InitialPoses then
        InitialPoses:Destroy()
    end
    local AnimSaves = v7:FindFirstChild("AnimSaves")
    if AnimSaves then
        AnimSaves:Destroy()
    end
end

local function configureParts(v8, v9) -- line 60
    for v10, v11 in v8:GetDescendants() do
        if v11:IsA("BasePart") then
            v11.Anchored = v9
            v11.CanCollide = false
            v11.CanQuery = false
            v11.CanTouch = false
            v11.Massless = true
        end
    end
end

local function partInside(v12, v13) -- line 71
    if v13 == nil then
        return false
    end
    return (v13:IsDescendantOf(v12))
end

local function destroyIfExternalJoint(v14, v15, v16, v17) -- line 75
    if v14.Name == "ParasiteEggWeld" then
        v14:Destroy()
    elseif v15 ~= nil and v15:IsDescendantOf(v17) then
        if not (v16 ~= nil and v16:IsDescendantOf(v17)) then
            v14:Destroy()
        end
    else
        v14:Destroy()
    end
end

local function stripExternalJointsAndBillboards(v18) -- line 90
    for v19, v20 in v18:GetDescendants() do
        if v20:IsA("BillboardGui") then
            v20:Destroy()
        elseif v20:IsA("Attachment") then
            if v20.Name == "MonsterParasiteIconAnchor" then
                v20:Destroy()
            end
        elseif v20:IsA("Motor6D") then
            local Part0 = v20.Part0
            local Part1 = v20.Part1
            if v20.Name == "ParasiteEggWeld" then
                v20:Destroy()
            elseif Part0 ~= nil and Part0:IsDescendantOf(v18) and Part1 ~= nil then
                Part1:IsDescendantOf(v18)
            end
        elseif v20:IsA("Weld") or v20:IsA("WeldConstraint") then
        end
    end
end

local function weldToEgg(v21, v22) -- line 115
    local ParasiteEggWeld = v22:FindFirstChild("ParasiteEggWeld")
    if ParasiteEggWeld then
        ParasiteEggWeld:Destroy()
    end
    local Motor6D = Instance.new("Motor6D")
    Motor6D.Name = "ParasiteEggWeld"
    Motor6D.Part0 = v21
    Motor6D.Part1 = v22
    Motor6D.C0 = v21.CFrame:Inverse() * v22.CFrame
    Motor6D.Parent = v22
    return Motor6D
end

local function poseDrift(v23) -- line 129
    local PrimaryPart = v23.PrimaryPart
    local v24
    if PrimaryPart then
        v24 = PrimaryPart:FindFirstChildWhichIsA("Bone")
    end
    if PrimaryPart == nil or v24 == nil then
        return (Vector3.new(0, 0, 0))
    end
    return v24.TransformedWorldCFrame.Position - (PrimaryPart.CFrame * v24.CFrame).Position
end

local function poseTransform(v25) -- line 142
    local PrimaryPart = v25.PrimaryPart
    local v26
    if PrimaryPart then
        v26 = PrimaryPart:FindFirstChildWhichIsA("Bone")
    end
    if PrimaryPart == nil or v26 == nil then
        return CFrame.identity
    end
    return PrimaryPart.CFrame:Inverse() * v26.TransformedWorldCFrame * v26.CFrame:Inverse()
end

local function poseMoved(v27, v28) -- line 156
    if v27 ~= nil and (v27.RightVector - v28.RightVector).Magnitude + (v27.UpVector - v28.UpVector).Magnitude + (v27.LookVector - v28.LookVector).Magnitude <= 0.001 then
        return (v27.Position - v28.Position).Magnitude > 0.001
    end
    return true
end

local function visibleParts(v29) -- line 164
    local v30 = {}
    for v31, v32 in v29:GetDescendants() do
        if v32:IsA("BasePart") and v32.Transparency < 1 then
            table.insert(v30, v32)
        end
    end
    return v30
end

local function resolveSeat(v33, v34, v35) -- line 173 | captures: Workspace, MonsterParasite, Spatial, visibleParts
    local function v36(v37, ...)
        return (math.min(v37, ...))
    end

    local PrimaryPart = v35.PrimaryPart
    if not (PrimaryPart ~= nil and v33:IsDescendantOf(Workspace)) then
        return nil
    end
    local v38 = visibleParts(v33)
    local v39 = visibleParts(v35)
    if #v38 == 0 or #v39 == 0 then
        return nil
    end
    local Rotation = v34.CFrame.Rotation
    local v40, v41 = Spatial.Bounds(v38, Rotation)
    if v41.Magnitude < 0.001 then
        return nil
    end
    local v42, v43 = Spatial.Bounds(v39, PrimaryPart.CFrame.Rotation)
    local v44 = PrimaryPart.CFrame:PointToObjectSpace(v42.Position)
    local UpVector = Rotation.UpVector
    local RightVector = Rotation.RightVector
    local LookVector = Rotation.LookVector
    local v45 = RaycastParams.new()
    v45.FilterType = Enum.RaycastFilterType.Include
    v45.FilterDescendantsInstances = v38
    v45.RespectCanCollide = false
    local Magnitude = v41.Magnitude
    local ParasiteCrownOffset = MonsterParasite.ParasiteCrownOffset
    local v46 = v40.Position + RightVector * (ParasiteCrownOffset.X * v41.X) + LookVector * (ParasiteCrownOffset.Y * v41.Z) + UpVector * Magnitude
    local v47 = UpVector * -Magnitude

    local function probe(v48) -- line 202 | captures: v45, v46, v47, Workspace
        return Workspace:Raycast(v46 + v48, v47, v45)
    end

    local v49 = v46 + Vector3.new(0, 0, 0)
    local v50 = Workspace:Raycast(v49, v47, v45)
    if v50 == nil then
        return nil
    end
    local v51 = (v46 - v50.Position):Dot(UpVector)
    local X = v43.X
    local Z = v43.Z
    local v52 = math.min(X, Z) * 0.4
    for v53, v54 in {
            RightVector * v52,
            RightVector * -v52,
            LookVector * v52,
            LookVector * -v52
        } do
        local v55 = Workspace:Raycast(v46 + v54, v47, v45)
        if v55 then
            v51 = v36(v51, (v46 + v54 - v55.Position):Dot(UpVector))
        end
    end
    local v56 = UpVector:Cross(-LookVector)
    local v57 = CFrame.fromMatrix(Vector3.new(0, 0, 0), v56, UpVector, -LookVector)
    local PrimaryPart_2 = v35.PrimaryPart
    local v58
    if PrimaryPart_2 then
        v58 = PrimaryPart_2:FindFirstChildWhichIsA("Bone")
    end
    local v59 = if PrimaryPart_2 == nil or v58 == nil then CFrame.identity else PrimaryPart_2.CFrame:Inverse() * v58.TransformedWorldCFrame * v58.CFrame:Inverse()
    local v60 = v57 * v59.Rotation:Inverse()
    return v60 + (v46 - UpVector * (v51 - v43.Y * 0.04999999999999999) - v60:VectorToWorldSpace(v59 * v44))
end

local function removeIcon(v61) -- line 240
    for v62, v63 in v61:GetDescendants() do
        if v63:IsA("BillboardGui") then
            v63:Destroy()
        elseif v63:IsA("Attachment") and v63.Name == "MonsterParasiteIconAnchor" then
        end
    end
end

local v64 = {}
local v65 = { __mode = "k" }
local v66 = setmetatable(v64, v65)

local function holdSeat(v67, v68, v69, v70) -- line 249 | captures: v66
    if v70.PrimaryPart ~= nil then
        v66[v69] = (v66[v69] or 0) + 1
        local v71 = os.clock() + 30
    end
end

local function seatWhenReachable(v72, v73, v74, v75) -- line 261
    if v74.PrimaryPart == nil then
    end
end

local function attachOutline(v76) -- line 267 | captures: MonsterParasite
    if v76:FindFirstChild(MonsterParasite.ParasiteHighlightName) then
        return
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = MonsterParasite.ParasiteHighlightName
    Highlight.Adornee = v76
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillColor = MonsterParasite.ParasiteHighlightColor
    Highlight.FillTransparency = MonsterParasite.ParasiteHighlightFillTransparency
    Highlight.OutlineColor = MonsterParasite.ParasiteHighlightColor
    Highlight.OutlineTransparency = MonsterParasite.ParasiteHighlightTransparency
    Highlight.Parent = v76
end

local function playIdle(v77) -- line 281 | captures: v2, Workspace, MonsterParasite
    local function tryPlay() -- line 282 | captures: v77, v2, Workspace, MonsterParasite
        if not (v77.Parent ~= nil and v77:IsDescendantOf(Workspace)) then
            return false
        end
        local v78 = v77:FindFirstChildWhichIsA("Animator", true)
        local v79, v80
        if v78 == nil then
            v80 = true
        elseif v78:IsA("Animator") then
            v79 = v2
            if v79 == nil then
                v79 = Instance.new("Animation")
                v79.Name = "ParasiteIdle"
                v79.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                v2 = v79
            end
            v80 = false
        else
            v80 = true
        end
        if not v80 then
            for v81, v82 in v78:GetPlayingAnimationTracks() do
                local Animation = v82.Animation
                if Animation and Animation.AnimationId == v79.AnimationId then
                    return true
                end
            end
            local v83 = v78
            local v84, v85 = pcall(function() -- line 305 | captures: v83, v2, MonsterParasite
                local v86 = v2
                if v86 == nil then
                    v86 = Instance.new("Animation")
                    v86.Name = "ParasiteIdle"
                    v86.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                    v2 = v86
                end
                return v83:LoadAnimation(v86)
            end)
            if v84 then
                v85.Looped = true
                v85.Priority = Enum.AnimationPriority.Idle
                v85:Play()
            else
                warn((("[MonsterParasite] Failed to load parasite idle: %*"):format(v85)))
            end
            return true
        end
        warn((("[MonsterParasite] Missing Animator in %*"):format((v77:GetFullName()))))
        return true
    end

    if tryPlay() then
    end
end

local function PoseDrift(v87) -- line 329
    local PrimaryPart = v87.PrimaryPart
    local v88
    if PrimaryPart then
        v88 = PrimaryPart:FindFirstChildWhichIsA("Bone")
    end
    if PrimaryPart == nil or v88 == nil then
        return (Vector3.new(0, 0, 0))
    end
    return v88.TransformedWorldCFrame.Position - (PrimaryPart.CFrame * v88.CFrame).Position
end

v1.PoseDrift = PoseDrift

function v1.Clear(v89) -- line 342 | captures: MonsterParasite
    local v90 = v89:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
    if v90 then
        v90:Destroy()
    end
    for v91, v92 in v89:GetDescendants() do
        if v92:IsA("BillboardGui") then
            if v92.Name == MonsterParasite.ParasiteBillboardName then
                v92:Destroy()
            end
        elseif v92:IsA("Highlight") and v92.Name == MonsterParasite.ParasiteHighlightName then
            v92:Destroy()
        end
    end
end

function v1.PrepareYankClone(v93) -- line 357 | captures: v2, Workspace, MonsterParasite, configureParts, stripExternalJointsAndBillboards
    if v93.PrimaryPart == nil then
        return nil
    end
    local v94 = v93:GetPivot()
    local v95 = v93:Clone()
    local InitialPoses = v95:FindFirstChild("InitialPoses")
    if InitialPoses then
        InitialPoses:Destroy()
    end
    local AnimSaves = v95:FindFirstChild("AnimSaves")
    if AnimSaves then
        AnimSaves:Destroy()
    end
    stripExternalJointsAndBillboards(v95)
    configureParts(v95, true)
    v95.Parent = Workspace
    v95:PivotTo(v94)

    local function tryPlay() -- line 282 | captures: v95, v2, Workspace, MonsterParasite
        if not (v95.Parent ~= nil and v95:IsDescendantOf(Workspace)) then
            return false
        end
        local v96 = v95:FindFirstChildWhichIsA("Animator", true)
        local v97, v98
        if v96 == nil then
            v98 = true
        elseif v96:IsA("Animator") then
            v97 = v2
            if v97 == nil then
                v97 = Instance.new("Animation")
                v97.Name = "ParasiteIdle"
                v97.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                v2 = v97
            end
            v98 = false
        else
            v98 = true
        end
        if not v98 then
            for v99, v100 in v96:GetPlayingAnimationTracks() do
                local Animation = v100.Animation
                if Animation and Animation.AnimationId == v97.AnimationId then
                    return true
                end
            end
            local v101 = v96
            local v102, v103 = pcall(function() -- line 305 | captures: v2, MonsterParasite, v101
                local v104 = v2
                if v104 == nil then
                    v104 = Instance.new("Animation")
                    v104.Name = "ParasiteIdle"
                    v104.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                    v2 = v104
                end
                return v101:LoadAnimation(v104)
            end)
            if v102 then
                v103.Looped = true
                v103.Priority = Enum.AnimationPriority.Idle
                v103:Play()
            else
                warn((("[MonsterParasite] Failed to load parasite idle: %*"):format(v103)))
            end
            return true
        end
        warn((("[MonsterParasite] Missing Animator in %*"):format((v95:GetFullName()))))
        return true
    end

    if tryPlay() then
    end
    v93:Destroy()
    return v95
end

function v1.Attach(v105, v106) -- line 379 | captures: v66, v2, Workspace, MonsterParasite, v1, resolveTemplate, configureParts, weldToEgg, resolveSeat, removeIcon, attachOutline
    if v106 == true then
        local v107 = v105:FindFirstChild(MonsterParasite.ParasiteVisualName)
        if v107 then
            if v107:IsA("Model") then
                attachOutline(v107)
                removeIcon(v107)

                local function tryPlay() -- line 282 | captures: v107, v2, Workspace, MonsterParasite
                    if not (v107.Parent ~= nil and v107:IsDescendantOf(Workspace)) then
                        return false
                    end
                    local v108 = v107:FindFirstChildWhichIsA("Animator", true)
                    local v109, v110
                    if v108 == nil then
                        v110 = true
                    elseif v108:IsA("Animator") then
                        v109 = v2
                        if v109 == nil then
                            v109 = Instance.new("Animation")
                            v109.Name = "ParasiteIdle"
                            v109.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                            v2 = v109
                        end
                        v110 = false
                    else
                        v110 = true
                    end
                    if not v110 then
                        for v111, v112 in v108:GetPlayingAnimationTracks() do
                            local Animation = v112.Animation
                            if Animation and Animation.AnimationId == v109.AnimationId then
                                return true
                            end
                        end
                        local v113 = v108
                        local v114, v115 = pcall(function() -- line 305 | captures: v2, MonsterParasite, v113
                            local v116 = v2
                            if v116 == nil then
                                v116 = Instance.new("Animation")
                                v116.Name = "ParasiteIdle"
                                v116.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                                v2 = v116
                            end
                            return v113:LoadAnimation(v116)
                        end)
                        if v114 then
                            v115.Looped = true
                            v115.Priority = Enum.AnimationPriority.Idle
                            v115:Play()
                        else
                            warn((("[MonsterParasite] Failed to load parasite idle: %*"):format(v115)))
                        end
                        return true
                    end
                    warn((("[MonsterParasite] Missing Animator in %*"):format((v107:GetFullName()))))
                    return true
                end

                if tryPlay() then
                end
                return v107
            end
            return
        end
        local v117 = resolveTemplate()
        local PrimaryPart = v105.PrimaryPart
        if v117 == nil or PrimaryPart == nil then
            return nil
        end
        local v118 = v117:Clone()
        v118.Name = MonsterParasite.ParasiteVisualName
        local InitialPoses = v118:FindFirstChild("InitialPoses")
        if InitialPoses then
            InitialPoses:Destroy()
        end
        local AnimSaves = v118:FindFirstChild("AnimSaves")
        if AnimSaves then
            AnimSaves:Destroy()
        end
        v118:ScaleTo(v117:GetScale() * v105:GetScale() * MonsterParasite.ParasiteScaleMultiplier)
        configureParts(v118, true)
        local ParasiteCrownOffset = MonsterParasite.ParasiteCrownOffset
        local Size = PrimaryPart.Size
        local v119 = Size.Y * 0.5
        v118:PivotTo(PrimaryPart.CFrame * CFrame.new(ParasiteCrownOffset.X * Size.X, v119, ParasiteCrownOffset.Y * Size.Z))
        local PrimaryPart_2 = v118.PrimaryPart
        local v120 = PrimaryPart_2 ~= nil
        assert(v120, "Parasite template requires a PrimaryPart")
        local v121 = resolveSeat(v105, PrimaryPart, v118)
        if v121 then
            v118:PivotTo(v121 * (PrimaryPart_2.CFrame:Inverse() * v118:GetPivot()))
        end
        v118.Parent = v105
        local v122 = weldToEgg(PrimaryPart, PrimaryPart_2)
        if v118.PrimaryPart ~= nil then
            v66[v122] = (v66[v122] or 0) + 1
            local v123 = os.clock() + 30
        end
        if v121 == nil and v118.PrimaryPart == nil then
        end
        configureParts(v118, false)
        attachOutline(v118)

        local function tryPlay() -- line 282 | captures: v118, v2, Workspace, MonsterParasite
            if not (v118.Parent ~= nil and v118:IsDescendantOf(Workspace)) then
                return false
            end
            local v124 = v118:FindFirstChildWhichIsA("Animator", true)
            local v125, v126
            if v124 == nil then
                v126 = true
            elseif v124:IsA("Animator") then
                v125 = v2
                if v125 == nil then
                    v125 = Instance.new("Animation")
                    v125.Name = "ParasiteIdle"
                    v125.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                    v2 = v125
                end
                v126 = false
            else
                v126 = true
            end
            if not v126 then
                for v127, v128 in v124:GetPlayingAnimationTracks() do
                    local Animation = v128.Animation
                    if Animation and Animation.AnimationId == v125.AnimationId then
                        return true
                    end
                end
                local v129 = v124
                local v130, v131 = pcall(function() -- line 305 | captures: v2, MonsterParasite, v129
                    local v132 = v2
                    if v132 == nil then
                        v132 = Instance.new("Animation")
                        v132.Name = "ParasiteIdle"
                        v132.AnimationId = ("rbxassetid://%*"):format(MonsterParasite.ParasiteIdleAnimationId)
                        v2 = v132
                    end
                    return v129:LoadAnimation(v132)
                end)
                if v130 then
                    v131.Looped = true
                    v131.Priority = Enum.AnimationPriority.Idle
                    v131:Play()
                else
                    warn((("[MonsterParasite] Failed to load parasite idle: %*"):format(v131)))
                end
                return true
            end
            warn((("[MonsterParasite] Missing Animator in %*"):format((v118:GetFullName()))))
            return true
        end

        if tryPlay() then
        end
        return v118
    end
    v1.Clear(v105)
    return nil
end

return table.freeze(v1)
