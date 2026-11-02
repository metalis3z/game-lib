local Settings = {
	EntityModule = require(game.ServerScriptService.Entities.Hunt.Blitz),
	RushCanCrucifixed = true, -- If false then crucifix item didnt work on rush
	TimeFlickerLights = 2, -- Flicker lights when rush coming, default:2
	RushAfterSpawnComing = 3, -- default:5
}

local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

game:GetService("Workspace"):WaitForChild("GameSettings"):FindFirstChild("Fires").BlitzMove.Event:Connect(function()
	
	local BlitzCloned = game.ServerScriptService.Entities.Hunt.Blitz.Blitz:Clone()
	
	local folder = Instance.new("Folder")
	folder.Parent = game.Workspace.CurrentRooms
	folder.Name = "RushPoints"..game.Workspace.CurrentRooms.CurrentRoom.Value - 1
	
	BlitzCloned.Parent = game.Workspace
	BlitzCloned.Name = "Blitz"
	BlitzCloned.Primar.Footsteps:Play()
	
	ModuleEvents.flickerLights(
		game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1),
		Settings.TimeFlickerLights
	)
	
	local function Rushdot(place, name, d)
		local part = Instance.new("Part")
		part.Size = Vector3.new(1, 1, 1)

		part.Name = name
		part.Transparency = 1
		part.CanCollide = false
		part.Anchored = true
		part.Parent = game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

		part:PivotTo(place.CFrame)
	end
	
	BlitzCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 4).RoomEntrance.CFrame)
	
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
			local distance = (BlitzCloned.PrimaryPart.Position - object.Position).Magnitude
			local relativeSpeed = distance / speed
			local startCFrame = BlitzCloned.PrimaryPart.CFrame
			local loop
			local reachedEvent = Instance.new("BindableEvent")
			loop = RunSrevice.Heartbeat:Connect(function(delta)
				local goalCFrame = startCFrame:Lerp(object.CFrame * offset, alpha)
				BlitzCloned:PivotTo(goalCFrame)
				alpha += delta / relativeSpeed
				if alpha >= 1 then
					loop:Disconnect()
					reachedEvent:Fire()
				end
			end)
			reachedEvent.Event:Wait()
		end,
	}
	
	--[[local valueToload = 4
	
	for i = 1, 4 do
		Rushdot(
			game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - i).RoomExit,
			valueToload
		)
		valueToload -= 1
		wait()
	end--]]
	
	task.wait(Settings.RushAfterSpawnComing)
	
	for i = 1, 4 do
		if i == 1 then
			--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 4], 55)
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 4).RoomExit, CFrame.new(0, 0, 0))
		elseif i == 2 then
			ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3], 55)
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).RoomExit, CFrame.new(0, 0, 0))
		elseif i == 3 then
			ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2], 55)
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2).RoomExit, CFrame.new(0, 0, 0))
		elseif i == 4 then
			ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomExit, CFrame.new(0, 0, 0))
			if math.random(1, 3) == math.random(1, 3) then
				BlitzCloned.Primar.Footsteps:Stop()
				BlitzCloned.Primar.Return:Play()
				BlitzCloned.Primar.Attachment.BlackTrail.Color = ColorSequence.new(Color3.new(0.356863, 0.176471, 0.176471))
				BlitzCloned.Primar.Attachment.ParticleEmitter.Texture = "rbxassetid://16630718245"
				BlitzCloned.Primar.Attachment.Point.Color = Color3.fromRGB(255, 124, 124)
				BlitzCloned.Primar.Attachment.PointLong.Color = Color3.fromRGB(255, 124, 124)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomEntrance, CFrame.new(0, 0, 0))
				wait(math.random(1, 2))
				BlitzCloned.Primar.Footsteps:Play()
				BlitzCloned.Primar.Return:Stop()
				BlitzCloned.Primar.Attachment.BlackTrail.Color = ColorSequence.new(Color3.new(0.168627, 0.317647, 0.356863))
				BlitzCloned.Primar.Attachment.ParticleEmitter.Texture = "rbxassetid://16764890623"
				BlitzCloned.Primar.Attachment.Point.Color = Color3.fromRGB(90, 176, 129)
				BlitzCloned.Primar.Attachment.PointLong.Color = Color3.fromRGB(90, 176, 129)
			end
			SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value).RoomExit, CFrame.new(0, 0, 0))
		end
	end
	
	BlitzCloned:Destroy()
	
end)