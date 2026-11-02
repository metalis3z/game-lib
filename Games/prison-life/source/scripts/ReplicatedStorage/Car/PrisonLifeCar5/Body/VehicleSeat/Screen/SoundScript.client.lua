			local carSeat = script.Parent.CarSeat.Value
		carSeat.Sound:Play()
while true do
	wait()


	speed = math.floor(math.sqrt((carSeat.Velocity.x^2)+(carSeat.Velocity.y^2)+(carSeat.Velocity.z^2)))	

	carSeat.Sound.Pitch = (speed/150)+0.300
end