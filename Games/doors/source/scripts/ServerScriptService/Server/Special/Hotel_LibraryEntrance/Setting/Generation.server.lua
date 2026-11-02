local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):WaitForChild("4Eyeball")

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(2, 33)

function generateFigureLibrary(RoomNumber) -- Function Generator Room 50 - Figure boss
	local randomroom = SpecialHallways.Hotel_FigureLibrary
	local clonedroom = randomroom

	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = workspace.CurrentRooms.CurrentRoom.Value
	workspace.CurrentRooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

local generatedrooms = {prevRoom}

script.Parent.Parent.RoomStart.Touched:Connect(function()
	script.Parent.Parent.RoomStart.CanTouch = false
	wait(0.1)
	generateFigureLibrary(game.Workspace.CurrentRooms.CurrentRoom.Value)
end)

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