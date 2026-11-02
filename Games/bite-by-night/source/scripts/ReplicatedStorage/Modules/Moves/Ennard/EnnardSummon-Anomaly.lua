-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    local v_u_4 = p_u_3[1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[2])
    v_u_4.Priority = Enum.AnimationPriority.Action4
    v_u_4:Play()
    local v_u_5 = script:FindFirstChild("1"):Clone()
    v_u_5.Parent = p_u_3[1]:FindFirstChild("RootPart")
    local v_u_6 = script:FindFirstChild("2"):Clone()
    v_u_6.Parent = p_u_3[1]:FindFirstChild("RootPart")
    local v_u_7 = script:FindFirstChild("3"):Clone()
    v_u_7.Parent = p_u_3[1]:FindFirstChild("RootPart"):FindFirstChild("Spine3", true)
    local v_u_8 = script.vfx:Clone()
    v_u_8:PivotTo(p_u_3[1]:FindFirstChild("HumanoidRootPart").CFrame)
    v_u_8.Parent = workspace.IGNORE
    task.delay(10, v_u_8.Destroy, v_u_8)
    v_u_4:GetMarkerReachedSignal("vfx1"):Once(function()
        v_u_8:PivotTo(p_u_3[1]:FindFirstChild("HumanoidRootPart").CFrame)
        local v9 = v_u_7
        m_EffectUtility.EmitAttachment(v9)
        m_EffectUtility.ToggleAttachment(v9, true, 1)
        local stuf = v_u_8.vfx:FindFirstChild("stuf")
        m_EffectUtility.EmitAttachment(stuf)
        m_EffectUtility.ToggleAttachment(stuf, true, 1)
    end)
    v_u_4:GetMarkerReachedSignal("vfx2"):Once(function()
        local v11 = v_u_5
        m_EffectUtility.EmitAttachment(v11)
        local v12 = v_u_5
        m_EffectUtility.TweenBeamTransparency(v12, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v_u_4:GetMarkerReachedSignal("vfx3"):Once(function()
        local v13 = v_u_6
        m_EffectUtility.EmitAttachment(v13)
    end)
    local v_u_14 = nil
    v_u_14 = p_u_3[1]:GetAttributeChangedSignal("InAbility"):Connect(function()
        if p_u_3[1]:GetAttribute("InAbility") == false then
            v_u_4:Stop()
            v_u_14:Disconnect()
        end
    end)
    v_u_4.Stopped:Once(function()
        v_u_8:Destroy()
        v_u_5:Destroy()
        v_u_6:Destroy()
        v_u_7:Destroy()
        v_u_14:Disconnect()
    end)
end
return v1
