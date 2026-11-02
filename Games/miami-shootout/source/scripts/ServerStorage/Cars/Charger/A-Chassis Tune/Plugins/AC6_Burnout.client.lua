local car = script.Parent.Car.Value
local slip = 50
local pslip = slip

car.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then
		car.Wheels.RL.Burnout.Force = Vector3.new(0,0,0)
		car.Wheels.RR.Burnout.Force = Vector3.new(0,0,0)
	end
end)

while wait(.2) do
	if script.Parent.Values.PBrake.Value and not script.Parent.Values.TCS.Value and car.DriveSeat.Velocity.Magnitude < 0.5 and script.Parent.Values.RPM.Value > 5000 then
		slip = math.min(3000,slip+1000)
	else
		slip = math.max(0,slip-500)
	end
	if pslip~=slip then
		car.Wheels.RL.Burnout.Force = Vector3.new(25,slip,25)
		car.Wheels.RR.Burnout.Force = Vector3.new(25,slip,25)
	end
	pslip=slip
end
