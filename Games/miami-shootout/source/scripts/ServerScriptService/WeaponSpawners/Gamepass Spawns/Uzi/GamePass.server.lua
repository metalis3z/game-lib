local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 629360640) then
	player.Spawns.Value = 6
end