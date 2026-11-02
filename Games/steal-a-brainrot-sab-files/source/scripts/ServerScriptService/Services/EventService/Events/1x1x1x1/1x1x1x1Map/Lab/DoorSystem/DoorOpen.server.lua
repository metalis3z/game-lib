


local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("RunService")
local v3 = script.Parent
local v_u_4 = v3:WaitForChild("Door.R")
local v_u_5 = v3:WaitForChild("Door.L")
local v_u_6 = v3:WaitForChild("Hitbox")
local v_u_7 = {}
local v_u_8 = 0
local function v_u_14(p_u_9, p10, p11)
    if v_u_7[p_u_9] then
        v_u_7[p_u_9]:Destroy()
        v_u_7[p_u_9] = nil
    end
    local v_u_12 = Instance.new("CFrameValue")
    v_u_7[p_u_9] = v_u_12
    v_u_12.Value = p_u_9:GetPivot()
    v_u_12:GetPropertyChangedSignal("Value"):Connect(function()
        p_u_9:PivotTo(v_u_12.Value)
    end)
    local v13 = v_u_1:Create(v_u_12, TweenInfo.new(p11, Enum.EasingStyle.Linear), {
        ["Value"] = p10
    })
    v13.Completed:Connect(function()
        if v_u_7[p_u_9] == v_u_12 then
            v_u_7[p_u_9] = nil
        end
        v_u_12:Destroy()
    end)
    v13:Play()
end
local function v_u_16()
    local v_u_15 = Instance.new("Sound")
    v_u_15.SoundId = "rbxassetid://106038848352876"
    v_u_15.Parent = v_u_6
    v_u_15.Volume = 0.5
    v_u_15:Play()
    v_u_15.Ended:Connect(function()
        v_u_15:Destroy()
    end)
end
local v_u_17 = v_u_4:GetPivot()
local v_u_18 = v_u_5:GetPivot()
local v_u_19 = v_u_17 * CFrame.new(6.5, 0, 0)
local v_u_20 = v_u_18 * CFrame.new(-6.5, 0, 0)
v_u_6.Touched:Connect(function()
    v_u_8 = os.clock() + 2
    if not DoorOpen then
        v_u_16()
        DoorOpen = true
    end
    v_u_14(v_u_4, v_u_19, 0.35)
    v_u_14(v_u_5, v_u_20, 0.35)
end)
v2.Heartbeat:Connect(function()
    if DoorOpen and v_u_8 <= os.clock() then
        DoorOpen = false
        v_u_14(v_u_4, v_u_17, 0.35)
        v_u_14(v_u_5, v_u_18, 0.35)
    end
end)
v_u_6.CanTouch = true
v_u_6.CanCollide = false