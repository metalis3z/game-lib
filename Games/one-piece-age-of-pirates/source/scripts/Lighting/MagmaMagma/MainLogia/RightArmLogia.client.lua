color = script.Parent.Parent.Parent.Character["Right Arm"].BrickColor

	game.Players.LocalPlayer.Character["Right Arm"].Touched:connect(function(person)
		if person.Name == "Handle" then
			
			local player2 = game.Players:FindFirstChild(person.Parent.Parent.Name)
			if player2.Data.Busoshoku.Value == true then
				return
			end
			if player2.Data.Busoshoku.Value ~= true then
				health = script.Parent.Parent.Parent.Character.Humanoid.Health
				script.Parent.Parent.Parent.Character.Humanoid.Health = health
				
				light = script.PointLight:Clone()
				light.Parent = script.Parent.Parent.Parent.Character["Right Arm"]
				game.Debris:AddItem(light, 1.5)
				
				script.Parent.Parent.Parent.Character["Right Arm"].BrickColor = BrickColor.new("Really red")
				script.Parent.Parent.Parent.Character["Right Arm"].Material = "Granite"
				
				script.Parent.Parent.Parent.Character["Right Arm"].TopSurface = "Smooth"
				script.Parent.Parent.Parent.Character["Right Arm"].BottomSurface = "Smooth"
				
				mesh1 = Instance.new("BlockMesh")
				mesh1.Parent = game.Players.LocalPlayer.Character["Right Arm"]
				mesh1.Scale = Vector3.new(1, 1, 1)
				game.Debris:AddItem(mesh1, 1.5)
				
				wait(1.5)
				
				script.Parent.Parent.Parent.Character["Right Arm"].BrickColor = color
				script.Parent.Parent.Parent.Character["Right Arm"].Material = "SmoothPlastic"
			end
		end
	end)