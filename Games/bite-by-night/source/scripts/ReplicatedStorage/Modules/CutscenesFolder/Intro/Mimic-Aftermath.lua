-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Duration"] = 7.9,
    ["Cutscene"] = "MimicIntro",
    ["Activate"] = function()
        workspace.GAME.STOP_MUSIC_ALL.Value = true
        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true) then
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true):Stop()
        end
        local v_u_1 = script.FolderModel:Clone()
        v_u_1.Parent = workspace.IGNORE
        task.delay(30, v_u_1.Destroy, v_u_1)
        game:GetService("ReplicatedStorage").Modules.CutscenesFolder.CutsceneMaps["BBN WAREHOUSE MAP"]:Clone().Parent = v_u_1
        local v_u_2 = v_u_1.Mimicmodelnew.Humanoid.Animator:LoadAnimation(script.MimicAnim)
        local v3 = v_u_1.Dummy.Humanoid.Animator:LoadAnimation(script.VictimAnim)
        local v4 = v_u_1["Security Door"].AnimationController.Animator:LoadAnimation(script.DoorAnim)
        task.spawn(function()
            local v5 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(workspace.GAME.Appearence.Value)
            v5.HatAccessory = ""
            v5.FaceAccessory = ""
            v5.BackAccessory = ""
            v5.HairAccessory = ""
            v5.Head = 0
            v_u_1.Dummy.Humanoid:ApplyDescriptionAsync(v5)
            for _, v6 in game:GetService("Lighting"):GetChildren() do
                v6:Destroy()
            end
            local v7 = script.Lighting:Clone()
            for _, v8 in v7:FindFirstChild("Lighting"):GetChildren() do
                game:GetService("Lighting")[v8.Name] = v8.Value
            end
            for _, v9 in v7:GetChildren() do
                v9.Parent = game:GetService("Lighting")
            end
        end)
        task.wait(2.5)
        local RoundKiller = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("UI"):FindFirstChild("RoundKiller")
        RoundKiller.Visible = true
        RoundKiller.Holder.Visible = false
        RoundKiller.Shine.ImageTransparency = 1
        RoundKiller.Bar1.Position = UDim2.new(0.5, 0, -0.07, 0)
        RoundKiller.Bar2.Position = UDim2.new(0.5, 0, 1.07, 0)
        game:GetService("TweenService"):Create(RoundKiller.Bar1, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Position"] = UDim2.new(0.5, 0, 0, 0)
        }):Play()
        game:GetService("TweenService"):Create(RoundKiller.Bar2, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ["Position"] = UDim2.new(0.5, 0, 1, 0)
        }):Play()
        v4:GetMarkerReachedSignal("Spark1"):Once(function()
            for _, v_u_11 in v_u_1["Security Door"].Door:GetDescendants() do
                if v_u_11:IsA("ParticleEmitter") then
                    v_u_11:Emit(v_u_11:GetAttribute("EmitCount"))
                    v_u_11.Enabled = true
                    task.delay(v_u_11:GetAttribute("EmitDuration"), function()
                        v_u_11.Enabled = false
                    end)
                end
            end
            for _, v_u_12 in v_u_1["Security Door"].Door.emit2:GetDescendants() do
                if v_u_12:IsA("ParticleEmitter") then
                    v_u_12:Emit(v_u_12:GetAttribute("EmitCount"))
                    v_u_12.Enabled = true
                    task.delay(v_u_12:GetAttribute("EmitDuration"), function()
                        v_u_12.Enabled = false
                    end)
                end
            end
            for _, v_u_13 in v_u_1["Security Door"].Door.emit:GetDescendants() do
                if v_u_13:IsA("ParticleEmitter") then
                    v_u_13:Emit(v_u_13:GetAttribute("EmitCount"))
                    v_u_13.Enabled = true
                    task.delay(v_u_13:GetAttribute("EmitDuration"), function()
                        v_u_13.Enabled = false
                    end)
                end
            end
        end)
        v4:GetMarkerReachedSignal("Spark2"):Once(function()
            RoundKiller.FadeIN.GroupTransparency = 1
            RoundKiller.Holder.Visible = true
            RoundKiller.Holder.Parent = RoundKiller.FadeIN
            game:GetService("TweenService"):Create(RoundKiller.FadeIN, TweenInfo.new(0.5), {
                ["GroupTransparency"] = 0
            }):Play()
            game:GetService("TweenService"):Create(RoundKiller.Shine, TweenInfo.new(0.5), {
                ["ImageTransparency"] = 0.52
            }):Play()
            task.delay(0.5, function()
                RoundKiller.FadeIN:FindFirstChild("Holder").Parent = RoundKiller
            end)
            for _, v_u_14 in v_u_1["Security Door"].doortop:GetDescendants() do
                if v_u_14:IsA("ParticleEmitter") then
                    v_u_14:Emit(v_u_14:GetAttribute("EmitCount"))
                    v_u_14.Enabled = true
                    task.delay(v_u_14:GetAttribute("EmitDuration"), function()
                        v_u_14.Enabled = false
                    end)
                end
            end
            for _, v_u_15 in v_u_1["Security Door"].Door.emitlast:GetDescendants() do
                if v_u_15:IsA("ParticleEmitter") then
                    v_u_15:Emit(v_u_15:GetAttribute("EmitCount"))
                    v_u_15.Enabled = true
                    task.delay(v_u_15:GetAttribute("EmitDuration"), function()
                        v_u_15.Enabled = false
                    end)
                end
            end
            for _, v_u_16 in v_u_1["Security Door"].Door.emitlast2:GetDescendants() do
                if v_u_16:IsA("ParticleEmitter") then
                    v_u_16:Emit(v_u_16:GetAttribute("EmitCount"))
                    v_u_16.Enabled = true
                    task.delay(v_u_16:GetAttribute("EmitDuration"), function()
                        v_u_16.Enabled = false
                    end)
                end
            end
        end)
        v4:GetMarkerReachedSignal("Spark3"):Once(function()
            for _, v_u_17 in v_u_1["Security Door"].doorbottom:GetDescendants() do
                if v_u_17:IsA("ParticleEmitter") then
                    v_u_17:Emit(v_u_17:GetAttribute("EmitCount"))
                    v_u_17.Enabled = true
                    task.delay(v_u_17:GetAttribute("EmitDuration"), function()
                        v_u_17.Enabled = false
                    end)
                end
            end
        end)
        v_u_2:GetMarkerReachedSignal("Speed"):Once(function()
            local v18 = Color3.fromRGB(138, 214, 255)
            local v19 = Color3.fromRGB(52, 201, 255)
            for _, v20 in v_u_1.Mimicmodelnew:GetDescendants() do
                if v20:IsA("ParticleEmitter") then
                    v20.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v19), ColorSequenceKeypoint.new(1, v19) })
                elseif v20:IsA("SpotLight") or v20:IsA("PointLight") then
                    v20.Color = v18
                end
            end
        end)
        v_u_2:GetMarkerReachedSignal("Strength"):Once(function()
            for _, v21 in v_u_1.Mimicmodelnew:GetDescendants() do
                if v21:IsA("ParticleEmitter") then
                    v21.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
                elseif v21:IsA("SpotLight") or v21:IsA("PointLight") then
                    v21.Color = Color3.fromRGB(0, 0, 0)
                end
            end
            task.wait(0.05)
            local v22 = Color3.fromRGB(255, 157, 0)
            local v23 = Color3.fromRGB(255, 30, 0)
            for _, v24 in v_u_1.Mimicmodelnew:GetDescendants() do
                if v24:IsA("ParticleEmitter") then
                    v24.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v23), ColorSequenceKeypoint.new(1, v23) })
                elseif v24:IsA("SpotLight") or v24:IsA("PointLight") then
                    v24.Color = v22
                end
            end
        end)
        v_u_2:Play(0)
        v3:Play(0)
        v4:Play(0)
        v_u_1.Intro:Play()
        v_u_1.Intro:GetPropertyChangedSignal("IsLoaded"):Once(function()
            if v_u_1 and v_u_1:FindFirstChild("Intro") then
                v_u_1.Intro.TimePosition = v_u_2.TimePosition
            end
        end)
        task.delay(7.9, function()
            workspace.GAME.STOP_MUSIC_ALL.Value = false
        end)
        v_u_2.Stopped:Connect(function()
            RoundKiller.Visible = false
            if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") == "Lobby" then
                game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
            end
        end)
        task.wait(15)
        v_u_1:Remove()
    end
}
