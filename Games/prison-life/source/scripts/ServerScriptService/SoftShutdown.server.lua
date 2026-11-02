local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function AddUI(pl)
	script.UpdateUI:Clone().Parent = pl:WaitForChild("PlayerGui")
end

if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
	-- this is a reserved server without a VIP server owner
	local m = Instance.new("Message")
	m.Text = "Prison life 3  is currently updating. Please allow up to 10 seconds!"
	m.Parent = workspace
	
	local waitTime = 8

	Players.PlayerAdded:connect(function(player)
		wait(waitTime)
		waitTime = waitTime / 2
		TeleportService:Teleport(game.PlaceId, player)
	end)
	
	for _,player in pairs(Players:GetPlayers()) do
		TeleportService:Teleport(game.PlaceId, player)
		wait(waitTime)
		waitTime = waitTime / 2
	end
else
	game:BindToClose(function()
		local con
		
		if (#Players:GetPlayers() == 0) then
			return
		end
		
		if (game:GetService("RunService"):IsStudio()) then
			return
		end
		
		for i,v in pairs(game.Players:GetChildren()) do
			AddUI(v)
		end
		
		con = Players.PlayerAdded:connect(function(v)
			wait(1)
			AddUI(v)
		end)
		
		wait(10) -- How long before the server actually shuts down.
		
		con:Disconnect()
		
		local m = Instance.new("Message")
		m.Text = "Rebooting servers for update. Please wait"
		m.Parent = workspace
		wait(2)
		local reservedServerCode = TeleportService:ReserveServer(game.PlaceId)
		
		for _,player in pairs(Players:GetPlayers()) do
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end
		Players.PlayerAdded:connect(function(player)
			TeleportService:TeleportToPrivateServer(game.PlaceId, reservedServerCode, { player })
		end)
		while (#Players:GetPlayers() > 0) do
			wait(1)
		end	
		
		-- done
	end)
end