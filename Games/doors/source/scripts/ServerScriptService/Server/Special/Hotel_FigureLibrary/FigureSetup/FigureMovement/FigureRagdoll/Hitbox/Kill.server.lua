script.Parent.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	
	if player then
		if player.Character:GetAttribute("CrucifixEnabled") == true then
			script.Parent.CanTouch = false
			script.Parent.Parent.Parent.SpeedValue.Value = 0
			player.Character.Crucifix.Function:Fire(script.Parent.Parent)
			task.delay(7, function()
				script.Parent.Parent.Parent.SpeedValue.Value = 7
				script.Parent.CanTouch = true
			end)
		else
			game.Players:GetPlayerFromCharacter(hit.Parent).Stats.Death.Value = "Figure"
			game.ReplicatedStorage.EntityInfo.Jumpscare:FireClient(game.Players:WaitForChild(hit.Parent.Name), "Figure")
			game.ReplicatedStorage.EntityInfo.DeathHint:FireClient(game.Players:WaitForChild(hit.Parent.Name), {"You died to who you call the Figure...", "It cannot see, but it will use sounds and vibrations to its advantage."}, "Blue")
			wait(0.5)
			game.Players:GetPlayerFromCharacter(hit.Parent).Character.Humanoid.Health = 0 
		end
	end
end)