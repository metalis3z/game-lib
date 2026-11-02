-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal

local TweenService = game:GetService("TweenService")
local Parent = script.Parent
local Gift = Parent:WaitForChild("Gift"):WaitForChild("Gift")
local Shadow = Parent:WaitForChild("Shadow")
local Glow = Parent.Parent:WaitForChild("Glow")
local ImageTransparency = Shadow.ImageTransparency
local ImageTransparency_0 = Glow.ImageTransparency
Parent:GetPropertyChangedSignal("GuiState"):Connect(function()
    if Parent.GuiState == Enum.GuiState.Hover then
        Glow.ImageTransparency = 0.3
        local v8 = {
            ["ImageTransparency"] = ImageTransparency_0
        }
        TweenService:Create(Glow, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v8):Play()
        if not game:GetService("UserInputService").TouchEnabled then
            Gift.Position = UDim2.new(1.05, 0, 0.65, 0)
            TweenService:Create(Gift, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Position"] = UDim2.new(0.65, 0, 0.65, 0)
            }):Play()
        end
        TweenService:Create(Shadow, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ["ImageTransparency"] = 0
        }):Play()
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(1.07, 0, 1.07, 0)
        }):Play()
        return
    elseif Parent.GuiState == Enum.GuiState.Press then
        TweenService:Create(Parent, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(0.94, 0, 0.94, 0)
        }):Play()
    elseif Parent.GuiState == Enum.GuiState.Idle then
        local v9 = {
            ["ImageTransparency"] = ImageTransparency
        }
        TweenService:Create(Shadow, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), v9):Play()
        if not game:GetService("UserInputService").TouchEnabled then
            TweenService:Create(Gift, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ["Position"] = UDim2.new(1.05, 0, 0.65, 0)
            }):Play()
        end
        TweenService:Create(Parent, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(1, 0, 1, 0)
        }):Play()
    end
end)
if game:GetService("UserInputService").TouchEnabled then
    TweenService:Create(Gift, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.new(0.65, 0, 0.65, 0)
    }):Play()
end
