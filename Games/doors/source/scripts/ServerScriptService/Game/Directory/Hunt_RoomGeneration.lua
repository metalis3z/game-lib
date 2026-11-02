local module = {}

repeat wait(0.1) until game.Workspace.CurrentRooms:FindFirstChild("0")

if game.Workspace.CurrentRooms:FindFirstChild("0"):GetAttribute("OriginalName") == "Hunt_FirstRoom" then

else
	return
end

local ReplicatedStorage = game:GetService("ServerScriptService")
local Drawers = require(game.ServerScriptService.Game.Directory.Hunt_Drawers)
local Furnituress = ReplicatedStorage:WaitForChild("Server"):WaitForChild("Assets"):WaitForChild("Furnitures")

function module:IntValueTime(Text)
	local function Format(Int)
		return string.format("%02i", Int)
	end

	local function convertToHMS(Seconds)
		local Minutes = (Seconds - Seconds%60)/60
		Seconds = Seconds - Minutes*60
		return Format(Minutes)..":"..Format(Seconds)
	end
	
	return convertToHMS(Text)
end

function module:DeleteRooms()
	local lastRoom = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 4)
	local lastRoom_2 = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 5)
	
	if lastRoom then
		for i, v in pairs(lastRoom:GetChildren()) do
			if v.Name == "RoomEntrance" or v.Name == "RoomExit" or v.Name == "PartDebris" then
				
			else
				if v.Name == "Door" then
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
function module:HuntDoorGenerate(v)
	local Door = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Assets"):FindFirstChild("Hunt_Door")
	local ClonedDoor = Door:Clone()
	
	ClonedDoor.Name = "Door"
	ClonedDoor.Parent = v
	ClonedDoor:PivotTo(v:FindFirstChild("RoomExit").CFrame)
	
	ClonedDoor.Door.Sign.Stinker.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1
	ClonedDoor.Door.Sign.Stinker.Highlight.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1
	ClonedDoor.Door.Sign.Stinker.Shadow.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1
	
	module:HuntOpen(ClonedDoor)
end

function module:HuntDoorKeyGenerate(v)
	local Door = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Assets"):FindFirstChild("Hunt_DoorKey")
	local ClonedDoor = Door:Clone()
	
	ClonedDoor.Name = "Door"
	ClonedDoor.Parent = v
	ClonedDoor:PivotTo(v:FindFirstChild("RoomExit").CFrame)
	ClonedDoor.Hidden:SetAttribute("Locked", true)
	
	ClonedDoor.Door.Sign.Stinker.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1
	ClonedDoor.Door.Sign.Stinker.Highlight.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1
	ClonedDoor.Door.Sign.Stinker.Shadow.Text = game.Workspace.CurrentRooms.NegativeNumber.Value + 1

	module:OpenLock(ClonedDoor.Hidden)
end

function module:HuntDoorKeyGenerateFirstRoom(v)
	local Door = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Assets"):FindFirstChild("Hunt_DoorKey_FirstRoom")
	local ClonedDoor = Door:Clone()

	ClonedDoor.Name = "Door"
	ClonedDoor.Parent = v
	ClonedDoor:PivotTo(v:FindFirstChild("RoomExit").CFrame)
	ClonedDoor.Hidden:SetAttribute("Locked", true)

	ClonedDoor.Door.Sign.Stinker.Text = game.Workspace.CurrentRooms.NegativeNumber.Value
	ClonedDoor.Door.Sign.Stinker.Highlight.Text = game.Workspace.CurrentRooms.NegativeNumber.Value
	ClonedDoor.Door.Sign.Stinker.Shadow.Text = game.Workspace.CurrentRooms.NegativeNumber.Value

	module:OpenLock(ClonedDoor.Hidden)
end

function module:HuntOpen(Door)
	local DoorInside = Door:FindFirstChild("Door")
	local Hidden = Door:FindFirstChild("Hidden")
	local HingeConstraint = Door:FindFirstChild("HingeConstraint")
	local KnobConstraint = Door:FindFirstChild("KnobConstraint")

	Hidden.Touched:Connect(function(hit)
		local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
		
		if Player then
			
			if Door:FindFirstChild("DisplayTimer") then
				if Door:FindFirstChild("DisplayTimer").Text then
					Door.DisplayTimer.Enabled = true
					Door.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
				end
			end
			
			game.Workspace.Game:GetAttributeChangedSignal("GameTimer"):Connect(function()
				if Door:FindFirstChild("DisplayTimer") then
					if Door:FindFirstChild("DisplayTimer").Text then
						Door.DisplayPlate.TimerBeep:Play()
						Door.DisplayTimer.Enabled = true
						Door.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
					end
				end
			end)
			
			DoorInside.Anchored = false
			Hidden.CanTouch = false
			Hidden.Transparency = 1

			DoorInside.Open:Play()
			DoorInside.Bell:Play()
			
			game.Workspace.CurrentRooms.NegativeNumber.Value += 1
			game.Workspace.CurrentRooms.CurrentRoom.Value += 1

			KnobConstraint.TargetAngle = 45
			DoorInside.CanCollide = false
			DoorInside.Open:Play()
			wait(0.5)
			KnobConstraint.TargetAngle = 0
		end
	end)
end

function module:HuntNormalOpen(Door)
	local DoorInside = Door:FindFirstChild("Door")
	local Hidden = Door:FindFirstChild("Hidden")
	local HingeConstraint = Door:FindFirstChild("HingeConstraint")
	local KnobConstraint = Door:FindFirstChild("KnobConstraint")

	Hidden.Touched:Connect(function(hit)
		local Player = game.Players:GetPlayerFromCharacter(hit.Parent)

		if Player then

			DoorInside.Anchored = false
			Hidden.CanTouch = false
			Hidden.Transparency = 1

			DoorInside.Open:Play()

			KnobConstraint.TargetAngle = 45
			DoorInside.CanCollide = false
			DoorInside.Open:Play()
			wait(0.5)
			KnobConstraint.TargetAngle = 0
		end
	end)
end

function module:HuntOpenAuto(Door)
	local function Format(Int)
		return string.format("%02i", Int)
	end

	local function convertToHMS(Seconds)
		local Minutes = (Seconds - Seconds%60)/60
		Seconds = Seconds - Minutes*60
		return Format(Minutes)..":"..Format(Seconds)
	end
	
	if Door.DisplayTimer then
		if Door.DisplayTimer.Text then
			Door.DisplayTimer.Enabled = true
			Door.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
		end
	end
	
	local DoorInside = Door:FindFirstChild("Door")
	local Hidden = Door:FindFirstChild("Hidden")
	local HingeConstraint = Door:FindFirstChild("HingeConstraint")
	local KnobConstraint = Door:FindFirstChild("KnobConstraint")

	game.Workspace.Game:GetAttributeChangedSignal("GameTimer"):Connect(function()
		if Door:FindFirstChild("DisplayTimer") then
			if Door:FindFirstChild("DisplayTimer").Text then
				Door.DisplayPlate.TimerBeep:Play()
				Door.DisplayTimer.Enabled = true
				Door.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
			end
		end
	end)

	DoorInside.Anchored = false
	Hidden.CanTouch = false
	Hidden.Transparency = 1
	
	Door.DisplayTimer.Enabled = true
	
	game.Workspace.CurrentRooms.NegativeNumber.Value += 1
	game.Workspace.CurrentRooms.CurrentRoom.Value += 1

	DoorInside.Open:Play()
	DoorInside.Bell:Play()

	KnobConstraint.TargetAngle = 45
	DoorInside.CanCollide = false
	DoorInside.Open:Play()
	wait(0.5)
	KnobConstraint.TargetAngle = 0
end

function module:SetRoomGenerate(Start)
	module:DeleteRooms()
	local Rooms = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Hunt_Rooms"):GetChildren()
	local randomRoom
	
	local blitzRun = false
	
	if game.Workspace.CurrentRooms.CurrentRoom.Value == 1 then
		local randomizer = game:GetService("ServerScriptService"):WaitForChild("Server"):FindFirstChild("Hunt_Rooms").Hunt_NextRoom:GetChildren()
		
		randomRoom = randomizer[math.random(1, #randomizer)]
	elseif game.Workspace.CurrentRooms.CurrentRoom.Value == tonumber(game.Workspace.Game:GetAttribute("LastRoom")) then
		randomRoom = game.ServerScriptService.Server.Special.Hunt_ExitBackdoor
		game.Workspace.Game:SetAttribute("CanLeverSpawn", true)
	else
		local randomizer = Rooms[math.random(1, #Rooms)]:GetChildren()
		
		randomRoom = randomizer[math.random(1, #randomizer)]
	end
	
	local clonedRoom = randomRoom:Clone()
	
	clonedRoom.Parent = game:GetService("Workspace").CurrentRooms
	clonedRoom.Name = game:GetService("Workspace").CurrentRooms.CurrentRoom.Value
	
	local part = Instance.new("Part")

	part.Material = Enum.Material.Plastic

	local orientation, size = clonedRoom:GetBoundingBox()
	part.Size = size
	part.CFrame = orientation

	part.Parent = clonedRoom

	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.Name = clonedRoom.Name
	
	clonedRoom:PivotTo(game:GetService("Workspace").CurrentRooms:FindFirstChild(game:GetService("Workspace").CurrentRooms.CurrentRoom.Value - 1).RoomExit.CFrame)
	wait()
	
	local lastRoom = game.Workspace.CurrentRooms:FindFirstChild(game:GetService("Workspace").CurrentRooms.CurrentRoom.Value - 1)
	
	if game.Workspace.CurrentRooms.CurrentRoom.Value > 3 then
		if math.random(1, game.Workspace.Game.GameData.BlitzChance.Value) == math.random(1, game.Workspace.Game.GameData.BlitzChance.Value) then
			for v7, v8 in pairs(lastRoom:GetDescendants()) do
				if v8:IsA("Model") and string.find(v8.Name, "Wardrobe") then
					if game.Workspace.CurrentRooms.CurrentRoom.Value == tonumber(game.Workspace.Game:GetAttribute("LastRoom")) then
						blitzRun = false
					else
						if blitzRun == false then
							blitzRun = true
						end
					end
				end
			end
		end
	end
	
	wait()
	
	if math.random(1, game.Workspace.Game.GameData.LookmanChance.Value) == math.random(1, game.Workspace.Game.GameData.LookmanChance.Value) then
		local Lookman = game.ServerScriptService.Entities.Hunt.Lookman.BackdoorLookman:Clone()
		
		Lookman.Parent = game.Workspace
		Lookman:PivotTo(clonedRoom.RoomExit.CFrame * CFrame.new(0, 1.5, math.random(10, 20)))
		
		local v2 = 0
		
		game.Workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
			if v2 > 0 then
				Lookman:Destroy()
				v2 = 0
			else
				v2 = v2 + 1
			end
		end)
	end
	
	if blitzRun == true then
		game.Workspace.GameSettings.Fires.BlitzMove:Fire()
	end
	
	if clonedRoom:FindFirstChild("Settings") then
		if clonedRoom:FindFirstChild("Settings"):WaitForChild("Key").Value == true then
			module:HuntDoorKeyGenerate(clonedRoom)
		end
	else
		module:HuntDoorGenerate(clonedRoom)
	end
	
	if clonedRoom:FindFirstChild("FurniturePoints") then
		for i, v in pairs(clonedRoom:WaitForChild("FurniturePoints"):GetChildren()) do
			local addFurniture = math.random(1, 125)
			
			if string.find(v.Name, "Smalltabl") then
				local Dresser = Furnituress:WaitForChild("Backdoor_TableSmall"):Clone()
				Dresser.Name = "Table"
				Dresser.Parent = clonedRoom:WaitForChild("Assets")
				Dresser:PivotTo(v.CFrame)

				Drawers.Scan(Dresser)
			end
			
			if string.find(v.Name, "JustRandomPart") then
				if addFurniture > 0 and addFurniture < 25 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TableCommon"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

				elseif addFurniture > 35 and addFurniture < 45 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TablePress"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)

				elseif addFurniture > 45 and addFurniture < 85 then
					local Dresser = Furnituress:WaitForChild("Backdoor_TableWithout"):Clone()
					Dresser.Name = "Table"
					Dresser.Parent = clonedRoom:WaitForChild("Assets")
					Dresser:PivotTo(v.CFrame)

					Drawers.Scan(Dresser)
				end
			end
		end
		
		if clonedRoom:FindFirstChild("FurniturePoints") then
			clonedRoom:FindFirstChild("FurniturePoints"):Destroy()
		end
	end
	
	if Start == true then
		if clonedRoom:FindFirstChild("LeverPoints") then
			for i, v in pairs(clonedRoom:WaitForChild("LeverPoints"):GetChildren()) do
				local Lever = game.ServerScriptService.Server.Assets.Hunt_TimerLever:Clone()
				
				Lever:PivotTo(v.CFrame)
				Lever.Parent = clonedRoom
				Lever.Name = "TimerLever"
				
				Lever.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
			end
		end
	end
	
	if game.Workspace.Game:GetAttribute("CanLeverSpawn") == true then
		
		if clonedRoom:FindFirstChild("LeverPoints") then
			for i, v in pairs(clonedRoom:WaitForChild("LeverPoints"):GetChildren()) do
				local Lever = game.ServerScriptService.Server.Assets.Hunt_TimerLever:Clone()
				game.Workspace.Game:SetAttribute("CanLeverSpawn", true)

				Lever:PivotTo(v.CFrame)
				Lever.Parent = clonedRoom
				Lever.Name = "TimerLever"

				Lever.DisplayTimer.Text.Text = module:IntValueTime(game.Workspace.Game:GetAttribute("GameTimer"))
			end
		end
	end
	
	if clonedRoom:FindFirstChild("RoomDoor") then
		for i, v in pairs(clonedRoom:GetDescendants()) do
			if v.Name == "RoomDoor" then
				local NormalDoor = game.ServerScriptService.Server.Assets.Hunt_NormalDoor:Clone()
				
				NormalDoor.Name = "DoorNormal"
				NormalDoor:PivotTo(v.CFrame)
				NormalDoor.Parent = clonedRoom
				
				module:HuntNormalOpen(NormalDoor)
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
			module:HuntOpenAuto(Hidden)
		end
	end
end

return module
