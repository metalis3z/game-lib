-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
require(ReplicatedStorage.Modules.BezierProjectileUtil)
require(ReplicatedStorage.Modules.VFXHandler)
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_4)
    local v5 = next
    local v6, v7 = p_u_4[1][2]:GetDescendants()
    for _, v8 in v5, v6, v7 do
        if v8:IsA("BasePart") then
            v8.LocalTransparencyModifier = v8.Transparency
        end
    end
    local v9 = next
    local v10, v11 = p_u_4[1][1]:GetDescendants()
    for _, v12 in v9, v10, v11 do
        if v12:IsA("BasePart") then
            v12.LocalTransparencyModifier = v12.Transparency
        end
    end
    if p_u_4[1][2]:FindFirstChild("Axe") then
        local v13 = next
        local v14, v15 = p_u_4[1][2].Axe:GetChildren()
        for _, v16 in v13, v14, v15 do
            if v16:IsA("BasePart") then
                v16.LocalTransparencyModifier = 1
            end
        end
    end
    local v_u_17 = script.FinisherSplatter:Clone()
    v_u_17:PivotTo(p_u_4[1][1]:FindFirstChild("HumanoidRootPart").CFrame)
    v_u_17.Parent = workspace.IGNORE
    local v_u_18 = script.FinisherTargetHead:Clone()
    v_u_18.Parent = p_u_4[1][2]:FindFirstChild("Head")
    local v19 = next
    local v20, v21 = script.FinisherEnnard:GetChildren()
    local v_u_22 = {}
    for _, v23 in v19, v20, v21 do
        local v24 = v23:Clone()
        v_u_22[v23.Name] = v24
        v24.Parent = p_u_4[1][1]:FindFirstChild("HumanoidRootPart")
    end
    local v25 = next
    local v26, v27 = script.FinisherTarget:GetChildren()
    local v_u_28 = {}
    for _, v29 in v25, v26, v27 do
        local v30 = v29:Clone()
        v_u_28[v29.Name] = v30
        v30.Parent = p_u_4[1][2]:FindFirstChild("Torso")
    end
    local v31 = p_u_4[1][1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_4[2][1])
    v31.Priority = Enum.AnimationPriority.Action4
    v31:Play()
    local v32 = p_u_4[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_4[2][2])
    v32.Priority = Enum.AnimationPriority.Action4
    v32:Play()
    v32.KeyframeReached:Connect(function(p33)
        if p33 == "vfx1" then
            local v34 = v_u_22["1"]
            m_EffectUtility.EmitAttachment(v34)
            local v35 = v_u_28["1"]
            m_EffectUtility.EmitAttachment(v35)
            return
        elseif p33 == "vfx3" then
            v_u_17:PivotTo(p_u_4[1][1]:FindFirstChild("HumanoidRootPart").CFrame)
            local v36 = v_u_28["2"]
            m_EffectUtility.EmitAttachment(v36)
            m_EffectUtility.ToggleAttachment(v36, true, 0.7)
            m_EffectUtility.EmitAttachment(v_u_22["2"])
            local Splatter1 = v_u_17.Splatter1
            m_EffectUtility.EmitAttachment(Splatter1)
            return
        elseif p33 == "vfx5" then
            local v38 = v_u_28["3"]
            m_EffectUtility.EmitAttachment(v38)
            m_EffectUtility.ToggleAttachment(v38, true, 0.3)
            local Splatter2 = v_u_17.Splatter2
            m_EffectUtility.EmitAttachment(Splatter2)
            m_EffectUtility.ToggleAttachment(Splatter2, true, 0.5)
            local v40 = v_u_22["3"]
            m_EffectUtility.EmitAttachment(v40)
            local v41 = v_u_22["3"]
            m_EffectUtility.TweenBeamTransparency(v41, {
                ["transparency"] = 1,
                ["duration"] = 1,
                ["speed"] = 0,
                ["beamEasingStyle"] = Enum.EasingStyle.Sine,
                ["beamEasingDirection"] = Enum.EasingDirection.Out
            })
            return
        elseif p33 == "vfx6" then
            local v42 = v_u_28["4"]
            m_EffectUtility.EmitAttachment(v42)
            m_EffectUtility.ToggleAttachment(v42, true, 0.5)
        elseif p33 == "vfx7" then
            local v43 = v_u_22["4"]
            m_EffectUtility.EmitAttachment(v43)
            m_EffectUtility.EmitAttachment(v_u_28["5"])
            m_EffectUtility.EmitAttachment(v_u_18)
            m_EffectUtility.ToggleAttachment(v_u_18, true, 0.3)
            local Splatter3 = v_u_17.Splatter3
            m_EffectUtility.EmitAttachment(Splatter3)
        end
    end)
    v31.Stopped:Once(function()
        for _, v45 in next, v_u_22 do
            task.delay(2, v45.Destroy, v45)
        end
        for _, v46 in next, v_u_28 do
            task.delay(2, v46.Destroy, v46)
        end
        task.delay(2, v_u_17.Destroy, v_u_17)
        task.delay(2, v_u_18.Destroy, v_u_18)
    end)
end
return v1
