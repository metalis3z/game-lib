local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 271390711) then
	player.Spawns.Value = 6
end