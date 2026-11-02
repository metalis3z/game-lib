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
    local v_u_16 = script.cameraVFX:Clone()
    local v_u_17 = script.KillVFX:Clone()
    v_u_16.Parent = workspace.IGNORE
    v_u_17.Parent = workspace.IGNORE
    task.delay(30, v_u_16.Destroy, v_u_16)
    task.delay(30, v_u_17.Destroy, v_u_17)
    local v18 = p_u_11[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_11[2])
    v18.Priority = Enum.AnimationPriority.Action4
    v18:Play()
    local v19 = next
    local v20, v21 = p_u_11[1][2]:GetDescendants()
    local v_u_22 = nil
    for _, v23 in v19, v20, v21 do
        if v23:IsA("BasePart") and v23.Name ~= "Axe.001" then
            v23.LocalTransparencyModifier = v23.Transparency
        end
    end
    local v24 = next
    local v25, v26 = p_u_11[1][1]:GetDescendants()
    for _, v27 in v24, v25, v26 do
        if v27:IsA("BasePart") and v27.Name ~= "Axe.001" then
            v27.LocalTransparencyModifier = v27.Transparency
        end
    end
    if p_u_11[1][2]:FindFirstChild("Axe") then
        local v28 = next
        local v29, v30 = p_u_11[1][2].Axe:GetChildren()
        for _, v31 in v28, v29, v30 do
            if v31:IsA("BasePart") then
                v31.LocalTransparencyModifier = 1
            end
        end
    end
    if table.find(p_u_11[1], game:GetService("Players").LocalPlayer.Character) then
        task.spawn(function()
            local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
            local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
            GameUIContainer.Parent = GameUIContainer_0
            if GameUIContainer then
                GameUIContainer_0.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
            end
            task.delay(1.25, function()
                for _, v34 in v_u_16.staticfx:QueryDescendants("ParticleEmitter") do
                    v34.Enabled = true
                end
                task.delay(0.6, function()
                    for _, v35 in v_u_16.staticfx:QueryDescendants("ParticleEmitter") do
                        v35.Enabled = false
                    end
                end)
            end)
            task.delay(1.867, function()
                for _, v36 in v_u_16.screenbreak:QueryDescendants("ParticleEmitter") do
                    v36:Emit(v36:GetAttribute("EmitCount"))
                end
            end)
            v_u_22 = game:GetService("RunService").PreRender:Connect(function()
                v_u_16.CFrame = workspace.CurrentCamera.CFrame
            end)
            if game:GetService("Players").LocalPlayer.Character.Parent == workspace.PLAYERS.KILLER then
                task.wait(3.26)
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
    local v_u_37 = 0
    local v_u_38 = nil
    v_u_38 = v18:GetMarkerReachedSignal("Hit"):Connect(function()
        v_u_37 = v_u_37 + 1
        v_u_17:PivotTo(p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame)
        if v_u_37 == 2 then
            local v39, _, _, _ = castRay(v_u_12, p_u_11[1][2]:FindFirstChild("HumanoidRootPart").Position, Vector3.new(0, -999, 0))
            local v47 = {
                ["root"] = p_u_11[1][2]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(-0.5, -3, -2),
                ["projectile"] = game:GetService("ReplicatedStorage").VFX.Blood,
                ["tickFunc"] = function(p40)
                    if p40 then
                        local _, _, v41, v42 = castRay(v_u_12, p40.Position, p40.CFrame.LookVector * 2)
                        if v42 and p40 then
                            local v43 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                            v43.Parent = workspace.IGNORE
                            v43:PivotTo(CFrame.lookAt(v41, v41 + v42.Normal))
                            v43:ScaleTo(Random.new():NextNumber(0.75, 2))
                            task.delay(2, v43.Destroy, v43)
                            m_VFXHandler.doEmitCount(v43)
                            p40:Destroy()
                        end
                    end
                end,
                ["onHit"] = function(p44, p45)
                    if p45 then
                        local v46 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                        v46.Parent = workspace.IGNORE
                        v46:PivotTo(CFrame.new(p44) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0))
                        v46:ScaleTo(Random.new():NextNumber(0.75, 2))
                        task.delay(2, v46.Destroy, v46)
                        m_VFXHandler.doEmitCount(v46)
                    end
                end,
                ["count"] = 4,
                ["spreadRadius"] = 8,
                ["startHeight"] = v39,
                ["durationRandom"] = { 0.35 + v39 / 100, 0.75 + v39 / 100 },
                ["arcHeightRandom"] = { 5, 35 },
                ["evenlySpaced"] = false,
                ["rotate"] = true,
                ["spawnDelay"] = 0.05,
                ["lifetime"] = 15
            }
            m_BezierProjectileUtil.SpawnProjectiles(v47)
            for _, v48 in v_u_17.Hit2:QueryDescendants("ParticleEmitter") do
                v48:Emit(v48:GetAttribute("EmitCount"))
            end
            v_u_38:Disconnect()
        else
            for _, v49 in v_u_17.Hit1:QueryDescendants("ParticleEmitter") do
                v49:Emit(v49:GetAttribute("EmitCount"))
            end
        end
        if table.find(p_u_11[1], game:GetService("Players").LocalPlayer.Character) then
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageColor3 = Color3.fromRGB(72, 0, 0)
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageTransparency = 0
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 1
            }):Play()
        end
    end)
    v18.Stopped:Once(function()
        local v50 = next
        local v51, v52 = p_u_11[1][2]:GetDescendants()
        for _, v53 in v50, v51, v52 do
            if v53:IsA("BasePart") and v53.Name ~= "Axe.001" then
                v53.LocalTransparencyModifier = 0
            end
        end
        local v54 = next
        local v55, v56 = p_u_11[1][1]:GetDescendants()
        for _, v57 in v54, v55, v56 do
            if v57:IsA("BasePart") and v57.Name ~= "Axe.001" then
                v57.LocalTransparencyModifier = 0
            end
        end
        if v_u_22 then
            v_u_22:Disconnect()
        end
        v_u_38:Disconnect()
    end)
end
return v1
