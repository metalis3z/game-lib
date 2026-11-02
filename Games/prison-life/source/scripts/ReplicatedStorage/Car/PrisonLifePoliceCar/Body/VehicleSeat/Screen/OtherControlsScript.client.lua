while wait() do
	local carSeat = script.Parent.CarSeat.Value
	local speed = carSeat.Velocity.magnitude
	local m = carSeat.Parent.MR.Motor
	local n = carSeat.Parent.ML.Motor
	if carSeat.Steer == 1 then
		m.DesiredAngle = (-2000/(speed+57.15))/45
		n.DesiredAngle = m.DesiredAngle
	elseif carSeat.Steer == -1 then
		m.DesiredAngle = (2000/(speed+57.15))/45
		n.DesiredAngle = m.DesiredAngle
	else
		m.DesiredAngle = 0
		n.DesiredAngle = 0
	end
end