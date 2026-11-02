color = script.Parent.Parent.Parent.Character.Torso.BrickColor

	game.Players.LocalPlayer.Character.Torso.Touched:connect(function(person)
		if person.Name == "Handle" then
			
			local player2 = game.Players:FindFirstChild(person.Parent.Parent.Name)
			if player2.Data.Busoshoku.Value == true then
				return
			end
			if player2.Data.Busoshoku.Value ~= true then
				health = script.Parent.Parent.Parent.Character.Humanoid.Health
				script.Parent.Parent.Parent.Character.Humanoid.Health = health
				
				fire = script.Fire:Clone()
				fire.Parent = script.Parent.Parent.Parent.Character.Torso
				game.Debris:AddItem(fire, 1.5)
				
				wait(1.5)
			end
		end
	end)