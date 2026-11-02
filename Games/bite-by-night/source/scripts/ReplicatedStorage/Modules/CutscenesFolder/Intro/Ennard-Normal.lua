-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {
    ["Duration"] = 12.31,
    ["Cutscene"] = "EnnardIntro"
}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate()
    workspace.GAME.STOP_MUSIC.Value = true
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true) then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true):Stop()
    end
    local v_u_3 = script.FolderModel:Clone()
    v_u_3.Parent = workspace.IGNORE
    task.delay(30, v_u_3.Destroy, v_u_3)
    game:GetService("ReplicatedStorage").Modules.CutscenesFolder.CutsceneMaps.EnnardMap:Clone().Parent = v_u_3
    local v_u_4 = v_u_3.Ennard2.Humanoid:LoadAnimation(script.Ennard)
    local v5 = v_u_3.Door.AnimationController:LoadAnimation(script.Door)
    local v6 = v_u_3.SkinWalker.Humanoid:LoadAnimation(script.SkinWalker)
    local v7 = v_u_3.wiresennard.AnimationController:LoadAnimation(script.Wire)
    local v8 = v_u_3.Victim.Humanoid:LoadAnimation(script.Victim)
    task.delay(0.1, function()
        local v9 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(game:GetService("Players").LocalPlayer.UserId)
        v9.HatAccessory = ""
        v9.FaceAccessory = ""
        v9.BackAccessory = ""
        v9.HairAccessory = ""
        v9.Head = 0
        v_u_3.Victim.Humanoid:ApplyDescriptionAsync(v9)
    end)
    task.spawn(function()
        local Players = game:GetService("Players")
        local v_u_11 = workspace.GAME.Appearence.Value
        local v13, v14 = pcall(function()
            local v12 = Players:GetFriendsAsync(workspace.GAME.Appearence.Value):GetCurrentPage()
            v_u_11 = v12[math.random(1, #v12)].Id
        end)
        if not v13 then
            print("[Error Loading Friend]", v14)
        end
        local v15 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(v_u_11)
        v_u_3.SkinWalker.Humanoid:ApplyDescriptionAsync(v15)
    end)
    task.spawn(function()
        for _, v16 in game:GetService("Lighting"):GetChildren() do
            v16:Destroy()
        end
        local v17 = script.Lighting:Clone()
        for _, v18 in v17:FindFirstChild("Lighting"):GetChildren() do
            game:GetService("Lighting")[v18.Name] = v18.Value
        end
        for _, v19 in v17:GetChildren() do
            v19.Parent = game:GetService("Lighting")
        end
    end)
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
    v_u_4:Play(0)
    v5:Play(0)
    v6:Play(0)
    v7:Play(0)
    v8:Play(0)
    v_u_4:AdjustSpeed(0)
    v5:AdjustSpeed(0)
    v6:AdjustSpeed(0)
    v7:AdjustSpeed(0)
    v8:AdjustSpeed(0)
    task.wait(2.5)
    v_u_4:AdjustSpeed(1)
    v5:AdjustSpeed(1)
    v6:AdjustSpeed(1)
    v7:AdjustSpeed(1)
    v8:AdjustSpeed(1)
    task.delay(3.11, function()
        v_u_3.Light1.SpotLight.Enabled = true
        v_u_3.Light2.SpotLight.Enabled = true
    end)
    task.delay(6.41, function()
        game:GetService("TweenService"):Create(v_u_3.Light1.SpotLight, TweenInfo.new(2.18, Enum.EasingStyle.Linear), {
            ["Color"] = Color3.fromRGB(255, 0, 0)
        }):Play()
        game:GetService("TweenService"):Create(v_u_3.Light2.SpotLight, TweenInfo.new(2.18, Enum.EasingStyle.Linear), {
            ["Color"] = Color3.fromRGB(255, 0, 0)
        }):Play()
    end)
    v_u_3.Intro:Play()
    v_u_3.Intro:GetPropertyChangedSignal("IsLoaded"):Once(function()
        if v_u_3 and v_u_3:FindFirstChild("Intro") then
            v_u_3.Intro.TimePosition = v_u_4.TimePosition
        end
    end)
    v_u_4:GetMarkerReachedSignal("vfx1"):Once(function()
        local v21 = v_u_3.vfxdemon["1"]
        m_EffectUtility.EmitAttachment(v21)
        local v22 = v_u_3.vfxdemon["1"]
        m_EffectUtility.TweenBeamTransparency(v22, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v_u_4:GetMarkerReachedSignal("vfx2"):Once(function()
        local v23 = v_u_3.vfxdemon["2"]
        m_EffectUtility.EmitAttachment(v23)
    end)
    v_u_4:GetMarkerReachedSignal("vfx3"):Once(function()
        local v24 = v_u_3.vfxdemon["1"]
        m_EffectUtility.EmitAttachment(v24)
        local v25 = v_u_3.vfxdemon["1"]
        m_EffectUtility.TweenBeamTransparency(v25, {
            ["transparency"] = 1,
            ["duration"] = 2,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
    end)
    v_u_4:GetMarkerReachedSignal("vfx4"):Once(function()
        local v26 = v_u_3.vfxdemon["1.5"]
        m_EffectUtility.EmitAttachment(v26)
    end)
    v_u_4:GetMarkerReachedSignal("vfx5"):Once(function()
        local v27 = v_u_3.SkinWalker.Head["1"]
        m_EffectUtility.EmitAttachment(v27)
        m_EffectUtility.ToggleAttachment(v27, true, 0.5)
    end)
    v_u_4:GetMarkerReachedSignal("vfx6"):Once(function()
        local thing1 = v_u_3.SkinWalker.thing1
        m_EffectUtility.EmitAttachment(thing1)
        m_EffectUtility.ToggleAttachment(thing1, true, 0.5)
    end)
    v_u_4:GetMarkerReachedSignal("vfx7"):Once(function()
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
        local thing2 = v_u_3.SkinWalker.thing2
        m_EffectUtility.EmitAttachment(thing2)
        m_EffectUtility.ToggleAttachment(thing2, true, 0.3)
    end)
    v_u_4:GetMarkerReachedSignal("vfx8"):Once(function()
        local v30 = v_u_3.vfxdemon["3"]
        m_EffectUtility.EmitAttachment(v30)
        m_EffectUtility.ToggleAttachment(v30, true, 0.2)
    end)
    v_u_4:GetMarkerReachedSignal("vfx9"):Once(function()
        local v31 = v_u_3.Ennard2.RootPart["1"]
        m_EffectUtility.EmitAttachment(v31)
    end)
    v_u_4:GetMarkerReachedSignal("vfx10"):Once(function()
        local v32 = v_u_3.Ennard2.RootPart.Master.TorsoControl.Spine1.Spine2.Spine3.Neck.Head["1"]
        m_EffectUtility.EmitAttachment(v32)
        m_EffectUtility.ToggleAttachment(v32, true, 2)
    end)
    v_u_4:GetMarkerReachedSignal("vfx11"):Once(function()
        local v33 = v_u_3.Ennard2.RootPart.Master.TorsoControl.Spine1.Spine2.Spine3.Neck.Head["2"]
        m_EffectUtility.EmitAttachment(v33)
        m_EffectUtility.ToggleAttachment(v33, true, 1)
    end)
    v_u_4.Stopped:Once(function()
        RoundKiller.Visible = false
        if game:GetService("Players").LocalPlayer:GetAttribute("TEAM") == "Lobby" then
            game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition").GroupTransparency = 0
        end
    end)
    task.wait(15.5)
    workspace.GAME.STOP_MUSIC.Value = false
    v_u_3:Destroy()
end
return v1
