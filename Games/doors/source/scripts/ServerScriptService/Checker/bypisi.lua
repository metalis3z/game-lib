
local module = {}

-- Created and Fixed by BUILDG Studios

local Chests = require(script.Parent["Chests"])
local TypeDoors = require(script.Parent["TypeDoors"])
local Furnitures = require(script.Parent["Furnitures"])
local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local Entities = require(script.Parent["Entities"])
local GameDetails = require(script.Parent["GameDetails"])
local PlayerAttribute = require(script.PlayerAttribute)
local RoomsData = require(game.ServerScriptService.Server.Attributes.RoomsData)
local LeverObtain = require(script.Parent["LeverObtain"])
local PaintingsModule = require(script.Parent.Parent.Controls.Paintings)
local SeekModule = require(game.ReplicatedStorage.ClientModules.EntityModules.Seek)
local RoomInteractable = require(script.Parent.Parent.Controls.RoomInteractable)
local Drawers = require(script.Parent.Parent.Directory.Drawers)
local Rolltop_Desk_M = require(script.Parent.Parent.Controls.Rolltop_Desk)
local Obstructions = require(script.Parent.Parent.Controls.Obstructions)
local ItemsControls = require(script.Parent.Parent.Controls.Items)

local Anims = {
	BookshelfObstruction = "rbxassetid://13401085851"
}

local RoomSettings = {
	DoorValueFromDoorEnd = 0.7,
}

function module:DeleteRooms()
	local currentRoomValue = game.Workspace.CurrentRooms.CurrentRoom.Value
	if currentRoomValue >= 4 then
		local cur = game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value
		local cur1 = cur - 1
		local cur2 = cur - 2
		local cur3 = cur - 3
		local cur4 = cur - 4
		local cur5 = cur - 5
		local g = currentRoomValue - 4

		if game.Workspace.CurrentRooms:FindFirstChild(tostring(g)) then
			game.Workspace.CurrentRooms.CurrentRoom.Despawn.Value = g + 1

			local curRoom = game.Workspace.CurrentRooms:FindFirstChild(tostring(cur))

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
			moveToOnDeletedDoors(cur)

			for _, roomNum in ipairs({cur1, cur2, cur3, cur4, cur5}) do
				local room = game.Workspace.CurrentRooms:FindFirstChild(tostring(roomNum))
				local room2 = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 4)
				if room then
					room:Destroy()
					moveToOnDeletedDoors(roomNum)
				end
				if room2 then
					room2:Destroy()
				end
			end

			wait(.1)
			game.Workspace.CurrentRooms.CurrentRoom.Door.Value += 1
			game.Workspace.CurrentRooms.CurrentRoom.Door.DoorAlt.Value += 1
		end
	end
end

function module:JackJumpcare()
	local dwdwa = Instance.new("NumberValue")
	dwdwa.Parent = workspace
end

function module:Open(Hidden, SkeletonDoor)
	local nomer = game.Workspace:FindFirstChild("CurrentRooms"):WaitForChild("CurrentRoom").Value - 1
	
	if SkeletonDoor == true then
		Hidden.Parent.Parent.Parent.Door.Transparency = 1
		Hidden.Parent.Parent.Parent.Door.CanCollide = false
		Hidden.Parent.Transparency = 1
		Hidden.Parent.CanCollide = false
		Hidden.Parent.Parent.Parent.Door.ParticleEmitter.Enabled = true
		wait(0.15)
		Hidden.Parent.Parent.Parent.Door.ParticleEmitter.Enabled = false
	else
		Hidden.Touched:Connect(function(hit)
			--print(hit.Name)
			--if hit.Name == "Collision" or hit.Name == "HumanoidRootPart" or hit.Name == "LeftFoot" or hit.Name == "LeftHand" or hit.Name == "LeftLowerArm" or hit.Name == "LeftLowerLeg" or hit.Name == "LeftUpperArm" or hit.Name == "LeftUpperLeg" or hit.Name == "LowerTorso" or hit.Name == "RightFoot" or hit.Name == "RightHand" or hit.Name == "RightLowerArm" or hit.Name == "RightLowerLeg" or hit.Name == "RightUpperArm" or hit.Name == "RightUpperLeg" or hit.Name == "UpperTorso" or hit.Name == "Head" then
			if Hidden.Parent:FindFirstChild("BlackHidden") then
				Hidden.Parent:FindFirstChild("BlackHidden").Transparency = 1
			end
			Hidden.Parent.KnobConstraint.TargetAngle = 45
			Hidden.Parent.Door.Anchored = false
			Hidden.Parent.Door.CanCollide = false
			Hidden.CanTouch = false
			Hidden.Parent.Door.Open:Play()
			wait(0.5)
			Hidden.Parent.KnobConstraint.TargetAngle = 0
			--end
		end)
	end
end

function module:DoorGenerate(v)
	local SecretStorage = game:GetService("ServerScriptService")

	local function generateDoor()
		local cloneddoor = SecretStorage.Server.Assets.Door:Clone()

		if cloneddoor:FindFirstChild("BlackHidden") then
			cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
		end
		cloneddoor.Parent = v
		cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, RoomSettings.DoorValueFromDoorEnd))
	end
	
	for i = 1, 1 do
		generateDoor()
	end
end

function module:DoorKeyGenerate(v)
	local SecretStorage = game:GetService("ServerScriptService")

	local function generateDoor()
		local cloneddoor = SecretStorage.Server.Assets.DoorKey:Clone()
		
		if cloneddoor:FindFirstChild("BlackHidden") then
			cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
		end
		cloneddoor.Name = "Door"
		cloneddoor.Parent = v
		cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, RoomSettings.DoorValueFromDoorEnd))
	end

	for i = 1, 1 do
		generateDoor()
	end
end

function module:DoorKeyGenerateFirstRoom(v)
	local SecretStorage = game:GetService("ServerScriptService")

	local function generateDoor()
		local cloneddoor = SecretStorage.Server.Assets.DoorKeyFirstRoom:Clone()

		if cloneddoor:FindFirstChild("BlackHidden") then
			cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
		end
		cloneddoor.Name = "Door"
		cloneddoor.Parent = v
		cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, RoomSettings.DoorValueFromDoorEnd))
	end

	for i = 1, 1 do
		generateDoor()
	end
end

function module:Generate(Hidden, Start, SpecialRoom_p1)
	
	-- ADDING CODES --
	
	local ReplicatedStoragee = game:GetService("ReplicatedStorage")
	local ReplicatedStorage = game:GetService("ServerScriptService")
	local PossibleHallways = ReplicatedStorage.Server:WaitForChild("Rooms")
	local Furnituress = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")
	local SpecialHallways = ReplicatedStorage.Server:WaitForChild("Special")
	local SeekSpecialHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):FindFirstChild("4Eyeball")
	
	local Eye4ballSeek = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):FindFirstChild("4Eyeball"):GetChildren()
	local Eye8ballSeek = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):FindFirstChild("8Eyeball"):GetChildren()
	local Eye12ballSeek = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("EntranceSeekRooms"):FindFirstChild("12Eyeball"):GetChildren()
	
	local SeekHallway = ReplicatedStorage.Server:WaitForChild("Special"):WaitForChild("SeekRooms"):FindFirstChild("RandomHallway"):GetChildren()

	local GeneratedRooms = workspace:WaitForChild("CurrentRooms")
	local Paintings = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Paintings")
	local Items = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Items"):WaitForChild("Handles")
	local RunSrevice = game:GetService('RunService')

	local function GameEntity(boolen1, boolen2)
		if workspace:FindFirstChild("Entities") then
			return
		else
			local folder = Instance.new("Folder")
			folder.Parent = workspace
			folder.Name = "Entities"

			folder:SetAttribute("CustomEntity", boolen1)
			folder:SetAttribute("GameEntity", boolen2)
		end
	end
	
	-- SPAWNER ENTITIES --
	
	local function spawnEntity(entity, ID)
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
		elseif entity == "Entities_Lookman" then
			if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
				return
			end
			GameEntity(false, true)
			local number = math.random(5, 20)
			local num = math.random(1, 2)
			local lookmancloned = game.ServerScriptService.Server.Assets.Entities.LookMan:Clone()
			lookmancloned.Range.Name = "WaitFor"
			local gamecode = game.Workspace.CurrentRooms.CurrentRoom.Value - 1
			local gamecode2 = game.Workspace.CurrentRooms.CurrentRoom.Value + 1
			
			Entities:Lookman_Eyes(lookmancloned, gamecode2)
			
			task.delay(2, function()
				lookmancloned.WaitFor.Name = "Range"
				lookmancloned.EffectsLookman.Attachment.Eyes.Enabled = true
			end)
			
			lookmancloned.EffectsLookman.Ambience:Play()
			lookmancloned.EffectsLookman.Initiate:Play()
			lookmancloned.EffectsLookman.Attachment.Spark.Enabled = true
			
			lookmancloned.Parent = game.Workspace.CurrentRooms:FindFirstChild(gamecode)
			if num == 1 then
				lookmancloned.WaitFor.CFrame = game.Workspace.CurrentRooms:FindFirstChild(gamecode).RoomStart.CFrame * CFrame.new(0, 1.5, -number);
				lookmancloned.PrimaryPart.CFrame = game.Workspace.CurrentRooms:FindFirstChild(gamecode).RoomStart.CFrame * CFrame.new(0, 1.5, -number);
			elseif num == 2 then
				lookmancloned.WaitFor.CFrame = game.Workspace.CurrentRooms:FindFirstChild(gamecode).RoomEnd.CFrame * CFrame.new(0, 1.5, number);
				lookmancloned.PrimaryPart.CFrame = game.Workspace.CurrentRooms:FindFirstChild(gamecode).RoomEnd.CFrame * CFrame.new(0, 1.5, number);
			end
		end
	end
	
	-- MAIN GENERATOR OF ALL ROOMS --
	-- (generating room: Color walls, Color and texture rug, generating random furnitures, generating random paintings, generating another special rooms) --
	

	local function generateRoom(RoomNumber, Dark, Special, SpecialRoom, Seek, SeekRoomName, HaltRoom, SeekHallwayRoom, FigureRoomes)
		
		local nomer = game.Workspace:FindFirstChild("CurrentRooms"):WaitForChild("CurrentRoom").Value - 1
		
		local saveroom = nil
		local randomroom
		
		local tables = {}
		
		for i, v in pairs(PossibleHallways:GetChildren()) do
			if v:IsA("Folder") then
				for i, v2 in pairs(v:GetChildren()) do
					if v2:IsA("Model") then
						if v2:GetAttribute("OriginalName") == game.Workspace.CurrentRooms.NextNegativeRoom.Value  then
							
						else
							table.insert(tables, v2:GetAttribute("OriginalName"))
						end
					end
				end
			end
		end
		
		print(tables)
		
		local randomRoomName = tables[math.random(1, #tables)]
		game.Workspace.CurrentRooms.NextNegativeRoom.Value = randomRoomName
		
		local CanDarkRoom = true
		
		if nomer == game:GetService("Workspace").CurrentRooms:GetAttribute("HaltRoomRandom1") - 1 then
			game.Workspace.GameSettings.Server.RunRush.Value = false
			game.Workspace.GameSettings.Server.NextRush.Value = false
		end
		
		if SpecialRoom == "Bayourd" then
			CanDarkRoom = false
			game.Workspace.GameSettings.Server.RunRush.Value = false
		end
		
		if SpecialRoom == "LibraryEntrance" then
			CanDarkRoom = false
			game.Workspace.GameSettings.Server.RunRush.Value = false
			game.Workspace.CurrentRooms.CurrentRoom.FigureLibraryValue.Value = true
		end

		if SpecialRoom == "HaltsCorridor" then
			CanDarkRoom = false
			game.Workspace.GameSettings.Server.RunRush.Value = false
			game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue.Value = true
		end
		
		if Seek == true then
			if SeekRoomName == "SeekHallway" then
				randomroom = SeekHallway[math.random(1, #SeekHallway)] --SeekHallway
			elseif SeekRoomName == "Eye4ballSeek" or SeekRoomName == "Eye8ballSeek" or SeekRoomName == "Eye12ballSeek" then
				local possibleHallways = PossibleHallways:GetChildren()
				if #possibleHallways > 0 then
					if possibleHallways[math.random(1, #possibleHallways)]:IsA("Folder") then
						local randomFolder = possibleHallways[math.random(1, #possibleHallways)]

						if not randomFolder then
							warn("Didnt defacted rooms folder, add back folder rooms")
						end

						local randomizer = randomFolder:GetChildren()

						randomroom = randomizer[math.random(1, #randomizer)]
					else
						randomroom = possibleHallways[math.random(1, #possibleHallways)]
					end
				else

				end
			end
		else
			if Special == true then
				local specialRoom = SpecialHallways:FindFirstChild("Hotel_"..SpecialRoom)
				if specialRoom then
					randomroom = specialRoom
				else
					
				end
			else
				local possibleHallways = PossibleHallways:GetChildren()
				if #possibleHallways > 0 then
					if possibleHallways[math.random(1, #possibleHallways)]:IsA("Folder") then
						local randomFolder = possibleHallways[math.random(1, #possibleHallways)]
						
						if not randomFolder then
							warn("Didnt defacted rooms folder, add back folder rooms")
						end
						
						local randomizer = randomFolder:GetChildren()
						
						randomroom = randomizer[math.random(1, #randomizer)]
						
						for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
							if v8:GetAttribute("SaveRoom") == math.random(2, 9) then
								saveroom = v8
							end
						end
					else
						randomroom = possibleHallways[math.random(1, #possibleHallways)]
						
						for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
							if v8:GetAttribute("SaveRoom") == math.random(2, 9) then
								saveroom = v8
							end
						end
					end
				else

				end
			end
		end
		
		local clonedroom
		
		if game.Workspace.GameSettings.Server.NextRush.Value == true then
			if SpecialRoom_p1 == true then
				clonedroom = randomroom
			else
				if saveroom == nil then
					local backup = math.random(1, 5)
					if backup == 1 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner4:Clone()
					elseif backup == 2 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner5:Clone()
					elseif backup == 3 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner6:Clone()
					elseif backup == 4 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_Hallway12:Clone()
					elseif backup == 5 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_Hallway11:Clone()
					end
				else
					clonedroom = saveroom:Clone()
				end
				game.Workspace.GameSettings.Server.NextRush.Value = false
				ModuleEvents.flickerLights(clonedroom, 2)
			end
		else
			if SpecialRoom_p1 == true then
				clonedroom = randomroom
			else
				if randomroom == nil then
					local backup = math.random(1, 5)
					if backup == 1 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner4:Clone()
					elseif backup == 2 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner5:Clone()
					elseif backup == 3 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_HallwayCorner6:Clone()
					elseif backup == 4 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_Hallway12:Clone()
					elseif backup == 5 then
						clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_Hallway11:Clone()
					end
				else
					print(randomroom)
					clonedroom = randomroom:Clone()
				end
			end
		end
		
		if SeekRoomName == "Eye4ballSeek" then
			SeekModule.tease(clonedroom, math.random(7, 12), math.random(32, 48))
			game.Workspace.GameSettings.Server.RunRush.Value = false
		elseif SeekRoomName == "Eye8ballSeek" then
			SeekModule.tease(clonedroom, math.random(12, 18), math.random(32, 48))
			game.Workspace.GameSettings.Server.RunRush.Value = false
		elseif SeekRoomName == "Eye12ballSeek" then
			SeekModule.tease(clonedroom, math.random(18, 30), math.random(32, 48))
			game.Workspace.GameSettings.Server.RunRush.Value = false
		end
		
		clonedroom.Name = RoomNumber
		for v9, v10 in pairs(clonedroom:GetDescendants()) do
			if v10:IsA("Model") and string.find(v10.Name, "BookshelfObstruction") then
				Obstructions:Bookshelf(v10)
			end
		end
		if SpecialRoom_p1 == true then
			clonedroom.Parent = game.Workspace.CurrentRooms:FindFirstChild(nomer)
		else
			clonedroom.Parent = GeneratedRooms
			workspace.CurrentRooms.CurrentRoom.Value += 1
		end
		
		if SpecialRoom == "JeffShop" then
			local Stuff = clonedroom:FindFirstChild("ShopStuff")
			
			local ItemsList = {"SkeletonKey", "Lighter", "Vitamins", "Flashlight"}
			
			ItemsControls:BuyableItem(Stuff.PurchasableItem1.Crucifix)
			ItemsControls:BuyableItem(Stuff.PurchasableItem2.Lighter)
			ItemsControls:BuyableItem(Stuff.PurchasableItem3.Vitamins)
			ItemsControls:BuyableItem(Stuff.PurchasableItem4.Flashlight)
			
			--[[for i = 1, 4 do
				ItemsControls:BuyableItem(Stuff:FindFirstChild("PurchasableItem"..i):FindFirstChild(ItemsList))
			end--]]
			
			game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue.Value = false
			game.Workspace.CurrentRooms.CurrentRoom.FigureLibraryValue.Value = false
			
			randomroom.ShopStuff.RadioShop.Hitbox.MusicFar:Play()
			randomroom.ShopStuff.RadioShop.Hitbox.MusicClose:Play()
		elseif SpecialRoom == "Infirmary" then
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					game.ReplicatedStorage.ClientBricks.RiftInfirmary:FireClient(v)
				end
			end
		elseif SpecialRoom == "LibraryEntrance" then
			Drawers.Scan(clonedroom.Assets.Library_Desk)
		end
		
		local Type = "Hotel_"
		local DarkRoom = false
		
		local Rugclear_1 = math.random(1, 13)
		local Rugclear_2 = math.random(1, 13)
		
		if Rugclear_1 == Rugclear_2 then
			if clonedroom.Assets:FindFirstChild("Rug") then
				clonedroom.Assets:FindFirstChild("Rug"):Destroy()
			end
		end

		if CanDarkRoom == true then
			if math.random(1, game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value) == math.random(1, game.Workspace.CurrentRooms.CurrentRoom.DarkIncrease.Value) then
				for v1, v2 in pairs(clonedroom:GetDescendants()) do
					if v2:IsA("Model") then
						if v2.Name == "Chandelier" then
							v2:Destroy()
						end

						if v2.Name == "LightStand" then
							v2:Destroy()
						end
					end
				end
				game.Workspace.Ambience_Dark:Play()
				GameDetails:DarkAttribute(clonedroom)
				DarkRoom = true
			else
				GameDetails:BasicAttribute(clonedroom)
			end

			if HaltRoom == true then
				ModuleEvents.flickerLights(clonedroom, 4)
			end
		else
			GameDetails:BasicAttribute(clonedroom)
		end
		
		local rolltop_pointSaveRoom = clonedroom:FindFirstChild("RolltopDeskPoint")

		local rolltop_point = clonedroom:FindFirstChild("RolltopDeskPoint")
		local keyobtain = clonedroom:FindFirstChild("KeyObtain", true)
		local colors = clonedroom.Colors
		local randomwallcolor = math.random(1, 6)
		local randomcarpetcolor = math.random(1, 9)
		local coloratribute
		local keyatribute = false
		
		if clonedroom:FindFirstChild("CollideRoom") then
			RoomInteractable:PlayerAttribute(clonedroom)
		end
		
		if keyobtain then
			keyatribute = true
			module:DoorKeyGenerate(clonedroom)
		else
			if SeekHallwayRoom == true or FigureRoomes == true then
				
			else
				if Seek == true then
					module:DoorGenerate(clonedroom)
				else
					if SpecialRoom == "Bayourd" then
						module:DoorGenerate(clonedroom, "LastDoorEnd_1")
					else
						module:DoorGenerate(clonedroom)
					end
				end
			end
		end
		
		-- Random broken doors / Normal doors handle #DoorsHandle
		
		local dupeSpawned = false
		local closetSpawned = false
		
		if clonedroom:FindFirstChild("RandomDoors") then
			local AssetsServer = game.ServerScriptService.Server.Assets.Doors.BlockedDoors
			
			for i, v in pairs(clonedroom:WaitForChild("RandomDoors"):GetChildren()) do
				local random = math.random(1, 3)
				local randomCloset = math.random(1, 3)
				local randomSign = math.random(1, 3)
				
				if random == 2 and dupeSpawned == false and game.Workspace.CurrentRooms.CurrentRoom.Value >= 5 then
					if v:GetAttribute("LoadModule") == "DoorNormal" then
						local randomdoor = AssetsServer.Parent.DoorNormal
						local cloneddoor = randomdoor:Clone()

						TypeDoors:DoorNormal(cloneddoor)
						cloneddoor.Parent = clonedroom
						cloneddoor:PivotTo(v.CFrame)

						v:Destroy()
					else
						if keyatribute == true then
							dupeSpawned = true

							local randomcloset = AssetsServer.Parent.Parent.Closets.ClosetDupe
							local clonedcloset = randomcloset:Clone()

							workspace.GameSettings.Fires.DupeEvent:Fire()

							Entities:Dupe_Door(clonedcloset.Hidden)
							clonedcloset.Parent = clonedroom
							clonedcloset:PivotTo(v.CFrame)
							v:Destroy()
						else
							dupeSpawned = true

							local randomcloset = AssetsServer.Parent.Parent.Closets.ClosetDupe
							local clonedcloset = randomcloset:Clone()

							workspace.GameSettings.Fires.DupeEvent:Fire()

							Entities:Dupe_Door(clonedcloset.Hidden)
							clonedcloset.Parent = clonedroom
							clonedcloset:PivotTo(v.CFrame)
							v:Destroy()
						end
					end
				else
					if v:GetAttribute("LoadModule") == "DoorNormal" then
						local randomdoor = AssetsServer.Parent.DoorNormal
						local cloneddoor = randomdoor:Clone()

						TypeDoors:DoorNormal(cloneddoor)
						cloneddoor.Parent = clonedroom
						cloneddoor:PivotTo(v.CFrame)
						
						v:Destroy()
					else
						if random == 2 and closetSpawned == false then
							closetSpawned = true
							local randomcloset = AssetsServer.Parent.Parent.Closets.ClosetChest
							local clonedcloset = randomcloset:Clone()

							TypeDoors:DoorNormal(clonedcloset.DoorNormal)
							clonedcloset.Parent = clonedroom
							clonedcloset:PivotTo(v.CFrame)
							
							local spawned = false
							
							for i, v in pairs(clonedcloset.ChestPoints:GetChildren()) do
								if spawned == false then
									spawned = true
									Chests:ChestBasic(v)
								end
							end
							
							v:Destroy()
						else
							local randomdoor = AssetsServer:GetChildren()[math.random(1, #AssetsServer:GetChildren())]
							local cloneddoor = randomdoor:Clone()

							cloneddoor.Parent = clonedroom
							cloneddoor:PivotTo(v.CFrame)
							
							v:Destroy()
						end
					end
				end
			end
			task.delay(1, function()
				clonedroom:WaitForChild("RandomDoors"):Destroy()
			end)
		end
		
		-- Lever system load
		
		if clonedroom.Assets:FindFirstChild("LeverForGate") then
			local randompoint = clonedroom.PullPoints:GetChildren()[math.random(1, #clonedroom.PullPoints:GetChildren())]
			local Lever = clonedroom.Assets.LeverForGate
			
			LeverObtain:Create(Lever)
			Lever:PivotTo(randompoint.CFrame)
			task.wait()
			clonedroom.PullPoints:Destroy()
		end
		
		local Invalid = math.random(1, 15)
		local Correct = math.random(1, 15)
		
		local Invalid2 = math.random(1, 10)
		local Correct2 = math.random(1, 10)
		
		if Invalid == Correct then
			ModuleEvents.flickerLights(clonedroom, 0.6)
		end
		
		if Invalid == Correct2 then
			ModuleEvents.breakLights_Time(clonedroom, 8)
		end
		
		if game.Workspace.GameSettings.DisableRush_Entity.Value == true then
		else
			if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom") - 1 then
				game.Workspace.GameSettings.Server.NextRush.Value = true
				--ModuleEvents.flickerLights(clonedroom, 1)
			elseif game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom2") - 1 then
				game.Workspace.GameSettings.Server.NextRush.Value = true
				--ModuleEvents.flickerLights(clonedroom, 1)
			elseif game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom3") - 1 then
				game.Workspace.GameSettings.Server.NextRush.Value = true
				--ModuleEvents.flickerLights(clonedroom, 1)
			elseif game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom4") - 1 then
				game.Workspace.GameSettings.Server.NextRush.Value = true
				--ModuleEvents.flickerLights(clonedroom, 1)
			end
		end
		
		if saveroom ~= nil then
			if rolltop_pointSaveRoom then
				local randompoint = clonedroom.RolltopDeskPoint:GetChildren()[math.random(1, #clonedroom.RolltopDeskPoint:GetChildren())]
				local rolltop_desk = Furnituress.Rolltop_Desk:GetChildren()[math.random(1, #Furnituress.Rolltop_Desk:GetChildren())]
				local cloned = rolltop_desk:Clone()
				cloned.Name = "Rolltop_Desk"
				cloned.Parent = clonedroom.Assets
				cloned:PivotTo(randompoint.CFrame)
				
				Rolltop_Desk_M:New(cloned)
				Drawers.Scan(cloned)
			end
		else
			if rolltop_point then
				local randompoint = clonedroom.RolltopDeskPoint:GetChildren()[math.random(1, #clonedroom.RolltopDeskPoint:GetChildren())]
				local rolltop_desk = Furnituress.Rolltop_Desk:GetChildren()[math.random(1, #Furnituress.Rolltop_Desk:GetChildren())]
				local cloned = rolltop_desk:Clone()
				cloned.Name = "Rolltop_Desk"
				cloned.Parent = clonedroom.Assets
				cloned:PivotTo(randompoint.CFrame)
				
				Rolltop_Desk_M:New(cloned)
				Drawers.Scan(cloned)
			end
		end

		if randomwallcolor == 1 then
			coloratribute = Color3.fromRGB(109, 70, 70)
		elseif randomwallcolor == 2 then
			coloratribute = Color3.fromRGB(89, 116, 117)
		elseif randomwallcolor == 3 then
			coloratribute = Color3.fromRGB(69, 81, 109)
		elseif randomwallcolor == 4 then
			coloratribute = Color3.fromRGB(76, 109, 91)
		elseif randomwallcolor == 5 then
			coloratribute = Color3.fromRGB(134, 116, 95)
		elseif randomwallcolor == 6 then
			coloratribute = Color3.fromRGB(72, 88, 125)
		end
		
		for v7, v8 in pairs(clonedroom:GetDescendants()) do
			if v8:IsA("Model") then
				if v8.Name == "Door" then
					v8.Door.Material = Enum.Material.Wood
					v8.Door.MaterialVariant = "PlywoodALT"
				end;
			end;

			if v8:IsA("MeshPart") then
				if v8.Name == "Door" or v8.Name == "FakeDoor" then
					v8.Material = Enum.Material.Wood
					v8.MaterialVariant = "PlywoodALT"
				end;
			end;
		end;
		
		for v7, v8 in pairs(clonedroom:GetDescendants()) do
			if v8:IsA("BasePart") then
				if clonedroom:GetAttribute("OriginalName") == "Hotel_Courtyard" then
					
				else
					if v8.Name == "Wall" then
						v8.Color = coloratribute

						v8.Material = Enum.Material.Wood
						v8.MaterialVariant = "Plaster"
					end;
				end
			end;
		end;

		if randomcarpetcolor == 1 then
			local Carpet = Color3.fromRGB(106, 79, 70)

			local CarpetLight = Color3.fromRGB(156, 116, 103)

			local Texture = Instance.new("Texture")
			Texture.Texture = "rbxassetid://12002739056"
			Texture.StudsPerTileU = 9
			Texture.StudsPerTileV = 9
			Texture.OffsetStudsU = 0
			Texture.OffsetStudsV = 0
			Texture.Transparency = 0.85
			Texture.Face = "Top"
			Texture.Parent = colors.Carpet
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 2 then
			local Carpet = Color3.fromRGB(71, 77, 69)

			local CarpetLight = Color3.fromRGB(102, 117, 102)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 3 then
			local Carpet = Color3.fromRGB(81, 70, 61)

			local CarpetLight = Color3.fromRGB(77, 63, 63)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8
						
						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8
						
						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 4 then
			local Carpet = Color3.fromRGB(79, 51, 51)

			local CarpetLight = Color3.fromRGB(91, 68, 73)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 5 then
			local Carpet = Color3.fromRGB(65, 63, 63)

			local CarpetLight = Color3.fromRGB(71, 69, 69)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 6 then
			local Carpet = Color3.fromRGB(79, 86, 77)

			local CarpetLight = Color3.fromRGB(95, 109, 95)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 7 then
			local Carpet = Color3.fromRGB(79, 51, 51)

			local CarpetLight = Color3.fromRGB(91, 68, 73)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 8 then
			local Carpet = Color3.fromRGB(91, 62, 71)

			local CarpetLight = Color3.fromRGB(72, 74, 83)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		elseif randomcarpetcolor == 9 then
			local Carpet = Color3.fromRGB(77, 63, 63)

			local CarpetLight = Color3.fromRGB(102, 83, 83)

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
			
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Carpet" then
						v8.Color = Carpet
					end;
					if v8.Name == "CarpetLight" then
						v8.Color = CarpetLight
						Texture:Clone().Parent = v8

						local v1 = Texture:Clone()
						v1.Face = "Left"
						v1.Parent = v8

						local v2 = Texture:Clone()
						v2.Face = "Right"
						v2.Parent = v8
					end
				end;
			end;
			
		end
		
		if clonedroom:FindFirstChild("SeekEye") then
			clonedroom:FindFirstChild("SeekEye").Value = true
		end
		if game.Workspace.CurrentRooms.CurrentRoom.SkeletonDoorValue.Value == false then
			if clonedroom:FindFirstChild("RandomDoor") then
				for i, v in pairs(clonedroom:WaitForChild("RandomDoor"):GetChildren()) do
					local addPainting = math.random(1, 6) 

					if clonedroom:FindFirstChild("BlockedDoor") then
						clonedroom.BlockedDoor:Destroy()
					elseif clonedroom:FindFirstChild("FakeDoor_Hotel") then
						clonedroom.FakeDoor_Hotel:Destroy()
					end
					local cloned = game.ServerScriptService.Server.Assets.Doors.SkeletonDoor:Clone()
					game.Workspace.CurrentRooms.CurrentRoom.SkeletonDoorValue.Value = true
					local re = require(game.ServerScriptService.Game.Directory.KeyObtain)
					re:LoadSkeletonDoor(cloned.Wax_Door.Lock.SkullLock.UnlockPrompt)
					cloned.Parent = clonedroom
					cloned:PivotTo(v.CFrame)
				end
			end
		end
		
		clonedroom.PrimaryPart = clonedroom.RoomStart
		
		if SpecialRoom_p1 == true then
			clonedroom:PivotTo(game.Workspace:FindFirstChild("SkeletonDoor", true).RoomEnd.CFrame)
			clonedroom.RoomsDoor_Entrance.Door.Music:Play()
			clonedroom.RoomsDoor_Entrance.Door.MusicClose:Play()
		else
			if game.Workspace.CurrentRooms:FindFirstChild(nomer):FindFirstChild("RoomEnd") then
				clonedroom:PivotTo(game.Workspace.CurrentRooms:WaitForChild(nomer).RoomEnd.CFrame)
			else
				clonedroom:PivotTo(game.Workspace.CurrentRooms:WaitForChild(nomer).RoomStart.CFrame)
			end
		end

		clonedroom:SetAttribute("ColorAmbient", coloratribute)
		clonedroom:SetAttribute("RoomNumber", workspace.CurrentRooms.CurrentRoom.Value -1)
		clonedroom:SetAttribute("KeyRequire", keyatribute)
		clonedroom:SetAttribute("Dark", DarkRoom)
		clonedroom:SetAttribute("KeySpawned", false)
		clonedroom:SetAttribute(Type, true)
		
		if Seek == true then
			if clonedroom:FindFirstChild("PaintingPoint") then
				for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do					
					local addPainting = math.random(1, 6) 

					if addPainting < 3 then
						local Painting = Paintings:WaitForChild("Painting_SmallSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					elseif addPainting < 4 then
						local Painting = Paintings:WaitForChild("Painting_TallSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					elseif addPainting < 6 then
						local Painting = Paintings:WaitForChild("Painting_VeryBigSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					end
				end
				
				clonedroom:WaitForChild("PaintingPoint"):Destroy()
			else
				return
			end
		else
			if clonedroom:FindFirstChild("PaintingPoint") then
				for i, v in pairs(clonedroom:WaitForChild("PaintingPoint"):GetChildren()) do
					
					if v:GetAttribute("Type") then
						if v:GetAttribute("Type") == "Tall" then
							local Painting = Paintings:WaitForChild("Painting_Tall"):Clone()
							Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
							PaintingsModule:Tall(Painting)
							Painting:PivotTo(v.CFrame)
						end
					else
						local addPainting = math.random(1, 6) 

						if addPainting < 3 then
							local Painting = Paintings:WaitForChild("Painting_Small"):Clone()
							Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
							PaintingsModule:Small(Painting)
							Painting:PivotTo(v.CFrame)
						elseif addPainting < 4 then
							local Painting = Paintings:WaitForChild("Painting_Tall"):Clone()
							Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
							PaintingsModule:Tall(Painting)
							Painting:PivotTo(v.CFrame)
						elseif addPainting < 6 then
							local Painting = Paintings:WaitForChild("Painting_VeryBig"):Clone()
							Painting.Parent = Hidden.Parent.Parent:WaitForChild("Assets")
							PaintingsModule:VeryBig(Painting)
							Painting:PivotTo(v.CFrame)
						end
					end
				end
				
				clonedroom:WaitForChild("PaintingPoint"):Destroy()
			else
				return
			end
		end

		local keyspawned = false
		
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
		if keyobtain then
			GameDetails:GuidePart_KeyObtain(clonedroom, 17.5)
		end
	end

	if SpecialRoom_p1 == true then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "GerbRoom")
		Hidden.CanTouch = false
	else
		Hidden.Touched:Connect(function(roomNum)
			local nomer = game.Workspace:FindFirstChild("CurrentRooms"):WaitForChild("CurrentRoom").Value - 1

			if workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek1Room1") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye4ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("CourtyardRoom") + 1 then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "Infirmary")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("BayourdId") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "Bayourd")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("ElevatorRoomId") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "ElevatorRoom")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek2Room1") then
				game.Workspace.CurrentRooms:SetAttribute("Seek2Mode", true)
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye4ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek2Room2") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye8ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek2Room3") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye12ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek2RoomMain") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "SeekHallway", false, true)
				Hidden.CanTouch = false
			elseif SpecialRoom_p1 == true then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "HaltsCorridor")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek1Room2") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye8ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("Seek1Room3") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "Eye12ballSeek")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("SeekRoomMain") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, true, "SeekHallway", false, true)
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("FigurePreRoom") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "LibraryEntrance", false, false, false, false, true)
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("HaltRoomRandom1") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "HaltsCorridor")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("HaltRoomRandom1") - 1 then
				if game.Workspace.GameSettings.DisableHalt_Entity.Value == true then
					generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
					Hidden.CanTouch = false
					return
				else
					generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, false, false, false, false, true)
					Hidden.CanTouch = false
				end
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("LookManRoom1") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				Hidden.CanTouch = false 
				if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
					return
				else
					spawnEntity("Entities_Lookman", game.Workspace.CurrentRooms:GetAttribute("LookManRoom1"))
				end
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("LookManRoom2") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				Hidden.CanTouch = false 
				if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
					return
				else
					spawnEntity("Entities_Lookman", game.Workspace.CurrentRooms:GetAttribute("LookManRoom2"))
				end
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("LookManRoom3") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				Hidden.CanTouch = false 
				if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
					return
				else
					spawnEntity("Entities_Lookman", game.Workspace.CurrentRooms:GetAttribute("LookManRoom3"))
				end
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("LookManRoom4") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				Hidden.CanTouch = false 
				if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
                    return
				else
					spawnEntity("Entities_Lookman", game.Workspace.CurrentRooms:GetAttribute("LookManRoom4"))
				end
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("JackRoom") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				spawnEntity("Entities_Jack")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("JeffShopID") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "JeffShop")
				Hidden.CanTouch = false
			elseif workspace.CurrentRooms.CurrentRoom.Value == game:GetService("Workspace").CurrentRooms:GetAttribute("CourtyardRoom") then
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value, false, true, "Courtyard")
				Hidden.CanTouch = false
				wait(1.5)
				game.Workspace.Ambience_Courtyard:Play()
			else
				generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
				Hidden.CanTouch = false
			end
		end)
	end
end

function module:OpenLock(Hidden)
	while true do
		wait(0.01)
		if Hidden:GetAttribute("Locked") == true then
			return
		else
			module:Open(Hidden)
			module:Generate(Hidden)
		end
	end
end

return module
