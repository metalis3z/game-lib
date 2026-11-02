-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local m_BezierProjectileUtil = require(ReplicatedStorage.Modules.BezierProjectileUtil)
local m_VFXHandler = require(ReplicatedStorage.Modules.VFXHandler)
function castRay(p5, p6, p7)
    local v8 = RaycastParams.new()
    v8.FilterType = Enum.RaycastFilterType.Include
    v8.FilterDescendantsInstances = p5
    local v9 = workspace:Raycast(p6, p7, v8)
    local v10 = v9 and v9.Position or p6 + p7
    return (p6 - v10).Magnitude, p6, v10, v9
end

function v1.Activate(p_u_11)
	warn(p_u_11)
	
    task.wait(0.1)
    local v_u_12 = { workspace.PLAYERS, workspace.Terrain }
    task.spawn(function()
        for _, v13 in game:GetService("Workspace"):GetDescendants() do
            if v13:IsA("Part") and (v13.CanCollide == true and (v13.Transparency < 1 and not (v13:IsDescendantOf(workspace.PLAYERS) or v13:IsDescendantOf(workspace.IGNORE)))) then
                local v14 = v_u_12
                table.insert(v14, v13)
            elseif v13:IsA("MeshPart") and (v13.CanCollide == true and (v13.Transparency < 1 and not (v13:IsDescendantOf(workspace.PLAYERS) or v13:IsDescendantOf(workspace.IGNORE)))) then
                local v15 = v_u_12
                table.insert(v15, v13)
            end
        end
    end)
    local v16 = p_u_11[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_11[2])
    v16.Priority = Enum.AnimationPriority.Action4
    v16:Play()
    local v17 = next
    local v18, v19 = p_u_11[1][2]:GetDescendants()
    for _, v20 in v17, v18, v19 do
        if v20:IsA("BasePart") then
            v20.LocalTransparencyModifier = v20.Transparency
        end
    end
    local v21 = next
    local v22, v23 = p_u_11[1][1]:GetDescendants()
    for _, v24 in v21, v22, v23 do
        if v24:IsA("BasePart") then
            v24.LocalTransparencyModifier = v24.Transparency
        end
    end
    if p_u_11[1][2]:FindFirstChild("Axe") then
        local v25 = next
        local v26, v27 = p_u_11[1][2].Axe:GetChildren()
        for _, v28 in v25, v26, v27 do
            if v28:IsA("BasePart") then
                v28.LocalTransparencyModifier = 1
            end
        end
    end
    local v_u_29 = script.VFX.cameraVFX:Clone()
    local v_u_30 = script.VFX.KillVFX:Clone()
    v_u_29.Parent = workspace.IGNORE
    v_u_30.Parent = workspace.IGNORE
    task.delay(30, v_u_29.Destroy, v_u_29)
    task.delay(30, v_u_30.Destroy, v_u_30)
    local v_u_31 = nil
    v_u_31 = game:GetService("RunService").PreRender:Connect(function()
        if p_u_11[1][2] and p_u_11[1][2]:FindFirstChild("HumanoidRootPart") then
            v_u_30:PivotTo(p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame)
        else
            v_u_31:Disconnect()
        end
    end)
    local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
    if table.find(p_u_11[1], game:GetService("Players").LocalPlayer.Character) then
        task.spawn(function()
            local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
            GameUIContainer.Parent = GameUIContainer_0
            if GameUIContainer then
                GameUIContainer_0.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
            end
            task.delay(1.52, function()
                for _, v_u_34 in v_u_29.staticfx:GetDescendants() do
                    if v_u_34:IsA("ParticleEmitter") then
                        v_u_34.Enabled = true
                        task.delay(0.6, function()
                            v_u_34.Enabled = false
                        end)
                    end
                end
            end)
            v_u_31 = game:GetService("RunService").PreRender:Connect(function()
                v_u_30:PivotTo(p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame)
                v_u_29.CFrame = workspace.CurrentCamera.CFrame
            end)
            if game:GetService("Players").LocalPlayer.Character.Parent == workspace.PLAYERS.KILLER then
                task.wait(4.15)
                if GameUIContainer then
                    game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                        ["GroupTransparency"] = 0
                    }):Play()
                    task.delay(0.5, function()
                        GameUIContainer.Parent = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI")
                    end)
                end
            end
        end)
    end
    local v_u_35 = v_u_31
    local v_u_36 = 0
    for _, v37 in ipairs(v_u_30.hit1:GetDescendants()) do
        if v37:IsA("ParticleEmitter") then
            v37:Emit(v37:GetAttribute("EmitCount"))
        end
    end
    local v38, _, _, _ = castRay(v_u_12, p_u_11[1][2]:FindFirstChild("HumanoidRootPart").Position, Vector3.new(0, -999, 0))
    local v46 = {
        ["root"] = p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(-0.5, -3, -2),
        ["projectile"] = game:GetService("ReplicatedStorage").VFX.Blood,
        ["tickFunc"] = function(p39)
            if p39 then
                local _, _, v40, v41 = castRay(v_u_12, p39.Position, p39.CFrame.LookVector * 2)
                if v41 and p39 then
                    local v42 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                    v42.Parent = workspace.IGNORE
                    v42:PivotTo(CFrame.lookAt(v40, v40 + v41.Normal))
                    v42:ScaleTo(Random.new():NextNumber(0.75, 2))
                    task.delay(2, v42.Destroy, v42)
                    m_VFXHandler.doEmitCount(v42)
                    p39:Destroy()
                end
            end
        end,
        ["onHit"] = function(p43, p44)
            if p44 then
                local v45 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                v45.Parent = workspace.IGNORE
                v45:PivotTo(CFrame.new(p43) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0))
                v45:ScaleTo(Random.new():NextNumber(0.75, 2))
                task.delay(2, v45.Destroy, v45)
                m_VFXHandler.doEmitCount(v45)
            end
        end,
        ["count"] = 4,
        ["spreadRadius"] = 8,
        ["startHeight"] = v38,
        ["durationRandom"] = { 0.35 + v38 / 100, 0.75 + v38 / 100 },
        ["arcHeightRandom"] = { 5, 35 },
        ["evenlySpaced"] = false,
        ["rotate"] = true,
        ["spawnDelay"] = 0.05,
        ["lifetime"] = 15
    }
    m_BezierProjectileUtil.SpawnProjectiles(v46)
    v16:GetMarkerReachedSignal("hit"):Connect(function()
        v_u_36 = v_u_36 + 1
        if v_u_36 == 1 then
            for _, v47 in v_u_30.hit2:GetDescendants() do
                if v47:IsA("ParticleEmitter") then
                    v47:Emit(v47:GetAttribute("EmitCount"))
                end
            end
        elseif v_u_36 == 2 then
            for _, v48 in v_u_30.hit3:GetDescendants() do
                if v48:IsA("ParticleEmitter") then
                    v48:Emit(v48:GetAttribute("EmitCount"))
                end
            end
        elseif v_u_36 == 3 then
            for _, v49 in v_u_30.hit4:GetDescendants() do
                if v49:IsA("ParticleEmitter") then
                    v49:Emit(v49:GetAttribute("EmitCount"))
                end
            end
        elseif v_u_36 == 4 then
            for _, v50 in v_u_30.hit5:GetDescendants() do
                if v50:IsA("ParticleEmitter") then
                    v50:Emit(v50:GetAttribute("EmitCount"))
                end
            end
            local v51, _, _, _ = castRay(v_u_12, p_u_11[1][2]:FindFirstChild("HumanoidRootPart").Position, Vector3.new(0, -999, 0))
            local v59 = {
                ["root"] = p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(-0.5, -3, -2),
                ["projectile"] = game:GetService("ReplicatedStorage").VFX.Blood,
                ["tickFunc"] = function(p52)
                    if p52 then
                        local _, _, v53, v54 = castRay(v_u_12, p52.Position, p52.CFrame.LookVector * 2)
                        if v54 and p52 then
                            local v55 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                            v55.Parent = workspace.IGNORE
                            v55:PivotTo(CFrame.lookAt(v53, v53 + v54.Normal))
                            v55:ScaleTo(Random.new():NextNumber(0.75, 2))
                            task.delay(2, v55.Destroy, v55)
                            m_VFXHandler.doEmitCount(v55)
                            p52:Destroy()
                        end
                    end
                end,
                ["onHit"] = function(p56, p57)
                    if p57 then
                        local v58 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                        v58.Parent = workspace.IGNORE
                        v58:PivotTo(CFrame.new(p56) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0))
                        v58:ScaleTo(Random.new():NextNumber(0.75, 2))
                        task.delay(2, v58.Destroy, v58)
                        m_VFXHandler.doEmitCount(v58)
                    end
                end,
                ["count"] = 4,
                ["spreadRadius"] = 8,
                ["startHeight"] = v51,
                ["durationRandom"] = { 0.35 + v51 / 100, 0.75 + v51 / 100 },
                ["arcHeightRandom"] = { 5, 35 },
                ["evenlySpaced"] = false,
                ["rotate"] = true,
                ["spawnDelay"] = 0.05,
                ["lifetime"] = 15
            }
            m_BezierProjectileUtil.SpawnProjectiles(v59)
        end
        if table.find(p_u_11[1], game:GetService("Players").LocalPlayer.Character) and GameUIContainer then
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageColor3 = Color3.fromRGB(72, 0, 0)
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageTransparency = 0
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 1
            }):Play()
        end
    end)
    task.delay(1.44, function()
        for _, v60 in v_u_30.stomp1:GetDescendants() do
            if v60:IsA("ParticleEmitter") then
                v60:Emit(v60:GetAttribute("EmitCount"))
            end
        end
    end)
    task.delay(2.3, function()
        for _, v61 in v_u_30.stomp2:GetDescendants() do
            if v61:IsA("ParticleEmitter") then
                v61:Emit(v61:GetAttribute("EmitCount"))
            end
        end
    end)
    task.delay(4.15, function()
        v_u_35:Disconnect()
    end)
    v16.Stopped:Once(function()
        local v62 = next
        local v63, v64 = p_u_11[1][2]:GetDescendants()
        for _, v65 in v62, v63, v64 do
            if v65:IsA("BasePart") then
                v65.LocalTransparencyModifier = 0
            end
        end
        local v66 = next
        local v67, v68 = p_u_11[1][1]:GetDescendants()
        for _, v69 in v66, v67, v68 do
            if v69:IsA("BasePart") then
                v69.LocalTransparencyModifier = 0
            end
        end
    end)
end
return v1
