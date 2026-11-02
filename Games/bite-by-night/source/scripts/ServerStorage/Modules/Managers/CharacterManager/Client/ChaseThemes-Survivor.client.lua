-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local v_u_3 = {
    15,
    30,
    45,
    60
}
workspace:FindFirstChild("LobbyMusic").Volume = 0
local v_u_4 = {}
local v_u_5 = 0
RunService.Heartbeat:Connect(function(p6)
    local Character = Players.LocalPlayer.Character
    if not Character then
        return
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return
    end
    if workspace.GAME.STOP_MUSIC.Value == true then
        for _, v9 in workspace.PLAYERS.KILLER:GetChildren() do
            if v9:FindFirstChild("Phases") then
                for v10 = 1, 4 do
                    game:GetService("TweenService"):Create(v9:FindFirstChild("Phases"):FindFirstChild(v10), TweenInfo.new(0.25), {
                        ["Volume"] = 0
                    }):Play()
                end
            end
        end
        return
    end
    if workspace.GAME.STOP_MUSIC_ALL.Value == true then
        for _, v11 in workspace.PLAYERS.KILLER:GetChildren() do
            if v11:FindFirstChild("Phases") then
                for v12 = 1, 6 do
                    if v11:FindFirstChild("Phases"):FindFirstChild(v12) then
                        game:GetService("TweenService"):Create(v11:FindFirstChild("Phases"):FindFirstChild(v12), TweenInfo.new(0.25), {
                            ["Volume"] = 0
                        }):Play()
                    end
                end
            end
        end
        return
    end
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
        for _, v13 in workspace.PLAYERS.KILLER:GetChildren() do
            if v13:FindFirstChild("Phases") then
                for v14 = 1, 6 do
                    if v13:FindFirstChild("Phases"):FindFirstChild(v14) then
                        game:GetService("TweenService"):Create(v13:FindFirstChild("Phases"):FindFirstChild(v14), TweenInfo.new(0.5), {
                            ["PlaybackSpeed"] = 0
                        }):Play()
                    end
                end
            end
        end
        return
    end
    local v15 = 0
    for _, v16 in workspace.PLAYERS.KILLER:GetChildren() do
        local HumanoidRootPart_0 = v16:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart_0 and (v16:FindFirstChild("Phases") and not v_u_4[v16.Name]) then
            local v18 = {}
            for v19 = 1, 4 do
                v18[v19] = v16:WaitForChild("Phases"):WaitForChild(v19)
            end
            for _, v20 in next, v18 do
                if not (v20.IsLoaded or v_u_4[v16.Name]) then
                    v_u_4[v16.Name] = true
                    v20.Loaded:Wait()
                    v_u_4[v16.Name] = false
                end
            end
            for _, v21 in next, v18 do
                if not v21.IsPlaying then
                    v21:Play()
                    v21.Volume = 0
                end
            end
            local v22 = 0
            for v23, v24 in next, v_u_3 do
                if (HumanoidRootPart.Position - HumanoidRootPart_0.Position).Magnitude <= v24 then
                    v22 = #v18 - v23 + 1
                    break
                end
            end
            local v25 = Character:HasTag("COMBAT") and 4 or (v16:HasTag("UNDETECTABLE") and v22 < 4 and 0 or ((v16:HasTag("INVISIBILE") or v16:HasTag("TRUE_UNDETECTABLE")) and 0 or v22))
            if v15 < v25 then
                v15 = v25
            end
            if v25 ~= v_u_5 and (v25 == 4 and Character:HasTag("COMBAT")) then
                for _, v26 in next, v18 do
                    v26.TimePosition = 0
                end
            end
            for v27, v28 in next, v18 do
                if v27 == v25 then
                    v28.Volume = v28.Volume + (v28:GetAttribute("VOLUME_MAX") - v28.Volume) * math.min(p6, 1)
                else
                    v28.Volume = v28.Volume * (1 - math.min(p6, 1))
                end
            end
        end
    end
    v_u_5 = v15
    if workspace:FindFirstChild("MAPS"):FindFirstChild("GAME MAP"):FindFirstChild("Music") then
        local Music = workspace:FindFirstChild("MAPS"):FindFirstChild("GAME MAP"):FindFirstChild("Music")
        if v15 > 0 then
            game:GetService("TweenService"):Create(Music, TweenInfo.new(0.5), {
                ["Volume"] = 0
            }):Play()
            return
        end
        game:GetService("TweenService"):Create(Music, TweenInfo.new(0.5), {
            ["Volume"] = Music:GetAttribute("Volume")
        }):Play()
    end
end)
