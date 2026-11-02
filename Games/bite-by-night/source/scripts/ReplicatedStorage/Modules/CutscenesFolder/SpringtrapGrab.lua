-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Activate"] = function(p_u_1)
        local v_u_2 = p_u_1[2]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_1[3])
        v_u_2.Priority = Enum.AnimationPriority.Idle
        v_u_2:Play()
        local v3 = next
        local v4, v5 = p_u_1[2]:GetDescendants()
        for _, v6 in v3, v4, v5 do
            if v6:IsA("BasePart") and v6.Name ~= "Axe.001" then
                v6.LocalTransparencyModifier = v6.Transparency
            end
        end
        local v_u_7 = script.Enable:Clone()
        local v_u_8 = script.emit:Clone()
        v_u_7.Parent = p_u_1[2]:FindFirstChild("RootPart"):FindFirstChild("Head", true)
        v_u_8.Parent = p_u_1[2]:FindFirstChild("RootPart"):FindFirstChild("Head", true)
        task.delay(15, v_u_7.Destroy, v_u_7)
        task.delay(15, v_u_8.Destroy, v_u_8)
        local v_u_9 = true
        v_u_2:GetMarkerReachedSignal("Scream"):Once(function()
            for _, v10 in v_u_7:QueryDescendants("ParticleEmitter") do
                v10.Enabled = true
            end
            for _, v11 in v_u_8:QueryDescendants("ParticleEmitter") do
                v11.Enabled = true
            end
            local Head = p_u_1[2]:FindFirstChild("RootPart"):FindFirstChild("Head", true)
            local v13 = next
            local v14, v15 = p_u_1[2]:GetDescendants()
            for _, v16 in v13, v14, v15 do
                if v16:IsA("BasePart") and v16.Name ~= "Axe.001" then
                    v16.LocalTransparencyModifier = v16.Transparency
                end
            end
            repeat
                local v17 = script.Distortion:Clone()
                v17.Size = Vector3.new(0, 0, 0)
                v17.CFrame = Head.WorldCFrame
                v17.Parent = workspace.IGNORE
                game:GetService("TweenService"):Create(v17, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ["Size"] = Vector3.new(25, 25, 25),
                    ["Transparency"] = 1
                }):Play()
                task.delay(0.25, v17.Destroy, v17)
                task.wait(0.125)
            until v_u_2.IsPlaying == false or v_u_9 == false
            for _, v18 in v_u_7:QueryDescendants("ParticleEmitter") do
                v18.Enabled = false
            end
            for _, v19 in v_u_8:QueryDescendants("ParticleEmitter") do
                v19.Enabled = false
            end
        end)
        v_u_2:GetMarkerReachedSignal("End"):Once(function()
            v_u_9 = false
        end)
        v_u_2.Stopped:Once(function()
            v_u_9 = false
        end)
        task.spawn(function()
            local v_u_20 = table.find(p_u_1[1], game:GetService("Players").LocalPlayer) and (game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI"):FindFirstChild("GameUIContainer") or game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer"):FindFirstChild("GameUIContainer"))
            if v_u_20 then
                local GameUIContainer = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):FindFirstChild("Transitions"):FindFirstChild("GameUIContainer")
                v_u_20.Parent = GameUIContainer
                GameUIContainer.GroupTransparency = 0
                game:GetService("TweenService"):Create(GameUIContainer, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 1
                }):Play()
                if game:GetService("Players").LocalPlayer.Character.Parent == workspace.PLAYERS.KILLER then
                    task.wait(4.52)
                    game:GetService("TweenService"):Create(GameUIContainer, TweenInfo.new(0.5), {
                        ["GroupTransparency"] = 0
                    }):Play()
                    task.delay(0.5, function()
                        v_u_20.Parent = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI")
                    end)
                    return
                end
                task.wait(3.26)
                game:GetService("TweenService"):Create(GameUIContainer, TweenInfo.new(0.5), {
                    ["GroupTransparency"] = 0
                }):Play()
                task.delay(0.5, function()
                    v_u_20.Parent = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("UI"):WaitForChild("UI")
                end)
            end
        end)
    end
}
