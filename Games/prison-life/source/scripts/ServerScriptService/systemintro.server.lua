local players = game:GetService("Players")

local homeConfig = game.ReplicatedStorage:WaitForChild("HomeConfig")

local CameraRemote = homeConfig:WaitForChild("Camera")
local JoinTeam = homeConfig:WaitForChild("JoinTeam")
local JoinNeutral = homeConfig:WaitForChild("JoinNeutral") 

local isLaunchedNuke = game.ReplicatedStorage.NukeConfig:WaitForChild("IsLaunched")

players.PlayerAdded:Connect(function(player)
	local avalue = Instance.new("BoolValue")
	avalue.Parent = player
	avalue.Name = "isintro"
	
	if isLaunchedNuke.Value == false then
		avalue.Value = true
	else
		avalue.Value = false
		
		player.Team = game.Teams.NoSurvivors
	end
	
	player.CharacterAdded:Connect(function(character)
		wait(0.5)
		
		if isLaunchedNuke.Value == false then
			if avalue.Value == true then
				CameraRemote:FireClient(player, true)

				player.PlayerGui.Home.intro.Visible = true
			else
				player.PlayerGui.Home.hud.Visible = true
			end
		end
	end)
end)

JoinTeam.OnServerEvent:Connect(function(player, color)
	if color == BrickColor.new("Bright blue") then
		
		local count = 0
		
		for i,v in pairs(game.Players:GetChildren()) do
			if v.Team == game.Teams.Guards then
				count = count +1
			end
		end
				
		if count < 8 then
			player.isintro.Value = false

			player.TeamColor = color

			wait(0.5)
			player:LoadCharacter()

			wait(0.5)
			CameraRemote:FireClient(player, false)

			--player.PlayerGui.Home.hud.Visible = true
		else
			player.PlayerGui.Home.intro.NoticeFrame.Visible = true
		end
	else 
		
		local count = 0

		for i,v in pairs(game.Players:GetChildren()) do
			if v.Team == game.Teams.Inmates then
				count = count +1
			end
		end

		if count < 16 then
			player.isintro.Value = false

			player.TeamColor = color

			wait(0.5)
			player:LoadCharacter()

			wait(0.5)
			CameraRemote:FireClient(player, false)
		else
			player.PlayerGui.Home.intro.NoticeFrame.Visible = true
		end
	end
end)

JoinNeutral.OnServerEvent:Connect(function(player)
	player.isintro.Value = true
	
	player.TeamColor = BrickColor.new("Medium stone grey")
	
	wait(0.5)
	player:LoadCharacter()
	
	--wait(0.5)
	--CameraRemote:FireClient(player, true)
	
	--player.PlayerGui.Home.Home.Visible = true
	
	--player.isintro.Value = true
end)