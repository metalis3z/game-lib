local DataStoreService = game:GetService("DataStoreService")
local PipBoyData = DataStoreService:GetDataStore("PipBoyData")

local mkps = game:GetService("MarketplaceService")
local idGamePass = 76718911

local dataDefault = {
	showing = true;
	enabled = true;
	--gunlaserDefault = "TommyGun";
	antiKill = true;
	color = "Bright green"
}

local pipboyConfig = game.ReplicatedStorage:WaitForChild("PipBoyConfig")
local remotes = pipboyConfig:WaitForChild("Remotes")
local animations = pipboyConfig:WaitForChild("Animations")

function PlaySound(player, SoundName, Multiples)
	local pipboy = player.Character:WaitForChild("PipBoy")
	local gloveouter = pipboy:WaitForChild("gloveouter")

	local aSounds = gloveouter:WaitForChild(SoundName)

	if Multiples == true then
		spawn(function()
			local newSound = aSounds:Clone()
			newSound.Parent = gloveouter

			newSound:Play()

			newSound.Ended:Wait()

			newSound:Destroy()
		end)
	else
		aSounds:Play()
	end
end

remotes.PlaySounds.OnServerEvent:Connect(function(player, SoundName, Multiples)
	PlaySound(player, SoundName, Multiples)
end)

function StopSound(player, SoundName)
	local pipboy = player.Character:WaitForChild("PipBoy")
	local gloveouter = pipboy:WaitForChild("gloveouter")

	local aSounds = gloveouter:WaitForChild(SoundName)
	aSounds:Stop()
end

remotes.StopSounds.OnServerEvent:Connect(function(player, SoundName)
	StopSound(player, SoundName)
end)

function Delete(player)
	local pipboy = player.Character:WaitForChild("PipBoy")
	pipboy:Destroy()
end

remotes.UnShow.OnServerEvent:Connect(function(player)
	Delete(player)
end)

function Add(player)
	--print("go")
	local NewPipboy = pipboyConfig.PipBoy:Clone()
	NewPipboy.Parent = player.Character
	NewPipboy:WaitForChild("Main").Disabled = false
	
	PlaySound(player, "Noise", false)
end

remotes.Show.OnServerEvent:Connect(function(player)
	Add(player)
end)

remotes.Open.OnServerEvent:Connect(function(player)
	local pipboy = player.Character:FindFirstChild("PipBoy")
	
	if not pipboy then
		Add(player)
	end
	
	local WatchOn = player.Character:WaitForChild("Humanoid"):LoadAnimation(animations.WatchOn)
	WatchOn:Play()
end)

remotes.Close.OnServerEvent:Connect(function(player)
	local pipboy = player.Character:FindFirstChild("PipBoy")
	local IsShowValue = player:WaitForChild("PipBoy"):WaitForChild("IsShowValue")
	
	if pipboy and IsShowValue.Value == false then
		Delete(player)
	end
	
	for i,Track in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
		if Track.Name == "WatchOn" then
			Track:Stop()
		end
	end
end)

remotes.ConfirmModeAntiKill.OnServerEvent:Connect(function(player, selected, currentKiller)
	if player:WaitForChild("PipBoy"):WaitForChild("IsAntiKill").Value == true then
		
		--stopWatchAnim
		for i,Track in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
			if Track.Name == "WatchOn" then
				Track:Stop()
			end
		end
		
		if not player.Character:FindFirstChild("TommyGun") then
			local ATommyGun = player.Backpack.TommyGun
			ATommyGun.Parent = player.Character
		end
		
		remotes.ShotLaser:FireClient(player,selected, currentKiller)
		
		player:WaitForChild("PipBoy"):WaitForChild("IsAntiKill").Value = false
		
		local timeArmingLaser = player:WaitForChild("PipBoy"):WaitForChild("TimeArmingLaser")
		timeArmingLaser.Value = 20
		
		spawn(function()
			while timeArmingLaser.Value ~= 0 do
				wait(1)
				timeArmingLaser.Value = timeArmingLaser.Value -1
			end
			
			player:WaitForChild("PipBoy"):WaitForChild("CanShotLaser").Value = true
		end)
	end
end)

remotes.ApplyASettings.OnServerEvent:Connect(function(player, setting ,bool)	
	local valueSettings = player:WaitForChild("PipBoy"):WaitForChild(setting)
	valueSettings.Value = bool
	
	if setting == "Enabled" then
		if bool == true then
			if player:WaitForChild("PipBoy"):WaitForChild("IsShowValue").Value == true then
				Add(player)
			end
			
			--player.PlayerGui:WaitForChild("WatchGui"):WaitForChild("Settings"):WaitForChild("LocalScript").Disabled = false
			
			if player.Team ~= game.Teams.Inmates then
				local gun = game.ServerStorage.TommyGun:Clone()
				gun.Parent = player.Backpack
			end
		else
			Delete(player)
			
			for i,Track in pairs(player.Character.Humanoid:GetPlayingAnimationTracks()) do
				if Track.Name == "WatchOn" then
					Track:Stop()
				end
			end
			
			--player.PlayerGui:WaitForChild("WatchGui"):WaitForChild("Settings"):WaitForChild("LocalScript").Disabled = true
			
			local atommygun = player.Backpack:FindFirstChild("TommyGun")
			
			if atommygun then
				atommygun:Destroy()
			end
		end
	end
end)

remotes.ApplyASettingsColor.OnServerEvent:Connect(function(player, value)
	local themeValue = player:WaitForChild("PipBoy"):WaitForChild("Theme")
	themeValue.Value = value
end)

remotes.Return.OnServerEvent:Connect(function(player)
	local pipboyFolder = player:WaitForChild("PipBoy")
	
	local CanShotLaser = pipboyFolder:WaitForChild("CanShotLaser")
	local IsAntiKill = pipboyConfig:WaitForChild("IsAntiKill")
	
	CanShotLaser.Value = true
	IsAntiKill.Value = false
end)

game.Players.PlayerAdded:Connect(function(player)
	if mkps:UserOwnsGamePassAsync(player.UserId, idGamePass) then
		--print("ok")
		--getdata
		local data
		
		local success, errorMessage = pcall(function()
			data = PipBoyData:GetAsync(player.UserId.."DataPipBoy")
		end)
		
		if success then
			if data == nil then
				data = dataDefault
			end
		else
			data = dataDefault
			
			print(errorMessage)
		end
		
		local folder = Instance.new("Folder", player)
		folder.Name = "PipBoy"
		
		local CanShotLaser = Instance.new("BoolValue", folder)
		CanShotLaser.Name = "CanShotLaser"
		CanShotLaser.Value = true
		
		local isShotLaser = Instance.new("BoolValue", folder)
		isShotLaser.Name = "IsAntiKill"
			
		local timeArmingLaser = Instance.new("NumberValue", folder)
		timeArmingLaser.Name = "TimeArmingLaser"

		local IsShow = Instance.new("BoolValue", folder)
		IsShow.Name = "IsShowValue"
		IsShow.Value = data.showing
	
		local Theme = Instance.new("StringValue", folder)
		Theme.Name = "Theme"
		Theme.Value = data.color

		local Enabled = Instance.new("BoolValue", folder)
		Enabled.Name = "Enabled"
		Enabled.Value = data.enabled

		local AntikillEnabled = Instance.new("BoolValue", folder)
		AntikillEnabled.Name = "AntikillEnabled"
		AntikillEnabled.Value = data.antiKill

		local CanOpen = Instance.new("BoolValue", folder)
		CanOpen.Name = "CanOpen"
		CanOpen.Value = true

		player.CharacterAdded:Connect(function(char)
			wait(1)
			
			local gui = script.WatchGui:Clone()
			gui.Parent = player.PlayerGui
			
			isShotLaser.Value = false
			CanShotLaser.Value = true
			
			if Enabled.Value == true then
				--gui.Settings.LocalScript.Disabled = false
				
				if IsShow.Value == true then
					Add(player)
				end

				if player.Team ~= game.Teams.Inmates then
					local gun = game.ServerStorage.TommyGun:Clone()
					gun.Parent = player.Backpack
				end

				local humanoid = char:WaitForChild("Humanoid")
				humanoid.HealthChanged:Connect(function()
					if humanoid.Health <= 75 then
						local killerValue = humanoid:FindFirstChild("creator")

						if killerValue then
							if player.Backpack:FindFirstChild("TommyGun") or char:FindFirstChild("TommyGun") then
								if CanShotLaser.Value == true and AntikillEnabled.Value == true and Enabled.Value == true then
									CanShotLaser.Value = false
									isShotLaser.Value = true

									local WatchOn = humanoid:LoadAnimation(animations.WatchOn)
									WatchOn:Play()

									remotes.ShowModeAntiKill:FireClient(player, killerValue.Value)
								end
							end
						end
					end
				end)
			end
		end)
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	if mkps:UserOwnsGamePassAsync(player.UserId, idGamePass) then
		local PipBoyFolder = player:WaitForChild("PipBoy")
		
		local AntikillEnabled = PipBoyFolder:WaitForChild("AntikillEnabled")
		local Enabled = PipBoyFolder:WaitForChild("Enabled")
		local IsShowinEnabled = PipBoyFolder:WaitForChild("IsShowValue")
		local Color = PipBoyFolder:WaitForChild("Theme")
		
		local newTable = {
			showing = IsShowinEnabled.Value;
			enabled = Enabled.Value;
			antiKill = AntikillEnabled.Value;
			color = Color.Value
		}
		
		local Success, ErrorMessage = pcall(function()
			PipBoyData:SetAsync(player.UserId.."DataPipBoy", newTable)
		end)
		
		if Success then
			print("Saved PipBoy for "..player.Name..".")
		else
			error(ErrorMessage)
		end
	end
end)