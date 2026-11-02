local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then -- If it is a reserved server then >>>
	for i, v in pairs(game.ReplicatedStorage.TradingServers:GetChildren()) do
		if game.PrivateServerId == v.ServerId.Value then
			return
		end
	end
	local waitTime = 5
	Players.PlayerAdded:Connect(function(player)
		spawn(function() script.UpdateScreen:Clone().Parent = player:WaitForChild("PlayerGui") end)
		wait(waitTime)
		waitTime = waitTime / 2
		TeleportService:Teleport(game.PlaceId, player, nil, script.UpdateScreen)
	end)
	for _,player in pairs(Players:GetPlayers()) do
		spawn(function() script.UpdateScreen:Clone().Parent = player:WaitForChild("PlayerGui") end)
		TeleportService:Teleport(game.PlaceId, player, nil, script.UpdateScreen)
		wait(waitTime)
		waitTime = waitTime / 2
	end
else
	game:BindToClose(function()
		if (game.JobId == "") or (#Players:GetPlayers() == 0) then return end
		wait(2)
		local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
		for _,player in pairs(Players:GetPlayers()) do
			spawn(function() script.UpdateScreen:Clone().Parent = player:WaitForChild("PlayerGui") end)
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, {player}, nil, nil, script.UpdateScreen)
		end
		Players.PlayerAdded:Connect(function(player)
			spawn(function() script.UpdateScreen:Clone().Parent = player:WaitForChild("PlayerGui") end)
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, {player}, nil, nil, script.UpdateScreen)
		end)
		while (#Players:GetPlayers() > 0) do wait(1) end	
	end)
end