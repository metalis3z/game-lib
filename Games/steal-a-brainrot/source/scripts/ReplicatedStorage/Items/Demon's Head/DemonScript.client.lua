local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("TweenService")
game:GetService("StarterPlayer")
local v3 = game:GetService("ReplicatedStorage")
game:GetService("ServerScriptService")
local v_u_4 = v3:WaitForChild("Models").ToolsExtras
local v5 = v3:WaitForChild("Packages")
local v_u_6 = require(v5.Net)
require(v5.Debounce)
local v7 = script.Parent
local v_u_8 = v7.Parent.Parent
local v_u_9 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
local v_u_10 = nil
local v_u_11 = nil
local function v_u_16(p12)
    if v_u_10 then
        local v_u_13 = Instance.new("NumberValue", script)
        v_u_13.Value = p12 and 0.0001 or 1
        v_u_13.Changed:Connect(function(p14)
            if v_u_10 then
                v_u_10:ScaleTo(p14)
            end
        end)
        local v15 = v_u_2:Create(v_u_13, v_u_9, {
            ["Value"] = p12 and 1 or 0.0001
        })
        v15:Play()
        v15.Completed:Connect(function()
            v_u_13:Destroy()
        end)
        v15.Completed:Wait()
    end
end
v7.Activated:Connect(function()
    v_u_6:RemoteEvent("UseItem"):FireServer()
end)
v7.Equipped:Connect(function()
    if v_u_10 then
        v_u_10:Destroy()
    end
    if v_u_11 then
        v_u_11:Disconnect()
    end
    v_u_8.Character:WaitForChild("Humanoid"):WaitForChild("Animator")
    v_u_10 = v_u_4.Ring:Clone()
    v_u_10.Name = ("%*.Ring"):format(v_u_8.Name)
    v_u_10:PivotTo(v_u_8.Character:GetPivot())
    local v17 = v_u_10.Union
    local v18 = v_u_10.Union.Size.Y
    v17.Size = Vector3.new(40, v18, 40)
    v_u_10.Parent = workspace
    v_u_16(true)
    local v19 = v_u_8.Character
    if v19 then
        v19 = v19:FindFirstChildOfClass("Humanoid")
    end
    if v19 then
        v19.Died:Once(function()
            local v20 = workspace:FindFirstChild((("%*.Ring"):format(v_u_8.Name)))
            if v20 then
                v20:Destroy()
            end
            if v_u_11 then
                v_u_11:Disconnect()
            end
        end)
    end
    v_u_11 = v_u_1.Heartbeat:Connect(function()

        local v21 = v_u_8.Character
        local v22
        if v21 then
            v22 = v21:FindFirstChild("HumanoidRootPart")
        else
            v22 = v21
        end
        if v22 and v22.Parent then
            if v21 then
                v21 = v21:FindFirstChildOfClass("Humanoid")
            end
            if v21 then
                if v_u_10 then
                    local v23 = 0 - v21.HipHeight - v22.Size.Y * 0.5 + v_u_10.Union.Size.Y * 0.5
                    v_u_10:PivotTo(v22:GetPivot() * CFrame.new(0, v23, 0))
                end
            end
        else
            return
        end
    end)
end)
v7.Unequipped:Connect(function()
    if v_u_11 then
        v_u_11:Disconnect()
        v_u_11 = nil
    end
    v_u_16(false)
    if v_u_11 then
        v_u_11:Disconnect()
        v_u_11 = nil
    end
    if v_u_10 then
        v_u_10:Destroy()
        v_u_10 = nil
    end
end)