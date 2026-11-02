player = game.Players.LocalPlayer

while true do
	if player.Character.Humanoid.Health <= 20 then
		
		if player.Character:FindFirstChild("Shirt") then
			player.Character.Shirt:Destroy()
		end
		
		if player.Character:FindFirstChild("Pants") then
			player.Character.Pants:Destroy()
		end
		
		player.Character.Humanoid.MaxHealth = 150
		wait()
		player.Character.Humanoid.Health = 150
		player.Character.Humanoid.WalkSpeed = 22
		
		player.Character.Head.BrickColor = BrickColor.new("White")
		player.Character.Torso.BrickColor = BrickColor.new("White")
		player.Character["Right Arm"].BrickColor = BrickColor.new("White")
		player.Character["Left Arm"].BrickColor = BrickColor.new("White")
		player.Character["Right Leg"].BrickColor = BrickColor.new("White")
		player.Character["Left Leg"].BrickColor = BrickColor.new("White")
		
		player.Character.Head.face:Destroy()
		
		head = script.Mesh:Clone()
		player.Character.Head.Mesh:Destroy()
		head.Parent = player.Character.Head
		
		leftarm = script["Skeleton Left Arm"]:Clone()
		leftarm.Parent = player.Character
		
		rightarm = script["Skeleton Right Arm"]:Clone()
		rightarm.Parent = player.Character
		
		leftleg = script["Skeleton Left Leg"]:Clone()
		leftleg.Parent = player.Character
		
		rightleg = script["Skeleton Right Leg"]:Clone()
		rightleg.Parent = player.Character
		
		torso = script["Skeleton Torso"]:Clone()
		torso.Parent = player.Character
		
		b = Instance.new("BodyForce")
		b.Name = "LowGrav"
		b.force = Vector3.new(0,2000,0)
		b.Parent = player.Character.Torso
		
		script:Destroy()
	end
	wait()
end