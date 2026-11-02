local bike = script:FindFirstChild("Honda 85")

local function spawnBike(position:Vector3)
	local newBike = bike:Clone()
	newBike.Parent = game.Workspace
	newBike:MoveTo(position)
	task.wait(0.1)
	newBike.Tuner.Initialize.Enabled = true
end

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local passID = script:GetAttribute("633901005")  -- Change this to your Pass ID

game.Players.PlayerAdded:Connect(function(player:Player) 
	player.Chatted:Connect(function(msg)
		if (msg == "/spawn dirtbike") then
			local hasPass = true 
			hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, passID)

			if (hasPass) then
				spawnBike(game.Workspace:FindFirstChild("bikespawner1").CFrame.Position)
			end
		end
	end)
end)