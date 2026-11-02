local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special")

local Furnituress = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")

local Drawers = require(game.ServerScriptService.Game.Directory.Drawers)

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(11, 20)

-- GENERATOR SCRIPT --
local RoomGeneration = require(game.ServerScriptService.Game.Directory["RoomGeneration"])

function DoorGenerate(v)
	local SecretStorage = game:GetService("ServerScriptService")

	local function generateDoor()
		local cloneddoor = SecretStorage.Server.Assets.Door:Clone()

		if cloneddoor:FindFirstChild("BlackHidden") then
			cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
		end
		cloneddoor.Parent = v
		cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, 0.7))
	end

	for i = 1, 1 do
		generateDoor()
	end
end

function generateRoom(RoomNumber) -- Function Generator Rooms
	local randomroom = SpecialHallways.Hotel_LibraryExit
	local clonedroom = randomroom:Clone()
	local colors = clonedroom.Colors
	local randomwallcolor = math.random(1, 7)
	--local randomclearcarpet = math.random(1, 5)

	if randomwallcolor == 1 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(109, 70, 70)
		color.Name = "color"
		color.Parent = colors.Wall
	elseif randomwallcolor == 2 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(89, 116, 117)
		color.Name = "color"
		color.Parent = colors.Wall
	elseif randomwallcolor == 3 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(69, 81, 109)
		color.Name = "color"
		color.Parent = colors.Wall
	elseif randomwallcolor == 4 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(76, 109, 91)
		color.Name = "color"
		color.Parent = colors.Wall
	elseif randomwallcolor == 5 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(134, 116, 95)
		color.Name = "color"
		color.Parent = colors.Wall
	elseif randomwallcolor == 6 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(72, 88, 125)
		color.Name = "color"
		color.Parent = colors
	end

	if clonedroom:FindFirstChild("FurniturePoint") then
		for i, v in pairs(clonedroom:WaitForChild("FurniturePoint"):GetChildren()) do
			local addFurniture = math.random(1, 240)

			if v:GetAttribute("Type") == "Dresser" then
				local Dresser = Furnituress:WaitForChild("Hotel_Dresser"):Clone()
				Dresser.Name = "Dresser"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.Scan(Dresser)

			elseif v:GetAttribute("Type") == "Table" then
				local Dresser = Furnituress:WaitForChild("Hotel_Table"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.SetDebris(Dresser)

			elseif v:GetAttribute("Type") == "TableObtain" then
				local Dresser = Furnituress:WaitForChild("Hotel_RedTable"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedroom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.SetDebris(Dresser)

			elseif v:GetAttribute("Type") == "Random" then
				if addFurniture > 0 and addFurniture < 25 then
					local Dresser = Furnituress:WaitForChild("Hotel_Drawer_Table"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

					Drawers.SetDebris(Dresser)

				elseif addFurniture > 35 and addFurniture < 45 then
					local Dresser = Furnituress:WaitForChild("Hotel_Table"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)

				elseif addFurniture > 45 and addFurniture < 85 then
					local Dresser = Furnituress:WaitForChild("Hotel_TDrawer"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

					Drawers.SetDebris(Dresser)

				elseif addFurniture > 85 and addFurniture < 125 then
					local Dresser = Furnituress:WaitForChild("Hotel_RedTableFront"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)

				elseif addFurniture > 125 and addFurniture < 165 then
					local Dresser = Furnituress:WaitForChild("Hotel_RedTableOpened"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)

				end
			end
		end

		clonedroom:WaitForChild("FurniturePoint"):Destroy()
	end
	
	DoorGenerate(clonedroom)

	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber  -- Changing name to Current room
	workspace.CurrentRooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

local generatedrooms = {prevRoom}

generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)

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