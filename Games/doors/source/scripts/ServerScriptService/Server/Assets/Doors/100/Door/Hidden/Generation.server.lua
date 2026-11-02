local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):WaitForChild("4Eyeball")

local GeneratedRooms = workspace:WaitForChild("Rooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(2, 33)

-- GENERATOR SCRIPT --

function generateElectricRoom(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SpecialHallways.Hotel_ElevatorRoom
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateBayourd(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SpecialHallways.Hotel_Bayourd
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateJeffShop(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SpecialHallways.Hotel_JeffShop
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	clonedroom.ShopStuff.RadioShop.Hitbox.MusicClose:Play()
	clonedroom.ShopStuff.RadioShop.Hitbox.MusicFar:Play()
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateCourtyardEntrance(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SpecialHallways.Hotel_Courtyard
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateSeekEntrance(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SeekSpecialHallway:GetChildren()[math.random(1, #SeekSpecialHallway:GetChildren())]
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateDarkRoom(RoomNumber) -- Function Generator Dark Rooms
	local randomroom = PossibleHallways:GetChildren()[math.random(1, #PossibleHallways:GetChildren())]
	local clonedroom = randomroom:Clone()
	clonedroom.Assets:WaitForChild("Light_Fixtures"):Destroy()
	game.Workspace.Ambience_Dark:Play()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
	
	for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do
		local addPainting = math.random(1, 5) 

		if addPainting < 3 then
			local Painting = Paintings:WaitForChild("Painting_Small"):Clone()
			Painting.Parent = script.Parent.Parent.Parent:WaitForChild("Paintings")
			Painting.Canvas.SurfaceGui.Script.Enabled = true
			Painting:PivotTo(v.CFrame)
		elseif addPainting < 4 then
			local Painting = Paintings:WaitForChild("Painting_Tall"):Clone()
			Painting.Parent = script.Parent.Parent.Parent:WaitForChild("Paintings")
			Painting.Canvas.SurfaceGui.Script.Enabled = true
			Painting:PivotTo(v.CFrame)
		end
	end

	for i, v in pairs(clonedroom:WaitForChild("FurniturePoint"):GetChildren()) do
		local addFurniture = math.random(1, 50) 

		if addFurniture < 10 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DresserObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Furnitures")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 20 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("ExcselentDresserObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Furnitures")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 30 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DressTableObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Furnitures")
			Dresser.AssetControl.Enabled = true
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 40 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("ExcselentTable"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Furnitures")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 50 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Furnitures")
			Dresser:PivotTo(v.CFrame)
		end
	end
end

function generateFigureLibrary(RoomNumber) -- Function Generator Room 50 - Figure boss
	local randomroom = SpecialHallways.Hotel_FigureLibrary
	local clonedroom = randomroom:Clone()

	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

function generateRoom(RoomNumber) -- Function Generator Rooms
	local randomroom = PossibleHallways:GetChildren()[math.random(1, #PossibleHallways:GetChildren())]
	local clonedroom = randomroom:Clone()
	local colors = clonedroom.Colors
	local randomwallcolor = math.random(1, 7)
	--local randomclearcarpet = math.random(1, 5)
	
	if randomwallcolor == 1 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(109, 70, 70)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
	elseif randomwallcolor == 2 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(89, 116, 117)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
	elseif randomwallcolor == 3 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(69, 81, 109)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
	elseif randomwallcolor == 4 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(76, 109, 91)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
	elseif randomwallcolor == 5 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(134, 116, 95)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
	elseif randomwallcolor == 6 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(72, 88, 125)
		color.Name = "color"
		color.Parent = colors
		colors.Wall.colortrue.Value = true
	end
	
	--if randomclearcarpet == 5 then
	--	clonedroom.Assets:WaitForChild("Rug"):Destroy()
	--end
	
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber  -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room

	for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do
		local addPainting = math.random(1, 5) 
		
		if addPainting < 3 then
			local Painting = Paintings:WaitForChild("Painting_Small"):Clone()
			Painting.Parent = script.Parent.Parent.Parent:WaitForChild("Assets")
			Painting.Canvas.SurfaceGui.Script.Enabled = true
			Painting:PivotTo(v.CFrame)
		elseif addPainting < 4 then
			local Painting = Paintings:WaitForChild("Painting_Tall"):Clone()
			Painting.Parent = script.Parent.Parent.Parent:WaitForChild("Assets")
			Painting.Canvas.SurfaceGui.Script.Enabled = true
			Painting:PivotTo(v.CFrame)
		end
	end

	for i, v in pairs(clonedroom:WaitForChild("FurniturePoint"):GetChildren()) do
		local addFurniture = math.random(1, 120) 

		if addFurniture < 25 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 50 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DresserObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 75 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("Table"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 100 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("ExcelentTable"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 110 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain1"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 120 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain1_1"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 130 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain1_2"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 140 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain1_3"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 150 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain1_4"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 155 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain2_1"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 158 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain2_2"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 160 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain2_3"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 161 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain2_4"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 165 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DresserObtain1_1"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		elseif addFurniture < 175 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DresserObtain1_2"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)
		end
	end
end
local generatedrooms = {prevRoom}

script.Parent.Touched:Connect(function(roomNum)
	script.Parent.CanTouch = false
	generateElectricRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
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