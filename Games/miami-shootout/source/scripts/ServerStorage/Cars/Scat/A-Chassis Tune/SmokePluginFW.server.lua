local car = script.Parent.Parent

--This script controls the tyre mark sounds and effects like the skid marks and smoke.

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.FL.SQ.TimeScript.Disabled = true
		car.Wheels.FL.SQ.PitchScript.Disabled = true
		car.Wheels.FR.SQ.TimeScript.Disabled = true
		car.Wheels.FR.SQ.PitchScript.Disabled = true
		car.Wheels.FL.SQ.TimePosition = 0
		car.Wheels.FL.SQ.Pitch = 0
		car.Wheels.FR.SQ.TimePosition = 0
		car.Wheels.FR.SQ.Pitch = 0
		car.Wheels.FL.Smoke.Rate=0
		car.Wheels.FR.Smoke.Rate=0
	end
end)

while wait(.2) do
	local r1 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(car.Wheels.FL.Size.x/1.2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.FL.Position,(car.Wheels.FR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(car.Wheels.FR.Size.x/1.2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local FL = math.min((math.max(math.abs((car.Wheels.FL.RotVelocity.Magnitude*car.Wheels.FL.Size.x/2) - (car.Wheels.FL.Velocity.Magnitude))-20,0)),50)*r1hit*1.2
	local FR = math.min((math.max(math.abs((car.Wheels.FR.RotVelocity.Magnitude*car.Wheels.FR.Size.x/2) - (car.Wheels.FR.Velocity.Magnitude))-20,0)),50)*r2hit*1.2
	car.Wheels.FL.Smoke.Rate = FL
	car.Wheels.FR.Smoke.Rate = FR
	
	if FL > 1 then
		car.Wheels.FL.SQ.TimeScript.Disabled = false
		car.Wheels.FL.SQ.PitchScript.Disabled = false
		car.Wheels.FL.WheelFixed.Mark.Trail.Enabled = true
		car.Wheels.FL.WheelFixed.Mark2.Trail.Enabled = true
		
	end
	if FL < 1 then
		car.Wheels.FL.SQ.TimeScript.Disabled = true
		car.Wheels.FL.SQ.PitchScript.Disabled = true
		car.Wheels.FL.WheelFixed.Mark.Trail.Enabled = false
		car.Wheels.FL.SQ.Pitch = 0
		car.Wheels.FL.SQ.TimePosition = 0
		car.Wheels.FL.WheelFixed.Mark2.Trail.Enabled = false
	end
	if FR > 1 then
		car.Wheels.FR.SQ.TimeScript.Disabled = false
		car.Wheels.FR.SQ.PitchScript.Disabled = false
		
		car.Wheels.FR.WheelFixed.Mark2.Trail.Enabled = true
	car.Wheels.FR.WheelFixed.Mark.Trail.Enabled = true
	end
	if FR < 1 then
		car.Wheels.FR.SQ.TimeScript.Disabled = true
		car.Wheels.FR.SQ.PitchScript.Disabled = true
		car.Wheels.FR.SQ.Pitch = 0
		car.Wheels.FR.SQ.TimePosition = 0
		car.Wheels.FR.WheelFixed.Mark.Trail.Enabled = false
		car.Wheels.FR.WheelFixed.Mark2.Trail.Enabled = false
	end
	
	
	
end
