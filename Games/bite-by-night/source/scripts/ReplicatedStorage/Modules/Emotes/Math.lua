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
            local v_u_17 = script.LeftHand:Clone()
            local v_u_18 = script.RightHand:Clone()
            local v19 = v15:FindFirstChild("Right Arm") and v15["Right Arm"].Color or Color3.new(1, 1, 1)
            local v20 = next
            local v21, v22 = v_u_18:GetDescendants()
            for _, v23 in v20, v21, v22 do
                if v23:IsA("BasePart") then
                    v23.Color = v19
                end
            end
            local v24 = v15:FindFirstChild("Left Arm") and v15["Left Arm"].Color or Color3.new(1, 1, 1)
            local v25 = next
            local v26, v27 = v_u_17:GetDescendants()
            for _, v28 in v25, v26, v27 do
                if v28:IsA("BasePart") then
                    v28.Color = v24
                end
            end
            local v_u_29 = v_u_18["Right Arm->RightHand"]
            v_u_29.Part0 = v15:FindFirstChild("Right Arm")
            v_u_29.Parent = v15:FindFirstChild("Right Arm")
            local v_u_30 = v_u_17["Left Arm->LeftHand"]
            v_u_30.Part0 = v15:FindFirstChild("Left Arm")
            v_u_30.Parent = v15:FindFirstChild("Left Arm")
            v_u_18.Parent = v15
            v_u_17.Parent = v15
            if v15:IsDescendantOf(workspace) and v_u_4.Mute == false then
                local v31 = script.Sound:Clone()
                v31.Parent = v15:FindFirstChild("Torso")
                v16:Play()
                v16.TimePosition = TimePosition
                v31.TimePosition = TimePosition_0
                v31:Play()
                v_u_4.Assets.SFX = v31
            else
                v16:Play()
                v16.TimePosition = TimePosition
            end
            v16.Stopped:Once(function()
                v_u_18:Destroy()
                v_u_17:Destroy()
                v_u_29:Destroy()
                v_u_30:Destroy()
            end)
            local Anims = v_u_4.Anims
            table.insert(Anims, v16)
        end
    end
    return v_u_4
end
return v1
