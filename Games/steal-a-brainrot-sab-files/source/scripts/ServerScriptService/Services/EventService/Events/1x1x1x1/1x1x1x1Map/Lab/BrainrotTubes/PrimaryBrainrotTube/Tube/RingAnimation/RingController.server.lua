


local v_u_1 = game:GetService("TweenService")
local v_u_2 = script.Parent
local v_u_3 = v_u_2:WaitForChild("Ring")
local function v7()
    local v_u_4 = v_u_3:Clone()
    v_u_4.Parent = v_u_2
    v_u_4.CFrame = v_u_3.CFrame
    local v5 = v_u_1:Create(v_u_4, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["CFrame"] = v_u_4.CFrame * CFrame.new(0, 20, 0)
    })
    local v6 = v_u_1:Create(v_u_4, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        ["Transparency"] = 1
    })
    v5:Play()
    v6:Play()
    task.delay(1.55, function()
        v_u_4:Destroy()
    end)
end
while true do
    v7()
    task.wait(0.75)
end