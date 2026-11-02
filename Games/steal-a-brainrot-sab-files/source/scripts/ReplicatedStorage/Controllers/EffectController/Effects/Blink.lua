

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

require(script:FindFirstAncestor("Effects").Parent.Types)

local t1 = {}
local _ = script.Name
local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")

ColorCorrectionEffect.Brightness = 0
ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255)
ColorCorrectionEffect.Parent = workspace.CurrentCamera

local tween = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
	Brightness = 0
})

function t1.Activate(_)
	ColorCorrectionEffect.Brightness = not ReplicatedStorage:GetAttribute("WaterEvent") and 1 or 2
	tween:Cancel()
	tween:Play()
end

return t1
