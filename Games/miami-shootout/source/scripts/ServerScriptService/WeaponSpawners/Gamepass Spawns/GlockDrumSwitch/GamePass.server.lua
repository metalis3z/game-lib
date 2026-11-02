local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 271275066) then
	player.Spawns.Value = 6
end