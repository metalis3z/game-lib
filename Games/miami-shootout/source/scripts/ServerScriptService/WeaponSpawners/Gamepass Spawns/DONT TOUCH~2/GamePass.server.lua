local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 135444698) then
	player.Spawns.Value = 20
end