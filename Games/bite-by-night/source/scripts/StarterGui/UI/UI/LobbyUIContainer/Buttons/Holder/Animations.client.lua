-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent
local TweenService = game:GetService("TweenService")
local v_u_3 = {}
local v_u_4 = ""
local v_u_5 = game.Players.LocalPlayer:GetMouse()
local HoverLabel = script.Parent.Parent:WaitForChild("HoverLabel")
function FollowMouse()
    TweenService:Create(HoverLabel, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromOffset(v_u_5.X + 20, v_u_5.Y + 50)
    }):Play()
end
local function v_u_20(p7, p8)
    local Text = p7.Text
    local v_u_10 = { "#", "\226\128\150" }
    local v11 = v_u_4
    local function v16(p12, p13)
        local v14 = ""
        for v15 = 1, #Text do
            v14 = v14 .. (v15 <= p12 and Text:sub(v15, v15) or v_u_10[p13])
        end
        return v14
    end
    local v17 = p8 or 0.005
    for v18 = 0, #Text do
        if v_u_4 ~= v11 then
            break
        end
        if v18 == 0 then
            p7.Text = v16(0, 2)
            task.wait(v17)
        else
            for v19 = 1, 4 do
                p7.Text = v16(v18 - 1, (v19 - 1) % 2 + 1)
                task.wait(0.0025)
            end
            p7.Text = v16(v18, 1)
            if v18 < #Text then
                task.wait(v17)
            end
        end
    end
    if v_u_4 == v11 then
        p7.Text = Text
    else
        p7.Text = ""
    end
end
local Name = v_u_4
local function v_u_29(p_u_22)
    HoverLabel.Shadow.ImageTransparency = 1
    HoverLabel.Text.TextTransparency = 1
    TweenService:Create(HoverLabel.Shadow, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["ImageTransparency"] = 0.39
    }):Play()
    TweenService:Create(HoverLabel.Text, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        ["TextTransparency"] = 0
    }):Play()
    HoverLabel:WaitForChild("Text").Text = p_u_22.Parent.Name:gsub("(.)", "%1 ")
    TweenService:Create(p_u_22, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.1, 0, 1.1, 0)
    }):Play()
    TweenService:Create(p_u_22:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1.2, 0, 1.2, 0),
        ["ImageTransparency"] = 0.53
    }):Play()
    TweenService:Create(p_u_22:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_22:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.3
    }):Play()
    local v_u_23 = p_u_22:WaitForChild("Holder"):WaitForChild("Outer"):Clone()
    p_u_22.Parent.ZIndex = 1000
    v_u_23.Name = "Stroke"
    v_u_23.Parent = p_u_22:WaitForChild("Holder")
    v_u_23.ZIndex = 5
    v_u_23.Thickness = 0.06
    local v24 = TweenService:Create(v_u_23, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["BorderOffset"] = UDim.new(0.15, 0),
        ["Transparency"] = 1,
        ["Thickness"] = 0.03
    })
    v24:Play()
    v24.Completed:Connect(function()
        v_u_23:Destroy()
    end)
    v_u_3[p_u_22] = true
    task.spawn(function()
        while v_u_3[p_u_22] do
            p_u_22:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_22:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_22:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_22:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_22:WaitForChild("Holder"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_22] do
            FollowMouse()
            task.wait()
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_22] do
            task.wait(math.random(0, 0.7))
            p_u_22:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, 0, 0)
            local v25 = TweenService
            local Line = p_u_22:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line")
            local v27 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v28 = {
                ["Position"] = UDim2.new(1, 0, 1, 0)
            }
            v25:Create(Line, v27, v28):Play()
            task.wait(math.random(3, 5))
        end
    end)
    v_u_20(HoverLabel:WaitForChild("Text"))
end
local function v_u_31(p30)
    p30.Parent.ZIndex = 1000
    TweenService:Create(p30, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.86, 0, 0.86, 0)
    }):Play()
end
local function v_u_33(p32)
    p32.Parent.ZIndex = 1
    v_u_3[p32] = nil
    TweenService:Create(p32, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p32:WaitForChild("Holder"):WaitForChild("Shadow"), TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0),
        ["ImageTransparency"] = 0.73
    }):Play()
    TweenService:Create(p32:WaitForChild("Holder"):WaitForChild("Pixel"), TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p32:WaitForChild("Holder"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    HoverLabel.Shadow.ImageTransparency = 1
    HoverLabel.Text.TextTransparency = 1
end
for _, v_u_34 in pairs(Parent:GetChildren()) do
    if v_u_34:IsA("Frame") then
        local Button = v_u_34:WaitForChild("Button")
        HoverLabel.Shadow.ImageTransparency = 1
        HoverLabel.Text.TextTransparency = 1
        Button:GetPropertyChangedSignal("GuiState"):Connect(function()
            if Button.GuiState == Enum.GuiState.Hover then
                Name = v_u_34.Name
                v_u_29(Button)
                return
            elseif Button.GuiState == Enum.GuiState.Press then
                v_u_31(Button)
            elseif Button.GuiState == Enum.GuiState.Idle then
                Name = ""
                v_u_33(Button)
            end
        end)
    end
end
