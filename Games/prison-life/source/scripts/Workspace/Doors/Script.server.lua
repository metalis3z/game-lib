local dayConfig = game.ReplicatedStorage:WaitForChild("DayValue")
local doorCt = dayConfig:WaitForChild("Doorsct")

local openDoorValue = game.ReplicatedStorage:WaitForChild("DoorValue"):WaitForChild("OpenDoorCV")

local doors = script.Parent

if openDoorValue.Value == false then
	local doorOpened = doors:WaitForChild("door_v3_ctOpend")
	doorOpened:Destroy()

	local NewDoor = doorCt.Close.door_v3_ctClosed:Clone()
	NewDoor.Parent = doors
end

openDoorValue.Changed:Connect(function()
	if openDoorValue.Value == true then
		local DoorClosed = doors:WaitForChild("door_v3_ctClosed")
		DoorClosed:Destroy()
		
		local NewDoor = doorCt.Open.door_v3_ctOpend:Clone()
		NewDoor.Parent = doors
	else
		local doorOpened = doors:WaitForChild("door_v3_ctOpend")
		doorOpened:Destroy()
		
		local NewDoor = doorCt.Close.door_v3_ctClosed:Clone()
		NewDoor.Parent = doors
	end
end)