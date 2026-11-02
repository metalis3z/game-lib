script.Parent.Touched:Connect(function()
	script.Parent.Parent.KnobConstraint.TargetAngle = 45
	script.Parent.Parent.Door.Anchored = false
	script.Parent.Parent.Door.CanCollide = false
	script.Parent.CanTouch = false
	script.Parent.Parent.Door.Open:Play()
	wait(0.5)
	script.Parent.Parent.KnobConstraint.TargetAngle = 0
	
	local currentRoomValue = game.Workspace.CurrentRooms.CurrentRoom.Value
	if currentRoomValue >= 4 then
		local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
		local cur1 = cur - 1
		local cur2 = cur - 2
		local cur3 = cur - 3
		local cur4 = cur - 4
		local g = currentRoomValue - 5 --4

		if game.Workspace.CurrentRooms:FindFirstChild(tostring(g)) then
			game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value = g + 1

			local curRoom = game.Workspace.CurrentRooms:FindFirstChild(tostring(cur))

			-- Function to move the door to OnDeletedDoors
			local function moveToOnDeletedDoors(roomNum)
				local roomNumOld = roomNum - 1
				local door = curRoom:FindFirstChild("Door")
				if door then
					door.Name = "Door"..roomNum
					door.Parent = game.Workspace.OnDeletedDoors
					door.HingeConstraint.TargetAngle = 0
					door.HingeConstraint.ServoMaxTorque = 255565
					door.Collicion.CanCollide = true
					if game.Workspace.OnDeletedDoors:FindFirstChild("Door"..roomNumOld) then
						game.Workspace.OnDeletedDoors:FindFirstChild("Door"..roomNumOld):Destroy()
					end
				end
			end

			-- Move the current room's door to OnDeletedDoors
			moveToOnDeletedDoors(cur)

			-- Destroy the current room and previous rooms
			for _, roomNum in ipairs({cur1, cur2, cur3, cur4}) do
				local room = game.Workspace.CurrentRooms:FindFirstChild(tostring(roomNum))
				if room then
					--[[local door = room:FindFirstChild("Door")
					if door then
						door:Destroy()
					end--]]
					room:Destroy()
					moveToOnDeletedDoors(roomNum)
				end
			end

			wait(.1)
			game.Workspace.CurrentRooms.CurrentRoom.Door.Value += 1
			game.Workspace.CurrentRooms.CurrentRoom.Door.DoorAlt.Value += 1
		end
	end
end)
