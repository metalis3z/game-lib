local module = {}

--[[local picture_puzzle_rooms = {
	p1 = math.random(4, 9),
	p2 = math.random(45, 47),
	p3 = math.random(86, 89),
}--]]

-- Created and Fixed by BUILDG Studios

local Chests = require(script.Parent["Chests"])
local TypeDoors = require(script.Parent["TypeDoors"])
local Furnitures = require(script.Parent["Furnitures"])
local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local Entities = require(script.Parent["Entities"])
local GameDetails = require(script.Parent["GameDetails"])
local PlayerAttribute = require(script.PlayerAttribute)
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

function module:Open(Hidden)
	
	Hidden.Touched:Connect(function(hit)
		
		Hidden.Parent.BlackHidden.Transparency = 1
		Hidden.Parent.KnobConstraint.TargetAngle = 45
		
		Hidden.Parent.Door.Anchored = false
		Hidden.Parent.Door.CanCollide = false
		
		Hidden.CanTouch = false
		Hidden.Parent.Door.Open:Play()
		
		wait(0.542)
		
		Hidden.Parent.KnobConstraint.TargetAngle = 0
		Hidden:Destroy()
		
	end)
end

function module:DoorGenerate(v)
	local cloneddoor = game:GetService("ServerScriptService").Server.Assets.Door:Clone()
	
	local number = game.Workspace.CurrentRooms.CurrentRoom.Value
	
	cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
	
	cloneddoor.Name = "Door"
	
	cloneddoor.Sign.Stinker.Text = string.format("%04d", number)
	cloneddoor.Sign.Stinker.Highlight.Text = string.format("%04d", number)
	cloneddoor.Sign.Stinker.Shadow.Text = string.format("%04d", number)

	if game.Workspace.GameSettings.Hardcore.Value == true then
		local Door = script.Duped:Clone()
		
		Door.Parent = cloneddoor.Sign
		cloneddoor.Sign.Stinker.Visible = false
	end

	cloneddoor.Parent = v
	cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, RoomSettings.DoorValueFromDoorEnd))
end

function module:DoorKeyGenerate(v)
	local cloneddoor = game:GetService("ServerScriptService").Server.Assets.DoorKey:Clone()

	local number = game.Workspace.CurrentRooms.CurrentRoom.Value

	cloneddoor:FindFirstChild("BlackHidden").Transparency = 0
	
	cloneddoor.Name = "Door"

	cloneddoor.Sign.Stinker.Text = string.format("%04d", number)
	cloneddoor.Sign.Stinker.Highlight.Text = string.format("%04d", number)
	cloneddoor.Sign.Stinker.Shadow.Text = string.format("%04d", number)

	if game.Workspace.GameSettings.Hardcore.Value == true then
		local Door = script.Duped:Clone()

		Door.Parent = cloneddoor.Sign
		cloneddoor.Sign.Stinker.Visible = false
	end

	cloneddoor.Parent = v
	cloneddoor:PivotTo(v:FindFirstChild("RoomEnd").CFrame * CFrame.new(0, 0, RoomSettings.DoorValueFromDoorEnd))
end

function module:Generate(Hidden, Start, SpecialRoom_p1, Autogen)
	
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
		local RoomsData_New = script.Parent.Parent.RoomsData
		
		local saveroom = nil
		local randomroom
		local tables = {}
		
		for i, v in pairs(PossibleHallways:GetChildren()) do
			if v:IsA("Folder") then
				for i, v2 in pairs(v:GetChildren()) do
					if v2:IsA("Model") then
						if v2:GetAttribute("OriginalName") == game.Workspace.CurrentRooms.NextNegativeRoom.Value  then
							
						else
							if v2:GetAttribute("OriginalName") then
								if RoomsData_New:FindFirstChild(v2:GetAttribute("OriginalName")) then
									if RoomsData_New:FindFirstChild(v2:GetAttribute("OriginalName")).Usages.Value == 0 then

									else
										table.insert(tables, v2:GetAttribute("OriginalName"))
									end
								else
									table.insert(tables, v2:GetAttribute("OriginalName"))
								end
							else
								table.insert(tables, v2.Name)
							end
						end
					end
				end
			end
		end
		
		--print(tables)
		
		local randomRoomName = tables[math.random(1, #tables)]
		game.Workspace.CurrentRooms.NextNegativeRoom.Value = randomRoomName
		
		local CanDarkRoom = true
		
		if nomer == game:GetService("Workspace").CurrentRooms:GetAttribute("HaltRoomRandom1") - 1 then
			game.Workspace.GameSettings.Server.RunRush.Value = false
			game.Workspace.GameSettings.Server.NextRush.Value = false
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
				CanDarkRoom = false
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
			local possibleHallways = PossibleHallways:GetChildren()
			if #possibleHallways > 0 then
				if possibleHallways[math.random(1, #possibleHallways)]:IsA("Folder") then
					local randomFolder = possibleHallways[math.random(1, #possibleHallways)]

					if not randomFolder then
						warn("Didnt defacted rooms folder, add back folder rooms")
					end

					local randomizer = randomFolder:GetChildren()
					for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
						if v8:GetAttribute("OriginalName") == randomRoomName then
							randomroom = v8
						end
					end

					--randomroom = randomizer[math.random(1, #randomizer)]

					for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
						if v8:GetAttribute("SaveRoom") == math.random(2, 9) then
							saveroom = v8
						end
					end
				else

					for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
						if v8:GetAttribute("OriginalName") == randomRoomName then
							randomroom = v8
						end
					end

					--randomroom = possibleHallways[math.random(1, #possibleHallways)]

					for v7, v8 in pairs(game.ServerScriptService.Server.Rooms:GetDescendants()) do
						if v8:GetAttribute("SaveRoom") == math.random(2, 9) then
							saveroom = v8
						end
					end
				end
			else

			end
		end
		
		local clonedroom
		if game.Workspace.GameSettings.Server.NextRush.Value == true then
			if saveroom == nil then

				local ChildrenBackup = game.ServerScriptService.Server.BackupRooms:GetChildren()
				local randomBackupRoom = ChildrenBackup[math.random(1, #ChildrenBackup)]
				clonedroom = randomBackupRoom

			else
				clonedroom = saveroom:Clone()
			end
			game.Workspace.GameSettings.Server.NextRush.Value = false
			ModuleEvents.flickerLights(clonedroom, 2)
		else
			if randomroom == nil then

				local ChildrenBackup = game.ServerScriptService.Server.BackupRooms:GetChildren()
				local randomBackupRoom = ChildrenBackup[math.random(1, #ChildrenBackup)]
				clonedroom = randomBackupRoom

			else
				clonedroom = randomroom:Clone()
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
		
		-- Continue generation script
		
		if SpecialRoom == "LibraryEntrance" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_LibraryEntrance:Clone()
			game.Workspace.GameSettings.Server.RunRush.Value = false
			game.Workspace.CurrentRooms.CurrentRoom.FigureLibraryValue.Value = true
		end
		
		if SpecialRoom == "Bayourd" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_Bayourd:Clone()
			game.Workspace.GameSettings.Server.RunRush.Value = false
		end
		
		if SpecialRoom == "ElevatorRoom" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_ElevatorRoom:Clone()
			game.Workspace.GameSettings.Server.RunRush.Value = false
		end
		
		if SpecialRoom == "JeffShop" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_JeffShop:Clone()
		end
		
		if SpecialRoom == "Courtyard" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_Courtyard:Clone()
		end
		
		if SpecialRoom == "Infirmary" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_Infirmary:Clone()
		end

		if SpecialRoom == "HaltsCorridor" then
			CanDarkRoom = false
			clonedroom = game.ServerScriptService.Server.Special.Hotel_HaltsCorridor:Clone()
			game.Workspace.GameSettings.Server.RunRush.Value = false
		end
		--[[local v1v1v1v1v1 = tonumber(RoomNumber)
		if v1v1v1v1v1 == picture_puzzle_rooms.p1 or v1v1v1v1v1 == picture_puzzle_rooms.p2 or v1v1v1v1v1 == picture_puzzle_rooms.p3 then
			clonedroom = game.ServerScriptService.Server.BackupRooms.Hotel_PicturePuzzle1:Clone()
		end--]]
		
--		clonedroom = game.ServerScriptService.Server.DifficultyRooms["2"].Hotel_PicturePuzzle.Hotel_PicturePuzzle1:Clone()
	if clonedroom:GetAttribute("UniversalKey") ~= nil then
		local variants = {"Oval", "Square", "Tall", "Wide"}
		local variants2 = {}
		for i,v in pairs(variants) do
			table.insert(variants2, v)
		end
		if string.find("PicturePuzzle", clonedroom:GetAttribute("UniversalKey")) then
			local Paintings = clonedroom.Assets.Paintings.Slots
			local done = false
			local f = {}
			f.update = game["Run Service"].Heartbeat:Connect(function()
				if done == true then
					f.update:Disconnect()
				end
				local correct = 0
				for i,v in pairs(Paintings:GetChildren()) do
					if v:FindFirstChild("Prop") then
						if v:GetAttribute("HolderID") == v:FindFirstChild("Prop"):GetAttribute("ID") then
							correct += 1
						end
					end
				end
				if correct == 4 then
					done = true
					local moving_door = clonedroom.Assets.Paintings.MovingDoor
					local coll = moving_door.Collision
					coll.SoundToPlay:Play()
					task.wait(0.05)
					coll.SoundToPlay2:Play()
					game.TweenService:Create(moving_door.Wall, TweenInfo.new(5.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {CFrame = moving_door.Wall.CFrame - Vector3.new(0, 8.5, 0)}):Play()
					task.wait(5)
					clonedroom:WaitForChild("Door").Hidden.CanTouch = true
					coll.CanCollide = false
					return
				elseif correct < 4 then
					clonedroom:WaitForChild("Door").Hidden.CanTouch = false
				end
				-- print("Correct paints:", correct)
			end)
			for _, paint_slot in pairs(Paintings:GetChildren()) do 
				-- print("boom!")
				local picture_id = math.random(1, #variants)
				local picture_id2 = math.random(1, #variants2)
				repeat
					task.wait()
					print("ahhh")
					-- local i_think_this_will_help1, i_think_this_will_help2  = tick(), time()
					picture_id2 = math.random(1, #variants2)
					picture_id = math.random(1, #variants)
					print(picture_id, picture_id2)
					math.randomseed(math.random(1, 500000) * math.random(1, 500000) / math.random(-10, 100))
				until variants[picture_id] ~= variants2[picture_id2]
				local picture_data = variants[picture_id]
				local picture_data2 = variants2[picture_id2]
				local folder_Data = game.ServerStorage.PicturePuzzle_Assets:FindFirstChild(picture_data)
				local folder_Data2 = game.ServerStorage.PicturePuzzle_Assets:FindFirstChild(picture_data2)
				local picture_block = folder_Data2.Prop:Clone()
				picture_block.Parent = paint_slot
				picture_block.CFrame = paint_slot.CFrame
				local texture = folder_Data.Image:Clone()
				texture.Parent = paint_slot
				paint_slot:SetAttribute("HolderID", picture_data)
				table.remove(variants, picture_id)
				table.remove(variants2, picture_id2)
				local prox = paint_slot.PropPrompt
				paint_slot:GetAttributeChangedSignal("havePicture"):Connect(function()
					local haveIt = paint_slot:GetAttribute("havePicture")
				end)
				prox.Triggered:Connect(function(pt)
					-- print("trigger, lol")
					if paint_slot:GetAttribute("havePicture") and pt.Character and pt.Character:FindFirstChild("Humanoid") and not pt.Character:FindFirstChild("Prop") then
						local prop1 = paint_slot:FindFirstChild("Prop")
						-- print("gived picture")
						prop1.Parent = pt.Character
						prop1.Anchored = false
						local super_weld = Instance.new("ManualWeld", prop1)
						super_weld.Part0 = prop1
						super_weld.Part1 = pt.Character.RightHand
						super_weld.C1 = CFrame.new(-1, 0, 0) * CFrame.fromOrientation(math.rad(90), math.rad(180), 0)
						super_weld.Name = "SuperWeld"
						local anim_load = pt.Character:FindFirstChild("Humanoid").Animator:LoadAnimation(prop1.Anim_Idle)
						anim_load.Looped = true
						anim_load:Play()
						paint_slot:SetAttribute("havePicture", false)
					elseif not paint_slot:GetAttribute("havePicture") and pt.Character and pt.Character:FindFirstChild("Humanoid") and pt.Character:FindFirstChild("Prop") then
						local dop_prop = pt.Character:FindFirstChild("Prop")
						-- print("picture back!")
						dop_prop.Anchored = true
						dop_prop:WaitForChild("SuperWeld"):Destroy()
						dop_prop.Parent = paint_slot
						dop_prop.CFrame = paint_slot.CFrame
						paint_slot:SetAttribute("havePicture", true)
						for _, track in pairs(pt.Character:FindFirstChild("Humanoid").Animator:GetPlayingAnimationTracks()) do
							if track:IsA("AnimationTrack") and track.Name == "Anim_Idle" then
								track:Stop()
							end
						end
					elseif paint_slot:GetAttribute("havePicture") and pt.Character and pt.Character:FindFirstChild("Humanoid") and pt.Character:FindFirstChild("Prop") and pt.Character:FindFirstChild("Prop") ~= paint_slot.Prop then
						-- print("picture changed!")
						local prop1 = paint_slot:FindFirstChild("Prop")
						prop1.Parent = pt.Character
						prop1.Anchored = false
						local super_weld = Instance.new("ManualWeld", prop1)
						super_weld.Part0 = prop1
						super_weld.Part1 = pt.Character.RightHand
						super_weld.C1 = CFrame.new(-1, 0, 0) * CFrame.fromOrientation(math.rad(90), math.rad(180), 0)
						super_weld.Name = "SuperWeld"
						local anim_load = pt.Character:FindFirstChild("Humanoid").Animator:LoadAnimation(prop1.Anim_Idle)
						anim_load.Looped = true
						anim_load:Play()
						local dop_prop = pt.Character:FindFirstChild("Prop")
						dop_prop.Anchored = true
						dop_prop:WaitForChild("SuperWeld"):Destroy()
						dop_prop.Parent = paint_slot
						dop_prop.CFrame = paint_slot.CFrame
						dop_prop:SetAttribute("havePicture", true)
					end
				end)
				paint_slot:SetAttribute("havePicture", true)
			end
		end
		
	end
	
		clonedroom.Name = RoomNumber
		for v9, v10 in pairs(clonedroom:GetDescendants()) do
			if v10:IsA("Model") and string.find(v10.Name, "BookshelfObstruction") then
				Obstructions:Bookshelf(v10)
			end
		end
		
		if clonedroom:GetAttribute("OriginalName") then
			if RoomsData_New:FindFirstChild(clonedroom:GetAttribute("OriginalName")) then
				if RoomsData_New:FindFirstChild(clonedroom:GetAttribute("OriginalName")).Usages.Value > 0 then
					RoomsData_New:FindFirstChild(clonedroom:GetAttribute("OriginalName")).Usages.Value -= 1
				end
			end
		end
		
		clonedroom.Parent = GeneratedRooms
		workspace.CurrentRooms.CurrentRoom.Value += 1
		
		if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2) then
			if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2):FindFirstChild("ClosetDupe") then
				game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2):FindFirstChild("ClosetDupe"):SetAttribute("TimeToClear", true)
			end
		end
		
		if SpecialRoom == "JeffShop" then
			local Stuff = clonedroom:FindFirstChild("ShopStuff")
			
			local ItemsList = {"Crucifix", "Lighter", "Vitamins", "Flashlight"}
			
			ItemsControls:BuyableItem(Stuff.PurchasableItem1.Crucifix)
			ItemsControls:BuyableItem(Stuff.PurchasableItem2.Lighter)
			ItemsControls:BuyableItem(Stuff.PurchasableItem3.Vitamins)
			ItemsControls:BuyableItem(Stuff.PurchasableItem4.Flashlight)
			
			--[[for i = 1, 4 do
				ItemsControls:BuyableItem(Stuff:FindFirstChild("PurchasableItem"..i):FindFirstChild(ItemsList))
			end--]]
			
			game.Workspace.CurrentRooms.CurrentRoom.HaltCorridorValue.Value = false
			game.Workspace.CurrentRooms.CurrentRoom.FigureLibraryValue.Value = false
			
			clonedroom.ShopStuff.RadioShop.Hitbox.MusicFar:Play()
			clonedroom.ShopStuff.RadioShop.Hitbox.MusicClose:Play()
			
			if game.Workspace.GameSettings.Hardcore.Value == true then
				Stuff.PurchasableItem1:Destroy()
				Stuff.PurchasableItem2:Destroy()
				Stuff.PurchasableItem3:Destroy()
				Stuff.PurchasableItem4:Destroy()
			end
		elseif SpecialRoom == "Infirmary" then
			for i, v in pairs(game.Players:GetPlayers()) do 
				if v.Character then 
					if game.Workspace.GameSettings.Hardcore.Value == true then
						
					else
						game.ReplicatedStorage.ClientBricks.RiftInfirmary:FireClient(v)
					end
				end
			end
		elseif SpecialRoom == "LibraryEntrance" then
			if clonedroom.Assets:FindFirstChild("Library_Desk") then
				Drawers.Scan(clonedroom.Assets.Library_Desk)
			end
		end
		
		local Type = "Hotel_"
		local DarkRoom = false
		if workspace:WaitForChild("AdminPanelSettings"):GetAttribute("NextRoom") ~= "Nil" then
			randomroom =  script.Parent.Parent.Parent.Server:FindFirstAncestor(workspace.AdminPanelSettings:GetAttribute("NextRoom"))
		end
		local Rugclear_1 = math.random(1, 13)
		local Rugclear_2 = math.random(1, 13)
		
		if Rugclear_1 == Rugclear_2 then
			if clonedroom.Assets:FindFirstChild("Rug") then
				clonedroom.Assets:FindFirstChild("Rug"):Destroy()
			end
		end
		
		if game.Workspace.Game.Modifiers:FindFirstChild("FakeFlickers") then
			if game.Workspace.Game.Modifiers:FindFirstChild("FakeFlickers").Value == true then
				local v3 = math.random(1, 195)
				
				if v3 > 15 and v3 < 20 then
					ModuleEvents.flickerLights(clonedroom, 1.2)
				elseif v3 > 185 and v3 < 188 then
					ModuleEvents.flickerLights(clonedroom, 1.2)
					game.Workspace.Ambience_Ambush:Play()
				elseif v3 > 190 and v3 < 195 then
					game.Workspace.Ambience_Dark:Play()
				end
			end
		end
		
		if game.Workspace.Game.Modifiers:FindFirstChild("NoMoreHiding") then
			if game.Workspace.Game.Modifiers:FindFirstChild("NoMoreHiding").Value == true then
				for i, v in pairs(clonedroom:GetDescendants()) do
					if v:IsA("Model") and v.Name == "Wardrobe" then
						v:Destroy()
					end
				end
			end
		end

		if CanDarkRoom == true then
			
			if game.Workspace.GameSettings.Hardcore.Value == true then
				if math.random(1, 2) == math.random(1, 2) then
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
				end
			else
				if game.Workspace.Game.Modifiers:FindFirstChild("LighterReally") then
					if game.Workspace.Game.Modifiers:FindFirstChild("LighterReally").Value == true then
						if math.random(1, 5) == math.random(1, 5) then
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
					else
						if game.Workspace.Game.Modifiers:FindFirstChild("WhereMyLighter") then
							if game.Workspace.Game.Modifiers:FindFirstChild("WhereMyLighter").Value == true then
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
							end
						end
					end
				end
				
				if game.Workspace.Game.Modifiers:FindFirstChild("ElectricalWork") then
					if game.Workspace.Game.Modifiers:FindFirstChild("ElectricalWork").Value == true then

					else
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
					end
				end
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
		
		if SpecialRoom then
			if SpecialRoom == "Infirmary" or SpecialRoom == "Courtyard" then
				randomwallcolor = 0
				randomcarpetcolor = 0
			end
		end
		
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
		
		if game.Workspace.GameSettings.Hardcore.Value == true then
			
			if math.random(1, 3) == math.random(1, 3) then
				spawnEntity("Entities_Lookman", clonedroom.Name)
			end
			
		else
			if math.random(1, game.Workspace.Game.GameData.EyesChance.Value) == math.random(2, game.Workspace.Game.GameData.EyesChance.Value) then

				if game.Workspace.GameSettings.DisableEyes_Entity.Value == true then
					return
				else
					spawnEntity("Entities_Lookman", clonedroom.Name)
				end

			end
		end
		
		if clonedroom:FindFirstChild("RandomDoors") then
			local AssetsServer = game.ServerScriptService.Server.Assets.Doors.BlockedDoors
			
			for i, v in pairs(clonedroom:WaitForChild("RandomDoors"):GetChildren()) do
				local random = math.random(1, 3)
				local randomCloset = math.random(1, 3)
				local randomSign = math.random(1, 3)
				
				if game.Workspace.GameSettings.Hardcore.Value == true then
					if dupeSpawned == false then
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
								
								if game.Workspace.GameSettings.Hardcore.Value == true then
									clonedcloset.DoorFake.Sign.Duped.Visible = true
									clonedcloset.DoorFake.Sign.Stinker.Visible = false
								end
								
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
				else
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
			end
			task.delay(1, function()
				clonedroom:WaitForChild("RandomDoors"):Destroy()
			end)
		end
		
		-- rush encounter

		local moduleAmbush = require(game.ServerScriptService.Entities.Hotel.Ambush)
		local moduleRush = require(game.ServerScriptService.Entities.Hotel.Rush)
		local moduleTroll = require(game.ServerScriptService.Entities.Custom.Trololo)
		
		if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleAmbush.AmbushSpawn1 then
			game.Workspace.GameSettings.Fires.AmbushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveAmbushTrueOk")
		end
		
		if game.Workspace.Game.Modifiers:FindFirstChild("Pranked") then
			if game.Workspace.Game.Modifiers:FindFirstChild("Pranked").Value == true then
				if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn1 then
					game.Workspace.GameSettings.Fires.TrollMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveTrollingTrueOk")
				elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn2 then
					game.Workspace.GameSettings.Fires.TrollMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveTrollingTrueOk")
				elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn3 then
					game.Workspace.GameSettings.Fires.TrollMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveTrollingTrueOk")
				end
			end
		end
		
		if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn1 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn2 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn3 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn4 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn5 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn6 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn7 then
			game.Workspace.GameSettings.Fires.RushMove:Fire(game.Workspace.CurrentRooms.CurrentRoom.Value, "ActiveRushTrueOk")
		end
		
		if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleAmbush.AmbushSpawn1 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		end
		
		if game.Workspace.Game.Modifiers:FindFirstChild("Pranked") then
			if game.Workspace.Game.Modifiers:FindFirstChild("Pranked").Value == true then
				if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn1 - 1 then
					game.Workspace.GameSettings.Server.NextRush.Value = true
				elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn2 - 1 then
					game.Workspace.GameSettings.Server.NextRush.Value = true
				elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleTroll.Spawn3 - 1 then
					game.Workspace.GameSettings.Server.NextRush.Value = true
				end
			end
		end
		
		if game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn1 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn2 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn3 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn4 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn5 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn6 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
		elseif game.Workspace.CurrentRooms.CurrentRoom.Value == moduleRush.RushSpawn7 - 1 then
			game.Workspace.GameSettings.Server.NextRush.Value = true
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
			ModuleEvents.flickerLights(clonedroom, 0.4)
		end
		
		if Invalid == Correct2 then
			ModuleEvents.breakLights_Time(clonedroom, 8)
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
		
		if randomwallcolor == 0 then
			
		else
			for v7, v8 in pairs(clonedroom:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Wall" then
						v8.Color = coloratribute

						v8.Material = Enum.Material.Wood
						v8.MaterialVariant = "Plaster"
					end;
				end;
			end;
		end
		
		if randomcarpetcolor == 0 then
			
		else
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
		end
		
		if clonedroom:FindFirstChild("SeekEye") then
			clonedroom:FindFirstChild("SeekEye").Value = true
		end
		
		clonedroom.PrimaryPart = clonedroom.RoomStart
		
		if game.Workspace.CurrentRooms:FindFirstChild(nomer):FindFirstChild("RoomEnd") then
			clonedroom:PivotTo(game.Workspace.CurrentRooms:WaitForChild(nomer).RoomEnd.CFrame)
		else
			clonedroom:PivotTo(game.Workspace.CurrentRooms:WaitForChild(nomer).RoomStart.CFrame)
		end

		clonedroom:SetAttribute("ColorAmbient", coloratribute)
		clonedroom:SetAttribute("RoomNumber", workspace.CurrentRooms.CurrentRoom.Value -1)
		clonedroom:SetAttribute("KeyRequire", keyatribute)
		clonedroom:SetAttribute("Dark", DarkRoom)
		clonedroom:SetAttribute("KeySpawned", false)
		clonedroom:SetAttribute(Type, true)
		
		if Seek == true then
			if clonedroom:FindFirstChild("PaintingPoint") then
				for i, v in pairs(clonedroom:FindFirstChild("PaintingPoint"):GetChildren()) do					
					local addPainting = math.random(1, 6) 

					if addPainting < 3 then
						local Painting = Paintings:FindFirstChild("Painting_SmallSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					elseif addPainting < 4 then
						local Painting = Paintings:FindFirstChild("Painting_TallSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					elseif addPainting < 6 then
						local Painting = Paintings:FindFirstChild("Painting_VeryBigSeek"):Clone()
						Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
						Painting.Canvas.SurfaceGui.Script.Enabled = true
						Painting:PivotTo(v.CFrame)
					end
				end

				clonedroom:FindFirstChild("PaintingPoint"):Destroy()
			else
				return
			end
		else
			if clonedroom:FindFirstChild("PaintingPoint") then
				for i, v in pairs(clonedroom:FindFirstChild("PaintingPoint"):GetChildren()) do

					if v:GetAttribute("Type") then
						if v:GetAttribute("Type") == "Tall" then
							local Painting = Paintings:FindFirstChild("Painting_Tall"):Clone()
							Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
							PaintingsModule:Tall(Painting)
							Painting:PivotTo(v.CFrame)
						end
					else
						local addPainting = math.random(1, 6) 

						if addPainting < 3 then
							local Painting = Paintings:FindFirstChild("Painting_Small"):Clone()
							Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
							PaintingsModule:Small(Painting)
							Painting:PivotTo(v.CFrame)
						elseif addPainting < 4 then
							local Painting = Paintings:FindFirstChild("Painting_Tall"):Clone()
							Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
							PaintingsModule:Tall(Painting)
							Painting:PivotTo(v.CFrame)
						elseif addPainting < 6 then
							local Painting = Paintings:FindFirstChild("Painting_VeryBig"):Clone()
							Painting.Parent = Hidden.Parent.Parent:FindFirstChild("Assets")
							PaintingsModule:VeryBig(Painting)
							Painting:PivotTo(v.CFrame)
						end
					end
				end

				clonedroom:FindFirstChild("PaintingPoint"):Destroy()
			else
				return
			end
		end

		local keyspawned = false

		-- Furnitures Instances

		--[[if tonumber(RoomNumber) == 3 then
			print("go!!!")
			clonedroom = game.ServerScriptService.Server.DifficultyRooms["2"]["Hotel_PicturePuzzle"].Hotel_PicturePuzzle:Clone()
		end]]
		if clonedroom:FindFirstChild("FurniturePoint") then
			for i, v in pairs(clonedroom:FindFirstChild("FurniturePoint"):GetChildren()) do
				local addFurniture = math.random(1, 240)

				if v:GetAttribute("Type") == "Dresser" then
					local Dresser = Furnituress:FindFirstChild("Hotel_Dresser"):Clone()
					Dresser.Name = "Dresser"
					Dresser.Parent = clonedroom:FindFirstChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

				elseif v:GetAttribute("Type") == "Table" then
					local Dresser = Furnituress:FindFirstChild("Hotel_Table"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:FindFirstChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)

				elseif v:GetAttribute("Type") == "TableObtain" then
					local Dresser = Furnituress:FindFirstChild("Hotel_RedTable"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedroom:FindFirstChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.SetDebris(Dresser)

				elseif v:GetAttribute("Type") == "Random" then
					if addFurniture > 0 and addFurniture < 25 then
						local Dresser = Furnituress:FindFirstChild("Hotel_Drawer_Table"):Clone()
						Dresser.Name = "Table"
						Dresser.Parent = clonedroom:FindFirstChild("Assets")
						Dresser:PivotTo(v.CFrame)

						Drawers.Scan(Dresser)

						Drawers.SetDebris(Dresser)

					elseif addFurniture > 35 and addFurniture < 45 then
						local Dresser = Furnituress:FindFirstChild("Hotel_Table"):Clone()
						Dresser.Name = "Table"
						Dresser.Parent = clonedroom:FindFirstChild("Assets")
						Dresser:PivotTo(v.CFrame)

						Drawers.SetDebris(Dresser)

					elseif addFurniture > 45 and addFurniture < 85 then
						local Dresser = Furnituress:FindFirstChild("Hotel_TDrawer"):Clone()
						Dresser.Name = "Table"
						Dresser.Parent = clonedroom:FindFirstChild("Assets")
						Dresser:PivotTo(v.CFrame)

						Drawers.Scan(Dresser)

						Drawers.SetDebris(Dresser)

					elseif addFurniture > 85 and addFurniture < 125 then
						local Dresser = Furnituress:FindFirstChild("Hotel_RedTableFront"):Clone()
						Dresser.Name = "Table"
						Dresser.Parent = clonedroom:FindFirstChild("Assets")
						Dresser:PivotTo(v.CFrame)

						Drawers.SetDebris(Dresser)

					elseif addFurniture > 125 and addFurniture < 165 then
						local Dresser = Furnituress:FindFirstChild("Hotel_RedTableOpened"):Clone()
						Dresser.Name = "Table"
						Dresser.Parent = clonedroom:FindFirstChild("Assets")
						Dresser:PivotTo(v.CFrame)

						Drawers.SetDebris(Dresser)

					end
				end
			end

			clonedroom:FindFirstChild("FurniturePoint"):Destroy()
		end
		
		--require(game.ServerScriptService.Game.Directory.EntryRoomNodes).Path(clonedroom)
		
		if keyobtain then
			if game.Workspace.GameSettings.Hardcore.Value == true then
				
			else
				GameDetails:GuidePart_KeyObtain(clonedroom, 27.5)
			end
		end
	end
	
	if Autogen == true then
		generateRoom(game.Workspace.CurrentRooms.CurrentRoom.Value)
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

function module:DeleteRooms()
	local lastRoom = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 4)
	local lastRoom_2 = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 5)

	if lastRoom then
		for i, v in pairs(lastRoom:GetChildren()) do
			if v.Name == "RoomStart" or v.Name == "RoomEnd" or v.Name == "PartDebris" then

			else
				if v.Name == "Door" and v:IsA("Model") then
					v.Collision.CollisionGroup = "TouchPlayer"
					v.HingeConstraint.TargetAngle = 0
				else
					if lastRoom_2 then
						lastRoom_2:Destroy()
					end
					v:Destroy()
				end
			end
		end
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
