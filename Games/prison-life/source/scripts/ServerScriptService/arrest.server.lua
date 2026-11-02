local remoteArrest = game.ReplicatedStorage:WaitForChild("Arrest")

remoteArrest.OnServerInvoke = function(player, EnemyPlayer)
	if EnemyPlayer.Team == game.Teams.Inmates then
		if EnemyPlayer:WaitForChild("valueArrest").Value == true then
			local char = EnemyPlayer.Character
			local Humanoid = char:WaitForChild("Humanoid")
			
			spawn(function()
				

				EnemyPlayer.valueArrest.Value = false
				EnemyPlayer.sprint.Value = false

				wait(0.5)

				Humanoid.WalkSpeed = 0

				local Arrest = Humanoid:LoadAnimation(script:WaitForChild("Arrest"))
				Arrest:Play()

				EnemyPlayer.Backpack:ClearAllChildren()

				wait(10)
				
				if Humanoid.Health > 0 then
					EnemyPlayer:LoadCharacter()

					wait(1)

					EnemyPlayer.sprint.Value = true
					EnemyPlayer.PlayerGui.Home.hud.Visible = true
				end
			end)
			
			return true
		else
			return false
		end
	elseif EnemyPlayer.Team == game.Teams.Criminals then
		local char = EnemyPlayer.Character
		local Humanoid = char:WaitForChild("Humanoid")

		spawn(function()
			EnemyPlayer.valueArrest.Value = false
			EnemyPlayer.sprint.Value = false

			EnemyPlayer.Team = game.Teams.Inmates

			wait(0.5)

			Humanoid.WalkSpeed = 0

			local Arrest = Humanoid:LoadAnimation(script:WaitForChild("Arrest"))
			Arrest:Play()

			EnemyPlayer.Backpack:ClearAllChildren()

			wait(10)

			EnemyPlayer:LoadCharacter()

			wait(1)

			EnemyPlayer.sprint.Value = true
			EnemyPlayer.PlayerGui.Home.hud.Visible = true
		end)

		return true
	else
		return false
	end
end