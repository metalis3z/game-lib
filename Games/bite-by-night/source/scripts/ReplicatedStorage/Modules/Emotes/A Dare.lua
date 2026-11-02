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
        local TimePositio = 0
        local TimePosition = 0
        for _, v7 in game:GetService("Players"):GetPlayers() do
            local Character = v7.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    for _, v10 in Humanoid:GetPlayingAnimationTracks() do
                        if v10.Animation.Name == script.Loop.Name then
                            TimePositio = v10.TimePositio
                        end
                    end
                    if TimePositio and Character:FindFirstChild("Torso") then
                        local Sound = Character.Torso:FindFirstChild("Sound")
                        if Sound then
                            TimePosition = Sound.TimePosition
                        end
                    end
                end
            end
        end
        for _, v12 in p_u_3 do
            local v13 = v12:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Loop)
            if v12:IsDescendantOf(workspace) and v_u_4.Mute == false then
                local v14 = script.Sound:Clone()
                v14.Parent = v12:FindFirstChild("Torso")
                v13:Play()
                v13.TimePosition = TimePositio
                v14.TimePosition = TimePosition
                v14:Play()
                v_u_4.Assets.SFX = v14
            else
                v13:Play()
                v13.TimePosition = TimePositio
            end
            local Anims = v_u_4.Anims
            table.insert(Anims, v13)
        end
    end
    return v_u_4
end
return v1
