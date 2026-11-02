-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

return {
    ["Duration"] = 11.33,
    ["Cutscene"] = "SpringtrapIntro",
    ["Activate"] = function()
        workspace.GAME.STOP_MUSIC.Value = true
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true):Stop()
        local v_u_1 = script.FolderModel:Clone()
        v_u_1.Parent = workspace.IGNORE
        task.delay(30, v_u_1.Destroy, v_u_1)
        game:GetService("ReplicatedStorage").Modules.CutscenesFolder.CutsceneMaps.MapSpringtrapIntro:Clone().Parent = v_u_1
        local v_u_2 = v_u_1.walkingspring.Humanoid:LoadAnimation(script.SpringtrapAnim)
        local v3 = v_u_1.Barricade.AnimationController:LoadAnimation(script.BarricadeAnim)
        local v4 = v_u_1.Victim.Humanoid:LoadAnimation(script.VictimAnim)
        task.delay(0.1, function()
            local v5 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(workspace.GAME.Appearence.Value)
            v_u_1.Victim.Humanoid:ApplyDescriptionAsync(v5)
        end)
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
        v_u_2:Play(0)
        v3:Play(0)
        v4:Play(0)
        v_u_1.Intro:Play()
        v_u_1.Intro:GetPropertyChangedSignal("IsLoaded"):Once(function()
            if v_u_1 and v_u_1:FindFirstChild("Intro") then
                v_u_1.Intro.TimePosition = v_u_2.TimePosition
            end
        end)
        v_u_2:GetMarkerReachedSignal("Light"):Once(function()
            v_u_1["FIRE AXE BOX"].Light.PointLight.Enabled = true
        end)
        v_u_2:GetMarkerReachedSignal("Light2"):Once(function()
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
            v_u_1["FIRE AXE BOX"].Light.PointLight.Enabled = false
        end)
        v_u_2:GetMarkerReachedSignal("Break"):Once(function()
            for _, v11 in v_u_1["FIRE AXE BOX"].GLASS:GetDescendants() do
                if v11:IsA("MeshPart") then
                    v11.Anchored = false
                    v11.Velocity = CFrame.new(v11.Position, v_u_1["FIRE AXE BOX"].Root.Position).LookVector * math.random(-15, -5)
                end
            end
        end)
        task.delay(11.33, function()
            RoundKiller.Visible = false
            if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") == "Lobby" then
                game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
            end
        end)
        task.wait(13.5)
        workspace.GAME.STOP_MUSIC.Value = false
        v_u_1:Destroy()
    end
}
