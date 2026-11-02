local Settings = {
	RushCanCrucifixed = true, -- If false then crucifix item didnt work on rush
	TimeFlickerLights = 2, -- Flicker lights when rush coming, default:2
	RushAfterSpawnComing = 5, -- default:5
}

local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

game:GetService("Workspace"):WaitForChild("GameSettings"):FindFirstChild("Fires").AmbushMove.Event:Connect(function(p1, secretcode)
	local spawnroom = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
	local RushSpawnRandom1 = p1
	local Rooms = game.Workspace.CurrentRooms

	ModuleEvents.flickerLights(game.Workspace.CurrentRooms:FindFirstChild(RushSpawnRandom1 - 1), Settings.TimeFlickerLights)

	-- RUSH

	local function rushing()
		
		if not secretcode then
			return print("Please input code")
		end
		
		if secretcode == "ActiveAmbushTrueOk" then
			
		else
			return print("IncorretCode")
		end
		
		if game.Workspace.GameSettings.DisableRush_Entity.Value == true or game.Workspace.GameSettings.Server.RunRush.Value == false then
			return print("Rush have been cancelled because Admin disable rush spawning.")
		end
		
		game.Workspace.Ambience_Ambush:Play()

		local numberRush1 = RushSpawnRandom1 - 1
		local numberRush2 = RushSpawnRandom1 - 2
		local numberRush3 = RushSpawnRandom1 - 3
		local numberRush4 = RushSpawnRandom1 - 4
		
		local folder = Instance.new("Folder")
		folder.Parent = game.Workspace.CurrentRooms

		local RushRig = game.ServerScriptService.Server.Assets.Entities.AmbushMoving:Clone()

		local RushCloned = RushRig
		local Figure = RushCloned:FindFirstChild("Primar")
		
		if game.Workspace.Game.Modifiers:FindFirstChild("Arethoseghosts") then
			if game.Workspace.Game.Modifiers:FindFirstChild("Arethoseghosts").Value == true then
				RushCloned.Primar.Footsteps.RollOffMaxDistance = 45
				RushCloned.Primar.PlaySound.RollOffMaxDistance = 125
				
				for i, v in pairs(RushCloned:GetDescendants()) do
					if v:IsA("Light") then
						v:Destroy()
					end
				end
				
			end
		end

		local SpawnerLibrary = {
			LerpTo = function(object, offset, speed)
				local alpha = 0
				local object = object or error("object must be part.")
				local offset = offset or error("offset Recommended")
				local speed = 75
				
				if game.Workspace.Game.Modifiers:FindFirstChild("Wearetired") then
					if game.Workspace.Game.Modifiers:FindFirstChild("Wearetired").Value == true then
						speed = 45
					end
				end
				
				if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot") then
					if game.Workspace.Game.Modifiers:FindFirstChild("FireShoot").Value == true then
						speed = 95
					end
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
		RushCloned.Primar.PlaySound:Play()
		
		RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomEnd.CFrame * CFrame.new(0, -125, 80))

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
		
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush3).RoomEnd, "1")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush2).RoomEnd, "2")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomEnd, "3")
		task.wait()
		Rushdot(game.Workspace.CurrentRooms:FindFirstChild(numberRush1).RoomEnd, "4", true)
		task.wait()

		task.wait(Settings.RushAfterSpawnComing)

		RushCloned:GetAttributeChangedSignal("Crucifixed"):Connect(function()
			if RushCloned:GetAttribute("Crucifixed", true) then
				game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
			end
		end)
		
		for i = 1, 13 do
			if i == 1 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 2 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 3 then
				ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 4 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 5 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 6 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 7 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 8 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 9 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 10 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 11 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 12 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2].RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 13 then
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3].RoomEnd, CFrame.new(0, 0, 0))
			end
		end
		if RushCloned:GetAttribute("Crucifixed", true) then
			game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
		else
			if RushCloned then
				RushCloned:Destroy()
				
				for i, v in pairs(game.Players:GetPlayers()) do
					if v.Character.Humanoid.Health > 0 then
						local ach = "SurviveAmbush"
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
			game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):Destroy()
		end
	end

	rushing()
end)