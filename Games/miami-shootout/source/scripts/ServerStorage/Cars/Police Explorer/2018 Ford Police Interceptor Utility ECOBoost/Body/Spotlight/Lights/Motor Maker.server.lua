wait(0.1)

local motor = Instance.new("Motor", script.Parent)
motor.Name = "Motor1"
motor.Part0 = script.Parent.Parent.PivotBase
motor.Part1 = script.Parent.PivotPart
motor.MaxVelocity = 0.025


script:Destroy()