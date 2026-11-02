speed = nil
seat = script.Parent.Parent




function changeSound(obj,state)
	if obj.Name == "SeatWeld" then
		if state == true then
			script.Parent:Play()
		else
			script.Parent:Pause()
		end
	end
end



seat.ChildAdded:connect(function(obj) changeSound(obj,true) end)
seat.ChildRemoved:connect(function(obj) changeSound(obj,false) end)



local volume = script.Parent.Volume
while true do
	wait(.2)
	while script.Parent.IsPaused do wait(.4) end
	speed = math.floor(math.sqrt((seat.Velocity.x^2)+(seat.Velocity.y^2)+(seat.Velocity.z^2)))
	script.Parent.Volume = ((speed/50) + .6)/3

	script.Parent.Pitch = (speed/50) + 1
end
