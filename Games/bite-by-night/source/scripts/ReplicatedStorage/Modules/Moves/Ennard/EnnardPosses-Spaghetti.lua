-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    p_u_3[3] = p_u_3[3][1]:WaitForChild(p_u_3[3][2], 8)
    local v4 = p_u_3[3]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[5])
    v4.Priority = Enum.AnimationPriority.Action4
    v4:Play()
    local v5 = p_u_3[2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[4])
    v5.Priority = Enum.AnimationPriority.Action4
    v5:Play()
    p_u_3[3]:PivotTo(p_u_3[2]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0.421, -0.909, -4.124))
    local v_u_6 = script:FindFirstChild("1"):Clone()
    v_u_6.Parent = p_u_3[2]:FindFirstChild("RootPart"):FindFirstChild("Head", true)
    task.delay(50, v_u_6.Destroy, v_u_6)
    local v7 = script:FindFirstChild("2"):Clone()
    v7.Parent = p_u_3[2]:FindFirstChild("RootPart")
    task.delay(10, v7.Destroy, v7)
    local v_u_8 = script:FindFirstChild("3"):Clone()
    v7.Parent = p_u_3[2]:FindFirstChild("RootPart")
    task.delay(10, v_u_8.Destroy, v_u_8)
    local v_u_9 = script.VFX:Clone()
    v_u_9:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    v_u_9.Parent = workspace.IGNORE
    task.delay(10, v_u_9.Destroy, v_u_9)
    local v_u_10 = script:FindFirstChild("Victim"):FindFirstChild("1"):Clone()
    local v_u_11 = script:FindFirstChild("Victim"):FindFirstChild("2"):Clone()
    local v_u_12 = script:FindFirstChild("Victim"):FindFirstChild("3"):Clone()
    local v_u_13 = script:FindFirstChild("Victim"):FindFirstChild("4"):Clone()
    v_u_10.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_11.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_12.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_13.Parent = p_u_3[3]:FindFirstChild("HumanoidRootPart")
    task.delay(10, v_u_10.Destroy, v_u_10)
    task.delay(10, v_u_11.Destroy, v_u_11)
    task.delay(10, v_u_12.Destroy, v_u_12)
    task.delay(10, v_u_13.Destroy, v_u_13)
    v_u_9:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    m_EffectUtility.EmitAttachment(v_u_6)
    m_EffectUtility.ToggleAttachment(v_u_6, true, 0.7)
    m_EffectUtility.EmitAttachment(v7)
    m_EffectUtility.ToggleAttachment(v7, true, 0.4)
    local Splatter3 = v_u_9:FindFirstChild("Splatter3")
    m_EffectUtility.EmitAttachment(Splatter3)
    m_EffectUtility.ToggleAttachment(Splatter3, true, 0.5)
    task.delay(0.28, function()
        local v15 = v_u_8
        m_EffectUtility.EmitAttachment(v15)
    end)
    v5:GetMarkerReachedSignal("Steam"):Once(function()
        m_EffectUtility.EmitAttachment(v_u_6)
        m_EffectUtility.ToggleAttachment(v_u_6, true, 0.4)
    end)
    v5:GetMarkerReachedSignal("vfx1"):Once(function()
        v_u_9:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
        local v16 = v_u_10
        m_EffectUtility.EmitAttachment(v16)
        m_EffectUtility.ToggleAttachment(v16, true, 0.7)
        local Splatter1 = v_u_9.Splatter1
        m_EffectUtility.EmitAttachment(Splatter1)
        m_EffectUtility.ToggleAttachment(Splatter1, true, 0.7)
        local v18 = v_u_10
        m_EffectUtility.TweenBeamTransparency(v18, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx2"):Once(function()
        local v19 = v_u_11
        m_EffectUtility.EmitAttachment(v19)
        m_EffectUtility.ToggleAttachment(v19, true, 1)
        local Splatter2 = v_u_9.Splatter2
        m_EffectUtility.EmitAttachment(Splatter2)
        m_EffectUtility.ToggleAttachment(Splatter2, true, 1.7)
        local v21 = v_u_11
        m_EffectUtility.TweenBeamTransparency(v21, {
            ["transparency"] = 1,
            ["duration"] = 3,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx3"):Once(function()
        local v22 = v_u_12
        m_EffectUtility.EmitAttachment(v22)
        m_EffectUtility.ToggleAttachment(v22, true, 0.7)
        local v23 = v_u_12
        m_EffectUtility.TweenBeamTransparency(v23, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx4"):Once(function()
        local clank = v_u_9.clank
        m_EffectUtility.EmitAttachment(clank)
        m_EffectUtility.ToggleAttachment(clank, true, 0.7)
    end)
    v5:GetMarkerReachedSignal("vfx5"):Once(function()
        local v25 = v_u_13
        m_EffectUtility.EmitAttachment(v25)
    end)
end
return v1
