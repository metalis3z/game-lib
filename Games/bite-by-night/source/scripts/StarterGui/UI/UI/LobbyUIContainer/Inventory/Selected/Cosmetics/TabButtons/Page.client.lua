-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local Parent = script.Parent.Parent
local TweenService = game:GetService("TweenService")
local v_u_3 = {}
local function v_u_9(p_u_4)
    TweenService:Create(p_u_4, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(0.96, 0, 0.96, 0)
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.55
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.4
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.86
    }):Play()
    p_u_4.Parent.ZIndex = 1000
    v_u_3[p_u_4] = true
    task.spawn(function()
        while v_u_3[p_u_4] do
            p_u_4:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_4:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_4:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_4:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_4:WaitForChild("Container"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_4] do
            task.wait(math.random(0, 0.7))
            p_u_4:WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, -0.4, 0)
            local v5 = TweenService
            local Line = p_u_4:WaitForChild("Container"):WaitForChild("Line")
            local v7 = TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
            local v8 = {
                ["Position"] = UDim2.new(0, 0, 1, 0)
            }
            v5:Create(Line, v7, v8):Play()
            task.wait(math.random(3, 5))
        end
    end)
end
local function v_u_11(p10)
    p10.Parent.ZIndex = 1
    v_u_3[p10] = nil
    TweenService:Create(p10, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.new(1, 0, 1, 0)
    }):Play()
    TweenService:Create(p10:WaitForChild("Shadow2"), TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p10:WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    TweenService:Create(p10:WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
end
for _, v_u_12 in pairs(script.Parent:GetChildren()) do
    if v_u_12:IsA("Frame") then
        v_u_12:GetPropertyChangedSignal("GuiState"):Connect(function()
            if v_u_12.GuiState == Enum.GuiState.Hover then
                v_u_9(v_u_12:WaitForChild("Button"))
            elseif v_u_12.GuiState == Enum.GuiState.Idle then
                v_u_11(v_u_12:WaitForChild("Button"))
            end
        end)
        v_u_12:WaitForChild("Button").MouseButton1Down:Connect(function()
            if v_u_12.Name == "Emotes" then
                Parent:WaitForChild("Emotes").Visible = true
                Parent:WaitForChild("Skins").Visible = false
            elseif v_u_12.Name == "Skins" then
                Parent:WaitForChild("Emotes").Visible = false
                Parent:WaitForChild("Skins").Visible = true
            end
        end)
    end
end
