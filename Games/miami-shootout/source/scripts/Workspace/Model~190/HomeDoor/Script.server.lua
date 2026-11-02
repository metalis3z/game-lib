game.ReplicatedStorage.OPENDOOR.Event:Connect(function(from,action,extra)

	if action == "batter" and extra == script.Parent then
		print("BATTER ACTION")
		if script.Parent.Door.RoomDoorClosed.Transparency == 0 then
			print("CLOSED")
			local sound = game.ReplicatedStorage.assets_imp.battering:Clone()
			sound.Parent = script.Parent.Door.RoomDoorClosed
			sound:Play()

			game.Debris:AddItem(sound,sound.TimeLength)

			script.Parent.Door.RoomDoorClosed.Transparency = 1
			script.Parent.Door.RoomDoorClosed.CanCollide = false
			script.Parent.Door.RoomDoorClosed.ClickDetector.MaxActivationDistance = 0
			script.Parent.Door.RoomDoorOpen.ClickDetector.MaxActivationDistance = 8
			script.Parent.Door.RoomDoorOpen.Transparency = 0
			script.Parent.Door.RoomDoorOpen.CanCollide = true
		end	
	end

end)

script.Parent.Door.RoomDoorClosed.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Name == script.Parent.Owner.Value or plr.Backpack:FindFirstChild("LockPick") then
		if plr.Backpack:FindFirstChild("LockPick") then
			if plr.Name == script.Parent.Owner.Value then
				script.Parent.Door.RoomDoorClosed.Transparency = 1
				script.Parent.Door.RoomDoorClosed.CanCollide = false
				script.Parent.Door.RoomDoorClosed.DoorSound:Play()
				script.Parent.Door.RoomDoorClosed.ClickDetector.MaxActivationDistance = 0
				script.Parent.Door.RoomDoorOpen.ClickDetector.MaxActivationDistance = 8
				script.Parent.Door.RoomDoorOpen.Transparency = 0
				script.Parent.Door.RoomDoorOpen.CanCollide = true
				return
			end
			plr.Backpack:FindFirstChild("LockPick"):Remove()
		end
		script.Parent.Door.RoomDoorClosed.Transparency = 1
		script.Parent.Door.RoomDoorClosed.CanCollide = false
		script.Parent.Door.RoomDoorClosed.DoorSound:Play()
		script.Parent.Door.RoomDoorClosed.ClickDetector.MaxActivationDistance = 0
		script.Parent.Door.RoomDoorOpen.ClickDetector.MaxActivationDistance = 8
		script.Parent.Door.RoomDoorOpen.Transparency = 0
		script.Parent.Door.RoomDoorOpen.CanCollide = true
	else
		script.Parent.Door.RoomDoorClosed.Knock:Play()
	end
end)

script.Parent.Door.RoomDoorOpen.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Name == script.Parent.Owner.Value then
		script.Parent.Door.RoomDoorClosed.Transparency = 0
		script.Parent.Door.RoomDoorClosed.CanCollide = true
		script.Parent.Door.RoomDoorClosed.ClickDetector.MaxActivationDistance = 8
		script.Parent.Door.RoomDoorOpen.ClickDetector.MaxActivationDistance = 0
		script.Parent.Door.RoomDoorClosed.DoorSound:Play()
		script.Parent.Door.RoomDoorOpen.Transparency = 1
		script.Parent.Door.RoomDoorOpen.CanCollide = false
	end
end)