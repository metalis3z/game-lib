-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Page = script.Parent.Parent:WaitForChild("Page")
local UIPageLayout = Page:WaitForChild("UIPageLayout")
local TweenService = game:GetService("TweenService")
local v_u_4 = {}
local function v_u_10(p_u_5)
    TweenService:Create(p_u_5, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.96, 0, 0.96, 0)
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.55
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_5:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.86
    }):Play()
    p_u_5.Parent.ZIndex = 1000
    v_u_4[p_u_5] = true
    task.spawn(function()
        while v_u_4[p_u_5] do
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
        while v_u_4[p_u_5] do
            task.wait(math.random(0, 0.7))
            p_u_5:WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, -0.4, 0)
            local v6 = TweenService
            local Line = p_u_5:WaitForChild("Container"):WaitForChild("Line")
            local v8 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v9 = {
                ["Position"] = UDim2.new(0, 0, 1, 0)
            }
            v6:Create(Line, v8, v9):Play()
            task.wait(math.random(3, 5))
        end
    end)
end
local function v_u_12(p11)
    p11.Parent.ZIndex = 1
    v_u_4[p11] = nil
    TweenService:Create(p11, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p11:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p11:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p11:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
end
for _, v_u_13 in pairs(script.Parent:GetChildren()) do
    if v_u_13:IsA("Frame") then
        v_u_13:GetPropertyChangedSignal("GuiState"):Connect(function()
            if v_u_13.GuiState == Enum.GuiState.Hover then
                v_u_10(v_u_13:WaitForChild("Button"))
            elseif v_u_13.GuiState == Enum.GuiState.Idle then
                v_u_12(v_u_13:WaitForChild("Button"))
            end
        end)
        v_u_13:WaitForChild("Button").MouseButton1Down:Connect(function()
            UIPageLayout:JumpTo(Page:WaitForChild(v_u_13.Name))
        end)
    end
end
