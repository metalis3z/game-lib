-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent
local Humanoid = Parent:WaitForChild("Humanoid")
local v1 = "Standing"

local function getRigScale() -- line 10 | captures: Parent
    return Parent:GetScale()
end

local v2 = script:FindFirstChild("ScaleDampeningPercent")
local v3 = ""
local v4, v5, v6
local v7 = 1
local v8, v9
local v10 = {}
local v11 = {}
local v12 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        }
    },
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        }
    },
    run = {
        {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        }
    },
    swim = {
        {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        }
    },
    swimidle = {
        {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        }
    },
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        }
    },
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        }
    },
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        }
    },
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        }
    },
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        }
    },
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        }
    },
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        }
    },
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        }
    },
    point = {
        {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        }
    },
    dance = {
        {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        }
    },
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        }
    },
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        }
    },
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        }
    },
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        }
    }
}
local v13 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
}
local v14, v15, v16, GroundSensor, v17

function resetManagerListeners() -- line 104 | captures: v14, v15, v16
    if v14 then
        v14:Disconnect()
        v14 = nil
    end
    if v15 then
        v15:Disconnect()
        v15 = nil
    end
    if v16 then
        v16:Disconnect()
        v16 = nil
    end
end

function processIfManagerBelongsToCharacter(v18) -- line 118 | captures: v14, v15, v16, GroundSensor, v17, Parent
    if v18.RootPart == Parent.PrimaryPart then
        if v17 ~= v18 then
            resetManagerListeners()
            GroundSensor = v18.GroundSensor
            v14 = v18:GetPropertyChangedSignal("GroundSensor"):Connect(function() -- line 126 | captures: v18, v14
                if processIfManagerBelongsToCharacter(v18) then
                    v14:Disconnect()
                    v14 = nil
                end
            end)
            v15 = v18:GetPropertyChangedSignal("RootPart"):Connect(function() -- line 133 | captures: v18, v15
                if processIfManagerBelongsToCharacter(v18) then
                    v15:Disconnect()
                    v15 = nil
                end
            end)
            v16 = v18.AncestryChanged:Connect(function(v19, v20) -- line 139
                if v20 == nil then
                    resetManagerListeners()
                    lookForControllerManager()
                end
            end)
            v17 = v18
        end
        return true
    end
    return false
end

function lookForControllerManager() -- line 149 | captures: GroundSensor, v17, Parent
    GroundSensor = nil
    v17 = nil
    local ControllerManager = Parent:FindFirstChildOfClass("ControllerManager")
    if ControllerManager then
        processIfManagerBelongsToCharacter(ControllerManager)
    end
end

lookForControllerManager()
math.randomseed(tick())

function findExistingAnimationInSet(v21, v22) -- line 162
    if v21 ~= nil and v22 ~= nil then
        local count = v21.count
        for v23 = 1, count do
            if v21[v23].anim.AnimationId == v22.AnimationId then
                return v23
            end
        end
    end
    return 0
end

function configureAnimationSet(v24, v25) -- line 175 | captures: Humanoid, v10, v11
    local function v26(v27, ...)
        table.insert(v27, ...)
    end

    local function v28(v29, ...)
        table.insert(v29, ...)
    end

    local function v30(v31, ...)
        table.insert(v31, ...)
    end

    local function v32(v33, ...)
        table.insert(v33, ...)
    end

    local function v34(v35, ...)
        table.insert(v35, ...)
    end

    if v11[v24] ~= nil then
        for v36, v37 in pairs(v11[v24].connections) do
            v37:disconnect()
        end
    end
    v11[v24] = {}
    v11[v24].count = 0
    v11[v24].totalWeight = 0
    v11[v24].connections = {}
    local v38 = true
    if not pcall(function() -- line 190 | captures: v38
            v38 = game:GetService("StarterPlayer").AllowCustomAnimations
        end) then
        v38 = true
    end
    local v39 = script:FindFirstChild(v24)
    local v40, v41
    if v38 then
        if v39 == nil then
            v40 = v24
            v41 = v25
        else
            v26(v11[v24].connections, v39.ChildAdded:connect(function(v42) -- line 203 | captures: v24, v25
                configureAnimationSet(v24, v25)
            end))
            v28(v11[v24].connections, v39.ChildRemoved:connect(function(v43) -- line 206 | captures: v24, v25
                configureAnimationSet(v24, v25)
            end))
            v40 = v24
            v41 = v25
            for v44, v45 in pairs(v39:GetChildren()) do
                if v45:IsA("Animation") then
                    local Weight = v45:FindFirstChild("Weight")
                    local v46 = if Weight == nil then 1 else Weight.Value
                    v11[v40].count = v11[v40].count + 1
                    local count = v11[v40].count
                    v11[v40][count] = {}
                    v11[v40][count].anim = v45
                    v11[v40][count].weight = v46
                    v11[v40].totalWeight = v11[v40].totalWeight + v11[v40][count].weight
                    v30(v11[v40].connections, v45.Changed:connect(function(v47) -- line 226 | captures: v40, v41
                        configureAnimationSet(v40, v41)
                    end))
                    v32(v11[v40].connections, v45.ChildAdded:connect(function(v48) -- line 229 | captures: v40, v41
                        configureAnimationSet(v40, v41)
                    end))
                    v34(v11[v40].connections, v45.ChildRemoved:connect(function(v49) -- line 232 | captures: v40, v41
                        configureAnimationSet(v40, v41)
                    end))
                end
            end
        end
    else
        v40 = v24
        v41 = v25
    end
    if v11[v40].count <= 0 then
        for v50, v51 in pairs(v41) do
            v11[v40][v50] = {}
            v11[v40][v50].anim = Instance.new("Animation")
            v11[v40][v50].anim.Name = v40
            v11[v40][v50].anim.AnimationId = v51.id
            v11[v40][v50].weight = v51.weight
            v11[v40].count = v11[v40].count + 1
            v11[v40].totalWeight = v11[v40].totalWeight + v51.weight
        end
    end
    for v52, v53 in pairs(v11) do
        local count = v53.count
        for v54 = 1, count do
            if v10[v53[v54].anim.AnimationId] == nil then
                Humanoid:LoadAnimation(v53[v54].anim)
                v10[v53[v54].anim.AnimationId] = true
            end
        end
    end
end

function configureAnimationSetOld(v55, v56) -- line 266 | captures: Humanoid, v11
    local function v57(v58, ...)
        table.insert(v58, ...)
    end

    local function v59(v60, ...)
        table.insert(v60, ...)
    end

    local function v61(v62, ...)
        table.insert(v62, ...)
    end

    if v11[v55] ~= nil then
        for v63, v64 in pairs(v11[v55].connections) do
            v64:disconnect()
        end
    end
    v11[v55] = {}
    v11[v55].count = 0
    v11[v55].totalWeight = 0
    v11[v55].connections = {}
    local v65 = true
    if not pcall(function() -- line 281 | captures: v65
            v65 = game:GetService("StarterPlayer").AllowCustomAnimations
        end) then
        v65 = true
    end
    local v66 = script:FindFirstChild(v55)
    local v67, v68
    if v65 then
        if v66 == nil then
            v67 = v55
            v68 = v56
        else
            v57(v11[v55].connections, v66.ChildAdded:connect(function(v69) -- line 294 | captures: v55, v56
                configureAnimationSet(v55, v56)
            end))
            v59(v11[v55].connections, v66.ChildRemoved:connect(function(v70) -- line 297 | captures: v55, v56
                configureAnimationSet(v55, v56)
            end))
            v67 = v55
            v68 = v56
            local v71 = 1
            for v72, v73 in pairs(v66:GetChildren()) do
                if v73:IsA("Animation") then
                    v61(v11[v67].connections, v73.Changed:connect(function(v74) -- line 304 | captures: v67, v68
                        configureAnimationSet(v67, v68)
                    end))
                    v11[v67][v71] = {}
                    v11[v67][v71].anim = v73
                    local Weight = v73:FindFirstChild("Weight")
                    if Weight == nil then
                        v11[v67][v71].weight = 1
                    else
                        v11[v67][v71].weight = Weight.Value
                    end
                    v11[v67].count = v11[v67].count + 1
                    v11[v67].totalWeight = v11[v67].totalWeight + v11[v67][v71].weight
                    v71 += 1
                end
            end
        end
    else
        v67 = v55
        v68 = v56
    end
    if v11[v67].count <= 0 then
        for v75, v76 in pairs(v68) do
            v11[v67][v75] = {}
            v11[v67][v75].anim = Instance.new("Animation")
            v11[v67][v75].anim.Name = v67
            v11[v67][v75].anim.AnimationId = v76.id
            v11[v67][v75].weight = v76.weight
            v11[v67].count = v11[v67].count + 1
            v11[v67].totalWeight = v11[v67].totalWeight + v76.weight
        end
    end
    for v77, v78 in pairs(v11) do
        local count = v78.count
        for v79 = 1, count do
            Humanoid:LoadAnimation(v78[v79].anim)
        end
    end
end

function scriptChildModified(v80) -- line 352 | captures: v12
    local v81 = v12[v80.Name]
    if v81 ~= nil then
        configureAnimationSet(v80.Name, v81)
    end
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v82

if Humanoid then
    v82 = Humanoid:FindFirstChildOfClass("Animator")
end

if v82 then
    local v83 = v82:GetPlayingAnimationTracks()
    for v84, v85 in ipairs(v83) do
        v85:Stop(0)
        v85:Destroy()
    end
end
for v86, v87 in pairs(v12) do
    configureAnimationSet(v86, v87)
end
local v88 = "None"
local v89 = 0
local v90 = 0
local v91 = false

function stopAllAnimations() -- line 379 | captures: v3, v4, v5, v6, v8, v9, v91, v13
    local v92 = v3
    if v13[v92] ~= nil and v13[v92] == false then
        v92 = "idle"
    end
    if v91 then
        v91 = false
        v92 = "idle"
    end
    v3 = ""
    v4 = nil
    if v6 ~= nil then
        v6:disconnect()
    end
    if v5 ~= nil then
        v5:Stop()
        v5:Destroy()
        v5 = nil
    end
    if v9 ~= nil then
        v9:disconnect()
    end
    if v8 ~= nil then
        v8:Stop()
        v8:Destroy()
        v8 = nil
    end
    return v92
end

function getHeightScale() -- line 408 | captures: v2, Humanoid, getRigScale
    local v93
    if Humanoid and Humanoid.AutomaticScalingEnabled then
        v93 = Humanoid.HipHeight / 2
        if v2 == nil then
            v2 = script:FindFirstChild("ScaleDampeningPercent")
        end
    else
        return getRigScale()
    end
    if v2 ~= nil then
        v93 = 1 + (Humanoid.HipHeight - 2) * v2.Value / 2
    end
    return v93
end

local function rootMotionCompensation(v94) -- line 421
    return v94 * 1.25 / getHeightScale()
end

local function setRunSpeed(v95) -- line 424 | captures: v5, v8
    local v96 = v95 * 1.25 / getHeightScale()
    local v97, v98, v99
    if v96 <= 0.5 then
        v97, v98, v99 = 1, 0.0001, v96 / 0.5
    elseif v96 >= 1 then
        v97, v98, v99 = 0.0001, 1, v96 / 1
    else
        v98 = (v96 - 0.5) / 0.5
        v97 = 1 - v98
        v99 = 1
    end
    v5:AdjustWeight(v97)
    v8:AdjustWeight(v98)
    v5:AdjustSpeed(v99)
    v8:AdjustSpeed(v99)
end

function setAnimationSpeed(v100) -- line 445 | captures: v3, v5, v7, setRunSpeed
    if v3 == "walk" then
        setRunSpeed(v100)
    elseif v100 ~= v7 then
        v7 = v100
        v5:AdjustSpeed(v7)
    end
end

function keyFrameReachedFunc(v101) -- line 455 | captures: v3, v5, v7, v8, v91, Humanoid, v13
    if v101 == "End" then
        if v3 == "walk" then
            if v8.Looped ~= true then
                v8.TimePosition = 0
            end
            if v5.Looped ~= true then
                v5.TimePosition = 0
            end
        else
            local v102 = v3
            if v13[v102] ~= nil and v13[v102] == false then
                v102 = "idle"
            end
            if v91 then
                if not v5.Looped then
                    v91 = false
                    playAnimation("idle", 0.15, Humanoid)
                    setAnimationSpeed(v7)
                end
            else
                playAnimation(v102, 0.15, Humanoid)
                setAnimationSpeed(v7)
            end
        end
    end
end

function rollAnimation(v103) -- line 485 | captures: v11
    local v104 = math.random(1, v11[v103].totalWeight)
    local v105 = 1
    while v11[v103][v105].weight < v104 do
        v104 -= v11[v103][v105].weight
        v105 += 1
    end
    return v105
end

local function switchToAnim(v106, v107, v108, v109) -- line 494 | captures: v3, v4, v5, v6, v7, v8, v9, v11
    if v106 == v4 then
        return
    end
    if v5 ~= nil then
        v5:Stop(v108)
        v5:Destroy()
    end
    if v8 ~= nil then
        v8:Stop(v108)
        v8:Destroy()
        v8 = nil
    end
    v7 = 1
    v5 = v109:LoadAnimation(v106)
    v5.Priority = Enum.AnimationPriority.Core
    v5:Play(v108)
    v3 = v107
    v4 = v106
    if v6 ~= nil then
        v6:disconnect()
    end
    v6 = v5.KeyframeReached:connect(keyFrameReachedFunc)
    if v107 ~= "walk" then
        return
    end
    v8 = v109:LoadAnimation(v11.run[rollAnimation("run")].anim)
    v8.Priority = Enum.AnimationPriority.Core
    v8:Play(v108)
    if v9 ~= nil then
        v9:disconnect()
    end
    v9 = v8.KeyframeReached:connect(keyFrameReachedFunc)
end

function playAnimation(v110, v111, v112) -- line 526 | captures: v91, v11, switchToAnim
    switchToAnim(v11[v110][rollAnimation(v110)].anim, v110, v111, v112)
    v91 = false
end

function playEmote(v113, v114, v115) -- line 530 | captures: v91, switchToAnim
    switchToAnim(v113, v113.Name, v114, v115)
    v91 = true
end

local v116 = ""
local v117, anim, v118

function toolKeyFrameReachedFunc(v119) -- line 538 | captures: v116, Humanoid
    if v119 == "End" then
        playToolAnimation(v116, 0, Humanoid)
    end
end

function playToolAnimation(v120, v121, v122, v123) -- line 543 | captures: v116, v117, anim, v118, v11
    local anim_2 = v11[v120][rollAnimation(v120)].anim
    if anim == anim_2 then
        return
    end
    local v124
    if v117 == nil then
        v124 = v121
    else
        v117:Stop()
        v117:Destroy()
        v124 = 0
    end
    v117 = v122:LoadAnimation(anim_2)
    if v123 then
        v117.Priority = v123
    end
    v117:Play(v124)
    v116 = v120
    anim = anim_2
    v118 = v117.KeyframeReached:connect(toolKeyFrameReachedFunc)
end

function stopToolAnimations() -- line 564 | captures: v116, v117, anim, v118
    if v118 ~= nil then
        v118:disconnect()
    end
    v116 = ""
    anim = nil
    if v117 ~= nil then
        v117:Stop()
        v117:Destroy()
        v117 = nil
    end
    return v116
end

function onRunning(v125) -- line 577 | captures: v1, v3, GroundSensor, v17, v91, Humanoid, v13
    local v126 = getHeightScale()
    local v127
    if GroundSensor == nil then
        v127 = v125
    elseif Humanoid.EvaluateStateMachine == false then
        local SensedPart = GroundSensor.SensedPart
        if SensedPart then
            local v128 = SensedPart:GetVelocityAtPosition(GroundSensor.HitFrame.Position)
            local AssemblyLinearVelocity = Humanoid.RootPart.AssemblyLinearVelocity
            local v129 = AssemblyLinearVelocity.X - v128.X
            local v130 = AssemblyLinearVelocity.Z - v128.Z
            local Magnitude = Vector3.new(v129, 0, v130).Magnitude
            local Magnitude_2 = v17.MovingDirection.Magnitude
            if Magnitude_2 < 0.1 then
                Magnitude = 0
                Magnitude_2 = 0
            elseif Magnitude_2 > 1 then
                Magnitude_2 = 1
            end
            v127 = Magnitude * Magnitude_2
        else
            v127 = v125
        end
    else
        v127 = v125
    end
    if (v91 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and Humanoid.WalkSpeed / v126 or 0.75) * v126 < v127 then
        playAnimation("walk", 0.2, Humanoid)
        setAnimationSpeed(v127 / 16)
        v1 = "Running"
    elseif v13[v3] == nil and not v91 then
        playAnimation("idle", 0.2, Humanoid)
        v1 = "Standing"
    end
end

function onDied() -- line 625 | captures: v1
    v1 = "Dead"
end

function onJumping() -- line 628 | captures: v1, v90, Humanoid
    playAnimation("jump", 0.1, Humanoid)
    v90 = 0.31
    v1 = "Jumping"
end

function onClimbing(v131) -- line 633 | captures: v1, Humanoid
    local v132 = v131 / getHeightScale()
    playAnimation("climb", 0.1, Humanoid)
    setAnimationSpeed(v132 / 5)
    v1 = "Climbing"
end

function onGettingUp() -- line 639 | captures: v1
    v1 = "GettingUp"
end

function onFreeFall() -- line 642 | captures: v1, v90, Humanoid
    if v90 <= 0 then
        playAnimation("fall", 0.2, Humanoid)
    end
    v1 = "FreeFall"
end

function onFallingDown() -- line 648 | captures: v1
    v1 = "FallingDown"
end

function onSeated() -- line 651 | captures: v1
    v1 = "Seated"
end

function onPlatformStanding() -- line 654 | captures: v1
    v1 = "PlatformStanding"
end

function onSwimming(v133) -- line 657 | captures: v1, Humanoid
    local v134 = v133 / getHeightScale()
    if v134 <= 1 then
        playAnimation("swimidle", 0.4, Humanoid)
        v1 = "Standing"
    else
        playAnimation("swim", 0.4, Humanoid)
        setAnimationSpeed(v134 / 10)
        v1 = "Swimming"
    end
end

function animateTool() -- line 668 | captures: v88, Humanoid
    if v88 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
    elseif v88 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
    elseif v88 == "Lunge" then
        playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
    end
end

function getToolAnim(v135) -- line 682
    for v136, v137 in ipairs(v135:GetChildren()) do
        if v137.Name == "toolanim" and v137.className == "StringValue" then
            return v137
        end
    end
    return nil
end

local v138 = 0

function stepAnimate(v139) -- line 691 | captures: v1, v88, v89, v90, anim, v138, Parent, Humanoid
    local v140 = v139 - v138
    v138 = v139
    if v90 > 0 then
        v90 -= v140
    end
    if v1 == "FreeFall" then
        if v90 <= 0 then
            playAnimation("fall", 0.2, Humanoid)
        end
    elseif v1 == "Seated" then
        playAnimation("sit", 0.5, Humanoid)
    else
        if v1 == "Running" then
            playAnimation("walk", 0.2, Humanoid)
        elseif v1 == "Dead" then
            stopAllAnimations()
        end
        local Tool = Parent:FindFirstChildOfClass("Tool")
        if Tool and Tool:FindFirstChild("Handle") then
            local v141 = getToolAnim(Tool)
            if v141 then
                v88 = v141.Value
                v141.Parent = nil
                v89 = v139 + 0.3
            end
            if v89 < v139 then
                v89 = 0
                v88 = "None"
            end
            animateTool()
        else
            stopToolAnimations()
            v88 = "None"
            anim = nil
            v89 = 0
        end
    end
end

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(v142) -- line 742 | captures: v1, Humanoid, v13
    local v143
    if string.sub(v142, 1, 3) == "/e " then
        v143 = string.sub(v142, 4)
    elseif string.sub(v142, 1, 7) == "/emote " then
        v143 = string.sub(v142, 8)
    else
        v143 = ""
    end
    if v1 == "Standing" and v13[v143] ~= nil then
        playAnimation(v143, 0.1, Humanoid)
    end
end)

script:WaitForChild("PlayEmote").OnInvoke = function(v144) -- OnInvoke | line 754 | captures: v1, v5, Humanoid, v13
    if v1 == "Standing" then
        if v13[v144] == nil then
            if not (typeof(v144) == "Instance" and v144:IsA("Animation")) then
                return false
            end
            playEmote(v144, 0.1, Humanoid)
        else
            playAnimation(v144, 0.1, Humanoid)
        end
        return true, v5
    end
end

if Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid)
end
while true do
    if Parent.Parent == nil then
        break
    end
    local v145, v146 = wait(0.1)
    _ = v145
    stepAnimate(v146)
end
