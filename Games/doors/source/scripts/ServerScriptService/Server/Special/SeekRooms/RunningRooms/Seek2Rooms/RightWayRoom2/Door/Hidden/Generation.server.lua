local ReplicatedStoragee = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ServerScriptService")
local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special")

local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
local Furnitures = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
local RunSrevice = game:GetService('RunService')
prevRoom = script.Parent.Parent

-- ROOM SETTINGS -- 

local door = script.Parent.Parent
door:PivotTo(script.Parent.Parent.Parent:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, 0.7))

local DarkRoomRandom = math.random(11, 20)

-- GENERATOR SCRIPT --

function generateRoom(RoomNumber, Special, SpecialRoom)
	local randomroom
	if Special == true then
		randomroom = SpecialHallways.SeekRooms.RunningRooms.Seek2Rooms:FindFirstChild(SpecialRoom)
	else
		randomroom = PossibleHallways:GetChildren()[math.random(1, #PossibleHallways:GetChildren())]
	end
	local clonedroom = randomroom:Clone()
	local Type = "Hotel_"
	local DarkRoom = false


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
	workspace.CurrentRooms.CurrentRoom.Value += 1
	clonedroom.Parent = GeneratedRooms -- Parent to Rooms
	prevRoom = clonedroom -- Prev room this Cloned Room

	clonedroom:SetAttribute("ColorAmbient", coloratribute)
	clonedroom:SetAttribute("RoomNumber", workspace.CurrentRooms.CurrentRoom.Value -1)
	clonedroom:SetAttribute("KeyRequire", keyatribute)
	clonedroom:SetAttribute("Dark", DarkRoom)
	clonedroom:SetAttribute(Type, true)
	
	game.ReplicatedStorage.Bricks.FireCamera:FireAllClients(3, 24, 0, 0.7)
	require(game.ReplicatedStorage.ClientModules.EntityModules.Seek).tease(clonedroom, 45, 5, true)
end

local generatedrooms = {prevRoom}

script.Parent.Touched:Connect(function(roomNum)
	generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, true, "LeftWayRoom2")
	script.Parent.CanTouch = false
end)

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