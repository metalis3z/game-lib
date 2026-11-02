-- Pulsation du texte
local label = script.Parent.ComingSoon.Background.ComingSoon
local TweenService = game:GetService("TweenService")

local function pulse()
    TweenService:Create(label, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 0.3
    }):Play()
    task.wait(0.8)
    TweenService:Create(label, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        TextTransparency = 0
    }):Play()
    task.wait(0.8)
end

while true do pulse() end
