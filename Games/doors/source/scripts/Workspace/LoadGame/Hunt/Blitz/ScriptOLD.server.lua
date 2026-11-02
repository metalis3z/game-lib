local Settings = {
	EntityModule = require(game.ServerScriptService.Entities.Hunt.Blitz),
	RushCanCrucifixed = true, -- If false then crucifix item didnt work on rush
	TimeFlickerLights = 2, -- Flicker lights when rush coming, default:2
	RushAfterSpawnComing = 4, -- default:5
}

local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

game:GetService("Workspace"):WaitForChild("GameSettings"):FindFirstChild("Fires").BlitzMove.Event:Connect(function(p1)
	local spawnroom = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
	local RushSpawnRandom1 = p1
	local Rooms = game.Workspace.CurrentRooms

	ModuleEvents.flickerLights(game.Workspace.CurrentRooms:FindFirstChild(RushSpawnRandom1 - 1), Settings.TimeFlickerLights)

	-- RUSH

	local function rushing()

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

		local numberRush1 = RushSpawnRandom1 - 1
		local numberRush2 = RushSpawnRandom1 - 2
		local numberRush3 = RushSpawnRandom1 - 3

		local folder = Instance.new("Folder")
		folder.Parent = game.Workspace.CurrentRooms

		local RushRig = game.ServerScriptService.Entities.Hunt.Blitz.Blitz:Clone()

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

		RushCloned.Primar.Footsteps:Play()
		RushCloned.Primar.Attachment.ParticleEmitter.Enabled = true

		RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomExit.CFrame * CFrame.new(0, 0, 16))

		RushCloned.Parent = workspace.CurrentRooms

		folder.Name = "RushPoints"..numberRush1

		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomExit, "1")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush2).RoomExit, "2")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomExit, "3")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomExit, "4", true)
		task.wait()

		task.wait(Settings.RushAfterSpawnComing)

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
				if game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1) then
					SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren()[2], CFrame.new(0, 0, 0))
					RushCloned.Primar.Return:Play()
					RushCloned.Primar.Footsteps:Stop()
					RushCloned.Primar.Attachment.ParticleEmitter.Texture = Settings.EntityModule.StoppedImage
					RushCloned.Primar.Attachment.BlackTrail.Color = ColorSequence.new(Settings.EntityModule.StoppedColor)
					wait(4)
					RushCloned.Primar.Return:Play()
					RushCloned.Primar.Footsteps:Stop()
					RushCloned.Primar.Attachment.ParticleEmitter.Texture = Settings.EntityModule.NormalImage
					RushCloned.Primar.Attachment.BlackTrail.Color = ColorSequence.new(Settings.EntityModule.NormalColor)
				end
			--elseif i == 4 then

			else
				if game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1) then
					SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren()[i], CFrame.new(0, 0, 0))
				end
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

	rushing()
end)