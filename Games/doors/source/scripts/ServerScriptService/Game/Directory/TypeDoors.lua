local module = {}

-- Created and Fixed by BUILDG Studios

function module:DoorNormal(Door)
	local HiddenRight = Door.Hidden:Clone()
	local HiddenLeft = Door.Hidden:Clone()

	HiddenLeft.Parent = Door
	HiddenRight.Parent = Door

	HiddenLeft.Name = "HiddenLeft"
	HiddenRight.Name = "HiddenRight"

	HiddenLeft.CFrame = Door.Door.CFrame * CFrame.new(0, 0, -5);
	HiddenRight.CFrame = Door.Door.CFrame * CFrame.new(0, 0, 5);

	HiddenRight.Touched:Connect(function(hit)
		HiddenRight.Parent.HingeConstraint.TargetAngle = -90
		HiddenRight.Parent.KnobConstraint.TargetAngle = 45
		HiddenRight.Parent.Door.Anchored = false
		HiddenRight.Parent.Door.CanCollide = false
		HiddenRight.CanTouch = false
		HiddenLeft.CanTouch = false
		HiddenRight.Parent.Door.Open:Play()
		wait(0.5)
		HiddenRight.Parent.KnobConstraint.TargetAngle = 0
	end)

	HiddenLeft.Touched:Connect(function(hit)
		HiddenLeft.Parent.HingeConstraint.TargetAngle = 90
		HiddenLeft.Parent.KnobConstraint.TargetAngle = 45
		HiddenLeft.Parent.Door.Anchored = false
		HiddenLeft.Parent.Door.CanCollide = false
		HiddenLeft.CanTouch = false
		HiddenRight.CanTouch = false
		HiddenLeft.Parent.Door.Open:Play()
		wait(0.5)
		HiddenLeft.Parent.KnobConstraint.TargetAngle = 0
	end)

	Door.Hidden:Destroy()
end

return module
