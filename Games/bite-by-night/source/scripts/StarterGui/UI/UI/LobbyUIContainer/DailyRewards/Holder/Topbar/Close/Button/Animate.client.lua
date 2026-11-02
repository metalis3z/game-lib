-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
local v_u_3 = {}
local Parent_0 = script.Parent
local function v_u_12(p_u_5)
    TweenService:Create(p_u_5, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.95, 0, 0.95, 0)
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.3
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.85
    }):Play()
    local v_u_6 = p_u_5:WaitForChild("Outer"):Clone()
    p_u_5.Parent.ZIndex = 1000
    v_u_6.Name = "Stroke"
    v_u_6.Parent = p_u_5
    v_u_6.ZIndex = 5
    v_u_6.Thickness = 0.06
    local v7 = TweenService:Create(v_u_6, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["BorderOffset"] = UDim.new(0.15, 0),
        ["Transparency"] = 1,
        ["Thickness"] = 0.03
    })
    v7:Play()
    v7.Completed:Connect(function()
        v_u_6:Destroy()
    end)
    v_u_3[p_u_5] = true
    task.spawn(function()
        while v_u_3[p_u_5] do
            p_u_5:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_5:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_5:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_5:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_5:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_5] do
            task.wait(math.random(0, 0.7))
            p_u_5:WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, -0.3, 0)
            local v8 = TweenService
            local Line = p_u_5:WaitForChild("Container"):WaitForChild("Line")
            local v10 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v11 = {
                ["Position"] = UDim2.new(0, 0, 1, 0)
            }
            v8:Create(Line, v10, v11):Play()
            task.wait(math.random(3, 5))
        end
    end)
end
local function v_u_14(p13)
    p13.Parent.ZIndex = 1
    v_u_3[p13] = nil
    TweenService:Create(p13, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p13:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p13:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p13:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
end
local function v_u_17(p15)
    p15.Parent.ZIndex = 1000
    TweenService:Create(p15, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.9, 0, 0.9, 0)
    }):Play()
    local Parent_1 = Parent.Parent.Parent.Parent.Parent
    Parent_1.Parent = game:GetService("Players").LocalPlayer.PlayerGui.UI.Transitions.DailyRewards
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.PlayerGui.UI.Transitions.DailyRewards, TweenInfo.new(0.5), {
        ["GroupTransparency"] = 1
    }):Play()
    task.delay(1, function()
        Parent_1.Visible = false
    end)
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UI"):FindFirstChild("sfx"):FindFirstChild("close_pop_up"):Play()
end
Parent_0:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent_0.GuiState == Enum.GuiState.Hover then
        v_u_12(Parent_0)
        return
    elseif Parent_0.GuiState == Enum.GuiState.Press then
        v_u_17(Parent_0)
    elseif Parent_0.GuiState == Enum.GuiState.Idle then
        v_u_14(Parent_0)
    end
end)
