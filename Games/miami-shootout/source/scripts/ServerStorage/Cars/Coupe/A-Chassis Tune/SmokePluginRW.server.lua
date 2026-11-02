local car = script.Parent.Parent

--This script controls the tyre mark sounds and effects like the skid marks and smoke.

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.RL.SQ.TimeScript.Disabled = true
		car.Wheels.RL.SQ.PitchScript.Disabled = true
		car.Wheels.RR.SQ.TimeScript.Disabled = true
		car.Wheels.RR.SQ.PitchScript.Disabled = true
		car.Wheels.RL.SQ.TimePosition = 0
		car.Wheels.RL.SQ.Pitch = 0
		car.Wheels.RR.SQ.TimePosition = 0
		car.Wheels.RR.SQ.Pitch = 0
		car.Wheels.RL.Smoke.Rate=0
		car.Wheels.RR.Smoke.Rate=0
	end
end)

while wait(.2) do
	local r1 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RL.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(car.Wheels.RL.Size.x/1.2))
	local r1hit = 0
	if workspace:FindPartOnRay(r1,car)~=nil then r1hit=1 end

	local r2 = Ray.new(car.Wheels.RL.Position,(car.Wheels.RR.Arm.CFrame*CFrame.Angles(-math.pi/2,0,0)).lookVector*(car.Wheels.RR.Size.x/1.2))
	local r2hit = 0
	if workspace:FindPartOnRay(r2,car)~=nil then r2hit=1 end
	
	local rl = math.min((math.max(math.abs((car.Wheels.RL.RotVelocity.Magnitude*car.Wheels.RL.Size.x/2) - (car.Wheels.RL.Velocity.Magnitude))-20,0)),50)*r1hit*1.2
	local rr = math.min((math.max(math.abs((car.Wheels.RR.RotVelocity.Magnitude*car.Wheels.RR.Size.x/2) - (car.Wheels.RR.Velocity.Magnitude))-20,0)),50)*r2hit*1.2
	car.Wheels.RL.Smoke.Rate = rl
	car.Wheels.RR.Smoke.Rate = rr
	
	if rl > 1 then
		car.Wheels.RL.SQ.TimeScript.Disabled = false
		car.Wheels.RL.SQ.PitchScript.Disabled = false
		car.Wheels.RL.WheelFixed.Mark.Trail.Enabled = true
		car.Wheels.RL.WheelFixed.Mark2.Trail.Enabled = true
		
	end
	if rl < 1 then
		car.Wheels.RL.SQ.TimeScript.Disabled = true
		car.Wheels.RL.SQ.PitchScript.Disabled = true
		car.Wheels.RL.WheelFixed.Mark.Trail.Enabled = false
		car.Wheels.RL.SQ.Pitch = 0
		car.Wheels.RL.SQ.TimePosition = 0
		car.Wheels.RL.WheelFixed.Mark2.Trail.Enabled = false
	end
	if rr > 1 then
		car.Wheels.RR.SQ.TimeScript.Disabled = false
		car.Wheels.RR.SQ.PitchScript.Disabled = false
		
		car.Wheels.RR.WheelFixed.Mark2.Trail.Enabled = true
	car.Wheels.RR.WheelFixed.Mark.Trail.Enabled = true
	end
	if rr < 1 then
		car.Wheels.RR.SQ.TimeScript.Disabled = true
		car.Wheels.RR.SQ.PitchScript.Disabled = true
		car.Wheels.RR.SQ.Pitch = 0
		car.Wheels.RR.SQ.TimePosition = 0
		car.Wheels.RR.WheelFixed.Mark.Trail.Enabled = false
		car.Wheels.RR.WheelFixed.Mark2.Trail.Enabled = false
	end
	
	
	
end
