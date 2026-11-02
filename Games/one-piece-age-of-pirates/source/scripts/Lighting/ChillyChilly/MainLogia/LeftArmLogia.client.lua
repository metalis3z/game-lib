color = script.Parent.Parent.Parent.Character["Left Arm"].BrickColor

	game.Players.LocalPlayer.Character["Left Arm"].Touched:connect(function(person)
		if person.Name == "Handle" then
			
			local player2 = game.Players:FindFirstChild(person.Parent.Parent.Name)
			if player2.Data.Busoshoku.Value == true then
				return
			end
			if player2.Data.Busoshoku.Value ~= true then
				health = script.Parent.Parent.Parent.Character.Humanoid.Health
				script.Parent.Parent.Parent.Character.Humanoid.Health = health
				
				script.Parent.Parent.Parent.Character["Left Arm"].BrickColor = BrickColor.new("Pastel Blue")
				script.Parent.Parent.Parent.Character["Left Arm"].Material = "Ice"
				
				script.Parent.Parent.Parent.Character["Left Arm"].TopSurface = "Smooth"
				script.Parent.Parent.Parent.Character["Left Arm"].BottomSurface = "Smooth"
				
				mesh1 = Instance.new("BlockMesh")
				mesh1.Parent = game.Players.LocalPlayer.Character["Left Arm"]
				mesh1.Scale = Vector3.new(1, 1, 1)
				game.Debris:AddItem(mesh1, 1.5)
				
				wait(1.5)
				
				script.Parent.Parent.Parent.Character["Left Arm"].BrickColor = color
				script.Parent.Parent.Parent.Character["Left Arm"].Material = "SmoothPlastic"
			end
		end
	end)