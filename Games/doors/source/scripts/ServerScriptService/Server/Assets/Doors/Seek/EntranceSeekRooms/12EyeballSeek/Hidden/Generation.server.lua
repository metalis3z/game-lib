local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("SeekRooms"):WaitForChild("RandomHallway")

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(11, 20)

-- GENERATOR SCRIPT --

function generateRoom(RoomNumber) -- Function Generator Rooms
	local randomroom = SeekSpecialHallway:GetChildren()[math.random(1, #SeekSpecialHallway:GetChildren())]
	local clonedroom = randomroom:Clone()

	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = game.Workspace.CurrentRooms:GetAttribute("SeekRoomMain")
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

local generatedrooms = {prevRoom}

script.Parent.Touched:Connect(function(roomNum)
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
		script.Parent.CanTouch = false
end)

if workspace.CurrentRooms.CurrentRoom.Value >= 4 then
	local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
	local cur1 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 1
	local cur2 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 2
	local cur3 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 3
	local cur4 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 4
	local g = game.Workspace.CurrentRooms.CurrentRoom.Value - 4

	local currentRoomValue = game.Workspace.CurrentRooms.CurrentRoom.Value
	if currentRoomValue >= 4 then
		local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
		local cur1 = cur - 1
		local cur2 = cur - 2
		local cur3 = cur - 3
		local cur4 = cur - 4
		local g = currentRoomValue - 5

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
end