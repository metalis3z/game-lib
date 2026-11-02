player = script.Parent.Parent
mouse = player:GetMouse()
RightShoulder = script.Parent.Parent.Character.Torso["Right Shoulder"]
LeftShoulder = script.Parent.Parent.Character.Torso["Left Shoulder"]
Run = game:GetService("RunService")

mouse.KeyDown:connect(function(key)
	if (string.lower(key) == "x") then
		
		script.Disabled = true
		
		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			Run.Stepped:wait(0.01)
		end
			
		x = Instance.new("Part")
		x.BrickColor = BrickColor.new("Light orange")
		x.Transparency = 0.3
		x.Size = Vector3.new(8, 8, 8)
		x.TopSurface = "Smooth"
		x.BottomSurface = "Smooth"
		x.CanCollide = false
		x.Anchored = false
		
		x2 = Instance.new("Part")
		x2.BrickColor = BrickColor.new("Light orange")
		x2.Transparency = 0.3
		x2.Size = Vector3.new(8, 8, 8)
		x2.TopSurface = "Smooth"
		x2.BottomSurface = "Smooth"
		x2.CanCollide = false
		x2.Anchored = false

		fd2 = script.Firedamage:clone()
		fd2.Parent = x2
		fd2.Disabled = false
		
		fd = script.Firedamage:clone()
		fd.Parent = x
		fd.Disabled = false
		
		sp = script.Spin:Clone()
		sp.Parent = x
		
		sp2 = script.Spin:Clone()
		sp2.Parent = x2
		
		o = Instance.new("StringValue",x)
		o.Value = script.Parent.Parent.Character.Name
		o.Name = "Owner"
		
		o2 = Instance.new("StringValue",x2)
		o2.Value = script.Parent.Parent.Character.Name
		o2.Name = "Owner"
		
		p = script.PointLight:Clone()
		p.Parent = x
		
		p2 = script.PointLight:Clone()
		p2.Parent = x2
		
		z = Instance.new("SpecialMesh",x)
		z.MeshType = "Brick"
		z.Scale  = Vector3.new(0.05, 0.05, 0.05)
		
		z2 = Instance.new("SpecialMesh",x2)
		z2.MeshType = "Brick"
		z2.Scale  = Vector3.new(0.05, 0.05, 0.05)
		
		y = Instance.new("BodyVelocity")
		y.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 70
		x.Parent = game.Workspace
		y.Parent = x
		x.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(1.5, 0, -3)
		
		y2 = Instance.new("BodyVelocity")
		y2.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		y2.velocity = script.Parent.Parent.Character.Torso.CFrame.lookVector * 70
		x2.Parent = game.Workspace
		y2.Parent = x2
		x2.CFrame = script.Parent.Parent.Character.Torso.CFrame * CFrame.new(-1.5, 0, -3)
		
  		game.Debris:AddItem(x, 2)
		game.Debris:AddItem(x2, 2)

		wait(1)

		for i = 1, 10 do
			RightShoulder.C0 = RightShoulder.C0 *CFrame.Angles(0, 0, -0.15)
			LeftShoulder.C0 = LeftShoulder.C0 *CFrame.Angles(0, 0, 0.15)
			Run.Stepped:wait(0.01)
		end
		
		wait(14)
		script.Disabled = false
	end
end)