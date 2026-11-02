player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")


mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Really black")
		x.Size = Vector3.new(1, 20, 20)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Material = "Marble"
		x.Shape = "Block"
		x.Name = "Ice"
		x.CanCollide = false
		x.Anchored = true
		spin = script.Spin:Clone()
		spin.Parent = x
		x.Transparency = 0
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Cylinder"
		z.Scale  = Vector3.new(0, 0, 0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 5, -10)* CFrame.Angles(0, 4.75, 0)
		
		x2 = Instance.new("Part")
		x2.BrickColor = BrickColor.new("Really black")
		x2.Size = Vector3.new(4, 4, 4)
		x2.TopSurface = "Smooth"
		x2.BottomSurface = "Smooth"
		x2.Material = "Marble"
		x2.Shape = "Block"
		x2.Name = "Ice"
		x2.CanCollide = false
		x2.Anchored = true
		x2.Transparency = 1
		o2 = Instance.new("StringValue",x2)
		o2.Value = script.Parent.Parent.Name
		o2.Name = "Owner"
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "Brick"
		z2.Scale  = Vector3.new(0, 0, 0)
		y2 = Instance.new("BodyVelocity")
		y2.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y2.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector*0
		x2.Parent = game.Workspace
		y2.Parent = x2
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 5, -15)

  		game.Debris:AddItem(x, 6)
		for i = 1,10 do
			z.Scale = z.Scale + Vector3.new(0.1, 0.1, 0.1)
			wait(0.05)
		end
		
		for i = 1, 75 do
			ran = math.random(1, 2)
			if ran == 1 then
				ran = BrickColor.new("Dark stone grey")
			end

			if ran == 2 then
				ran = BrickColor.new("Brown")
			end
			x3 = Instance.new("Part")
			x3.BrickColor = ran
			x3.Transparency = 0
			x3.Size = Vector3.new(math.random(2, 5), math.random(2, 5), math.random(2, 5))
			x3.TopSurface = "Smooth"
			x3.BottomSurface = "Smooth"
			x3.CanCollide = false
			x3.Anchored = false
		
			fd2 = script.Firedamage:Clone()
			fd2.Parent = x3
		
			o3 = Instance.new("StringValue",x3)
			o3.Value = script.Parent.Parent.Character.Name
			o3.Name = "Owner"
		
			p3 = script.PointLight:Clone()
			p3.Parent = x3
		
			z3 = Instance.new("SpecialMesh",x3)
			z3.MeshType = "Brick"
			z3.Scale  = Vector3.new(1, 1, 1)
		
			y3 = Instance.new("BodyVelocity")
			y3.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			y3.velocity = x2.CFrame.lookVector * math.random(80, 140)
			x3.Parent = game.Workspace
			y3.Parent = x3
			x3.CFrame = x.CFrame * CFrame.new(math.random(-4, -2), math.random(-6, 6), math.random(-6, 6))
		
			fd2.Disabled = false
  			game.Debris:AddItem(x2, 0.5)
  			game.Debris:AddItem(x3, 1)
			wait()	
		end
		
	end
		
		wait(14)
		script.Disabled = false
end)

