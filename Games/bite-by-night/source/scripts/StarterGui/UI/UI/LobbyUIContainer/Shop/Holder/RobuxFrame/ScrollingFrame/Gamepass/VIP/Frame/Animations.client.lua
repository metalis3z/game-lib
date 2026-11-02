-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local _ = script.Parent
local TweenService = game:GetService("TweenService")
local Parent = script.Parent
if game:GetService("UserInputService").TouchEnabled then
    TweenService:Create(Parent:WaitForChild("Container"):WaitForChild("Gift"), TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.032, 0, 0.907, 0)
    }):Play()
end
local function v_u_4(p3)
    if not game:GetService("UserInputService").TouchEnabled then
        p3:WaitForChild("Container"):WaitForChild("Gift").Position = UDim2.new(0.032, 0, 1.5, 0)
        TweenService:Create(p3:WaitForChild("Container"):WaitForChild("Gift"), TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Position"] = UDim2.new(0.032, 0, 0.907, 0)
        }):Play()
    end
    TweenService:Create(p3, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.025, 0, 1.025, 0)
    }):Play()
    TweenService:Create(p3:WaitForChild("Container"):WaitForChild("Shine"), TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    TweenService:Create(p3:WaitForChild("Shine"), TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.9
    }):Play()
    p3.Parent.ZIndex = 1000
end
local function v_u_6(p5)
    p5.Parent.ZIndex = 1
    if not game:GetService("UserInputService").TouchEnabled then
        TweenService:Create(p5:WaitForChild("Container"):WaitForChild("Gift"), TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["Position"] = UDim2.new(0.032, 0, 1.5, 0)
        }):Play()
    end
    TweenService:Create(p5:WaitForChild("Container"):WaitForChild("Shine"), TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.56
    }):Play()
    TweenService:Create(p5:WaitForChild("Shine"), TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.94
    }):Play()
    TweenService:Create(p5, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
end
local function v_u_8(p7)
    p7.Parent.ZIndex = 1000
    TweenService:Create(p7, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.96, 0, 0.96, 0)
    }):Play()
end
Parent:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent.GuiState == Enum.GuiState.Hover then
        v_u_4(Parent)
        return
    elseif Parent.GuiState == Enum.GuiState.Press then
        v_u_8(Parent)
    elseif Parent.GuiState == Enum.GuiState.Idle then
        v_u_6(Parent)
    end
end)
