-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local _ = script.Parent
local TweenService = game:GetService("TweenService")
local v_u_2 = {}
local Parent = script.Parent.Parent
local function v_u_11(p_u_4)
    TweenService:Create(p_u_4, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.1, 0, 1.1, 0)
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.2, 0, 1.2, 0),
        ["ImageTransparency"] = 0.53
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.3
    }):Play()
    local v_u_5 = p_u_4:WaitForChild("Holder"):WaitForChild("Outer"):Clone()
    p_u_4.Parent.ZIndex = 1000
    v_u_5.Name = "Stroke"
    v_u_5.Parent = p_u_4:WaitForChild("Holder")
    v_u_5.ZIndex = 5
    v_u_5.Thickness = 0.06
    local v6 = TweenService:Create(v_u_5, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["BorderOffset"] = UDim.new(0.15, 0),
        ["Transparency"] = 1,
        ["Thickness"] = 0.03
    })
    v6:Play()
    v6.Completed:Connect(function()
        v_u_5:Destroy()
    end)
    v_u_2[p_u_4] = true
    task.spawn(function()
        while v_u_2[p_u_4] do
            p_u_4:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_4:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_4:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_4:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_4:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_2[p_u_4] do
            task.wait(math.random(0, 0.7))
            p_u_4:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, 0, 0)
            local v7 = TweenService
            local Line = p_u_4:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line")
            local v9 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v10 = {
                ["Position"] = UDim2.new(1, 0, 1, 0)
            }
            v7:Create(Line, v9, v10):Play()
            task.wait(math.random(3, 5))
        end
    end)
end
local function v_u_13(p12)
    p12.Parent.ZIndex = 1
    v_u_2[p12] = nil
    TweenService:Create(p12, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p12:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["ImageTransparency"] = 0.73
    }):Play()
    TweenService:Create(p12:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p12:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
end
local function v_u_15(p14)
    p14.Parent.ZIndex = 1000
    TweenService:Create(p14, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.86, 0, 0.86, 0)
    }):Play()
end
Parent:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent.GuiState == Enum.GuiState.Hover then
        v_u_11(Parent)
        return
    elseif Parent.GuiState == Enum.GuiState.Press then
        v_u_15(Parent)
    elseif Parent.GuiState == Enum.GuiState.Idle then
        v_u_13(Parent)
    end
end)
