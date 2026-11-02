local RoomDoorClosed = script.Parent.Closed
local RoomDoorOpen = script.Parent.Opened

Open = function()
	RoomDoorClosed.Hinge.Part.ProximityPrompt.Enabled = false
	RoomDoorOpen.Hinge.Part.ProximityPrompt.Enabled = true
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
end

local DoorClosedClone = script.ProximityPrompt:Clone()
DoorClosedClone.Parent = RoomDoorClosed.Hinge.Part
DoorClosedClone.ObjectText = 'Open Door' DoorClosedClone.MaxActivationDistance = 3

DoorClosedClone.Triggered:Connect(function(plr)
	Open()
	if script:FindFirstChild('DoorSound') then script.DoorSound.Parent = script.Parent.Frame.Ape end script.Parent.Frame.Ape.DoorSound:Play()
end)

local DoorOpenedClone = script.ProximityPrompt:Clone()
DoorOpenedClone.Parent = RoomDoorOpen.Hinge.Part
DoorOpenedClone.ObjectText = 'Close Door'  DoorOpenedClone.Enabled = false

DoorOpenedClone.Triggered:Connect(function(plr)
	Close()
	if script:FindFirstChild('DoorSound') then script.DoorSound.Parent = script.Parent.Frame.Ape end script.Parent.Frame.Ape.DoorSound:Play()
end)
