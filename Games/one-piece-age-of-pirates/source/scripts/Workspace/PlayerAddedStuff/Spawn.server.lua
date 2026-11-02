math.randomseed(tick())

game.Players.PlayerAdded:connect(function(player)
	player.CharacterAdded:connect(function(character)
	
	wait(1)
	
if (player.Data.X.Value == 0 and player.Data.Y.Value == 0 and player.Data.Z.Value == 0) or (player.Data.Y.Value > 100) then
	spawnloc = math.random(1, 2)
	if spawnloc == 1 then
		player.Character:MoveTo(game.Workspace.PersonSpawn1.Position + Vector3.new(0, 5, 0))
	end
	
	if spawnloc == 2 then
		player.Character:MoveTo(game.Workspace.PersonSpawn2.Position + Vector3.new(0, 5, 0))
	end
	
	return
end

	player.Character:MoveTo(Vector3.new(player.Data.X.Value, player.Data.Y.Value, player.Data.Z.Value))

	end)
end)