local Hinge = script.Parent.Parent.HingeConstraint
local Door = script.Parent.Parent.Door

script.Parent.Touched:Connect(function()
	Hinge.Parent.KnobConstraint.TargetAngle = 45
	script.Parent.CanTouch = false
	Door.Anchored = false
	Door.Open:Play()
	Door.CanCollide = false
	wait(0.5)
	Hinge.Parent.KnobConstraint.TargetAngle = 0
end)