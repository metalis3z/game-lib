local players = game.Players
local marketplace = game.MarketplaceService
local ih = require(game.ServerScriptService.InventoryHandler)

players.PlayerAdded:Connect(function(player)
	if marketplace:UserOwnsGamePassAsync(player.UserId, 261748378) then
		ih.AddItemToInventory(player, "ThrusterScooter")
	end
end)