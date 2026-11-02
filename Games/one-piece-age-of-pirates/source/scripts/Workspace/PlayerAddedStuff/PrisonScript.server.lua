game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)

	wait(1)
	
	if player.Data.Imprisoned.Value == true then
		prison = script.PrisonScript:Clone()
		prison.Parent = player.Backpack
	end
end)
end)