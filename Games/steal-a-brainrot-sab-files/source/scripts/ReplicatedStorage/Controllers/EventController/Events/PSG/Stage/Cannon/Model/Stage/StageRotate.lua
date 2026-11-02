-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("TweenService")
local v2 = {}
local function v_u_12(p_u_3, p4, p5)
    -- upvalues: (copy) v_u_1
    local v6
    if p_u_3:IsA("Model") then
        v6 = p_u_3:GetPivot()
    elseif p_u_3:IsA("BasePart") then
        v6 = p_u_3.CFrame
    else
        v6 = nil
    end
    local v_u_7 = Instance.new("CFrameValue")
    v_u_7.Value = v6
    local v10 = v_u_7:GetPropertyChangedSignal("Value"):Connect(function()
        -- upvalues: (copy) p_u_3, (copy) v_u_7
        local v8 = p_u_3
        local v9 = v_u_7.Value
        if v8:IsA("Model") then
            v8:PivotTo(v9)
            return
        elseif v8:IsA("BasePart") then
            v8.CFrame = v9
        end
    end)
    local v11 = v_u_1:Create(v_u_7, p5, {
        ["Value"] = p4
    })
    v11:Play()
    v11.Completed:Wait()
    v10:Disconnect()
    v_u_7:Destroy()
end
local function v_u_16(p13, p14)
    local v_u_15 = Instance.new("Sound")
    v_u_15.SoundId = p14
    v_u_15.SoundGroup = game:GetService("SoundService")["Sound Effects"]
    v_u_15.Volume = 3
    v_u_15.Parent = p13
    v_u_15:Play()
    task.delay(5, function()
        -- upvalues: (copy) v_u_15
        if v_u_15 then
            v_u_15:Destroy()
        end
    end)
end
function v2.Play(p17)
    -- upvalues: (copy) v_u_16, (copy) v_u_12
    local v18 = script.Parent
    local v19 = v18:WaitForChild("HeavenBackwalls")
    local v20 = v18:WaitForChild("Rotate")
    local v21 = v18:WaitForChild("TheRomanticBackwalls")
    v_u_16(v21.Light, "rbxassetid://73331373891734")
    local v22
    if v21:IsA("Model") then
        v22 = v21:GetPivot()
    elseif v21:IsA("BasePart") then
        v22 = v21.CFrame
    else
        v22 = nil
    end
    v_u_12(v21, v22 * CFrame.new(0, -100, 0), p17(1))
    v_u_16(v20.FloorConnector, "rbxassetid://139608646997339")
    local v23
    if v20:IsA("Model") then
        v23 = v20:GetPivot()
    elseif v20:IsA("BasePart") then
        v23 = v20.CFrame
    else
        v23 = nil
    end
    local v24 = v23.Position
    local v25 = CFrame.new(v24) * CFrame.Angles(0, 3.141592653589793, 0)
    local v26 = CFrame.new(v24) * CFrame.Angles(0, 0, 0)
    if v20:IsA("Model") then
        v20:PivotTo(v25)
    elseif v20:IsA("BasePart") then
        v20.CFrame = v25
    end
    v_u_12(v20, v26, p17(2))
    v_u_16(v19.Light, "rbxassetid://75173176969126")
    local v27
    if v19:IsA("Model") then
        v27 = v19:GetPivot()
    elseif v19:IsA("BasePart") then
        v27 = v19.CFrame
    else
        v27 = nil
    end
    v_u_12(v19, v27 * CFrame.new(0, 100, -100), p17(3))
end
return v2\0