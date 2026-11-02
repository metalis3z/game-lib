-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p3)
    local v4, v5, v6, v7 = unpack(p3)
    local v8 = v5[1]:WaitForChild(v5[2])
    local v_u_9 = v4:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v6)
    v_u_9.Priority = Enum.AnimationPriority.Action4
    local v_u_10 = v8:WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(v7)
    v_u_10.Priority = Enum.AnimationPriority.Action4
    v_u_9:Play(0)
    v_u_10:Play(0)
    for v11 = 0, 1, 0.2 do
        task.delay(v11, function()
            v_u_10.TimePosition = v_u_9.TimePosition
        end)
    end
    local v_u_12 = script.TorsoEffect:Clone()
    v_u_12.Parent = v4:FindFirstChild("Torso")
    local v_u_13 = script.Splatter1:Clone()
    v_u_13.Parent = workspace.IGNORE
    local v14 = Instance.new("Weld")
    v14.Part0 = v4:FindFirstChild("HumanoidRootPart")
    v14.Part1 = v_u_13
    v14.C0 = CFrame.new(0, -2.5, -2)
    v14.Parent = v_u_13
    local v15 = next
    local v16, v17 = script.RootPartAttachments:GetChildren()
    local v_u_18 = {}
    for _, v19 in v15, v16, v17 do
        v_u_18[v19.Name] = v19:Clone()
        v_u_18[v19.Name].Parent = v4:FindFirstChild("HumanoidRootPart")
    end
    local v20 = next
    local v21, v22 = script.RightArmAttachments:GetChildren()
    local v_u_23 = {}
    for _, v24 in v20, v21, v22 do
        v_u_23[v24.Name] = v24:Clone()
        v_u_23[v24.Name].Parent = v4:FindFirstChild("Right Arm")
    end
    local v25 = next
    local v26, v27 = script.MinionTrail:GetChildren()
    local v_u_28 = {}
    for _, v29 in v25, v26, v27 do
        v_u_28[v29.Name] = v29:Clone()
        local Master = v8:WaitForChild("Cube.002", 5)
        local v31 = v_u_28[v29.Name]
        if Master then
            Master = Master:WaitForChild("Master", 5)
        end
        v31.Parent = Master
    end
    v_u_10:GetMarkerReachedSignal("Grab"):Once(function()
        v_u_12.l2.PointLight.Enabled = true
        local v32 = v_u_12
        m_EffectUtility.EmitAttachment(v32)
        m_EffectUtility.ToggleAttachment(v32, true, 0.5)
        local v33 = v_u_12
        m_EffectUtility.TweenBeamTransparency(v33, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v34 = v_u_18["1"]
        m_EffectUtility.EmitAttachment(v34)
        local v35 = v_u_13
        m_EffectUtility.EmitAttachment(v35)
        m_EffectUtility.ToggleAttachment(v35, true, 0.5)
    end)
    v_u_10:GetMarkerReachedSignal("Pull"):Once(function()
        local v36 = v_u_23["1"]
        m_EffectUtility.EmitAttachment(v36)
        m_EffectUtility.ToggleAttachment(v36, true, 0.7)
        local v37 = v_u_18["2"]
        m_EffectUtility.TweenBeamTransparency(v37, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v38 = v_u_23["2"]
        m_EffectUtility.EmitAttachment(v38)
        m_EffectUtility.ToggleAttachment(v38, true, 0.3)
        local v39 = v_u_18["2"]
        m_EffectUtility.EmitAttachment(v39)
        for _, v40 in next, v_u_28 do
            local v41 = next
            local v42, v43 = v40:GetChildren()
            for _, v44 in v41, v42, v43 do
                if v44:IsA("Trail") then
                    v44.Enabled = true
                end
            end
        end
    end)
    v_u_10:GetMarkerReachedSignal("Trail"):Once(function()
        v_u_12.l2.PointLight.Enabled = false
        local v45 = v_u_23["3"]
        m_EffectUtility.EmitAttachment(v45)
    end)
    v_u_10:GetMarkerReachedSignal("Throw"):Once(function()
        local v46 = v_u_18["3"]
        m_EffectUtility.TweenBeamTransparency(v46, {
            ["transparency"] = 1,
            ["duration"] = 0.6,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v47 = v_u_18["3"]
        m_EffectUtility.EmitAttachment(v47)
        for _, v48 in next, v_u_28 do
            local v49 = next
            local v50, v51 = v48:GetChildren()
            for _, v52 in v49, v50, v51 do
                if v52:IsA("Trail") then
                    v52.Enabled = false
                end
            end
        end
    end)
    v_u_10.Stopped:Wait()
    task.wait(1)
    v_u_12:Destroy()
    v_u_13:Destroy()
    for _, v53 in next, v_u_18 do
        v53:Destroy()
    end
    for _, v54 in next, v_u_23 do
        v54:Destroy()
    end
    for _, v55 in next, v_u_28 do
        v55:Destroy()
    end
end
return v1
