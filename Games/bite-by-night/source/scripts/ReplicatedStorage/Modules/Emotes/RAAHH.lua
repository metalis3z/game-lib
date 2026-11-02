-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
game:GetService("ReplicatedStorage")
local m_EmoteClass = require(script.Parent.EmoteClass)
function v1.new(p_u_3)
    local v_u_4 = m_EmoteClass.new(p_u_3)
    v_u_4.Traversal = true
    function v_u_4.EmoteFunc()
        v_u_4.NAME = script.Name
        v_u_4.CheckFunc()
        for _, v_u_5 in p_u_3 do
            local v6 = v_u_5:FindFirstChildOfClass("Humanoid"):LoadAnimation(script.Anim)
            v6.Priority = Enum.AnimationPriority.Action4
            v_u_5:SetAttribute("CustomSpeed", 6)
            v_u_5:AddTag("CustomSpeed")
            local v7 = script.SpartanShield:Clone()
            local v8 = script.Sword:Clone()
            v8.Weld.Part0 = v_u_5:FindFirstChild("Right Arm")
            v7.Weld.Part0 = v_u_5:FindFirstChild("Left Arm")
            v7.Parent = v_u_5
            v8.Parent = v_u_5
            if v_u_5:IsDescendantOf(workspace) and v_u_4.Mute == false then
                local v9 = script.Sound:Clone()
                v9.Parent = v_u_5:FindFirstChild("Torso")
                v6:Play()
                v9:Play()
                v_u_4.Assets.SFX = v9
            else
                v6:Play()
                v6.Looped = true
            end
            v6.Stopped:Once(function()
                v_u_5:RemoveTag("CustomSpeed")
                v_u_4.Stop()
            end)
            local Anims = v_u_4.Anims
            table.insert(Anims, v6)
            local Assets = v_u_4.Assets
            table.insert(Assets, v7)
            local Assets_0 = v_u_4.Assets
            table.insert(Assets_0, v8)
        end
    end
    return v_u_4
end
return v1
