-- Reference copy for study. Game: doors
-- Original: Workspace/LoadGame/Rush/MovingUpdated.server.lua  (Script, 258 lines)
-- What it does: DOORS-style Rush: flickers lights, spawns a few rooms behind the players, then lerps the entity through each room's RoomStart->RoomEnd pathfinding waypoints at a fixed speed and awards a survival badge; supports crucifix cancel.

local Settings = {
	RushCanCrucifixed = true, -- If false then crucifix item didnt work on rush
	TimeFlickerLights = 2, -- Flicker lights when rush coming, default:2
	RushAfterSpawnComing = 5, -- default:5
}

local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

game:GetService("Workspace"):WaitForChild("GameSettings"):FindFirstChild("Fires").RushMove.Event:Connect(function(p1, secretcode)
	local spawnroom = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
	local RushSpawnRandom1 = game.Workspace.CurrentRooms.CurrentRoom.Value
	local Rooms = game.Workspace.CurrentRooms

	ModuleEvents.flickerLights(game.Workspace.CurrentRooms:FindFirstChild(RushSpawnRandom1 - 1), Settings.TimeFlickerLights)
	
	if game.Workspace.GameSettings.Hardcore.Value == true then
		game.Workspace.GameSettings.Entities.RushIsBlood.Value = true
	end
	
	-- RUSH

	local function rushing()
		
		if not secretcode then
			return print("Please input code")
		end
		
		if secretcode == "ActiveRushTrueOk" then
			
		else
			return print("IncorretCode")
		end
		
		if game.Workspace.GameSettings.DisableRush_Entity.Value == true or game.Workspace.GameSettings.Server.RunRush.Value == false then
			return print("Rush have been cancelled because Admin disable rush spawning.")
		end

		local numberRush1 = RushSpawnRandom1 - 1
		local numberRush2 = RushSpawnRandom1 - 2
		local numberRush3 = RushSpawnRandom1 - 3
		local numberRush4 = RushSpawnRandom1 - 4
		
		local folder = Instance.new("Folder")
		folder.Parent = game.Workspace.CurrentRooms

		local RushRig = game.ServerScriptService.Server.Assets.Entities.RushNew:Clone()

		local RushCloned = RushRig
		local Figure = RushCloned:FindFirstChild("Primar")

		local SpawnerLibrary = {
			LerpTo = function(object, offset, speed)
				if RushCloned:GetAttribute("Crucifixed") == true then
					return print("LOL")
				end
				local alpha = 0
				local object = object or error("object must be part.")
				local offset = offset or error("offset Recommended")
				local speed
				if game.Workspace.GameSettings.Entities.RushIsBlood.Value == true then
					speed = 75
				else
					speed = 80
				end
				local distance = (Figure.Position - object.Position).Magnitude
				local relativeSpeed = distance / speed
				local startCFrame = RushCloned.PrimaryPart.CFrame
				local loop
				local part_Object = Instance.new("Part", workspace)
				part_Object.Anchored = true
				part_Object.CanCollide = false
				part_Object.CanTouch = false
				part_Object.CanQuery = false
				part_Object.Transparency = 1
				part_Object.Position = object.Position
				local reachedEvent = Instance.new("BindableEvent")
				loop = RunSrevice.Heartbeat:Connect(function(delta)
					local goalCFrame = startCFrame:Lerp(part_Object.CFrame * offset, alpha)
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
		
		if not game.Workspace.CurrentRooms:FindFirstChild(numberRush4) then
			RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomEnd.CFrame * CFrame.new(0, 0, 16))
		else
			RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush4).RoomEnd.CFrame * CFrame.new(0, 0, 16))
		end

		RushCloned.Parent = workspace.CurrentRooms

		folder.Name = "RushPoints"..numberRush1
		
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

		task.wait(Settings.RushAfterSpawnComing)

		RushCloned:GetAttributeChangedSignal("Crucifixed"):Connect(function()
			if RushCloned:GetAttribute("Crucifixed", true) then
				game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
			end
		end)
		
		local PathfindingService = game:GetService("PathfindingService")
		
		local CurrentRoom1 = workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3]
		
		local start = CurrentRoom1.RoomStart
		local goal = CurrentRoom1.RoomEnd

		local path = PathfindingService:CreatePath({ AgentHeight = 5, AgentRadius = 3, AgentCanJump = true })

		path:ComputeAsync(start.Position, goal.Position)
		local waypoints = path:GetWaypoints()

		for i = 1, 4 do
			if i == 1 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3], 55)
				local room = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3)
				
				path:ComputeAsync(
					room.RoomStart.Position,
					room.RoomEnd.Position
				)
				
				local waypoints = path:GetWaypoints()
				
				for i, waypoint in pairs(waypoints) do
					SpawnerLibrary.LerpTo(waypoint, CFrame.new(0, 5, 0))
				end
				
			elseif i == 2 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2], 55)
				local room = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2)

				path:ComputeAsync(
					room.RoomStart.Position,
					room.RoomEnd.Position
				)

				local waypoints = path:GetWaypoints()

				for i, waypoint in pairs(waypoints) do
					SpawnerLibrary.LerpTo(waypoint, CFrame.new(0, 5, 0))
				end
			elseif i == 3 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
				local room = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)

				path:ComputeAsync(
					room.RoomStart.Position,
					room.RoomEnd.Position
				)

				local waypoints = path:GetWaypoints()

				for i, waypoint in pairs(waypoints) do
					SpawnerLibrary.LerpTo(waypoint, CFrame.new(0, 5, 0))
				end
			elseif i == 4 then
				
				local D = Instance.new("Part")
				D.Parent = game.Workspace
				D.Anchored = true
				D.CanCollide = false
				D.CanTouch = false
				D.Transparency = 1
				D.CFrame = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomEnd.CFrame * CFrame.new(0, -0, -90)
				
				--[[local part = Instance.new("Part")
				part.Transparency = 1
				part.Parent = game.Workspace
				part:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).Door.Hidden.CFrame * CFrame.new(0, 2, 0))
				task.delay(2, function()
					part:Destroy()
					D:Destroy()
				end)
				--]]
				--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
				
				SpawnerLibrary.LerpTo(D, CFrame.new(0, 0, 0))
			end
		--	SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren()[i], CFrame.new(0, 0, 0))
		end

		if RushCloned:GetAttribute("Crucifixed", true) then
			game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
		else
			if RushCloned then
				RushCloned:Destroy()
				
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Character.Humanoid.Health > 0 then
						for i, v in pairs(game.Players:GetPlayers()) do
							if v.Character then 
								local ach = "SurviveRush"
								local p1_player = v

								if game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach) then
									local achive = game.Players[p1_player.Name].InGameStats.Achievements:FindFirstChild(ach)
									local req = require(game.ReplicatedStorage.Achievements)[ach]

									if achive.Value == false then
										achive.Value = true
										if not game:GetService("BadgeService"):UserHasBadgeAsync(p1_player.UserId, req.BadgeId) then
											game.ReplicatedStorage.EntityInfo.AchievementUnlock:FireClient(p1_player, ach)
											game:GetService("BadgeService"):AwardBadge(p1_player.UserId, req.BadgeId)
										end
									end

								end
							end
						end
					end
				end
				
			end
			game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
		end
	end
	
	rushing()
end)
