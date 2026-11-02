local mps = game:GetService("MarketplaceService")
local gravID = 261748517
local speedID = 663194466
local gigaID = 669263399

game.Players.PlayerAdded:Connect(function(player)
	local givenCoil = false
	if mps:UserOwnsGamePassAsync(player.UserId, gravID) then
		givenCoil = true
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("Backpack")
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("StarterGear")
	end
	if not givenCoil and mps:UserOwnsGamePassAsync(player.UserId, gigaID) then
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("Backpack")
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("StarterGear")
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	if mps:UserOwnsGamePassAsync(player.UserId, speedID) then
		game.ServerStorage.SpeedCoil:Clone().Parent = player:WaitForChild("Backpack")
		game.ServerStorage.SpeedCoil:Clone().Parent = player:WaitForChild("StarterGear")
	end
end)