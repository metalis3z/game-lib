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
            ["id"] = "http://www.roblox.com/asset/?id=100366191143513",
            ["weight"] = 9
        }
    },
    ["runForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=118999109006745",
            ["weight"] = 10
        }
    },
    ["runLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=87231273194753",
            ["weight"] = 10
        }
    },
    ["runRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=88961517298043",
            ["weight"] = 10
        }
    },
    ["walkForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=135774928927185",
            ["weight"] = 10
        }
    },
    ["walkForwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=129795268599178",
            ["weight"] = 10
        }
    },
    ["walkForwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=122826043144293",
            ["weight"] = 10
        }
    },
    ["walkBackward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=94557797663581",
            ["weight"] = 10
        }
    },
    ["walkBackwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=77320981048732",
            ["weight"] = 10
        }
    },
    ["walkBackwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=82642118807049",
            ["weight"] = 10
        }
    },
    ["walkRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=96793749633204",
            ["weight"] = 10
        }
    },
    ["walkLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=134163504757606",
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
        for _, v_u_29 in pairs(v23:GetChildren()) do
            if v_u_29:IsA("Animation") then
                local connections_1 = v_u_17[p_u_20].connections
                local Changed = v_u_29.Changed
                local function v32(_)
                    if v_u_14 and v_u_14.Animation == v_u_29 then
                        stopAllAnimations()
                    end
                    configureAnimationSet(p_u_20, p_u_21)
                    task.spawn(move, os.clock())
                end
                table.insert(connections_1, Changed:connect(v32))
                v_u_17[p_u_20][v28] = {}
                v_u_17[p_u_20][v28].anim = v_u_29
                local Weight = v_u_29:FindFirstChild("Weight")
                if Weight == nil then
                    v_u_17[p_u_20][v28].weight = 1
                else
                    v_u_17[p_u_20][v28].weight = Weight.Value
                end
                v_u_17[p_u_20].count = v_u_17[p_u_20].count + 1
                v_u_17[p_u_20].totalWeight = v_u_17[p_u_20].totalWeight + v_u_17[p_u_20][v28].weight
                v28 = v28 + 1
                if v_u_14 and v_u_14.Animation == v_u_29 then
                    stopAllAnimations()
                    playAnimation(p_u_20, 0, Humanoid)
                end
            end
        end
    end
    if v_u_17[p_u_20].count <= 0 then
        for v34, v35 in pairs(p_u_21) do
            v_u_17[p_u_20][v34] = {}
            v_u_17[p_u_20][v34].anim = Instance.new("Animation")
            v_u_17[p_u_20][v34].anim.Name = p_u_20
            v_u_17[p_u_20][v34].anim.AnimationId = v35.id
            v_u_17[p_u_20][v34].weight = v35.weight
            v_u_17[p_u_20].count = v_u_17[p_u_20].count + 1
            v_u_17[p_u_20].totalWeight = v_u_17[p_u_20].totalWeight + v35.weight
        end
    end
end
function scriptChildModified(p36)
    local v37 = v_u_18[p36.Name]
    if v37 ~= nil then
        configureAnimationSet(p36.Name, v37)
    end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
if Humanoid then
    Humanoid:FindFirstChildOfClass("Animator")
end
local v_u_38 = v_u_14
for v39, v40 in pairs(v_u_18) do
    configureAnimationSet(v39, v40)
end
local Value = "None"
local v_u_42 = 0
local v_u_43 = 0
function stopAllAnimations()
    local v44 = v_u_12
    local v45 = v_u_19[v44] ~= nil and v_u_19[v44] == false and "idle" or v44
    v_u_12 = ""
    v_u_13 = nil
    if v_u_15 ~= nil then
        v_u_15:disconnect()
    end
    if v_u_38 ~= nil then
        v_u_38:Stop()
        v_u_38:Destroy()
        v_u_38 = nil
    end
    return v45
end
function setAnimationSpeed(p46)
    if p46 ~= v_u_16 and v_u_38 then
        v_u_16 = p46
        v_u_38:AdjustSpeed(v_u_16)
    end
end
function keyFrameReachedFunc(p47)
    if p47 == "End" then
        local v48 = v_u_12
        local v49 = v_u_19[v48] ~= nil and v_u_19[v48] == false and "idle" or v48
        local v50 = v_u_16
        playAnimation(v49, 0, Humanoid)
        setAnimationSpeed(v50)
    end
end
function playAnimation(p51, p52, p53)
    local weight = math.random(1, v_u_17[p51].totalWeight)
    local v55 = 1
    while v_u_17[p51][v55].weight < weight do
        weight = weight - v_u_17[p51][v55].weight
        v55 = v55 + 1
    end
    local anim = v_u_17[p51][v55].anim
    if anim ~= v_u_13 then
        if v_u_38 ~= nil then
            v_u_38:Stop(p52)
            v_u_38:Destroy()
        end
        local TimePosition = (not (v_u_12:match("walk") or v_u_12:match("run")) or v_u_12 == "stop") and 0 or v_u_38.TimePosition
        v_u_16 = 1
        v_u_38 = p53:LoadAnimation(anim)
        v_u_38.Priority = Enum.AnimationPriority.Core
        v_u_38:Play(p52)
        v_u_38.TimePosition = TimePosition
        v_u_12 = p51
        v_u_13 = anim
        if v_u_15 ~= nil then
            v_u_15:disconnect()
        end
        local v_u_58 = v_u_38:GetMarkerReachedSignal("Step"):Connect(function()
            if v_u_3 == "Walking" and game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
                v_u_7:Shake(m_CameraShaker.Presets.StepShake)
            end
        end)
        v_u_38.Stopped:Once(function()
            v_u_58:Disconnect()
        end)
        v_u_15 = v_u_38.KeyframeReached:connect(keyFrameReachedFunc)
    end
end
local v_u_59 = ""
local v_u_60 = nil
local v_u_61 = nil
local v_u_62 = nil
function toolKeyFrameReachedFunc(p63)
    if p63 == "End" then
        playToolAnimation(v_u_59, 0, Humanoid)
    end
end
function playToolAnimation(p64, p65, p66, p67)
    local weight_0 = math.random(1, v_u_17[p64].totalWeight)
    local v69 = 1
    while v_u_17[p64][v69].weight < weight_0 do
        weight_0 = weight_0 - v_u_17[p64][v69].weight
        v69 = v69 + 1
    end
    local anim_0 = v_u_17[p64][v69].anim
    if v_u_61 ~= anim_0 then
        if v_u_60 ~= nil then
            v_u_60:Stop()
            v_u_60:Destroy()
            p65 = 0
        end
        v_u_60 = p66:LoadAnimation(anim_0)
        if p67 then
            v_u_60.Priority = p67
        end
        v_u_60:Play(p65)
        v_u_59 = p64
        v_u_61 = anim_0
        v_u_62 = v_u_60.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end
function stopToolAnimations()
    local v71 = v_u_59
    if v_u_62 ~= nil then
        v_u_62:disconnect()
    end
    v_u_59 = ""
    v_u_61 = nil
    if v_u_60 ~= nil then
        v_u_60:Stop()
        v_u_60:Destroy()
        v_u_60 = nil
    end
    return v71
end
function onDied()
    v_u_3 = "Dead"
end
function onJumping()
    playAnimation("jump", 0.1, Humanoid)
    v_u_43 = 0.3
    v_u_3 = "Jumping"
end
function onClimbing(p72)
    local v73 = p72 / (not v_u_11 and 1 or Parent:GetScale())
    playAnimation("climb", 0.1, Humanoid)
    setAnimationSpeed(v73 / 12)
    v_u_3 = "Climbing"
end
function onGettingUp()
    v_u_3 = "GettingUp"
end
function onFreeFall()
    if v_u_43 <= 0 then
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
function onSwimming(p74)
    if p74 > 0 then
        v_u_3 = "Running"
    else
        v_u_3 = "Standing"
    end
end
function getTool()
    for _, v75 in ipairs(Parent:GetChildren()) do
        if v75.className == "Tool" then
            return v75
        end
    end
    return nil
end
function getToolAnim(p76)
    for _, v77 in ipairs(p76:GetChildren()) do
        if v77.Name == "toolanim" and v77.className == "StringValue" then
            return v77
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
local v_u_78 = 0
local Health = Humanoid.Health
function move(p80)
    if Parent:HasTag("CantMove") or (Parent:GetAttribute("Stun") == true or (Parent:HasTag("StopAnim") or Parent:HasTag("KillAnims"))) then
        if Parent:HasTag("KillAnims") then
            v_u_3 = "None"
            stopAllAnimations()
        elseif v_u_3 ~= "Standing" then
            v_u_3 = "Standing"
            playAnimation("idle", 0.1, Humanoid)
        end
    else
        local v81 = p80 - v_u_78
        v_u_78 = p80
        if v_u_43 > 0 then
            v_u_43 = v_u_43 - v81
        end
        local Magnitude = (Parent:FindFirstChild("HumanoidRootPart").Velocity * Vector3.new(1, 0, 1)).Magnitude
        if Humanoid.FloorMaterial ~= Enum.Material.Air and (v_u_3 ~= "Stopping" or Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(Humanoid.MoveDirection) > 0.45) then
            if Magnitude > 0.01 and (Magnitude <= 18 and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0)) then
                v_u_7:StopSustained(0.5)
                v_u_3 = "Walking"
            elseif Magnitude > 18 and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
                v_u_3 = "Running"
            elseif v_u_19[v_u_12] == nil and (v_u_3 ~= "Standing" and v_u_3 ~= "Stopping") then
                playAnimation("idle", 0.1, Humanoid)
                v_u_3 = "Standing"
            end
        end
        if v_u_3 == "FreeFall" and v_u_43 <= 0 then
            playAnimation("fall", 0.3, Humanoid)
        else
            if v_u_3 == "Seated" then
                playAnimation("sit", 0.5, Humanoid)
                return
            end
            if v_u_3 == "Walking" then
                local v83 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if Parent:HasTag("Confusion") then
                    v83 = v83 * -1
                end
                if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardRight", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardRight", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardLeft", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardLeft", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkRight", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackward", 0.3, Humanoid)
                elseif v83:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkLeft", 0.3, Humanoid)
                end
                if v_u_38 then
                    v_u_38.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 12)
            elseif v_u_3 == "Running" then
                local v84 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if Parent:HasTag("Confusion") then
                    v84 = v84 * -1
                end
                if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("runForward", 0.3, Humanoid)
                elseif v84:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runLeft", 0.3, Humanoid)
                elseif v84:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runRight", 0.3, Humanoid)
                else
                    playAnimation("runForward", 0.3, Humanoid)
                end
                if v_u_38 then
                    v_u_38.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 24)
            elseif v_u_3 == "Dead" or (v_u_3 == "GettingUp" or (v_u_3 == "FallingDown" or (v_u_3 == "Seated" or v_u_3 == "PlatformStanding"))) then
                stopAllAnimations()
            end
        end
        Health = Humanoid.Health
        local v85 = getTool()
        if v85 and v85:FindFirstChild("Handle") then
            local v86 = getToolAnim(v85)
            if v86 then
                Value = v86.Value
                v86.Parent = nil
                v_u_42 = p80 + 0.3
            end
            if v_u_42 < p80 then
                v_u_42 = 0
                Value = "None"
            end
            animateTool()
        else
            stopToolAnimations()
            Value = "None"
            v_u_61 = nil
            v_u_42 = 0
        end
    end
end
Humanoid.Died:connect(onDied)
stopAllAnimations()
for _, v87 in Humanoid:FindFirstChildOfClass("Animator"):GetPlayingAnimationTracks() do
    v87:Stop()
end
playAnimation("idle", 0.1, Humanoid)
local _ = "Standing"
while Parent.Parent ~= nil do
    local _, v88 = wait()
    move(v88)
end
