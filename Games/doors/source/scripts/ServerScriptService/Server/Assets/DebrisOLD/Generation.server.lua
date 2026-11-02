local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):WaitForChild("4Eyeball")

local GeneratedRooms = workspace:WaitForChild("Rooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local DarkRoomRandom = math.random(8, 13)

-- GENERATOR SCRIPT --

function GameEntity(boolen1, boolen2)
	local folder = Instance.new("Folder")
	folder.Parent = workspace
	folder.Name = "Entities"
	
	folder:SetAttribute("CustomEntity", boolen1)
	folder:SetAttribute("GameEntity", boolen2)
end

function spawnEntity(entity)
	if entity == "Entities_Rush" then
		GameEntity(false, true)
		task.wait()
		local gamecode = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
		local rushcloned = game.ServerScriptService.Server.Assets.Entities.Rush:Clone()
		if workspace:FindFirstChild("Entities", true) then
			rushcloned.Parent = workspace:FindFirstChild("Entities", true)
		end
		rushcloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(gamecode).RoomStart.CFrame)

		rushcloned:SetAttribute("Entities_Rush", true)
		wait(3)
		rushcloned.AdToEnabled.Enabled = true
	end
end

--[[function generateBayourd(RoomNumber) -- Function Generator Seek Entrance Room
	local randomroom = SpecialHallways.Bayourd
	local clonedroom = randomroom:Clone()
	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = RoomNumber -- Changing name to Current room
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end--]]

--[[function generateJeffShop(RoomNumber) -- Function Generator Seek Entrance Room
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
end--]]

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

function generateRoom(RoomNumber, Dark, Special, SpecialRoom)
	local randomroom
	if Special == true then
		randomroom = SpecialHallways:FindFirstChild("Hotel_"..SpecialRoom)
	else
		randomroom = PossibleHallways:GetChildren()[math.random(1, #PossibleHallways:GetChildren())]
	end
	local clonedroom = randomroom:Clone()
	local Type = "Hotel_"
	local DarkRoom = false
	
	if Dark == true then
		clonedroom.Assets:WaitForChild("Light_Fixtures"):Destroy()
		game.Workspace.Ambience_Dark:Play()
		DarkRoom = true
		if randomroom:FindFirstChild("Collid") then
			clonedroom:FindFirstChild("Collid").CanTouch = true
			local DarkBadBoi = script.Dark:Clone()
			DarkBadBoi.Enabled = true
			DarkBadBoi.Parent = clonedroom:FindFirstChild("Collid")
		end
	end

	local rolltop_point = randomroom:FindFirstChild("RolltopDeskPoint")
	local keyobtain = clonedroom:FindFirstChild("KeyObtain", true)
	local colors = clonedroom.Colors
	local randomwallcolor = math.random(1, 6)
	local randomcarpetcolor = math.random(1, 9)
	local coloratribute
	local keyatribute = false

	if rolltop_point then
		local randompoint = clonedroom.RolltopDeskPoint:GetChildren()[math.random(1, #clonedroom.RolltopDeskPoint:GetChildren())]
		local rolltop_desk = Furnitures.Rolltop_Desk:GetChildren()[math.random(1, #Furnitures.Rolltop_Desk:GetChildren())]
		local cloned = rolltop_desk:Clone()
		cloned.Name = "Rolltop_Desk"
		cloned.Parent = clonedroom.Assets
		cloned:PivotTo(randompoint.CFrame)
	end

	if keyobtain then
		keyatribute = true
	end

	if randomwallcolor == 1 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(109, 70, 70)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(109, 70, 70)
	elseif randomwallcolor == 2 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(89, 116, 117)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(89, 116, 117)
	elseif randomwallcolor == 3 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(69, 81, 109)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(69, 81, 109)
	elseif randomwallcolor == 4 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(76, 109, 91)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(76, 109, 91)
	elseif randomwallcolor == 5 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(134, 116, 95)
		color.Name = "color"
		color.Parent = colors.Wall
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(134, 116, 95)
	elseif randomwallcolor == 6 then
		local color = Instance.new("Color3Value")
		color.Value = Color3.fromRGB(72, 88, 125)
		color.Name = "color"
		color.Parent = colors
		colors.Wall.colortrue.Value = true
		coloratribute = Color3.fromRGB(72, 88, 125)
	end

	if randomcarpetcolor == 1 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(106, 79, 70)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(156, 116, 103)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Texture = "rbxassetid://12002739056"
		Texture.StudsPerTileU = 9
		Texture.StudsPerTileV = 9
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 2 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(71, 77, 69)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(102, 117, 102)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://9820813087"
		Texture.StudsPerTileU = 3
		Texture.StudsPerTileV = 3
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.88
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 3 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(81, 70, 61)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(77, 63, 63)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(198, 187, 162)
		Texture.Texture = "rbxassetid://849185396"
		Texture.StudsPerTileU = 6
		Texture.StudsPerTileV = 6
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 4 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 51, 51)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(91, 68, 73)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 247, 179)
		Texture.Texture = "rbxassetid://7960579811"
		Texture.StudsPerTileU = 72
		Texture.StudsPerTileV = 72
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.9
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 5 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(65, 63, 63)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(71, 69, 69)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 255, 255)
		Texture.Texture = "rbxassetid://2062021684"
		Texture.StudsPerTileU = 10
		Texture.StudsPerTileV = 10
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.97
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 6 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 86, 77)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(95, 109, 95)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://3476500459"
		Texture.StudsPerTileU = 4
		Texture.StudsPerTileV = 4
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.88
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 7 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(79, 51, 51)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(91, 68, 73)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(153, 148, 107)
		Texture.Texture = "rbxassetid://2279603548"
		Texture.StudsPerTileU = 15
		Texture.StudsPerTileV = 15
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.93
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 8 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(91, 62, 71)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(72, 74, 83)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(255, 255, 255)
		Texture.Texture = "rbxassetid://2535177972"
		Texture.StudsPerTileU = 10
		Texture.StudsPerTileV = 10
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0.5
		Texture.Transparency = 0.6
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
	elseif randomcarpetcolor == 9 then
		local Carpet = Instance.new("Color3Value")
		Carpet.Value = Color3.fromRGB(77, 63, 63)
		Carpet.Name = "Carpet"
		Carpet.Parent = colors.Carpet

		local CarpetLight = Instance.new("Color3Value")
		CarpetLight.Value = Color3.fromRGB(102, 83, 83)
		CarpetLight.Name = "CarpetLight"
		CarpetLight.Parent = colors.Carpet

		local Texture = Instance.new("Texture")
		Texture.Color3 = Color3.fromRGB(0, 0, 0)
		Texture.Texture = "rbxassetid://273619459"
		Texture.StudsPerTileU = 18
		Texture.StudsPerTileV = 15
		Texture.OffsetStudsU = 0
		Texture.OffsetStudsV = 0
		Texture.Transparency = 0.85
		Texture.Face = "Top"
		Texture.Parent = colors.Carpet
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

	clonedroom:SetAttribute("ColorAmbient", coloratribute)
	clonedroom:SetAttribute("RoomNumber", workspace.Rooms.CurrentRoom.Value -1)
	clonedroom:SetAttribute("KeyRequire", keyatribute)
	clonedroom:SetAttribute("Dark", DarkRoom)
	clonedroom:SetAttribute(Type, true)
	

	for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do
		local addPainting = math.random(1, 6) 

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
		elseif addPainting < 6 then
			local Painting = Paintings:WaitForChild("Painting_VeryBig"):Clone()
			Painting.Parent = script.Parent.Parent.Parent:WaitForChild("Assets")
			Painting.Canvas.SurfaceGui.Script.Enabled = true
			Painting:PivotTo(v.CFrame)
		end
	end
	
	local keyspawned = false

	for i, v in pairs(clonedroom:WaitForChild("FurniturePoint"):GetChildren()) do
		local addFurniture = math.random(1, 200) 

		if addFurniture < 25 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("TableObtain"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)

			if keyobtain then
				if keyspawned == false then
					keyspawned = true
					keyobtain:PivotTo(Dresser:FindFirstChild("MainObtain").CFrame)
				end
			end
		elseif addFurniture < 50 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("DresserObtain"):Clone()
			Dresser.Name = "Dresser"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
			Dresser:PivotTo(v.CFrame)

			if keyobtain then
				if keyspawned == false then
					keyspawned = true
					keyobtain:PivotTo(Dresser:FindFirstChild("MainObtain").CFrame)
				end
			end
		elseif addFurniture < 75 then -- Random to spawn
			local Dresser = Furnitures:WaitForChild("Table"):Clone()
			Dresser.Name = "Table"
			Dresser.Parent = clonedroom:WaitForChild("Assets")
		    Dresser:PivotTo(v.CFrame)
                
			if keyobtain then
				if keyspawned == false then
					keyspawned = true
					keyobtain:PivotTo(Dresser:FindFirstChild("MainObtain").CFrame)
				end
			end
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

function generateFigureLibrary(RoomNumber) -- Function Generator Room 50 - Figure boss
	local randomroom = SpecialHallways.Hotel_LibraryEntrance
	local clonedroom = randomroom:Clone()

	clonedroom.PrimaryPart = clonedroom.RoomStart -- Clone room get a Primaty part
	clonedroom:PivotTo(script.Parent.Parent.Parent.RoomEnd.CFrame) -- Cloned room moving to generate part
	clonedroom.Name = workspace.Rooms.CurrentRoom.Value
	workspace.Rooms.CurrentRoom.Value += 1
	clonedroom.Setting.Generation.Enabled = true
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room
end

local generatedrooms = {prevRoom}

script.Parent.Touched:Connect(function(roomNum)
	if workspace.Rooms.CurrentRoom.Value == game:GetService("Workspace").Rooms:GetAttribute("SeekRoom") then
		generateSeekEntrance(game.Workspace.CurrentRooms.CurrentRoom.Value)
		script.Parent.CanTouch = false
	elseif workspace.Rooms.CurrentRoom.Value == 49 then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "FigureLibrary")
		--generateFigureLibrary(game.Workspace.CurrentRooms.CurrentRoom.Value)
		script.Parent.CanTouch = false
	elseif workspace.Rooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("NextDarkRoom") then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, true)
		script.Parent.CanTouch = false	
	elseif workspace.Rooms.CurrentRoom.Value == 52 then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "JeffShop")
		--generateJeffShop(game.Workspace.CurrentRooms.CurrentRoom.Value)
		script.Parent.CanTouch = false
	elseif workspace.Rooms.CurrentRoom.Value == 99 then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "Bayourd")
		script.Parent.CanTouch = false
	elseif workspace.Rooms.CurrentRoom.Value == game:GetService("Workspace").Rooms:GetAttribute("CourtyardRoom") then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "Courtyard")
		script.Parent.CanTouch = false
	else
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
		script.Parent.CanTouch = false
	end
end)

if workspace.Rooms.CurrentRoom.Value >= 4 then
	local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
	local cur1 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 1
	local cur2 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 2
	local cur3 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 3
	local cur4 = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value - 4
	local g = game.Workspace.CurrentRooms.CurrentRoom.Value - 4
	if game.Workspace.CurrentRooms:FindFirstChild(g) then
		game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value = g + 1
		game.Workspace.CurrentRooms:WaitForChild(cur).Door.Name = "Door"..cur
		game.Workspace.CurrentRooms:WaitForChild(cur):FindFirstChild("Door"..cur).Parent = game.Workspace.OnDeletedDoors
		wait(0.1)
		if game.Workspace.OnDeletedDoors:FindFirstChild("Door"..cur) then
			game.Workspace.OnDeletedDoors:FindFirstChild("Door"..cur).HingeConstraint.TargetAngle = 0
			game.Workspace.OnDeletedDoors:FindFirstChild("Door"..cur).HingeConstraint.ServoMaxTorque = 255565
			wait(0.1)
			game.Workspace.OnDeletedDoors:FindFirstChild("Door"..cur).Collicion.CanCollide = true
			wait(0.5)
			game.Workspace.CurrentRooms:WaitForChild(cur):Destroy()
			if game.Workspace.CurrentRooms:FindFirstChild(cur1) then
				game.Workspace.CurrentRooms:FindFirstChild(cur1):Destroy()
			elseif game.Workspace.CurrentRooms:FindFirstChild(cur2) then
				game.Workspace.CurrentRooms:FindFirstChild(cur2):Destroy()
			elseif game.Workspace.CurrentRooms:FindFirstChild(cur3) then
				game.Workspace.CurrentRooms:FindFirstChild(cur3):Destroy()
			elseif game.Workspace.CurrentRooms:FindFirstChild(cur4) then
				game.Workspace.CurrentRooms:FindFirstChild(cur4):Destroy()
			end
			local crty = game.Workspace.CurrentRooms.CurrentRoom.Door.Value
			local crty1 = game.Workspace.CurrentRooms.CurrentRoom.Door.Value - 1
			local crty2 = game.Workspace.CurrentRooms.CurrentRoom.Door.Value - 2
			local crty3 = game.Workspace.CurrentRooms.CurrentRoom.Door.Value - 3
			local crty4 = game.Workspace.CurrentRooms.CurrentRoom.Door.Value - 4
			if game.Workspace.OnDeletedDoors:FindFirstChild("Door"..game.Workspace.CurrentRooms.CurrentRoom.Door.DoorAlt.Value) then
				game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty):Destroy()
				if game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty1) then
					game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty1):Destroy()
				elseif game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty2) then
					game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty2):Destroy()
				elseif game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty3) then
					game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty3):Destroy()
				elseif game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty4) then
					game.Workspace.OnDeletedDoors:FindFirstChild("Door"..crty4):Destroy()
				end
				wait(.1)
				game.Workspace.CurrentRooms.CurrentRoom.Door.Value += 1
				game.Workspace.CurrentRooms.CurrentRoom.Door.DoorAlt.Value += 1
			end
		end
	end
end