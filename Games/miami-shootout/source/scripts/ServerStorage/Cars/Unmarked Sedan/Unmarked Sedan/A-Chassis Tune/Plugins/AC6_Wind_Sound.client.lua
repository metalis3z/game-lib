wait(0.2)
local car = script.Parent.Car.Value
local carSeat = car.DriveSeat
	script.Wind:Play()
	script.Wind.Parent=carSeat

while true do
	wait()
	local speed = carSeat.Velocity.magnitude
	speed = math.floor(math.sqrt((carSeat.Velocity.x^2)+(carSeat.Velocity.y^2)+(carSeat.Velocity.z^2)))	
	carSeat.Wind.Pitch = (speed/150)+0.02
end