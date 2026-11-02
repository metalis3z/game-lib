-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
local v_u_3 = {}
local v_u_4 = game.Players.LocalPlayer:GetMouse()
local HoverLabel = script.Parent.Parent:WaitForChild("HoverLabel")
function FollowMouse()
    TweenService:Create(HoverLabel, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromOffset(v_u_4.X + 20, v_u_4.Y + 50)
    }):Play()
end
local function v_u_13(p_u_6)
    HoverLabel.Shadow.ImageTransparency = 1
    HoverLabel.Text.TextTransparency = 1
    TweenService:Create(HoverLabel.Shadow, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["ImageTransparency"] = 0.39
    }):Play()
    TweenService:Create(HoverLabel.Text, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["TextTransparency"] = 0
    }):Play()
    HoverLabel:WaitForChild("Text").Text = p_u_6.Parent.Name:gsub("(.)", "%1 ")
    TweenService:Create(p_u_6, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.1, 0, 1.1, 0)
    }):Play()
    TweenService:Create(p_u_6:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.2, 0, 1.2, 0),
        ["ImageTransparency"] = 0.53
    }):Play()
    TweenService:Create(p_u_6:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_6:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.3
    }):Play()
    local v_u_7 = p_u_6:WaitForChild("Holder"):WaitForChild("Outer"):Clone()
    p_u_6.Parent.ZIndex = 1000
    v_u_7.Name = "Stroke"
    v_u_7.Parent = p_u_6:WaitForChild("Holder")
    v_u_7.ZIndex = 5
    v_u_7.Thickness = 0.06
    local v8 = TweenService:Create(v_u_7, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["BorderOffset"] = UDim.new(0.15, 0),
        ["Transparency"] = 1,
        ["Thickness"] = 0.03
    })
    v8:Play()
    v8.Completed:Connect(function()
        v_u_7:Destroy()
    end)
    v_u_3[p_u_6] = true
    task.spawn(function()
        while v_u_3[p_u_6] do
            p_u_6:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_6:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_6:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_6:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_6:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_6] do
            FollowMouse()
            task.wait()
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_6] do
            task.wait(math.random(0, 0.7))
            p_u_6:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, 0, 0)
            local v9 = TweenService
            local Line = p_u_6:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line")
            local v11 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v12 = {
                ["Position"] = UDim2.new(1, 0, 1, 0)
            }
            v9:Create(Line, v11, v12):Play()
            task.wait(math.random(3, 5))
        end
    end)
end
local function v_u_15(p14)
    p14.Parent.ZIndex = 1000
    TweenService:Create(p14, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.86, 0, 0.86, 0)
    }):Play()
    HoverLabel.Visible = false
end
local function v_u_17(p16)
    HoverLabel.Visible = true
    p16.Parent.ZIndex = 1
    v_u_3[p16] = nil
    TweenService:Create(p16, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p16:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["ImageTransparency"] = 0.73
    }):Play()
    TweenService:Create(p16:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p16:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    HoverLabel.Shadow.ImageTransparency = 1
    HoverLabel.Text.TextTransparency = 1
end
for _, v18 in pairs(Parent:GetChildren()) do
    if v18:IsA("Frame") then
        local Button = v18:WaitForChild("Button")
        HoverLabel.Shadow.ImageTransparency = 1
        HoverLabel.Text.TextTransparency = 1
        Button:GetPropertyChangedSignal("GuiState"):Connect(function()
            if Button.GuiState == Enum.GuiState.Hover then
                v_u_13(Button)
                return
            elseif Button.GuiState == Enum.GuiState.Press then
                v_u_15(Button)
            elseif Button.GuiState == Enum.GuiState.Idle then
                v_u_17(Button)
            end
        end)
    end
end
