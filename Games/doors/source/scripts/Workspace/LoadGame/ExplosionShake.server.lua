game.ReplicatedStorage.ExplosionShake.OnServerEvent:Connect(function(player, p2)
	if player.Stats.KnobsGiven.Value == false then
		
		local module = require(game.ReplicatedStorage.ClientModules.Module_AdminPanel)

		if module:haveAccess(player) == true and player.PlayerStats.AdminPanel.Value == true then
			print('Clonet')
			player.Stats.KnobsGiven.Value = true
			return
		else
			local KnobsToGive
			local FriendBoost = p2
			
			local KnobsForGold = math.floor(player.Stats.Gold.Value / 6)
			local KnobsForOpenedDoors = math.floor(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)
			
			KnobsToGive = KnobsForGold + KnobsForOpenedDoors
			
			if player.InGameStats.FloorsEscaped.Value == true then
				KnobsToGive = KnobsToGive + 50
			end
			
			if FriendBoost == 1 then
				KnobsToGive = KnobsToGive * 1.25
			elseif FriendBoost == 2 then
				KnobsToGive = KnobsToGive * 1.5
			elseif FriendBoost == 3 then
				KnobsToGive = KnobsToGive * 1.75
			end
			
			print(KnobsToGive)
			
			player.Stats.KnobsGiven.Value = true
			player.PlayerStats.Knobs.Value = player.PlayerStats.Knobs.Value + KnobsToGive
		end

	end
end)