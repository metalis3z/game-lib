-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    task.wait(0.1)
    local v_u_4 = p_u_3[1][2]
    local v_u_5 = script.VFX.CameraVFX:Clone()
    local v_u_6 = script.VFX.root:Clone()
    v_u_6.Parent = p_u_3[1][1]:FindFirstChild("HumanoidRootPart")
    local v_u_7 = script.VFX.torso:Clone()
    v_u_7.Parent = p_u_3[1][1]:FindFirstChild("Torso")
    local v_u_8 = script.VFX.rightArm:Clone()
    v_u_8.Parent = p_u_3[1][1]:FindFirstChild("Right Arm")
    local v_u_9 = script.VFX.leftArm:Clone()
    v_u_9.Parent = p_u_3[1][1]:FindFirstChild("Left Arm")
    local v10 = p_u_3[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[2][2])
    local v11 = p_u_3[1][1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[2][1])
    v10.Priority = Enum.AnimationPriority.Action4
    v11.Priority = Enum.AnimationPriority.Action4
    v10:Play()
    v11:Play()
    if p_u_3[1][2]:FindFirstChild("Axe") then
        local v12 = next
        local v13, v14 = p_u_3[1][2].Axe:GetChildren()
        for _, v15 in v12, v13, v14 do
            if v15:IsA("BasePart") then
                v15.LocalTransparencyModifier = 1
            end
        end
    end
    v11:GetMarkerReachedSignal("vfx1"):Once(function()
        local v16 = v_u_5
        m_EffectUtility.EmitAttachment(v16)
        m_EffectUtility.ToggleAttachment(v16, true, 0.2)
        local v17 = v_u_6
        m_EffectUtility.EmitAttachment(v17)
    end)
    v11:GetMarkerReachedSignal("vfx2"):Once(function()
        local v18 = v_u_5
        m_EffectUtility.EmitAttachment(v18)
        m_EffectUtility.ToggleAttachment(v18, true, 0.5)
    end)
    v11:GetMarkerReachedSignal("vfx3"):Once(function()
        local v19 = v_u_9
        m_EffectUtility.EmitAttachment(v19)
        m_EffectUtility.ToggleAttachment(v19, true, 0.4)
        local v20 = v_u_8
        m_EffectUtility.EmitAttachment(v20)
        m_EffectUtility.ToggleAttachment(v20, true, 0.4)
        local v21 = v_u_7
        m_EffectUtility.EmitAttachment(v21)
        m_EffectUtility.ToggleAttachment(v21, true, 1)
    end)
    local v_u_22 = nil
    v11.Stopped:Once(function()
        if v_u_22 then
            v_u_22:Disconnect()
        end
        v_u_6:Destroy()
        v_u_5:Destroy()
        v_u_7:Destroy()
        v_u_9:Destroy()
        v_u_8:Destroy()
    end)
    v_u_22 = game:GetService("RunService").PreRender:Connect(function()
        if not (p_u_3[1][2] and p_u_3[1][2]:FindFirstChild("HumanoidRootPart")) then
            v_u_22:Disconnect()
        end
    end)
    if table.find(p_u_3[1], game:GetService("Players").LocalPlayer.Character) then
        for _, v23 in v_u_4:GetDescendants() do
            if v23:IsA("Accessory") then
                for _, v24 in v23:GetDescendants() do
                    if v24:IsA("BasePart") then
                        v24:SetAttribute("OGTRANS", v24.Transparency)
                        v24.Transparency = 1
                    end
                end
            end
        end
        v_u_4:FindFirstChild("Head"):SetAttribute("OGTRANS", v_u_4:FindFirstChild("Head").Transparency)
        v_u_4:FindFirstChild("Head").Transparency = 1
        v_u_5.Parent = workspace.IGNORE
        v_u_22 = game:GetService("RunService").PreRender:Connect(function()
            v_u_5.CFrame = workspace.CurrentCamera.CFrame
        end)
        local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
        local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
        if GameUIContainer then
            GameUIContainer.Parent = GameUIContainer_0
            GameUIContainer_0.GroupTransparency = 0
            game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                ["GroupTransparency"] = 1
            }):Play()
        end
        local l1 = v_u_5:FindFirstChild("1"):FindFirstChild("l1")
        local l2 = v_u_5:FindFirstChild("1"):FindFirstChild("l2")
        l1:FindFirstChild("SpotLight").Enabled = false
        l2:FindFirstChild("SpotLight").Enabled = false
        task.delay(1.92, function()
            l1:FindFirstChild("SpotLight").Enabled = true
            l2:FindFirstChild("SpotLight").Enabled = true
            l1:FindFirstChild("SpotLight").Brightness = 0
            l2:FindFirstChild("SpotLight").Brightness = 0
            game:GetService("TweenService"):Create(l1:FindFirstChild("SpotLight"), TweenInfo.new(0.39, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Brightness"] = 12
            }):Play()
            game:GetService("TweenService"):Create(l2:FindFirstChild("SpotLight"), TweenInfo.new(0.39, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["Brightness"] = 12
            }):Play()
            game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(0.43, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["ExposureCompensation"] = -3
            }):Play()
        end)
        task.delay(2.21, function()
            l1:FindFirstChild("SpotLight").Enabled = false
            l2:FindFirstChild("SpotLight").Enabled = false
        end)
        task.delay(2.25, function()
            l1:FindFirstChild("SpotLight").Enabled = true
            l2:FindFirstChild("SpotLight").Enabled = true
        end)
        task.delay(2.27, function()
            l1:FindFirstChild("SpotLight").Enabled = false
            l2:FindFirstChild("SpotLight").Enabled = false
        end)
        task.delay(2.31, function()
            l1:FindFirstChild("SpotLight").Enabled = true
            l2:FindFirstChild("SpotLight").Enabled = true
        end)
        task.delay(2.33, function()
            l1:FindFirstChild("SpotLight").Enabled = false
            l2:FindFirstChild("SpotLight").Enabled = false
        end)
        task.delay(2.84, function()
            l1:FindFirstChild("SpotLight").Enabled = true
            l2:FindFirstChild("SpotLight").Enabled = true
        end)
        task.delay(2.86, function()
            l1:FindFirstChild("SpotLight").Enabled = false
            l2:FindFirstChild("SpotLight").Enabled = false
        end)
        task.delay(2.87, function()
            l1:FindFirstChild("SpotLight").Enabled = true
            l2:FindFirstChild("SpotLight").Enabled = true
        end)
        task.delay(5.24, function()
            if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") ~= "Lobby" then
                game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
            end
            for _, v29 in v_u_4:GetDescendants() do
                if v29:IsA("Accessory") then
                    for _, v30 in v29:GetDescendants() do
                        if v30:IsA("BasePart") then
                            v30.Transparency = v30:GetAttribute("OGTRANS")
                        end
                    end
                end
            end
            v_u_4:FindFirstChild("Head").Transparency = v_u_4:FindFirstChild("Head"):GetAttribute("OGTRANS")
        end)
    end
end
return v1
