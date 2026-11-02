-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
local m_MeshEmit = require(game:GetService("ReplicatedStorage").Modules.MeshEmit)
function v1.Activate(p4)
    local v5, v6, v7, v8 = unpack(p4)
    local v9 = v6[1]:WaitForChild(v6[2])
    local v_u_10 = v5:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v7)
    v_u_10.Priority = Enum.AnimationPriority.Action4
    local v_u_11 = v9:WaitForChild("AnimationController"):WaitForChild("Animator"):LoadAnimation(v8)
    v_u_11.Priority = Enum.AnimationPriority.Action4
    v_u_10:Play(0)
    v_u_11:Play(0)
    for v12 = 0, 1, 0.2 do
        task.delay(v12, function()
            v_u_11.TimePosition = v_u_10.TimePosition
        end)
    end
    local v_u_13 = script.VFX:Clone()
    v_u_13.Parent = workspace.IGNORE
    v_u_13:PivotTo(v5:WaitForChild("HumanoidRootPart").CFrame)
    local v_u_14 = { script:FindFirstChild("1"):Clone(), script:FindFirstChild("2"):Clone(), script:FindFirstChild("3"):Clone() }
    local v_u_15 = { script:FindFirstChild("4"):Clone(), script:FindFirstChild("5"):Clone(), script:FindFirstChild("6"):Clone() }
    for _, v16 in v_u_14 do
        v16.Parent = v5:WaitForChild("Torso")
    end
    for _, v17 in v_u_15 do
        v17.Parent = v5:WaitForChild("Right Arm")
    end
    local v18 = next
    local v19, v20 = script.Minion:GetChildren()
    local v_u_21 = {}
    for _, v22 in v18, v19, v20 do
        v_u_21[v22.Name] = v22:Clone()
        local Master = v9:WaitForChild("Cube.002", 5)
        local v24 = v_u_21[v22.Name]
        if Master then
            Master = Master:WaitForChild("Master", 5)
        end
        v24.Parent = Master
    end
    v_u_11:GetMarkerReachedSignal("Grab"):Once(function()
        local v25 = v_u_14[1]
        m_EffectUtility.EmitAttachment(v25)
        m_EffectUtility.ToggleAttachment(v25, true, 0.5)
        local v26 = v_u_14[1]
        m_EffectUtility.TweenBeamTransparency(v26, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v27 = v_u_14[1]
        m_EffectUtility.EmitAttachment(v27)
        local Splatter1 = v_u_13:FindFirstChild("Splatter1")
        m_EffectUtility.EmitAttachment(Splatter1)
        m_EffectUtility.ToggleAttachment(Splatter1, true, 0.5)
    end)
    v_u_11:GetMarkerReachedSignal("Pull"):Once(function()
        local v29 = v_u_15[1]
        m_EffectUtility.EmitAttachment(v29)
        m_EffectUtility.ToggleAttachment(v29, true, 0.7)
        local v30 = v_u_15[2]
        m_EffectUtility.TweenBeamTransparency(v30, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v31 = v_u_15[2]
        m_EffectUtility.EmitAttachment(v31)
        m_EffectUtility.ToggleAttachment(v31, true, 0.3)
        local v32 = v_u_14[2]
        m_EffectUtility.EmitAttachment(v32)
        for _, v33 in next, v_u_21 do
            local v34 = next
            local v35, v36 = v33:GetChildren()
            for _, v37 in v34, v35, v36 do
                if v37:IsA("Trail") then
                    v37.Enabled = true
                end
            end
        end
    end)
    v_u_11:GetMarkerReachedSignal("Trail"):Once(function()
        local v38 = v_u_15[3]
        m_EffectUtility.EmitAttachment(v38)
    end)
    v_u_11:GetMarkerReachedSignal("Throw"):Once(function()
        local v39 = v_u_14[3]
        m_EffectUtility.TweenBeamTransparency(v39, {
            ["transparency"] = 1,
            ["duration"] = 0.6,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v40 = v_u_14[3]
        m_EffectUtility.EmitAttachment(v40)
        for _, v41 in v_u_13.Mesh.e1:GetDescendants() do
            if v41.Name == "Start" then
                m_MeshEmit(v41, true)
            end
        end
        for _, v42 in next, v_u_21 do
            local v43 = next
            local v44, v45 = v42:GetChildren()
            for _, v46 in v43, v44, v45 do
                if v46:IsA("Trail") then
                    v46.Enabled = false
                end
            end
        end
    end)
    v_u_11.Stopped:Wait()
    task.wait(1)
    for _, v47 in next, v_u_14 do
        v47:Destroy()
    end
    for _, v48 in next, v_u_15 do
        v48:Destroy()
    end
    for _, v49 in next, v_u_21 do
        v49:Destroy()
    end
    v_u_13:Destroy()
end
return v1
