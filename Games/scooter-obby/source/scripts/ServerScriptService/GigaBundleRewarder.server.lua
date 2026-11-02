local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "GigaBundleRewards")
local rs = game:GetService("ReplicatedStorage")
local marketplaceService = game:GetService("MarketplaceService")
local players = game.Players
local gigaID = 669263399
local gravID = 261748517
local speedID = 663194466

players.PlayerAdded:Connect(function(player)
	local rebirthStore = ds2("GigaBundleRewards", player)
	local rebirths = rebirthStore:Get(false)
	if rebirths == false and marketplaceService:UserOwnsGamePassAsync(player.UserId, gigaID) then
		rebirthStore:Set(true)
		print("gave giga rewards to " .. player.Name)
		game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 250000)
		task.wait(5)
		game.ReplicatedStorage.RemoteEvents.ugcCrateRequest:Fire(player)
	end
end)

marketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, pass_id, was_purchased)
	local rebirthStore = ds2("GigaBundleRewards", player)
	local rebirths = rebirthStore:Get(false)
	if pass_id == gigaID and was_purchased then
		if rebirths == false then
			rebirthStore:Set(true)
			print("gave giga rewards to " .. player.Name)
			game.ServerScriptService.StageUpdater.CoinTake:Fire(player, 250000)
			game.ReplicatedStorage.RemoteEvents.ugcCrateRequest:Fire(player)
		end
	end
	if pass_id == gravID and was_purchased then
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("Backpack")
		game.ServerStorage.GravCoil:Clone().Parent = player:WaitForChild("StarterGear")
	end
	if pass_id == speedID and was_purchased then
		game.ServerStorage.SpeedCoil:Clone().Parent = player:WaitForChild("Backpack")
		game.ServerStorage.SpeedCoil:Clone().Parent = player:WaitForChild("StarterGear")
	end
end)