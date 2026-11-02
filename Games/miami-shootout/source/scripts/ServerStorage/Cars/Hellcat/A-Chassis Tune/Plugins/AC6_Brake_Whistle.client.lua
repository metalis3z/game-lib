local car = script.Parent.Car.Value
local handler = car.Brakeoverheat
local FE = workspace.FilteringEnabled
car.DriveSeat.Brakes:Play()

if not FE then
while wait() do
	if script.Parent.Values.Brake.Value > 0.1 and ((car.Wheels.RR.RotVelocity.Magnitude+car.Wheels.FR.RotVelocity.Magnitude+car.Wheels.FL.RotVelocity.Magnitude+car.Wheels.RL.RotVelocity.Magnitude)/4) > 10 and script.Parent.Values.Gear.Value > 0 then
		car.DriveSeat.Brakes.Volume = math.max((script.Parent.Values.Brake.Value/2)-.35,0)
		else
		car.DriveSeat.Brakes.Volume = math.max(car.DriveSeat.Brakes.Volume-.35,0)
	end
end
else
	handler:FireServer("SoundPlay")
	
	while wait() do
		handler:FireServer("SoundUpdate",sound)
		
		if script.Parent.Values.Brake.Value > 0.1 and ((car.Wheels.RR.RotVelocity.Magnitude+car.Wheels.FR.RotVelocity.Magnitude+car.Wheels.FL.RotVelocity.Magnitude+car.Wheels.RL.RotVelocity.Magnitude)/4) > 10 and script.Parent.Values.Gear.Value > 0 then
			sound = math.max((script.Parent.Values.Brake.Value/2)-.35,0)
		else
			sound = math.max(car.DriveSeat.Brakes.Volume-.35,0)
		end		
	end
end