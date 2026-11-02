local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 629815653) then
	player.Spawns.Value = 6
end