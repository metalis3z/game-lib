-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local Humanoid = Parent:WaitForChild("Humanoid")
local _ = Humanoid.MaxHealth / 2
local CurrentCamera = game:GetService("Workspace").CurrentCamera
local m_CameraShaker = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CameraShaker"))
local v_u_6 = m_CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p5)
    if CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
        CurrentCamera.CFrame = CurrentCamera.CFrame * p5
    end
end)
v_u_6:Start()
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Shake"):Connect(function(p7)
    if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
        v_u_6:Shake(m_CameraShaker.Presets[p7])
    end
end)
local _, _ = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v_u_8 = {}
local v_u_9 = {
    ["idle"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 9
        }
    },
    ["runForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=70657718621545",
            ["weight"] = 10
        }
    },
    ["runLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137580550793351",
            ["weight"] = 10
        }
    },
    ["runRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=101226878937977",
            ["weight"] = 10
        }
    },
    ["runForwardCombat"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=132542721243718",
            ["weight"] = 10
        }
    },
    ["runLeftCombat"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=76351620481989",
            ["weight"] = 10
        }
    },
    ["runRightCombat"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=139904700964556",
            ["weight"] = 10
        }
    },
    ["walkForward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=80475763555583",
            ["weight"] = 10
        }
    },
    ["walkForwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=76140894043024",
            ["weight"] = 10
        }
    },
    ["walkForwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=126304435006774",
            ["weight"] = 10
        }
    },
    ["walkBackward"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=128393400521780",
            ["weight"] = 10
        }
    },
    ["walkBackwardLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=125346843608277",
            ["weight"] = 10
        }
    },
    ["walkBackwardRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=88579341644853",
            ["weight"] = 10
        }
    },
    ["walkRight"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=136453403274325",
            ["weight"] = 10
        }
    },
    ["walkLeft"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=107450726687873",
            ["weight"] = 10
        }
    },
    ["jump"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["fall"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["climb"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["sit"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["toolnone"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["toolslash"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    },
    ["toollunge"] = {
        {
            ["id"] = "http://www.roblox.com/asset/?id=137110695807551",
            ["weight"] = 10
        }
    }
}
function configureAnimationSet(p_u_10, p_u_11)
    if v_u_8[p_u_10] ~= nil then
        for _, v12 in pairs(v_u_8[p_u_10].connections) do
            v12:disconnect()
        end
    end
    v_u_8[p_u_10] = {}
    v_u_8[p_u_10].count = 0
    v_u_8[p_u_10].totalWeight = 0
    v_u_8[p_u_10].connections = {}
    local v13 = script:FindFirstChild(p_u_10)
    if v13 ~= nil then
        local connections = v_u_8[p_u_10].connections
        local ChildAdded = v13.ChildAdded
        table.insert(connections, ChildAdded:connect(function(_)
            configureAnimationSet(p_u_10, p_u_11)
        end))
        local connections_0 = v_u_8[p_u_10].connections
        local ChildRemoved = v13.ChildRemoved
        table.insert(connections_0, ChildRemoved:connect(function(_)
            configureAnimationSet(p_u_10, p_u_11)
        end))
        local v18 = 1
        for _, v19 in pairs(v13:GetChildren()) do
            if v19:IsA("Animation") then
                local connections_1 = v_u_8[p_u_10].connections
                local Changed = v19.Changed
                table.insert(connections_1, Changed:connect(function(_)
                    configureAnimationSet(p_u_10, p_u_11)
                    task.spawn(move, os.clock())
                end))
                v_u_8[p_u_10][v18] = {}
                v_u_8[p_u_10][v18].anim = v19
                local Weight = v19:FindFirstChild("Weight")
                if Weight == nil then
                    v_u_8[p_u_10][v18].weight = 1
                else
                    v_u_8[p_u_10][v18].weight = Weight.Value
                end
                v_u_8[p_u_10].count = v_u_8[p_u_10].count + 1
                v_u_8[p_u_10].totalWeight = v_u_8[p_u_10].totalWeight + v_u_8[p_u_10][v18].weight
                v18 = v18 + 1
            end
        end
    end
    if v_u_8[p_u_10].count <= 0 then
        for v23, v24 in pairs(p_u_11) do
            v_u_8[p_u_10][v23] = {}
            v_u_8[p_u_10][v23].anim = Instance.new("Animation")
            v_u_8[p_u_10][v23].anim.Name = p_u_10
            v_u_8[p_u_10][v23].anim.AnimationId = v24.id
            v_u_8[p_u_10][v23].weight = v24.weight
            v_u_8[p_u_10].count = v_u_8[p_u_10].count + 1
            v_u_8[p_u_10].totalWeight = v_u_8[p_u_10].totalWeight + v24.weight
        end
    end
end
function scriptChildModified(p25)
    local v26 = v_u_9[p25.Name]
    if v26 ~= nil then
        configureAnimationSet(p25.Name, v26)
    end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v_u_27 = "Standing"
local v_u_28 = ""
local v_u_29 = {
    ["wave"] = false,
    ["point"] = false,
    ["dance1"] = true,
    ["dance2"] = true,
    ["dance3"] = true,
    ["laugh"] = false,
    ["cheer"] = false
}
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = 1
for v34, v35 in pairs(v_u_9) do
    configureAnimationSet(v34, v35)
end
local Value = "None"
local v_u_37 = 0
local v_u_38 = 0
function stopAllAnimations()
    local v39 = v_u_28
    local v40 = v_u_29[v39] ~= nil and v_u_29[v39] == false and "idle" or v39
    v_u_28 = ""
    v_u_30 = nil
    if v_u_31 ~= nil then
        v_u_31:disconnect()
    end
    if v_u_32 ~= nil then
        v_u_32:Stop()
        v_u_32:Destroy()
        v_u_32 = nil
    end
    return v40
end
function setAnimationSpeed(p41)
    if p41 ~= v_u_33 and v_u_32 then
        v_u_33 = p41
        v_u_32:AdjustSpeed(v_u_33)
    end
end
function keyFrameReachedFunc(p42)
    if p42 == "End" then
        local v43 = v_u_28
        local v44 = v_u_29[v43] ~= nil and v_u_29[v43] == false and "idle" or v43
        local v45 = v_u_33
        playAnimation(v44, 0, Humanoid)
        setAnimationSpeed(v45)
    end
end
local v_u_46 = {}
function playAnimation(p47, p48, p49)
    local weight = math.random(1, v_u_8[p47].totalWeight)
    local v51 = 1
    while v_u_8[p47][v51].weight < weight do
        weight = weight - v_u_8[p47][v51].weight
        v51 = v51 + 1
    end
    local anim = v_u_8[p47][v51].anim
    if anim ~= v_u_30 then
        local TimePosition = (not (v_u_28:match("walk") or v_u_28:match("run")) or v_u_28 == "stop") and 0 or v_u_32.TimePosition
        v_u_33 = 1
        if v_u_32 ~= nil and v_u_32.Animation.AnimationId:match("%d+") ~= v_u_9.idle[1].id:match("%d+") then
            v_u_32:Stop(p48)
            v_u_32:Destroy()
        end
        v_u_32 = v_u_46[anim.AnimationId] or p49:LoadAnimation(anim)
        v_u_32.Priority = v_u_32.Animation.AnimationId:match("%d+") == v_u_9.idle[1].id:match("%d+") and Enum.AnimationPriority.Core or Enum.AnimationPriority.Idle
        if not v_u_46[anim.AnimationId] then
            v_u_46[anim.AnimationId] = v_u_32
        end
        v_u_32:Play(p48)
        v_u_32.TimePosition = TimePosition
        v_u_28 = p47
        v_u_30 = anim
        if v_u_31 ~= nil then
            v_u_31:disconnect()
        end
        local v_u_54 = v_u_32:GetMarkerReachedSignal("Step"):Connect(function()
            if v_u_27 == "Walking" then
                if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
                    v_u_6:Shake(m_CameraShaker.Presets.StepShake)
                    return
                end
            elseif (v_u_27 == "Running" or v_u_27 == "RunningStart") and game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
                v_u_6:Shake(m_CameraShaker.Presets.RunningShake)
            end
        end)
        v_u_32.Stopped:Once(function()
            v_u_54:Disconnect()
        end)
        v_u_31 = v_u_32.KeyframeReached:connect(keyFrameReachedFunc)
    end
end
local v_u_55 = ""
local v_u_56 = nil
local v_u_57 = nil
local v_u_58 = nil
function toolKeyFrameReachedFunc(p59)
    if p59 == "End" then
        playToolAnimation(v_u_55, 0, Humanoid)
    end
end
function playToolAnimation(p60, p61, p62, p63)
    local weight_0 = math.random(1, v_u_8[p60].totalWeight)
    local v65 = 1
    while v_u_8[p60][v65].weight < weight_0 do
        weight_0 = weight_0 - v_u_8[p60][v65].weight
        v65 = v65 + 1
    end
    local anim_0 = v_u_8[p60][v65].anim
    if v_u_57 ~= anim_0 then
        if v_u_56 ~= nil then
            v_u_56:Stop()
            v_u_56:Destroy()
            p61 = 0
        end
        v_u_56 = p62:LoadAnimation(anim_0)
        if p63 then
            v_u_56.Priority = p63
        end
        v_u_56:Play(p61)
        v_u_55 = p60
        v_u_57 = anim_0
        v_u_58 = v_u_56.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end
function stopToolAnimations()
    local v67 = v_u_55
    if v_u_58 ~= nil then
        v_u_58:disconnect()
    end
    v_u_55 = ""
    v_u_57 = nil
    if v_u_56 ~= nil then
        v_u_56:Stop()
        v_u_56:Destroy()
        v_u_56 = nil
    end
    return v67
end
function onDied()
    v_u_27 = "Dead"
end
function onSeated()
    v_u_27 = "Seated"
end
function onPlatformStanding()
    v_u_27 = "PlatformStanding"
end
function onSwimming(p68)
    if p68 > 0 then
        v_u_27 = "Running"
    else
        v_u_27 = "Standing"
    end
end
function getTool()
    for _, v69 in ipairs(Parent:GetChildren()) do
        if v69.className == "Tool" then
            return v69
        end
    end
    return nil
end
function getToolAnim(p70)
    for _, v71 in ipairs(p70:GetChildren()) do
        if v71.Name == "toolanim" and v71.className == "StringValue" then
            return v71
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
local v_u_72 = 0
local Health = Humanoid.Health
function move(p74)
    if Parent:HasTag("CantMove") or (Parent:GetAttribute("Stun") == true or (Parent:HasTag("StopAnim") or Parent:HasTag("KillAnims"))) then
        if Parent:HasTag("KillAnims") then
            v_u_27 = "None"
            stopAllAnimations()
        elseif v_u_27 ~= "Standing" then
            v_u_27 = "Standing"
            playAnimation("idle", 0.1, Humanoid)
        end
    else
        local v75 = p74 - v_u_72
        v_u_72 = p74
        if v_u_38 > 0 then
            v_u_38 = v_u_38 - v75
        end
        local Magnitude = (Parent:FindFirstChild("HumanoidRootPart").Velocity * Vector3.new(1, 0, 1)).Magnitude
        if Humanoid.FloorMaterial ~= Enum.Material.Air and (v_u_27 ~= "Stopping" or Parent:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(Humanoid.MoveDirection) > 0.45) then
            if Magnitude > 0.01 and (Magnitude <= 20 and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0)) then
                v_u_6:StopSustained(0.5)
                v_u_27 = "Walking"
            elseif Magnitude > 20 and Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
                v_u_27 = "Running"
            elseif v_u_29[v_u_28] == nil and (v_u_27 ~= "Standing" and v_u_27 ~= "Stopping") then
                playAnimation("idle", 0.1, Humanoid)
                v_u_27 = "Standing"
            end
        end
        if v_u_27 == "FreeFall" and v_u_38 <= 0 then
            playAnimation("idle", 0.1, Humanoid)
        else
            if v_u_27 == "Seated" then
                playAnimation("sit", 0.5, Humanoid)
                return
            end
            if v_u_27 == "Running" then
                local v77 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if Parent:HasTag("Confusion") then
                    v77 = v77 * -1
                end
                if Parent:GetAttribute("Combat") == true then
                    if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                        playAnimation("runForwardCombat", 0.3, Humanoid)
                    elseif v77:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
                        playAnimation("runLeftCombat", 0.3, Humanoid)
                    elseif v77:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
                        playAnimation("runRightCombat", 0.3, Humanoid)
                    else
                        playAnimation("runForwardCombat", 0.3, Humanoid)
                    end
                elseif game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("runForward", 0.3, Humanoid)
                elseif v77:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runLeft", 0.3, Humanoid)
                elseif v77:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
                    playAnimation("runRight", 0.3, Humanoid)
                else
                    playAnimation("runForward", 0.3, Humanoid)
                end
                if v_u_32 then
                    v_u_32.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 21)
            elseif v_u_27 == "Walking" then
                local v78 = Parent:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(Humanoid.MoveDirection)
                if Parent:HasTag("Confusion") then
                    v78 = v78 * -1
                end
                if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardRight", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardRight", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackwardLeft", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForwardLeft", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
                    playAnimation("walkForward", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkRight", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
                    playAnimation("walkBackward", 0.3, Humanoid)
                elseif v78:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
                    playAnimation("walkLeft", 0.3, Humanoid)
                end
                if v_u_32 then
                    v_u_32.Priority = Enum.AnimationPriority.Movement
                end
                setAnimationSpeed(Magnitude / 13.3)
            elseif v_u_27 == "Dead" or (v_u_27 == "GettingUp" or (v_u_27 == "Seated" or v_u_27 == "PlatformStanding")) then
                stopAllAnimations()
            end
        end
        Health = Humanoid.Health
        local v79 = getTool()
        if v79 and v79:FindFirstChild("Handle") then
            local v80 = getToolAnim(v79)
            if v80 then
                Value = v80.Value
                v80.Parent = nil
                v_u_37 = p74 + 0.3
            end
            if v_u_37 < p74 then
                v_u_37 = 0
                Value = "None"
            end
            animateTool()
        else
            stopToolAnimations()
            Value = "None"
            v_u_57 = nil
            v_u_37 = 0
        end
    end
end
Humanoid.Died:connect(onDied)
playAnimation("idle", 0.1, Humanoid)
local _ = "Standing"
while Parent.Parent ~= nil do
    local _, v81 = wait()
    move(v81)
end
