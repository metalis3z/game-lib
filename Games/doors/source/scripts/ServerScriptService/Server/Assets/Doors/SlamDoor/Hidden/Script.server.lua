--script.Parent.Touched:Connect(function()
	script.Parent.Parent.KnobConstraint.TargetAngle = 45
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.SlamOpen:Play()
	wait(0.5)
	script.Parent.Parent.KnobConstraint.TargetAngle = 0
--end)
