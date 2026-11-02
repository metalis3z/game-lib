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
        for _, v15 in p_u_3 do
            local v16 = v15:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Loop)
            if v15:IsDescendantOf(workspace) and v_u_4.Mute == false then
                local v17 = script.Sound:Clone()
                v17.Parent = v15:FindFirstChild("Torso")
                v16:Play()
                v16.TimePosition = TimePosition
                v17.TimePosition = TimePosition_0
                v17:Play()
                local v18 = script["LeftLeg Ring"]:Clone()
                v18["Ring5 Weld"].Part0 = v15:FindFirstChild("Left Leg")
                v18["Ring6 Weld"].Part0 = v15:FindFirstChild("Left Leg")
                v18.Parent = v15
                local v19 = script["RightLeg Ring"]:Clone()
                v19["Ring3 Weld"].Part0 = v15:FindFirstChild("Right Leg")
                v19["Ring4 Weld"].Part0 = v15:FindFirstChild("Right Leg")
                v19.Parent = v15
                local v20 = script.TorsoRing:Clone()
                v20["Ring1 Weld"].Part0 = v15:FindFirstChild("Torso")
                v20["Ring2 Weld"].Part0 = v15:FindFirstChild("Torso")
                v20.Parent = v15
                local v_u_21 = script:FindFirstChild("Effects"):Clone()
                v_u_21.Parent = v15
                v_u_21.Enabled = true
                v16:GetMarkerReachedSignal("TorsoPush"):Connect(function()
                    if not game:GetService("RunService"):IsClient() then
                        v_u_21.Server:FireAllClients(1)
                    end
                end)
                v16:GetMarkerReachedSignal("LegPush"):Connect(function()
                    if not game:GetService("RunService"):IsClient() then
                        v_u_21.Server:FireAllClients(2)
                    end
                end)
                local Assets = v_u_4.Assets
                table.insert(Assets, v18)
                local Assets_0 = v_u_4.Assets
                table.insert(Assets_0, v19)
                local Assets_1 = v_u_4.Assets
                table.insert(Assets_1, v20)
                local Assets_2 = v_u_4.Assets
                table.insert(Assets_2, v_u_21)
                v_u_4.Assets.SFX = v17
            else
                v16:Play()
                v16.TimePosition = TimePosition
            end
            local Anims = v_u_4.Anims
            table.insert(Anims, v16)
        end
    end
    return v_u_4
end
return v1
