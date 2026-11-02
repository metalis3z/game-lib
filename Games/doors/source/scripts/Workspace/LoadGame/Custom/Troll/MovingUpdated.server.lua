local Settings = {
	RushCanCrucifixed = true, -- If false then crucifix item didnt work on rush
	TimeFlickerLights = 2, -- Flicker lights when rush coming, default:2
	RushAfterSpawnComing = 5, -- default:5
}

local ModuleEvents = require(game.ReplicatedStorage.ClientModules.Module_Events)
local RunSrevice = game:GetService('RunService')

game:GetService("Workspace"):WaitForChild("GameSettings"):FindFirstChild("Fires").TrollMove.Event:Connect(function(p1, secretcode)
	local spawnroom = game.Workspace.CurrentRooms.CurrentRoom.Value - 3
	local RushSpawnRandom1 = game.Workspace.CurrentRooms.CurrentRoom.Value
	local Rooms = game.Workspace.CurrentRooms

	--ModuleEvents.flickerLights(game.Workspace.CurrentRooms:FindFirstChild(RushSpawnRandom1 - 1), Settings.TimeFlickerLights)
	
	-- RUSH

	local function rushing()
		
		local l__TweenService__3 = game:GetService("TweenService");

		game.Workspace.Ambience_A60.Volume = 5
		game.Workspace.Ambience_A60.TimePosition = 0
		game.Workspace.Ambience_A60:Play()

		l__TweenService__3:Create(game.Workspace.Ambience_A60, TweenInfo.new(Settings.RushAfterSpawnComing, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play();

		task.delay(Settings.RushAfterSpawnComing, function()
			game.Workspace.Ambience_A60:Stop()
		end)
		
		if not secretcode then
			return print("Please input code")
		end
		
		if secretcode == "ActiveTrollingTrueOk" then
			
		else
			return print("IncorretCode")
		end
		
		if game.Workspace.GameSettings.DisableRush_Entity.Value == true or game.Workspace.GameSettings.Server.RunRush.Value == false then
			return print("Rush have been cancelled because Admin disable rush spawning.")
		end
		
		local folder = Instance.new("Folder")
		folder.Parent = game.Workspace.CurrentRooms

		local RushRig = game.ServerScriptService.Entities.Custom.Trololo.TrololoMoving:Clone()

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
				if RushCloned:GetAttribute("Crucifixed") == true then
					return print("LOL")
				elseif RushCloned:GetAttribute("Crucifixed") == false then
					print("continue")
					local alpha = 0
					local object = object or error("object must be part.")
					local offset = offset or error("offset Recommended")
					local speed = 80
					
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
						
						if RushCloned:GetAttribute("Crucifixed") == true then
							loop:Disconnect()
							reachedEvent:Fire()
						else
							RushCloned:PivotTo(goalCFrame)
						end

						alpha += delta / relativeSpeed
						if alpha >= 1 then
							loop:Disconnect()
							reachedEvent:Fire()
						end
					end)
					reachedEvent.Event:Wait()
				end
			end,
		}

		RushCloned.Primar.Footsteps:Play()
		RushCloned.Primar.PlaySound:Play()

		RushCloned:PivotTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).RoomEnd.CFrame * CFrame.new(0, -120, 120))

		RushCloned.Parent = workspace.CurrentRooms

		task.wait(Settings.RushAfterSpawnComing)

		for i = 1, 4 do
			if i == 1 then
				--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 3], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 3).RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 2 then
				--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 2], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 2).RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 3 then
				--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
				SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomEnd, CFrame.new(0, 0, 0))
			elseif i == 4 then
				
				local D = Instance.new("Part")
				D.Parent = game.Workspace
				D.Anchored = true
				D.CanCollide = false
				D.CanTouch = false
				D.Transparency = 1
				D.CFrame = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1).RoomEnd.CFrame * CFrame.new(0, -120, -120)
				
				task.delay(2, function()
					D:Destroy()
				end)
				
				--ModuleEvents.breakLights(workspace.CurrentRooms[workspace.CurrentRooms.CurrentRoom.Value - 1], 55)
				
				SpawnerLibrary.LerpTo(D, CFrame.new(0, 0, 0))
			end
		--	SpawnerLibrary.LerpTo(game.Workspace.CurrentRooms:FindFirstChild("RushPoints"..numberRush1):GetChildren()[i], CFrame.new(0, 0, 0))
		end

		if RushCloned then
			
			if RushCloned:GetAttribute("Crucifixed") == true then
				
			else
				RushCloned:Destroy()
			end

		end
	end
	
	rushing()
end)