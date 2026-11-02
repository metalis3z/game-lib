color = script.Parent.Parent.Parent.Character["Right Leg"].BrickColor

	game.Players.LocalPlayer.Character["Right Leg"].Touched:connect(function(person)
		if person.Name == "Handle" then
			
			local player2 = game.Players:FindFirstChild(person.Parent.Parent.Name)
			if player2.Data.Busoshoku.Value == true then
				return
			end
			if player2.Data.Busoshoku.Value ~= true then
				health = script.Parent.Parent.Parent.Character.Humanoid.Health
				script.Parent.Parent.Parent.Character.Humanoid.Health = health
				
				light = script.Smoke:Clone()
				light.Parent = script.Parent.Parent.Parent.Character["Right Leg"]
				game.Debris:AddItem(light, 1.5)
				
				script.Parent.Parent.Parent.Character["Right Leg"].BrickColor = BrickColor.new("Alder")
				script.Parent.Parent.Parent.Character["Right Leg"].Transparency = 0.4
				
				script.Parent.Parent.Parent.Character["Right Leg"].TopSurface = "Smooth"
				script.Parent.Parent.Parent.Character["Right Leg"].BottomSurface = "Smooth"
				
				mesh1 = Instance.new("BlockMesh")
				mesh1.Parent = game.Players.LocalPlayer.Character["Right Leg"]
				mesh1.Scale = Vector3.new(1, 1, 1)
				game.Debris:AddItem(mesh1, 1.5)
				
				wait(1.5)
				
				script.Parent.Parent.Parent.Character["Right Leg"].BrickColor = color
				script.Parent.Parent.Parent.Character["Right Leg"].Transparency = 0
			end
		end
	end)