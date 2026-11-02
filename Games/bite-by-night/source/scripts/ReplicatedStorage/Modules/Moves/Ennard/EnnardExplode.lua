-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    p_u_3[3] = p_u_3[3][1]:WaitForChild(p_u_3[3][2], 8)
    p_u_3[4] = p_u_3[4][1]:WaitForChild(p_u_3[4][2], 8)
    local v4 = p_u_3[4]:FindFirstChildOfClass("AnimationController"):WaitForChild("Animator"):LoadAnimation(p_u_3[7])
    v4.Priority = Enum.AnimationPriority.Action4
    v4:Play()
    local v5 = p_u_3[3]:WaitForChild("Humanoid"):LoadAnimation(p_u_3[6])
    v5.Priority = Enum.AnimationPriority.Action4
    v5:Play()
    local v6 = p_u_3[2][1]:WaitForChild("Humanoid"):LoadAnimation(p_u_3[5])
    v6.Priority = Enum.AnimationPriority.Action4
    v6:Play()
    if table.find(p_u_3[1], game:GetService("Players").LocalPlayer) then
        workspace.CurrentCamera.CameraSubject = p_u_3[3]:FindFirstChild("Head")
    end
    local v_u_7 = script:FindFirstChild("1_HeadEffectAttachment"):Clone()
    local v_u_8 = script["1"]:Clone()
    task.delay(5, v_u_8.Destroy, v_u_8)
    local v_u_9 = script.thing1:Clone()
    v_u_9.Parent = workspace.IGNORE
    task.delay(5, v_u_9.Destroy, v_u_9)
    local v_u_10 = script.thing2:Clone()
    v_u_10.Parent = workspace.IGNORE
    task.delay(5, v_u_10.Destroy, v_u_10)
    for _, v11 in next, { v_u_9, v_u_10 } do
        local v12 = next
        local v13, v14 = v11:GetChildren()
        for _, v15 in v12, v13, v14 do
            if v15:IsA("BasePart") then
                v15.Massless = true
                v15.Anchored = false
                local v16 = p_u_3[3]:FindFirstChild(v15.Name)
                if v16 then
                    local v17 = Instance.new("Weld")
                    v17.Part0 = v16
                    v17.Part1 = v15
                    v17.Parent = v15
                end
            end
        end
    end
    local v_u_18 = script.VFX:Clone()
    v_u_18:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    v_u_18.Parent = workspace.IGNORE
    task.delay(5, v_u_18.Destroy, v_u_18)
    v6:GetMarkerReachedSignal("vfx1"):Once(function()
        m_EffectUtility.EmitAttachment(v_u_9)
        m_EffectUtility.ToggleAttachment(v_u_9, true, 0.4)
    end)
    v6:GetMarkerReachedSignal("vfx2"):Once(function()
        m_EffectUtility.EmitAttachment(v_u_10)
        m_EffectUtility.ToggleAttachment(v_u_10, true, 0.2)
        m_EffectUtility.EmitAttachment(v_u_18)
        m_EffectUtility.ToggleAttachment(v_u_18, true, 0.8)
    end)
    local Parent = p_u_3[2][1].Parent
    v6:GetMarkerReachedSignal("vfx3"):Once(function()
        if table.find(p_u_3[1], game:GetService("Players").LocalPlayer) then
            workspace.CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        end
        v_u_8.Parent = workspace.Terrain
        v_u_8.WorldPosition = (Parent:WaitForChild(p_u_3[2][1].Name):FindFirstChild("RootPart") or Parent:WaitForChild(p_u_3[2][1].Name):FindFirstChild("HumanoidRootPart")).Position
        m_EffectUtility.EmitAttachment(v_u_8)
    end)
    v6:GetMarkerReachedSignal("vfx4"):Once(function()
        local v20 = Parent:WaitForChild(p_u_3[2][1].Name)
        local v21 = v20:FindFirstChild("RootPart")
        if v21 then
            v21 = v20.RootPart:FindFirstChild("Head", true)
        end
        if v21 then
            v21 = v21.WorldPosition
        end
        if not v21 then
            v21 = v20:FindFirstChild("Head")
            if v21 then
                v21 = v20.Head.Position
            end
        end
        v_u_7.WorldPosition = v21
        v_u_7.Parent = workspace.Terrain
        m_EffectUtility.ToggleAttachment(v_u_7, true, 0.3)
    end)
    v6:GetMarkerReachedSignal("vfx5"):Once(function() end)
    v6.Stopped:Wait()
    if table.find(p_u_3[1], game:GetService("Players").LocalPlayer) then
        workspace.CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end
return v1
