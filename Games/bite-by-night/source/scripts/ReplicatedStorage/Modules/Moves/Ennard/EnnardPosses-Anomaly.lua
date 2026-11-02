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
    task.delay(10, v_u_6.Destroy, v_u_6)
    local v_u_7 = script.VFX:Clone()
    v_u_7:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    v_u_7.Parent = workspace.IGNORE
    task.delay(10, v_u_7.Destroy, v_u_7)
    local v_u_8 = script:FindFirstChild("Victim"):FindFirstChild("1"):Clone()
    local v_u_9 = script:FindFirstChild("Victim"):FindFirstChild("2"):Clone()
    local v_u_10 = script:FindFirstChild("Victim"):FindFirstChild("3"):Clone()
    local v_u_11 = script:FindFirstChild("Victim"):FindFirstChild("4"):Clone()
    v_u_8.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_9.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_10.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_11.Parent = p_u_3[3]:FindFirstChild("HumanoidRootPart")
    task.delay(10, v_u_8.Destroy, v_u_8)
    task.delay(10, v_u_9.Destroy, v_u_9)
    task.delay(10, v_u_10.Destroy, v_u_10)
    task.delay(10, v_u_11.Destroy, v_u_11)
    v_u_7:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    v5:GetMarkerReachedSignal("Steam"):Once(function()
        m_EffectUtility.EmitAttachment(v_u_6)
        m_EffectUtility.ToggleAttachment(v_u_6, true, 0.4)
    end)
    v5:GetMarkerReachedSignal("vfx1"):Once(function()
        v_u_7:PivotTo(p_u_3[3]:FindFirstChild("HumanoidRootPart").CFrame)
        local v12 = v_u_8
        m_EffectUtility.EmitAttachment(v12)
        m_EffectUtility.ToggleAttachment(v12, true, 0.7)
        local Splatter1 = v_u_7.Splatter1
        m_EffectUtility.EmitAttachment(Splatter1)
        m_EffectUtility.ToggleAttachment(Splatter1, true, 0.7)
        local v14 = v_u_8
        m_EffectUtility.TweenBeamTransparency(v14, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx2"):Once(function()
        local v15 = v_u_9
        m_EffectUtility.EmitAttachment(v15)
        m_EffectUtility.ToggleAttachment(v15, true, 1)
        local Splatter2 = v_u_7.Splatter2
        m_EffectUtility.EmitAttachment(Splatter2)
        m_EffectUtility.ToggleAttachment(Splatter2, true, 1.7)
        local v17 = v_u_9
        m_EffectUtility.TweenBeamTransparency(v17, {
            ["transparency"] = 1,
            ["duration"] = 3,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx3"):Once(function()
        local v18 = v_u_10
        m_EffectUtility.EmitAttachment(v18)
        m_EffectUtility.ToggleAttachment(v18, true, 0.7)
        local v19 = v_u_10
        m_EffectUtility.TweenBeamTransparency(v19, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx4"):Once(function()
        local clank = v_u_7.clank
        m_EffectUtility.EmitAttachment(clank)
        m_EffectUtility.ToggleAttachment(clank, true, 0.7)
    end)
    v5:GetMarkerReachedSignal("vfx5"):Once(function()
        local v21 = v_u_11
        m_EffectUtility.EmitAttachment(v21)
    end)
end
return v1
