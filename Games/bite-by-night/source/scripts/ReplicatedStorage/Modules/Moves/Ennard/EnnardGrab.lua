-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p3)
    local v4 = p3[3]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p3[5])
    v4.Priority = Enum.AnimationPriority.Action4
    v4:Play()
    local v5 = p3[2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p3[4])
    v5.Priority = Enum.AnimationPriority.Action4
    v5:Play()
    local v_u_6 = script.VFX:Clone()
    v_u_6.Parent = workspace.IGNORE
    v_u_6:PivotTo(p3[3]:FindFirstChild("HumanoidRootPart").CFrame)
    local v_u_7 = {}
    local v_u_8 = {}
    for _, v9 in v_u_6.VictimTorso:GetChildren() do
        if v9:IsA("Attachment") then
            v9.Parent = p3[3]:FindFirstChild("Torso")
            table.insert(v_u_7, v9)
        end
    end
    for _, v10 in v_u_6.PlayerTorso:GetChildren() do
        if v10:IsA("Attachment") then
            v10.Parent = p3[2]:FindFirstChild("HumanoidRootPart")
            table.insert(v_u_8, v10)
        end
    end
    local v_u_11 = 0
    local v_u_24 = v4:GetMarkerReachedSignal("hit"):Connect(function()
        v_u_11 = v_u_11 + 1
        if v_u_11 == 1 then
            local v12 = v_u_8[1]
            m_EffectUtility.EmitAttachment(v12)
            local v13 = v_u_7[1]
            m_EffectUtility.EmitAttachment(v13)
            m_EffectUtility.ToggleAttachment(v13, true, 0.7)
            local v14 = v_u_8[1]
            m_EffectUtility.TweenBeamTransparency(v14, {
                ["transparency"] = 1,
                ["duration"] = 1,
                ["speed"] = 0,
                ["beamEasingStyle"] = Enum.EasingStyle.Sine,
                ["beamEasingDirection"] = Enum.EasingDirection.Out
            })
            return
        elseif v_u_11 == 3 then
            local v15 = v_u_7[2]
            m_EffectUtility.EmitAttachment(v15)
            m_EffectUtility.ToggleAttachment(v15, true, 0.7)
            local Splatter1 = v_u_6.vfx.Splatter1
            m_EffectUtility.EmitAttachment(Splatter1)
            m_EffectUtility.ToggleAttachment(Splatter1, true, 0.7)
            local v17 = v_u_8[2]
            m_EffectUtility.EmitAttachment(v17)
            return
        elseif v_u_11 == 5 then
            local v18 = v_u_7[3]
            m_EffectUtility.EmitAttachment(v18)
            m_EffectUtility.ToggleAttachment(v18, true, 0.3)
            local Splatter2 = v_u_6.vfx.Splatter2
            m_EffectUtility.EmitAttachment(Splatter2)
            m_EffectUtility.ToggleAttachment(Splatter2, true, 0.5)
            local v20 = v_u_8[3]
            m_EffectUtility.EmitAttachment(v20)
            return
        elseif v_u_11 == 6 then
            local v21 = v_u_7[4]
            m_EffectUtility.EmitAttachment(v21)
            m_EffectUtility.ToggleAttachment(v21, true, 0.5)
        elseif v_u_11 == 7 then
            local v22 = v_u_8[4]
            m_EffectUtility.EmitAttachment(v22)
            local v23 = v_u_8[4]
            m_EffectUtility.TweenBeamTransparency(v23, {
                ["transparency"] = 1,
                ["duration"] = 0.5,
                ["speed"] = 0,
                ["beamEasingStyle"] = Enum.EasingStyle.Sine,
                ["beamEasingDirection"] = Enum.EasingDirection.Out
            })
        end
    end)
    v4.Stopped:Once(function()
        v_u_24:Disconnect()
    end)
end
return v1
