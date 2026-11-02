


local v_u_1 = game:GetService("TweenService")
local v2 = script.Parent
local v3 = { v2:WaitForChild("Arrow1"), v2:WaitForChild("Arrow2"), v2:WaitForChild("Arrow3") }
local function v9(p_u_4, p5, p6)
    local v_u_7 = Instance.new("CFrameValue")
    v_u_7.Value = p_u_4:GetPivot()
    v_u_7:GetPropertyChangedSignal("Value"):Connect(function()
        p_u_4:PivotTo(v_u_7.Value)
    end)
    local v8 = v_u_1:Create(v_u_7, TweenInfo.new(p6, Enum.EasingStyle.Linear), {
        ["Value"] = p5
    })
    v8.Completed:Connect(function()
        v_u_7:Destroy()
    end)
    v8:Play()
    v8.Completed:Wait()
end
while script:IsDescendantOf(workspace) do
    for _, v10 in ipairs(v3) do
        local v11 = v10:GetPivot()
        v9(v10, v11 * CFrame.new(0, -1.5, 0), 0.15)
        v9(v10, v11 * CFrame.new(0, 3, 0), 0.075)
        v9(v10, v11, 0.15)
        task.wait(0.05)
    end
end