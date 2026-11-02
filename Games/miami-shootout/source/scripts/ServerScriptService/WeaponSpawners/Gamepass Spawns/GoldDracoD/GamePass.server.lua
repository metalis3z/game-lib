local player = game.Players.LocalPlayer

if game.MarketplaceService:UserOwnsGamePassAsync(player.UserId, 633145124) then
	player.Spawns.Value = 6
end