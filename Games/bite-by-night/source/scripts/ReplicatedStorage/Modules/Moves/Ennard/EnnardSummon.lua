-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local v1 = {}
local m_EffectUtility = require(game:GetService("ReplicatedStorage").Modules.EffectUtility)
function v1.Activate(p_u_3)
    local v_u_4 = p_u_3[1]:FindFirstChildOfClass("Humanoid"):LoadAnimation(p_u_3[2])
    v_u_4.Priority = Enum.AnimationPriority.Action4
	v_u_4:Play()
	
    local v_u_5 = script.vfx.stuf:Clone()
    v_u_5.CFrame = p_u_3[1]:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(-3.328, -3.762, -0.674)
	v_u_5.Parent = p_u_3[1]
	
    task.delay(15, v_u_5.Destroy, v_u_5)
    local v_u_6 = script.vfx:FindFirstChild("1"):Clone()
    v_u_6.Parent = p_u_3[1]:FindFirstChild("RootPart")
    task.delay(15, v_u_6.Destroy, v_u_6)
    local v_u_7 = script.vfx:FindFirstChild("2"):Clone()
    v_u_7.Parent = p_u_3[1]:FindFirstChild("RootPart")
    task.delay(15, v_u_7.Destroy, v_u_7)
    local v_u_8 = script.vfx:FindFirstChild("3"):Clone()
    v_u_8.Parent = p_u_3[1]:FindFirstChild("RootPart"):FindFirstChild("Head", true)
	task.delay(15, v_u_8.Destroy, v_u_8)
	
    v_u_4:GetMarkerReachedSignal("vfx1"):Once(function()
        local v9 = v_u_8
        m_EffectUtility.EmitAttachment(v9)
        m_EffectUtility.ToggleAttachment(v9, true, 1)
        local v10 = v_u_5
        m_EffectUtility.EmitAttachment(v10)
        m_EffectUtility.ToggleAttachment(v10, true, 1)
        local v11 = v_u_8
        for _, v12 in ipairs(v11:GetDescendants()) do
            if v12:IsA("PointLight") then
                v12.Enabled = true
            end
        end
	end)
	
    v_u_4:GetMarkerReachedSignal("vfx2"):Once(function()
        local v13 = v_u_6
        m_EffectUtility.EmitAttachment(v13)
        local v14 = v_u_6
        m_EffectUtility.TweenBeamTransparency(v14, {
            ["transparency"] = 1,
            ["duration"] = 1,
            ["speed"] = 0,
            ["beamEasingStyle"] = Enum.EasingStyle.Sine,
            ["beamEasingDirection"] = Enum.EasingDirection.Out
        })
        local v15 = v_u_8
        for _, v16 in ipairs(v15:GetDescendants()) do
            if v16:IsA("PointLight") then
                v16.Enabled = false
            end
        end
	end)
	
    v_u_4:GetMarkerReachedSignal("vfx3"):Once(function()
        local v17 = v_u_7
        m_EffectUtility.EmitAttachment(v17)
	end)
	
    local v_u_18 = nil
    v_u_18 = p_u_3[1]:GetAttributeChangedSignal("InAbility"):Connect(function()
        if p_u_3[1]:GetAttribute("InAbility") == false then
            v_u_4:Stop()
            v_u_18:Disconnect()
        end
	end)
	
    v_u_4.Stopped:Once(function()
        v_u_5:Destroy()
        v_u_6:Destroy()
        v_u_7:Destroy()
        v_u_8:Destroy()
        v_u_18:Disconnect()
    end)
end
return v1
