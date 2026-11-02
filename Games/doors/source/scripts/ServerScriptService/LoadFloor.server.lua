local modifiers = {}

game.Players.PlayerAdded:Connect(function(Player)
	
	local md = Player:GetJoinData().TeleportData
	if md ~= nil and md.modifiers ~= nil then
		modifiers = md.modifiers
		
		print("Knobs bonus "..md.modifierBonus)
		
	end
	print(modifiers)
	
	while true do
		wait(0.1)
		if Player:FindFirstChild("PlayerStats") and game.Workspace:FindFirstChild(Player.Name) then
			break
		end
	end
	
	if Player then
		
		if modifiers == nil then
			
		else
			for i, v in pairs(modifiers) do
				if Player:WaitForChild("Modifiers") then
					if Player:WaitForChild("Modifiers"):FindFirstChild(v) then
						game.Workspace.Game:WaitForChild("Modifiers"):FindFirstChild(v).Value = true
						game.Workspace.Game:WaitForChild("Modifiers").KnobBonus.Value = md.modifierBonus
						game.ReplicatedStorage.EntityInfo.GetMods:FireClient(Player)
					end
				end
			end
		end
		
		if Player:WaitForChild("PlayerStats").TypeRun.Value == "Rooms" then

			wait()

			if game.Workspace.TypeRun:GetAttribute("FirstRoomLoaded") == false then

				for i, v in pairs(script.Rooms.Lighting.Stats:GetChildren()) do

					if v then
						v.Parent = game.Lighting
					end

				end
				
				game.Workspace.TypeRun:SetAttribute("FirstRoomLoaded", true)
				game.Lighting.Ambient = script:FindFirstChild("Rooms").Lighting.Ambient.Value
				game.Lighting.Brightness = script:FindFirstChild("Rooms").Lighting.Brightness.Value

				script.Rooms:FindFirstChild("0").Parent = game.Workspace.CurrentRooms
			end

			wait(0.1)

			Player.Character:PivotTo(game.Workspace.CurrentRooms:WaitForChild("0").StartPlace.CFrame)
		elseif Player:WaitForChild("PlayerStats").TypeRun.Value == "HardHotel" then

			wait()

			if game.Workspace.TypeRun:GetAttribute("FirstRoomLoaded") == false then

				for i, v in pairs(script.Hotel.Lighting.Stats:GetChildren()) do

					if v then
						v.Parent = game.Lighting
					end

				end
				
				game.Workspace.GameSettings.Hardcore.Value = true
				
				game.Workspace.TypeRun:SetAttribute("FirstRoomLoaded", true)
				game.Lighting.Ambient = script:FindFirstChild("Hotel").Lighting.Ambient.Value
				game.Lighting.Brightness = script:FindFirstChild("Hotel").Lighting.Brightness.Value

				script.Hotel:FindFirstChild("0").Parent = game.Workspace.CurrentRooms
			end

			wait(0.1)

			Player.Character:PivotTo(game.Workspace.CurrentRooms:WaitForChild("0").StartPlace.CFrame)
		elseif Player:WaitForChild("PlayerStats").TypeRun.Value == "Hotel" then

			if game.Workspace.TypeRun:GetAttribute("FirstRoomLoaded") == false then
				
				for i, v in pairs(script.Hotel.Lighting.Stats:GetChildren()) do

					if v then
						v.Parent = game.Lighting
					end

				end
				
				game.Workspace.TypeRun:SetAttribute("FirstRoomLoaded", true)
				game.Lighting.Ambient = script:FindFirstChild("Hotel").Lighting.Ambient.Value
				game.Lighting.Brightness = script:FindFirstChild("Hotel").Lighting.Brightness.Value
				
				script.Hotel:FindFirstChild("0").Parent = game.Workspace.CurrentRooms
			end
			
			wait(0.1)
			
			Player.Character:PivotTo(game.Workspace.CurrentRooms:WaitForChild("0").StartPlace.CFrame)
		elseif Player:WaitForChild("PlayerStats").TypeRun.Value == "Hunt" then

			wait()

			if script.Backdoor.Lighting:FindFirstChild("SkyboxPart") then
				script.Backdoor.Lighting.SkyboxPart.Parent = game.Workspace
			end

			if game.Workspace.TypeRun:GetAttribute("FirstRoomLoaded") == false then

				for i, v in pairs(script.Backdoor.Lighting.Stats:GetChildren()) do

					if v then
						v.Parent = game.Lighting
					end

				end
				
				game.Workspace.TypeRun:SetAttribute("FirstRoomLoaded", true)
				game.Lighting.Ambient = script:FindFirstChild("Backdoor").Lighting.Ambient.Value
				game.Lighting.Brightness = script:FindFirstChild("Backdoor").Lighting.Brightness.Value
				
				script.Backdoor:FindFirstChild("0").Parent = game.Workspace.CurrentRooms
			end
			wait(0.1)
			
			local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

			local ach = "EnterBackdoor"
			local p1_player = Player

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
			
			Player.Character:PivotTo(game.Workspace.CurrentRooms:WaitForChild("0").StartPlace.CFrame)
		elseif Player:WaitForChild("PlayerStats").TypeRun.Value == "HuntExit" then

			game.ReplicatedStorage.EntityInfo.CinematicDoor:FireClient(Player)

			wait()

			game.Lighting.Ambient = script:FindFirstChild("HuntExit").Lighting.Ambient.Value
			game.Lighting.Brightness = script:FindFirstChild("HuntExit").Lighting.Brightness.Value

			if game.Workspace.TypeRun:GetAttribute("FirstRoomLoaded") == false then
				
				for i, v in pairs(script.Backdoor.Lighting.Stats:GetChildren()) do

					if v then
						v.Parent = game.Lighting
					end

				end
				
				game.Workspace.TypeRun:SetAttribute("FirstRoomLoaded", true)
				script.HuntExit:FindFirstChild("0").Parent = game.Workspace.CurrentRooms
			end

			wait(0.1)

			Player.Character:PivotTo(game.Workspace.CurrentRooms:WaitForChild("0").StartPlace.CFrame)
		elseif Player:WaitForChild("PlayerStats").TypeRun.Value == "Lobby" then
			print("Bro have no data:".. Player:WaitForChild("PlayerStats").TypeRun.Value)
			task.delay(1, function()
				--Player:Kick("Brah 🤗")
			end)
		end
	end
end)