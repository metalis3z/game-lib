local TweenService = game:GetService('TweenService')

while true do

	wait(2.25)

	TweenService:Create(script.Parent, TweenInfo.new(2.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Size = Vector3.new(4.265, 1.209, 3.694),
		Position = Vector3.new(-64.444, 3.203, -31.692)
	}):Play()

	wait(2.25)

	TweenService:Create(script.Parent, TweenInfo.new(2.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
		Size = Vector3.new(4.265, 1.305, 3.694),
		Position = Vector3.new(-64.444, 3.25, -31.692)
	}):Play()

end