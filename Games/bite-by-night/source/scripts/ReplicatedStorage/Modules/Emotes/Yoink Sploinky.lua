-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
game:GetService("ReplicatedStorage")
local m_EmoteClass = require(script.Parent.EmoteClass)
function v1.new(p_u_3)
    local v_u_4 = m_EmoteClass.new(p_u_3)
    function v_u_4.EmoteFunc()
        v_u_4.NAME = script.Name
        v_u_4.CheckFunc()
        for _, v5 in p_u_3 do
            local v6 = v5:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Start)
            local v_u_7 = v5:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Loop)
            if v5:IsDescendantOf(workspace) and v_u_4.Mute == false then
                local v8 = script.Sound:Clone()
                v8.Parent = v5:FindFirstChild("HumanoidRootPart")
                v6:Play()
                v8:Play()
                v_u_4.Assets.SFX = v8
            else
                v6:Play()
            end
            v6.Stopped:Once(function()
                if v_u_4.Playing == true then
                    local TimePosition = 0
                    for _, v10 in game:GetService("Players"):GetPlayers() do
                        local Character = v10.Character
                        if Character then
                            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                            if Humanoid then
                                for _, v13 in Humanoid:GetPlayingAnimationTracks() do
                                    if v13.Animation.Name == script.Loop.Name then
                                        TimePosition = v13.TimePosition
                                    end
                                end
                            end
                        end
                    end
                    v_u_7:Play()
                    v_u_7.TimePosition = TimePosition
                end
            end)
            local Anims = v_u_4.Anims
            table.insert(Anims, v6)
            local Anims_0 = v_u_4.Anims
            table.insert(Anims_0, v_u_7)
        end
        for _, v16 in p_u_3 do
            if v16:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) then
                v_u_4.Stop()
                return
            end
        end
    end
    return v_u_4
end
return v1
