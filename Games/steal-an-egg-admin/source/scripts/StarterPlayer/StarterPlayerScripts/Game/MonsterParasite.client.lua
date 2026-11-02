-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CrateOpeningSpinner = require(ReplicatedStorage.Client.UI.CrateOpeningSpinner)
local EggScaling = require(ReplicatedStorage.Shared.Util.EggScaling)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Interpolation = require(ReplicatedStorage.Shared.Utils.Interpolation)
require(ReplicatedStorage.Shared.Utils.Layout)
local Message = require(ReplicatedStorage.Client.Message)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
require(ReplicatedStorage.Packages.Networking)
local ParasiteVisual = require(ReplicatedStorage.Shared.Eggs.ParasiteVisual)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local OnRender = require(ReplicatedStorage.Shared.Utils.FrameStepper).OnRender
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VisualTransform = require(ReplicatedStorage.Shared.Utils.VisualTransform)
local MonsterParasite_3 = Remotes.MonsterParasite
local Ease = Interpolation.Ease
local SpatialCurve = Interpolation.SpatialCurve
local Fade = VisualTransform.Fade
local v1 = Random.new()
local LocalPlayer = Players.LocalPlayer
local v2 = Trove.new()
local v3 = v2:Extend()
local v4 = {}
local v7 = {}
local v8, v9, v10
local v11 = MonsterParasite_2.DefaultState()
local v12 = false
local v17 = false
local v19 = false
local v20 = false
local v21 = false
local OpeningId, OpeningId_2
local v22 = 0
local v23 = 0
local v24 = {}
local v25, v26, v27, v28, v29
local v30 = CameraShaker.new(Enum.RenderPriority.Camera.Value + 2, function(v31) -- line 68 | captures: Workspace
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        CurrentCamera.CFrame *= v31
    end
end)

local function playSound(v32, v33) -- line 74 | captures: ReplicatedStorage, Audio, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v34
    if Assets then
        v34 = Assets:FindFirstChild("Sounds")
    end
    local v35
    if v34 then
        v35 = v34:FindFirstChild(MonsterParasite.SoundFolderName)
    end
    local v36
    if v35 then
        v36 = v35:FindFirstChild(v32)
    end
    if v36 and v36:IsA("Sound") then
        Audio.Play(v36, v33)
    end
end

local function resolveChestTemplate() -- line 96 | captures: ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v37
    if Assets then
        v37 = Assets:FindFirstChild("Models")
    end
    local v38
    if v37 then
        v38 = v37:FindFirstChild(MonsterParasite.AssetsFolderName)
    end
    local v39
    if v38 then
        v39 = v38:FindFirstChild(MonsterParasite.ChestModelName)
    end
    if v39 and v39:IsA("Model") and v39.PrimaryPart then
        return v39
    end
    return nil
end

local function resolveVfxTemplate(v40) -- line 122 | captures: ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v41
    if Assets then
        v41 = Assets:FindFirstChild("VFX")
    end
    local v42
    if v41 then
        v42 = v41:FindFirstChild(MonsterParasite.VfxFolderName)
    end
    local v43
    if v42 then
        v43 = v42:FindFirstChild(v40)
    end
    if v43 and v43:IsA("Attachment") then
        return v43
    end
    return nil
end

local function resolveEnergyBurstTemplate() -- line 148 | captures: MonsterParasite, resolveVfxTemplate
    return (resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName))
end

local function resolveSwapPoofTemplate() -- line 151 | captures: MonsterParasite, resolveVfxTemplate
    return (resolveVfxTemplate(MonsterParasite.SwapPoofVfxName))
end

local function getMonsterModelIndex(v44) -- line 154 | captures: MonsterParasite
    local v45 = v44:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    if typeof(v45) == "number" then
        return v45
    end
    return nil
end

local function getMonsterAnimationIds(v46) -- line 161 | captures: MonsterParasite
    local v47 = v46:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    if typeof(v47) ~= "number" then
        v47 = nil
    end
    if v47 == nil then
        return nil
    end
    return MonsterParasite.MonsterAnimationIdsByIndex[v47]
end

local function waitForAnimator(v48) -- line 174
    local v49 = v48:FindFirstChildWhichIsA("Animator", true)
    if v49 == nil then
        local v50 = os.clock() + 5
        while true do
            if v48.Parent ~= nil and os.clock() < v50 then
                task.wait()
                local v51 = v48:FindFirstChildWhichIsA("Animator", true)
                if v51 == nil then
                    continue
                end
                return v51
            end
            break
        end
        if v48.Parent ~= nil then
            warn((("[MonsterParasite] Missing Animator in %*"):format((v48:GetFullName()))))
        end
        return nil
    end
    return v49
end

local v52 = {}
local v53 = { __mode = "k" }
local v54 = setmetatable(v52, v53)

local function loadTrackFromContentId(v55, v56) -- line 195
    local Animation = Instance.new("Animation")
    Animation.AnimationId = v56
    local v57, v58 = pcall(function() -- line 198 | captures: v55, Animation
        return v55:LoadAnimation(Animation)
    end)
    Animation:Destroy()
    if v57 then
        return v58
    end
    return nil, v58
end

local function savedAnimationSequence(v59, v60) -- line 208 | captures: RunService, MonsterParasite
    if RunService:IsStudio() then
        local v61 = v59:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
        if typeof(v61) ~= "number" then
            v61 = nil
        end
        local v62
        if v61 then
            v62 = MonsterParasite.MonsterAnimationIdsByIndex[v61]
            v61 = MonsterParasite.MonsterAnimationSaveNamesByIndex[v61]
        else
            v62 = v61
        end
        if v62 == nil or v61 == nil then
            return nil
        end
        local v63
        for v64, v65 in pairs(v62) do
            if v65 == v60 then
                v63 = v64
                break
            end
            v63 = nil
        end
        local v66 = v63 and v61[v63]
        local AnimSaves = v59:FindFirstChild("AnimSaves")
        local v67 = AnimSaves and v66 and AnimSaves:FindFirstChild(v66)
        if not (v67 and v67:IsA("KeyframeSequence")) then
            return nil
        end
        return v67
    end
    return nil
end

local function loadAnimationTrack(v68, v69) -- line 234 | captures: KeyframeSequenceProvider, waitForAnimator, v54, savedAnimationSequence
    local v70 = waitForAnimator(v68)
    if v70 == nil then
        return nil
    end
    local v71 = savedAnimationSequence(v68, v69)
    if v71 ~= nil then
        local v72 = v54[v71]
        local v73
        if v72 == nil then
            local v74
            v74, v73 = pcall(function() -- line 248 | captures: v71, KeyframeSequenceProvider
                return KeyframeSequenceProvider:RegisterKeyframeSequence(v71)
            end)
            if v74 then
                v54[v71] = v73
            else
                warn(("[MonsterParasite] Could not register embedded animation %*: %*"):format(v71.Name, v73))
                v73 = v72
            end
        else
            v73 = v72
        end
        if v73 ~= nil then
            local Animation = Instance.new("Animation")
            Animation.AnimationId = v73
            local v75, v76 = pcall(function() -- line 198 | captures: v70, Animation
                return v70:LoadAnimation(Animation)
            end)
            Animation:Destroy()
            local v77
            if v75 then
            else
                v76, v77 = nil, v76
            end
            if v76 == nil then
                warn(("[MonsterParasite] Could not load embedded animation %*: %*"):format(v71.Name, v77))
            else
                return v76
            end
        end
    end
    local v78 = ("rbxassetid://%*"):format(v69)
    local Animation = Instance.new("Animation")
    Animation.AnimationId = v78
    local v79, v80 = pcall(function() -- line 198 | captures: v70, Animation
        return v70:LoadAnimation(Animation)
    end)
    Animation:Destroy()
    local v81
    if v79 then
    else
        v80, v81 = nil, v80
    end
    if v80 == nil then
        warn((("[MonsterParasite] Failed to load animation %*: %*"):format(v69, v81)))
        return nil
    end
    return v80
end

local function playAnimationAndWait(v82, v83, v84) -- line 274 | captures: Timer, Trove
    local v85 = false
    local BindableEvent = Instance.new("BindableEvent")
    local v86 = Trove.new()
    v86:Add(BindableEvent)

    local function finish() -- line 279 | captures: v85, BindableEvent
        if not v85 then
            v85 = true
            BindableEvent:Fire()
        end
    end

    v86:Connect(v82.Ended, finish)
    v86:Connect(v82.Stopped, finish)
    v86:Connect(v83.Destroying, finish)
    v82:Play(0.1)
    local v87 = v82.Length + 1
    local v88 = math.max(v87, 5)
    v86:Add(Timer.Simple(v88, finish))
    if v84 then
        v84()
    end
    if not v85 then
        BindableEvent.Event:Wait()
    end
    v86:Destroy()
end

local function pauseIdle(v89) -- line 300 | captures: v7
    local v90 = v7[v89]
    if v90 and v90.IsPlaying then
        v90:Stop(0.1)
    end
end

local function resumeIdle(v91) -- line 306 | captures: v7
    local v92 = v7[v91]
    if v92 and v91.Parent and not v92.IsPlaying then
        v92:Play(0.1)
    end
end

local v93 = {}

v93[2] = { "Tongue3" }
v93[4] = { "root", "BackLeg1.L", "BackLeg1.R" }

local v94 = {}

local function v5(v95) -- line 316 | captures: KeyframeSequenceProvider, v94
    local v96 = v94[v95]
    if v96 == nil then
        local v97, v98 = pcall(function() -- line 322 | captures: v95, KeyframeSequenceProvider
            local v99 = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(v95)))
            local v100 = {}
            local v101 = {}
            local v102

            function v102(v103) -- line 327 | captures: v102, v100, v101
                local Name = v103.Name
                local v104 = v100[Name]
                if v104 == nil then
                    v100[Name] = v103.CFrame
                elseif not v101[Name] and not v104:FuzzyEq(v103.CFrame, 0.001) then
                    v101[Name] = true
                end
                for v105, v106 in v103:GetSubPoses() do
                    v102(v106)
                end
            end

            for v107, v108 in v99:GetKeyframes() do
                for v109, v110 in v108:GetChildren() do
                    if v110:IsA("Pose") then
                        v102(v110)
                    end
                end
            end
            local v111 = {}
            for v112 in v100 do
                v111[v112] = { constant = not v101[v112] }
            end
            return v111
        end)
        if v97 then
            v94[v95] = v98
            return v98
        end
        return nil
    end
    return v96
end

local function collectStrayBones(v113, v114, v115) -- line 361 | captures: KeyframeSequenceProvider, v93, v94
    local Idle = v114.Idle
    local v116 = v94[Idle]
    if v116 == nil then
        local v117
        v117, v116 = pcall(function() -- line 366 | captures: Idle, KeyframeSequenceProvider
            local v118 = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(Idle)))
            local v119 = {}
            local v120 = {}
            local v121

            function v121(v122) -- line 371 | captures: v121, v119, v120
                local Name = v122.Name
                local v123 = v119[Name]
                if v123 == nil then
                    v119[Name] = v122.CFrame
                elseif not v120[Name] and not v123:FuzzyEq(v122.CFrame, 0.001) then
                    v120[Name] = true
                end
                for v124, v125 in v122:GetSubPoses() do
                    v121(v125)
                end
            end

            for v126, v127 in v118:GetKeyframes() do
                for v128, v129 in v127:GetChildren() do
                    if v129:IsA("Pose") then
                        v121(v129)
                    end
                end
            end
            local v130 = {}
            for v131 in v119 do
                v130[v131] = { constant = not v120[v131] }
            end
            return v130
        end)
        if v117 then
            v94[Idle] = v116
        else
            v116 = nil
        end
    end
    if v116 == nil then
        return {}
    end
    local v132 = { v114.Yank }
    local Burp = v114.Burp
    if Burp ~= nil then
        table.insert(v132, Burp)
    end
    local v133 = {}
    for v134, v135 in v132 do
        local v136 = v94[v135]
        if v136 == nil then
            local pcall_2 = pcall
            local v137 = v135
            local v138
            v138, v136 = pcall_2(function() -- line 424 | captures: v137, KeyframeSequenceProvider
                local v139 = KeyframeSequenceProvider:GetKeyframeSequenceAsync((("rbxassetid://%*"):format(v137)))
                local v140 = {}
                local v141 = {}
                local v142

                function v142(v143) -- line 429 | captures: v142, v140, v141
                    local Name = v143.Name
                    local v144 = v140[Name]
                    if v144 == nil then
                        v140[Name] = v143.CFrame
                    elseif not v141[Name] and not v144:FuzzyEq(v143.CFrame, 0.001) then
                        v141[Name] = true
                    end
                    for v145, v146 in v143:GetSubPoses() do
                        v142(v146)
                    end
                end

                for v147, v148 in v139:GetKeyframes() do
                    for v149, v150 in v148:GetChildren() do
                        if v150:IsA("Pose") then
                            v142(v150)
                        end
                    end
                end
                local v151 = {}
                for v152 in v140 do
                    v151[v152] = { constant = not v141[v152] }
                end
                return v151
            end)
            if v138 then
                v94[v135] = v136
            else
                v136 = nil
            end
        end
        if v136 ~= nil then
            for v153 in v136 do
                if v116[v153] == nil then
                    v133[v153] = true
                end
            end
        end
    end
    for v154, v155 in v93[v115] or {} do
        local v156 = v116[v155]
        if v156 == nil then
            v133[v155] = true
        elseif v156.constant then
        end
    end
    local v157 = {}
    for v158 in v133 do
        local v159 = (nil):FindFirstChild(v158, true)
        if v159 and v159:IsA("Bone") then
            table.insert(v157, v159)
        end
    end
    return v157
end

local function guardStrayBones(v160, v161, v162, v163, v164) -- line 502 | captures: RunService, collectStrayBones
    if v160.Parent ~= nil then
        local v165 = collectStrayBones(v160, v162, v163)
        if #v165 ~= 0 then
            local v166 = {}
            local v167 = 0
            v164:Connect(RunService.PostSimulation, function(v168) -- line 512 | captures: v167, v161, v165, v166
                if v161.IsPlaying then
                    if v167 <= 0 then
                        for v169, v170 in v165 do
                            v166[v170] = v170.Transform
                        end
                    end
                    local v171 = v167 + v168
                    v167 = math.min(v171, 0.18)
                    local v172 = v167 / 0.18
                    local v173
                    for v174, v175 in v165 do
                        local v176 = v166[v175]
                        if v176 == nil then
                            v173 = CFrame.identity
                        elseif v172 < 1 then
                            v173 = v176:Lerp(CFrame.identity, v172)
                        end
                        v175.Transform = v173
                    end
                else
                    v167 = 0
                    table.clear(v166)
                end
            end)
        end
    end
end

local function startIdle(v177, v178) -- line 543 | captures: MonsterParasite, v7, loadAnimationTrack, guardStrayBones
    local v179 = v177:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    if typeof(v179) ~= "number" then
        v179 = nil
    end
    local v180, v181
    if v179 == nil then
    else
        local v182 = MonsterParasite.MonsterAnimationIdsByIndex[v179]
        v180 = v182
        v181 = v182
    end
    local v183 = v177:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    local v184, v185
    if typeof(v183) == "number" then
        v184 = v183
        v185 = v183
    end
    if v181 == nil or v185 == nil then
        return
    end
    local v186 = false
    v178:Add(function() -- line 566 | captures: v186
        v186 = true
    end)
    task.spawn(function() -- line 569 | captures: v180, v184, v186, v177, v178, v7, loadAnimationTrack, guardStrayBones
        local v187 = loadAnimationTrack(v177, v180.Idle)
        if v187 ~= nil then
            if v186 or v177.Parent == nil then
                v187:Destroy()
            else
                v187.Looped = true
                v187.Priority = Enum.AnimationPriority.Idle
                v7[v177] = v187
                v178:Add(v187)
                v178:Add(function() -- line 582 | captures: v177, v7
                    v7[v177] = nil
                end)
                v187:Play(0.1)
                guardStrayBones(v177, v187, v180, v184, v178)
            end
        end
    end)
end

local function getEquippedEggTool() -- line 589 | captures: EggToolDisplay, LocalPlayer
    local Character = LocalPlayer.Character
    if Character ~= nil then
        for v188, v189 in Character:GetChildren() do
            if v189:IsA("Tool") and EggToolDisplay.IsEggTool(v189) then
                return v189
            end
        end
    end
    return nil
end

local function getEquippedEggHandle() -- line 601 | captures: getEquippedEggTool
    local v190 = getEquippedEggTool()
    local v191
    if v190 then
        v191 = v190:FindFirstChild("Handle")
    end
    if v191 and v191:IsA("BasePart") then
        return v191
    end
    return nil
end

local function getEquippedEggModel() -- line 617 | captures: EggToolDisplay, LocalPlayer, getEquippedEggTool
    local v192 = getEquippedEggTool()
    if v192 == nil then
        return nil
    end
    local v193 = EggToolDisplay.GetToolUid(v192)
    local v194
    if v193 then
        v194 = v192:FindFirstChild((("%*_%*"):format(LocalPlayer.UserId, v193)))
    end
    if v194 ~= nil and v194:IsA("Model") then
        return v194
    end
    return v192:FindFirstChildOfClass("Model")
end

local function getWorldCFrame(v195) -- line 637
    if v195 ~= nil then
        if v195:IsA("BasePart") then
            return v195.CFrame
        end
        if v195:IsA("Attachment") or v195:IsA("Bone") then
            return v195.WorldCFrame
        end
    end
    return nil
end

local v196 = {
    ScaleTweenDelaySeconds = 0.2,
    PickupFadeStart = 0.55,
    PickupFadeEnd = 1,
    PickupMinScale = 0.001,
    PickupTargetHeight = 1.5,
    MouthBiteStuds = 2.2,
    SeizeSeconds = 0.1,
    MouthPull = 0.85,
    SwallowSeconds = 0.2,
    HandPoseName = "toolnone",
    HandPoseReleaseSeconds = 0.4,
    SwallowDepth = 0.9,
    SwallowScale = 0.05,
    MinScale = 0.001,
    MouthTargetNames = { "MouthCenter1", "ParasiteEatTarget", "Tongue3" }
}

local function getAnimatedWorldCFrame(v197) -- line 666
    if v197 ~= nil then
        if v197:IsA("Attachment") then
            local Parent = v197.Parent
            if Parent ~= nil and Parent:IsA("Bone") then
                return Parent.TransformedWorldCFrame * v197.CFrame
            end
            return v197.WorldCFrame
        end
        if v197:IsA("Bone") then
            return v197.TransformedWorldCFrame
        end
        if v197 ~= nil then
            if v197:IsA("BasePart") then
                return v197.CFrame
            end
            if v197:IsA("Attachment") or v197:IsA("Bone") then
                return v197.WorldCFrame
            end
        end
    end
    return nil
end

local function v6(v198) -- line 694 | captures: MonsterParasite
    return v198:FindFirstChild("ParasiteGrabber", true) or v198:FindFirstChild(MonsterParasite.TongueTipName, true) or v198:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true)
end

local function resolveMouthTarget(v199) -- line 704 | captures: v196
    for v200, v201 in v196.MouthTargetNames do
        local v202 = v199:FindFirstChild(v201, true)
        if v202 ~= nil then
            return v202
        end
    end
    return v199.PrimaryPart
end

local function resolveChestOrigin(v203) -- line 717 | captures: MonsterParasite
    for v204, v205 in MonsterParasite.ChestOriginNames do
        local v206 = v203:FindFirstChild(v205, true)
        if v206 ~= nil then
            return v206
        end
    end
    return nil
end

local function buildGroundProbeParams(v207) -- line 730 | captures: v9, Players, Workspace, MonsterParasite
    local v208 = RaycastParams.new()
    v208.FilterType = Enum.RaycastFilterType.Exclude
    v208.IgnoreWater = true
    local v209 = { v207 }
    if v9 then
        local v210 = v9
        table.insert(v209, v210)
    end
    local v211 = Workspace:FindFirstChild(MonsterParasite.MarkerFolderName, true)
    if v211 then
        table.insert(v209, v211)
    end
    for v212, v213 in Players:GetPlayers() do
        local Character = v213.Character
        if Character then
            table.insert(v209, Character)
        end
    end
    v208.FilterDescendantsInstances = v209
    return v208
end

local function monsterForward(v214, v215) -- line 752
    local v216 = v214:GetPivot().LookVector * Vector3.new(1, 0, 1)
    if v216.Magnitude < 0.05 then
        v216 = v215.LookVector * Vector3.new(1, 0, 1)
    end
    if v216.Magnitude > 0.001 then
        return v216.Unit
    end
    return (Vector3.new(0, 0, -1))
end

local function probeGround(v217, v218) -- line 762 | captures: Workspace, MonsterParasite
    local v219 = v217 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight
    local v220 = Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth
    return Workspace:Raycast(v219, v220, v218)
end

local function resolveGroundLanding(v221, v222) -- line 767 | captures: Workspace, MonsterParasite, v1, buildGroundProbeParams
    local v223 = v221:GetPivot().LookVector * Vector3.new(1, 0, 1)
    if v223.Magnitude < 0.05 then
        v223 = v222.LookVector * Vector3.new(1, 0, 1)
    end
    local v224
    if v223.Magnitude <= 0.001 then
        v224 = Vector3.new(0, 0, -1)
    else
        v224 = v223.Unit
    end
    local Position = v222.Position
    local v225 = buildGroundProbeParams(v221)
    local ChestThrowDistanceMin = MonsterParasite.ChestThrowDistanceMin
    local v226 = MonsterParasite.ChestThrowDistanceMax - ChestThrowDistanceMin
    local v227 = math.max(v226, 0)
    local ChestThrowSpreadDegrees = MonsterParasite.ChestThrowSpreadDegrees
    local v228 = math.rad(ChestThrowSpreadDegrees)
    local ChestThrowStraightJitterDegrees = MonsterParasite.ChestThrowStraightJitterDegrees
    local v229 = math.rad(ChestThrowStraightJitterDegrees)
    local ChestThrowAttempts = MonsterParasite.ChestThrowAttempts
    local v230 = math.max(ChestThrowAttempts, 1)
    local v231 = v230 / 2
    local v232 = math.floor(v231)
    local v233 = math.max(v232, 1)

    local function candidate(v234) -- line 787 | captures: Position, v225, ChestThrowDistanceMin, v227, Workspace, MonsterParasite, v1
        local v235 = v1:NextNumber()
        local v236 = Position + v234 * (ChestThrowDistanceMin + v235 * v227)
        local v237 = v236 - Position
        local v238 = Workspace:Raycast(Position, v237, v225)
        if v238 == nil then
            local v239 = v236 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight
            local v240 = Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth
            local v241 = Workspace:Raycast(v239, v240, v225)
            if v241 == nil then
                return nil, nil
            end
            local v242 = CFrame.new(v241.Position)
            local v243 = v1:NextNumber() * 3.141592653589793 * 2
            return v242 * CFrame.Angles(0, v243, 0), v241.Normal
        end
        local v244 = v238.Position - v234 * 1.5
        if ((v244 - Position) * Vector3.new(1, 0, 1)).Magnitude < ChestThrowDistanceMin then
            return nil, nil
        end
        local v245 = v244 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight
        local v246 = Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth
        local v247 = Workspace:Raycast(v245, v246, v225)
        if v247 == nil then
            return nil, nil
        end
        local v248 = CFrame.new(v247.Position)
        local v249 = v1:NextNumber() * 3.141592653589793 * 2
        return v248 * CFrame.Angles(0, v249, 0), v247.Normal
    end

    for v250 = 1, v230 do
        local v251 = v250 / 2
        local v252 = math.floor(v251)
        local v253
        if v252 == 0 then
            v253 = (v1:NextNumber() * 2 - 1) * v229
        else
            local v254 = if v250 % 2 == 0 then 1 else -1
            local v255 = v254 * v228
            local v256 = v252 / v233
            v253 = v255 * math.min(v256, 1)
        end
        local v257, v258 = candidate(CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v253) * v224)
        if v257 ~= nil and v258 ~= nil then
            return v257, v258
        end
    end
    local v259 = Position + v224 * ChestThrowDistanceMin
    local v260 = Workspace:Raycast(Position, v259 - Position, v225)
    if v260 ~= nil then
        v259 = v260.Position - v224 * 1.5
    end
    local v261 = v259 + Vector3.new(0, 1, 0) * MonsterParasite.ChestGroundProbeHeight
    local v262 = Vector3.new(0, 1, 0) * -MonsterParasite.ChestGroundProbeDepth
    local v263 = Workspace:Raycast(v261, v262, v225)
    local v264
    if v263 then
        v264 = v263.Position
    else
        local X = v259.X
        local Y = v221:GetPivot().Position.Y
        local Z = v259.Z
        v264 = Vector3.new(X, Y, Z)
    end
    local v265 = CFrame.new(v264)
    local v266 = v1:NextNumber() * 3.141592653589793 * 2
    local v267 = v265 * CFrame.Angles(0, v266, 0)
    if v263 then
        return v267, v263.Normal
    end
    return v267, (Vector3.new(0, 1, 0))
end

local function resolveEffectParent() -- line 862 | captures: Workspace
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if __DEBRIS and __DEBRIS:IsA("Folder") then
        return __DEBRIS
    end
    return Workspace
end

local function clearChest() -- line 872 | captures: v9
    if v9 then
        v9:Destroy()
        v9 = nil
    end
end

local function createChest(v268) -- line 878 | captures: v9, Workspace, resolveChestTemplate
    local v269 = resolveChestTemplate()
    if v269 == nil then
        return nil
    end
    if v9 then
        v9:Destroy()
        v9 = nil
    end
    local v270 = v269:Clone()
    for v271, v272 in v270:GetDescendants() do
        if v272:IsA("BasePart") then
            v272.Anchored = true
            v272.CanCollide = false
            v272.CanTouch = false
        end
    end
    v270:PivotTo(v268)
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if not (__DEBRIS and __DEBRIS:IsA("Folder")) then
        __DEBRIS = Workspace
    end
    v270.Parent = __DEBRIS
    v9 = v270
    return v270
end

local function stopPendingYankFollow() -- line 909 | captures: v28
    local v273 = v28
    v28 = nil
    if v273 ~= nil then
        v273:Disconnect()
    end
end

local function prepareEggYankClone(v274) -- line 916 | captures: Workspace, MonsterParasite, ParasiteVisual
    if v274.PrimaryPart == nil then
        return nil
    end
    local v275 = v274:Clone()

    local function inside(v276) -- line 922 | captures: v275
        if v276 == nil then
            return false
        end
        return (v276:IsDescendantOf(v275))
    end

    for v277, v278 in v275:GetDescendants() do
        if v278:IsA("BasePart") then
            v278.Anchored = true
            v278.CanCollide = false
            v278.CanQuery = false
            v278.CanTouch = false
            v278.Massless = true
        elseif v278:IsA("BillboardGui") then
            v278:Destroy()
        elseif v278:IsA("Motor6D") then
            local Part0 = v278.Part0
            if Part0 ~= nil and Part0:IsDescendantOf(v275) then
                local Part1 = v278.Part1
                if Part1 ~= nil then
                    Part1:IsDescendantOf(v275)
                end
            else
                v278:Destroy()
            end
        elseif v278:IsA("Weld") or v278:IsA("WeldConstraint") then
        end
    end
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if __DEBRIS then
        if not __DEBRIS:IsA("Folder") then
            __DEBRIS = nil
        end
    else
        __DEBRIS = Workspace
    end
    v275.Parent = __DEBRIS
    v275:PivotTo(v274:GetPivot())
    local v279 = v274:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
    local v280 = v275:FindFirstChild(MonsterParasite.ParasiteVisualName, true)
    if v279 ~= nil and v280 ~= nil and v279:IsA("Model") and v280:IsA("Model") then
        local v281 = ParasiteVisual.PoseDrift(v279) - ParasiteVisual.PoseDrift(v280)
        if v281.Magnitude > 0.001 then
            v280:PivotTo(v280:GetPivot() + v281)
        end
    end
    return v275
end

local function holdHandPose() -- line 967 | captures: v29, LocalPlayer, v196
    if v29 == nil then
        local Character = LocalPlayer.Character
        if Character ~= nil then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            local Animator, Animator_2
            if Humanoid == nil then
            else
                local Animator_3 = Humanoid:FindFirstChildOfClass("Animator")
                Animator = Animator_3
                Animator_2 = Animator_3
            end
            if Animator_2 ~= nil then
                local Animate = Character:FindFirstChild("Animate")
                local v282
                if Animate == nil then
                else
                    v282 = Animate:FindFirstChild(v196.HandPoseName)
                end
                local Animation, Animation_2
                if v282 == nil then
                else
                    local Animation_3 = v282:FindFirstChildOfClass("Animation")
                    Animation = Animation_3
                    Animation_2 = Animation_3
                end
                if Animation_2 ~= nil then
                    local Action = Enum.AnimationPriority.Action
                    for v283, v284 in Animator_2:GetPlayingAnimationTracks() do
                        local Animation = v284.Animation
                        if Animation ~= nil and Animation.AnimationId == Animation_2.AnimationId then
                            Action = v284.Priority
                            break
                        end
                    end
                    local v285, v286 = pcall(function() -- line 1007 | captures: Animation, Animator
                        return Animator:LoadAnimation(Animation)
                    end)
                    if v285 then
                        v286.Looped = true
                        v286.Priority = Action
                        v286:Play(0)
                        v29 = v286
                    else
                        warn((("[MonsterParasite] Failed to hold the egg pose: %*"):format(v286)))
                    end
                end
            end
        end
    end
end

local function releaseHandPose() -- line 1019 | captures: v29, v196
    local v287 = v29
    v29 = nil
    if v287 == nil then
        return
    end
    v287:Stop(v196.HandPoseReleaseSeconds)
    task.delay(v196.HandPoseReleaseSeconds, function() -- line 1026 | captures: v287
        v287:Destroy()
    end)
end

local function captureEquippedEgg() -- line 1030 | captures: v25, v26, v27, v28, RunService, Workspace, Fade, LocalPlayer, getEquippedEggModel, prepareEggYankClone, holdHandPose
    if v25 == nil then
        local v288 = getEquippedEggModel()
        if v288 ~= nil then
            local v289 = prepareEggYankClone(v288)
            if v289 ~= nil then
                local v290 = Fade()
                v290(v289, 1, 1)
                v25 = v289
                v27 = v290
                v26 = v288
                holdHandPose()
                local v291
                local v292 = false
                local v293 = v28
                v28 = nil
                if v293 ~= nil then
                    v293:Disconnect()
                end
                v28 = RunService.RenderStepped:Connect(function() -- line 1055 | captures: v291, v292, v288, v289, v290, Workspace, LocalPlayer
                    if v289.Parent == nil then
                        return
                    end
                    local Character = LocalPlayer.Character
                    local RightHand
                    if Character == nil then
                    else
                        RightHand = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm") or Character:FindFirstChild("HumanoidRootPart")
                    end
                    if RightHand ~= nil and not RightHand:IsA("BasePart") then
                        RightHand = nil
                    end
                    if v288:IsDescendantOf(Workspace) then
                        if RightHand ~= nil then
                            v291 = RightHand.CFrame:ToObjectSpace(v288:GetPivot())
                        end
                        v289:PivotTo(v288:GetPivot())
                    else
                        if not v292 then
                            v292 = true
                            v290(v289, 1, 0)
                        end
                        if RightHand ~= nil and v291 ~= nil then
                            v289:PivotTo(RightHand.CFrame * v291)
                        end
                    end
                end)
            end
        end
    end
end

local function takeCapturedEgg() -- line 1093 | captures: v25, v26, v27, v28, v29, Workspace, ParasiteVisual, Fade, LocalPlayer, v196, captureEquippedEgg
    captureEquippedEgg()
    local v294 = v28
    v28 = nil
    if v294 ~= nil then
        v294:Disconnect()
    end
    local v295 = v25
    local v296 = v27
    local v297 = v26
    v25 = nil
    v27 = nil
    v26 = nil
    if v295 ~= nil and v295.Parent ~= nil then
        if v297 ~= nil and v297:IsDescendantOf(Workspace) then
            v295:PivotTo(v297:GetPivot())
            Fade()(v297, 1, 1)
        end
        if v296 ~= nil then
            v296(v295, 1, 0)
        end
        local Character = LocalPlayer.Character
        if Character ~= nil then
            ParasiteVisual.Clear(Character)
        end
        local v298 = v29
        v29 = nil
        if v298 ~= nil then
            v298:Stop(v196.HandPoseReleaseSeconds)
            task.delay(v196.HandPoseReleaseSeconds, function() -- line 1134 | captures: v298
                v298:Destroy()
            end)
        end
        return v295
    end
    local v299 = v29
    v29 = nil
    if v299 ~= nil then
        v299:Stop(v196.HandPoseReleaseSeconds)
        task.delay(v196.HandPoseReleaseSeconds, function() -- line 1111 | captures: v299
            v299:Destroy()
        end)
    end
    return nil
end

local function discardPendingYank() -- line 1139 | captures: v25, v26, v27, v28, v29, v196
    local v300 = v28
    v28 = nil
    if v300 ~= nil then
        v300:Disconnect()
    end
    local v301 = v29
    v29 = nil
    if v301 ~= nil then
        v301:Stop(v196.HandPoseReleaseSeconds)
        task.delay(v196.HandPoseReleaseSeconds, function() -- line 1149 | captures: v301
            v301:Destroy()
        end)
    end
    if v25 ~= nil then
        v25:Destroy()
        v25 = nil
    end
    v27 = nil
    v26 = nil
end

local function carryEgg(v302, v303) -- line 1160 | captures: EggScaling, v196
    local function v304(v305, ...)
        return (math.min(v305, ...))
    end

    local v306 = v302:GetBoundingBox()
    local v307 = Vector3.new(1, 1, 1) * (v196.MouthBiteStuds * v303:GetScale())
    local v308 = v302:GetScale()
    return {
        Model = v302,
        StartScale = v308,
        FitScale = v304(v308, EggScaling.FitInside(v302, v307)),
        CenterOffset = v302:GetPivot():PointToObjectSpace(v306.Position)
    }
end

local function placeCarriedEgg(v309, v310, v311) -- line 1166
    local Model = v309.Model
    Model:ScaleTo(v311)
    Model:PivotTo(v310 * CFrame.new(-v309.CenterOffset * (v311 / v309.StartScale)))
end

local function swallowEgg(v312, v313, v314, v315, v316, v317) -- line 1171 | captures: OnRender, Ease, v196, getAnimatedWorldCFrame
    local Model = v312.Model
    OnRender(function(v318, v319) -- line 1174 | captures: v312, v313, v314, v315, v316, v317, Model, Ease, v196, getAnimatedWorldCFrame
        if Model.Parent == nil or v313.Parent == nil then
            return true
        end
        local v320 = getAnimatedWorldCFrame(v314)
        local v321
        if v320 == nil then
            v321 = v316.Position
        else
            local v322 = v313:GetPivot():VectorToWorldSpace(v315)
            v321 = v320.Position + v322 * (v196.SwallowDepth * v313:GetScale())
        end
        local v323 = Ease(v319, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local v324 = CFrame.new(v316.Position:Lerp(v321, v323)) * v316.Rotation
        local v325 = v317 * v196.SwallowScale
        local MinScale = v196.MinScale
        local v326 = math.lerp(v317, v325, v323)
        local v327 = math.max(MinScale, v326)
        local Model_2 = v312.Model
        Model_2:ScaleTo(v327)
        Model_2:PivotTo(v324 * CFrame.new(-v312.CenterOffset * (v327 / v312.StartScale)))
        return nil
    end, v196.SwallowSeconds, true):OnComplete(function() -- line 1197 | captures: Model
        Model:Destroy()
    end)
end

local function animateEggYank(v328) -- line 1201 | captures: v25, v26, v27, v28, v29, MonsterParasite, OnRender, Ease, v196, getAnimatedWorldCFrame, resolveMouthTarget, takeCapturedEgg, carryEgg, swallowEgg
    local PrimaryPart = v328.PrimaryPart
    if PrimaryPart == nil then
        local v329 = v28
        v28 = nil
        if v329 ~= nil then
            v329:Disconnect()
        end
        local v330 = v29
        v29 = nil
        if v330 ~= nil then
            v330:Stop(v196.HandPoseReleaseSeconds)
            task.delay(v196.HandPoseReleaseSeconds, function() -- line 1214 | captures: v330
                v330:Destroy()
            end)
        end
        if v25 ~= nil then
            v25:Destroy()
            v25 = nil
        end
        v27 = nil
        v26 = nil
    else
        local v331 = takeCapturedEgg()
        if v331 ~= nil then
            local v332 = resolveMouthTarget(v328)
            local v333 = carryEgg(v331, v328)
            local v334 = v331:GetPivot() * CFrame.new(v333.CenterOffset)
            local v335 = OnRender(function(v336, v337) -- line 1234 | captures: v328, PrimaryPart, v331, v332, v333, v334, Ease, getAnimatedWorldCFrame
                if v331.Parent == nil or v328.Parent == nil then
                    return true
                end
                local v338 = getAnimatedWorldCFrame(v332) or PrimaryPart.CFrame
                local v339 = Ease(v337, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                local v340 = CFrame.new(v334.Position:Lerp(v338.Position, v339)) * v334.Rotation
                local StartScale = v333.StartScale
                local FitScale = v333.FitScale
                local v341 = math.lerp(StartScale, FitScale, v339)
                local Model = v333.Model
                Model:ScaleTo(v341)
                Model:PivotTo(v340 * CFrame.new(-v333.CenterOffset * (v341 / v333.StartScale)))
                return nil
            end, MonsterParasite.YankDuration, true)
            v335:Wait()
            v335:Destroy()
            if v331.Parent == nil or v328.Parent == nil then
                v331:Destroy()
            else
                local v342 = v331:GetPivot() * CFrame.new(v333.CenterOffset * (v333.FitScale / v333.StartScale))
                swallowEgg(v333, v328, v332, Vector3.new(0, 0, 1), v342, v333.FitScale)
            end
        end
    end
end

local function animateEggGrab(v343, v344) -- line 1262 | captures: MonsterParasite, getAnimatedWorldCFrame, resolveMouthTarget, takeCapturedEgg, carryEgg, animateEggYank
    if v344.IsPlaying then
        local v345 = takeCapturedEgg()
        if v345 ~= nil then
            local v346 = v343:FindFirstChild("ParasiteGrabber", true) or v343:FindFirstChild(MonsterParasite.TongueTipName, true) or v343:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true)
            local v347 = resolveMouthTarget(v343)
            local v348 = getAnimatedWorldCFrame(v346)
            local v349 = getAnimatedWorldCFrame(v347)
            if v348 == nil or v349 == nil then
                v345:Destroy()
            else
                local v350 = carryEgg(v345, v343)
                local v351 = v345:GetPivot() * CFrame.new(v350.CenterOffset)
                local Rotation = v351.Rotation
                local v352 = v351.Position - v348.Position
                local v353 = v348.Position - v349.Position
                if v353.Magnitude <= 0.01 then
                    Vector3.new(0, 0, 1)
                else
                    v343:GetPivot():VectorToObjectSpace(-v353.Unit)
                end
            end
        end
    else
        animateEggYank(v343)
    end
end

local function pulseMonsterScale(v354) -- line 1302 | captures: OnRender, Ease
    local v355 = v354:GetScale()
    local v356 = OnRender(function(v357, v358) -- line 1305 | captures: v354, v355, Ease
        if v354.Parent == nil then
            return true
        end
        local v359 = Ease(v358, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v360 = v355 * 1.08
        v354:ScaleTo((math.lerp(v355, v360, v359)))
        return nil
    end, 0.12, true)
    v356:Wait()
    v356:Destroy()
    if v354.Parent == nil then
        return
    end
    local v361 = OnRender(function(v362, v363) -- line 1319 | captures: v354, v355, Ease
        if v354.Parent == nil then
            return true
        end
        local v364 = Ease(v363, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        local v365 = v355 * 1.08
        v354:ScaleTo((math.lerp(v365, v355, v364)))
        return nil
    end, 0.4, true)
    v361:Wait()
    v361:Destroy()
    if v354.Parent then
        v354:ScaleTo(v355)
    end
end

local v366 = {}
local v367 = 0
local v368 = 0

local function wrapAngle(v369) -- line 1337
    return (v369 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end

local function getMonsterRestCFrame(v370) -- line 1340 | captures: v366
    local v371 = v366[v370]
    if v371 == nil then
        local PrimaryPart = v370.PrimaryPart
        if PrimaryPart == nil then
            return nil
        end
        v366[v370] = PrimaryPart.CFrame
        return PrimaryPart.CFrame
    end
    return v371
end

local function applyFacingYaw(v372, v373) -- line 1356 | captures: v366
    local PrimaryPart = v372.PrimaryPart
    local v374 = v366[v372]
    if v374 == nil then
        local PrimaryPart = v372.PrimaryPart
        if PrimaryPart == nil then
            v374 = nil
        else
            v366[v372] = PrimaryPart.CFrame
            v374 = PrimaryPart.CFrame
        end
    end
    if PrimaryPart ~= nil and v374 ~= nil then
        PrimaryPart.CFrame = v374 * CFrame.fromEulerAnglesYXZ(0, v373, 0)
    end
end

local function adoptMonsterFacing(v375) -- line 1376 | captures: v367, v366
    local PrimaryPart = v375.PrimaryPart
    if PrimaryPart == nil then
        return
    end
    v366[v375] = PrimaryPart.CFrame
    local v376 = v367
    if math.abs(v376) <= 0.001 then
        return
    end
    local PrimaryPart_2 = v375.PrimaryPart
    local v377 = v366[v375]
    if v377 == nil then
        local PrimaryPart = v375.PrimaryPart
        if PrimaryPart == nil then
            v377 = nil
        else
            v366[v375] = PrimaryPart.CFrame
            v377 = PrimaryPart.CFrame
        end
    end
    if PrimaryPart_2 ~= nil and v377 ~= nil then
        PrimaryPart_2.CFrame = v377 * CFrame.fromEulerAnglesYXZ(0, v367, 0)
    end
end

local function holdMonsterFacing(v378, v379, v380) -- line 1405 | captures: v367, v366
    local v381 = v380 * 16
    local v382 = math.min(v381, 1)
    v367 += ((v379 - v367 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v382
    local PrimaryPart = v378.PrimaryPart
    local v383 = v366[v378]
    if v383 == nil then
        local PrimaryPart = v378.PrimaryPart
        if PrimaryPart == nil then
            v383 = nil
        else
            v366[v378] = PrimaryPart.CFrame
            v383 = PrimaryPart.CFrame
        end
    end
    if PrimaryPart ~= nil and v383 ~= nil then
        PrimaryPart.CFrame = v383 * CFrame.fromEulerAnglesYXZ(0, v367, 0)
    end
end

local function releaseMonsterFacing() -- line 1427 | captures: v8, v367, v368, OnRender, Ease, v366
    v368 += 1
    local v384 = v368
    local v385 = v367
    if math.abs(v385) < 0.001 then
        v367 = 0
    else
        local v386 = OnRender(function(v387, v388) -- line 1437 | captures: v384, v385, v8, v367, v368, Ease, v366
            if v368 == v384 then
                local v389 = Ease(v388, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
                v367 = v385 * (1 - v389)
                local v390 = v8
                if v390 ~= nil and v390.Parent ~= nil then
                    local PrimaryPart = v390.PrimaryPart
                    local v391 = v366[v390]
                    if v391 == nil then
                        local PrimaryPart = v390.PrimaryPart
                        if PrimaryPart == nil then
                            v391 = nil
                        else
                            v366[v390] = PrimaryPart.CFrame
                            v391 = PrimaryPart.CFrame
                        end
                    end
                    if PrimaryPart ~= nil and v391 ~= nil then
                        PrimaryPart.CFrame = v391 * CFrame.fromEulerAnglesYXZ(0, v367, 0)
                    end
                end
                return nil
            end
            return true
        end, 0.45, true)
        v386:Wait()
        v386:Destroy()
        if v368 == v384 then
            v367 = 0
            local v392 = v8
            if v392 == nil or v392.Parent == nil then
                return
            end
            local PrimaryPart = v392.PrimaryPart
            local v393 = v366[v392]
            if v393 == nil then
                local PrimaryPart = v392.PrimaryPart
                if PrimaryPart == nil then
                    v393 = nil
                else
                    v366[v392] = PrimaryPart.CFrame
                    v393 = PrimaryPart.CFrame
                end
            end
            if PrimaryPart ~= nil and v393 ~= nil then
                PrimaryPart.CFrame = v393 * CFrame.fromEulerAnglesYXZ(0, 0, 0)
            end
        end
    end
end

local function playYankAnimation(v394) -- line 1493 | captures: v25, v26, v27, v28, v29, v367, v368, RunService, MonsterParasite, Trove, v7, playSound, loadAnimationTrack, playAnimationAndWait, getEquippedEggTool, v196, animateEggYank, animateEggGrab, v366
    local PrimaryPart = v394.PrimaryPart
    if PrimaryPart == nil then
        local v395 = v28
        v28 = nil
        if v395 ~= nil then
            v395:Disconnect()
        end
        local v396 = v29
        v29 = nil
        if v396 ~= nil then
            v396:Stop(v196.HandPoseReleaseSeconds)
            task.delay(v196.HandPoseReleaseSeconds, function() -- line 1506 | captures: v396
                v396:Destroy()
            end)
        end
        if v25 ~= nil then
            v25:Destroy()
            v25 = nil
        end
        v27 = nil
        v26 = nil
    else
        local v397 = v394:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
        if typeof(v397) ~= "number" then
            v397 = nil
        end
        local v398
        if v397 == nil then
        else
            v398 = MonsterParasite.MonsterAnimationIdsByIndex[v397]
        end
        local v399, v400
        if v398 then
            local v401 = loadAnimationTrack(v394, v398.Yank)
            v399 = v401
            v400 = v401
        end
        if v400 == nil then
            playSound(MonsterParasite.YankSoundName, PrimaryPart)
            animateEggYank(v394)
        else
            local v402 = Trove.new()
            v402:Add(v400)
            v402:Add(function() -- line 1541 | captures: v394, v7
                if v394.Parent then
                    local v403 = v7[v394]
                    if v403 and v394.Parent and not v403.IsPlaying then
                        v403:Play(0.1)
                    end
                end
            end)
            v368 += 1
            v402:Connect(RunService.RenderStepped, function(v404) -- line 1551 | captures: v394, v367, getEquippedEggTool, v366
                if v394.Parent == nil then
                    return
                end
                local v405 = getEquippedEggTool()
                local v406
                if v405 then
                    v406 = v405:FindFirstChild("Handle")
                end
                if not (v406 and v406:IsA("BasePart")) then
                    v406 = nil
                end
                if v406 == nil then
                    return
                end
                local v407 = v366[v394]
                if v407 == nil then
                    local PrimaryPart = v394.PrimaryPart
                    if PrimaryPart == nil then
                        v407 = nil
                    else
                        v366[v394] = PrimaryPart.CFrame
                        v407 = PrimaryPart.CFrame
                    end
                end
                if v407 ~= nil then
                    local X = v406.Position.X
                    local Y = v407.Position.Y
                    local Z = v406.Position.Z
                    local v408 = Vector3.new(X, Y, Z)
                    if not ((v408 - v407.Position).Magnitude <= 0.001) then
                        local v409, v410 = v407:ToOrientation()
                        _ = v409
                        local v411, v412 = CFrame.lookAt(v407.Position, v408):ToOrientation()
                        _ = v411
                        local v413 = v404 * 16
                        local v414 = math.min(v413, 1)
                        v367 += (((v412 - v410 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793 - v367 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * v414
                        local PrimaryPart = v394.PrimaryPart
                        local v415 = v366[v394]
                        if v415 == nil then
                            local PrimaryPart = v394.PrimaryPart
                            if PrimaryPart == nil then
                                v415 = nil
                            else
                                v366[v394] = PrimaryPart.CFrame
                                v415 = PrimaryPart.CFrame
                            end
                        end
                        if PrimaryPart ~= nil and v415 ~= nil then
                            PrimaryPart.CFrame = v415 * CFrame.fromEulerAnglesYXZ(0, v367, 0)
                        end
                    end
                end
            end)
            local v416 = false
            v402:Connect(v400:GetMarkerReachedSignal(MonsterParasite.GrabMarkerName), function() -- line 1615 | captures: v399, v416, v394, animateEggGrab
                if not v416 then
                    v416 = true
                    if v394.Parent ~= nil then
                        animateEggGrab(v394, v399)
                    end
                end
            end)
            local v417 = v7[v394]
            if v417 and v417.IsPlaying then
                v417:Stop(0.1)
            end
            playSound(MonsterParasite.YankSoundName, PrimaryPart)
            v399.Looped = false
            local Action4 = Enum.AnimationPriority.Action4
            v399.Priority = Action4
            playAnimationAndWait(v399, v394, nil)
            if not v416 then
                warn((("[MonsterParasite] Yank animation did not reach the %* marker"):format(MonsterParasite.GrabMarkerName)))
                if not v416 and v394.Parent ~= nil then
                    animateEggGrab(v394, v399)
                end
            end
            v402:Destroy()
        end
    end
end

local function emitEnergyBurst(v418, v419) -- line 1640 | captures: Emit, MonsterParasite, resolveVfxTemplate
    local v420 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
    if v420 == nil then
        return
    end
    local v421 = v420:Clone()
    v421.Parent = v418
    v419:Add(v421)
    Emit(v421)
end

local function animateMonsterRoar(v422, v423) -- line 1650 | captures: MonsterParasite, OnRender
    local v424 = v422:GetPivot()
    local v425 = OnRender(function(v426, v427) -- line 1652 | captures: v422, v424
        if v422.Parent == nil then
            return true
        end
        local v428 = v427 * 3.141592653589793 * 3
        local v429 = math.sin(v428) * 0.15707963267948966
        local v430 = v427 * 3.141592653589793
        local v431 = v429 * math.sin(v430)
        local v432 = v427 * 3.141592653589793
        local v433 = math.sin(v432) * 0.4
        local v434 = v424 * CFrame.new(0, v433, 0)
        v422:PivotTo(v434 * CFrame.Angles(v431, 0, v431 * -0.35))
        if v427 >= 1 then
            v422:PivotTo(v424)
        end
        return nil
    end, MonsterParasite.RoarDuration, true)
    v423:Add(function() -- line 1665 | captures: v425
        v425:Destroy()
    end)
end

local function upAlignedCFrame(v435, v436) -- line 1669
    local v437
    if v436.Magnitude <= 0.001 then
        v437 = Vector3.new(0, 1, 0)
    else
        v437 = v436.Unit
    end
    local Y = v437.Y
    local v438
    if math.abs(Y) <= 0.99 then
        v438 = Vector3.new(0, 1, 0)
    else
        v438 = Vector3.new(1, 0, 0)
    end
    local v439 = v438:Cross(v437)
    local v440
    if v439.Magnitude <= 0.001 then
        v440 = Vector3.new(1, 0, 0)
    else
        v440 = v439.Unit
    end
    return CFrame.fromMatrix(v435, v440, v437, -v437:Cross(v440).Unit)
end

local function resolveImpactParticles() -- line 1690 | captures: ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v441
    if Assets then
        v441 = Assets:FindFirstChild("Particles")
    end
    local v442
    if v441 then
        v442 = v441:FindFirstChild(MonsterParasite.GroundHitParticlesName)
    end
    if v442 ~= nil and (v442:IsA("ParticleEmitter") or v442:FindFirstChildWhichIsA("ParticleEmitter", true) ~= nil) then
        return v442
    end
    return nil
end

local function emitGroundHit(v443) -- line 1715 | captures: Debris, Workspace, PlayVFX, resolveImpactParticles
    local v444 = resolveImpactParticles()
    if v444 == nil then
        return
    end
    local Part = Instance.new("Part")
    Part.Name = "MonsterChestGroundHit"
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = v443
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if not (__DEBRIS and __DEBRIS:IsA("Folder")) then
        __DEBRIS = Workspace
    end
    Part.Parent = __DEBRIS
    local v445 = v444:Clone()
    if not pcall(PlayVFX, Part, v443, v445) then
        v445:Destroy()
    end
    Debris:AddItem(Part, 3)
end

local function shakeCamera(v446, v447) -- line 1746 | captures: Workspace, MonsterParasite, v30
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local ChestImpactShakeRange = MonsterParasite.ChestImpactShakeRange
    local Magnitude = (CurrentCamera.CFrame.Position - v446).Magnitude
    if not (ChestImpactShakeRange <= Magnitude) then
        v30:ShakeOnce(v447 * (1 - Magnitude / ChestImpactShakeRange), MonsterParasite.ChestImpactShakeRoughness, MonsterParasite.ChestImpactShakeFadeIn, MonsterParasite.ChestImpactShakeFadeOut)
    end
end

local function animateChestLaunch(v448, v449) -- line 1758 | captures: v9, Workspace, MonsterParasite, OnRender, Ease, SpatialCurve, v30, playSound, getAnimatedWorldCFrame, resolveGroundLanding, createChest, upAlignedCFrame, emitGroundHit
    local PrimaryPart = v448.PrimaryPart
    local v450 = PrimaryPart ~= nil
    assert(v450, "Monster model requires a PrimaryPart")
    local v451 = getAnimatedWorldCFrame(v449) or PrimaryPart.CFrame
    local v452 = createChest(v451)
    if v452 == nil then
        return
    end
    local v453 = v452:GetScale()
    local v454 = v453 * MonsterParasite.ChestLaunchStartScale
    local v455, v456 = resolveGroundLanding(v448, v451)
    local Position = v455.Position
    v452:PivotTo(v455)
    local v457, v458 = v452:GetBoundingBox()
    local v459 = v455 + Vector3.new(0, 1, 0) * (Position.Y - (v457.Position.Y - v458.Y * 0.5))
    v452:PivotTo(v451)
    v452:ScaleTo(v454)
    local Position_2 = v451.Position
    local Position_3 = v459.Position
    local v460 = (Position_3 - Position_2) * Vector3.new(1, 0, 1)
    local v461
    if v460.Magnitude <= 0.001 then
        local v462 = v448:GetPivot().LookVector * Vector3.new(1, 0, 1)
        if v462.Magnitude < 0.05 then
            v462 = v451.LookVector * Vector3.new(1, 0, 1)
        end
        if v462.Magnitude <= 0.001 then
            v461 = Vector3.new(0, 0, -1)
        else
            v461 = v462.Unit
        end
    else
        v461 = v460.Unit
    end
    local Y = Position_2.Y
    local Y_2 = Position_3.Y
    local v463 = math.max(Y, Y_2) + MonsterParasite.ChestLaunchHeight
    local v464 = v460.Magnitude * 0.55
    local v465 = Position_2.X + v461.X * v464
    local v466 = v463 * 2 - (Position_2.Y + Position_3.Y) * 0.5
    local v467 = Position_2.Z + v461.Z * v464
    local v468 = Vector3.new(v465, v466, v467)
    local v469 = SpatialCurve(Position_2, v468, Position_3)
    local v470 = Vector3.new(0, 1, 0):Cross(v461)
    local v471
    if v470.Magnitude <= 0.001 then
        v471 = Vector3.new(1, 0, 0)
    else
        v471 = v470.Unit
    end
    local v472 = MonsterParasite.ChestLaunchSpins * 3.141592653589793 * 2
    local Rotation = v451.Rotation
    local Rotation_2 = v459.Rotation
    local v473 = OnRender(function(v474, v475) -- line 1810 | captures: v471, v452, v453, v454, v469, v472, Rotation, Rotation_2, Ease
        if v452.Parent == nil then
            return true
        end
        local v476 = Ease(v475, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v477 = CFrame.new(v469(v475)) * CFrame.fromAxisAngle(v471, v472 * v476)
        v452:PivotTo(v477 * Rotation:Lerp(Rotation_2, v476))
        v452:ScaleTo((math.lerp(v454, v453, v475)))
        return nil
    end, MonsterParasite.ChestLaunchDuration, true)
    v473:Wait()
    v473:Destroy()
    if v452.Parent == nil then
        return
    end
    v452:ScaleTo(v453)
    v452:PivotTo(v459)
    playSound(MonsterParasite.ChestLandingSoundName, v452.PrimaryPart or PrimaryPart)
    emitGroundHit(upAlignedCFrame(Position, v456))
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        local ChestImpactShakeRange = MonsterParasite.ChestImpactShakeRange
        local Magnitude = (CurrentCamera.CFrame.Position - Position).Magnitude
        if Magnitude < ChestImpactShakeRange then
            v30:ShakeOnce(MonsterParasite.ChestImpactShakeMagnitude * (1 - Magnitude / ChestImpactShakeRange), MonsterParasite.ChestImpactShakeRoughness, MonsterParasite.ChestImpactShakeFadeIn, MonsterParasite.ChestImpactShakeFadeOut)
        end
    end
    local v478 = OnRender(function(v479, v480) -- line 1838 | captures: v452, Position_3, Rotation_2, v9, MonsterParasite
        if v9 == v452 then
            local v481 = 1 - v480
            local v482 = v480 * 3.141592653589793
            local v483 = math.sin(v482) * v481 * MonsterParasite.ChestBounceHeight
            local v484 = v480 * 3.141592653589793 * 4
            local v485 = math.sin(v484) * v481 * 0.20943951023931956
            local v486 = CFrame.new(Position_3 + Vector3.new(0, 1, 0) * v483)
            v452:PivotTo(v486 * Rotation_2 * CFrame.Angles(0, 0, v485))
            return nil
        end
        return true
    end, MonsterParasite.ChestBounceDuration, true)
    v478:Wait()
    v478:Destroy()
    if v452.Parent then
        v452:PivotTo(v459)
    end
    task.wait(MonsterParasite.ChestGroundRestDuration)
end

local function autoControlPoint(v487, v488) -- line 1857 | captures: MonsterParasite
    local v489 = (v487 + v488) * 0.5
    local Y = v487.Y
    local Y_2 = v488.Y
    local v490 = math.max(Y, Y_2) + ((v487 - v488) * Vector3.new(1, 0, 1)).Magnitude * 0.5 + MonsterParasite.ChestPickupRise
    local X = v489.X
    local Z = v489.Z
    return (Vector3.new(X, v490, Z))
end

local function animateChestPickup(v491) -- line 1864 | captures: MonsterParasite, OnRender, Ease, SpatialCurve, Fade, LocalPlayer, v196
    local Character = LocalPlayer.Character
    local PrimaryPart, PrimaryPart_2
    if Character then
        local PrimaryPart_3 = Character.PrimaryPart
        PrimaryPart = PrimaryPart_3
        PrimaryPart_2 = PrimaryPart_3
    end
    if PrimaryPart_2 == nil then
        return
    end
    local v492 = v491:GetPivot()
    local Position = v492.Position
    local v493 = v491:GetScale()
    local v494 = Fade()
    local v495 = v196.PickupFadeEnd - v196.PickupFadeStart
    local v496 = math.max(v495, 0.001)
    local v497 = OnRender(function(v498, v499) -- line 1881 | captures: PrimaryPart, v491, v492, Position, v493, v494, v496, MonsterParasite, Ease, SpatialCurve, v196
        if v491.Parent == nil then
            return true
        end
        local v500 = PrimaryPart.Position + Vector3.new(0, 1, 0) * v196.PickupTargetHeight
        local v501 = (Position + v500) * 0.5
        local Y = Position.Y
        local Y_2 = v500.Y
        local v502 = math.max(Y, Y_2) + ((Position - v500) * Vector3.new(1, 0, 1)).Magnitude * 0.5
        local X = v501.X
        local v503 = v502 + MonsterParasite.ChestPickupRise
        local Z = v501.Z
        local v504 = SpatialCurve(Position, Vector3.new(X, v503, Z), v500)((Ease(v499, Enum.EasingStyle.Quad, Enum.EasingDirection.In)))
        local X_2 = v500.X
        local Y_3 = v504.Y
        local Z_2 = v500.Z
        local v505 = Vector3.new(X_2, Y_3, Z_2)
        local v506
        if (v504 - v505).Magnitude >= 0.001 then
            v506 = CFrame.lookAt(v504, v505)
        else
            v506 = CFrame.new(v504) * v492.Rotation
        end
        v491:PivotTo(v506)
        local v507 = (v499 - v196.PickupFadeStart) / v496
        local v508 = math.clamp(v507, 0, 1)
        local v509 = Ease(v508, Enum.EasingStyle.Exponential, Enum.EasingDirection.In)
        v494(v491, 1, v509)
        local PickupMinScale = v196.PickupMinScale
        local v510 = v493 * (1 - v509)
        v491:ScaleTo((math.max(PickupMinScale, v510)))
        return nil
    end, MonsterParasite.ChestPickupDuration, true)
    v497:Wait()
    v497:Destroy()
end

local function playBurpAnimation(v511, v512, v513) -- line 1911 | captures: MonsterParasite, Timer, Trove, v7, playSound, loadAnimationTrack, playAnimationAndWait
    local v514 = v511:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
    if typeof(v514) ~= "number" then
        v514 = nil
    end
    local v515
    if v514 == nil then
    else
        v515 = MonsterParasite.MonsterAnimationIdsByIndex[v514]
    end
    local v516 = if v515 then v515.Burp else nil
    local v517, v518
    if v516 then
        local v519 = loadAnimationTrack(v511, v516)
        v517 = v519
        v518 = v519
    end
    local v520 = false
    if v518 == nil then
        playSound(MonsterParasite.BurpSoundName, v512)
        v513()
        task.wait(MonsterParasite.BurpBeatDuration)
    else
        local v521 = Trove.new()
        v521:Add(v518)
        v521:Add(function() -- line 1945 | captures: v511, v7
            if v511.Parent then
                local v522 = v7[v511]
                if v522 and v511.Parent and not v522.IsPlaying then
                    v522:Play(0.1)
                end
            end
        end)
        local v523 = v518:GetMarkerReachedSignal(MonsterParasite.BurpMarkerName)
        v521:Connect(v523, function() -- line 1955 | captures: v520, v512, v513, MonsterParasite, playSound
            if v520 then
                return
            end
            v520 = true
            playSound(MonsterParasite.BurpSoundName, v512)
            v513()
        end)
        local v524 = v7[v511]
        if v524 and v524.IsPlaying then
            v524:Stop(0.1)
        end
        v518.Looped = false
        v518.Priority = Enum.AnimationPriority.Action3
        playAnimationAndWait(v518, v511, function() -- line 1969 | captures: v517, v520, v512, v513, v521, MonsterParasite, Timer, playSound
            local ChestLaunchBeatFallback = MonsterParasite.ChestLaunchBeatFallback
            if v517.Length > 0 then
                local v525 = v517.Length - 0.1
                local v526 = math.max(v525, 0.05)
                ChestLaunchBeatFallback = math.min(ChestLaunchBeatFallback, v526)
            end
            v521:Add(Timer.Simple(ChestLaunchBeatFallback, function() -- line 1975 | captures: v520, v512, v513, MonsterParasite, playSound
                if not v520 then
                    warn((("[MonsterParasite] Burp animation did not reach the %* marker"):format(MonsterParasite.BurpMarkerName)))
                    if not v520 then
                        v520 = true
                        playSound(MonsterParasite.BurpSoundName, v512)
                        v513()
                    end
                end
            end))
        end)
        if not v520 then
            playSound(MonsterParasite.BurpSoundName, v512)
            v513()
        end
        v521:Destroy()
    end
end

local function animateFullCharge(v527) -- line 1994 | captures: v10, Emit, MonsterParasite, Trove, playSound, resolveVfxTemplate, resolveChestOrigin, animateMonsterRoar, animateChestLaunch, playBurpAnimation
    local PrimaryPart = v527.PrimaryPart
    if PrimaryPart == nil then
        return false
    end
    local v528 = resolveChestOrigin(v527) or PrimaryPart
    local v529 = Trove.new()
    v10 = v527
    v529:Add(function() -- line 2002 | captures: v527, v10
        if v10 == v527 then
            v10 = nil
        end
    end)
    local v530
    local v531 = false
    playBurpAnimation(v527, v528, function() -- line 2009 | captures: v530, v531, v527, PrimaryPart, v528, v529, Emit, MonsterParasite, playSound, resolveVfxTemplate, animateMonsterRoar, animateChestLaunch
        v530 = task.spawn(function() -- line 2011 | captures: v531, v527, v528, MonsterParasite, animateChestLaunch
            if MonsterParasite.ChestLaunchDelay > 0 then
                task.wait(MonsterParasite.ChestLaunchDelay)
            end
            local v532, v533 = pcall(animateChestLaunch, v527, v528)
            v531 = true
            if not v532 then
                warn((("[MonsterParasite] Chest launch failed: %*"):format(v533)))
            end
        end)
        local v534, v535 = pcall(function() -- line 2022 | captures: v527, PrimaryPart, v528, v529, Emit, MonsterParasite, playSound, resolveVfxTemplate, animateMonsterRoar
            playSound(MonsterParasite.RoarSoundName, PrimaryPart)
            playSound(MonsterParasite.EnergyBurstSoundName, v528)
            local v536 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
            if v536 ~= nil then
                local v537 = v536:Clone()
                v537.Parent = v528
                v529:Add(v537)
                Emit(v537)
            end
            animateMonsterRoar(v527, v529)
        end)
        if not v534 then
            warn((("[MonsterParasite] Full charge dressing failed: %*"):format(v535)))
        end
    end)
    while true do
        if v530 == nil then
            break
        end
        if v531 then
            break
        end
        if coroutine.status(v530) == "dead" then
            break
        end
        task.wait()
    end
    v529:Destroy()
    return v531
end

local function getPrompt(v538) -- line 2047 | captures: v8
    local v539 = v8
    if v539 ~= nil then
        local v540 = v539:FindFirstChild(v538, true)
        if v540 and v540:IsA("ProximityPrompt") then
            return v540
        end
    end
    return nil
end

local function setPromptEnabled(v541, v542) -- line 2061
    if v541 and v541.Enabled ~= v542 then
        v541.Enabled = v542
    end
end

local function isHoldingParasiteEgg() -- line 2066 | captures: EggToolDisplay, Save, LocalPlayer
    local Character = LocalPlayer.Character
    local v543 = Save.Get()
    if Character ~= nil and v543 ~= nil then
        for v544, v545 in Character:GetChildren() do
            if v545:IsA("Tool") and EggToolDisplay.IsEggTool(v545) then
                local v546 = EggToolDisplay.GetToolUid(v545)
                local v547 = if v546 then v543.EggInventory[v546] else nil
                if v547 ~= nil and v547.HasParasite == true then
                    return true
                end
            end
        end
    end
    return false
end

local function refreshPrompts() -- line 2088 | captures: v8, v12, v17, v19, v20, v21, v22, MonsterParasite, MonsterParasite_2, isHoldingParasiteEgg
    local v548 = v8
    local v549
    if v548 == nil then
    else
        v549 = v548:FindFirstChild(MonsterParasite.TalkPromptName, true)
        if not (v549 and v549:IsA("ProximityPrompt")) then
            v549 = nil
        end
    end
    local v550 = v8
    local v551
    if v550 == nil then
    else
        v551 = v550:FindFirstChild(MonsterParasite.FeedPromptName, true)
        if not (v551 and v551:IsA("ProximityPrompt")) then
            v551 = nil
        end
    end
    local v552 = v8
    local v553
    if v552 == nil then
    else
        v553 = v552:FindFirstChild(MonsterParasite.ChestPromptName, true)
        if v553 then
            if not v553:IsA("ProximityPrompt") then
                v553 = v548
            end
        else
            v553 = nil
        end
    end
    local v554 = v8
    local v555
    if v554 == nil then
    else
        v555 = v554:FindFirstChild(MonsterParasite_2.ViewRewardsPromptName, true)
        if v555 then
            if not v555:IsA("ProximityPrompt") then
                v555 = v550
            end
        else
            v555 = nil
        end
    end
    local v556 = v20 or v17 or v19 or v21 or v22 > 0
    local v557 = v12 and not v556 and isHoldingParasiteEgg()
    local v558 = not v557 and not v556
    if v551 and v551.Enabled ~= v557 then
        v551.Enabled = v557
    end
    if v553 and v553.Enabled ~= false then
        v553.Enabled = false
    end
    if v549 and v549.Enabled ~= v558 then
        v549.Enabled = v558
    end
    local v559 = not v556
    if v555 and v555.Enabled ~= v559 then
        v555.Enabled = v559
    end
end

local function renderState() -- line 2172 | captures: v9, v11, v22, refreshPrompts
    if v11.PendingChests <= 0 and v22 <= 0 and v9 then
        v9:Destroy()
        v9 = nil
    end
    refreshPrompts()
end

local function storeState(v560) -- line 2179 | captures: v8, v11
    v11 = table.clone(v560)
    if v8 then
        v8:SetAttribute("Charge", v560.Charge)
        v8:SetAttribute("PendingChests", v560.PendingChests)
    end
end

local function applyState(v561) -- line 2186 | captures: v8, v9, v11, v20, v21, v22, v23, MonsterParasite, refreshPrompts
    local v562
    if v11.PendingChests < v561.PendingChests and v561.Charge < v11.Charge then
        local v563 = v11.Charge + MonsterParasite.ChargePerFeed
        v562 = MonsterParasite.MaxCharge <= v563
    else
        v562 = false
    end
    v11 = table.clone(v561)
    if v8 then
        v8:SetAttribute("Charge", v561.Charge)
        v8:SetAttribute("PendingChests", v561.PendingChests)
    end
    if v562 then
        v22 += 1
        v23 += 1
        refreshPrompts()
    else
        local v564
        if v20 then
            v564 = true
        elseif v22 <= 0 then
            if v21 then
                v564 = true
            else
                if v11.PendingChests <= 0 and v22 <= 0 and v9 then
                    v9:Destroy()
                    v9 = nil
                end
                v564 = false
            end
        else
            v564 = true
        end
        if not v564 then
            refreshPrompts()
        end
    end
end

local function showError(v565) -- line 2214 | captures: Message
    task.spawn(Message.Prompt, v565, { err = true })
end

local function acknowledgeChest(v566) -- line 2217 | captures: MonsterParasite_2, MonsterParasite_3
    local Message
    for v567 = 1, 3 do
        local v568, v569 = pcall(function() -- line 2224 | captures: v566, MonsterParasite_3
            return MonsterParasite_3.AskChestRevealComplete:InvokeServer(v566)
        end)
        if not (v568 and MonsterParasite_2.RevealResultSchema(v569)) then
            if v568 then
                Message = "The reward confirmation was invalid."
            else
                Message = tostring(v569)
            end
        else
            if v569.Success then
                return true, nil
            end
            Message = v569.Message
            if v567 < 3 then
                task.wait(0.4)
            end
        end
    end
    return false, Message
end

local function beginChestReveal(v570) -- line 2245 | captures: v8, v9, v11, v21, OpeningId, OpeningId_2, v22, CrateOpeningSpinner, Message, MonsterParasite, LocalPlayer, playSound, refreshPrompts, acknowledgeChest
    local OpeningId_3 = v570.OpeningId
    if OpeningId_3 == nil or v570.Reward == nil then
        v21 = false
        if v11.PendingChests <= 0 and v22 <= 0 and v9 then
            v9:Destroy()
            v9 = nil
        end
        refreshPrompts()
        task.spawn(Message.Prompt, "The Monster Chest reward was invalid.", { err = true })
    else
        local PrimaryPart, v571
        if OpeningId == OpeningId_3 or OpeningId_2 == OpeningId_3 then
            v571 = true
        elseif OpeningId == nil then
            OpeningId = OpeningId_3
            v21 = true
            refreshPrompts()
            local Character = LocalPlayer.Character
            if Character then
                PrimaryPart = Character.PrimaryPart
            end
            v571 = false
        else
            v571 = true
        end
        if v571 then
            return
        end
        local v572 = v9
        local v573 = v8
        if v572 then
            if v572.PrimaryPart then
                PrimaryPart = v572.PrimaryPart
            else
                PrimaryPart = nil
            end
        elseif not PrimaryPart then
            if v573 then
                PrimaryPart = v573.PrimaryPart
            else
                PrimaryPart = nil
            end
        end
        if PrimaryPart then
            playSound(MonsterParasite.ChestSoundName, PrimaryPart)
        end
        if v9 then
            v9:Destroy()
            v9 = nil
        end
        task.spawn(function() -- line 2290 | captures: v570, OpeningId_3, v9, v11, v21, OpeningId, OpeningId_2, v22, CrateOpeningSpinner, Message, refreshPrompts, acknowledgeChest
            local v574, v575 = pcall(CrateOpeningSpinner.Play, v570)
            if not v574 then
                warn((("[MonsterParasite] Crate opening presentation failed: %*"):format(v575)))
            end
            local v576, v577 = acknowledgeChest(OpeningId_3)
            if not v576 then
                task.spawn(Message.Prompt, v577 or "The Monster Chest reveal is still finishing.", { err = true })
            end
            OpeningId_2 = OpeningId_3
            OpeningId = nil
            v21 = false
            v11.PendingChests = v570.PendingChests or 0
            refreshPrompts()
            if v11.PendingChests <= 0 and v22 <= 0 and v9 then
                v9:Destroy()
                v9 = nil
            end
            refreshPrompts()
        end)
    end
end

local function requestFeed() -- line 2312 | captures: v12, v17, v19, v20, v21, OpeningId, v22, v25, v26, v27, v28, v29, Message, MonsterParasite_2, MonsterParasite_3, v196, captureEquippedEgg, refreshPrompts
    if v12 then
        if not v17 and not v20 and not v19 and not (v22 > 0) and not v21 and OpeningId == nil then
            v17 = true
            refreshPrompts()
            captureEquippedEgg()
            task.spawn(function() -- line 2323 | captures: v17, v25, v26, v27, v28, v29, Message, MonsterParasite_2, MonsterParasite_3, v196, refreshPrompts
                local v578, v579 = pcall(function() -- line 2325 | captures: MonsterParasite_3
                    return MonsterParasite_3.AskFeed:InvokeServer()
                end)
                if v578 then
                    if MonsterParasite_2.FeedResultSchema(v579) and not v579.Success then
                        v17 = false
                        refreshPrompts()
                        local v580 = v28
                        v28 = nil
                        if v580 ~= nil then
                            v580:Disconnect()
                        end
                        local v581 = v29
                        v29 = nil
                        if v581 ~= nil then
                            v581:Stop(v196.HandPoseReleaseSeconds)
                            task.delay(v196.HandPoseReleaseSeconds, function() -- line 2370 | captures: v581
                                v581:Destroy()
                            end)
                        end
                        if v25 ~= nil then
                            v25:Destroy()
                            v25 = nil
                        end
                        v27 = nil
                        v26 = nil
                        task.spawn(Message.Prompt, v579.Message, { err = true })
                    end
                else
                    v17 = false
                    refreshPrompts()
                    local v582 = v28
                    v28 = nil
                    if v582 ~= nil then
                        v582:Disconnect()
                    end
                    local v583 = v29
                    v29 = nil
                    if v583 ~= nil then
                        v583:Stop(v196.HandPoseReleaseSeconds)
                        task.delay(v196.HandPoseReleaseSeconds, function() -- line 2340 | captures: v583
                            v583:Destroy()
                        end)
                    end
                    if v25 ~= nil then
                        v25:Destroy()
                        v25 = nil
                    end
                    v27 = nil
                    v26 = nil
                    local v584 = tostring(v579)
                    task.spawn(Message.Prompt, v584, { err = true })
                end
            end)
        end
    else
        task.spawn(Message.Prompt, "The Monster Parasite event is not active.", { err = true })
    end
end

local function requestChest() -- line 2386 | captures: v9, v11, v17, v19, v20, v21, OpeningId, OpeningId_2, v22, HttpService, Message, MonsterParasite_2, MonsterParasite_3, refreshPrompts, beginChestReveal
    if v19 or v17 or v20 or v22 > 0 or v21 or not (OpeningId == nil) then
        return
    end
    v19 = true
    v21 = true
    refreshPrompts()
    local v585 = HttpService:GenerateGUID(false)
    task.spawn(function() -- line 2394 | captures: v585, v9, v11, v19, v21, OpeningId, OpeningId_2, v22, Message, MonsterParasite_2, MonsterParasite_3, refreshPrompts, beginChestReveal
        local v586, v587
        for v588 = 1, 3 do
            local v589, v590 = pcall(function() -- line 2401 | captures: v585, MonsterParasite_3
                return MonsterParasite_3.AskChestClaim:InvokeServer(v585)
            end)
            if not (v589 and MonsterParasite_2.ChestResultSchema(v590)) then
                if v589 then
                    v587 = "The Monster Chest could not be opened."
                else
                    v587 = tostring(v590)
                end
            else
                if v590.Success then
                    v586 = v590
                    break
                end
                if v590.Message == "Another Monster Parasite action is still finishing." then
                    if OpeningId == v585 then
                        v586 = v590
                        break
                    end
                    if OpeningId_2 == v585 then
                        v586 = v590
                        break
                    end
                    if v588 < 3 then
                        task.wait(0.4)
                    end
                    v586 = v590
                else
                    v586 = v590
                    break
                end
            end
        end
        v19 = false
        refreshPrompts()
        if OpeningId ~= v585 and OpeningId_2 ~= v585 then
            if v586 == nil then
                v21 = false
                if v11.PendingChests <= 0 and v22 <= 0 and v9 then
                    v9:Destroy()
                    v9 = nil
                end
                refreshPrompts()
                task.spawn(Message.Prompt, v587 or "The Monster Chest could not be opened.", { err = true })
            elseif v586.Success then
                beginChestReveal(v586)
            elseif OpeningId == nil then
                v21 = false
                if v11.PendingChests <= 0 and v22 <= 0 and v9 then
                    v9:Destroy()
                    v9 = nil
                end
                refreshPrompts()
                task.spawn(Message.Prompt, v586.Message, { err = true })
            end
        end
    end)
end

local function requestTakeChest() -- line 2451 | captures: v9, Message, MonsterParasite_2, MonsterParasite_3
    local v591, v592 = pcall(function() -- line 2453 | captures: MonsterParasite_3
        return MonsterParasite_3.AskChestTake:InvokeServer()
    end)
    if not (v591 and MonsterParasite_2.TakeResultSchema(v592)) then
        local v593
        if v591 then
            v593 = "The Monster Chest could not be picked up."
        else
            v593 = tostring(v592)
        end
        task.spawn(Message.Prompt, v593, { err = true })
    elseif v592.Success then
        if v9 then
            v9:Destroy()
            v9 = nil
        end
    else
        task.spawn(Message.Prompt, v592.Message, { err = true })
    end
end

local function deliverChestTool() -- line 2475 | captures: v9, animateChestPickup, requestTakeChest
    local v594 = v9
    if v594 and v594.Parent then
        animateChestPickup(v594)
    end
    requestTakeChest()
end

local function isChestTool(v595) -- line 2482 | captures: MonsterParasite
    return v595:GetAttribute("ItemType") == MonsterParasite.ChestToolItemType
end

local function bindChestTool(v596) -- line 2487 | captures: v3, requestChest
    v3:Connect(v596.Activated, requestChest)
end

local v597 = {
    Accessor = "MonsterChestRewards",
    PlateDim = 0.36,
    PanelAspect = 1.18,
    MaxRowAspect = 6,
    MinRowHeight = 30,
    RowGapFraction = 0.09,
    PadXFraction = 0.012,
    PadYFraction = 0.012,
    RowPadFraction = 0.11,
    SlotGapFraction = 0.3,
    PillHeightFraction = 0.52,
    PillPadFraction = 0.34,
    GlowScale = 1.15,
    IconScale = 0.76,
    NameTextCap = 0.44,
    ChanceTextCap = 0.34,
    NoteTextCap = 0.28,
    PillCharWidth = 0.62,
    NoteCharWidth = 0.62,
    FlowSeconds = 6,
    RainbowHueSpan = 0.3
}
local v598 = {}

v598["BEST REWARD"] = "Prismatic"
v597.RarityGradients = v598
v597.ScrollerSize = Vector2.new(0.972, 0.862)
v597.ScrollerCenter = Vector2.new(0.5, 0.5465)
v597.Cards = {}
v597.Flowing = {}

local function dimColor(v599, v600) -- line 2520
    return Color3.new(v599.R * v600, v599.G * v600, v599.B * v600)
end

local function sampleStops(v601, v602) -- line 2523
    local v603 = #v601 - 1
    for v604 = 1, v603 do
        local v605 = v601[v604]
        local v606 = v601[v604 + 1]
        if v605.Time <= v602 and v602 <= v606.Time then
            local v607 = v606.Time - v605.Time
            local v608 = if v607 > 0 then (v602 - v605.Time) / v607 else 0
            return v605.Value:Lerp(v606.Value, v608)
        end
    end
    return v601[#v601].Value
end

local function rolledPalette(v609, v610) -- line 2543 | captures: sampleStops
    local function v611(v612, ...)
        table.insert(v612, ...)
    end

    local function v613(v614, ...)
        table.insert(v614, ...)
    end

    local v615 = sampleStops(v609, -v610 % 1)
    local v616 = { ColorSequenceKeypoint.new(0, v615) }
    local v617 = #v609 - 1
    for v618 = 1, v617 do
        local v619 = (v609[v618].Time + v610) % 1
        if v619 > 0 and v619 < 1 then
            v611(v616, ColorSequenceKeypoint.new(v619, v609[v618].Value))
        end
    end
    table.sort(v616, function(v620, v621) -- line 2556
        return v620.Time < v621.Time
    end)
    v613(v616, ColorSequenceKeypoint.new(1, v615))
    return ColorSequence.new(v616)
end

local function isRainbow(v622) -- line 2563 | captures: v597
    local Keypoints = v622.Color.Keypoints
    local Value = Keypoints[1].Value
    local Value_2 = Keypoints[#Keypoints].Value
    local v623 = Value.R - Value_2.R
    local v624 = math.abs(v623)
    local v625 = Value.G - Value_2.G
    local v626 = v624 + math.abs(v625)
    local v627 = Value.B - Value_2.B
    if v626 + math.abs(v627) > 0.02 then
        return false
    end
    local v628 = 0
    local v629 = 1
    for v630, v631 in Keypoints do
        local v632 = Color3.toHSV(v631.Value)
        v629 = math.min(v629, v632)
        v628 = math.max(v628, v632)
    end
    return v597.RainbowHueSpan <= v628 - v629
end

local function paintRewardCard(v633, v634) -- line 2587 | captures: v597, dimColor, isRainbow
    local Keypoints = v634.Color.Keypoints
    local v635 = table.create(#Keypoints)
    for v636, v637 in Keypoints do
        v635[v636] = ColorSequenceKeypoint.new(v637.Time, dimColor(v637.Value, v597.PlateDim))
    end
    local UIGradient = v633:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        UIGradient.Color = ColorSequence.new(v635)
        if isRainbow(v634) then
            UIGradient.Rotation = 0
        else
            UIGradient.Rotation = 90
        end
    end
    local Value = Keypoints[1].Value
    v633.UIStrokeClr.Color = Value
    v633.Glow.ImageColor3 = Value
    if not (UIGradient ~= nil and isRainbow(v634)) then
        return
    end
    local Flowing = v597.Flowing
    local v638 = {
        Plate = UIGradient,
        Rim = v633.UIStrokeClr,
        Glow = v633.Glow,
        Dimmed = v635,
        Bright = Keypoints
    }
    table.insert(Flowing, v638)
end

local function startRewardFlow(v639) -- line 2619 | captures: RunService, v597, sampleStops, rolledPalette
    if v597.Motion ~= nil then
        v597.Motion:Disconnect()
        v597.Motion = nil
    end
    if #v597.Flowing ~= 0 then
        local RenderStepped = RunService.RenderStepped
        v597.Motion = RenderStepped:Connect(function() -- line 2627 | captures: v639, v597, sampleStops, rolledPalette
            if v639.Enabled then
                local v640 = os.clock() % v597.FlowSeconds / v597.FlowSeconds
                for v641, v642 in v597.Flowing do
                    v642.Plate.Color = rolledPalette(v642.Dimmed, v640)
                    local v643 = sampleStops(v642.Bright, -v640 % 1)
                    v642.Rim.Color = v643
                    v642.Glow.ImageColor3 = v643
                end
            elseif v597.Motion ~= nil then
                v597.Motion:Disconnect()
                v597.Motion = nil
            end
        end)
    end
end

local function buildRewardRow(v644) -- line 2649
    local Frame = Instance.new("Frame")
    Frame.Name = "Slot"
    Frame.AnchorPoint = Vector2.new(0, 0.5)
    Frame.BackgroundColor3 = Color3.new(0, 0, 0)
    Frame.BackgroundTransparency = 0.55
    Frame.ZIndex = 2
    Frame.Parent = v644
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.16, 0)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromHex("#131624")
    UIStroke.Thickness = 2
    UIStroke.Parent = Frame
    v644.Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    v644.Glow.Position = UDim2.fromScale(0.5, 0.5)
    v644.Glow.ZIndex = 3
    v644.Glow.Parent = Frame
    v644.Icon.AnchorPoint = Vector2.new(0.5, 0.5)
    v644.Icon.Position = UDim2.fromScale(0.5, 0.5)
    v644.Icon.ZIndex = 4
    v644.Icon.Parent = Frame
    v644.RewardName.AnchorPoint = Vector2.new(0, 0.5)
    v644.RewardName.TextXAlignment = Enum.TextXAlignment.Left
    v644.Note.AnchorPoint = Vector2.new(0, 0.5)
    v644.Note.TextXAlignment = Enum.TextXAlignment.Left
    v644.Chance.AnchorPoint = Vector2.new(0, 0.5)
    local UICorner_2 = v644.Chance:FindFirstChildOfClass("UICorner")
    if UICorner_2 == nil then
        UICorner_2 = Instance.new("UICorner")
        UICorner_2.Parent = v644.Chance
    end
    UICorner_2.CornerRadius = UDim.new(0.5, 0)
    v644.Chance.BackgroundColor3 = Color3.fromHex("#1B1B24")
    v644.Chance.BackgroundTransparency = 0
    v644.Chance.ZIndex = 2
    local UIStroke_2 = v644.Chance:FindFirstChildOfClass("UIStroke")
    if UIStroke_2 == nil then
        UIStroke_2 = Instance.new("UIStroke")
        UIStroke_2.Parent = v644.Chance
    end
    UIStroke_2.Color = Color3.fromHex("#131624")
    UIStroke_2.Thickness = 2
    v644.Chance.Value.TextColor3 = Color3.new(1, 1, 1)
    v644.Chance.Value.ZIndex = 3
end

local function layoutRewardCards(v645) -- line 2696 | captures: v597
    local AbsoluteSize = v645.AbsoluteSize
    local v646 = #v597.Cards
    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 or v646 == 0 then
        return
    end
    local v647 = AbsoluteSize.X * v597.PadXFraction
    local v648 = math.round(v647)
    local v649 = AbsoluteSize.Y * v597.PadYFraction
    local v650 = math.round(v649)
    local v651 = AbsoluteSize.X - v648 * 2
    local v652 = AbsoluteSize.Y - v650 * 2
    local v653 = v652 / (v646 + (v646 - 1) * v597.RowGapFraction)
    local MinRowHeight = v597.MinRowHeight
    local v654 = v651 / v597.MaxRowAspect
    local v655 = math.clamp(v653, MinRowHeight, v654)
    local v656 = math.floor(v655)
    local v657 = v656 * v597.RowGapFraction
    local v658 = math.round(v657)
    local v659 = v656 * v646 + v658 * (v646 - 1)
    local v660 = v652 < v659
    v645.ScrollingEnabled = v660
    v645.AutomaticCanvasSize = Enum.AutomaticSize.None
    if v660 then
        v645.CanvasSize = UDim2.fromOffset(0, v659 + v650 * 2)
    else
        v645.CanvasSize = UDim2.new()
        v650 += (v652 - v659) / 2
    end
    local v661 = v656 * v597.NameTextCap
    local v662 = math.round(v661)
    local v663 = math.max(1, v662)
    local v664 = v656 * v597.ChanceTextCap
    local v665 = math.round(v664)
    local v666 = math.max(1, v665)
    local v667 = v656 * v597.NoteTextCap
    local v668 = math.round(v667)
    local v669 = math.max(1, v668)
    local TextSize = v645.Template.Note.TextSize
    local v670 = v656 * v597.RowPadFraction
    local v671 = math.round(v670)
    local v672 = v656 - v671 * 2
    local v673 = v672 * v597.GlowScale
    local v674 = math.round(v673)
    local v675 = v672 * v597.IconScale
    local v676 = math.round(v675)
    local v677 = v656 * v597.PillHeightFraction
    local v678 = math.round(v677)
    local v679 = v656 * v597.PillPadFraction
    local v680 = math.round(v679)
    for v681, v682 in v597.Cards do
        v682.AnchorPoint = Vector2.new(0, 0)
        v682.Size = UDim2.fromOffset(v651, v656)
        v682.Position = UDim2.fromOffset(v648, v650 + (v681 - 1) * (v656 + v658))
        local Slot = v682.Slot
        Slot.Size = UDim2.fromOffset(v672, v672)
        Slot.Position = UDim2.fromOffset(v671, v656 / 2)
        Slot.Glow.Size = UDim2.fromOffset(v674, v674)
        Slot.Icon.Size = UDim2.fromOffset(v676, v676)
        local v683 = #v682.Chance.Value.Text * v666 * v597.PillCharWidth + v680 * 2
        local v684 = math.round(v683)
        v682.Chance.Size = UDim2.fromOffset(v684, v678)
        local v685 = v651 - v671 - v684
        v682.Chance.Position = UDim2.fromOffset(v685, v656 / 2)
        local v686 = v671 + v672
        local v687 = v656 * v597.SlotGapFraction
        local v688 = v686 + math.round(v687)
        local v689 = v651 - v671 * 2 - v684 - v688
        if v682.Note.Visible then
            local RewardName = v682.RewardName
            local fromOffset = UDim2.fromOffset
            local v690 = v656 * 0.42
            RewardName.Size = fromOffset(v689, (math.round(v690)))
            local RewardName_2 = v682.RewardName
            local fromOffset_2 = UDim2.fromOffset
            local v691 = v656 * 0.36
            RewardName_2.Position = fromOffset_2(v688, (math.round(v691)))
            local Note = v682.Note
            local fromOffset_3 = UDim2.fromOffset
            local v692 = v656 * 0.26
            Note.Size = fromOffset_3(v689, (math.round(v692)))
            local Note_2 = v682.Note
            local fromOffset_4 = UDim2.fromOffset
            local v693 = v656 * 0.71
            Note_2.Position = fromOffset_4(v688, (math.round(v693)))
            local v694 = #v682.Note.Text * TextSize * v597.NoteCharWidth
            local v695
            if v694 <= v689 then
                v695 = TextSize
            else
                local v696 = TextSize * v689 / v694
                local v697 = math.floor(v696)
                v695 = math.max(1, v697)
            end
            v682.Note.TextSize = v695
        else
            local RewardName = v682.RewardName
            local fromOffset = UDim2.fromOffset
            local v698 = v656 * 0.56
            RewardName.Size = fromOffset(v689, (math.round(v698)))
            v682.RewardName.Position = UDim2.fromOffset(v688, v656 / 2)
        end
        v682.RewardName.UITextSizeConstraint.MaxTextSize = v663
        v682.Chance.Value.UITextSizeConstraint.MaxTextSize = v666
        v682.Note.UITextSizeConstraint.MaxTextSize = v669
    end
end

local function renderRewardsPanel() -- line 2773 | captures: GUI, MonsterParasite, Rarities, v597, paintRewardCard, startRewardFlow, buildRewardRow, layoutRewardCards
    local v699 = GUI.Get(v597.Accessor)
    local ScrollingFrame = v699.Frame.ScrollingFrame
    local UIGridLayout = ScrollingFrame:FindFirstChildOfClass("UIGridLayout")
    if UIGridLayout ~= nil then
        UIGridLayout:Destroy()
    end
    local UIAspectRatioConstraint = v699.Frame:FindFirstChildOfClass("UIAspectRatioConstraint")
    if UIAspectRatioConstraint ~= nil then
        UIAspectRatioConstraint.AspectRatio = v597.PanelAspect
    end
    ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ScrollingFrame.Size = UDim2.fromScale(v597.ScrollerSize.X, v597.ScrollerSize.Y)
    ScrollingFrame.Position = UDim2.fromScale(v597.ScrollerCenter.X, v597.ScrollerCenter.Y)
    local Template = ScrollingFrame.Template
    for v700, v701 in ScrollingFrame:GetChildren() do
        if v701:IsA("GuiObject") and v701 ~= Template then
            v701:Destroy()
        end
    end
    table.clear(v597.Cards)
    table.clear(v597.Flowing)
    local v702 = 0
    for v703, v704 in MonsterParasite.Rewards do
        v702 += MonsterParasite.GetRewardWeight(v704.Id)
    end
    for v705, v706 in MonsterParasite.Rewards do
        local v707 = Template:Clone()
        v707.Name = ("Reward_%*"):format(v706.Id)
        v707.LayoutOrder = v705
        v707.Visible = true
        v707.RewardName.Text = string.upper(v706.DisplayName)
        local v708 = v706.Icon or Template:GetAttribute("FallbackIcon")
        v707.Icon.Image = v708
        local DisplayNote = v706.DisplayNote
        local v709 = DisplayNote ~= nil
        v707.Note.Visible = v709
        if DisplayNote ~= nil then
            v707.Note.Text = string.upper(DisplayNote)
        end
        local v710 = MonsterParasite.GetRewardWeight(v706.Id) / v702 * 100 * 10 + 0.5
        local v711 = math.floor(v710) / 10
        v707.Chance.Value.Text = ("%*%%"):format(v711)
        local v712 = v597.RarityGradients[v706.Rarity] or v706.Rarity
        local v713 = Rarities[v712]
        if v713 ~= nil and v713.RarityGradient ~= nil then
            paintRewardCard(v707, v713.RarityGradient)
        end
        buildRewardRow(v707)
        local Cards = v597.Cards
        table.insert(Cards, v707)
        v707.Parent = ScrollingFrame
    end
    if v597.Sizing ~= nil then
        v597.Sizing:Disconnect()
    end
    local AbsoluteSize = ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize")
    v597.Sizing = AbsoluteSize:Connect(function() -- line 2841 | captures: ScrollingFrame, layoutRewardCards
        layoutRewardCards(ScrollingFrame)
    end)
    layoutRewardCards(ScrollingFrame)
    startRewardFlow(v699)
end

local v714 = {}

local function hideTutorial() -- line 2848 | captures: v714
    local Gui = v714.Gui
    if Gui ~= nil and Gui.Enabled then
        Gui.Enabled = false
        local Release = v714.Release
        v714.Release = nil
        if Release ~= nil then
            Release()
        end
    end
end

local function showTutorial() -- line 2860 | captures: ButtonFX, GUI, HiddenUIHandler, v714, hideTutorial
    local Gui = v714.Gui
    if Gui == nil then
        Gui = GUI.MonsterEventTutorialFrame()
        local MonsterEventTutorialFrame = Gui.MonsterEventTutorialFrame
        local Frame = MonsterEventTutorialFrame:IsA("Frame")
        assert(Frame, "MonsterEventTutorialFrame.MonsterEventTutorialFrame must be a Frame")
        local Ok = MonsterEventTutorialFrame.Ok
        local ImageButton = Ok:IsA("ImageButton")
        assert(ImageButton, "MonsterEventTutorialFrame.Ok must be an ImageButton")
        GUI.ButtonActivated(Ok, hideTutorial)
        ButtonFX(Ok)
        v714.Gui = Gui
    end
    if not Gui.Enabled then
        v714.Release = HiddenUIHandler.Acquire()
        Gui.Enabled = true
    end
end

local function bindPrompt(v715, v716) -- line 2880 | captures: MonsterParasite, MonsterParasite_2, Tabs, refreshPrompts, requestFeed, v597, renderRewardsPanel, showTutorial
    if v716.Name == MonsterParasite.TalkPromptName then
        v715:Connect(v716.Triggered, showTutorial)
    elseif v716.Name == MonsterParasite.FeedPromptName then
        v715:Connect(v716.Triggered, requestFeed)
    elseif v716.Name == MonsterParasite_2.ViewRewardsPromptName then
        v715:Connect(v716.Triggered, function() -- line 2886 | captures: Tabs, v597, renderRewardsPanel
            renderRewardsPanel()
            Tabs.Toggle(v597.Accessor)
        end)
    end
    refreshPrompts()
end

local function hideModel(v717) -- line 2893
    for v718, v719 in v717:GetDescendants() do
        if v719:IsA("BasePart") then
            v719.LocalTransparencyModifier = 1
        end
    end
end

local v720 = {
    CleanupSeconds = 2,
    ParticleScale = 2.6,
    EmitScale = 2.25,
    SuppressSeconds = 1
}
local v721 = {
    ReferenceDiameter = 8.4,
    MinScale = 0.7,
    MaxScale = 2.2
}
local v722 = (-1/0)

local function scaleNumberSequence(v723, v724) -- line 2903
    local v725 = table.create(#v723.Keypoints)
    for v726, v727 in v723.Keypoints do
        v725[v726] = NumberSequenceKeypoint.new(v727.Time, v727.Value * v724, v727.Envelope * v724)
    end
    return NumberSequence.new(v725)
end

local function isSwapVeilActive() -- line 2913 | captures: v722
    return os.clock() - v722 < 1
end

local function playSwapVeil(v728) -- line 2918 | captures: v722, Debris, Workspace, Emit, MonsterParasite, resolveVfxTemplate, scaleNumberSequence
    if v728 == nil or v728.Parent == nil then
        return
    end
    local v729, v730 = v728:GetBoundingBox()
    local Part = Instance.new("Part")
    Part.Name = "MonsterSwapVeil"
    Part.Size = Vector3.new(1, 1, 1)
    Part.CFrame = CFrame.new(v729.Position)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Transparency = 1
    local __DEBRIS = Workspace:FindFirstChild("__DEBRIS")
    if __DEBRIS then
        if not __DEBRIS:IsA("Folder") then
            __DEBRIS = nil
        end
    else
        __DEBRIS = Workspace
    end
    Part.Parent = __DEBRIS
    Debris:AddItem(Part, 2)
    v722 = os.clock()
    local v731 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
    if v731 ~= nil then
        local v732 = v731:Clone()
        for v733, v734 in v732:GetDescendants() do
            if v734:IsA("ParticleEmitter") then
                v734.Size = scaleNumberSequence(v734.Size, 2.6)
                v734.Speed = NumberRange.new(v734.Speed.Min * 2.6, v734.Speed.Max * 2.6)
                local EmitCount = v734:GetAttribute("EmitCount")
                if type(EmitCount) == "number" then
                    local v735 = EmitCount * 2.25
                    v734:SetAttribute("EmitCount", (math.ceil(v735)))
                end
            end
        end
        v732.CFrame = CFrame.identity
        v732.Parent = Part
        Emit(v732)
    end
    local v736 = resolveVfxTemplate(MonsterParasite.SwapPoofVfxName)
    if v736 == nil then
        return
    end
    local v737 = v736:Clone()
    local X = v730.X
    local Y = v730.Y
    local Z = v730.Z
    local v738 = math.max(X, Y, Z) / 8.4
    local v739 = math.clamp(v738, 0.7, 2.2)
    for v740, v741 in v737:GetDescendants() do
        if v741:IsA("ParticleEmitter") then
            v741.Size = scaleNumberSequence(v741.Size, v739)
            v741.Speed = NumberRange.new(v741.Speed.Min * v739, v741.Speed.Max * v739)
            v741.Acceleration *= v739
            v741.ZOffset *= v739
        end
    end
    v737.CFrame = CFrame.identity
    v737.Parent = Part
    Emit(v737)
end

local function isRetiring(v742) -- line 2979 | captures: MonsterParasite
    return v742:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true
end

local v743 = {
    FadeSeconds = 0.35,
    Alpha = 1,
    Lit = false,
    Path = {
        "Stands",
        "Pads",
        MonsterParasite.PadName
    }
}
local v744 = Workspace
for v745, v746 in v743.Path do
    if v744 ~= nil then
        v744 = v744:FindFirstChild(v746)
    end
end

if v744 ~= nil then
    local v747 = Fade()
    v747(v744, 1, 1)
    v743.Instance = v744
    v743.Dim = v747
end

local function refreshPad() -- line 3006 | captures: v8, MonsterParasite, OnRender, Ease, v743
    local Instance = v743.Instance
    local Dim = v743.Dim
    if Instance == nil or Dim == nil then
        return
    end
    local v748 = v8
    local v749 = if v748 == nil or v748.Parent == nil then false else v748:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) ~= true
    if v749 == v743.Lit then
        return
    end
    v743.Lit = v749
    local Step = v743.Step
    if Step ~= nil then
        Step:Cancel()
        v743.Step = nil
    end
    local Alpha = v743.Alpha
    local v750 = if v749 then 0 else 1
    local v751 = OnRender(function(v752, v753) -- line 3038 | captures: v750, Instance, Dim, Alpha, Ease, v743
        local v754 = Ease(v753, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v743.Alpha = Alpha + (v750 - Alpha) * v754
        Dim(Instance, 1, v743.Alpha)
        return nil
    end, v743.FadeSeconds, true)
    v743.Step = v751:OnComplete(function() -- line 3044 | captures: v750, Instance, Dim, v743
        v743.Alpha = v750
        Dim(Instance, 1, v750)
        v743.Step = nil
    end)
end

local v755 = {
    Pointer = nil,
    Zone = nil,
    Step = nil,
    Dim = nil,
    Surface = nil,
    Origin = nil,
    Alpha = 1,
    Fading = false,
    Shown = false,
    Retired = false,
    PollSeconds = 0.2,
    FadeSeconds = 0.35,
    Arrow = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D),
    Zones = require(ReplicatedStorage.Client.WorldFX.Pads),
    Config = {
        ProximityThreshold = 5,
        Radius = 5,
        Amplitude = 2,
        Color = MonsterParasite.ParasiteHighlightColor
    }
}

function v755.Finished() -- line 3067 | captures: v11, Save, v755
    if v755.Retired then
        return true
    end
    local v756 = Save.Get()
    local MonsterParasite
    if v756 == nil then
    else
        MonsterParasite = v756.MonsterParasite
    end
    local v757 = if MonsterParasite == nil then 0 else MonsterParasite.TotalFeeds
    if v757 > 0 or v11.TotalFeeds > 0 then
        v755.Retired = true
    end
    return v755.Retired
end

function v755.Root() -- line 3090 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    local v758
    if Character == nil then
    else
        v758 = Character:FindFirstChild("HumanoidRootPart")
    end
    if v758 ~= nil and v758:IsA("BasePart") then
        return v758
    end
    return nil
end

function v755.Wanted() -- line 3106 | captures: v20, isHoldingParasiteEgg, v743, v755
    return v743.Lit and not v755.Shown and not v755.Finished() and not v20 and isHoldingParasiteEgg()
end

function v755.Ease(v759, v760) -- line 3122 | captures: OnRender, Ease, v755
    local Pointer = v755.Pointer
    local Dim = v755.Dim
    if Pointer == nil or Dim == nil then
        return
    end
    local Step = v755.Step
    if Step ~= nil then
        Step:Cancel()
        v755.Step = nil
    end
    local model = Pointer.model
    local Alpha = v755.Alpha
    local v761 = OnRender(function(v762, v763) -- line 3135 | captures: v759, Dim, model, Alpha, Ease, v755
        local v764 = Ease(v763, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v755.Alpha = Alpha + (v759 - Alpha) * v764
        Dim(model, 1, v755.Alpha)
        return nil
    end, v755.FadeSeconds, true)
    v755.Step = v761:OnComplete(function() -- line 3141 | captures: v759, v760, Dim, model, v755
        v755.Alpha = v759
        Dim(model, 1, v759)
        v755.Step = nil
        if v760 ~= nil then
            v760()
        end
    end)
end

function v755.Raise(v765, v766) -- line 3150 | captures: Fade, v755
    local v767 = v755.Arrow.new(v765, v766, v755.Config)
    v755.Pointer = v767
    v755.Origin = v766
    v755.Dim = Fade()
    v755.Alpha = 1
    v755.Dim(v767.model, 1, 1)
    v767:Start()
    v755.Ease(0)
end

function v755.Drop() -- line 3160 | captures: v755
    local Pointer = v755.Pointer
    if Pointer == nil or v755.Fading then
        return
    end
    v755.Fading = true
    v755.Ease(1, function() -- line 3166 | captures: Pointer, v755
        Pointer:Destroy()
        if v755.Pointer == Pointer then
            v755.Pointer = nil
            v755.Origin = nil
            v755.Dim = nil
        end
        v755.Fading = false
    end)
end

function v755.Refresh() -- line 3176 | captures: v755
    if v755.Fading then
        return
    end
    local v768 = v755.Root()
    local Surface = v755.Surface
    if Surface ~= nil and v768 ~= nil and v755.Wanted() then
        if v755.Pointer == nil then
            v755.Raise(Surface, v768)
        elseif v755.Origin ~= v768 then
            local Pointer = v755.Pointer
            Pointer:PointFrom(v768)
            v755.Origin = v768
            Pointer:Start()
        end
    else
        v755.Drop()
    end
end

function v755.Enter() -- line 3198 | captures: showTutorial, v755
    if not v755.Wanted() then
        return
    end
    v755.Shown = true
    showTutorial()
    v755.Drop()
end

task.spawn(function() -- line 3206 | captures: v2, v743, v755
    local Instance = v743.Instance
    if Instance ~= nil and Instance:IsA("BasePart") then
        v755.Surface = Instance
        v755.Zone = v755.Zones.new(Instance)
        v2:Add(v755.Zone)
        v2:Add(v755.Zone:ObserveEnter(v755.Enter))
    end
    while true do
        local v769
        if task.wait(v755.PollSeconds) then
            v755.Refresh()
            if v755.Finished() and v755.Pointer == nil then
                v769 = not v755.Fading
            else
                v769 = false
            end
        else
            v769 = true
        end
        if v769 then
            break
        end
    end
end)

local function bindModel(v770) -- line 3221 | captures: v8, v9, v10, v11, v20, v367, v722, Emit, MonsterParasite, Trove, LocalPlayer, v4, resolveVfxTemplate, startIdle, v366, applyState, bindPrompt, hideModel, refreshPad
    if not (v4[v770] or v770:GetAttribute("OwnerUserId") == nil) then
        if v770:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
            if v770:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true then
                hideModel(v770)
            else
                local v771 = Trove.new()
                local v772 = v8
                v4[v770] = v771
                v8 = v770
                if v772 ~= nil and v772 ~= v770 and v772.Parent ~= nil and v10 ~= v772 then
                    hideModel(v772)
                end
                local v773 = v770:GetAttributeChangedSignal(MonsterParasite.MonsterRetiringAttributeName)
                v771:Connect(v773, function() -- line 3244 | captures: v770, v10, MonsterParasite, hideModel, refreshPad
                    if v770:GetAttribute(MonsterParasite.MonsterRetiringAttributeName) == true then
                        task.defer(refreshPad)
                        if v10 == v770 then
                            task.spawn(function() -- line 3254 | captures: v770, v10, hideModel
                                while v10 == v770 do
                                    if v770.Parent == nil then
                                        break
                                    end
                                    task.wait()
                                end
                                if v770.Parent ~= nil then
                                    hideModel(v770)
                                end
                            end)
                        else
                            hideModel(v770)
                        end
                    end
                end)
                local PrimaryPart = v770.PrimaryPart
                local PrimaryPart_2, v774, v775
                if PrimaryPart == nil then
                    v775 = true
                else
                    v366[v770] = PrimaryPart.CFrame
                    local v776 = v367
                    if math.abs(v776) > 0.001 then
                        PrimaryPart_2 = v770.PrimaryPart
                        v774 = v366[v770]
                        if v774 == nil then
                            local PrimaryPart = v770.PrimaryPart
                            if PrimaryPart == nil then
                                v774 = nil
                            else
                                v366[v770] = PrimaryPart.CFrame
                                v774 = PrimaryPart.CFrame
                            end
                        end
                        v775 = false
                    else
                        v775 = true
                    end
                end
                if not v775 and PrimaryPart_2 ~= nil and v774 ~= nil then
                    PrimaryPart_2.CFrame = v774 * CFrame.fromEulerAnglesYXZ(0, v367, 0)
                end
                startIdle(v770, v771)
                local v777, v778
                if v20 then
                    if v770.PrimaryPart == nil then
                        v778 = true
                    else
                        v777 = os.clock() - v722 < 1
                        v778 = false
                    end
                else
                    v778 = true
                end
                if not v778 and not v777 then
                    local PrimaryPart = v770.PrimaryPart
                    local v779 = resolveVfxTemplate(MonsterParasite.EnergyBurstVfxName)
                    if v779 ~= nil then
                        local v780 = v779:Clone()
                        v780.Parent = PrimaryPart
                        v771:Add(v780)
                        Emit(v780)
                    end
                end
                local Destroying = v770.Destroying
                v771:Connect(Destroying, function() -- line 3305 | captures: v770, v771, v8, v9, v4, v366, refreshPad
                    v4[v770] = nil
                    v366[v770] = nil
                    if v8 == v770 then
                        v8 = nil
                        if v9 then
                            v9:Destroy()
                            v9 = nil
                        end
                        task.defer(refreshPad)
                    end
                    v771:Destroy()
                end)
                for v781, v782 in v770:GetDescendants() do
                    if v782:IsA("ProximityPrompt") then
                        bindPrompt(v771, v782)
                    end
                end
                local DescendantAdded = v770.DescendantAdded
                v771:Connect(DescendantAdded, function(v783) -- line 3323 | captures: v771, bindPrompt
                    if v783:IsA("ProximityPrompt") then
                        bindPrompt(v771, v783)
                    end
                end)
                applyState(v11)
                refreshPad()
            end
        else
            v770:Destroy()
        end
    end
end

local function inspectInstance(v784) -- line 3331 | captures: bindModel
    if v784:IsA("Model") then
        bindModel(v784)
    end
end

local function v13() -- line 3336 | captures: MonsterParasite_2, LocalPlayer
    LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, os.clock())
end

local function v14(v785) -- line 3339 | captures: MonsterParasite_3, playSwapVeil
    playSwapVeil(v785)
    MonsterParasite_3.AskFullChargeReset:FireServer()
end

local function v15(v786) -- line 3348
    local v787 = v786.PreviousCharge or 0
    return not not (v786.Charge or v787 > 0)
end

local function v16(v788) -- line 3358 | captures: MonsterParasite
    local v789 = MonsterParasite.GetMonsterModelIndex(v788.PreviousCharge or 0)
    return MonsterParasite.GetMonsterModelIndex(v788.Charge or 0) ~= v789
end

local function waitForThread(v790) -- line 3368
    while v790 ~= nil do
        if coroutine.status(v790) == "dead" then
            break
        end
        task.wait()
    end
end

local function getFeedMonster() -- line 3376 | captures: v8
    local v791 = os.clock() + 2
    while true do
        local v792 = v8
        if v792 == nil then
            task.wait()
            if v791 <= os.clock() then
                break
            end
            continue
        end
        if v792.PrimaryPart == nil then
            continue
        end
        return v792
    end
    return v8
end

local function playFeedSequence(v793) -- line 3391 | captures: v9, v26, v27, v28, v29, MonsterParasite, MonsterParasite_2, MonsterParasite_3, LocalPlayer, playSound, v196, pulseMonsterScale, releaseMonsterFacing, playYankAnimation, animateChestPickup, animateFullCharge, requestTakeChest, playSwapVeil, waitForThread, getFeedMonster
    local v794 = getFeedMonster()
    local v795 = if v794 then v794.PrimaryPart else nil
    if v794 == nil then
        local v796 = v28
        v28 = nil
        if v796 ~= nil then
            v796:Disconnect()
        end
        local v797 = v29
        local v798 = v797
        v29 = nil
        if v797 ~= nil then
            v797:Stop(v196.HandPoseReleaseSeconds)
            task.delay(v196.HandPoseReleaseSeconds, function() -- line 3409 | captures: v798
                v798:Destroy()
            end)
        end
        if v798 ~= nil then
            v798:Destroy()
            v798 = nil
        end
        v27 = nil
        v26 = nil
        LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, os.clock())
        MonsterParasite_3.AskGrowthSwap:FireServer()
        local v799 = v793.PreviousCharge or 0
        if v793.Charge or v799 > 0 then
            MonsterParasite_3.AskFullChargeReset:FireServer()
            local v800 = v9
            if v800 and v800.Parent then
                animateChestPickup(v800)
            end
            requestTakeChest()
        end
    else
        if v795 == nil then
            return
        end
        playYankAnimation(v794)
        local v801 = v794:FindFirstChild(MonsterParasite.ParasiteEatTargetPartName, true) or v794:FindFirstChild(MonsterParasite.TongueTipName, true) or v795
        playSound(MonsterParasite.ChompSoundName, v801)
        LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, os.clock())
        task.wait(v196.ScaleTweenDelaySeconds)
        local v802
        if v794.Parent then
            v802 = task.spawn(pulseMonsterScale, v794)
            task.wait(0.12)
        end
        local v803 = MonsterParasite.GetMonsterModelIndex(v793.PreviousCharge or 0)
        if MonsterParasite.GetMonsterModelIndex(v793.Charge or 0) ~= v803 then
            local v804 = v793.PreviousCharge or 0
            if not (v793.Charge or v804 > 0) then
                playSwapVeil(v794)
            end
        end
        MonsterParasite_3.AskGrowthSwap:FireServer()
        local v805 = v793.PreviousCharge or 0
        if v793.Charge or v805 > 0 then
            task.spawn(releaseMonsterFacing)
            task.wait(MonsterParasite.FullChargeHoldDuration)
            local v806
            if v794.Parent == nil then
                v806 = getFeedMonster()
            else
                v806 = v794
            end
            if v806 ~= nil and v806.Parent ~= nil then
                v806:SetAttribute(MonsterParasite_2.ChargeDrainAttributeName, os.clock())
                task.wait(MonsterParasite_2.ChargeDrainDuration)
                local v807
                if v806.Parent == nil then
                    v807 = getFeedMonster()
                else
                    v807 = v806
                end
                if v807 == nil or v807.Parent == nil then
                    warn("[MonsterParasite] Full charge lost its monster during the drain")
                elseif not animateFullCharge(v807) then
                    warn("[MonsterParasite] Full charge ended without launching a chest")
                end
                playSwapVeil(v807)
                MonsterParasite_3.AskFullChargeReset:FireServer()
                local v808 = v9
                if v808 and v808.Parent then
                    animateChestPickup(v808)
                end
            else
                warn("[MonsterParasite] Full charge had no live monster to burp from")
                MonsterParasite_3.AskFullChargeReset:FireServer()
                local v809 = v9
                if v809 and v809.Parent then
                    animateChestPickup(v809)
                end
            end
            requestTakeChest()
        else
            releaseMonsterFacing()
            waitForThread(v802)
        end
    end
end

local function startFeedSequence() -- line 3524 | captures: v8, v9, v10, v11, v20, v22, v25, v26, v27, v28, v29, MonsterParasite_2, MonsterParasite_3, LocalPlayer, v24, v196, releaseMonsterFacing, refreshPrompts, requestTakeChest, playSwapVeil, playFeedSequence
    if v20 then
        return
    end
    v20 = true
    refreshPrompts()
    task.spawn(function() -- line 3530 | captures: v8, v9, v10, v11, v20, v22, v25, v26, v27, v28, v29, MonsterParasite_2, MonsterParasite_3, LocalPlayer, v24, v196, releaseMonsterFacing, refreshPrompts, requestTakeChest, playSwapVeil, playFeedSequence
        local v810
        while true do
            if #v24 <= 0 then
                break
            end
            local v811 = table.remove(v24, 1)
            local v812 = v811 ~= nil
            assert(v812, "Feed sequence queue changed unexpectedly")
            local v813 = v811.PreviousCharge or 0
            local v814 = not not (v811.Charge or v813 > 0)
            local v815, v816 = pcall(function() -- line 3546 | captures: v811, playFeedSequence
                playFeedSequence(v811)
                return true
            end)
            if v814 then
                local v817 = v22 - 1
                v22 = math.max(0, v817)
            end
            if not v815 then
                local v818 = v28
                v28 = nil
                if v818 ~= nil then
                    v818:Disconnect()
                end
                v810 = v29
                v29 = nil
                if v810 ~= nil then
                    v810:Stop(v196.HandPoseReleaseSeconds)
                    task.delay(v196.HandPoseReleaseSeconds, function() -- line 3563 | captures: v810
                        v810:Destroy()
                    end)
                end
                if v25 ~= nil then
                    v25:Destroy()
                    v25 = nil
                end
                v27 = nil
                v26 = nil
                LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, os.clock())
                task.spawn(releaseMonsterFacing)
                v10 = nil
                warn((("[MonsterParasite] Feed sequence failed: %*"):format(v816)))
                if v814 then
                    playSwapVeil(v8)
                    MonsterParasite_3.AskFullChargeReset:FireServer()
                    requestTakeChest()
                end
            end
        end
        v20 = false
        if v11.PendingChests <= 0 and v22 <= 0 and v9 then
            v9:Destroy()
            v9 = nil
        end
        refreshPrompts()
    end)
end

MonsterParasite_3.StateShifted.OnClientEvent:Connect(function(v819) -- line 3592 | captures: MonsterParasite_2, applyState
    if MonsterParasite_2.StateSchema(v819) then
        applyState(v819)
    end
end)
MonsterParasite_3.EventStateShifted.OnClientEvent:Connect(function(v820) -- line 3597 | captures: v12, MonsterParasite_2, refreshPrompts
    if MonsterParasite_2.EventStateSchema(v820) then
        v12 = v820.Active
        refreshPrompts()
    end
end)
MonsterParasite_3.FeedSettled.OnClientEvent:Connect(function(v821) -- line 3603 | captures: v8, v9, v10, v11, v17, v20, v22, v23, v25, v26, v27, v28, v29, MonsterParasite_2, MonsterParasite_3, LocalPlayer, v24, v196, captureEquippedEgg, releaseMonsterFacing, refreshPrompts, requestTakeChest, playSwapVeil, playFeedSequence
    if not MonsterParasite_2.FeedResultSchema(v821) then
        return
    end
    v17 = false
    captureEquippedEgg()
    local v822 = v821.PreviousCharge or 0
    if v821.Charge or v822 > 0 then
        if v23 <= 0 then
            v22 += 1
        else
            v23 -= 1
        end
    end
    local v823 = {}
    if v821.Charge == nil then
        v823.Charge = v11.Charge
    else
        v823.Charge = v821.Charge
    end
    if v821.PendingChests == nil then
        v823.PendingChests = v11.PendingChests
    else
        v823.PendingChests = v821.PendingChests
    end
    v823.TotalFeeds = v11.TotalFeeds
    v823.PendingReward = v11.PendingReward
    v11 = table.clone(v823)
    if v8 then
        v8:SetAttribute("Charge", v823.Charge)
        v8:SetAttribute("PendingChests", v823.PendingChests)
    end
    table.insert(v24, v821)
    if v20 then
        return
    end
    v20 = true
    refreshPrompts()
    task.spawn(function() -- line 3649 | captures: v8, v9, v10, v11, v20, v22, v25, v26, v27, v28, v29, MonsterParasite_2, MonsterParasite_3, LocalPlayer, v24, v196, releaseMonsterFacing, refreshPrompts, requestTakeChest, playSwapVeil, playFeedSequence
        local v824
        while true do
            if #v24 <= 0 then
                break
            end
            local v825 = table.remove(v24, 1)
            local v826 = v825 ~= nil
            assert(v826, "Feed sequence queue changed unexpectedly")
            local v827 = v825.PreviousCharge or 0
            local v828 = not not (v825.Charge or v827 > 0)
            local v829, v830 = pcall(function() -- line 3665 | captures: v825, playFeedSequence
                playFeedSequence(v825)
                return true
            end)
            if v828 then
                local v831 = v22 - 1
                v22 = math.max(0, v831)
            end
            if not v829 then
                local v832 = v28
                v28 = nil
                if v832 ~= nil then
                    v832:Disconnect()
                end
                v824 = v29
                v29 = nil
                if v824 ~= nil then
                    v824:Stop(v196.HandPoseReleaseSeconds)
                    task.delay(v196.HandPoseReleaseSeconds, function() -- line 3682 | captures: v824
                        v824:Destroy()
                    end)
                end
                if v25 ~= nil then
                    v25:Destroy()
                    v25 = nil
                end
                v27 = nil
                v26 = nil
                LocalPlayer:SetAttribute(MonsterParasite_2.ChargeGainAttributeName, os.clock())
                task.spawn(releaseMonsterFacing)
                v10 = nil
                warn((("[MonsterParasite] Feed sequence failed: %*"):format(v830)))
                if v828 then
                    playSwapVeil(v8)
                    MonsterParasite_3.AskFullChargeReset:FireServer()
                    requestTakeChest()
                end
            end
        end
        v20 = false
        if v11.PendingChests <= 0 and v22 <= 0 and v9 then
            v9:Destroy()
            v9 = nil
        end
        refreshPrompts()
    end)
end)
MonsterParasite_3.ChestOpened.OnClientEvent:Connect(function(v833) -- line 3711 | captures: MonsterParasite_2, beginChestReveal
    if MonsterParasite_2.ChestResultSchema(v833) and v833.Success then
        beginChestReveal(v833)
    end
end)
v30:Start()
v2:Add(function() -- line 3718 | captures: v30
    v30:Stop()
end)
task.spawn(function() -- line 3721 | captures: v721, ContentProvider, ReplicatedStorage, MonsterParasite
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v834
    if Assets then
        v834 = Assets:FindFirstChild("Models")
    end
    local v835, v836
    if v834 then
        local v837 = v834:FindFirstChild(MonsterParasite.AssetsFolderName)
        v835 = v837
        v836 = v837
    end
    if v836 == nil then
        return
    end
    local v838 = {}

    local function enqueueModel(v839) -- line 3738 | captures: v835, v838
        local v840 = v835:FindFirstChild(v839)
        if v840 ~= nil then
            table.insert(v838, v840)
            for v841, v842 in v840:GetDescendants() do
                if v842:IsA("MeshPart") then
                    table.insert(v838, v842)
                end
            end
        end
    end

    for v843, v844 in MonsterParasite.MonsterModelNames do
        enqueueModel(v844)
    end
    enqueueModel(MonsterParasite.ChestModelName)
    local v845 = {}
    local v846
    if Assets then
        v846 = Assets:FindFirstChild("Particles")
    end
    local v847
    if v846 then
        v847 = v846:FindFirstChild(MonsterParasite.GroundHitParticlesName)
    end
    if v847 ~= nil then
        table.insert(v838, v847)
    end
    pcall(function() -- line 3774 | captures: v838, ContentProvider
        ContentProvider:PreloadAsync(v838)
    end)
    v721 = v845
    for v848, v849 in v721 do
        v849:Destroy()
    end
end)
local v850 = Workspace.ChildAdded
v2:Connect(v850, function(v851) -- line 3784 | captures: MonsterParasite, v2, bindModel, inspectInstance
    if v851.Name == MonsterParasite.WorldFolderName and v851:IsA("Folder") then
        for v852, v853 in v851:GetChildren() do
            if v853:IsA("Model") then
                bindModel(v853)
            end
        end
        v2:Connect(v851.ChildAdded, inspectInstance)
    end
end)
local OnClientEvent = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)

if OnClientEvent and OnClientEvent:IsA("Folder") then
    local function v854(v855) -- line 3796 | captures: v2, bindModel, inspectInstance
        for v856, v857 in v855:GetChildren() do
            if v857:IsA("Model") then
                bindModel(v857)
            end
        end
        v2:Connect(v855.ChildAdded, inspectInstance)
    end

    v854(OnClientEvent)
end

local function v18(v858) -- line 3805 | captures: MonsterParasite, v3, refreshPrompts, requestChest
    v3:Clean()
    v3:Connect(v858.ChildAdded, function(v859) -- line 3808 | captures: MonsterParasite, v3, refreshPrompts, requestChest
        if not v859:IsA("Tool") then
            return
        end
        refreshPrompts()
        if v859:GetAttribute("ItemType") == MonsterParasite.ChestToolItemType then
            v3:Connect(v859.Activated, requestChest)
        end
    end)
    v3:Connect(v858.ChildRemoved, function(v860) -- line 3818 | captures: refreshPrompts
        if v860:IsA("Tool") then
            refreshPrompts()
        end
    end)
    for v861, v862 in v858:GetChildren() do
        if v862:IsA("Tool") and v862:GetAttribute("ItemType") == MonsterParasite.ChestToolItemType then
            v3:Connect(v862.Activated, requestChest)
        end
    end
    refreshPrompts()
end

v2:Connect(LocalPlayer.CharacterAdded, v18)
v850 = LocalPlayer.Character

if v850 then
    v18(v850)
end
v2:Connect(Save.FieldSignal("EggInventory"), refreshPrompts)
v2:Connect(Save.FieldSignal("MonsterParasite"), refreshPrompts)
task.spawn(function() -- line 3843 | captures: v12, OpeningId, MonsterParasite_2, MonsterParasite_3, refreshPrompts, applyState, beginChestReveal
    local v863, v864 = pcall(function() -- line 3845 | captures: MonsterParasite_3
        return MonsterParasite_3.AskSnapshot:InvokeServer()
    end)
    if v863 and MonsterParasite_2.SnapshotSchema(v864) then
        v12 = v864.Event.Active
        applyState(v864.State)
        local PendingReward = v864.State.PendingReward
        if PendingReward ~= nil and OpeningId == nil then
            beginChestReveal({
                Success = true,
                Message = ("You received %*!"):format(PendingReward.Reward.DisplayName),
                OpeningId = PendingReward.OpeningId,
                Reward = PendingReward.Reward,
                PendingChests = v864.State.PendingChests
            })
        end
    else
        return
    end
    refreshPrompts()
end)
