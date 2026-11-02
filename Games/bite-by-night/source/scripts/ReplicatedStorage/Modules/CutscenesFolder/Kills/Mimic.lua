-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local m_BezierProjectileUtil = require(ReplicatedStorage.Modules.BezierProjectileUtil)
local m_VFXHandler = require(ReplicatedStorage.Modules.VFXHandler)
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function castRay(p6, p7, p8)
    local v9 = RaycastParams.new()
    v9.FilterType = Enum.RaycastFilterType.Include
    v9.FilterDescendantsInstances = p6
    local v10 = workspace:Raycast(p7, p8, v9)
    local v11 = v10 and v10.Position or p7 + p8
    return (p7 - v11).Magnitude, p7, v11, v10
end
function v1.Activate(p_u_12)
    task.wait(0.1)
    local v_u_13 = { workspace.PLAYERS, workspace.Terrain }
    task.spawn(function()
        for _, v14 in game:GetService("Workspace"):GetDescendants() do
            if v14:IsA("Part") and (v14.CanCollide == true and (v14.Transparency < 1 and not (v14:IsDescendantOf(workspace.PLAYERS) or v14:IsDescendantOf(workspace.IGNORE)))) then
                local v15 = v_u_13
                table.insert(v15, v14)
            elseif v14:IsA("MeshPart") and (v14.CanCollide == true and (v14.Transparency < 1 and not (v14:IsDescendantOf(workspace.PLAYERS) or v14:IsDescendantOf(workspace.IGNORE)))) then
                local v16 = v_u_13
                table.insert(v16, v14)
            end
        end
    end)
    local v17 = p_u_12[1][2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_12[2][2])
    local v18 = p_u_12[1][1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_12[2][1])
    v17.Priority = Enum.AnimationPriority.Action4
    v18.Priority = Enum.AnimationPriority.Action4
    v17:Play()
    v18:Play()
    local v19 = next
    local v20, v21 = p_u_12[1][2]:GetDescendants()
    for _, v22 in v19, v20, v21 do
        if v22:IsA("BasePart") then
            v22.LocalTransparencyModifier = v22.Transparency
        end
    end
    local v23 = next
    local v24, v25 = p_u_12[1][1]:GetDescendants()
    for _, v26 in v23, v24, v25 do
        if v26:IsA("BasePart") then
            v26.LocalTransparencyModifier = v26.Transparency
        end
    end
    if p_u_12[1][2]:FindFirstChild("Axe") then
        local v27 = next
        local v28, v29 = p_u_12[1][2].Axe:GetChildren()
        for _, v30 in v27, v28, v29 do
            if v30:IsA("BasePart") then
                v30.LocalTransparencyModifier = 1
            end
        end
    end
    local v_u_31 = script.VFX.CamVFX:Clone()
    local v_u_32 = script.VFX.Cam:Clone()
    local v_u_33 = script.VFX.Effects:Clone()
    v_u_32.Parent = workspace.IGNORE
    v_u_31.Parent = workspace.IGNORE
    v_u_33.Parent = workspace.IGNORE
    task.delay(15, v_u_32.Destroy, v_u_32)
    task.delay(15, v_u_31.Destroy, v_u_31)
    task.delay(15, v_u_33.Destroy, v_u_33)
    local v_u_34 = nil
    v_u_34 = game:GetService("RunService").PreRender:Connect(function()
        if p_u_12[1][2] and (v_u_33.Parent ~= nil and p_u_12[1][2]:FindFirstChild("HumanoidRootPart")) then
            v_u_33:PivotTo(p_u_12[1][2]:FindFirstChild("HumanoidRootPart").CFrame)
        else
            v_u_34:Disconnect()
        end
    end)
    if table.find(p_u_12[1], game:GetService("Players").LocalPlayer.Character) then
        v_u_34:Disconnect()
        task.spawn(function()
            local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer")
            local GameUIContainer_0 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
            if GameUIContainer then
                GameUIContainer.Parent = GameUIContainer_0
                GameUIContainer_0.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer_0, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
            end
            task.delay(1.75, function()
                m_EffectUtility.ToggleAttachment(v_u_31, true, 0.6)
            end)
            task.delay(2.35, function()
                m_EffectUtility.EmitAttachment(v_u_32.ScreenOil)
            end)
            v_u_34 = game:GetService("RunService").PreRender:Connect(function()
                if p_u_12[1][2] and (v_u_32:FindFirstChild("ScreenOil") and p_u_12[1][2]:FindFirstChild("HumanoidRootPart")) then
                    for _, v37 in v_u_32.ScreenOil:GetChildren() do
                        if v37:IsA("ParticleEmitter") then
                            v37.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 2 * (workspace.CurrentCamera.FieldOfView / 70)), NumberSequenceKeypoint.new(1, 2 * (workspace.CurrentCamera.FieldOfView / 70)) })
                        end
                    end
                    if p_u_12[1][2] and p_u_12[1][2]:FindFirstChild("HumanoidRootPart") then
                        v_u_33:PivotTo(p_u_12[1][2]:FindFirstChild("HumanoidRootPart").CFrame)
                    end
                    v_u_32.CFrame = workspace.CurrentCamera.CFrame
                    v_u_31.CFrame = workspace.CurrentCamera.CFrame
                else
                    v_u_34:Disconnect()
                end
            end)
            if game:GetService("Players").LocalPlayer.Character.Parent == workspace.PLAYERS.KILLER then
                task.wait(3.26)
                task.delay(3, function()
                    if v_u_34 then
                        v_u_34:Disconnect()
                    end
                end)
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
    local v_u_38 = 0
    local v_u_61 = v17:GetMarkerReachedSignal("hit"):Connect(function()
        v_u_38 = v_u_38 + 1
        if table.find(p_u_12[1], game:GetService("Players").LocalPlayer.Character) then
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageColor3 = Color3.fromRGB(72, 0, 0)
            game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette.ImageTransparency = 0
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI.Vignette, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 1
            }):Play()
        end
        if v_u_38 == 2 then
            local v39, _, _, _ = castRay(v_u_13, p_u_12[1][2]:FindFirstChild("Torso").Position, Vector3.new(0, -999, 0))
            local v47 = {
                ["root"] = p_u_12[1][2]:FindFirstChild("Right Arm").CFrame * CFrame.new(0, 0.5, 0),
                ["projectile"] = game:GetService("ReplicatedStorage").VFX.Blood,
                ["tickFunc"] = function(p40)
                    if p40 then
                        local _, _, v41, v42 = castRay(v_u_13, p40.Position, p40.CFrame.LookVector * 2)
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
            local v55 = {
                ["root"] = p_u_12[1][2]:FindFirstChild("Left Arm").CFrame * CFrame.new(0, 0.5, 0),
                ["projectile"] = game:GetService("ReplicatedStorage").VFX.Blood,
                ["tickFunc"] = function(p48)
                    if p48 then
                        local _, _, v49, v50 = castRay(v_u_13, p48.Position, p48.CFrame.LookVector * 2)
                        if v50 and p48 then
                            local v51 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                            v51.Parent = workspace.IGNORE
                            v51:PivotTo(CFrame.lookAt(v49, v49 + v50.Normal))
                            v51:ScaleTo(Random.new():NextNumber(0.75, 2))
                            task.delay(2, v51.Destroy, v51)
                            m_VFXHandler.doEmitCount(v51)
                            p48:Destroy()
                        end
                    end
                end,
                ["onHit"] = function(p52, p53)
                    if p53 then
                        local v54 = game:GetService("ReplicatedStorage").VFX.BloodSplat:Clone()
                        v54.Parent = workspace.IGNORE
                        v54:PivotTo(CFrame.new(p52) * CFrame.fromEulerAnglesXYZ(1.5707963267948966, 0, 0))
                        v54:ScaleTo(Random.new():NextNumber(0.75, 2))
                        task.delay(2, v54.Destroy, v54)
                        m_VFXHandler.doEmitCount(v54)
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
            m_BezierProjectileUtil.SpawnProjectiles(v55)
            local v56 = script.VFX["Arm Blood"].Attachment:Clone()
            v56.Parent = p_u_12[1][2]:FindFirstChild("Right Arm")
            local v57 = script.VFX["Arm Blood"].Attachment:Clone()
            v57.Parent = p_u_12[1][2]:FindFirstChild("Left Arm")
            for _, v58 in v57:GetDescendants() do
                if v58:IsA("ParticleEmitter") then
                    v58:Emit(v58:GetAttribute("EmitCount"))
                end
            end
            for _, v59 in v56:GetDescendants() do
                if v59:IsA("ParticleEmitter") then
                    v59:Emit(v59:GetAttribute("EmitCount"))
                end
            end
        elseif v_u_38 == 1 then
            for _, v60 in v_u_33:QueryDescendants("ParticleEmitter") do
                v60:Emit(v60:GetAttribute("EmitCount"))
            end
        end
    end)
    v17.Stopped:Once(function()
        if not table.find(p_u_12[1], game:GetService("Players").LocalPlayer.Character) and v_u_34 then
            v_u_34:Disconnect()
        end
        v_u_61:Disconnect()
    end)
end
return v1
