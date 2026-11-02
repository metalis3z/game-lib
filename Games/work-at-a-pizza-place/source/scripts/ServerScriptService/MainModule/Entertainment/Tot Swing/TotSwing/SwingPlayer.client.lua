local objectPointer = script:WaitForChild("ObjectPointer",2)
if objectPointer.Value and objectPointer.Value.Parent and objectPointer.Value:FindFirstChild("Seat") and objectPointer.Value.Seat.Occupant then
	
	local seat = objectPointer.Value:FindFirstChild("Seat")
	local humanoid = game.Players.LocalPlayer.Character.Humanoid
	local bodyForce = seat.BodyForce
	local running = true
	
	local function reset()
		bodyForce.Force = Vector3.new(0,0,0)
		script:Destroy()
	end
	

	objectPointer.Changed:connect(function()
		if objectPointer.Value == nil or objectPointer.Value.Parent == nil then
			running = false
			reset()
		end
	end)
	
	while running and humanoid.Sit do
		wait(.1)
		bodyForce.Force = humanoid.MoveDirection * 500
	end
	
	reset()
end