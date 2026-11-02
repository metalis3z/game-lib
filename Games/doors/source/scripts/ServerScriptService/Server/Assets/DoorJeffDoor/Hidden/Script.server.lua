script.Parent.Touched:Connect(function()
	workspace.Rooms.CurrentRoom.Value += 1
	script.Parent.Parent.KnobConstraint.TargetAngle = 45
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.Open:Play()
	wait(0.5)
	script.Parent.Parent.KnobConstraint.TargetAngle = 0
end)
