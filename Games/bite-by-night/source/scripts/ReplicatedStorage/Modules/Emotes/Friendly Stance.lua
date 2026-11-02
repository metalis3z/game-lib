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
        local v5 = p_u_3[1]
        local v6 = v5 and (v5:FindFirstChild("HumanoidRootPart") and v5.HumanoidRootPart.Position) or Vector3.new(0, 0, 0)
        local TimePosition = 0
        for _, v8 in game:GetService("Players"):GetPlayers() do
            local Character = v8.Character
            if Character then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart and (HumanoidRootPart.Position - v6).Magnitude <= 14 then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        for _, v12 in Humanoid:GetPlayingAnimationTracks() do
                            if v12.Animation.Name == script.Loop.Name then
                                TimePosition = v12.TimePosition
                            end
                        end
                        if TimePosition and Character:FindFirstChild("Torso") then
                            local Sound = Character.Torso:FindFirstChild("Sound")
                            if Sound then
                                local _ = Sound.TimePosition
                            end
                        end
                    end
                end
            end
        end
        for _, v14 in p_u_3 do
            local v15 = v14:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Loop)
            v15:Play()
            v15.TimePosition = TimePosition
            local Anims = v_u_4.Anims
            table.insert(Anims, v15)
        end
    end
    return v_u_4
end
return v1
