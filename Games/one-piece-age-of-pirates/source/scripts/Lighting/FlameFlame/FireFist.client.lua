player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "z") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Bright orange")
		x.Size = Vector3.new(15, 15, 15)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.Shape = "Block"
		x.Name = "Earth"
		x.CanCollide = false
		x.Anchored = false
		p = script.PointLight:Clone()
		p.Parent = x
		spin = script.Spin:Clone()
		spin.Parent = x
		x.Transparency = 0.7
		fd = script.Firedamage:clone()
		fd.Parent = x
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Name
		o.Name = "Owner"
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(0,0,0)
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 100
		x.Parent = game.Workspace
		y.Parent = x
		cf = script.Parent.Parent.Character.Torso.CFrame*CFrame.new(0, 0, 0)
		x.CFrame = cf
		fd.Disabled = false
  		game.Debris:AddItem(x, 12)
		for i = 1,5 do
			z.Scale = z.Scale + Vector3.new(0.2, 0.2, 0.2)
			x.Transparency = x.Transparency - .02
			wait(.005)
		end
		for dy = 1,30 do
			wait(.02)
			g = Instance.new("Part",game.Workspace)
			g.BrickColor = BrickColor.new("Bright orange")
			g.Size = Vector3.new(15, 15, 15)
			g.TopSurface = "Smooth"
			g.BottomSurface = "Smooth"
			g.Shape = "Block"
			g.CFrame = x.CFrame * CFrame.new(0, 0, -2)
			g.Name = "Earth"
			g.CanCollide = false
			g.Anchored = true
			g.Transparency = 0.7
			fire = script.Fire:Clone()
			fire.Parent = g
			spin2 = script.Spin:Clone()
			spin2.Parent = g
			fd2 =  script.Firedamage2:Clone()
			fd2.Parent = g
			fd2.Disabled = false
			o2 = Instance.new("StringValue",g)
			o2.Value = script.Parent.Parent.Name
			o2.Name = "Owner"
			z2 = Instance.new("SpecialMesh",g)
			z2.MeshType = "Brick"
			z2.Scale  = Vector3.new(1,1,1)
			game.Debris:AddItem(g, 1)
			
			g2 = Instance.new("Part",game.Workspace)
			g2.BrickColor = BrickColor.new("Bright red")
			g2.Size = Vector3.new(15, 15, 15)
			g2.TopSurface = "Smooth"
			g2.BottomSurface = "Smooth"
			g2.Shape = "Block"
			g2.CFrame = x.CFrame * CFrame.new(0, 0, -2)
			g2.Name = "Earth"
			g2.CanCollide = false
			g2.Anchored = true
			g2.Transparency = 0.7
			spin3 = script.Spin2:Clone()
			spin3.Parent = g2
			fd3 = script.Firedamage2:clone()
			fd3.Parent = g2
			fd3.Disabled = false
			o3 = Instance.new("StringValue",g2)
			o3.Value = script.Parent.Parent.Name
			o3.Name = "Owner"
			z3 = Instance.new("SpecialMesh",g2)
			z3.MeshType = "Brick"
			z3.Scale = Vector3.new(0.95, 0.95, 0.95)
			game.Debris:AddItem(g2, 1)
		end
		
		x:remove()
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0)
			Run.Stepped:wait(0.01)
		end
		
		wait(15)
		script.Disabled = false
	end
end)