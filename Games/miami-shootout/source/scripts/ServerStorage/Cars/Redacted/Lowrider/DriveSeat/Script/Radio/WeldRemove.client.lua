Vehicle = script.Parent.Vehicle.Value
	Vehicle.DriveSeat.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" then 
		script.Parent:Destroy()
	end
end)