local TweenService = game:GetService("TweenService")

return function(uiGradient, duration)
	duration = duration or 3

	uiGradient.Offset = Vector2.new(-1, 0)

	local tweenInfo = TweenInfo.new(
		duration, 
		Enum.EasingStyle.Linear, 
		Enum.EasingDirection.InOut, 
		-1
	)

	local tween = TweenService:Create(uiGradient, tweenInfo, {
		Offset = Vector2.new(1, 0)
	})

	tween:Play()

	return function()
		tween:Cancel()
	end
end