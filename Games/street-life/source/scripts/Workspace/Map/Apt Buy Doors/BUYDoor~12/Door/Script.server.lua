local RoomDoorClosed = script.Parent.Closed
local RoomDoorOpen = script.Parent.Opened

Open = function()
	RoomDoorOpen.Hinge.Part.ProximityPrompt.Enabled = true
	RoomDoorClosed.Hinge.Part.ProximityPrompt.Enabled = false
	for _,v in ipairs(RoomDoorClosed:GetDescendants()) do
		if v:IsA('BasePart') then
			v.Transparency = 1
			v.CanCollide = false
			v.CanQuery = false
		end
	end
	for _,v in ipairs(RoomDoorOpen:GetDescendants()) do
		if v:IsA('BasePart') then
			v.Transparency = 0
			v.CanCollide = true
		end
	end
	if RoomDoorOpen.Lock.xd.Transparency == 0 then
		RoomDoorOpen.Lock.O.Transparency = 0
		RoomDoorOpen.Lock.C.Transparency = 1
	end
end


Close = function()
	RoomDoorOpen.Hinge.Part.ProximityPrompt.Enabled = false
	RoomDoorClosed.Hinge.Part.ProximityPrompt.Enabled = true
	for _,v in ipairs(RoomDoorOpen:GetDescendants()) do
		if v:IsA('BasePart') then
			v.Transparency = 1
			v.CanCollide = false
			v.CanQuery = false
		end
	end
	for _,v in ipairs(RoomDoorClosed:GetDescendants()) do
		if v:IsA('BasePart') then
			v.Transparency = 0
			v.CanCollide = true
		end
	end
	if RoomDoorClosed.Lock.xd.Transparency == 0 then
		RoomDoorClosed.Lock.O.Transparency = 0
		RoomDoorClosed.Lock.C.Transparency = 1
	end
end


game.ReplicatedStorage.OPENDOOR.Event:Connect(function(from,action,extra)
	if action == "batter" and extra == script.Parent then
		if RoomDoorClosed.Frame2.Transparency == 0 then
			local sound = game.ReplicatedStorage.assets_imp.battering:Clone()
			sound.Parent = RoomDoorClosed.door
			sound:Play()

			game.Debris:AddItem(sound,sound.TimeLength)
			Open()
		end	
	end
end)

RoomDoorClosed.Lock.xd.ClickDetector.MouseClick:Connect(function(plr)
	if plr.Name == script.Parent.Owner.Value then
		if RoomDoorClosed.Lock.O.Transparency == 0 and RoomDoorClosed.Lock.xd.Transparency == 0 then
			RoomDoorClosed.Lock.O.Transparency = 1
			RoomDoorClosed.Lock.C.Transparency = 0
			RoomDoorClosed.Lock.xd.Lock:Play()
		elseif RoomDoorClosed.Lock.O.Transparency == 1 and RoomDoorClosed.Lock.xd.Transparency == 0 then
			RoomDoorClosed.Lock.O.Transparency = 0
			RoomDoorClosed.Lock.C.Transparency = 1
			RoomDoorClosed.Lock.xd.Lock:Play()
		end
	end
end)

local DoorClosedClone = script.ProximityPrompt:Clone()
DoorClosedClone.Parent = RoomDoorClosed.Hinge.Part
DoorClosedClone.ObjectText = 'Open Door' DoorClosedClone.MaxActivationDistance = 3

DoorClosedClone.Triggered:Connect(function(plr)
	if RoomDoorClosed.Lock.O.Transparency == 1 and RoomDoorClosed.Lock.xd.Transparency == 0 then 
		if plr.Name ~= script.Parent.Owner.Value then
			local Knock = script.Knock:Clone()
			Knock.Parent = RoomDoorClosed.door
			Knock:Play()
		end
		return
	end
	Open()
	local DoorSound = script.DoorSound:Clone()
	DoorSound.Parent = RoomDoorOpen.door
	DoorSound:Play()
end)

local DoorOpenedClone = script.ProximityPrompt:Clone()
DoorOpenedClone.Parent = RoomDoorOpen.Hinge.Part
DoorOpenedClone.ObjectText = 'Close Door'  DoorOpenedClone.Enabled = false

DoorOpenedClone.Triggered:Connect(function(plr)
	if RoomDoorOpen.Lock.O.Transparency == 1 then return end
	Close()
	local DoorSound = script.DoorSound:Clone()
	DoorSound.Parent = RoomDoorOpen.door
	DoorSound:Play()
end)

RoomDoorClosed:FindFirstChild('RemoteEvent').OnServerEvent:Connect(function(Player, Arg)
	if Player and Arg == 333 then
		if Player.Character:FindFirstChildOfClass('Tool') then
			RoomDoorClosed.Lock.xd.Broken.Pitch = 3
			RoomDoorClosed.Lock.xd.Broken:Play()
			RoomDoorClosed.Lock.xd.Transparency = 1
			RoomDoorClosed.Lock.O.Transparency = 1
			RoomDoorClosed.Lock.C.Transparency = 1
			task.wait(math.random(5, 10))
			if RoomDoorClosed.door.Transparency == 0 then
				RoomDoorClosed.Lock.xd.Transparency = 0
				RoomDoorClosed.Lock.O.Transparency = 0
				RoomDoorClosed.Lock.C.Transparency = 1
			end
		end
	end
end)