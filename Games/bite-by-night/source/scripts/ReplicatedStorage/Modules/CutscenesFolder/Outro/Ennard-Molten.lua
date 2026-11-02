-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v_u_1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
v_u_1.Duration = 5.609999999999999
v_u_1.Cutscene = "EnnardOutro"
function v_u_1.Activate(p3)
    workspace.GAME.STOP_MUSIC_ALL.Value = true
    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true) then
        game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ambience", true):Stop()
    end
    local v_u_4 = script.FolderModel:Clone()
    v_u_4.Parent = workspace.IGNORE
    game:GetService("ReplicatedStorage").Modules.CutscenesFolder.CutsceneMaps.EnnardOutroMap:Clone().Parent = v_u_4
    local v5 = 0
    local v6 = {}
    for _, v_u_7 in next, p3 do
        if v_u_7.UserId ~= workspace.GAME.Appearence.Value then
            if v5 >= 6 then
                break
            end
            v5 = v5 + 1
            local v_u_8 = v_u_4.Dummy:Clone()
            v_u_8.Name = "DeadPerson"
            task.spawn(function()
                local v_u_9 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(v_u_7.UserId)
                task.delay(0.5, function()
                    v_u_8.Humanoid:ApplyDescriptionAsync(v_u_9)
                end)
            end)
            v_u_8.Parent = v_u_4
            v6[#v6 + 1] = v_u_8.Humanoid.Animator:LoadAnimation(script[("EnnardBody%*"):format(v5)])
        end
    end
    task.delay(0.5, function()
        local v10 = game:GetService("Players"):GetHumanoidDescriptionFromUserIdAsync(workspace.GAME.Appearence.Value)
        v_u_4.Dummy.Humanoid:ApplyDescriptionAsync(v10)
    end)
    task.delay(30, v_u_4.Destroy, v_u_4)
    local v_u_11 = v_u_4.Dummy.Humanoid.Animator:LoadAnimation(script.EnnardAnim)
    local v12 = v_u_4.DoubleDoors.AnimationController:LoadAnimation(script.DoorKick)
    local vfx = v_u_4.vfx
    v_u_11:GetMarkerReachedSignal("vfx1"):Connect(function()
        local v14 = vfx["1"]
        m_EffectUtility.EmitAttachment(v14)
    end)
    v_u_11:GetMarkerReachedSignal("vfx2"):Connect(function()
        local Stage2 = vfx.Stage2
        m_EffectUtility.EmitAttachment(Stage2)
        m_EffectUtility.ToggleAttachment(Stage2, true, 2)
    end)
    v_u_11:GetMarkerReachedSignal("vfx3"):Connect(function()
        local Stage3 = vfx.Stage3
        m_EffectUtility.EmitAttachment(Stage3)
        m_EffectUtility.ToggleAttachment(Stage3, true, 0.7)
    end)
    v_u_11:GetMarkerReachedSignal("vfx4"):Connect(function()
        local Stage4 = vfx.Stage4
        m_EffectUtility.EmitAttachment(Stage4)
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
    v_u_4.Outro:Play()
    v_u_4.Outro:GetPropertyChangedSignal("IsLoaded"):Once(function()
        if v_u_4 and v_u_4:FindFirstChild("Outro") then
            v_u_4.Outro.TimePosition = v_u_11.TimePosition
        end
    end)
    for _, v19 in next, v6 do
        v19:Play(0)
    end
    v_u_11:Play(0)
    v12:Play(0)
    task.delay(5.08, function()
        RoundKiller.Visible = false
        game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition"), TweenInfo.new(0), {
            ["GroupTransparency"] = 0
        }):Play()
    end)
    task.delay(v_u_1.Duration + 2.5, function()
        game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI:FindFirstChild("Transitions"):FindFirstChild("Transition"), TweenInfo.new(1), {
            ["GroupTransparency"] = 1
        }):Play()
    end)
    task.delay(5.5, function()
        workspace.GAME.STOP_MUSIC_ALL.Value = false
    end)
    task.wait(10)
    v_u_4:Remove()
end
return v_u_1
