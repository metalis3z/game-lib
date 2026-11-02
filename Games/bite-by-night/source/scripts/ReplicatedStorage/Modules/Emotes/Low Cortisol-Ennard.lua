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
        local TimePosition_0 = 0
        for _, v9 in game:GetService("Players"):GetPlayers() do
            local Character = v9.Character
            if Character then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart and (HumanoidRootPart.Position - v6).Magnitude <= 14 then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        for _, v13 in Humanoid:GetPlayingAnimationTracks() do
                            if v13.Animation.Name == script.Loop.Name then
                                TimePosition = v13.TimePosition
                            end
                        end
                        if TimePosition and Character:FindFirstChild("Torso") then
                            local Sound = Character.Torso:FindFirstChild("Sound")
                            if Sound then
                                TimePosition_0 = Sound.TimePosition
                            end
                        end
                    end
                end
            end
        end
        for _, v_u_15 in p_u_3 do
            local v16 = v_u_15:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Loop)
            if v_u_15:IsDescendantOf(workspace) and v_u_4.Mute == false then
                v_u_15:SetAttribute("CustomSpeed", 6)
                v_u_15:AddTag("CustomSpeed")
                local v17 = script.Sound:Clone()
                v17.Parent = v_u_15:FindFirstChild("RootPart")
                v17.TimePosition = TimePosition_0
                v17:Play()
                v_u_4.Assets.SFX = v17
                v16:Play()
                v16.TimePosition = TimePosition
            else
                v16:Play()
                v16.TimePosition = TimePosition
            end
            v16.Stopped:Once(function()
                v_u_15:RemoveTag("CustomSpeed")
                v_u_4.Stop()
            end)
            local Anims = v_u_4.Anims
            table.insert(Anims, v16)
        end
        for _, v19 in p_u_3 do
            if v19:FindFirstChildOfClass("Humanoid").MoveDirection ~= Vector3.new(0, 0, 0) then
                v_u_4.Stop()
                return
            end
        end
    end
    return v_u_4
end
return v1
