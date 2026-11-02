-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    local v4 = p_u_3[3]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[5])
    v4.Priority = Enum.AnimationPriority.Action4
    v4:Play()
    local v5 = p_u_3[2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[4])
    v5.Priority = Enum.AnimationPriority.Action4
    v5:Play()
    local v_u_6 = script:FindFirstChild("PlayerVFX"):Clone()
    v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
    v_u_6.Parent = workspace.IGNORE
    local v_u_7 = script:FindFirstChild("Victim"):FindFirstChild("1"):Clone()
    local v_u_8 = script:FindFirstChild("Victim"):FindFirstChild("2"):Clone()
    v_u_7.Parent = p_u_3[3]:FindFirstChild("Torso")
    v_u_8.Parent = p_u_3[3]:FindFirstChild("Torso")
    v5:GetMarkerReachedSignal("vfx1"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local v9 = v_u_6:FindFirstChild("Player"):FindFirstChild("arm"):Clone()
        v9.Parent = p_u_3[2]:FindFirstChild("RootPart"):FindFirstChild("Forearm.L.001", true)
        m_EffectUtility.EmitAttachment(v9)
        m_EffectUtility.ToggleAttachment(v9, true, 0.5)
        local v10 = v_u_6:FindFirstChild("Player")["1"]
        m_EffectUtility.EmitAttachment(v10)
        m_EffectUtility.TweenBeamTransparency(v10, {
            ["transparency"] = 1,
            ["duration"] = 0.5,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx2"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local v11 = v_u_6:FindFirstChild("Player")["2"]
        m_EffectUtility.EmitAttachment(v11)
    end)
    v5:GetMarkerReachedSignal("vfx3"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local v12 = v_u_6:FindFirstChild("Player")["3"]
        m_EffectUtility.EmitAttachment(v12)
        local Splatter = v_u_6.Splatter
        m_EffectUtility.EmitAttachment(Splatter)
        m_EffectUtility.ToggleAttachment(Splatter, true, 0.6)
        task.spawn(function()
            m_EffectUtility.EmitAttachment(v_u_7)
            m_EffectUtility.ToggleAttachment(v_u_7, true, 0.6)
            m_EffectUtility.EmitAttachment(v_u_8)
            m_EffectUtility.ToggleAttachment(v_u_8, true, 1.5)
        end)
        local v14 = v_u_6:FindFirstChild("Player")["3"]
        m_EffectUtility.TweenBeamTransparency(v14, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx4"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local v15 = v_u_6:FindFirstChild("Player")["4"]
        m_EffectUtility.EmitAttachment(v15)
        local v16 = v_u_6:FindFirstChild("Player")["4"]
        m_EffectUtility.TweenBeamTransparency(v16, {
            ["transparency"] = 1,
            ["duration"] = 0.7,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v5:GetMarkerReachedSignal("vfx5"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local pre1 = v_u_6.pre1
        m_EffectUtility.EmitAttachment(pre1)
        m_EffectUtility.ToggleAttachment(pre1, true, 0.2)
    end)
    v5:GetMarkerReachedSignal("vfx6"):Connect(function()
        v_u_6:PivotTo(p_u_3[2]:FindFirstChild("RootPart").CFrame)
        local v18 = v_u_6:FindFirstChild("Player")["5"]
        m_EffectUtility.EmitAttachment(v18)
        local v19 = v_u_6:FindFirstChild("Player")["5"]
        m_EffectUtility.TweenBeamTransparency(v19, {
            ["transparency"] = 1,
            ["duration"] = 0.7,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
end
return v1
