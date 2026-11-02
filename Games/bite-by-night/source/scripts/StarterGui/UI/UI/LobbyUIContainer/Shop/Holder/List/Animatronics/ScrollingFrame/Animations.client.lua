-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local v_u_3 = {}
local function v_u_9(p_u_4)
    p_u_4.ZIndex = 100
    TweenService:Create(p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0.91
    }):Play()
    TweenService:Create(p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 0.9
    }):Play()
    v_u_3[p_u_4] = true
    task.spawn(function()
        while v_u_3[p_u_4] do
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel").Rotation = 0
            task.wait(0.04)
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel").Rotation = 90
            task.wait(0.04)
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel").Rotation = 180
            task.wait(0.04)
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel").Rotation = 270
            task.wait(0.04)
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel").Rotation = 360
        end
    end)
    task.spawn(function()
        while v_u_3[p_u_4] do
            task.wait(math.random(0, 0.7))
            p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Line").Position = UDim2.new(0, 0, -0.1, 0)
            local v5 = TweenService
            local Line = p_u_4:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Line")
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
    TweenService:Create(p10:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Line"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Transparency"] = 1
    }):Play()
    TweenService:Create(p10:WaitForChild("Button"):WaitForChild("Container"):WaitForChild("Pixel"), TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    p10.ZIndex = 1
    v_u_3[p10] = nil
end
for _, v_u_12 in pairs(Parent:GetChildren()) do
    if v_u_12:IsA("Frame") then
        v_u_12:GetPropertyChangedSignal("GuiState"):Connect(function()
            v_u_12:GetPropertyChangedSignal("GuiState"):Connect(function()
                if v_u_12.GuiState == Enum.GuiState.Hover then
                    v_u_9(v_u_12)
                    return
                elseif v_u_12.GuiState ~= Enum.GuiState.Press then
                    if v_u_12.GuiState == Enum.GuiState.Idle then
                        v_u_11(v_u_12)
                    end
                end
            end)
        end)
    end
end
