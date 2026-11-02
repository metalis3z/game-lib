local l__TweenService__3 = game:GetService("TweenService");

while true do
	local TweenPos1 = l__TweenService__3:Create(script.Parent.Handle, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Position = script.Parent.Handle.Position + Vector3.new(0, 0.35, 0)
	})

	TweenPos1:Play()
	TweenPos1.Completed:Wait()

	local TweenPos2 = l__TweenService__3:Create(script.Parent.Handle, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Position = script.Parent.Handle.Position + Vector3.new(0, -0.35, 0)
	})

	TweenPos2:Play()
	TweenPos2.Completed:Wait()
end
