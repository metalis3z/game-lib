task.wait(5)

if game:GetService("RunService"):IsStudio() then return end

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
	for _,v in pairs(game.Players:GetPlayers()) do
		script.SoftShutdown:Clone().Parent = v:FindFirstChild("PlayerGui")
	end

	Players.PlayerAdded:connect(function(player)
		script.SoftShutdown:Clone().Parent = player:WaitForChild("PlayerGui")
		TeleportService:Teleport(game.PlaceId, player)
	end)
	
	for _,player in pairs(Players:GetPlayers()) do
		TeleportService:Teleport(game.PlaceId, player)
	end
else
	game:BindToClose(function()
		if (#Players:GetPlayers() == 0) then
			return
		end
		
		if (game:GetService("RunService"):IsStudio()) then
			return
		end
		
		for _,v in pairs(game.Players:GetPlayers()) do
			script.SoftShutdown:Clone().Parent = v:FindFirstChild("PlayerGui")
		end
		wait(2)
		local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
		
		for _,player in pairs(Players:GetPlayers()) do
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end
		Players.PlayerAdded:connect(function(player)
			script.SoftShutdown:Clone().Parent = player:WaitForChild("PlayerGui")
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end)
		while (#Players:GetPlayers() > 0) do
			wait(1)
		end	
	end)
end