local spawnroom = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

local RushSpawnRandom1 = math.random(7, 11)
local RushSpawnRandom2 = math.random(21, 24)
local RushSpawnRandom3 = math.random(40, 60)
local RushSpawnRandom4 = math.random(65, 80)

local AmbushSpawnRandom1 = math.random(5, 24)

local Rooms = game.Workspace.CurrentRooms

Rooms:SetAttribute("RushSpawnRandom", RushSpawnRandom1)
Rooms:SetAttribute("RushSpawnRandom2", RushSpawnRandom2)
Rooms:SetAttribute("RushSpawnRandom3", RushSpawnRandom3)
Rooms:SetAttribute("RushSpawnRandom4", RushSpawnRandom4)

Rooms:SetAttribute("AmbushSpawnRandom", AmbushSpawnRandom1)

-- PATHWAY NODES

-- RUSH

local function rushing(n)
	
	if game.Workspace.GameSettings.DisableRush_Entity.Value == true or game.Workspace.GameSettings.Server.RunRush.Value == false then
		return print("Rush have been cancelled because Admin disable rush spawning.")
	end
	
	local function Rushdot(place, name, d)
		local part = Instance.new("Part")
		part.Size = Vector3.new(1, 1, 1)

		part.Name = name
		part.Transparency = 1
		part.CanCollide = false
		part.Anchored = true
		part.Parent = game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

		if d == true then
			part:PivotTo(place.CFrame * CFrame.new(0, -15, -40))
		else
			part:PivotTo(place.CFrame)
		end
	end
	
	local numberRush1
	local numberRush2
	local numberRush3
	local numberRush4
	
	if n == 1 then
		numberRush1 = RushSpawnRandom1 - 1
		numberRush2 = RushSpawnRandom1 - 2
		numberRush3 = RushSpawnRandom1 - 3
		numberRush4 = RushSpawnRandom1 - 4
	elseif n == 2 then
		numberRush1 = RushSpawnRandom2 - 1
		numberRush2 = RushSpawnRandom2 - 2
		numberRush3 = RushSpawnRandom2 - 3
		numberRush4 = RushSpawnRandom2 - 4
	elseif n == 3 then
		numberRush1 = RushSpawnRandom3 - 1
		numberRush2 = RushSpawnRandom3 - 2
		numberRush3 = RushSpawnRandom3 - 3
		numberRush4 = RushSpawnRandom3 - 4
	elseif n == 4 then
		numberRush1 = RushSpawnRandom4 - 1
		numberRush2 = RushSpawnRandom4 - 2
		numberRush3 = RushSpawnRandom4 - 3
		numberRush4 = RushSpawnRandom4 - 4
	end
	local folder = Instance.new("Folder")
	folder.Parent = game.Workspace.CurrentRooms
	
	local RushRig = game.ServerScriptService.Server.Assets.Entities.RushNew:Clone()
	
	local RushCloned = RushRig
	local Figure = RushCloned:FindFirstChild("Primar")
	
	local SpawnerLibrary = {
		LerpTo = function(object, offset, speed)
			local alpha = 0
			local object = object or error("object must be part.")
			local offset = offset or error("offset Recommended")
			local speed
			if game.Workspace.GameSettings.Entities.RushIsBlood.Value == true then
				speed = 75
			else
				speed = 60
			end
			local distance = (Figure.Position - object.Position).Magnitude
			local relativeSpeed = distance / speed
			local startCFrame = RushCloned.PrimaryPart.CFrame
			local loop
			local reachedEvent = Instance.new("BindableEvent")
			loop = RunSrevice.Heartbeat:Connect(function(delta)
				local goalCFrame = startCFrame:Lerp(object.CFrame * offset, alpha)
				RushCloned:PivotTo(goalCFrame)
				alpha += delta / relativeSpeed
				if alpha >= 1 then
					loop:Disconnect()
					reachedEvent:Fire()
				end
			end)
			reachedEvent.Event:Wait()
		end,
	}
	
	if game.Workspace.GameSettings.Entities.RushIsBlood.Value == true then
		game.Workspace.Ambience_Rush:Play()
		RushCloned.Primar.BloodFootsteps:Play()
		RushCloned.Primar.BloodPlaySound:Play()
		RushCloned.Primar.Attachment.BloodBlackTrail.Enabled = true
		RushCloned.Primar.Attachment.ParticleEmitter.Enabled = false
		RushCloned.Primar.Attachment.BloodParticleEmitter.Enabled = true
    else
		RushCloned.Primar.Footsteps:Play()
		RushCloned.Primar.PlaySound:Play()
		RushCloned.Primar.Attachment.BlackTrail.Enabled = true
	end
	
	RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush4).RoomEnd.CFrame * CFrame.new(0, 0, 16))
	
	RushCloned.Parent = workspace.CurrentRooms
	
	folder.Name = "RushPoints"..numberRush1
	
	task.wait()
	Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomEnd, "1")
	task.wait()
	Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush2).RoomEnd, "2")
	task.wait()
	Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomEnd, "3")
	task.wait()
	Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomEnd, "4", true)
	task.wait()
	
	wait(5)
	
	RushCloned:GetAttributeChangedSignal("Crucifixed"):Connect(function()
		if RushCloned:GetAttribute("Crucifixed", true) then
			game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
		end
	end)
	
	for i = 1, #game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren() do
		if i == 1 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberRush3), 55)
		elseif i == 2 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberRush2), 55)
		elseif i == 3 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberRush1), 55)
		elseif i == 4 then
			if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("HaltRoomRandom1") then
				print("Next is Halt, sorry be late")
			else
				local part = Instance.new("Part")
				part.Transparency = 1
				part.Parent = game.Workspace
				part:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).Door.Hidden.CFrame * CFrame.new(0, 2, 0))
				task.delay(2, function()
					part:Destroy()
				end)
			end
		end
		if game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1) then
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren()[i], CFrame.new(0, 0, 0))
		end
	end
	
	if RushCloned:GetAttribute("Crucifixed", true) then
		game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
	else
		if RushCloned then
			RushCloned:Destroy()
		end
		game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
	end
end

-- AMBUSH

local function ambusing(n)
	
	game.Workspace.Ambience_Ambush:Play()
	game.Workspace.Ambience_Ambush.TimePosition = 0
	
	local function Ambushdot(place, name, d)
		local part = Instance.new("Part")
		part.Size = Vector3.new(1, 1, 1)

		part.Name = name
		part.Transparency = 1
		part.CanCollide = false
		part.Anchored = true
		part.Parent = game.Workspace.CurrentRooms:FindFirstChild("AmbushPoints"..game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

		if d == true then
			part:PivotTo(place.CFrame * CFrame.new(0, -15, -40))
		else
			part:PivotTo(place.CFrame)
		end
	end

	local numberAmbush1
	local numberAmbush2
	local numberAmbush3
	local numberAmbush4

	if n == 1 then
		numberAmbush1 = AmbushSpawnRandom1 - 1
		numberAmbush2 = AmbushSpawnRandom1 - 2
		numberAmbush3 = AmbushSpawnRandom1 - 3
		numberAmbush4 = AmbushSpawnRandom1 - 4
	end
	local folder = Instance.new("Folder")
	folder.Parent = game.Workspace.CurrentRooms

	local RushRig = game.ServerScriptService.Server.Assets.Entities.AmbushMoving:Clone()
	local RushCloned = RushRig
	local Figure = RushCloned:FindFirstChild("AmbushNew")

	local SpawnerLibrary = {
		LerpTo = function(object, offset, speed)
			local alpha = 0
			local object = object or error("object must be part.")
			local offset = offset or error("offset Recommended")
			local speed = speed or 21
			local distance = (Figure.Position - object.Position).Magnitude
			local relativeSpeed = distance / speed
			local startCFrame = RushCloned.PrimaryPart.CFrame
			local loop
			local reachedEvent = Instance.new("BindableEvent")
			loop = RunSrevice.Heartbeat:Connect(function(delta)
				local goalCFrame = startCFrame:Lerp(object.CFrame * offset, alpha)
				RushCloned:PivotTo(goalCFrame)
				alpha += delta / relativeSpeed
				if alpha >= 1 then
					loop:Disconnect()
					reachedEvent:Fire()
				end
			end)
			reachedEvent.Event:Wait()
		end,
	}

	RushCloned.AmbushNew.Footsteps:Play()
	RushCloned.AmbushNew.PlaySound:Play()
	--RushCloned.AmbushNew.Attachment.BlackTrail.Enabled = true

	RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush3).RoomEnd.CFrame * CFrame.new(0, 0, 16))

	RushCloned.Parent = workspace.Rooms

	folder.Name = "AmbushPoints"..numberAmbush1

	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush3).RoomEnd, "1")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2).RoomEnd, "2")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush1).RoomEnd, "3")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2).RoomEnd, "4")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush3).RoomEnd, "5")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2).RoomEnd, "6")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush1).RoomEnd, "7")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2).RoomEnd, "8")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush3).RoomEnd, "9")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2).RoomEnd, "10")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush1).RoomEnd, "11")
	task.wait()
	Ambushdot(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush1).RoomEnd, "12", true)
	task.wait()

	wait(4)

	for i = 1, #game.Workspace.CurrentRooms:FindFirstChild("AmbushPoints"..numberAmbush1):GetChildren() do
		if i == 1 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush3), 60)
		elseif i == 2 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush2), 60)
		elseif i == 3 then
			ModuleEvents.breakLights(game.Workspace.CurrentRooms:FindFirstChild(numberAmbush1), 60)
		end
		if game.Workspace.CurrentRooms:FindFirstChild("AmbushPoints"..numberAmbush1) then
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("AmbushPoints"..numberAmbush1):GetChildren()[i], CFrame.new(0, 0, 0), 80)
		end
	end

	RushCloned:Destroy()
	game.Workspace.CurrentRooms:FindFirstChild("AmbushPoints"..numberAmbush1):Destroy()
end
--[[game.Workspace.CurrentRooms.CurrentRoom.Changed:Connect(function()
	if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("AmbushSpawnRandom") then
		ambusing(1)
	end
	
	if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom") then
		rushing(1)
	end
	if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom2") then
		rushing(2)
	end
	if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom3") then
		rushing(3)
	end
	if game.Workspace.CurrentRooms.CurrentRoom.Value == game.Workspace.CurrentRooms:GetAttribute("RushSpawnRandom4") then
		rushing(4)
	end
end)]]
