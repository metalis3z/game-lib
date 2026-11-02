-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
require(ReplicatedStorage.Modules.BezierProjectileUtil)
require(ReplicatedStorage.Modules.VFXHandler)
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_4)
    task.wait(0.1)
    local v_u_5 = { workspace.PLAYERS, workspace.IGNORE }
    task.spawn(function()
        for _, v6 in game:GetService("Workspace"):GetDescendants() do
            if v6:IsA("Part") and (v6.CanCollide == true and (v6.Transparency < 1 and not (v6:IsDescendantOf(workspace.PLAYERS) or v6:IsDescendantOf(workspace.IGNORE)))) then
                local v7 = v_u_5
                table.insert(v7, v6)
            elseif v6:IsA("MeshPart") and (v6.CanCollide == true and (v6.Transparency < 1 and not (v6:IsDescendantOf(workspace.PLAYERS) or v6:IsDescendantOf(workspace.IGNORE)))) then
                local v8 = v_u_5
                table.insert(v8, v6)
            end
        end
    end)
    local v9 = next
    local v10, v11 = p_u_4[1][2]:GetDescendants()
    for _, v12 in v9, v10, v11 do
        if v12:IsA("BasePart") then
            v12.LocalTransparencyModifier = v12.Transparency
        end
    end
    local v13 = next
    local v14, v15 = p_u_4[1][1]:GetDescendants()
    for _, v16 in v13, v14, v15 do
        if v16:IsA("BasePart") then
            v16.LocalTransparencyModifier = v16.Transparency
        end
    end
    if p_u_4[1][2]:FindFirstChild("Axe") then
        local v17 = next
        local v18, v19 = p_u_4[1][2].Axe:GetChildren()
        for _, v20 in v17, v18, v19 do
            if v20:IsA("BasePart") then
                v20.LocalTransparencyModifier = 1
            end
        end
    end
    local v21 = p_u_4[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_4[2][2])
    local v22 = p_u_4[1][1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_4[2][1])
    v21.Priority = Enum.AnimationPriority.Action4
    v22.Priority = Enum.AnimationPriority.Action4
    v21:Play()
    v22:Play()
    local v_u_23 = p_u_4[1][3]:Clone()
    local v24 = Instance.new("Weld")
    v24.Part0 = p_u_4[1][2]:FindFirstChild("HumanoidRootPart")
    v24.Part1 = v_u_23.PrimaryPart
    v24.C0 = CFrame.new(0, -11, 1.75)
    v24.Parent = v_u_23.PrimaryPart
    v_u_23.Parent = workspace.IGNORE
    v_u_23.AnimationController.Animator:LoadAnimation(p_u_4[2][3]):Play()
    local v_u_25 = script.VFX["1"]:Clone()
    v_u_25.Parent = p_u_4[1][1].RootPart:FindFirstChild("Head", true)
    local v_u_26 = script.VFX.Root1:Clone()
    v_u_26.Parent = p_u_4[1][1].RootPart
    local v_u_27 = script.VFX.Root2:Clone()
    v_u_27.Parent = p_u_4[1][1].RootPart
    local v_u_28 = script.VFX.Torso:Clone()
    v_u_28.Parent = p_u_4[1][2].Torso
    local v_u_29 = script.VFX.Torso2:Clone()
    v_u_29.Parent = p_u_4[1][2].Torso
    local v_u_30 = script.VFX.Torso3:Clone()
    v_u_30.Parent = p_u_4[1][2].Torso
    local v_u_31 = script.VFX.CameraVFX:Clone()
    v22:GetMarkerReachedSignal("Smoke"):Once(function()
        m_EffectUtility.EmitAttachment(v_u_25)
        m_EffectUtility.ToggleAttachment(v_u_25, true, 0.4)
    end)
    v22:GetMarkerReachedSignal("GlitchStart"):Once(function()
        local v32 = v_u_28
        m_EffectUtility.EmitAttachment(v32)
        m_EffectUtility.ToggleAttachment(v32, true, 0.6)
        local v33 = v_u_31
        m_EffectUtility.EmitAttachment(v33)
        m_EffectUtility.ToggleAttachment(v33, true, 0.2)
        local v34 = v_u_28
        m_EffectUtility.TweenBeamTransparency(v34, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v22:GetMarkerReachedSignal("BlackBlood"):Once(function()
        local v35 = v_u_29
        m_EffectUtility.EmitAttachment(v35)
        m_EffectUtility.ToggleAttachment(v35, true, 0.7)
    end)
    v22:GetMarkerReachedSignal("Pulse"):Once(function()
        local v36 = v_u_26
        m_EffectUtility.EmitAttachment(v36)
    end)
    v22:GetMarkerReachedSignal("Glitch2"):Once(function()
        local v37 = v_u_30
        m_EffectUtility.EmitAttachment(v37)
        m_EffectUtility.ToggleAttachment(v37, true, 0.4)
        local v38 = v_u_31
        m_EffectUtility.EmitAttachment(v38)
        m_EffectUtility.ToggleAttachment(v38, true, 0.4)
        for _, v39 in p_u_4[1][2]:GetDescendants() do
            if v39:IsA("BasePart") then
                if not v39:GetAttribute("OGSize") then
                    v39:SetAttribute("OGSize", v39.Size)
                end
                game:GetService("TweenService"):Create(v39, TweenInfo.new(0.75), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }):Play()
            elseif v39:IsA("SpecialMesh") then
                if not v39:GetAttribute("OGSize") then
                    v39:SetAttribute("OGSize", v39.Scale)
                end
                game:GetService("TweenService"):Create(v39, TweenInfo.new(0.75), {
                    ["Scale"] = Vector3.new(0, 0, 0)
                }):Play()
            end
        end
    end)
    v22:GetMarkerReachedSignal("BlackBoom"):Once(function()
        local v40 = v_u_27
        m_EffectUtility.EmitAttachment(v40)
    end)
    v21:GetMarkerReachedSignal("kill"):Once(function()
        p_u_4[1][2]:FindFirstChildOfClass("Humanoid").Health = 0
    end)
    local v_u_41 = nil
    v_u_41 = game:GetService("RunService").PreRender:Connect(function()
        if not (p_u_4[1][2] and p_u_4[1][2]:FindFirstChild("HumanoidRootPart")) then
            v_u_41:Disconnect()
        end
    end)
    if table.find(p_u_4[1], game:GetService("Players").LocalPlayer.Character) then
        v_u_41:Disconnect()
        task.spawn(function()
            local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
            if GameUIContainer then
                local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
                GameUIContainer.Parent = GameUIContainer_0
                GameUIContainer_0.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
                v_u_31.Parent = workspace.IGNORE
                v_u_41 = game:GetService("RunService").PreRender:Connect(function()
                    v_u_31.CFrame = workspace.CurrentCamera.CFrame
                end)
                game:GetService("TweenService"):Create(v_u_31.Attachment.PointLight, TweenInfo.new(1.33, Enum.EasingStyle.Linear), {
                    ["Brightness"] = 4
                }):Play()
                task.delay(3.57, function()
                    game:GetService("TweenService"):Create(v_u_31.Attachment.PointLight, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
                        ["Brightness"] = 0
                    }):Play()
                end)
                local ExposureCompensation = game:GetService("Lighting").ExposureCompensation
                game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(1.33, Enum.EasingStyle.Linear), {
                    ["ExposureCompensation"] = -1
                }):Play()
                task.delay(1.33, function()
                    game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(0.88, Enum.EasingStyle.Linear), {
                        ["ExposureCompensation"] = -2
                    }):Play()
                end)
                task.delay(2.21, function()
                    game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(1.31, Enum.EasingStyle.Linear), {
                        ["ExposureCompensation"] = -1
                    }):Play()
                end)
                task.delay(3.52, function()
                    local v45 = {
                        ["ExposureCompensation"] = ExposureCompensation
                    }
                    game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(0.81, Enum.EasingStyle.Linear), v45):Play()
                end)
                if game:GetService("Players").LocalPlayer.Character.Parent == workspace.PLAYERS.KILLER then
                    task.wait(5.21)
                    game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                        ["GroupTransparency"] = 0
                    }):Play()
                    task.delay(0.5, function()
                        GameUIContainer.Parent = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI")
                    end)
                end
            end
        end)
    end
    v21.Stopped:Once(function()
        if v_u_41 then
            v_u_41:Disconnect()
        end
        v_u_31:Destroy()
        v_u_23:Destroy()
        v_u_26:Destroy()
        v_u_27:Destroy()
        v_u_29:Destroy()
        v_u_28:Destroy()
        v_u_30:Destroy()
        v_u_25:Destroy()
    end)
end
return v1
