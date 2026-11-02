local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 271378374) then
	player.Spawns.Value = 6
end