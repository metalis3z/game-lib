-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_10 = {
    ["Duration"] = 5.43,
    ["Cutscene"] = "HoaxOutro",
    ["Activate"] = function()
        workspace.GAME.STOP_MUSIC_ALL.Value = true
        if game:GetService("Players").LocalPlayer.Character and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("RootPart") and game:GetService("Players").LocalPlayer.Character.RootPart:FindFirstChild("Ambience", true)) then
            game:GetService("Players").LocalPlayer.Character.RootPart:FindFirstChild("Ambience", true):Stop()
        end
        local v_u_1 = script.FolderModel:Clone()
        v_u_1.Parent = workspace.IGNORE
        task.delay(30, v_u_1.Destroy, v_u_1)
        local v_u_2 = v_u_1.Hoax.Humanoid.Animator:LoadAnimation(script.SpringtrapAnim)
        local v3 = v_u_1.Dummy.Humanoid.Animator:LoadAnimation(script.SpringtrapVictimAnim)
        task.spawn(function()
            local v4 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(game:GetService("Players").LocalPlayer.UserId)
            v4.HatAccessory = ""
            v4.FaceAccessory = ""
            v4.BackAccessory = ""
            v4.HairAccessory = ""
            v_u_1.Dummy.Humanoid:ApplyDescriptionAsync(v4)
            for _, v5 in game:GetService("Lighting"):GetChildren() do
                v5:Destroy()
            end
            local v6 = script.Lighting:Clone()
            for _, v7 in v6:FindFirstChild("Lighting"):GetChildren() do
                game:GetService("Lighting")[v7.Name] = v7.Value
            end
            for _, v8 in v6:GetChildren() do
                v8.Parent = game:GetService("Lighting")
            end
        end)
        task.wait(2.5)
        game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition"), TweenInfo.new(0.5), {
            ["GroupTransparency"] = 1
        }):Play()
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
        v_u_1.Outro:Play()
        v_u_1.Outro:GetPropertyChangedSignal("IsLoaded"):Once(function()
            if v_u_1 and v_u_1:FindFirstChild("Outro") then
                v_u_1.Outro.TimePosition = v_u_2.TimePosition + 0.25
            end
        end)
        task.delay(4.9, function()
            RoundKiller.Visible = false
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition"), TweenInfo.new(0.5), {
                ["GroupTransparency"] = 0
            }):Play()
        end)
        task.delay(v_u_10.Duration + 2.5, function()
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Shop.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Inventory.Visible = false
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Currency.Visible = true
            game:GetService("Players").LocalPlayer.PlayerGui.UI.UI.LobbyUIContainer.Buttons.Visible = true
            game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition"), TweenInfo.new(1), {
                ["GroupTransparency"] = 1
            }):Play()
        end)
        task.delay(5.5, function()
            workspace.GAME.STOP_MUSIC_ALL.Value = false
        end)
        task.wait(10)
        v_u_1:Remove()
    end
}
return v_u_10
