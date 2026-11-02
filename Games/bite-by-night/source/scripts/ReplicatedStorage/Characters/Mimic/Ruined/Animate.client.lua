-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local Humanoid = Parent:WaitForChild("Humanoid")
local v_u_3 = "Standing"
local _ = Humanoid.MaxHealth / 2
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local m_CameraShaker = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CameraShaker"))
local v_u_7 = m_CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p6)
    if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
        CurrentCamera.CFrame = CurrentCamera.CFrame * p6
    end
end)
v_u_7:Start()
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Shake"):Connect(function(p8)
    if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
        v_u_7:Shake(m_CameraShaker.Presets[p8])
    end
end)
local v9, v10 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v_u_11 = v9 and v10
local v_u_12 = ""
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = 1
local v_u_17 = {}
local v_u_18 = {
    ["idle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=140266457629101",
            ["weight"] = 9
        }
    },
    ["runForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=128410676942339",
            ["weight"] = 10
        }
    },
    ["runLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=97432351840259",
            ["weight"] = 10
        }
    },
    ["runRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=91386915457970",
            ["weight"] = 10
        }
    },
    ["walkForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=131928508938793",
            ["weight"] = 10
        }
    },
    ["walkForwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=117684421272671",
            ["weight"] = 10
        }
    },
    ["walkForwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=74597828098856",
            ["weight"] = 10
        }
    },
    ["walkBackward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=102923069389498",
            ["weight"] = 10
        }
    },
    ["walkBackwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=77833069434268",
            ["weight"] = 10
        }
    },
    ["walkBackwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=119842509237005",
            ["weight"] = 10
        }
    },
    ["walkRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=118158792536239",
            ["weight"] = 10
        }
    },
    ["walkLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=131444573074843",
            ["weight"] = 10
        }
    },
    ["jump"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["fall"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["climb"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["sit"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["toolnone"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["toolslash"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    },
    ["toollunge"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=89409838595230",
            ["weight"] = 10
        }
    }
}
local v_u_19 = {
    ["wave"] = false,
    ["point"] = false,
    ["dance1"] = true,
    ["dance2"] = true,
    ["dance3"] = true,
    ["laugh"] = false,
    ["cheer"] = false
}
function configureAnimationSet(p_u_20, p_u_21)
    if v_u_17[p_u_20] ~= nil then
        for _, v22 in pairs(v_u_17[p_u_20].connections) do
            v22:disconnect()
        end
    end
    v_u_17[p_u_20] = {}
    v_u_17[p_u_20].count = 0
    v_u_17[p_u_20].totalWeight = 0
    v_u_17[p_u_20].connections = {}
    local v23 = script:FindFirstChild(p_u_20)
    if v23 ~= nil then
        local connections = v_u_17[p_u_20].connections
        local ChildAdded = v23.ChildAdded
        table.insert(connections, ChildAdded:connect(function(_)
            configureAnimationSet(p_u_20, p_u_21)
        end))
        local connections_0 = v_u_17[p_u_20].connections
        local ChildRemoved = v23.ChildRemoved
        table.insert(connections_0, ChildRemoved:connect(function(_)
            configureAnimationSet(p_u_20, p_u_21)
        end))
        local v28 = 1
        for _, v29 in pairs(v23:GetChildren()) do
            if v29:IsA("Animation") then
                local connections_1 = v_u_17[p_u_20].connections
                local Changed = v29.Changed
                table.insert(connections_1, Changed:connect(function(_)
                    configureAnimationSet(p_u_20, p_u_21)
                    task.spawn(move, os.clock())
                end))
                v_u_17[p_u_20][v28] = {}
                v_u_17[p_u_20][v28].anim = v29
                local Weight = v29:FindFirstChild("Weight")
                if Weight == nil then
                    v_u_17[p_u_20][v28].weight = 1
                else
                    v_u_17[p_u_20][v28].weight = Weight.Value
                end
                v_u_17[p_u_20].count = v_u_17[p_u_20].count + 1
                v_u_17[p_u_20].totalWeight = v_u_17[p_u_20].totalWeight + v_u_17[p_u_20][v28].weight
                v28 = v28 + 1
            end
        end
    end
    if v_u_17[p_u_20].count <= 0 then
        for v33, v34 in pairs(p_u_21) do
            v_u_17[p_u_20][v33] = {}
            v_u_17[p_u_20][v33].anim = Instance.new("Animation")
            v_u_17[p_u_20][v33].anim.Name = p_u_20
            v_u_17[p_u_20][v33].anim.AnimationId = v34.id
            v_u_17[p_u_20][v33].weight = v34.weight
            v_u_17[p_u_20].count = v_u_17[p_u_20].count + 1
            v_u_17[p_u_20].totalWeight = v_u_17[p_u_20].totalWeight + v34.weight
        end
    end
end
function scriptChildModified(p35)
    local v36 = v_u_18[p35.Name]
    if v36 ~= nil then
        configureAnimationSet(p35.Name, v36)
    end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
if Humanoid then
    Humanoid:FindFirstChildOfClass("Animator")
end
for v37, v38 in pairs(v_u_18) do
    configureAnimationSet(v37, v38)
end
local Value = "None"
local v_u_40 = 0
local v_u_41 = 0
function stopAllAnimations()
    local v42 = v_u_12
    local v43 = v_u_19[v42] ~= nil and v_u_19[v42] == false and "idle" or v42
    v_u_12 = ""
    v_u_13 = nil
    if v_u_15 ~= nil then
        v_u_15:disconnect()
    end
    if v_u_14 ~= nil then
        v_u_14:Stop()
        v_u_14:Destroy()
        v_u_14 = nil
    end
    return v43
end
function setAnimationSpeed(p44)
    if p44 ~= v_u_16 and v_u_14 then
        v_u_16 = p44
        v_u_14:AdjustSpeed(v_u_16)
    end
end
function keyFrameReachedFunc(p45)
    if p45 == "End" then
        local v46 = v_u_12
        local v47 = v_u_19[v46] ~= nil and v_u_19[v46] == false and "idle" or v46
        local v48 = v_u_16
        playAnimation(v47, 0, Humanoid)
        setAnimationSpeed(v48)
    end
end
function playAnimation(p49, p50, p51)
    local weight = math.random(1, v_u_17[p49].totalWeight)
    local v53 = 1
    while v_u_17[p49][v53].weight < weight do
        weight = weight - v_u_17[p49][v53].weight
        v53 = v53 + 1
    end
    local anim = v_u_17[p49][v53].anim
    if anim ~= v_u_13 then
        local TimePosition = (not (v_u_12:match("walk") or v_u_12:match("run")) or v_u_12 == "stop") and 0 or v_u_14.TimePosition
        if v_u_14 ~= nil then
            v_u_14:Stop(p50)
            v_u_14:Destroy()
        end
        v_u_16 = 1
        v_u_14 = p51:LoadAnimation(anim)
        v_u_14.Priority = Enum.AnimationPriority.Core
        v_u_14:Play(p50)
        v_u_14.TimePosition = TimePosition
        v_u_12 = p49
        v_u_13 = anim
        if v_u_15 ~= nil then
            v_u_15:disconnect()
        end
        local v_u_56 = v_u_14:GetMarkerReachedSignal("Step"):Connect(function()
            if v_u_3 == "Walking" then
                if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
                    v_u_7:Shake(m_CameraShaker.Presets.StepShake)
                    return
                end
            elseif (v_u_3 == "Running" or v_u_3 == "RunningStart") and game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
                v_u_7:Shake(m_CameraShaker.Presets.RunningShake)
            end
        end)
        v_u_14.Stopped:Once(function()
            v_u_56:Disconnect()
        end)
        v_u_15 = v_u_14.KeyframeReached:connect(keyFrameReachedFunc)
    end
end
local v_u_57 = ""
local v_u_58 = nil
local v_u_59 = nil
local v_u_60 = nil
function toolKeyFrameReachedFunc(p61)
    if p61 == "End" then
        playToolAnimation(v_u_57, 0, Humanoid)
    end
end
function playToolAnimation(p62, p63, p64, p65)
    local weight_0 = math.random(1, v_u_17[p62].totalWeight)
    local v67 = 1
    while v_u_17[p62][v67].weight < weight_0 do
        weight_0 = weight_0 - v_u_17[p62][v67].weight
        v67 = v67 + 1
    end
    local anim_0 = v_u_17[p62][v67].anim
    if v_u_59 ~= anim_0 then
        if v_u_58 ~= nil then
            v_u_58:Stop()
            v_u_58:Destroy()
            p63 = 0
        end
        v_u_58 = p64:LoadAnimation(anim_0)
        if p65 then
            v_u_58.Priority = p65
        end
        v_u_58:Play(p63)
        v_u_57 = p62
        v_u_59 = anim_0
        v_u_60 = v_u_58.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end
function stopToolAnimations()
    local v69 = v_u_57
    if v_u_60 ~= nil then
        v_u_60:disconnect()
    end
    v_u_57 = ""
    v_u_59 = nil
    if v_u_58 ~= nil then
        v_u_58:Stop()
        v_u_58:Destroy()
        v_u_58 = nil
    end
    return v69
end
function onDied()
    v_u_3 = "Dead"
end
function onJumping()
    playAnimation("jump", 0.1, Humanoid)
    v_u_41 = 0.3
    v_u_3 = "Jumping"
end
function onClimbing(p70)
    local v71 = p70 / (not v_u_11 and 1 or Parent:GetScale())
    playAnimation("climb", 0.1, Humanoid)
    setAnimationSpeed(v71 / 12)
    v_u_3 = "Climbing"
end
function onGettingUp()
    v_u_3 = "GettingUp"
end
function onFreeFall()
    if v_u_41 <= 0 then
        playAnimation("fall", 0.3, Humanoid)
    end
    v_u_3 = "FreeFall"
end
function onFallingDown()
    v_u_3 = "FallingDown"
end
function onSeated()
    v_u_3 = "Seated"
end
function onPlatformStanding()
    v_u_3 = "PlatformStanding"
end
function onSwimming(p72)
    if p72 > 0 then
        v_u_3 = "Running"
    else
        v_u_3 = "Standing"
    end
end
function getTool()
    for _, v73 in ipairs(Parent:GetChildren()) do
        if v73.className == "Tool" then
            return v73
        end
    end
    return nil
end
function getToolAnim(p74)
    for _, v75 in ipairs(p74:GetChildren()) do
        if v75.Name == "toolanim" and v75.className == "StringValue" then
            return v75
        end
    end
    return nil
end
function animateTool()
    if Value == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
        return
    elseif Value == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
        return
    elseif Value == "Lunge" then
        playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
    end
end
local v_u_76 = 0
local Health = Humanoid.Health
function move(p78)
    if Parent:HasTag("CantMove") or (Parent:GetAttribute("Stun") == true or (Parent:HasTag("StopAnim") or Parent:HasTag("KillAnims"))) then
        if Parent:HasTag("KillAnims") then
            v_u_3 = "None"
            stopAllAnimations()
        elseif v_u_3 ~= "Standing" then
            v_u_3 = "Standing"
            playAnimation("idle", 0.1, Humanoid)
        end
    elseif Parent:GetAttribute("RunSpeed") then
        local v79 = p78 - v_u_76
        v_u_76 = p78
        if v_u_41 > 0 then
            v_u_41 = v_u_41 - v79
        end
        local Magnitude = (Parent:FindFirstChild("HumanoidRootPart").Velocity * Vector3.new(1, 0, 1)).Magnitude
        if Humanoid.FloorMaterial ~= Enum.Material.Air and (v_u_3 ~= "Stopping" or Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(Humanoid.MoveDirection) > 0.45) then
            if Magnitude > 0.01 and (Magnitude <= Parent:GetAttribute("RunSpeed") - 2 and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0)) then
                v_u_7:StopSustained(0.5)
                v_u_3 = "Walking"
            elseif Parent:GetAttribute("RunSpeed") - 2 < Magnitude and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
                v_u_3 = "Running"
            elseif v_u_19[v_u_12] == nil and (v_u_3 ~= "Standing" and v_u_3 ~= "Stopping") then
                playAnimation("idle", 0.1, Humanoid)
                v_u_3 = "Standing"
            end
        end
        if v_u_3 == "FreeFall" and v_u_41 <= 0 then
            playAnimation("idle", 0.1, Humanoid)
        else
            if v_u_3 == "Seated" then
                playAnimation("sit", 0.5, Humanoid)
                return
            end
            if v_u_3 == "Walking" then
                local v81 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardRight", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardRight", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardLeft", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardLeft", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkRight", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackward", 0.3, Humanoid)
                elseif v81:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkLeft", 0.3, Humanoid)
                end
                if v_u_14 then
                    v_u_14.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 12)
            elseif v_u_3 == "Running" then
                local v82 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("runForward", 0.3, Humanoid)
                elseif v82:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runLeft", 0.3, Humanoid)
                elseif v82:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runRight", 0.3, Humanoid)
                else
                    playAnimation("runForward", 0.3, Humanoid)
                end
                if v_u_14 then
                    v_u_14.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 18)
            elseif v_u_3 == "Dead" or (v_u_3 == "GettingUp" or (v_u_3 == "Seated" or v_u_3 == "PlatformStanding")) then
                stopAllAnimations()
            end
        end
        Health = Humanoid.Health
        local v83 = getTool()
        if v83 and v83:FindFirstChild("Handle") then
            local v84 = getToolAnim(v83)
            if v84 then
                Value = v84.Value
                v84.Parent = nil
                v_u_40 = p78 + 0.3
            end
            if v_u_40 < p78 then
                v_u_40 = 0
                Value = "None"
            end
            animateTool()
        else
            stopToolAnimations()
            Value = "None"
            v_u_59 = nil
            v_u_40 = 0
        end
    else
        return
    end
end
Humanoid.Died:connect(onDied)
playAnimation("idle", 0.1, Humanoid)
local _ = "Standing"
while Parent.Parent ~= nil do
    local _, v85 = wait()
    move(v85)
end
