local frame = script.Parent.Parent.Parent
local button = script.Parent
local TweenService = game:GetService("TweenService")

-- paramètres de l'animation
local tweenInfo = TweenInfo.new(
	0.4, -- durée
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.InOut
)

button.MouseButton1Click:Connect(function()
	-- animation de fermeture
	local tween = TweenService:Create(frame, tweenInfo, {
		Size = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1
	})

	tween:Play()

	-- attendre la fin
	tween.Completed:Wait()

	frame.Visible = false
end)