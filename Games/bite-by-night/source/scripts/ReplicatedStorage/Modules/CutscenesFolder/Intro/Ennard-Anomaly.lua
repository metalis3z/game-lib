-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    ["Duration"] = 12.31,
    ["Cutscene"] = "EnnardVHSIntro"
}
require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate()
    workspace.GAME.STOP_MUSIC.Value = true
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true) then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true):Stop()
    end
    if workspace:FindFirstChild("LobbyMusic") then
        workspace.LobbyMusic:Stop()
    end
    local v2 = script.FolderModel:Clone()
    v2.Parent = workspace.IGNORE
    task.delay(30, v2.Destroy, v2)
    game:GetService("ReplicatedStorage").Modules.CutscenesFolder.CutsceneMaps.EnnardIntroVHS:Clone().Parent = v2
    local v3 = v2.AnomalyEnnard.AnimationController.Animator:LoadAnimation(v2.EnnardAnimation)
    v3:Play(0)
    v3:AdjustSpeed(0)
    task.wait(2.5)
    v3:AdjustSpeed(1)
    local v_u_4 = v2.EnnardVHS:Clone()
    v_u_4.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    task.spawn(function()
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
    local RoundKiller = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("UI"):FindFirstChild("RoundKiller")
    RoundKiller.Visible = true
    RoundKiller.Holder.Visible = false
    RoundKiller.Shine.ImageTransparency = 1
    RoundKiller.Bar1.Position = UDim2.new(0.5, 0, -0.2, 0)
    RoundKiller.Bar2.Position = UDim2.new(0.5, 0, 1.2, 0)
    v2.Intro:Play()
    task.delay(8.5, function()
        RoundKiller.Holder.Information.User:FindFirstChild("Text").Text = "???"
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
    end)
    task.delay(10.5, function()
        RoundKiller.Visible = false
        if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") == "Lobby" then
            game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
        end
        v_u_4:Destroy()
    end)
    v3.Stopped:Wait()
    task.wait(3)
    workspace.GAME.STOP_MUSIC.Value = false
    v2:Destroy()
end
return v1
