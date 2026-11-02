color = script.Parent.Parent.Parent.Character.Head.BrickColor
	
	game.Players.LocalPlayer.Character.Head.Touched:connect(function(person)
		if person.Name == "Handle" then
			
			local player2 = game.Players:FindFirstChild(person.Parent.Parent.Name)
			if player2.Data.Busoshoku.Value == true then
				return
			end
			if player2.Data.Busoshoku.Value ~= true then
				health = script.Parent.Parent.Parent.Character.Humanoid.Health
					
				wait(1.5)
				
			end
		end
	end)