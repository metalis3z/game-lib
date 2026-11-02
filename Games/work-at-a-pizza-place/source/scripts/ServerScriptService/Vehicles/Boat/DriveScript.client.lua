local humanoid = script.Parent:WaitForChild("Humanoid")
while humanoid.SeatPart == nil do
	wait()
end
local seat = humanoid.SeatPart
local boat = seat.Parent
local thrust = boat.Base.BodyThrust


local angular = boat.Base.BodyAngularVelocity
angular.maxTorque = Vector3.new(0,70000,0)


function changed(property)
	if property == "Steer" then
		if math.abs(seat.SteerFloat) > .2 then
			angular.angularvelocity = Vector3.new(0,seat.SteerFloat*-1,0)
		else
			angular.angularvelocity = Vector3.new(0,0,0)
		end
			
	elseif property == "Throttle" then
		local throttlefloat = seat.ThrottleFloat
		if throttlefloat > .3 then 
			thrust.force = Vector3.new(0,0, throttlefloat*-11000) 
		elseif throttlefloat < -.3 then
			thrust.force = Vector3.new(0,0, (throttlefloat*-11000)/4) --reverse
		else
			thrust.force = Vector3.new(0,0, 0) --stop boat
		end
			
	elseif property == "Occupant" then
		angular.angularvelocity = Vector3.new(0,0,0)
		thrust.force = Vector3.new(0,0,0)
		script:Destroy()
	end
end
seat.Changed:connect(changed)